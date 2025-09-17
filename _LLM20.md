I'll implement Kubernetes support for the OCI system and update the remaining components with copyright notices in all file headers. Let's start by creating a comprehensive Kubernetes manager module and improving the OCI implementation.

## 1. First, let's create an enhanced OCIContainerManager with Kubernetes support:

```javascript
// Path: /private/plugin/modules/OCIContainerManager.js
// Written by Greg Deeds, Autonomy Association International, Inc.
// Copyright 2025 Autonomy Association International Inc., all rights reserved 
// Safeguard patent license from National Aeronautics and Space Administration (NASA)
// Copyright 2025 NASA, all rights reserved

/**
 * OCI Container Manager
 * Comprehensive manager for OCI-compliant containers (Docker, Podman) and Kubernetes
 */

const { execSync, spawn } = require('child_process');
const fs = require('fs').promises;
const path = require('path');
const yaml = require('js-yaml');
const util = require('util');
const execAsync = util.promisify(require('child_process').exec);
const { Meteor } = require('meteor/meteor');
const crypto = require('crypto');

class OCIContainerManager {
  /**
   * Create a new OCIContainerManager instance
   * @param {Object} options - Configuration options
   * @param {string} options.containerEngine - Container engine to use ('docker', 'podman')
   * @param {string} options.composeVersion - Docker Compose version to use ('v1', 'v2')
   * @param {boolean} options.enablePrivileged - Whether to allow privileged containers
   * @param {string} options.networkName - Default container network
   * @param {Object} options.defaultResources - Default resource limits
   * @param {boolean} options.kubernetesEnabled - Whether Kubernetes integration is enabled
   * @param {string} options.kubeconfig - Path to kubeconfig file
   * @param {string} options.namespace - Default Kubernetes namespace
   */
  constructor(options = {}) {
    this.options = {
      containerEngine: options.containerEngine || process.env.CONTAINER_ENGINE || 'docker',
      composeVersion: options.composeVersion || process.env.COMPOSE_VERSION || 'v2',
      enablePrivileged: options.enablePrivileged === true || process.env.ENABLE_PRIVILEGED === 'true',
      networkName: options.networkName || process.env.CONTAINER_NETWORK || 'plugin-network',
      defaultResources: options.defaultResources || {
        cpuLimit: '1',
        memoryLimit: '512m',
        diskLimit: '1g'
      },
      kubernetesEnabled: options.kubernetesEnabled === true || process.env.KUBERNETES_ENABLED === 'true',
      kubeconfig: options.kubeconfig || process.env.KUBECONFIG,
      namespace: options.namespace || process.env.KUBERNETES_NAMESPACE || 'default',
      ...options
    };
    
    this.initialized = false;
    this.k8sInitialized = false;
    this.log = {
      info: (msg) => console.log(`[OCIManager:INFO] ${msg}`),
      warn: (msg) => console.warn(`[OCIManager:WARN] ${msg}`),
      error: (msg) => console.error(`[OCIManager:ERROR] ${msg}`),
      debug: (msg) => console.debug(`[OCIManager:DEBUG] ${msg}`)
    };
  }

  /**
   * Initialize the OCI manager
   * @returns {Promise<void>}
   */
  async initialize() {
    if (this.initialized) return;
    
    try {
      // Check if container engine is installed
      const engineVersion = await this.getEngineVersion();
      this.log.info(`Using container engine: ${this.options.containerEngine} ${engineVersion}`);
      
      // Create default network if it doesn't exist
      await this.createNetwork(this.options.networkName);
      
      // Initialize Kubernetes if enabled
      if (this.options.kubernetesEnabled) {
        await this.initializeKubernetes();
      }
      
      this.initialized = true;
      this.log.info(`OCI Container Manager initialized successfully`);
    } catch (error) {
      this.log.error(`Failed to initialize OCI Manager: ${error.message}`);
      throw error;
    }
  }

  /**
   * Initialize Kubernetes integration
   * @returns {Promise<void>}
   * @private
   */
  async initializeKubernetes() {
    try {
      this.log.info('Initializing Kubernetes integration...');
      
      // Check if kubectl is installed
      const kubectlVersion = await this._executeKubectl(['version', '--client', '--short']);
      this.log.info(`Using kubectl: ${kubectlVersion.stdout.trim()}`);
      
      // Check connection to cluster
      try {
        const clusterInfo = await this._executeKubectl(['cluster-info']);
        this.log.info('Connected to Kubernetes cluster');
      } catch (error) {
        this.log.warn(`Not connected to Kubernetes cluster: ${error.message}`);
        this.log.warn('Kubernetes commands will fail until connected to a cluster');
      }
      
      // Verify namespace exists or create it
      await this._ensureNamespaceExists(this.options.namespace);
      
      this.k8sInitialized = true;
      this.log.info(`Kubernetes integration initialized with namespace: ${this.options.namespace}`);
    } catch (error) {
      this.log.error(`Failed to initialize Kubernetes: ${error.message}`);
      throw error;
    }
  }

  /**
   * Ensure Kubernetes namespace exists
   * @param {string} namespace - Namespace name
   * @returns {Promise<void>}
   * @private
   */
  async _ensureNamespaceExists(namespace) {
    if (namespace === 'default') {
      return; // Default namespace always exists
    }
    
    try {
      // Check if namespace exists
      await this._executeKubectl(['get', 'namespace', namespace]);
      this.log.info(`Kubernetes namespace ${namespace} already exists`);
    } catch (error) {
      // Create namespace if it doesn't exist
      this.log.info(`Creating Kubernetes namespace ${namespace}`);
      
      const namespaceManifest = {
        apiVersion: 'v1',
        kind: 'Namespace',
        metadata: {
          name: namespace,
          labels: {
            name: namespace,
            'managed-by': 'safeguard-oci-manager'
          }
        }
      };
      
      // Write temporary YAML file
      const tmpFile = path.join('/tmp', `namespace-${namespace}-${Date.now()}.yaml`);
      await fs.writeFile(tmpFile, yaml.dump(namespaceManifest));
      
      try {
        await this._executeKubectl(['apply', '-f', tmpFile]);
        this.log.info(`Created Kubernetes namespace ${namespace}`);
      } finally {
        // Clean up temporary file
        try {
          await fs.unlink(tmpFile);
        } catch (e) {
          this.log.warn(`Failed to clean up temporary file ${tmpFile}: ${e.message}`);
        }
      }
    }
  }

  /**
   * Execute kubectl command
   * @param {Array<string>} args - Command arguments
   * @param {Object} options - Command options
   * @returns {Promise<Object>} Command result
   * @private
   */
  async _executeKubectl(args, options = {}) {
    if (!this.options.kubernetesEnabled) {
      throw new Error('Kubernetes integration is not enabled');
    }
    
    // Add namespace if specified and not already in args
    if (this.options.namespace && !args.includes('-n') && !args.includes('--namespace')) {
      // But only for commands that operate on resources
      const namespaceCommands = ['get', 'describe', 'create', 'apply', 'delete', 'scale', 'rollout', 'logs', 'exec'];
      if (namespaceCommands.includes(args[0])) {
        args = ['--namespace', this.options.namespace, ...args];
      }
    }
    
    // Add kubeconfig if specified
    const env = { ...process.env };
    if (this.options.kubeconfig) {
      env.KUBECONFIG = this.options.kubeconfig;
    }
    
    // Execute command
    return await execAsync(`kubectl ${args.join(' ')}`, { env, ...options });
  }

  /**
   * Get container engine version
   * @returns {Promise<string>} - Version string
   */
  async getEngineVersion() {
    try {
      const { stdout } = await execAsync(`${this.options.containerEngine} --version`);
      return stdout.trim();
    } catch (error) {
      this.log.error(`Error getting ${this.options.containerEngine} version: ${error.message}`);
      throw new Error(`${this.options.containerEngine} not found or not accessible`);
    }
  }

  /**
   * Create a container network
   * @param {string} networkName - Network name
   * @returns {Promise<void>}
   */
  async createNetwork(networkName) {
    try {
      // Check if network already exists
      const { stdout } = await execAsync(`${this.options.containerEngine} network ls --format "{{.Name}}"`);
      if (stdout.includes(networkName)) {
        this.log.info(`Network ${networkName} already exists`);
        return;
      }
      
      // Create network
      await execAsync(`${this.options.containerEngine} network create ${networkName}`);
      this.log.info(`Created container network: ${networkName}`);
    } catch (error) {
      this.log.error(`Error creating network ${networkName}: ${error.message}`);
      throw error;
    }
  }

  /**
   * Pull an image
   * @param {string} image - Image name
   * @returns {Promise<void>}
   */
  async pullImage(image) {
    try {
      this.log.info(`Pulling image: ${image}`);
      
      // Pull with progress output
      const pull = spawn(this.options.containerEngine, ['pull', image], { 
        stdio: ['ignore', 'pipe', 'pipe'] 
      });
      
      pull.stdout.on('data', (data) => {
        this.log.debug(`Pull progress: ${data.toString().trim()}`);
      });
      
      pull.stderr.on('data', (data) => {
        this.log.warn(`Pull output: ${data.toString().trim()}`);
      });
      
      return new Promise((resolve, reject) => {
        pull.on('close', (code) => {
          if (code === 0) {
            this.log.info(`Successfully pulled image: ${image}`);
            resolve();
          } else {
            reject(new Error(`Failed to pull image: ${image}, exit code: ${code}`));
          }
        });
      });
    } catch (error) {
      this.log.error(`Error pulling image ${image}: ${error.message}`);
      throw error;
    }
  }

  /**
   * Run a container
   * @param {Object} options - Container options
   * @param {string} options.image - Container image
   * @param {string} options.name - Container name
   * @param {Array<string>} options.command - Command to run
   * @param {Object} options.env - Environment variables
   * @param {Object} options.volumes - Volume mappings
   * @param {Object} options.ports - Port mappings
   * @param {Object} options.resources - Resource limits
   * @param {boolean} options.detach - Run in detached mode
   * @returns {Promise<Object>} - Container information
   */
  async runContainer(options) {
    if (!this.initialized) await this.initialize();
    
    try {
      const {
        image,
        name = `plugin-${Date.now()}`,
        command = [],
        env = {},
        volumes = {},
        ports = {},
        resources = this.options.defaultResources,
        detach = true,
        labels = {}
      } = options;
      
      // Build command
      let cmd = [this.options.containerEngine, 'run'];
      
      // Add name
      cmd.push('--name', name);
      
      // Add network
      cmd.push('--network', this.options.networkName);
      
      // Add environment variables
      Object.entries(env).forEach(([key, value]) => {
        cmd.push('-e', `${key}=${value}`);
      });
      
      // Add volumes
      Object.entries(volumes).forEach(([host, container]) => {
        cmd.push('-v', `${host}:${container}`);
      });
      
      // Add ports
      Object.entries(ports).forEach(([host, container]) => {
        cmd.push('-p', `${host}:${container}`);
      });
      
      // Add labels
      Object.entries(labels).forEach(([key, value]) => {
        cmd.push('--label', `${key}=${value}`);
      });
      
      // Add resource limits
      if (resources.cpuLimit) {
        cmd.push('--cpus', resources.cpuLimit);
      }
      
      if (resources.memoryLimit) {
        cmd.push('--memory', resources.memoryLimit);
      }
      
      // Add detach flag
      if (detach) {
        cmd.push('-d');
      }
      
      // Add image
      cmd.push(image);
      
      // Add command
      cmd = cmd.concat(command);
      
      // Run container
      this.log.info(`Running container: ${cmd.join(' ')}`);
      
      if (detach) {
        const { stdout } = await execAsync(cmd.join(' '));
        const containerId = stdout.trim();
        
        // Get container info
        const containerInfo = await this.getContainerInfo(containerId);
        return containerInfo;
      } else {
        // Run in foreground and capture output
        const container = spawn(cmd[0], cmd.slice(1), { 
          stdio: ['ignore', 'pipe', 'pipe'] 
        });
        
        let output = '';
        container.stdout.on('data', (data) => {
          const text = data.toString();
          output += text;
          this.log.debug(`Container output: ${text.trim()}`);
        });
        
        container.stderr.on('data', (data) => {
          const text = data.toString();
          output += text;
          this.log.debug(`Container error: ${text.trim()}`);
        });
        
        return new Promise((resolve, reject) => {
          container.on('close', async (code) => {
            if (code === 0) {
              // Get container info
              try {
                const containerInfo = await this.getContainerInfo(name);
                resolve({
                  ...containerInfo,
                  output
                });
              } catch (error) {
                resolve({ output, exitCode: code });
              }
            } else {
              reject(new Error(`Container exited with code ${code}: ${output}`));
            }
          });
        });
      }
    } catch (error) {
      this.log.error(`Error running container: ${error.message}`);
      throw error;
    }
  }

  /**
   * Get container information
   * @param {string} containerIdOrName - Container ID or name
   * @returns {Promise<Object>} - Container information
   */
  async getContainerInfo(containerIdOrName) {
    try {
      const { stdout } = await execAsync(
        `${this.options.containerEngine} inspect ${containerIdOrName}`
      );
      
      const info = JSON.parse(stdout)[0];
      
      return {
        id: info.Id,
        name: info.Name.replace(/^\//, ''),
        image: info.Config.Image,
        status: info.State.Status,
        created: info.Created,
        ports: info.NetworkSettings.Ports,
        ip: info.NetworkSettings.Networks[this.options.networkName]?.IPAddress,
        labels: info.Config.Labels || {},
        engine: this.options.containerEngine
      };
    } catch (error) {
      this.log.error(`Error getting container info for ${containerIdOrName}: ${error.message}`);
      throw error;
    }
  }

  /**
   * Stop a container
   * @param {string} containerIdOrName - Container ID or name
   * @param {number} timeout - Timeout in seconds before force kill
   * @returns {Promise<void>}
   */
  async stopContainer(containerIdOrName, timeout = 10) {
    try {
      await execAsync(`${this.options.containerEngine} stop -t ${timeout} ${containerIdOrName}`);
      this.log.info(`Stopped container: ${containerIdOrName}`);
    } catch (error) {
      this.log.error(`Error stopping container ${containerIdOrName}: ${error.message}`);
      throw error;
    }
  }

  /**
   * Remove a container
   * @param {string} containerIdOrName - Container ID or name
   * @param {boolean} force - Force removal
   * @returns {Promise<void>}
   */
  async removeContainer(containerIdOrName, force = false) {
    try {
      const forceFlag = force ? '-f' : '';
      await execAsync(`${this.options.containerEngine} rm ${forceFlag} ${containerIdOrName}`);
      this.log.info(`Removed container: ${containerIdOrName}`);
    } catch (error) {
      this.log.error(`Error removing container ${containerIdOrName}: ${error.message}`);
      throw error;
    }
  }

  /**
   * Get container logs
   * @param {string} containerIdOrName - Container ID or name
   * @param {Object} options - Log options
   * @param {number} options.tail - Number of lines to show
   * @param {boolean} options.follow - Follow log output
   * @returns {Promise<string>} - Container logs
   */
  async getContainerLogs(containerIdOrName, options = {}) {
    const { tail = 100, follow = false } = options;
    
    try {
      if (follow) {
        // Stream logs
        const logs = spawn(this.options.containerEngine, [
          'logs',
          '--tail', tail.toString(),
          '--follow',
          containerIdOrName
        ]);
        
        let output = '';
        logs.stdout.on('data', (data) => {
          const text = data.toString();
          output += text;
          this.log.debug(`Container logs: ${text.trim()}`);
        });
        
        logs.stderr.on('data', (data) => {
          const text = data.toString();
          output += text;
          this.log.debug(`Container error logs: ${text.trim()}`);
        });
        
        return new Promise((resolve) => {
          setTimeout(() => {
            logs.kill();
            resolve(output);
          }, 5000); // Stream for 5 seconds
        });
      } else {
        // Get logs directly
        const { stdout } = await execAsync(
          `${this.options.containerEngine} logs --tail ${tail} ${containerIdOrName}`
        );
        return stdout;
      }
    } catch (error) {
      this.log.error(`Error getting logs for container ${containerIdOrName}: ${error.message}`);
      throw error;
    }
  }

  /**
   * Run a Docker Compose stack
   * @param {Object} options - Compose options
   * @param {string} options.composePath - Path to docker-compose.yml file
   * @param {string} options.projectName - Project name
   * @param {Object} options.env - Environment variables
   * @returns {Promise<Object>} - Compose stack information
   */
  async runComposeStack(options) {
    if (!this.initialized) await this.initialize();
    
    try {
      const {
        composePath,
        projectName = `plugin-stack-${Date.now()}`,
        env = {}
      } = options;
      
      // Check if compose file exists
      try {
        await fs.access(composePath, fs.constants.R_OK);
      } catch (error) {
        throw new Error(`Compose file not found or not readable: ${composePath}`);
      }
      
      // Build command based on compose version
      let composeCmd;
      if (this.options.composeVersion === 'v2') {
        composeCmd = `${this.options.containerEngine} compose`;
      } else {
        composeCmd = 'docker-compose';
      }
      
      // Set environment variables
      const envVars = { ...process.env };
      Object.entries(env).forEach(([key, value]) => {
        envVars[key] = value;
      });
      
      // Run compose stack
      this.log.info(`Running compose stack: ${projectName} from ${composePath}`);
      
      const { stdout } = await execAsync(
        `${composeCmd} -f ${composePath} -p ${projectName} up -d`,
        { env: envVars }
      );
      
      // Get information about the stack
      const stackInfo = await this.getComposeStackInfo(projectName, composePath);
      
      return {
        projectName,
        composePath,
        services: stackInfo.services,
        output: stdout,
        engine: this.options.containerEngine
      };
    } catch (error) {
      this.log.error(`Error running compose stack: ${error.message}`);
      throw error;
    }
  }

  /**
   * Get information about a Docker Compose stack
   * @param {string} projectName - Project name
   * @param {string} composePath - Path to docker-compose.yml file
   * @returns {Promise<Object>} - Compose stack information
   */
  async getComposeStackInfo(projectName, composePath) {
    try {
      // Build command based on compose version
      let composeCmd;
      if (this.options.composeVersion === 'v2') {
        composeCmd = `${this.options.containerEngine} compose`;
      } else {
        composeCmd = 'docker-compose';
      }
      
      // Get running containers for the stack
      const { stdout } = await execAsync(
        `${composeCmd} -f ${composePath} -p ${projectName} ps --format json`
      );
      
      // Parse JSON output
      let services;
      try {
        services = JSON.parse(stdout);
      } catch (error) {
        // Fallback for older compose versions that don't support JSON output
        const { stdout: psOutput } = await execAsync(
          `${composeCmd} -f ${composePath} -p ${projectName} ps`
        );
        
        // Parse table output
        services = this._parseComposePs(psOutput);
      }
      
      // Load compose file to get service definitions
      const composeContent = await fs.readFile(composePath, 'utf8');
      const composeConfig = yaml.load(composeContent);
      
      return {
        projectName,
        composePath,
        services,
        config: composeConfig,
        engine: this.options.containerEngine
      };
    } catch (error) {
      this.log.error(`Error getting compose stack info for ${projectName}: ${error.message}`);
      throw error;
    }
  }

  /**
   * Parse docker-compose ps table output
   * @param {string} output - Command output
   * @returns {Array<Object>} - Parsed services
   * @private
   */
  _parseComposePs(output) {
    const lines = output.trim().split('\n');
    if (lines.length < 2) {
      return [];
    }
    
    // Skip header line
    const services = [];
    for (let i = 1; i < lines.length; i++) {
      const line = lines[i].trim();
      if (!line) continue;
      
      // Parse columns (name, command, state, ports)
      const columns = line.split(/\s{2,}/);
      if (columns.length < 3) continue;
      
      services.push({
        name: columns[0],
        command: columns[1],
        state: columns[2],
        ports: columns.length > 3 ? columns[3] : ''
      });
    }
    
    return services;
  }

  /**
   * Stop a Docker Compose stack
   * @param {string} projectName - Project name
   * @param {string} composePath - Path to docker-compose.yml file
   * @returns {Promise<void>}
   */
  async stopComposeStack(projectName, composePath) {
    try {
      // Build command based on compose version
      let composeCmd;
      if (this.options.composeVersion === 'v2') {
        composeCmd = `${this.options.containerEngine} compose`;
      } else {
        composeCmd = 'docker-compose';
      }
      
      await execAsync(`${composeCmd} -f ${composePath} -p ${projectName} down`);
      this.log.info(`Stopped compose stack: ${projectName}`);
    } catch (error) {
      this.log.error(`Error stopping compose stack ${projectName}: ${error.message}`);
      throw error;
    }
  }

  /**
   * Deploy a Kubernetes manifest
   * @param {Object|string} manifest - Kubernetes manifest object or path to manifest file
   * @param {Object} options - Deployment options
   * @param {string} options.namespace - Kubernetes namespace
   * @param {boolean} options.dryRun - Perform a dry run
   * @returns {Promise<Object>} Deployment result
   */
  async deployKubernetesManifest(manifest, options = {}) {
    if (!this.initialized) await this.initialize();
    if (!this.k8sInitialized) await this.initializeKubernetes();
    
    try {
      const { 
        namespace = this.options.namespace,
        dryRun = false
      } = options;
      
      let manifestPath;
      
      // Handle different input types
      if (typeof manifest === 'string') {
        // Check if it's a file path
        try {
          await fs.access(manifest, fs.constants.R_OK);
          manifestPath = manifest;
        } catch (error) {
          // It's a string containing YAML
          const tmpFile = path.join('/tmp', `k8s-manifest-${Date.now()}.yaml`);
          await fs.writeFile(tmpFile, manifest);
          manifestPath = tmpFile;
        }
      } else if (typeof manifest === 'object') {
        // Convert object to YAML
        const tmpFile = path.join('/tmp', `k8s-manifest-${Date.now()}.yaml`);
        await fs.writeFile(tmpFile, yaml.dump(manifest));
        manifestPath = tmpFile;
      } else {
        throw new Error('Invalid manifest format. Expected string or object.');
      }
      
      // Prepare kubectl command
      const args = ['apply', '-f', manifestPath];
      
      if (namespace && namespace !== this.options.namespace) {
        args.push('-n', namespace);
      }
      
      if (dryRun) {
        args.push('--dry-run=client', '-o', 'yaml');
      }
      
      // Apply the manifest
      this.log.info(`Deploying Kubernetes manifest: kubectl ${args.join(' ')}`);
      const result = await this._executeKubectl(args);
      
      // Clean up temporary file if we created one
      if (manifestPath !== manifest && typeof manifest !== 'string') {
        try {
          await fs.unlink(manifestPath);
        } catch (e) {
          this.log.warn(`Failed to clean up temporary file: ${e.message}`);
        }
      }
      
      this.log.info(`Successfully deployed Kubernetes manifest`);
      
      return {
        success: true,
        output: result.stdout,
        manifestPath,
        namespace
      };
    } catch (error) {
      this.log.error(`Error deploying Kubernetes manifest: ${error.message}`);
      throw error;
    }
  }

  /**
   * Delete a Kubernetes resource
   * @param {string} kind - Resource kind
   * @param {string} name - Resource name
   * @param {Object} options - Delete options
   * @param {string} options.namespace - Kubernetes namespace
   * @param {boolean} options.force - Force deletion
   * @returns {Promise<Object>} Deletion result
   */
  async deleteKubernetesResource(kind, name, options = {}) {
    if (!this.initialized) await this.initialize();
    if (!this.k8sInitialized) await this.initializeKubernetes();
    
    try {
      const { 
        namespace = this.options.namespace,
        force = false
      } = options;
      
      // Prepare kubectl command
      const args = ['delete', kind, name];
      
      if (namespace && namespace !== this.options.namespace) {
        args.push('-n', namespace);
      }
      
      if (force) {
        args.push('--force', '--grace-period=0');
      }
      
      // Delete the resource
      this.log.info(`Deleting Kubernetes resource: kubectl ${args.join(' ')}`);
      const result = await this._executeKubectl(args);
      
      this.log.info(`Successfully deleted Kubernetes resource ${kind}/${name}`);
      
      return {
        success: true,
        output: result.stdout,
        kind,
        name,
        namespace
      };
    } catch (error) {
      this.log.error(`Error deleting Kubernetes resource: ${error.message}`);
      throw error;
    }
  }

  /**
   * Get Kubernetes resource
   * @param {string} kind - Resource kind
   * @param {string} name - Resource name
   * @param {Object} options - Get options
   * @param {string} options.namespace - Kubernetes namespace
   * @param {string} options.outputFormat - Output format (json, yaml)
   * @returns {Promise<Object>} Resource data
   */
  async getKubernetesResource(kind, name, options = {}) {
    if (!this.initialized) await this.initialize();
    if (!this.k8sInitialized) await this.initializeKubernetes();
    
    try {
      const { 
        namespace = this.options.namespace,
        outputFormat = 'json'
      } = options;
      
      // Prepare kubectl command
      const args = ['get', kind, name, '-o', outputFormat];
      
      if (namespace && namespace !== this.options.namespace) {
        args.push('-n', namespace);
      }
      
      // Get the resource
      this.log.info(`Getting Kubernetes resource: kubectl ${args.join(' ')}`);
      const result = await this._executeKubectl(args);
      
      // Parse output based on format
      let resourceData;
      if (outputFormat === 'json') {
        resourceData = JSON.parse(result.stdout);
      } else if (outputFormat === 'yaml') {
        resourceData = yaml.load(result.stdout);
      } else {
        resourceData = result.stdout;
      }
      
      return {
        success: true,
        resource: resourceData,
        kind,
        name,
        namespace
      };
    } catch (error) {
      this.log.error(`Error getting Kubernetes resource: ${error.message}`);
      throw error;
    }
  }

  /**
   * List Kubernetes resources
   * @param {string} kind - Resource kind
   * @param {Object} options - List options
   * @param {string} options.namespace - Kubernetes namespace
   * @param {string} options.labelSelector - Label selector
   * @param {string} options.fieldSelector - Field selector
   * @returns {Promise<Object>} Resource list
   */
  async listKubernetesResources(kind, options = {}) {
    if (!this.initialized) await this.initialize();
    if (!this.k8sInitialized) await this.initializeKubernetes();
    
    try {
      const { 
        namespace = this.options.namespace,
        labelSelector,
        fieldSelector,
        outputFormat = 'json'
      } = options;
      
      // Prepare kubectl command
      const args = ['get', kind, '-o', outputFormat];
      
      if (namespace && namespace !== this.options.namespace) {
        args.push('-n', namespace);
      }
      
      if (labelSelector) {
        args.push('-l', labelSelector);
      }
      
      if (fieldSelector) {
        args.push('--field-selector', fieldSelector);
      }
      
      // List resources
      this.log.info(`Listing Kubernetes resources: kubectl ${args.join(' ')}`);
      const result = await this._executeKubectl(args);
      
      // Parse output based on format
      let resourceList;
      if (outputFormat === 'json') {
        resourceList = JSON.parse(result.stdout);
      } else if (outputFormat === 'yaml') {
        resourceList = yaml.load(result.stdout);
      } else {
        resourceList = result.stdout;
      }
      
      return {
        success: true,
        resources: resourceList,
        kind,
        namespace
      };
    } catch (error) {
      this.log.error(`Error listing Kubernetes resources: ${error.message}`);
      throw error;
    }
  }

  /**
   * Get logs from a Kubernetes pod
   * @param {string} podName - Pod name
   * @param {Object} options - Log options
   * @param {string} options.namespace - Kubernetes namespace
   * @param {string} options.container - Container name
   * @param {number} options.tail - Number of lines to show
   * @param {boolean} options.follow - Follow log output
   * @returns {Promise<string>} - Pod logs
   */
  async getKubernetesPodLogs(podName, options = {}) {
    if (!this.initialized) await this.initialize();
    if (!this.k8sInitialized) await this.initializeKubernetes();
    
    try {
      const { 
        namespace = this.options.namespace,
        container,
        tail = 100,
        follow = false
      } = options;
      
      // Prepare kubectl command
      const args = ['logs', podName];
      
      if (namespace && namespace !== this.options.namespace) {
        args.push('-n', namespace);
      }
      
      if (container) {
        args.push('-c', container);
      }
      
      args.push('--tail', tail.toString());
      
      if (follow) {
        // For follow, we'll use spawn to stream the logs
        const kubectl = spawn('kubectl', args, {
          env: this.options.kubeconfig ? { ...process.env, KUBECONFIG: this.options.kubeconfig } : process.env
        });
        
        let output = '';
        kubectl.stdout.on('data', (data) => {
          const text = data.toString();
          output += text;
          this.log.debug(`Pod logs: ${text.trim()}`);
        });
        
        kubectl.stderr.on('data', (data) => {
          const text = data.toString();
          output += text;
          this.log.debug(`Pod error logs: ${text.trim()}`);
        });
        
        return new Promise((resolve) => {
          setTimeout(() => {
            kubectl.kill();
            resolve(output);
          }, 5000); // Stream for 5 seconds
        });
      } else {
        // For non-follow, just execute the command directly
        const result = await this._executeKubectl(args);
        return result.stdout;
      }
    } catch (error) {
      this.log.error(`Error getting pod logs: ${error.message}`);
      throw error;
    }
  }

  /**
   * Execute command in a Kubernetes pod
   * @param {string} podName - Pod name
   * @param {Array<string>} command - Command to execute
   * @param {Object} options - Execution options
   * @param {string} options.namespace - Kubernetes namespace
   * @param {string} options.container - Container name
   * @returns {Promise<string>} - Command output
   */
  async execInKubernetesPod(podName, command, options = {}) {
    if (!this.initialized) await this.initialize();
    if (!this.k8sInitialized) await this.initializeKubernetes();
    
    try {
      const { 
        namespace = this.options.namespace,
        container
      } = options;
      
      // Prepare kubectl command
      const args = ['exec', podName];
      
      if (namespace && namespace !== this.options.namespace) {
        args.push('-n', namespace);
      }
      
      if (container) {
        args.push('-c', container);
      }
      
      args.push('--', ...command);
      
      // Execute the command
      this.log.info(`Executing command in pod: kubectl ${args.join(' ')}`);
      const result = await this._executeKubectl(args);
      
      return result.stdout;
    } catch (error) {
      this.log.error(`Error executing command in pod: ${error.message}`);
      throw error;
    }
  }

  /**
   * Port forward to a Kubernetes pod
   * @param {string} podName - Pod name
   * @param {string|number} localPort - Local port
   * @param {string|number} podPort - Pod port
   * @param {Object} options - Port forward options
   * @param {string} options.namespace - Kubernetes namespace
   * @returns {Promise<Object>} - Port forward process and information
   */
  async portForwardToPod(podName, localPort, podPort, options = {}) {
    if (!this.initialized) await this.initialize();
    if (!this.k8sInitialized) await this.initializeKubernetes();
    
    try {
      const { 
        namespace = this.options.namespace
      } = options;
      
      // Prepare kubectl command
      const args = ['port-forward', podName, `${localPort}:${podPort}`];
      
      if (namespace && namespace !== this.options.namespace) {
        args.push('-n', namespace);
      }
      
      // Start port forwarding
      this.log.info(`Starting port forward: kubectl ${args.join(' ')}`);
      
      const kubectl = spawn('kubectl', args, {
        env: this.options.kubeconfig ? { ...process.env, KUBECONFIG: this.options.kubeconfig } : process.env
      });
      
      kubectl.stdout.on('data', (data) => {
        this.log.debug(`Port forward output: ${data.toString().trim()}`);
      });
      
      kubectl.stderr.on('data', (data) => {
        this.log.debug(`Port forward error: ${data.toString().trim()}`);
      });
      
      // Create a promise that resolves when port forwarding is established
      const established = new Promise((resolve, reject) => {
        const timeout = setTimeout(() => {
          reject(new Error('Port forward timed out'));
        }, 10000); // 10 second timeout
        
        kubectl.stdout.on('data', (data) => {
          if (data.toString().includes('Forwarding from')) {
            clearTimeout(timeout);
            resolve();
          }
        });
        
        kubectl.on('error', (error) => {
          clearTimeout(timeout);
          reject(error);
        });
        
        kubectl.on('close', (code) => {
          if (code !== 0) {
            clearTimeout(timeout);
            reject(new Error(`Port forward process exited with code ${code}`));
          }
        });
      });
      
      // Wait for port forwarding to be established
      await established;
      
      this.log.info(`Port forward established from localhost:${localPort} to ${podName}:${podPort}`);
      
      // Return process and information
      return {
        process: kubectl,
        localPort,
        podPort,
        podName,
        namespace,
        stop: () => {
          kubectl.kill();
          this.log.info(`Port forward stopped for ${podName}`);
        }
      };
    } catch (error) {
      this.log.error(`Error setting up port forward: ${error.message}`);
      throw error;
    }
  }

  /**
   * Create a Dockerfile from a template
   * @param {Object} options - Dockerfile options
   * @param {string} options.baseImage - Base image
   * @param {string} options.targetDir - Directory to write Dockerfile
   * @param {Array<string>} options.commands - Commands to add to Dockerfile
   * @param {Object} options.env - Environment variables
   * @param {Object} options.volumes - Volume mappings
   * @param {number} options.exposedPort - Port to expose
   * @returns {Promise<string>} - Path to created Dockerfile
   */
  async createDockerfile(options) {
    try {
      const {
        baseImage = 'node:16-alpine',
        targetDir,
        commands = [],
        env = {},
        volumes = {},
        exposedPort = 3000,
        entrypoint,
        cmd
      } = options;
      
      // Ensure target directory exists
      await fs.mkdir(targetDir, { recursive: true });
      
      // Build Dockerfile content
      let dockerfileContent = `FROM ${baseImage}\n\n`;
      
      // Add environment variables
      if (Object.keys(env).length > 0) {
        Object.entries(env).forEach(([key, value]) => {
          dockerfileContent += `ENV ${key}=${value}\n`;
        });
        dockerfileContent += '\n';
      }
      
      // Add commands
      commands.forEach(command => {
        dockerfileContent += `RUN ${command}\n`;
      });
      dockerfileContent += '\n';
      
      // Add volume definitions
      if (Object.keys(volumes).length > 0) {
        Object.values(volumes).forEach(containerPath => {
          dockerfileContent += `VOLUME ${containerPath}\n`;
        });
        dockerfileContent += '\n';
      }
      
      // Add exposed port
      if (exposedPort) {
        dockerfileContent += `EXPOSE ${exposedPort}\n\n`;
      }
      
      // Add entrypoint if specified
      if (entrypoint) {
        if (Array.isArray(entrypoint)) {
          dockerfileContent += `ENTRYPOINT [${entrypoint.map(item => `"${item}"`).join(', ')}]\n`;
        } else {
          dockerfileContent += `ENTRYPOINT ["${entrypoint}"]\n`;
        }
      }
      
      // Add CMD if specified
      if (cmd) {
        if (Array.isArray(cmd)) {
          dockerfileContent += `CMD [${cmd.map(item => `"${item}"`).join(', ')}]\n`;
        } else {
          dockerfileContent += `CMD ["${cmd}"]\n`;
        }
      } else if (!entrypoint) {
        // Add default command if neither entrypoint nor cmd specified
        dockerfileContent += 'CMD ["node", "index.js"]\n';
      }
      
      // Write Dockerfile
      const dockerfilePath = path.join(targetDir, 'Dockerfile');
      await fs.writeFile(dockerfilePath, dockerfileContent);
      
      this.log.info(`Created Dockerfile at ${dockerfilePath}`);
      return dockerfilePath;
    } catch (error) {
      this.log.error(`Error creating Dockerfile: ${error.message}`);
      throw error;
    }
  }

  /**
   * Build a Docker image
   * @param {Object} options - Build options
   * @param {string} options.dockerfile - Path to Dockerfile
   * @param {string} options.context - Build context directory
   * @param {string} options.imageName - Image name
   * @param {Object} options.buildArgs - Build arguments
   * @returns {Promise<string>} - Built image ID
   */
  async buildImage(options) {
    try {
      const {
        dockerfile,
        context = path.dirname(dockerfile),
        imageName = `plugin-image-${Date.now()}`,
        buildArgs = {}
      } = options;
      
      // Build command
      let cmd = [
        this.options.containerEngine, 'build',
        '-f', dockerfile,
        '-t', imageName
      ];
      
      // Add build args
      Object.entries(buildArgs).forEach(([key, value]) => {
        cmd.push('--build-arg', `${key}=${value}`);
      });
      
      // Add context
      cmd.push(context);
      
      // Build image
      this.log.info(`Building image: ${cmd.join(' ')}`);
      
      const build = spawn(cmd[0], cmd.slice(1), { 
        stdio: ['ignore', 'pipe', 'pipe'] 
      });
      
      let output = '';
      build.stdout.on('data', (data) => {
        const text = data.toString();
        output += text;
        this.log.debug(`Build output: ${text.trim()}`);
      });
      
      build.stderr.on('data', (data) => {
        const text = data.toString();
        output += text;
        this.log.debug(`Build error: ${text.trim()}`);
      });
      
      return new Promise((resolve, reject) => {
        build.on('close', (code) => {
          if (code === 0) {
            this.log.info(`Successfully built image: ${imageName}`);
            resolve(imageName);
          } else {
            reject(new Error(`Failed to build image: ${imageName}, exit code: ${code}`));
          }
        });
      });
    } catch (error) {
      this.log.error(`Error building image: ${error.message}`);
      throw error;
    }
  }

  /**
   * Create a Kubernetes manifest from template
   * @param {Object} options - Manifest options
   * @param {string} options.kind - Resource kind
   * @param {string} options.name - Resource name
   * @param {string} options.image - Container image
   * @param {string} options.namespace - Kubernetes namespace
   * @param {Object} options.labels - Resource labels
   * @param {Object} options.env - Environment variables
   * @param {Object} options.resources - Resource limits
   * @param {Array<Object>} options.ports - Container ports
   * @param {Array<Object>} options.volumes - Container volumes
   * @returns {Object} - Kubernetes manifest
   */
  createKubernetesManifest(options) {
    try {
      const {
        kind = 'Deployment',
        name,
        image,
        namespace = this.options.namespace,
        labels = {},
        env = {},
        resources = this.options.defaultResources,
        ports = [],
        volumes = [],
        replicas = 1,
        serviceAccount
      } = options;
      
      // Base labels to include in all resources
      const baseLabels = {
        'app': name,
        'managed-by': 'safeguard-oci-manager',
        ...labels
      };
      
      // Convert environment variables to Kubernetes format
      const envVars = Object.entries(env).map(([key, value]) => ({
        name: key,
        value: String(value)
      }));
      
      // Convert resources to Kubernetes format
      const resourceLimits = {};
      if (resources.cpuLimit) {
        resourceLimits.cpu = resources.cpuLimit;
      }
      if (resources.memoryLimit) {
        resourceLimits.memory = resources.memoryLimit;
      }
      
      let manifest;
      
      switch (kind) {
        case 'Deployment':
          manifest = {
            apiVersion: 'apps/v1',
            kind: 'Deployment',
            metadata: {
              name,
              namespace,
              labels: baseLabels
            },
            spec: {
              replicas,
              selector: {
                matchLabels: {
                  app: name
                }
              },
              template: {
                metadata: {
                  labels: {
                    app: name,
                    ...labels
                  }
                },
                spec: {
                  containers: [{
                    name: name,
                    image,
                    ports: ports.map(port => ({
                      containerPort: port.containerPort || port,
                      name: port.name || `port-${port.containerPort || port}`,
                      protocol: port.protocol || 'TCP'
                    })),
                    env: envVars,
                    resources: Object.keys(resourceLimits).length > 0 ? {
                      limits: resourceLimits
                    } : undefined
                  }]
                }
              }
            }
          };
          
          // Add service account if specified
          if (serviceAccount) {
            manifest.spec.template.spec.serviceAccountName = serviceAccount;
          }
          
          // Add volumes if specified
          if (volumes.length > 0) {
            manifest.spec.template.spec.volumes = volumes.map(vol => vol.volume);
            manifest.spec.template.spec.containers[0].volumeMounts = volumes.map(vol => vol.mount);
          }
          break;
          
        case 'Service':
          manifest = {
            apiVersion: 'v1',
            kind: 'Service',
            metadata: {
              name,
              namespace,
              labels: baseLabels
            },
            spec: {
              selector: {
                app: name
              },
              ports: ports.map(port => ({
                port: port.port || port,
                targetPort: port.targetPort || port.port || port,
                name: port.name || `port-${port.port || port}`,
                protocol: port.protocol || 'TCP'
              })),
              type: options.serviceType || 'ClusterIP'
            }
          };
          break;
          
        case 'ConfigMap':
          manifest = {
            apiVersion: 'v1',
            kind: 'ConfigMap',
            metadata: {
              name,
              namespace,
              labels: baseLabels
            },
            data: options.data || {}
          };
          break;
          
        case 'Secret':
          // For secrets, we need to base64 encode the values
          const secretData = {};
          if (options.data) {
            Object.entries(options.data).forEach(([key, value]) => {
              secretData[key] = Buffer.from(String(value)).toString('base64');
            });
          }
          
          manifest = {
            apiVersion: 'v1',
            kind: 'Secret',
            metadata: {
              name,
              namespace,
              labels: baseLabels
            },
            type: 'Opaque',
            data: secretData
          };
          break;
          
        case 'Job':
          manifest = {
            apiVersion: 'batch/v1',
            kind: 'Job',
            metadata: {
              name,
              namespace,
              labels: baseLabels
            },
            spec: {
              template: {
                metadata: {
                  labels: {
                    app: name,
                    ...labels
                  }
                },
                spec: {
                  containers: [{
                    name: name,
                    image,
                    env: envVars,
                    resources: Object.keys(resourceLimits).length > 0 ? {
                      limits: resourceLimits
                    } : undefined
                  }],
                  restartPolicy: 'Never'
                }
              },
              backoffLimit: options.backoffLimit || 3
            }
          };
          
          // Add service account if specified
          if (serviceAccount) {
            manifest.spec.template.spec.serviceAccountName = serviceAccount;
          }
          
          // Add volumes if specified
          if (volumes.length > 0) {
            manifest.spec.template.spec.volumes = volumes.map(vol => vol.volume);
            manifest.spec.template.spec.containers[0].volumeMounts = volumes.map(vol => vol.mount);
          }
          break;
          
        case 'Pod':
          manifest = {
            apiVersion: 'v1',
            kind: 'Pod',
            metadata: {
              name,
              namespace,
              labels: baseLabels
            },
            spec: {
              containers: [{
                name: name,
                image,
                ports: ports.map(port => ({
                  containerPort: port.containerPort || port,
                  name: port.name || `port-${port.containerPort || port}`,
                  protocol: port.protocol || 'TCP'
                })),
                env: envVars,
                resources: Object.keys(resourceLimits).length > 0 ? {
                  limits: resourceLimits
                } : undefined
              }]
            }
          };
          
          // Add service account if specified
          if (serviceAccount) {
            manifest.spec.serviceAccountName = serviceAccount;
          }
          
          // Add volumes if specified
          if (volumes.length > 0) {
            manifest.spec.volumes = volumes.map(vol => vol.volume);
            manifest.spec.containers[0].volumeMounts = volumes.map(vol => vol.mount);
          }
          break;
          
        default:
          throw new Error(`Unsupported Kubernetes resource kind: ${kind}`);
      }
      
      return manifest;
    } catch (error) {
      this.log.error(`Error creating Kubernetes manifest: ${error.message}`);
      throw error;
    }
  }

  /**
   * Register Meteor methods
   */
  registerMeteorMethods() {
    Meteor.methods({
      'oci.getEngineVersion': async () => {
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        return await this.getEngineVersion();
      },
      
      'oci.runContainer': async (options) => {
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        return await this.runContainer(options);
      },
      
      'oci.stopContainer': async (containerIdOrName, timeout) => {
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        return await this.stopContainer(containerIdOrName, timeout);
      },
      
      'oci.getContainerLogs': async (containerIdOrName, options) => {
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        return await this.getContainerLogs(containerIdOrName, options);
      },
      
      'oci.runComposeStack': async (options) => {
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        return await this.runComposeStack(options);
      },
      
      'oci.stopComposeStack': async (projectName, composePath) => {
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        return await this.stopComposeStack(projectName, composePath);
      },
      
      'oci.buildImage': async (options) => {
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        return await this.buildImage(options);
      },
      
      'oci.deployKubernetesManifest': async (manifest, options) => {
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        if (!this.options.kubernetesEnabled) {
          throw new Meteor.Error('kubernetes-disabled', 'Kubernetes integration is not enabled');
        }
        
        return await this.deployKubernetesManifest(manifest, options);
      },
      
      'oci.getKubernetesResource': async (kind, name, options) => {
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        if (!this.options.kubernetesEnabled) {
          throw new Meteor.Error('kubernetes-disabled', 'Kubernetes integration is not enabled');
        }
        
        return await this.getKubernetesResource(kind, name, options);
      },
      
      'oci.listKubernetesResources': async (kind, options) => {
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        if (!this.options.kubernetesEnabled) {
          throw new Meteor.Error('kubernetes-disabled', 'Kubernetes integration is not enabled');
        }
        
        return await this.listKubernetesResources(kind, options);
      },
      
      'oci.deleteKubernetesResource': async (kind, name, options) => {
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        if (!this.options.kubernetesEnabled) {
          throw new Meteor.Error('kubernetes-disabled', 'Kubernetes integration is not enabled');
        }
        
        return await this.deleteKubernetesResource(kind, name, options);
      }
    });
  }
}

module.exports = OCIContainerManager;
```


## 2. Now, let's create a Kubernetes-specific Manager with enhanced functionality:

```javascript
// Path: /private/plugin/modules/KubernetesManager.js
// Written by Greg Deeds, Autonomy Association International, Inc.
// Copyright 2025 Autonomy Association International Inc., all rights reserved 
// Safeguard patent license from National Aeronautics and Space Administration (NASA)
// Copyright 2025 NASA, all rights reserved

/**
 * Kubernetes Manager
 * Advanced management for Kubernetes clusters and resources
 */

const { execSync, spawn } = require('child_process');
const fs = require('fs').promises;
const path = require('path');
const yaml = require('js-yaml');
const util = require('util');
const execAsync = util.promisify(require('child_process').exec);
const { Meteor } = require('meteor/meteor');
const crypto = require('crypto');
const { MongoClient } = require('mongodb');

class KubernetesManager {
  /**
   * Create a new KubernetesManager instance
   * @param {Object} options - Configuration options
   * @param {string} options.kubeconfig - Path to kubeconfig file
   * @param {string} options.namespace - Default Kubernetes namespace
   * @param {boolean} options.inCluster - Whether running inside a Kubernetes cluster
   * @param {string} options.context - Kubernetes context to use
   * @param {Object} options.mongo - MongoDB connection options
   * @param {string} options.mongo.url - MongoDB connection URL
   * @param {string} options.mongo.database - MongoDB database name
   * @param {string} options.mongo.collection - MongoDB collection name prefix
   */
  constructor(options = {}) {
    this.options = {
      kubeconfig: options.kubeconfig || process.env.KUBECONFIG,
      namespace: options.namespace || process.env.KUBERNETES_NAMESPACE || 'default',
      inCluster: options.inCluster === true || process.env.KUBERNETES_SERVICE_HOST !== undefined,
      context: options.context || process.env.KUBERNETES_CONTEXT,
      mongo: {
        url: options.mongo?.url || process.env.MONGO_URL,
        database: options.mongo?.database || process.env.MONGO_DB || 'safeguard',
        collection: options.mongo?.collection || 'kubernetes'
      },
      ...options
    };
    
    this.initialized = false;
    this.mongoConnected = false;
    this.collections = {};
    this.log = {
      info: (msg) => console.log(`[K8sManager:INFO] ${msg}`),
      warn: (msg) => console.warn(`[K8sManager:WARN] ${msg}`),
      error: (msg) => console.error(`[K8sManager:ERROR] ${msg}`),
      debug: (msg) => console.debug(`[K8sManager:DEBUG] ${msg}`)
    };
    
    // Active port forwards
    this.portForwards = new Map();
  }

  /**
   * Initialize the Kubernetes manager
   * @returns {Promise<void>}
   */
  async initialize() {
    if (this.initialized) return;
    
    try {
      // Check if kubectl is installed
      const kubectlVersion = await this._executeKubectl(['version', '--client', '--short']);
      this.log.info(`Using kubectl: ${kubectlVersion.stdout.trim()}`);
      
      // Check connection to cluster
      try {
        const clusterInfo = await this._executeKubectl(['cluster-info']);
        this.log.info('Connected to Kubernetes cluster');
        
        // Get current context and cluster info
        const currentContext = await this._executeKubectl(['config', 'current-context']);
        this.currentContext = currentContext.stdout.trim();
        this.log.info(`Current Kubernetes context: ${this.currentContext}`);
        
        // Get more detailed cluster info
        const clusterDetails = await this._executeKubectl(['cluster-info', 'dump', '--output=json', '--namespaces=kube-system']);
        this.clusterDetails = JSON.parse(clusterDetails.stdout);
        
        // Extract kubernetes version from server
        try {
          const versionInfo = await this._executeKubectl(['version', '-o', 'json']);
          const versionData = JSON.parse(versionInfo.stdout);
          this.serverVersion = versionData.serverVersion;
          this.log.info(`Kubernetes server version: ${this.serverVersion.gitVersion}`);
        } catch (error) {
          this.log.warn(`Failed to get server version: ${error.message}`);
        }
      } catch (error) {
        this.log.warn(`Not connected to Kubernetes cluster: ${error.message}`);
        this.log.warn('Kubernetes commands will fail until connected to a cluster');
      }
      
      // Verify namespace exists or create it
      await this._ensureNamespaceExists(this.options.namespace);
      
      // Initialize MongoDB if URL is provided
      if (this.options.mongo.url) {
        await this._initializeMongo();
      }
      
      this.initialized = true;
      this.log.info(`Kubernetes manager initialized with namespace: ${this.options.namespace}`);
    } catch (error) {
      this.log.error(`Failed to initialize Kubernetes manager: ${error.message}`);
      throw error;
    }
  }

  /**
   * Initialize MongoDB connection and collections
   * @private
   */
  async _initializeMongo() {
    try {
      this.log.info(`Connecting to MongoDB at ${this.options.mongo.url}`);
      
      this.mongoClient = new MongoClient(this.options.mongo.url);
      await this.mongoClient.connect();
      
      const db = this.mongoClient.db(this.options.mongo.database);
      
      // Initialize collections
      this.collections = {
        clusters: db.collection(`${this.options.mongo.collection}_clusters`),
        namespaces: db.collection(`${this.options.mongo.collection}_namespaces`),
        deployments: db.collection(`${this.options.mongo.collection}_deployments`),
        pods: db.collection(`${this.options.mongo.collection}_pods`),
        services: db.collection(`${this.options.mongo.collection}_services`),
        events: db.collection(`${this.options.mongo.collection}_events`),
        logs: db.collection(`${this.options.mongo.collection}_logs`)
      };
      
      // Create indexes
      await this.collections.clusters.createIndex({ name: 1 });
      await this.collections.namespaces.createIndex({ name: 1, cluster: 1 }, { unique: true });
      await this.collections.deployments.createIndex({ name: 1, namespace: 1, cluster: 1 }, { unique: true });
      await this.collections.pods.createIndex({ name: 1, namespace: 1, cluster: 1 }, { unique: true });
      await this.collections.services.createIndex({ name: 1, namespace: 1, cluster: 1 }, { unique: true });
      await this.collections.events.createIndex({ involvedObject: 1, namespace: 1, cluster: 1 });
      await this.collections.events.createIndex({ lastTimestamp: 1 });
      await this.collections.logs.createIndex({ podName: 1, namespace: 1, cluster: 1 });
      await this.collections.logs.createIndex({ timestamp: 1 });
      
      this.mongoConnected = true;
      this.log.info('MongoDB connection established and collections initialized');
    } catch (error) {
      this.log.error(`Failed to initialize MongoDB: ${error.message}`);
      throw error;
    }
  }

  /**
   * Execute kubectl command
   * @param {Array<string>} args - Command arguments
   * @param {Object} options - Command options
   * @returns {Promise<Object>} Command result
   * @private
   */
  async _executeKubectl(args, options = {}) {
    // Add namespace if specified and not already in args
    if (this.options.namespace && !args.includes('-n') && !args.includes('--namespace')) {
      // But only for commands that operate on resources
      const namespaceCommands = ['get', 'describe', 'create', 'apply', 'delete', 'scale', 'rollout', 'logs', 'exec'];
      if (namespaceCommands.includes(args[0])) {
        args = ['--namespace', this.options.namespace, ...args];
      }
    }
    
    // Add context if specified
    if (this.options.context && !args.includes('--context')) {
      args = ['--context', this.options.context, ...args];
    }
    
    // Add kubeconfig if specified
    const env = { ...process.env };
    if (this.options.kubeconfig) {
      env.KUBECONFIG = this.options.kubeconfig;
    }
    
    // Execute command
    return await execAsync(`kubectl ${args.join(' ')}`, { env, ...options });
  }

  /**
   * Ensure Kubernetes namespace exists
   * @param {string} namespace - Namespace name
   * @returns {Promise<void>}
   * @private
   */
  async _ensureNamespaceExists(namespace) {
    if (namespace === 'default') {
      return; // Default namespace always exists
    }
    
    try {
      // Check if namespace exists
      await this._executeKubectl(['get', 'namespace', namespace]);
      this.log.info(`Kubernetes namespace ${namespace} already exists`);
    } catch (error) {
      // Create namespace if it doesn't exist
      this.log.info(`Creating Kubernetes namespace ${namespace}`);
      
      const namespaceManifest = {
        apiVersion: 'v1',
        kind: 'Namespace',
        metadata: {
          name: namespace,
          labels: {
            name: namespace,
            'managed-by': 'safeguard-k8s-manager'
          }
        }
      };
      
      // Write temporary YAML file
      const tmpFile = path.join('/tmp', `namespace-${namespace}-${Date.now()}.yaml`);
      await fs.writeFile(tmpFile, yaml.dump(namespaceManifest));
      
      try {
        await this._executeKubectl(['apply', '-f', tmpFile]);
        this.log.info(`Created Kubernetes namespace ${namespace}`);
      } finally {
        // Clean up temporary file
        try {
          await fs.unlink(tmpFile);
        } catch (e) {
          this.log.warn(`Failed to clean up temporary file ${tmpFile}: ${e.message}`);
        }
      }
    }
  }

  /**
   * Deploy a Kubernetes manifest
   * @param {Object|string} manifest - Kubernetes manifest object or path to manifest file
   * @param {Object} options - Deployment options
   * @param {string} options.namespace - Kubernetes namespace
   * @param {boolean} options.dryRun - Perform a dry run
   * @param {boolean} options.storeInMongo - Store deployment info in MongoDB
   * @returns {Promise<Object>} Deployment result
   */
  async deployManifest(manifest, options = {}) {
    if (!this.initialized) await this.initialize();
    
    try {
      const { 
        namespace = this.options.namespace,
        dryRun = false,
        storeInMongo = this.mongoConnected
      } = options;
      
      let manifestPath;
      let manifestObj;
      
      // Handle different input types
      if (typeof manifest === 'string') {
        // Check if it's a file path
        try {
          await fs.access(manifest, fs.constants.R_OK);
          manifestPath = manifest;
          const content = await fs.readFile(manifest, 'utf8');
          manifestObj = yaml.load(content);
        } catch (error) {
          // It's a string containing YAML
          manifestObj = yaml.load(manifest);
          const tmpFile = path.join('/tmp', `k8s-manifest-${Date.now()}.yaml`);
          await fs.writeFile(tmpFile, manifest);
          manifestPath = tmpFile;
        }
      } else if (typeof manifest === 'object') {
        // Convert object to YAML
        manifestObj = manifest;
        const tmpFile = path.join('/tmp', `k8s-manifest-${Date.now()}.yaml`);
        await fs.writeFile(tmpFile, yaml.dump(manifest));
        manifestPath = tmpFile;
      } else {
        throw new Error('Invalid manifest format. Expected string or object.');
      }
      
      // Prepare kubectl command
      const args = ['apply', '-f', manifestPath];
      
      if (namespace !== this.options.namespace) {
        args.push('-n', namespace);
      }
      
      if (dryRun) {
        args.push('--dry-run=client', '-o', 'yaml');
      }
      
      // Apply the manifest
      this.log.info(`Deploying Kubernetes manifest: kubectl ${args.join(' ')}`);
      const result = await this._executeKubectl(args);
      
      // Store deployment info in MongoDB if required
      if (storeInMongo && this.mongoConnected && !dryRun) {
        await this._storeDeploymentInfo(manifestObj, namespace);
      }
      
      // Clean up temporary file if we created one
      if (manifestPath !== manifest && typeof manifest !== 'string') {
        try {
          await fs.unlink(manifestPath);
        } catch (e) {
          this.log.warn(`Failed to clean up temporary file: ${e.message}`);
        }
      }
      
      this.log.info(`Successfully deployed Kubernetes manifest`);
      
      return {
        success: true,
        output: result.stdout,
        manifestPath,
        namespace,
        manifest: manifestObj
      };
    } catch (error) {
      this.log.error(`Error deploying Kubernetes manifest: ${error.message}`);
      throw error;
    }
  }

  /**
   * Store deployment information in MongoDB
   * @param {Object} manifest - Kubernetes manifest
   * @param {string} namespace - Kubernetes namespace
   * @private
   */
  async _storeDeploymentInfo(manifest, namespace) {
    if (!this.mongoConnected) return;
    
    try {
      const { kind, metadata } = manifest;
      const name = metadata.name;
      
      switch (kind) {
        case 'Deployment':
          await this.collections.deployments.updateOne(
            { 
              name,
              namespace,
              cluster: this.currentContext
            },
            {
              $set: {
                manifest,
                lastUpdated: new Date()
              },
              $setOnInsert: {
                createdAt: new Date()
              }
            },
            { upsert: true }
          );
          break;
          
        case 'Service':
          await this.collections.services.updateOne(
            { 
              name,
              namespace,
              cluster: this.currentContext
            },
            {
              $set: {
                manifest,
                lastUpdated: new Date()
              },
              $setOnInsert: {
                createdAt: new Date()
              }
            },
            { upsert: true }
          );
          break;
          
        case 'Pod':
          await this.collections.pods.updateOne(
            { 
              name,
              namespace,
              cluster: this.currentContext
            },
            {
              $set: {
                manifest,
                lastUpdated: new Date()
              },
              $setOnInsert: {
                createdAt: new Date()
              }
            },
            { upsert: true }
          );
          break;
          
        case 'Namespace':
          await this.collections.namespaces.updateOne(
            { 
              name,
              cluster: this.currentContext
            },
            {
              $set: {
                manifest,
                lastUpdated: new Date()
              },
              $setOnInsert: {
                createdAt: new Date()
              }
            },
            { upsert: true }
          );
          break;
      }
    } catch (error) {
      this.log.error(`Error storing deployment info: ${error.message}`);
    }
  }

  /**
   * Delete a Kubernetes resource
   * @param {string} kind - Resource kind
   * @param {string} name - Resource name
   * @param {Object} options - Delete options
   * @param {string} options.namespace - Kubernetes namespace
   * @param {boolean} options.force - Force deletion
   * @returns {Promise<Object>} Deletion result
   */
  async deleteResource(kind, name, options = {}) {
    if (!this.initialized) await this.initialize();
    
    try {
      const { 
        namespace = this.options.namespace,
        force = false
      } = options;
      
      // Prepare kubectl command
      const args = ['delete', kind, name];
      
      if (namespace !== this.options.namespace) {
        args.push('-n', namespace);
      }
      
      if (force) {
        args.push('--force', '--grace-period=0');
      }
      
      // Delete the resource
      this.log.info(`Deleting Kubernetes resource: kubectl ${args.join(' ')}`);
      const result = await this._executeKubectl(args);
      
      // Remove from MongoDB if connected
      if (this.mongoConnected) {
        try {
          switch (kind.toLowerCase()) {
            case 'deployment':
              await this.collections.deployments.deleteOne({ 
                name, 
                namespace, 
                cluster: this.currentContext 
              });
              break;
              
            case 'service':
              await this.collections.services.deleteOne({ 
                name, 
                namespace, 
                cluster: this.currentContext 
              });
              break;
              
            case 'pod':
              await this.collections.pods.deleteOne({ 
                name, 
                namespace, 
                cluster: this.currentContext 
              });
              break;
              
            case 'namespace':
              await this.collections.namespaces.deleteOne({ 
                name, 
                cluster: this.currentContext 
              });
              break;
          }
        } catch (error) {
          this.log.warn(`Error removing resource from MongoDB: ${error.message}`);
        }
      }
      
      this.log.info(`Successfully deleted Kubernetes resource ${kind}/${name}`);
      
      return {
        success: true,
        output: result.stdout,
        kind,
        name,
        namespace
      };
    } catch (error) {
      this.log.error(`Error deleting Kubernetes resource: ${error.message}`);
      throw error;
    }
  }

  /**
   * Get Kubernetes resource
   * @param {string} kind - Resource kind
   * @param {string} name - Resource name
   * @param {Object} options - Get options
   * @param {string} options.namespace - Kubernetes namespace
   * @param {string} options.outputFormat - Output format (json, yaml)
   * @returns {Promise<Object>} Resource data
   */
  async getResource(kind, name, options = {}) {
    if (!this.initialized) await this.initialize();
    
    try {
      const { 
        namespace = this.options.namespace,
        outputFormat = 'json'
      } = options;
      
      // Prepare kubectl command
      const args = ['get', kind, name, '-o', outputFormat];
      
      if (namespace !== this.options.namespace) {
        args.push('-n', namespace);
      }
      
      // Get the resource
      this.log.info(`Getting Kubernetes resource: kubectl ${args.join(' ')}`);
      const result = await this._executeKubectl(args);
      
      // Parse output based on format
      let resourceData;
      if (outputFormat === 'json') {
        resourceData = JSON.parse(result.stdout);
      } else if (outputFormat === 'yaml') {
        resourceData = yaml.load(result.stdout);
      } else {
        resourceData = result.stdout;
      }
      
      return {
        success: true,
        resource: resourceData,
        kind,
        name,
        namespace
      };
    } catch (error) {
      this.log.error(`Error getting Kubernetes resource: ${error.message}`);
      throw error;
    }
  }

  /**
   * List Kubernetes resources
   * @param {string} kind - Resource kind
   * @param {Object} options - List options
   * @param {string} options.namespace - Kubernetes namespace
   * @param {string} options.labelSelector - Label selector
   * @param {string} options.fieldSelector - Field selector
   * @returns {Promise<Object>} Resource list
   */
  async listResources(kind, options = {}) {
    if (!this.initialized) await this.initialize();
    
    try {
      const { 
        namespace = this.options.namespace,
        labelSelector,
        fieldSelector,
        outputFormat = 'json'
      } = options;
      
      // Prepare kubectl command
      const args = ['get', kind, '-o', outputFormat];
      
      if (namespace !== this.options.namespace) {
        args.push('-n', namespace);
      }
      
      if (labelSelector) {
        args.push('-l', labelSelector);
      }
      
      if (fieldSelector) {
        args.push('--field-selector', fieldSelector);
      }
      
      // List resources
      this.log.info(`Listing Kubernetes resources: kubectl ${args.join(' ')}`);
      const result = await this._executeKubectl(args);
      
      // Parse output based on format
      let resourceList;
      if (outputFormat === 'json') {
        resourceList = JSON.parse(result.stdout);
      } else if (outputFormat === 'yaml') {
        resourceList = yaml.load(result.stdout);
      } else {
        resourceList = result.stdout;
      }
      
      return {
        success: true,
        resources: resourceList,
        kind,
        namespace
      };
    } catch (error) {
      this.log.error(`Error listing Kubernetes resources: ${error.message}`);
      throw error;
    }
  }

  /**
   * Get logs from a Kubernetes pod
   * @param {string} podName - Pod name
   * @param {Object} options - Log options
   * @param {string} options.namespace - Kubernetes namespace
   * @param {string} options.container - Container name
   * @param {number} options.tail - Number of lines to show
   * @param {boolean} options.follow - Follow log output
   * @returns {Promise<string>} - Pod logs
   */
  async getPodLogs(podName, options = {}) {
    if (!this.initialized) await this.initialize();
    
    try {
      const { 
        namespace = this.options.namespace,
        container,
        tail = 100,
        follow = false,
        since = undefined,
        timestamps = false,
        storeInMongo = this.mongoConnected && !follow
      } = options;
      
      // Prepare kubectl command
      const args = ['logs', podName];
      
      if (namespace !== this.options.namespace) {
        args.push('-n', namespace);
      }
      
      if (container) {
        args.push('-c', container);
      }
      
      args.push('--tail', tail.toString());
      
      if (since) {
        args.push('--since', since);
      }
      
      if (timestamps) {
        args.push('--timestamps');
      }
      
      if (follow) {
        // For follow, we'll use spawn to stream the logs
        const kubectl = spawn('kubectl', args, {
          env: this.options.kubeconfig ? { ...process.env, KUBECONFIG: this.options.kubeconfig } : process.env
        });
        
        let output = '';
        kubectl.stdout.on('data', (data) => {
          const text = data.toString();
          output += text;
          this.log.debug(`Pod logs: ${text.trim()}`);
        });
        
        kubectl.stderr.on('data', (data) => {
          const text = data.toString();
          output += text;
          this.log.debug(`Pod error logs: ${text.trim()}`);
        });
        
        return new Promise((resolve) => {
          setTimeout(() => {
            kubectl.kill();
            resolve(output);
          }, 5000); // Stream for 5 seconds
        });
      } else {
        // For non-follow, just execute the command directly
        const result = await this._executeKubectl(args);
        
        // Store logs in MongoDB if required
        if (storeInMongo && this.mongoConnected) {
          try {
            await this.collections.logs.insertOne({
              podName,
              namespace,
              container,
              cluster: this.currentContext,
              logs: result.stdout,
              timestamp: new Date(),
              tailLines: tail
            });
          } catch (error) {
            this.log.warn(`Error storing logs in MongoDB: ${error.message}`);
          }
        }
        
        return result.stdout;
      }
    } catch (error) {
      this.log.error(`Error getting pod logs: ${error.message}`);
      throw error;
    }
  }

  /**
   * Execute command in a Kubernetes pod
   * @param {string} podName - Pod name
   * @param {Array<string>} command - Command to execute
   * @param {Object} options - Execution options
   * @param {string} options.namespace - Kubernetes namespace
   * @param {string} options.container - Container name
   * @returns {Promise<string>} - Command output
   */
  async execInPod(podName, command, options = {}) {
    if (!this.initialized) await this.initialize();
    
    try {
      const { 
        namespace = this.options.namespace,
        container
      } = options;
      
      // Prepare kubectl command
      const args = ['exec', podName];
      
      if (namespace !== this.options.namespace) {
        args.push('-n', namespace);
      }
      
      if (container) {
        args.push('-c', container);
      }
      
      args.push('--', ...command);
      
      // Execute the command
      this.log.info(`Executing command in pod: kubectl ${args.join(' ')}`);
      const result = await this._executeKubectl(args);
      
      return result.stdout;
    } catch (error) {
      this.log.error(`Error executing command in pod: ${error.message}`);
      throw error;
    }
  }

  /**
   * Port forward to a Kubernetes pod
   * @param {string} podName - Pod name
   * @param {string|number} localPort - Local port
   * @param {string|number} podPort - Pod port
   * @param {Object} options - Port forward options
   * @param {string} options.namespace - Kubernetes namespace
   * @returns {Promise<Object>} - Port forward process and information
   */
  async portForwardToPod(podName, localPort, podPort, options = {}) {
    if (!this.initialized) await this.initialize();
    
    try {
      const { 
        namespace = this.options.namespace,
        address = '127.0.0.1'
      } = options;
      
      // Create a unique ID for this port-forward
      const forwardId = `${namespace}:${podName}:${localPort}:${podPort}`;
      
      // Check if already forwarding
      if (this.portForwards.has(forwardId)) {
        this.log.info(`Already forwarding ${forwardId}`);
        return this.portForwards.get(forwardId);
      }
      
      // Prepare kubectl command
      const args = ['port-forward', podName, `${localPort}:${podPort}`];
      
      if (namespace !== this.options.namespace) {
        args.push('-n', namespace);
      }
      
      if (address !== '127.0.0.1') {
        args.push('--address', address);
      }
      
      // Start port forwarding
      this.log.info(`Starting port forward: kubectl ${args.join(' ')}`);
      
      const kubectl = spawn('kubectl', args, {
        env: this.options.kubeconfig ? { ...process.env, KUBECONFIG: this.options.kubeconfig } : process.env
      });
      
      kubectl.stdout.on('data', (data) => {
        this.log.debug(`Port forward output: ${data.toString().trim()}`);
      });
      
      kubectl.stderr.on('data', (data) => {
        this.log.debug(`Port forward error: ${data.toString().trim()}`);
      });
      
      // Create a promise that resolves when port forwarding is established
      const established = new Promise((resolve, reject) => {
        const timeout = setTimeout(() => {
          reject(new Error('Port forward timed out'));
        }, 10000); // 10 second timeout
        
        kubectl.stdout.on('data', (data) => {
          if (data.toString().includes('Forwarding from')) {
            clearTimeout(timeout);
            resolve();
          }
        });
        
        kubectl.on('error', (error) => {
          clearTimeout(timeout);
          reject(error);
        });
        
        kubectl.on('close', (code) => {
          if (code !== 0) {
            clearTimeout(timeout);
            reject(new Error(`Port forward process exited with code ${code}`));
          }
        });
      });
      
      // Wait for port forwarding to be established
      await established;
      
      this.log.info(`Port forward established from ${address}:${localPort} to ${podName}:${podPort}`);
      
      // Create port forward object
      const portForward = {
        id: forwardId,
        process: kubectl,
        localAddress: address,
        localPort,
        podPort,
        podName,
        namespace,
        startedAt: new Date(),
        stop: () => {
          kubectl.kill();
          this.portForwards.delete(forwardId);
          this.log.info(`Port forward stopped for ${forwardId}`);
        }
      };
      
      // Store in active port forwards
      this.portForwards.set(forwardId, portForward);
      
      // Set up automatic cleanup when process exits
      kubectl.on('close', () => {
        this.portForwards.delete(forwardId);
        this.log.info(`Port forward ${forwardId} closed`);
      });
      
      return portForward;
    } catch (error) {
      this.log.error(`Error setting up port forward: ${error.message}`);
      throw error;
    }
  }

  /**
   * Stop all port forwards
   * @returns {Promise<void>}
   */
  async stopAllPortForwards() {
    for (const [id, forward] of this.portForwards.entries()) {
      this.log.info(`Stopping port forward ${id}`);
      forward.stop();
    }
    
    this.portForwards.clear();
  }

  /**
   * Scale a Kubernetes deployment
   * @param {string} deploymentName - Deployment name
   * @param {number} replicas - Number of replicas
   * @param {Object} options - Scale options
   * @param {string} options.namespace - Kubernetes namespace
   * @returns {Promise<Object>} - Scale result
   */
  async scaleDeployment(deploymentName, replicas, options = {}) {
    if (!this.initialized) await this.initialize();
    
    try {
      const { 
        namespace = this.options.namespace
      } = options;
      
      // Prepare kubectl command
      const args = ['scale', 'deployment', deploymentName, `--replicas=${replicas}`];
      
      if (namespace !== this.options.namespace) {
        args.push('-n', namespace);
      }
      
      // Scale the deployment
      this.log.info(`Scaling deployment ${deploymentName} to ${replicas} replicas`);
      const result = await this._executeKubectl(args);
      
      // Update in MongoDB if connected
      if (this.mongoConnected) {
        try {
          await this.collections.deployments.updateOne(
            { 
              name: deploymentName, 
              namespace, 
              cluster: this.currentContext 
            },
            {
              $set: {
                'manifest.spec.replicas': replicas,
                lastUpdated: new Date()
              }
            }
          );
        } catch (error) {
          this.log.warn(`Error updating deployment in MongoDB: ${error.message}`);
        }
      }
      
      return {
        success: true,
        output: result.stdout,
        deploymentName,
        replicas,
        namespace
      };
    } catch (error) {
      this.log.error(`Error scaling deployment: ${error.message}`);
      throw error;
    }
  }

  /**
   * Restart a Kubernetes deployment (by rolling out the deployment)
   * @param {string} deploymentName - Deployment name
   * @param {Object} options - Restart options
   * @param {string} options.namespace - Kubernetes namespace
   * @returns {Promise<Object>} - Restart result
   */
  async restartDeployment(deploymentName, options = {}) {
    if (!this.initialized) await this.initialize();
    
    try {
      const { 
        namespace = this.options.namespace
      } = options;
      
      // Prepare kubectl command for rollout restart
      const args = ['rollout', 'restart', 'deployment', deploymentName];
      
      if (namespace !== this.options.namespace) {
        args.push('-n', namespace);
      }
      
      // Restart the deployment
      this.log.info(`Restarting deployment ${deploymentName}`);
      const result = await this._executeKubectl(args);
      
      // Wait for rollout to complete
      const statusArgs = ['rollout', 'status', 'deployment', deploymentName];
      if (namespace !== this.options.namespace) {
        statusArgs.push('-n', namespace);
      }
      
      this.log.info(`Waiting for deployment ${deploymentName} rollout to complete`);
      const statusResult = await this._executeKubectl(statusArgs);
      
      return {
        success: true,
        output: result.stdout,
        statusOutput: statusResult.stdout,
        deploymentName,
        namespace
      };
    } catch (error) {
      this.log.error(`Error restarting deployment: ${error.message}`);
      throw error;
    }
  }

  /**
   * Get Kubernetes events
   * @param {Object} options - Event options
   * @param {string} options.namespace - Kubernetes namespace
   * @param {string} options.fieldSelector - Field selector
   * @param {number} options.limit - Limit the number of events
   * @returns {Promise<Object>} - Events data
   */
  async getEvents(options = {}) {
    if (!this.initialized) await this.initialize();
    
    try {
      const { 
        namespace = this.options.namespace,
        fieldSelector,
        limit = 50
      } = options;
      
      // Prepare kubectl command
      const args = ['get', 'events', '--sort-by=.lastTimestamp', '-o', 'json'];
      
      if (namespace !== this.options.namespace) {
        args.push('-n', namespace);
      }
      
      if (fieldSelector) {
        args.push('--field-selector', fieldSelector);
      }
      
      // Get the events
      this.log.info(`Getting Kubernetes events: kubectl ${args.join(' ')}`);
      const result = await this._executeKubectl(args);
      
      // Parse output
      const eventsData = JSON.parse(result.stdout);
      
      // Limit the number of events if required
      if (eventsData.items.length > limit) {
        eventsData.items = eventsData.items.slice(-limit);
      }
      
      // Store events in MongoDB if connected
      if (this.mongoConnected) {
        try {
          for (const event of eventsData.items) {
            await this.collections.events.updateOne(
              { 
                uid: event.metadata.uid,
                cluster: this.currentContext
              },
              {
                $set: {
                  ...event,
                  namespace: event.metadata.namespace,
                  type: event.type,
                  reason: event.reason,
                  message: event.message,
                  involvedObject: `${event.involvedObject.kind}/${event.involvedObject.name}`,
                  lastTimestamp: new Date(event.lastTimestamp),
                  firstTimestamp: new Date(event.firstTimestamp),
                  count: event.count,
                  lastUpdated: new Date()
                },
                $setOnInsert: {
                  createdAt: new Date()
                }
              },
              { upsert: true }
            );
          }
        } catch (error) {
          this.log.warn(`Error storing events in MongoDB: ${error.message}`);
        }
      }
      
      return {
        success: true,
        events: eventsData,
        namespace
      };
    } catch (error) {
      this.log.error(`Error getting events: ${error.message}`);
      throw error;
    }
  }

  /**
   * Create a Kubernetes manifest from template
   * @param {Object} options - Manifest options
   * @param {string} options.kind - Resource kind
   * @param {string} options.name - Resource name
   * @param {string} options.image - Container image
   * @param {string} options.namespace - Kubernetes namespace
   * @param {Object} options.labels - Resource labels
   * @param {Object} options.env - Environment variables
   * @param {Object} options.resources - Resource limits
   * @param {Array<Object>} options.ports - Container ports
   * @param {Array<Object>} options.volumes - Container volumes
   * @returns {Object} - Kubernetes manifest
   */
  createManifest(options) {
    try {
      const {
        kind = 'Deployment',
        name,
        image,
        namespace = this.options.namespace,
        labels = {},
        env = {},
        resources = {},
        ports = [],
        volumes = [],
        replicas = 1,
        serviceAccount,
        annotations = {}
      } = options;
      
      // Base labels to include in all resources
      const baseLabels = {
        'app': name,
        'managed-by': 'safeguard-k8s-manager',
        ...labels
      };
      
      // Convert environment variables to Kubernetes format
      const envVars = Object.entries(env).map(([key, value]) => ({
        name: key,
        value: String(value)
      }));
      
      // Convert resources to Kubernetes format
      const resourceLimits = {};
      const resourceRequests = {};
      
      if (resources.cpuLimit) {
        resourceLimits.cpu = resources.cpuLimit;
      }
      if (resources.memoryLimit) {
        resourceLimits.memory = resources.memoryLimit;
      }
      if (resources.cpuRequest) {
        resourceRequests.cpu = resources.cpuRequest;
      }
      if (resources.memoryRequest) {
        resourceRequests.memory = resources.memoryRequest;
      }
      
      let manifest;
      
      switch (kind) {
        case 'Deployment':
          manifest = {
            apiVersion: 'apps/v1',
            kind: 'Deployment',
            metadata: {
              name,
              namespace,
              labels: baseLabels,
              annotations
            },
            spec: {
              replicas,
              selector: {
                matchLabels: {
                  app: name
                }
              },
              template: {
                metadata: {
                  labels: {
                    app: name,
                    ...labels
                  },
                  annotations
                },
                spec: {
                  containers: [{
                    name: name,
                    image,
                    ports: ports.map(port => ({
                      containerPort: port.containerPort || port,
                      name: port.name || `port-${port.containerPort || port}`,
                      protocol: port.protocol || 'TCP'
                    })),
                    env: envVars,
                    resources: {}
                  }]
                }
              }
            }
          };
          
          // Add resources if specified
          if (Object.keys(resourceLimits).length > 0) {
            manifest.spec.template.spec.containers[0].resources.limits = resourceLimits;
          }
          if (Object.keys(resourceRequests).length > 0) {
            manifest.spec.template.spec.containers[0].resources.requests = resourceRequests;
          }
          
          // Add service account if specified
          if (serviceAccount) {
            manifest.spec.template.spec.serviceAccountName = serviceAccount;
          }
          
          // Add volumes if specified
          if (volumes.length > 0) {
            manifest.spec.template.spec.volumes = volumes.map(vol => vol.volume);
            manifest.spec.template.spec.containers[0].volumeMounts = volumes.map(vol => vol.mount);
          }
          
          // Add additional container options if specified
          if (options.command) {
            manifest.spec.template.spec.containers[0].command = 
              Array.isArray(options.command) ? options.command : [options.command];
          }
          
          if (options.args) {
            manifest.spec.template.spec.containers[0].args = 
              Array.isArray(options.args) ? options.args : [options.args];
          }
          
          if (options.imagePullPolicy) {
            manifest.spec.template.spec.containers[0].imagePullPolicy = options.imagePullPolicy;
          }
          
          break;
          
        case 'Service':
          manifest = {
            apiVersion: 'v1',
            kind: 'Service',
            metadata: {
              name,
              namespace,
              labels: baseLabels,
              annotations
            },
            spec: {
              selector: {
                app: name
              },
              ports: ports.map(port => ({
                port: port.port || port,
                targetPort: port.targetPort || port.port || port,
                name: port.name || `port-${port.port || port}`,
                protocol: port.protocol || 'TCP'
              })),
              type: options.serviceType || 'ClusterIP'
            }
          };
          break;
          
        case 'ConfigMap':
          manifest = {
            apiVersion: 'v1',
            kind: 'ConfigMap',
            metadata: {
              name,
              namespace,
              labels: baseLabels,
              annotations
            },
            data: options.data || {}
          };
          break;
          
        case 'Secret':
          // For secrets, we need to base64 encode the values
          const secretData = {};
          if (options.data) {
            Object.entries(options.data).forEach(([key, value]) => {
              secretData[key] = Buffer.from(String(value)).toString('base64');
            });
          }
          
          manifest = {
            apiVersion: 'v1',
            kind: 'Secret',
            metadata: {
              name,
              namespace,
              labels: baseLabels,
              annotations
            },
            type: options.secretType || 'Opaque',
            data: secretData
          };
          break;
          
        case 'Job':
          manifest = {
            apiVersion: 'batch/v1',
            kind: 'Job',
            metadata: {
              name,
              namespace,
              labels: baseLabels,
              annotations
            },
            spec: {
              template: {
                metadata: {
                  labels: {
                    app: name,
                    ...labels
                  },
                  annotations
                },
                spec: {
                  containers: [{
                    name: name,
                    image,
                    env: envVars,
                    resources: {}
                  }],
                  restartPolicy: options.restartPolicy || 'Never'
                }
              },
              backoffLimit: options.backoffLimit || 3
            }
          };
          
          // Add resources if specified
          if (Object.keys(resourceLimits).length > 0) {
            manifest.spec.template.spec.containers[0].resources.limits = resourceLimits;
          }
          if (Object.keys(resourceRequests).length > 0) {
            manifest.spec.template.spec.containers[0].resources.requests = resourceRequests;
          }
          
          // Add service account if specified
          if (serviceAccount) {
            manifest.spec.template.spec.serviceAccountName = serviceAccount;
          }
          
          // Add volumes if specified
          if (volumes.length > 0) {
            manifest.spec.template.spec.volumes = volumes.map(vol => vol.volume);
            manifest.spec.template.spec.containers[0].volumeMounts = volumes.map(vol => vol.mount);
          }
          
          // Add command and args if specified
          if (options.command) {
            manifest.spec.template.spec.containers[0].command = 
              Array.isArray(options.command) ? options.command : [options.command];
          }
          
          if (options.args) {
            manifest.spec.template.spec.containers[0].args = 
              Array.isArray(options.args) ? options.args : [options.args];
          }
          
          break;
          
        case 'CronJob':
          manifest = {
            apiVersion: 'batch/v1',
            kind: 'CronJob',
            metadata: {
              name,
              namespace,
              labels: baseLabels,
              annotations
            },
            spec: {
              schedule: options.schedule || '* * * * *',
              jobTemplate: {
                spec: {
                  template: {
                    metadata: {
                      labels: {
                        app: name,
                        ...labels
                      },
                      annotations
                    },
                    spec: {
                      containers: [{
                        name: name,
                        image,
                        env: envVars,
                        resources: {}
                      }],
                      restartPolicy: options.restartPolicy || 'Never'
                    }
                  },
                  backoffLimit: options.backoffLimit || 3
                }
              }
            }
          };
          
          // Add resources if specified
          if (Object.keys(resourceLimits).length > 0) {
            manifest.spec.jobTemplate.spec.template.spec.containers[0].resources.limits = resourceLimits;
          }
          if (Object.keys(resourceRequests).length > 0) {
            manifest.spec.jobTemplate.spec.template.spec.containers[0].resources.requests = resourceRequests;
          }
          
          // Add service account if specified
          if (serviceAccount) {
            manifest.spec.jobTemplate.spec.template.spec.serviceAccountName = serviceAccount;
          }
          
          // Add volumes if specified
          if (volumes.length > 0) {
            manifest.spec.jobTemplate.spec.template.spec.volumes = volumes.map(vol => vol.volume);
            manifest.spec.jobTemplate.spec.template.spec.containers[0].volumeMounts = volumes.map(vol => vol.mount);
          }
          
          // Add command and args if specified
          if (options.command) {
            manifest.spec.jobTemplate.spec.template.spec.containers[0].command = 
              Array.isArray(options.command) ? options.command : [options.command];
          }
          
          if (options.args) {
            manifest.spec.jobTemplate.spec.template.spec.containers[0].args = 
              Array.isArray(options.args) ? options.args : [options.args];
          }
          
          break;
          
        case 'Pod':
          manifest = {
            apiVersion: 'v1',
            kind: 'Pod',
            metadata: {
              name,
              namespace,
              labels: baseLabels,
              annotations
            },
            spec: {
              containers: [{
                name: name,
                image,
                ports: ports.map(port => ({
                  containerPort: port.containerPort || port,
                  name: port.name || `port-${port.containerPort || port}`,
                  protocol: port.protocol || 'TCP'
                })),
                env: envVars,
                resources: {}
              }]
            }
          };
          
          // Add resources if specified
          if (Object.keys(resourceLimits).length > 0) {
            manifest.spec.containers[0].resources.limits = resourceLimits;
          }
          if (Object.keys(resourceRequests).length > 0) {
            manifest.spec.containers[0].resources.requests = resourceRequests;
          }
          
          // Add service account if specified
          if (serviceAccount) {
            manifest.spec.serviceAccountName = serviceAccount;
          }
          
          // Add volumes if specified
          if (volumes.length > 0) {
            manifest.spec.volumes = volumes.map(vol => vol.volume);
            manifest.spec.containers[0].volumeMounts = volumes.map(vol => vol.mount);
          }
          
          // Add command and args if specified
          if (options.command) {
            manifest.spec.containers[0].command = 
              Array.isArray(options.command) ? options.command : [options.command];
          }
          
          if (options.args) {
            manifest.spec.containers[0].args = 
              Array.isArray(options.args) ? options.args : [options.args];
          }
          
          if (options.imagePullPolicy) {
            manifest.spec.containers[0].imagePullPolicy = options.imagePullPolicy;
          }
          
          break;
          
        default:
          throw new Error(`Unsupported Kubernetes resource kind: ${kind}`);
      }
      
      return manifest;
    } catch (error) {
      this.log.error(`Error creating Kubernetes manifest: ${error.message}`);
      throw error;
    }
  }

  /**
   * Register Meteor methods
   */
  registerMeteorMethods() {
    Meteor.methods({
      'kubernetes.getVersion': async () => {
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        if (!this.initialized) await this.initialize();
        return {
          serverVersion: this.serverVersion,
          clientVersion: kubectlVersion
        };
      },
      
      'kubernetes.deployManifest': async (manifest, options) => {
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        return await this.deployManifest(manifest, options);
      },
      
      'kubernetes.getResource': async (kind, name, options) => {
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        return await this.getResource(kind, name, options);
      },
      
      'kubernetes.listResources': async (kind, options) => {
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        return await this.listResources(kind, options);
      },
      
      'kubernetes.deleteResource': async (kind, name, options) => {
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        return await this.deleteResource(kind, name, options);
      },
      
      'kubernetes.getPodLogs': async (podName, options) => {
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        return await this.getPodLogs(podName, options);
      },
      
      'kubernetes.execInPod': async (podName, command, options) => {
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        return await this.execInPod(podName, command, options);
      },
      
      'kubernetes.scaleDeployment': async (deploymentName, replicas, options) => {
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        return await this.scaleDeployment(deploymentName, replicas, options);
      },
      
      'kubernetes.restartDeployment': async (deploymentName, options) => {
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        return await this.restartDeployment(deploymentName, options);
      },
      
      'kubernetes.getEvents': async (options) => {
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        return await this.getEvents(options);
      },
      
      'kubernetes.createManifest': (options) => {
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        return this.createManifest(options);
      }
    });
  }
  
  /**
   * Close the Kubernetes manager and clean up resources
   * @returns {Promise<void>}
   */
  async close() {
    if (!this.initialized) return;
    
    try {
      // Stop all port forwards
      await this.stopAllPortForwards();
      
      // Close MongoDB connection
      if (this.mongoConnected && this.mongoClient) {
        await this.mongoClient.close();
        this.mongoConnected = false;
      }
      
      this.initialized = false;
      this.log.info('Kubernetes manager closed');
    } catch (error) {
      this.log.error(`Error closing Kubernetes manager: ${error.message}`);
      throw error;
    }
  }
}

module.exports = KubernetesManager;
```


## 3. Let's create a Kubernetes deployment module for our OpenAPI wizard:

```javascript
// Path: /private/plugin/modules/OpenAPIWizardKubernetesDeployer.js
// Written by Greg Deeds, Autonomy Association International, Inc.
// Copyright 2025 Autonomy Association International Inc., all rights reserved 
// Safeguard patent license from National Aeronautics and Space Administration (NASA)
// Copyright 2025 NASA, all rights reserved

/**
 * OpenAPI Wizard Kubernetes Deployer
 * 
 * Utility for deploying OpenAPI plugins to Kubernetes
 */

const KubernetesManager = require('./KubernetesManager');
const OpenAPIWizard = require('./OpenAPIWizard');
const fs = require('fs').promises;
const path = require('path');
const crypto = require('crypto');
const yaml = require('js-yaml');

class OpenAPIWizardKubernetesDeployer {
  /**
   * Create a new OpenAPIWizardKubernetesDeployer
   * @param {Object} options - Deployer options
   * @param {string} options.namespace - Kubernetes namespace
   * @param {string} options.kubeconfig - Path to kubeconfig file
   * @param {Object} options.resources - Resource limits
   */
  constructor(options = {}) {
    this.options = {
      namespace: options.namespace || process.env.KUBERNETES_NAMESPACE || 'default',
      kubeconfig: options.kubeconfig || process.env.KUBECONFIG,
      resources: options.resources || {
        cpuRequest: '100m',
        memoryRequest: '128Mi',
        cpuLimit: '500m',
        memoryLimit: '256Mi'
      },
      ...options
    };
    
    this.kubernetesManager = new KubernetesManager({
      namespace: this.options.namespace,
      kubeconfig: this.options.kubeconfig
    });
    
    this.log = {
      info: (msg) => console.log(`[OpenAPIK8sDeployer:INFO] ${msg}`),
      warn: (msg) => console.warn(`[OpenAPIK8sDeployer:WARN] ${msg}`),
      error: (msg) => console.error(`[OpenAPIK8sDeployer:ERROR] ${msg}`),
      debug: (msg) => console.debug(`[OpenAPIK8sDeployer:DEBUG] ${msg}`)
    };
  }

  /**
   * Initialize the deployer
   * @returns {Promise<void>}
   */
  async initialize() {
    await this.kubernetesManager.initialize();
    this.log.info('OpenAPI Wizard Kubernetes Deployer initialized');
  }

  /**
   * Deploy an OpenAPI plugin to Kubernetes
   * @param {Object} config - OpenAPI plugin configuration
   * @param {Object} deployOptions - Deployment options
   * @returns {Promise<Object>} Deployment result
   */
  async deployOpenAPIPlugin(config, deployOptions = {}) {
    try {
      if (!this.kubernetesManager.initialized) {
        await this.initialize();
      }
      
      const {
        name = `openapi-${crypto.randomBytes(4).toString('hex')}`,
        serviceType = 'ClusterIP',
        port = 3000,
        replicas = 1,
        annotations = {},
        labels = {},
        volumes = [],
        enableIngress = false,
        ingressHost,
        ingressAnnotations = {},
        enableMonitoring = false,
        securityContext = {},
        envVars = {},
        serviceAccount,
        createSecret = true
      } = deployOptions;
      
      // Validate configuration
      this.log.info(`Validating OpenAPI plugin configuration for ${name}`);
      const wizard = new OpenAPIWizard(config);
      
      try {
        // Initialize to validate configuration
        await wizard.initialize();
      } catch (error) {
        throw new Error(`Invalid OpenAPI configuration: ${error.message}`);
      }
      
      // Store credentials in a Kubernetes secret if authentication is required
      let secretName;
      
      if (config.authentication && config.authentication.credentials && createSecret) {
        secretName = `${name}-credentials`;
        
        const secretData = {};
        
        // Format credentials based on authentication type
        switch (config.authentication.type) {
          case 'apiKey':
            secretData.apiKey = config.authentication.credentials.apiKey;
            break;
            
          case 'basic':
            secretData.username = config.authentication.credentials.username;
            secretData.password = config.authentication.credentials.password;
            break;
            
          case 'bearer':
            secretData.token = config.authentication.credentials.token;
            break;
            
          case 'oauth2':
            secretData.accessToken = config.authentication.credentials.accessToken;
            if (config.authentication.credentials.refreshToken) {
              secretData.refreshToken = config.authentication.credentials.refreshToken;
            }
            break;
        }
        
        // Create secret manifest
        const secretManifest = this.kubernetesManager.createManifest({
          kind: 'Secret',
          name: secretName,
          namespace: this.options.namespace,
          labels: {
            app: name,
            'managed-by': 'openapi-wizard',
            ...labels
          },
          data: secretData
        });
        
        // Deploy secret
        this.log.info(`Creating Kubernetes secret ${secretName}`);
        await this.kubernetesManager.deployManifest(secretManifest);
      }
      
      // Create ConfigMap with OpenAPI configuration
      const configMapName = `${name}-config`;
      
      // Remove credentials from config for ConfigMap
      const configForConfigMap = { ...config };
      if (configForConfigMap.authentication) {
        configForConfigMap.authentication = { ...configForConfigMap.authentication };
        delete configForConfigMap.authentication.credentials;
      }
      
      const configMapManifest = this.kubernetesManager.createManifest({
        kind: 'ConfigMap',
        name: configMapName,
        namespace: this.options.namespace,
        labels: {
          app: name,
          'managed-by': 'openapi-wizard',
          ...labels
        },
        data: {
          'config.json': JSON.stringify(configForConfigMap, null, 2)
        }
      });
      
      // Deploy ConfigMap
      this.log.info(`Creating Kubernetes ConfigMap ${configMapName}`);
      await this.kubernetesManager.deployManifest(configMapManifest);
      
      // Prepare environment variables
      const env = {
        OPENAPI_CONFIG_PATH: '/app/config/config.json',
        ...envVars
      };
      
      if (secretName) {
        env.AUTH_SECRET_PATH = '/app/secrets';
      }
      
      // Prepare volumes
      const deployVolumes = [
        {
          volume: {
            name: 'config-volume',
            configMap: {
              name: configMapName
            }
          },
          mount: {
            name: 'config-volume',
            mountPath: '/app/config'
          }
        },
        ...volumes
      ];
      
      // Add secret volume if needed
      if (secretName) {
        deployVolumes.push({
          volume: {
            name: 'secrets-volume',
            secret: {
              secretName
            }
          },
          mount: {
            name: 'secrets-volume',
            mountPath: '/app/secrets'
          }
        });
      }
      
      // Create deployment manifest
      const deploymentManifest = this.kubernetesManager.createManifest({
        kind: 'Deployment',
        name,
        namespace: this.options.namespace,
        image: 'safeguard/openapi-wizard:latest', // Use appropriate image
        replicas,
        labels: {
          app: name,
          'managed-by': 'openapi-wizard',
          ...labels
        },
        annotations: {
          'openapi-wizard/version': '1.0.0',
          'openapi-wizard/title': wizard.title || 'OpenAPI Plugin',
          'openapi-wizard/base-url': wizard.baseUrl || '',
          ...annotations
        },
        env,
        resources: this.options.resources,
        ports: [{ containerPort: port, name: 'http' }],
        volumes: deployVolumes,
        serviceAccount
      });
      
      // Deploy the deployment
      this.log.info(`Creating Kubernetes Deployment ${name}`);
      const deploymentResult = await this.kubernetesManager.deployManifest(deploymentManifest);
      
      // Create service manifest
      const serviceManifest = this.kubernetesManager.createManifest({
        kind: 'Service',
        name,
        namespace: this.options.namespace,
        labels: {
          app: name,
          'managed-by': 'openapi-wizard',
          ...labels
        },
        annotations,
        ports: [{ port, targetPort: port, name: 'http' }],
        serviceType
      });
      
      // Deploy the service
      this.log.info(`Creating Kubernetes Service ${name}`);
      const serviceResult = await this.kubernetesManager.deployManifest(serviceManifest);
      
      // Create ingress if enabled
      let ingressResult;
      if (enableIngress && ingressHost) {
        const ingressManifest = {
          apiVersion: 'networking.k8s.io/v1',
          kind: 'Ingress',
          metadata: {
            name,
            namespace: this.options.namespace,
            labels: {
              app: name,
              'managed-by': 'openapi-wizard',
              ...labels
            },
            annotations: {
              'kubernetes.io/ingress.class': 'nginx',
              ...ingressAnnotations
            }
          },
          spec: {
            rules: [
              {
                host: ingressHost,
                http: {
                  paths: [
                    {
                      path: '/',
                      pathType: 'Prefix',
                      backend: {
                        service: {
                          name,
                          port: {
                            number: port
                          }
                        }
                      }
                    }
                  ]
                }
              }
            ]
          }
        };
        
        // Deploy the ingress
        this.log.info(`Creating Kubernetes Ingress for ${name} at ${ingressHost}`);
        ingressResult = await this.kubernetesManager.deployManifest(ingressManifest);
      }
      
      // Enable monitoring if requested
      let serviceMonitorResult;
      if (enableMonitoring) {
        const serviceMonitorManifest = {
          apiVersion: 'monitoring.coreos.com/v1',
          kind: 'ServiceMonitor',
          metadata: {
            name,
            namespace: this.options.namespace,
            labels: {
              app: name,
              'managed-by': 'openapi-wizard',
              ...labels
            }
          },
          spec: {
            selector: {
              matchLabels: {
                app: name
              }
            },
            endpoints: [
              {
                port: 'http',
                interval: '15s',
                path: '/metrics'
              }
            ]
          }
        };
        
        // Deploy the service monitor
        try {
          this.log.info(`Creating Kubernetes ServiceMonitor for ${name}`);
          serviceMonitorResult = await this.kubernetesManager.deployManifest(serviceMonitorManifest);
        } catch (error) {
          this.log.warn(`Failed to create ServiceMonitor, Prometheus operator may not be installed: ${error.message}`);
        }
      }
      
      // Return deployment information
      return {
        success: true,
        name,
        namespace: this.options.namespace,
        service: {
          name,
          type: serviceType,
          port
        },
        deployment: {
          name,
          replicas
        },
        ingress: enableIngress ? {
          enabled: true,
          host: ingressHost
        } : {
          enabled: false
        },
        monitoring: enableMonitoring,
        secrets: secretName ? [secretName] : [],
        configMaps: [configMapName]
      };
    } catch (error) {
      this.log.error(`Failed to deploy OpenAPI plugin: ${error.message}`);
      throw error;
    }
  }

  /**
   * Delete an OpenAPI plugin from Kubernetes
   * @param {string} name - Plugin name
   * @returns {Promise<Object>} Deletion result
   */
  async deleteOpenAPIPlugin(name) {
    try {
      if (!this.kubernetesManager.initialized) {
        await this.initialize();
      }
      
      this.log.info(`Deleting OpenAPI plugin ${name} from Kubernetes`);
      
      // Delete deployment
      try {
        await this.kubernetesManager.deleteResource('deployment', name);
        this.log.info(`Deleted Deployment ${name}`);
      } catch (error) {
        this.log.warn(`Failed to delete Deployment ${name}: ${error.message}`);
      }
      
      // Delete service
      try {
        await this.kubernetesManager.deleteResource('service', name);
        this.log.info(`Deleted Service ${name}`);
      } catch (error) {
        this.log.warn(`Failed to delete Service ${name}: ${error.message}`);
      }
      
      // Delete ingress
      try {
        await this.kubernetesManager.deleteResource('ingress', name);
        this.log.info(`Deleted Ingress ${name}`);
      } catch (error) {
        this.log.warn(`Failed to delete Ingress ${name}: ${error.message}`);
      }
      
      // Delete service monitor
      try {
        await this.kubernetesManager.deleteResource('servicemonitor', name);
        this.log.info(`Deleted ServiceMonitor ${name}`);
      } catch (error) {
        this.log.warn(`Failed to delete ServiceMonitor ${name}: ${error.message}`);
      }
      
      // Delete config map
      try {
        await this.kubernetesManager.deleteResource('configmap', `${name}-config`);
        this.log.info(`Deleted ConfigMap ${name}-config`);
      } catch (error) {
        this.log.warn(`Failed to delete ConfigMap ${name}-config: ${error.message}`);
      }
      
      // Delete secret
      try {
        await this.kubernetesManager.deleteResource('secret', `${name}-credentials`);
        this.log.info(`Deleted Secret ${name}-credentials`);
      } catch (error) {
        this.log.warn(`Failed to delete Secret ${name}-credentials: ${error.message}`);
      }
      
      return {
        success: true,
        name,
        namespace: this.options.namespace,
        message: `Successfully deleted OpenAPI plugin ${name}`
      };
    } catch (error) {
      this.log.error(`Failed to delete OpenAPI plugin: ${error.message}`);
      throw error;
    }
  }

  /**
   * Get status of an OpenAPI plugin in Kubernetes
   * @param {string} name - Plugin name
   * @returns {Promise<Object>} Plugin status
   */
  async getOpenAPIPluginStatus(name) {
    try {
      if (!this.kubernetesManager.initialized) {
        await this.initialize();
      }
      
      this.log.info(`Getting status for OpenAPI plugin ${name}`);
      
      // Get deployment status
      let deployment;
      try {
        const deploymentResult = await this.kubernetesManager.getResource('deployment', name);
        deployment = deploymentResult.resource;
      } catch (error) {
        this.log.warn(`Failed to get Deployment ${name}: ${error.message}`);
      }
      
      // Get service status
      let service;
      try {
        const serviceResult = await this.kubernetesManager.getResource('service', name);
        service = serviceResult.resource;
      } catch (error) {
        this.log.warn(`Failed to get Service ${name}: ${error.message}`);
      }
      
      // Get ingress status
      let ingress;
      try {
        const ingressResult = await this.kubernetesManager.getResource('ingress', name);
        ingress = ingressResult.resource;
      } catch (error) {
        this.log.debug(`No Ingress found for ${name}`);
      }
      
      // Get config map
      let configMap;
      try {
        const configMapResult = await this.kubernetesManager.getResource('configmap', `${name}-config`);
        configMap = configMapResult.resource;
      } catch (error) {
        this.log.warn(`Failed to get ConfigMap ${name}-config: ${error.message}`);
      }
      
      // Get pods
      let pods = [];
      try {
        const podsResult = await this.kubernetesManager.listResources('pods', {
          labelSelector: `app=${name}`
        });
        pods = podsResult.resources.items;
      } catch (error) {
        this.log.warn(`Failed to get Pods for ${name}: ${error.message}`);
      }
      
      // Get plugin configuration from ConfigMap
      let pluginConfig;
      if (configMap && configMap.data && configMap.data['config.json']) {
        try {
          pluginConfig = JSON.parse(configMap.data['config.json']);
        } catch (error) {
          this.log.warn(`Failed to parse plugin config: ${error.message}`);
        }
      }
      
      // Calculate status
      let status = 'Unknown';
      if (deployment) {
        const availableReplicas = deployment.status.availableReplicas || 0;
        const replicas = deployment.spec.replicas || 0;
        
        if (availableReplicas === replicas) {
          status = 'Ready';
        } else if (availableReplicas > 0) {
          status = 'Degraded';
        } else {
          status = 'NotReady';
        }
      } else {
        status = 'NotFound';
      }
      
      return {
        success: true,
        name,
        namespace: this.options.namespace,
        status,
        deployment: deployment ? {
          name: deployment.metadata.name,
          replicas: deployment.spec.replicas,
          availableReplicas: deployment.status.availableReplicas || 0,
          createdAt: new Date(deployment.metadata.creationTimestamp),
          image: deployment.spec.template.spec.containers[0].image
        } : null,
        service: service ? {
          name: service.metadata.name,
          type: service.spec.type,
          ports: service.spec.ports,
          clusterIP: service.spec.clusterIP
        } : null,
        ingress: ingress ? {
          name: ingress.metadata.name,
          hosts: ingress.spec.rules.map(rule => rule.host),
          createdAt: new Date(ingress.metadata.creationTimestamp)
        } : null,
        pods: pods.map(pod => ({
          name: pod.metadata.name,
          phase: pod.status.phase,
          createdAt: new Date(pod.metadata.creationTimestamp),
          restarts: pod.status.containerStatuses ? 
            pod.status.containerStatuses[0].restartCount : 0,
          ready: pod.status.containerStatuses ? 
            pod.status.containerStatuses[0].ready : false
        })),
        pluginInfo: pluginConfig ? {
          title: pluginConfig.title || 'Unknown',
          baseUrl: pluginConfig.baseUrl || 'Unknown',
          authType: pluginConfig.authentication ? 
            pluginConfig.authentication.type : 'none'
        } : null
      };
    } catch (error) {
      this.log.error(`Failed to get OpenAPI plugin status: ${error.message}`);
      throw error;
    }
  }

  /**
   * Scale an OpenAPI plugin deployment
   * @param {string} name - Plugin name
   * @param {number} replicas - Number of replicas
   * @returns {Promise<Object>} Scale result
   */
  async scaleOpenAPIPlugin(name, replicas) {
    try {
      if (!this.kubernetesManager.initialized) {
        await this.initialize();
      }
      
      this.log.info(`Scaling OpenAPI plugin ${name} to ${replicas} replicas`);
      
      const result = await this.kubernetesManager.scaleDeployment(name, replicas);
      
      return {
        success: true,
        name,
        namespace: this.options.namespace,
        replicas,
        message: result.output
      };
    } catch (error) {
      this.log.error(`Failed to scale OpenAPI plugin: ${error.message}`);
      throw error;
    }
  }

  /**
   * Update an OpenAPI plugin configuration
   * @param {string} name - Plugin name
   * @param {Object} config - New configuration
   * @returns {Promise<Object>} Update result
   */
  async updateOpenAPIPluginConfig(name, config) {
    try {
      if (!this.kubernetesManager.initialized) {
        await this.initialize();
      }
      
      this.log.info(`Updating configuration for OpenAPI plugin ${name}`);
      
      // Validate configuration
      const wizard = new OpenAPIWizard(config);
      
      try {
        // Initialize to validate configuration
        await wizard.initialize();
      } catch (error) {
        throw new Error(`Invalid OpenAPI configuration: ${error.message}`);
      }
      
      // Remove credentials from config for ConfigMap
      const configForConfigMap = { ...config };
      if (configForConfigMap.authentication) {
        configForConfigMap.authentication = { ...configForConfigMap.authentication };
        delete configForConfigMap.authentication.credentials;
      }
      
      // Update ConfigMap
      const configMapName = `${name}-config`;
      
      // Get existing ConfigMap
      try {
        await this.kubernetesManager.getResource('configmap', configMapName);
      } catch (error) {
        throw new Error(`ConfigMap ${configMapName} not found: ${error.message}`);
      }
      
      // Create new ConfigMap manifest
      const configMapManifest = this.kubernetesManager.createManifest({
        kind: 'ConfigMap',
        name: configMapName,
        namespace: this.options.namespace,
        data: {
          'config.json': JSON.stringify(configForConfigMap, null, 2)
        }
      });
      
      // Update ConfigMap
      await this.kubernetesManager.deployManifest(configMapManifest);
      
      // Update credentials if provided
      if (config.authentication && config.authentication.credentials) {
        const secretName = `${name}-credentials`;
        
        // Check if secret exists
        let secretExists = false;
        try {
          await this.kubernetesManager.getResource('secret', secretName);
          secretExists = true;
        } catch (error) {
          this.log.warn(`Secret ${secretName} not found, creating new one`);
        }
        
        if (secretExists) {
          const secretData = {};
          
          // Format credentials based on authentication type
          switch (config.authentication.type) {
            case 'apiKey':
              secretData.apiKey = config.authentication.credentials.apiKey;
              break;
              
            case 'basic':
              secretData.username = config.authentication.credentials.username;
              secretData.password = config.authentication.credentials.password;
              break;
              
            case 'bearer':
              secretData.token = config.authentication.credentials.token;
              break;
              
            case 'oauth2':
              secretData.accessToken = config.authentication.credentials.accessToken;
              if (config.authentication.credentials.refreshToken) {
                secretData.refreshToken = config.authentication.credentials.refreshToken;
              }
              break;
          }
          
          // Create secret manifest
          const secretManifest = this.kubernetesManager.createManifest({
            kind: 'Secret',
            name: secretName,
            namespace: this.options.namespace,
            data: secretData
          });
          
          // Update secret
          await this.kubernetesManager.deployManifest(secretManifest);
        }
      }
      
      // Restart deployment to pick up config changes
      await this.kubernetesManager.restartDeployment(name);
      
      return {
        success: true,
        name,
        namespace: this.options.namespace,
        message: `Configuration updated and deployment restarted`
      };
    } catch (error) {
      this.log.error(`Failed to update OpenAPI plugin configuration: ${error.message}`);
      throw error;
    }
  }

  /**
   * Register Meteor methods
   */
  registerMeteorMethods() {
    Meteor.methods({
      'openapi.deployToKubernetes': async (config, deployOptions) => {
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        return await this.deployOpenAPIPlugin(config, deployOptions);
      },
      
      'openapi.deleteFromKubernetes': async (name) => {
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        return await this.deleteOpenAPIPlugin(name);
      },
      
      'openapi.getKubernetesStatus': async (name) => {
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        return await this.getOpenAPIPluginStatus(name);
      },
      
      'openapi.scaleKubernetesDeployment': async (name, replicas) => {
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        return await this.scaleOpenAPIPlugin(name, replicas);
      },
      
      'openapi.updateKubernetesConfig': async (name, config) => {
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        return await this.updateOpenAPIPluginConfig(name, config);
      }
    });
  }
}

module.exports = OpenAPIWizardKubernetesDeployer;
```


## 4. Now, let's create an updated onboarding script that includes Kubernetes setup:

```shell script
#!/bin/bash
# Path: /safeguard_system_onboarding.sh
# Written by Greg Deeds, Autonomy Association International, Inc.
# Copyright 2025 Autonomy Association International Inc., all rights reserved 
# Safeguard patent license from National Aeronautics and Space Administration (NASA)
# Copyright 2025 NASA, all rights reserved

# Shell script for onboarding a Linux system to the Safeguard network
# This script handles setup of various virtualization options and configures
# the system for Safeguard integration

set -e

# Color definitions for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Log function
log() {
  echo -e "${BLUE}[$(date +'%Y-%m-%d %H:%M:%S')]${NC} $1"
}

error() {
  echo -e "${RED}[ERROR]${NC} $1"
  exit 1
}

success() {
  echo -e "${GREEN}[SUCCESS]${NC} $1"
}

warning() {
  echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  error "This script must be run as root"
fi

# Function to check and install required packages
check_and_install_packages() {
  log "Checking for required packages..."
  
  PACKAGES="curl wget git jq apt-transport-https ca-certificates gnupg lsb-release"
  
  for pkg in $PACKAGES; do
    if ! command -v $pkg &> /dev/null; then
      log "Installing $pkg..."
      apt-get update && apt-get install -y $pkg || error "Failed to install $pkg"
    fi
  done
  
  success "All required packages are installed"
}

# Function to set up QEMU
setup_qemu() {
  log "Setting up QEMU..."
  
  apt-get update
  apt-get install -y qemu qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils || error "Failed to install QEMU packages"
  
  # Enable and start libvirtd service
  systemctl enable libvirtd
  systemctl start libvirtd
  
  success "QEMU setup completed"
}

# Function to set up Lima
setup_lima() {
  log "Setting up Lima..."
  
  # Check if Lima is already installed
  if command -v limactl &> /dev/null; then
    warning "Lima is already installed"
    return
  fi
  
  # Install Lima dependencies
  apt-get update
  apt-get install -y qemu-system bsd-mailx || error "Failed to install Lima dependencies"
  
  # Get the latest Lima release
  LATEST_RELEASE=$(curl -s https://api.github.com/repos/lima-vm/lima/releases/latest | jq -r '.tag_name')
  DOWNLOAD_URL="https://github.com/lima-vm/lima/releases/download/${LATEST_RELEASE}/lima-${LATEST_RELEASE:1}-Linux-x86_64.tar.gz"
  
  log "Downloading Lima ${LATEST_RELEASE}..."
  wget -q ${DOWNLOAD_URL} -O /tmp/lima.tar.gz || error "Failed to download Lima"
  
  # Extract and install Lima
  mkdir -p /tmp/lima
  tar -xzf /tmp/lima.tar.gz -C /tmp/lima
  
  # Install binaries
  cp /tmp/lima/bin/* /usr/local/bin/
  
  # Clean up
  rm -rf /tmp/lima /tmp/lima.tar.gz
  
  success "Lima setup completed"
}

# Function to set up Docker
setup_docker() {
  log "Setting up Docker..."
  
  # Check if Docker is already installed
  if command -v docker &> /dev/null; then
    warning "Docker is already installed"
    return
  fi
  
  # Install prerequisites
  apt-get update
  apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release || error "Failed to install Docker prerequisites"
  
  # Add Docker's official GPG key
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  
  # Set up the stable repository
  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
  
  # Install Docker Engine
  apt-get update
  apt-get install -y docker-ce docker-ce-cli containerd.io || error "Failed to install Docker"
  
  # Start and enable Docker service
  systemctl start docker
  systemctl enable docker
  
  # Create docker group and add current user
  groupadd -f docker
  read -p "Enter username to add to docker group: " USERNAME
  usermod -aG docker $USERNAME
  
  success "Docker setup completed. Please log out and log back in for group changes to take effect."
}

# Function to set up Podman
setup_podman() {
  log "Setting up Podman..."
  
  # Check if Podman is already installed
  if command -v podman &> /dev/null; then
    warning "Podman is already installed"
    return
  fi
  
  # Install Podman
  apt-get update
  apt-get install -y podman || error "Failed to install Podman"
  
  success "Podman setup completed"
}

# Function to setup EMU instance
setup_emu_instance() {
  log "Setting up EMU instance..."
  
  # Create a directory for EMU
  mkdir -p /opt/safeguard/emu
  
  # Download the EMU image (placeholder for actual download URL)
  log "Downloading EMU image..."
  # wget -q <URL> -O /opt/safeguard/emu/emu.img
  
  # Set up a simple config file
  cat > /opt/safeguard/emu/config.json << EOF
{
  "name": "safeguard-emu",
  "memory": "2G",
  "cpus": 2,
  "disk": "/opt/safeguard/emu/emu.img"
}
EOF
  
  success "EMU instance setup completed"
  log "You can start the EMU instance using appropriate commands based on your virtualization choice"
}

# Function to set up Kubernetes (Minikube)
setup_minikube() {
  log "Setting up Minikube (Kubernetes)..."
  
  # Check if Minikube is already installed
  if command -v minikube &> /dev/null; then
    warning "Minikube is already installed"
    return
  }
  
  # Install Minikube
  curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  install minikube-linux-amd64 /usr/local/bin/minikube
  rm minikube-linux-amd64
  
  # Install kubectl
  if ! command -v kubectl &> /dev/null; then
    log "Installing kubectl..."
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    rm kubectl
  fi
  
  # Set up bash completion for kubectl
  kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl > /dev/null
  
  success "Minikube installation completed"
  
  # Start Minikube
  log "Starting Minikube..."
  
  # Determine which driver to use (prefer the already set up virtualization)
  DRIVER="docker"
  if [ "$VIRTUALIZATION_CHOICE" == "3" ]; then  # QEMU
    DRIVER="kvm2"
  elif [ "$VIRTUALIZATION_CHOICE" == "1" ]; then  # Docker
    DRIVER="docker"
  elif [ "$VIRTUALIZATION_CHOICE" == "2" ]; then  # Podman
    DRIVER="podman"
  fi
  
  # Start Minikube with the selected driver
  sudo -u $USERNAME minikube start --driver=$DRIVER
  
  # Enable necessary addons
  sudo -u $USERNAME minikube addons enable ingress
  sudo -u $USERNAME minikube addons enable metrics-server
  
  success "Minikube started successfully with $DRIVER driver"
  log "Kubernetes is now available via kubectl"
}

# Function to set up K3s (lightweight Kubernetes)
setup_k3s() {
  log "Setting up K3s (lightweight Kubernetes)..."
  
  # Check if K3s is already installed
  if command -v k3s &> /dev/null; then
    warning "K3s is already installed"
    return
  }
  
  # Install K3s
  curl -sfL https://get.k3s.io | sh -
  
  # Set up kubectl symlink if not already present
  if ! command -v kubectl &> /dev/null; then
    ln -s /usr/local/bin/k3s /usr/local/bin/kubectl
  fi
  
  # Configure kubectl for non-root user
  mkdir -p /home/$USERNAME/.kube
  cp /etc/rancher/k3s/k3s.yaml /home/$USERNAME/.kube/config
  chown -R $USERNAME:$USERNAME /home/$USERNAME/.kube
  chmod 600 /home/$USERNAME/.kube/config
  
  # Export KUBECONFIG for the current session
  export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
  
  success "K3s setup completed"
  log "Kubernetes is now available via kubectl"
}

# Function to set up Cloudflare client tools
setup_cloudflare_tools() {
  log "Setting up Cloudflare tools..."
  
  # Install cloudflared
  if ! command -v cloudflared &> /dev/null; then
    log "Installing cloudflared..."
    
    # Add Cloudflare GPG key
    mkdir -p --mode=0755 /usr/share/keyrings
    curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | sudo tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null
    
    # Add the repository
    echo 'deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared focal main' | sudo tee /etc/apt/sources.list.d/cloudflared.list
    
    # Install cloudflared
    apt-get update
    apt-get install -y cloudflared
  else
    warning "cloudflared is already installed"
  fi
  
  success "Cloudflare tools setup completed"
}

# Main function
main() {
  log "Starting Safeguard system onboarding..."
  
  check_and_install_packages
  
  # Ask for username if not provided
  if [ -z "$USERNAME" ]; then
    read -p "Enter your username for tool configurations: " USERNAME
    if [ -z "$USERNAME" ] || ! id "$USERNAME" &>/dev/null; then
      error "Invalid username or user does not exist"
    fi
  fi
  
  # Interactive part - Ask for virtualization choice
  echo "Please select the virtualization technology to use:"
  echo "1. Docker"
  echo "2. Podman"
  echo "3. QEMU"
  echo "4. Lima"
  read -p "Enter your choice (1-4): " VIRTUALIZATION_CHOICE
  
  case $VIRTUALIZATION_CHOICE in
    1)
      setup_docker
      ;;
    2)
      setup_podman
      ;;
    3)
      setup_qemu
      ;;
    4)
      setup_lima
      ;;
    *)
      error "Invalid choice"
      ;;
  esac
  
  # Ask if Kubernetes should be set up
  echo "Would you like to set up Kubernetes?"
  echo "1. Yes, using Minikube (full Kubernetes)"
  echo "2. Yes, using K3s (lightweight Kubernetes)"
  echo "3. No, skip Kubernetes setup"
  read -p "Enter your choice (1-3): " K8S_CHOICE
  
  case $K8S_CHOICE in
    1)
      setup_minikube
      ;;
    2)
      setup_k3s
      ;;
    3)
      log "Skipping Kubernetes setup"
      ;;
    *)
      error "Invalid choice"
      ;;
  esac
  
  # Ask if Cloudflare tools should be installed
  echo "Would you like to install Cloudflare tools for Zero Trust tunnels?"
  echo "1. Yes"
  echo "2. No"
  read -p "Enter your choice (1-2): " CF_CHOICE
  
  if [ "$CF_CHOICE" == "1" ]; then
    setup_cloudflare_tools
  else
    log "Skipping Cloudflare tools installation"
  fi
  
  # Set up EMU instance
  setup_emu_instance
  
  # Set up Lima instance if selected
  if [ "$VIRTUALIZATION_CHOICE" == "4" ]; then
    log "Setting up Lima instance..."
    sudo -u $USERNAME limactl start --name=safeguard-lima default
    success "Lima instance started"
  fi
  
  success "Safeguard system onboarding completed successfully!"
  log "You can now proceed with configuring the Safeguard services"
  
  # Display summary
  echo
  echo "=========== SYSTEM SETUP SUMMARY ==========="
  echo "Virtualization: $(case $VIRTUALIZATION_CHOICE in 1) echo "Docker";; 2) echo "Podman";; 3) echo "QEMU";; 4) echo "Lima";; esac)"
  echo "Kubernetes: $(case $K8S_CHOICE in 1) echo "Minikube";; 2) echo "K3s";; 3) echo "Not installed";; esac)"
  echo "Cloudflare tools: $([ "$CF_CHOICE" == "1" ] && echo "Installed" || echo "Not installed")"
  echo "EMU instance configured: Yes"
  echo "Lima instance: $([ "$VIRTUALIZATION_CHOICE" == "4" ] && echo "Started" || echo "Not applicable")"
  echo "===========================================" 
}

# Run the main function
main
```


## 5. Finally, let's create a CloudflareZeroTrustController that integrates with Kubernetes:

```javascript
// Path: /private/plugin/modules/CloudflareZeroTrustController.js
// Written by Greg Deeds, Autonomy Association International, Inc.
// Copyright 2025 Autonomy Association International Inc., all rights reserved 
// Safeguard patent license from National Aeronautics and Space Administration (NASA)
// Copyright 2025 NASA, all rights reserved

/**
 * CloudflareZeroTrustController
 * 
 * Controller for managing Cloudflare Zero Trust tunnels with Kubernetes integration
 * Manages automatic tunnel creation and cleanup for Kubernetes services
 */

const CloudflareZeroTrustManager = require('./CloudflareZeroTrustManager');
const CloudflareDNSManager = require('./CloudflareDNSManager');
const KubernetesManager = require('./KubernetesManager');
const fs = require('fs').promises;
const path = require('path');
const crypto = require('crypto');
const yaml = require('js-yaml');
const { v4: uuidv4 } = require('uuid');

class CloudflareZeroTrustController {
  /**
   * Create a new CloudflareZeroTrustController
   * @param {Object} options - Controller options
   * @param {string} options.accountId - Cloudflare account ID
   * @param {string} options.apiToken - Cloudflare API token
   * @param {string} options.zoneName - Cloudflare zone name
   * @param {string} options.rootDomain - Root domain for DNS records
   * @param {string} options.namespace - Kubernetes namespace
   * @param {string} options.kubeconfig - Path to kubeconfig file
   * @param {boolean} options.createIngress - Whether to create Kubernetes ingress resources
   * @param {string} options.ingressClass - Ingress class to use
   */
  constructor(options = {}) {
    this.options = {
      accountId: options.accountId || process.env.CF_ACCOUNT_ID,
      apiToken: options.apiToken || process.env.CF_API_TOKEN,
      zoneName: options.zoneName || process.env.CF_ZONE_NAME,
      rootDomain: options.rootDomain || process.env.ROOT_DOMAIN,
      namespace: options.namespace || process.env.KUBERNETES_NAMESPACE || 'default',
      kubeconfig: options.kubeconfig || process.env.KUBECONFIG,
      secretPath: options.secretPath || '/tmp/cloudflare-secrets',
      createIngress: options.createIngress === true || process.env.CREATE_INGRESS === 'true',
      ingressClass: options.ingressClass || process.env.INGRESS_CLASS || 'nginx',
      teamName: options.teamName || process.env.CF_TEAM_NAME,
      instanceId: options.instanceId || process.env.INSTANCE_ID || uuidv4(),
      instanceRole: options.instanceRole || process.env.INSTANCE_ROLE || 'core',
      ...options
    };
    
    // Required options validation
    if (!this.options.accountId) throw new Error('Cloudflare account ID is required');
    if (!this.options.apiToken) throw new Error('Cloudflare API token is required');
    if (!this.options.zoneName && !this.options.zoneId) throw new Error('Cloudflare zone name or ID is required');
    if (!this.options.rootDomain) throw new Error('Root domain is required');
    
    this.tunnelManagers = new Map();
    this.dnsManager = null;
    this.kubernetesManager = null;
    this.watchers = [];
    this.initialized = false;
    
    this.log = {
      info: (msg) => console.log(`[ZeroTrustController:INFO] ${msg}`),
      warn: (msg) => console.warn(`[ZeroTrustController:WARN] ${msg}`),
      error: (msg) => console.error(`[ZeroTrustController:ERROR] ${msg}`),
      debug: (msg) => console.debug(`[ZeroTrustController:DEBUG] ${msg}`)
    };
  }

  /**
   * Initialize the controller
   * @returns {Promise<void>}
   */
  async initialize() {
    if (this.initialized) return;
    
    try {
      this.log.info('Initializing CloudflareZeroTrustController...');
      
      // Create secret path directory if it doesn't exist
      try {
        await fs.mkdir(this.options.secretPath, { recursive: true });
      } catch (error) {
        this.log.warn(`Failed to create secret path directory: ${error.message}`);
      }
      
      // Initialize DNS manager
      this.dnsManager = new CloudflareDNSManager({
        accountId: this.options.accountId,
        apiToken: this.options.apiToken,
        zoneName: this.options.zoneName,
        zoneId: this.options.zoneId,
        rootDomain: this.options.rootDomain,
        instanceId: this.options.instanceId,
        instanceRole: this.options.instanceRole
      });
      
      await this.dnsManager.initialize();
      
      // Initialize Kubernetes manager if needed
      if (this.options.kubeconfig || process.env.KUBERNETES_SERVICE_HOST) {
        this.kubernetesManager = new KubernetesManager({
          kubeconfig: this.options.kubeconfig,
          namespace: this.options.namespace
        });
        
        await this.kubernetesManager.initialize();
        
        // Start watching Kubernetes services
        await this.startServiceWatcher();
      } else {
        this.log.warn('Kubernetes integration not enabled (no kubeconfig or not in cluster)');
      }
      
      this.initialized = true;
      this.log.info('CloudflareZeroTrustController initialized successfully');
    } catch (error) {
      this.log.error(`Failed to initialize CloudflareZeroTrustController: ${error.message}`);
      throw error;
    }
  }

  /**
   * Start watching Kubernetes services
   * @returns {Promise<void>}
   * @private
   */
  async startServiceWatcher() {
    if (!this.kubernetesManager) return;
    
    try {
      this.log.info('Starting Kubernetes service watcher...');
      
      // Get initial list of services
      const services = await this.kubernetesManager.listResources('service', {
        labelSelector: 'cloudflare-tunnel=enabled'
      });
      
      if (services.resources && services.resources.items) {
        this.log.info(`Found ${services.resources.items.length} services with Cloudflare tunnel enabled`);
        
        // Process existing services
        for (const service of services.resources.items) {
          await this.processService(service);
        }
      }
      
      // Set up a periodic check for services
      // In a production environment, this would use the Kubernetes watch API
      // but for simplicity, we'll use a polling approach here
      const watchInterval = setInterval(async () => {
        try {
          const services = await this.kubernetesManager.listResources('service', {
            labelSelector: 'cloudflare-tunnel=enabled'
          });
          
          if (services.resources && services.resources.items) {
            for (const service of services.resources.items) {
              await this.processService(service);
            }
          }
        } catch (error) {
          this.log.error(`Error watching services: ${error.message}`);
        }
      }, 30000); // Check every 30 seconds
      
      this.watchers.push(watchInterval);
      
      this.log.info('Kubernetes service watcher started');
    } catch (error) {
      this.log.error(`Failed to start service watcher: ${error.message}`);
      throw error;
    }
  }

  /**
   * Process a Kubernetes service
   * @param {Object} service - Kubernetes service object
   * @returns {Promise<void>}
   * @private
   */
  async processService(service) {
    try {
      const name = service.metadata.name;
      const namespace = service.metadata.namespace;
      const labels = service.metadata.labels || {};
      const annotations = service.metadata.annotations || {};
      
      // Check if this service should have a tunnel
      if (labels['cloudflare-tunnel'] !== 'enabled') {
        return;
      }
      
      // Generate a tunnel name based on service
      const tunnelName = annotations['cloudflare.com/tunnel-name'] || 
        `${namespace}-${name}-${crypto.randomBytes(4).toString('hex')}`;
      
      // Check if we already have a tunnel for this service
      if (this.tunnelManagers.has(`${namespace}/${name}`)) {
        this.log.debug(`Tunnel already exists for service ${namespace}/${name}`);
        return;
      }
      
      // Get hostname from annotations or generate one
      const hostname = annotations['cloudflare.com/hostname'] || 
        `${name}.${namespace}.${this.options.rootDomain}`;
      
      // Determine service target
      let serviceTarget;
      
      if (this.kubernetesManager.options.inCluster) {
        // If we're running inside the cluster, use the cluster IP
        serviceTarget = `http://${service.spec.clusterIP}`;
        
        // Add port if available
        if (service.spec.ports && service.spec.ports.length > 0) {
          serviceTarget += `:${service.spec.ports[0].port}`;
        }
      } else {
        // If we're running outside the cluster, use port-forwarding
        const portForward = await this.kubernetesManager.portForwardToPod(
          `service/${name}`,
          8000,
          service.spec.ports[0].port,
          { namespace }
        );
        
        serviceTarget = `http://localhost:8000`;
      }
      
      // Create Cloudflare tunnel
      this.log.info(`Creating Cloudflare tunnel for service ${namespace}/${name} with hostname ${hostname}`);
      
      const tunnelManager = new CloudflareZeroTrustManager({
        accountId: this.options.accountId,
        apiToken: this.options.apiToken,
        zoneName: this.options.zoneName,
        zoneId: this.options.zoneId,
        tunnelName,
        teamName: this.options.teamName,
        services: [
          {
            hostname,
            service: serviceTarget
          }
        ],
        secretPath: this.options.secretPath,
        authRequired: annotations['cloudflare.com/auth-required'] === 'true',
        mfaRequired: annotations['cloudflare.com/mfa-required'] === 'true',
        fidoPreferred: annotations['cloudflare.com/fido-preferred'] === 'true'
      });
      
      await tunnelManager.initialize();
      await tunnelManager.createDnsRecord(hostname);
      await tunnelManager.startTunnel();
      
      // Store the tunnel manager
      this.tunnelManagers.set(`${namespace}/${name}`, {
        tunnelManager,
        serviceKey: `${namespace}/${name}`,
        hostname,
        tunnelName,
        createdAt: new Date()
      });
      
      this.log.info(`Tunnel created and started for service ${namespace}/${name}`);
      
      // Create Kubernetes ingress if requested
      if (this.options.createIngress) {
        await this.createKubernetesIngress(service, hostname);
      }
      
      // Register as core or supercore if needed
      if (this.options.instanceRole === 'supercore') {
        await this.dnsManager.registerAsSupercore(`https://${hostname}`);
      } else {
        await this.dnsManager.registerAsCore(`https://${hostname}`);
      }
    } catch (error) {
      this.log.error(`Failed to process service: ${error.message}`);
      // Don't throw, as this is called in a loop
    }
  }

  /**
   * Create Kubernetes ingress resource
   * @param {Object} service - Kubernetes service object
   * @param {string} hostname - Hostname for the ingress
   * @returns {Promise<void>}
   * @private
   */
  async createKubernetesIngress(service, hostname) {
    if (!this.kubernetesManager) return;
    
    try {
      const name = service.metadata.name;
      const namespace = service.metadata.namespace;
      
      // Check if ingress already exists
      try {
        await this.kubernetesManager.getResource('ingress', name, { namespace });
        this.log.debug(`Ingress ${namespace}/${name} already exists`);
        return;
      } catch (error) {
        // Ingress doesn't exist, continue
      }
      
      // Create ingress manifest
      const ingressManifest = {
        apiVersion: 'networking.k8s.io/v1',
        kind: 'Ingress',
        metadata: {
          name,
          namespace,
          labels: {
            app: name,
            'managed-by': 'cloudflare-zero-trust-controller'
          },
          annotations: {
            'kubernetes.io/ingress.class': this.options.ingressClass,
            'cloudflare.com/hostname': hostname
          }
        },
        spec: {
          rules: [
            {
              host: hostname,
              http: {
                paths: [
                  {
                    path: '/',
                    pathType: 'Prefix',
                    backend: {
                      service: {
                        name,
                        port: {
                          number: service.spec.ports[0].port
                        }
                      }
                    }
                  }
                ]
              }
            }
          ]
        }
      };
      
      // Deploy ingress
      this.log.info(`Creating Kubernetes ingress for service ${namespace}/${name}`);
      await this.kubernetesManager.deployManifest(ingressManifest);
      
      this.log.info(`Ingress created for service ${namespace}/${name}`);
    } catch (error) {
      this.log.error(`Failed to create ingress: ${error.message}`);
      throw error;
    }
  }

  /**
   * Create a tunnel for a service
   * @param {Object} options - Tunnel options
   * @param {string} options.name - Service name
   * @param {string} options.namespace - Service namespace
   * @param {string} options.hostname - Hostname
   * @param {string} options.service - Service target
   * @returns {Promise<Object>} Tunnel information
   */
  async createTunnel(options) {
    if (!this.initialized) await this.initialize();
    
    try {
      const {
        name,
        namespace = this.options.namespace,
        hostname,
        service
      } = options;
      
      // Check if we already have a tunnel for this service
      if (this.tunnelManagers.has(`${namespace}/${name}`)) {
        this.log.warn(`Tunnel already exists for service ${namespace}/${name}`);
        return this.tunnelManagers.get(`${namespace}/${name}`);
      }
      
      // Generate a tunnel name
      const tunnelName = `${namespace}-${name}-${crypto.randomBytes(4).toString('hex')}`;
      
      // Create Cloudflare tunnel
      this.log.info(`Creating Cloudflare tunnel for service ${namespace}/${name} with hostname ${hostname}`);
      
      const tunnelManager = new CloudflareZeroTrustManager({
        accountId: this.options.accountId,
        apiToken: this.options.apiToken,
        zoneName: this.options.zoneName,
        zoneId: this.options.zoneId,
        tunnelName,
        teamName: this.options.teamName,
        services: [
          {
            hostname,
            service
          }
        ],
        secretPath: this.options.secretPath
      });
      
      await tunnelManager.initialize();
      await tunnelManager.createDnsRecord(hostname);
      await tunnelManager.startTunnel();
      
      // Store the tunnel manager
      const tunnelInfo = {
        tunnelManager,
        serviceKey: `${namespace}/${name}`,
        hostname,
        tunnelName,
        tunnelId: tunnelManager.config.tunnelId,
        createdAt: new Date()
      };
      
      this.tunnelManagers.set(`${namespace}/${name}`, tunnelInfo);
      
      this.log.info(`Tunnel created and started for service ${namespace}/${name}`);
      
      return tunnelInfo;
    } catch (error) {
      this.log.error(`Failed to create tunnel: ${error.message}`);
      throw error;
    }
  }

  /**
   * Delete a tunnel
   * @param {string} name - Service name
   * @param {string} namespace - Service namespace
   * @returns {Promise<boolean>} Success status
   */
  async deleteTunnel(name, namespace = this.options.namespace) {
    if (!this.initialized) await this.initialize();
    
    try {
      const serviceKey = `${namespace}/${name}`;
      
      // Check if we have a tunnel for this service
      if (!this.tunnelManagers.has(serviceKey)) {
        this.log.warn(`No tunnel found for service ${serviceKey}`);
        return false;
      }
      
      const tunnelInfo = this.tunnelManagers.get(serviceKey);
      
      // Stop and delete the tunnel
      this.log.info(`Deleting tunnel for service ${serviceKey}`);
      
      await tunnelInfo.tunnelManager.stopTunnel();
      await tunnelInfo.tunnelManager.deleteTunnel();
      
      // Remove from tunnelManagers
      this.tunnelManagers.delete(serviceKey);
      
      this.log.info(`Tunnel deleted for service ${serviceKey}`);
      
      return true;
    } catch (error) {
      this.log.error(`Failed to delete tunnel: ${error.message}`);
      throw error;
    }
  }

  /**
   * Get all active tunnels
   * @returns {Array<Object>} Tunnel information
   */
  getTunnels() {
    const tunnels = [];
    
    for (const [serviceKey, tunnelInfo] of this.tunnelManagers.entries()) {
      tunnels.push({
        serviceKey: tunnelInfo.serviceKey,
        hostname: tunnelInfo.hostname,
        tunnelName: tunnelInfo.tunnelName,
        tunnelId: tunnelInfo.tunnelManager.config.tunnelId,
        createdAt: tunnelInfo.createdAt
      });
    }
    
    return tunnels;
  }

  /**
   * Get tunnel status
   * @param {string} name - Service name
   * @param {string} namespace - Service namespace
   * @returns {Promise<Object>} Tunnel status
   */
  async getTunnelStatus(name, namespace = this.options.namespace) {
    if (!this.initialized) await this.initialize();
    
    try {
      const serviceKey = `${namespace}/${name}`;
      
      // Check if we have a tunnel for this service
      if (!this.tunnelManagers.has(serviceKey)) {
        throw new Error(`No tunnel found for service ${serviceKey}`);
      }
      
      const tunnelInfo = this.tunnelManagers.get(serviceKey);
      
      // Get tunnel status
      const status = await tunnelInfo.tunnelManager.getTunnelStatus();
      
      return {
        serviceKey,
        hostname: tunnelInfo.hostname,
        tunnelName: tunnelInfo.tunnelName,
        tunnelId: tunnelInfo.tunnelManager.config.tunnelId,
        status,
        createdAt: tunnelInfo.createdAt
      };
    } catch (error) {
      this.log.error(`Failed to get tunnel status: ${error.message}`);
      throw error;
    }
  }

  /**
   * Create a Kubernetes manifest for deploying a service with Cloudflare tunnel
   * @param {Object} options - Manifest options
   * @returns {Object} Kubernetes manifest
   */
  createKubernetesManifest(options) {
    try {
      const {
        name,
        namespace = this.options.namespace,
        image,
        hostname = `${name}.${this.options.rootDomain}`,
        port = 80,
        replicas = 1,
        env = {},
        labels = {},
        annotations = {},
        authRequired = false,
        mfaRequired = false,
        fidoPreferred = true
      } = options;
      
      // Combine labels
      const serviceLabels = {
        app: name,
        'cloudflare-tunnel': 'enabled',
        ...labels
      };
      
      // Combine annotations
      const serviceAnnotations = {
        'cloudflare.com/hostname': hostname,
        'cloudflare.com/auth-required': authRequired.toString(),
        'cloudflare.com/mfa-required': mfaRequired.toString(),
        'cloudflare.com/fido-preferred': fidoPreferred.toString(),
        ...annotations
      };
      
      // Create deployment manifest
      const deployment = {
        apiVersion: 'apps/v1',
        kind: 'Deployment',
        metadata: {
          name,
          namespace,
          labels: serviceLabels
        },
        spec: {
          replicas,
          selector: {
            matchLabels: {
              app: name
            }
          },
          template: {
            metadata: {
              labels: {
                app: name
              }
            },
            spec: {
              containers: [
                {
                  name,
                  image,
                  ports: [
                    {
                      containerPort: port,
                      name: 'http'
                    }
                  ],
                  env: Object.entries(env).map(([name, value]) => ({
                    name,
                    value: String(value)
                  }))
                }
              ]
            }
          }
        }
      };
      
      // Create service manifest
      const service = {
        apiVersion: 'v1',
        kind: 'Service',
        metadata: {
          name,
          namespace,
          labels: serviceLabels,
          annotations: serviceAnnotations
        },
        spec: {
          selector: {
            app: name
          },
          ports: [
            {
              port,
              targetPort: port,
              name: 'http'
            }
          ],
          type: 'ClusterIP'
        }
      };
      
      return {
        deployment,
        service
      };
    } catch (error) {
      this.log.error(`Failed to create Kubernetes manifest: ${error.message}`);
      throw error;
    }
  }

  /**
   * Deploy a service with Cloudflare tunnel
   * @param {Object} options - Deployment options
   * @returns {Promise<Object>} Deployment result
   */
  async deployService(options) {
    if (!this.initialized) await this.initialize();
    if (!this.kubernetesManager) {
      throw new Error('Kubernetes integration not enabled');
    }
    
    try {
      // Create Kubernetes manifests
      const manifests = this.createKubernetesManifest(options);
      
      // Deploy deployment
      this.log.info(`Deploying Kubernetes deployment ${options.name}`);
      await this.kubernetesManager.deployManifest(manifests.deployment);
      
      // Deploy service
      this.log.info(`Deploying Kubernetes service ${options.name}`);
      await this.kubernetesManager.deployManifest(manifests.service);
      
      // Wait for service to be created
      await new Promise(resolve => setTimeout(resolve, 2000));
      
      // Process the service (create tunnel)
      const service = await this.kubernetesManager.getResource('service', options.name, {
        namespace: options.namespace || this.options.namespace
      });
      
      await this.processService(service.resource);
      
      return {
        success: true,
        name: options.name,
        namespace: options.namespace || this.options.namespace,
        hostname: options.hostname || `${options.name}.${this.options.rootDomain}`
      };
    } catch (error) {
      this.log.error(`Failed to deploy service: ${error.message}`);
      throw error;
    }
  }

  /**
   * Register as a supercore
   * @param {string} url - Supercore URL
   * @returns {Promise<boolean>} Success status
   */
  async registerAsSupercore(url) {
    if (!this.initialized) await this.initialize();
    
    try {
      return await this.dnsManager.registerAsSupercore(url);
    } catch (error) {
      this.log.error(`Failed to register as supercore: ${error.message}`);
      throw error;
    }
  }

  /**
   * Register as a core
   * @param {string} url - Core URL
   * @returns {Promise<boolean>} Success status
   */
  async registerAsCore(url) {
    if (!this.initialized) await this.initialize();
    
    try {
      return await this.dnsManager.registerAsCore(url);
    } catch (error) {
      this.log.error(`Failed to register as core: ${error.message}`);
      throw error;
    }
  }

  /**
   * Check if supercore exists
   * @returns {Promise<boolean>} Whether supercore exists
   */
  async checkSupercoreExists() {
    if (!this.initialized) await this.initialize();
    
    try {
      return await this.dnsManager.checkSupercoreExists();
    } catch (error) {
      this.log.error(`Failed to check supercore: ${error.message}`);
      throw error;
    }
  }

  /**
   * Get all core instances
   * @returns {Promise<Array>} Core instances
   */
  async getAllCores() {
    if (!this.initialized) await this.initialize();
    
    try {
      return await this.dnsManager.getAllCores();
    } catch (error) {
      this.log.error(`Failed to get core instances: ${error.message}`);
      throw error;
    }
  }

  /**
   * Unregister instance
   * @returns {Promise<boolean>} Success status
   */
  async unregister() {
    if (!this.initialized) await this.initialize();
    
    try {
      return await this.dnsManager.unregister();
    } catch (error) {
      this.log.error(`Failed to unregister: ${error.message}`);
      throw error;
    }
  }

  /**
   * Close and clean up resources
   * @returns {Promise<void>}
   */
  async close() {
    if (!this.initialized) return;
    
    try {
      this.log.info('Closing CloudflareZeroTrustController...');
      
      // Stop watchers
      for (const watcher of this.watchers) {
        clearInterval(watcher);
      }
      this.watchers = [];
      
      // Stop and delete all tunnels
      for (const [serviceKey, tunnelInfo] of this.tunnelManagers.entries()) {
        this.log.info(`Stopping tunnel for ${serviceKey}`);
        try {
          await tunnelInfo.tunnelManager.stopTunnel();
          await tunnelInfo.tunnelManager.deleteTunnel();
        } catch (error) {
          this.log.warn(`Error stopping tunnel for ${serviceKey}: ${error.message}`);
        }
      }
      
      this.tunnelManagers.clear();
      
      // Unregister from DNS
      if (this.dnsManager) {
        try {
          await this.dnsManager.unregister();
        } catch (error) {
          this.log.warn(`Error unregistering from DNS: ${error.message}`);
        }
      }
      
      // Close Kubernetes manager
      if (this.kubernetesManager) {
        await this.kubernetesManager.close();
      }
      
      this.initialized = false;
      this.log.info('CloudflareZeroTrustController closed successfully');
    } catch (error) {
      this.log.error(`Failed to close CloudflareZeroTrustController: ${error.message}`);
      throw error;
    }
  }

  /**
   * Register Meteor methods
   */
  registerMeteorMethods() {
    Meteor.methods({
      'cloudflare.createTunnel': async (options) => {
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        return await this.createTunnel(options);
      },
      
      'cloudflare.deleteTunnel': async (name, namespace) => {
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        return await this.deleteTunnel(name, namespace);
      },
      
      'cloudflare.getTunnels': () => {
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        return this.getTunnels();
      },
      
      'cloudflare.getTunnelStatus': async (name, namespace) => {
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        return await this.getTunnelStatus(name, namespace);
      },
      
      'cloudflare.deployService': async (options) => {
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        return await this.deployService(options);
      },
      
      'cloudflare.registerAsSupercore': async (url) => {
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        return await this.registerAsSupercore(url);
      },
      
      'cloudflare.registerAsCore': async (url) => {
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        return await this.registerAsCore(url);
      },
      
      'cloudflare.checkSupercoreExists': async () => {
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        return await this.checkSupercoreExists();
      },
      
      'cloudflare.getAllCores': async () => {
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        return await this.getAllCores();
      },
      
      'cloudflare.unregister': async () => {
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        return await this.unregister();
      }
    });
  }
}

module.exports = CloudflareZeroTrustController;
```


## Summary of Changes and Improvements

I've made comprehensive updates to the system with a focus on enhancing Kubernetes support and ensuring consistent copyright notices across all files. Here's a summary of the key changes:

1. **Enhanced OCI Implementation with Kubernetes Support**:
    - Created a robust `OCIContainerManager.js` that integrates both Docker/Podman and Kubernetes operations
    - Added comprehensive Kubernetes functions for deployment, scaling, and management
    - Included proper error handling, logging, and resource cleanup

2. **Dedicated Kubernetes Manager**:
    - Implemented a complete `KubernetesManager.js` with advanced Kubernetes operations
    - Added MongoDB integration for state persistence
    - Included support for deployments, services, ingress resources, and more
    - Added comprehensive port forwarding and pod management capabilities

3. **OpenAPI Wizard Kubernetes Integration**:
    - Created `OpenAPIWizardKubernetesDeployer.js` to deploy OpenAPI plugins to Kubernetes
    - Added support for ConfigMaps, Secrets, and Ingress resources
    - Implemented monitoring and status tracking for deployed plugins

4. **Enhanced Cloudflare Zero Trust Integration**:
    - Implemented `CloudflareZeroTrustController.js` to manage Cloudflare tunnels with Kubernetes
    - Added service watcher to automatically create tunnels for labeled services
    - Integrated DNS management for core/supercore discovery
    - Added support for proper FIDO MFA and zero trust principles

5. **Improved System Onboarding**:
    - Updated `safeguard_system_onboarding.sh` to include Kubernetes setup options
    - Added support for both Minikube and K3s for different deployment scenarios
    - Added Cloudflare tools installation for zero trust tunnels
    - Improved error handling and user feedback

6. **Consistent Copyright Notices**:
    - Added consistent copyright notices to all files with the full file path
    - Used the format from `CopyrightNotice2.js` to maintain consistency

These improvements make the system much more robust, with proper Kubernetes integration and enhanced security through zero trust principles. The code now provides a solid foundation for deploying, managing, and securing applications in both containerized and Kubernetes environments.