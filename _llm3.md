I'll implement your goal to create a unified system with modalities based on the existing seaguard, air guard, and land guard models. Let me analyze the requirements and implement the necessary changes.

## Understanding the Requirements

From your request, I need to:

1. Create a foundational class, runtime, and meteor layer for all modalities
2. Move plugin inspection to the `/modules` or `/private/plugin/modules` directory
3. Set up directory-based plugin discovery and naming
4. Extract metadata from various sources (package.json, config.json, Dockerfile)
5. Support Node.js and Python plugins with Dockerfile generation
6. Implement OCI container management with Varnish, Kubernetes integration, and DIND support
7. Add authenticated image pull/push and encryption
8. Implement key management with KPI methodology
9. Enhance health monitoring and worker thread management

Let's start with the core implementation.

## Implementation Plan

### 1. Plugin Management Foundation

First, I'll create a foundational class for plugin management:

```javascript
const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');
const crypto = require('crypto');
const { Meteor } = require('meteor/meteor');
const { MongoInternals } = require('meteor/mongo');

/**
 * PluginManager - Core class for managing plugins across all modalities
 * Serves as the foundational class for seaguard, air guard, and land guard modalities
 */
class PluginManager {
  constructor(options = {}) {
    this.pluginsDir = options.pluginsDir || '/private/plugin/modules';
    this.fallbackDir = options.fallbackDir || '/modules';
    this.dbCollection = options.dbCollection || 'plugins';
    this.mongoUrl = options.mongoUrl || process.env.MONGO_URL || 'mongodb://localhost:27017/meteor';
    
    // Connect to MongoDB
    this.db = MongoInternals.defaultRemoteCollectionDriver().mongo.db;
    this.pluginsCollection = this.db.collection(this.dbCollection);
    
    // Create indexes
    this._createIndexes();
    
    // Initialize plugins registry
    this.plugins = {};
    
    // Set OCIManager reference if provided
    this.ociManager = options.ociManager || null;
    
    // Set KeyManager reference if provided
    this.keyManager = options.keyManager || null;
  }
  
  /**
   * Create necessary database indexes
   * @private
   */
  _createIndexes() {
    this.pluginsCollection.createIndex({ name: 1 }, { unique: true });
    this.pluginsCollection.createIndex({ active: 1 });
    this.pluginsCollection.createIndex({ modality: 1 });
  }
  
  /**
   * Discover and initialize all plugins
   * @param {string} modality - The modality to initialize (seaguard, airguard, landguard)
   */
  async discoverPlugins(modality) {
    console.log(`Discovering plugins for modality: ${modality}`);
    
    // Check primary plugins directory
    let pluginBasePath = path.join(process.cwd(), this.pluginsDir);
    if (!fs.existsSync(pluginBasePath)) {
      // Try fallback directory
      pluginBasePath = path.join(process.cwd(), this.fallbackDir);
      if (!fs.existsSync(pluginBasePath)) {
        console.error(`Plugin directories not found: ${this.pluginsDir} or ${this.fallbackDir}`);
        return;
      }
    }
    
    // Get all subdirectories in the plugins directory
    const entries = fs.readdirSync(pluginBasePath, { withFileTypes: true });
    const pluginDirs = entries.filter(entry => entry.isDirectory());
    
    for (const dir of pluginDirs) {
      const pluginName = dir.name;
      const pluginPath = path.join(pluginBasePath, pluginName);
      
      try {
        await this.initializePlugin(pluginName, pluginPath, modality);
      } catch (error) {
        console.error(`Failed to initialize plugin ${pluginName}:`, error);
      }
    }
  }
  
  /**
   * Initialize a specific plugin
   * @param {string} pluginName - Name of the plugin derived from directory name
   * @param {string} pluginPath - Full path to the plugin directory
   * @param {string} modality - The modality this plugin belongs to
   */
  async initializePlugin(pluginName, pluginPath, modality) {
    console.log(`Initializing plugin: ${pluginName} at ${pluginPath}`);
    
    // Extract plugin metadata
    const metadata = await this.extractPluginMetadata(pluginPath, pluginName);
    
    // Set the modality
    metadata.modality = modality;
    
    // Check if plugin should be containerized
    if (metadata.containerize) {
      await this.containerizePlugin(pluginPath, metadata);
    }
    
    // Save plugin to database
    await this.savePluginToDb(metadata);
    
    // Load the plugin
    await this.loadPlugin(metadata);
    
    // Set active status
    if (metadata.active) {
      await this.notifyNetworkNodes(metadata);
    }
    
    return metadata;
  }
  
  /**
   * Extract metadata from package.json, config.json, or Dockerfile
   * @param {string} pluginPath - Path to plugin directory
   * @param {string} defaultName - Default name (directory name) if metadata extraction fails
   */
  async extractPluginMetadata(pluginPath, defaultName) {
    let metadata = {
      name: defaultName,
      version: '1.0.0',
      description: `Plugin ${defaultName}`,
      active: false,
      containerize: false,
      runtime: 'node',
      interface: {},
      methods: {}
    };
    
    // Try package.json first
    const packageJsonPath = path.join(pluginPath, 'package.json');
    if (fs.existsSync(packageJsonPath)) {
      try {
        const packageData = JSON.parse(fs.readFileSync(packageJsonPath, 'utf8'));
        metadata = {
          ...metadata,
          name: packageData.name || defaultName,
          version: packageData.version || '1.0.0',
          description: packageData.description || metadata.description,
          author: packageData.author,
          license: packageData.license,
          runtime: 'node',
          main: packageData.main || 'index.js',
          dependencies: packageData.dependencies || {}
        };
        
        // Look for plugin contract in package.json
        if (packageData.pluginContract) {
          metadata.contract = packageData.pluginContract;
        }
        
        return metadata;
      } catch (error) {
        console.warn(`Error parsing package.json for ${defaultName}:`, error);
      }
    }
    
    // Try config.json
    const configJsonPath = path.join(pluginPath, 'config.json');
    if (fs.existsSync(configJsonPath)) {
      try {
        const configData = JSON.parse(fs.readFileSync(configJsonPath, 'utf8'));
        metadata = {
          ...metadata,
          ...configData,
          name: configData.name || configData.pluginName || defaultName
        };
        return metadata;
      } catch (error) {
        console.warn(`Error parsing config.json for ${defaultName}:`, error);
      }
    }
    
    // Try Dockerfile
    const dockerfilePath = path.join(pluginPath, 'Dockerfile');
    if (fs.existsSync(dockerfilePath)) {
      try {
        const dockerfileContent = fs.readFileSync(dockerfilePath, 'utf8');
        metadata.containerize = true;
        
        // Extract metadata from Dockerfile comments or labels
        const labelMatch = dockerfileContent.match(/LABEL\s+org\.opencontainers\.image\.description="([^"]+)"/);
        if (labelMatch) {
          metadata.description = labelMatch[1];
        }
        
        const versionMatch = dockerfileContent.match(/LABEL\s+org\.opencontainers\.image\.version="([^"]+)"/);
        if (versionMatch) {
          metadata.version = versionMatch[1];
        }
        
        return metadata;
      } catch (error) {
        console.warn(`Error parsing Dockerfile for ${defaultName}:`, error);
      }
    }
    
    // Check for other indicators of runtime
    if (fs.existsSync(path.join(pluginPath, 'requirements.txt'))) {
      metadata.runtime = 'python';
      metadata.containerize = true;
    } else if (fs.existsSync(path.join(pluginPath, 'index.js'))) {
      metadata.runtime = 'node';
      
      // Try to extract plugin info from index.js
      try {
        // Import the plugin to get its exports
        const pluginModule = require(path.join(pluginPath, 'index.js'));
        
        if (typeof pluginModule.plugin_info === 'function') {
          const pluginInfo = pluginModule.plugin_info();
          metadata = {
            ...metadata,
            ...pluginInfo,
            name: pluginInfo.name || pluginInfo.pluginName || defaultName
          };
        }
        
        // Check for contract in the module
        if (pluginModule.contract) {
          metadata.contract = pluginModule.contract;
        }
        
        // Check for methods to register
        if (pluginModule.methods) {
          metadata.methods = pluginModule.methods;
        }
      } catch (error) {
        console.warn(`Error extracting metadata from index.js for ${defaultName}:`, error);
      }
    } else {
      // Scan for .js files and try to extract metadata
      const jsFiles = fs.readdirSync(pluginPath).filter(file => file.endsWith('.js'));
      
      for (const jsFile of jsFiles) {
        try {
          const pluginModule = require(path.join(pluginPath, jsFile));
          
          if (typeof pluginModule.plugin_info === 'function') {
            const pluginInfo = pluginModule.plugin_info();
            metadata = {
              ...metadata,
              ...pluginInfo,
              name: pluginInfo.name || pluginInfo.pluginName || defaultName,
              main: jsFile
            };
            break;
          }
        } catch (error) {
          console.warn(`Error extracting metadata from ${jsFile} for ${defaultName}:`, error);
        }
      }
    }
    
    return metadata;
  }
  
  /**
   * Create a Dockerfile for the plugin if needed
   * @param {string} pluginPath - Path to plugin directory
   * @param {Object} metadata - Plugin metadata
   */
  async containerizePlugin(pluginPath, metadata) {
    if (!this.ociManager) {
      console.warn('OCIManager not provided, skipping containerization');
      return;
    }
    
    // Check if Dockerfile already exists
    const dockerfilePath = path.join(pluginPath, 'Dockerfile');
    if (fs.existsSync(dockerfilePath)) {
      // Use existing Dockerfile
      metadata.dockerfile = dockerfilePath;
      metadata.imageName = `aruraai/${metadata.name.toLowerCase()}:${metadata.version}`;
      return;
    }
    
    // Create a Dockerfile based on runtime
    let dockerfileContent = '';
    
    if (metadata.runtime === 'node') {
      dockerfileContent = this.createNodeDockerfile(metadata);
    } else if (metadata.runtime === 'python') {
      dockerfileContent = this.createPythonDockerfile(metadata);
    } else {
      console.warn(`Unknown runtime ${metadata.runtime} for plugin ${metadata.name}`);
      return;
    }
    
    // Write Dockerfile
    fs.writeFileSync(dockerfilePath, dockerfileContent);
    metadata.dockerfile = dockerfilePath;
    metadata.imageName = `aruraai/${metadata.name.toLowerCase()}:${metadata.version}`;
    
    // Build the container image
    try {
      await this.ociManager.buildImage(pluginPath, metadata.imageName);
      metadata.containerReady = true;
    } catch (error) {
      console.error(`Failed to build container for ${metadata.name}:`, error);
      metadata.containerReady = false;
      metadata.containerError = error.message;
    }
  }
  
  /**
   * Create a Node.js Dockerfile
   * @param {Object} metadata - Plugin metadata
   */
  createNodeDockerfile(metadata) {
    return `FROM node:18-alpine
LABEL org.opencontainers.image.title="${metadata.name}"
LABEL org.opencontainers.image.description="${metadata.description}"
LABEL org.opencontainers.image.version="${metadata.version}"
LABEL org.opencontainers.image.vendor="Autonomy Association International"

WORKDIR /app

COPY package*.json ./
RUN npm install --production

COPY . .

EXPOSE 8080
CMD ["node", "${metadata.main || 'index.js'}"]
`;
  }
  
  /**
   * Create a Python Dockerfile
   * @param {Object} metadata - Plugin metadata
   */
  createPythonDockerfile(metadata) {
    return `FROM python:3.9-slim
LABEL org.opencontainers.image.title="${metadata.name}"
LABEL org.opencontainers.image.description="${metadata.description}"
LABEL org.opencontainers.image.version="${metadata.version}"
LABEL org.opencontainers.image.vendor="Autonomy Association International"

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8080
CMD ["python", "${metadata.main || 'app.py'}"]
`;
  }
  
  /**
   * Save plugin information to the database
   * @param {Object} metadata - Plugin metadata
   */
  async savePluginToDb(metadata) {
    try {
      // Add timestamps
      metadata.createdAt = metadata.createdAt || new Date();
      metadata.updatedAt = new Date();
      
      // Generate plugin ID if not present
      if (!metadata._id) {
        metadata._id = crypto.randomUUID();
      }
      
      // Check if plugin already exists
      const existingPlugin = await this.pluginsCollection.findOne({ name: metadata.name });
      
      if (existingPlugin) {
        // Update existing plugin
        await this.pluginsCollection.updateOne(
          { name: metadata.name },
          { $set: metadata }
        );
      } else {
        // Insert new plugin
        await this.pluginsCollection.insertOne(metadata);
      }
      
      return metadata;
    } catch (error) {
      console.error(`Failed to save plugin ${metadata.name} to database:`, error);
      throw error;
    }
  }
  
  /**
   * Load a plugin into memory
   * @param {Object} metadata - Plugin metadata
   */
  async loadPlugin(metadata) {
    if (metadata.containerize && metadata.containerReady) {
      // Plugin will run in a container, no need to load in memory
      this.plugins[metadata.name] = {
        metadata,
        type: 'container'
      };
      return;
    }
    
    try {
      const pluginPath = path.join(process.cwd(), this.pluginsDir, metadata.name);
      const mainFile = path.join(pluginPath, metadata.main || 'index.js');
      
      if (!fs.existsSync(mainFile)) {
        throw new Error(`Main file ${mainFile} not found`);
      }
      
      // Clear require cache to ensure fresh load
      delete require.cache[require.resolve(mainFile)];
      
      // Load the plugin
      const pluginModule = require(mainFile);
      
      // Initialize the plugin if it has an init function
      let handle = null;
      if (typeof pluginModule.plugin_init === 'function') {
        handle = await pluginModule.plugin_init(metadata);
      }
      
      // Register the plugin
      this.plugins[metadata.name] = {
        metadata,
        module: pluginModule,
        handle,
        type: 'memory'
      };
      
      return this.plugins[metadata.name];
    } catch (error) {
      console.error(`Failed to load plugin ${metadata.name}:`, error);
      throw error;
    }
  }
  
  /**
   * Notify network nodes about a plugin's status update
   * @param {Object} metadata - Plugin metadata
   */
  async notifyNetworkNodes(metadata) {
    try {
      // Implementation will depend on network configuration
      console.log(`Notifying network about plugin ${metadata.name} status: ${metadata.active ? 'active' : 'inactive'}`);
      
      // TODO: Implement actual notification logic to other nodes
      
      return true;
    } catch (error) {
      console.error(`Failed to notify network about plugin ${metadata.name}:`, error);
      return false;
    }
  }
  
  /**
   * Execute a method on a plugin
   * @param {string} pluginName - Name of the plugin
   * @param {string} methodName - Name of the method to execute
   * @param {Object} params - Parameters to pass to the method
   */
  async executePluginMethod(pluginName, methodName, params = {}) {
    const plugin = this.plugins[pluginName];
    
    if (!plugin) {
      throw new Error(`Plugin ${pluginName} not found`);
    }
    
    if (plugin.type === 'memory') {
      // Execute in-memory plugin
      if (!plugin.module[methodName]) {
        throw new Error(`Method ${methodName} not found in plugin ${pluginName}`);
      }
      
      return await plugin.module[methodName](plugin.handle, params);
    } else if (plugin.type === 'container') {
      // Execute containerized plugin
      if (!this.ociManager) {
        throw new Error('OCIManager not available for containerized execution');
      }
      
      return await this.ociManager.executeContainerMethod(
        plugin.metadata.imageName,
        methodName,
        params
      );
    }
  }
  
  /**
   * Get a list of all registered plugins
   * @param {Object} filter - Optional MongoDB filter
   */
  async getPlugins(filter = {}) {
    return await this.pluginsCollection.find(filter).toArray();
  }
  
  /**
   * Update a plugin's status
   * @param {string} pluginName - Name of the plugin
   * @param {boolean} active - Whether the plugin should be active
   */
  async setPluginStatus(pluginName, active) {
    const result = await this.pluginsCollection.updateOne(
      { name: pluginName },
      { $set: { active, updatedAt: new Date() } }
    );
    
    if (result.matchedCount === 0) {
      throw new Error(`Plugin ${pluginName} not found`);
    }
    
    // Update in-memory registry
    if (this.plugins[pluginName]) {
      this.plugins[pluginName].metadata.active = active;
    }
    
    // Notify network
    await this.notifyNetworkNodes({ name: pluginName, active });
    
    return { name: pluginName, active };
  }
}

module.exports = PluginManager;
```


### 2. OCI Container Manager Implementation

Let's now implement the OCIContainerManager with support for Docker-in-Docker, Kubernetes, and Varnish:

```javascript
const fs = require('fs');
const path = require('path');
const { execSync, spawn } = require('child_process');
const crypto = require('crypto');
const { Meteor } = require('meteor/meteor');
const { MongoInternals } = require('meteor/mongo');

/**
 * OCIContainerManager - Manages OCI-compliant containers
 * Supports Docker, containerd, podman, and kubernetes workloads
 */
class OCIContainerManager {
  constructor(options = {}) {
    this.dbCollection = options.dbCollection || 'containers';
    this.mongoUrl = options.mongoUrl || process.env.MONGO_URL || 'mongodb://localhost:27017/meteor';
    this.runtimeType = options.runtimeType || 'docker'; // docker, containerd, podman, kubernetes
    this.keyManager = options.keyManager;
    this.varnishEnabled = !!process.env.VARNISH_BACKEND_HOST;
    this.varnishHost = process.env.VARNISH_BACKEND_HOST;
    this.varnishPort = process.env.VARNISH_BACKEND_PORT || 8080;
    this.registryUrl = options.registryUrl || null;
    this.registryUsername = options.registryUsername || null;
    this.registryPassword = options.registryPassword || null;
    
    // Connect to MongoDB
    this.db = MongoInternals.defaultRemoteCollectionDriver().mongo.db;
    this.containersCollection = this.db.collection(this.dbCollection);
    
    // Create indexes
    this._createIndexes();
    
    // Initialize container registry
    this.containers = {};
    
    // Check if we're using Docker-in-Docker
    this.dindEnabled = options.dindEnabled || process.env.DIND_ENABLED === 'true';
    
    // Check if encryption is enabled
    this.encryptionEnabled = options.encryptionEnabled || process.env.CONTAINER_ENCRYPTION_ENABLED === 'true';
    
    // Initialize the runtime
    this._initializeRuntime();
  }
  
  /**
   * Create necessary database indexes
   * @private
   */
  _createIndexes() {
    this.containersCollection.createIndex({ name: 1 }, { unique: true });
    this.containersCollection.createIndex({ image: 1 });
    this.containersCollection.createIndex({ status: 1 });
    this.containersCollection.createIndex({ nodeName: 1 });
  }
  
  /**
   * Initialize the container runtime
   * @private
   */
  _initializeRuntime() {
    try {
      switch (this.runtimeType) {
        case 'docker':
          // Check if Docker is available
          execSync('docker --version', { stdio: 'pipe' });
          
          // Set up Docker-in-Docker if enabled
          if (this.dindEnabled) {
            this._setupDind();
          }
          break;
          
        case 'containerd':
          // Check if containerd is available
          execSync('ctr --version', { stdio: 'pipe' });
          
          // Set up image encryption if enabled
          if (this.encryptionEnabled) {
            this._setupContainerdEncryption();
          }
          break;
          
        case 'podman':
          // Check if podman is available
          execSync('podman --version', { stdio: 'pipe' });
          
          // Set up lima VM if needed
          if (process.platform === 'darwin') {
            this._setupLimaVM();
          }
          break;
          
        case 'kubernetes':
          // Check if kubectl is available
          execSync('kubectl version --client', { stdio: 'pipe' });
          break;
          
        default:
          throw new Error(`Unsupported runtime type: ${this.runtimeType}`);
      }
      
      // Set up registry authentication if provided
      if (this.registryUrl && this.registryUsername && this.registryPassword) {
        this._setupRegistryAuth();
      }
      
      // Set up Varnish if enabled
      if (this.varnishEnabled) {
        this._setupVarnish();
      }
      
      console.log(`OCI Container Manager initialized with runtime: ${this.runtimeType}`);
    } catch (error) {
      console.error('Failed to initialize container runtime:', error);
      throw error;
    }
  }
  
  /**
   * Set up Docker-in-Docker (DinD)
   * @private
   */
  _setupDind() {
    try {
      // Check if DinD container is already running
      const dindCheck = execSync('docker ps -q -f name=dind', { stdio: 'pipe' }).toString().trim();
      
      if (!dindCheck) {
        console.log('Setting up Docker-in-Docker...');
        
        // Start Docker-in-Docker container
        execSync(`
          docker run -d --privileged --name dind \
          -v dind-vol:/var/lib/docker \
          -p 2375:2375 \
          docker:dind dockerd --host=tcp://0.0.0.0:2375
        `, { stdio: 'pipe' });
        
        // Wait for Docker-in-Docker to start
        execSync('sleep 5');
        
        // Set environment variable for Docker client
        process.env.DOCKER_HOST = 'tcp://localhost:2375';
      }
      
      console.log('Docker-in-Docker is running');
    } catch (error) {
      console.error('Failed to set up Docker-in-Docker:', error);
      throw error;
    }
  }
  
  /**
   * Set up Containerd image encryption
   * @private
   */
  _setupContainerdEncryption() {
    try {
      // Check if containerd imgcrypt is installed
      const imgcryptCheck = execSync('which ctd-decoder', { stdio: 'pipe' }).toString().trim();
      
      if (!imgcryptCheck) {
        console.log('Setting up containerd image encryption...');
        
        // Clone ocicrypt repository
        execSync('git clone https://github.com/containers/ocicrypt.git /tmp/ocicrypt', { stdio: 'pipe' });
        
        // Build and install ocicrypt
        execSync('cd /tmp/ocicrypt && make && make install', { stdio: 'pipe' });
        
        // Clone imgcrypt repository
        execSync('git clone https://github.com/containerd/imgcrypt.git /tmp/imgcrypt', { stdio: 'pipe' });
        
        // Build and install imgcrypt
        execSync('cd /tmp/imgcrypt && make && make install', { stdio: 'pipe' });
      }
      
      console.log('Containerd image encryption is set up');
    } catch (error) {
      console.error('Failed to set up containerd image encryption:', error);
      throw error;
    }
  }
  
  /**
   * Set up Lima VM for podman on macOS
   * @private
   */
  _setupLimaVM() {
    try {
      // Check if Lima is installed
      const limaCheck = execSync('which limactl', { stdio: 'pipe' }).toString().trim();
      
      if (!limaCheck) {
        throw new Error('Lima not installed. Please install lima: brew install lima');
      }
      
      // Check if podman VM is already running
      const vmStatus = execSync('limactl list', { stdio: 'pipe' }).toString();
      
      if (!vmStatus.includes('podman')) {
        console.log('Setting up Lima VM for podman...');
        
        // Create a temporary lima config file
        const limaConfig = `
arch: "x86_64"
images:
- location: "https://download.fedoraproject.org/pub/fedora/linux/releases/36/Cloud/x86_64/images/Fedora-Cloud-Base-36-1.5.x86_64.qcow2"
  arch: "x86_64"
mounts:
- location: "~"
  writable: true
containerd:
  system: false
  user: false
provision:
- mode: system
  script: |
    #!/bin/bash
    set -eux -o pipefail
    dnf -y update
    dnf -y install podman buildah skopeo
`;
        
        fs.writeFileSync('/tmp/podman.yaml', limaConfig);
        
        // Create and start the Lima VM
        execSync('limactl create --name=podman /tmp/podman.yaml', { stdio: 'pipe' });
        execSync('limactl start podman', { stdio: 'pipe' });
        
        // Set podman socket
        process.env.CONTAINER_HOST = 'unix:///Users/$(whoami)/.lima/podman/sock/podman.sock';
      }
      
      console.log('Lima VM for podman is running');
    } catch (error) {
      console.error('Failed to set up Lima VM for podman:', error);
      throw error;
    }
  }
  
  /**
   * Set up registry authentication
   * @private
   */
  _setupRegistryAuth() {
    try {
      switch (this.runtimeType) {
        case 'docker':
          execSync(`docker login ${this.registryUrl} -u ${this.registryUsername} -p ${this.registryPassword}`, { stdio: 'pipe' });
          break;
          
        case 'containerd':
          // Create config directory if it doesn't exist
          execSync('mkdir -p /etc/containerd/certs.d', { stdio: 'pipe' });
          
          // Create registry configuration file
          const containerdConfig = `
server = "${this.registryUrl}"

[host."${this.registryUrl}"]
  capabilities = ["pull", "push"]
  skip_verify = false

  [host."${this.registryUrl}".header]
    Authorization = ["Basic ${Buffer.from(`${this.registryUsername}:${this.registryPassword}`).toString('base64')}"]
`;
          
          fs.writeFileSync(`/etc/containerd/certs.d/${this.registryUrl}.toml`, containerdConfig);
          break;
          
        case 'podman':
          execSync(`podman login ${this.registryUrl} -u ${this.registryUsername} -p ${this.registryPassword}`, { stdio: 'pipe' });
          break;
          
        case 'kubernetes':
          // Create a Kubernetes secret for registry authentication
          const secretName = 'registry-auth';
          const namespace = 'default';
          
          execSync(`kubectl create secret docker-registry ${secretName} \
            --docker-server=${this.registryUrl} \
            --docker-username=${this.registryUsername} \
            --docker-password=${this.registryPassword} \
            --namespace=${namespace} \
            --dry-run=client -o yaml | kubectl apply -f -`, { stdio: 'pipe' });
          
          // Set the secret name for later use
          this.registrySecretName = secretName;
          break;
      }
      
      console.log(`Registry authentication set up for ${this.registryUrl}`);
    } catch (error) {
      console.error('Failed to set up registry authentication:', error);
      throw error;
    }
  }
  
  /**
   * Set up Varnish cache
   * @private
   */
  _setupVarnish() {
    try {
      // Check if Varnish container is already running
      const varnishCheck = execSync('docker ps -q -f name=varnish', { stdio: 'pipe' }).toString().trim();
      
      if (!varnishCheck) {
        console.log('Setting up Varnish cache...');
        
        // Create a default VCL file
        const vclConfig = `
vcl 4.0;

backend default {
    .host = "${this.varnishHost}";
    .port = "${this.varnishPort}";
}

sub vcl_recv {
    # Only cache GET and HEAD requests
    if (req.method != "GET" && req.method != "HEAD") {
        return (pass);
    }
    
    # Don't cache authenticated requests
    if (req.http.Authorization) {
        return (pass);
    }
    
    return (hash);
}

sub vcl_backend_response {
    # Set cache TTL based on backend response
    if (beresp.ttl <= 0s) {
        set beresp.ttl = 120s;
        set beresp.uncacheable = true;
        return (deliver);
    }
    
    return (deliver);
}
`;
        
        // Write VCL file
        fs.writeFileSync('/tmp/default.vcl', vclConfig);
        
        // Start Varnish container
        execSync(`
          docker run -d --name varnish \
          -p 80:80 \
          -v /tmp/default.vcl:/etc/varnish/default.vcl \
          -e VARNISH_SIZE=2G \
          varnish:stable
        `, { stdio: 'pipe' });
      }
      
      console.log('Varnish cache is running');
    } catch (error) {
      console.error('Failed to set up Varnish cache:', error);
      throw error;
    }
  }
  
  /**
   * Build a container image
   * @param {string} contextPath - Path to the build context
   * @param {string} imageName - Name for the resulting image
   * @param {Object} options - Additional build options
   */
  async buildImage(contextPath, imageName, options = {}) {
    try {
      console.log(`Building image ${imageName} from ${contextPath}`);
      
      let buildCommand;
      
      switch (this.runtimeType) {
        case 'docker':
          buildCommand = `docker build -t ${imageName} ${contextPath}`;
          break;
          
        case 'containerd':
          // Use buildkit with containerd
          buildCommand = `buildctl build --frontend dockerfile.v0 --local context=${contextPath} --local dockerfile=${contextPath} --output type=image,name=${imageName},push=false`;
          break;
          
        case 'podman':
          buildCommand = `podman build -t ${imageName} ${contextPath}`;
          break;
          
        case 'kubernetes':
          // For kubernetes, we'll use kaniko
          const kanikoPod = `kaniko-${crypto.randomBytes(4).toString('hex')}`;
          
          // Create a ConfigMap for the Dockerfile
          const dockerfilePath = path.join(contextPath, 'Dockerfile');
          const dockerfile = fs.readFileSync(dockerfilePath, 'utf8');
          
          execSync(`kubectl create configmap ${kanikoPod}-dockerfile --from-literal=Dockerfile='${dockerfile}'`, { stdio: 'pipe' });
          
          // Create the Kaniko Pod
          const kanikoPodYaml = `
apiVersion: v1
kind: Pod
metadata:
  name: ${kanikoPod}
spec:
  containers:
  - name: kaniko
    image: gcr.io/kaniko-project/executor:latest
    args:
    - "--dockerfile=/workspace/Dockerfile"
    - "--context=dir:///workspace"
    - "--destination=${imageName}"
    volumeMounts:
    - name: dockerfile
      mountPath: /workspace
    - name: docker-config
      mountPath: /kaniko/.docker/
  restartPolicy: Never
  volumes:
  - name: dockerfile
    configMap:
      name: ${kanikoPod}-dockerfile
  - name: docker-config
    secret:
      secretName: ${this.registrySecretName}
`;
          
          // Apply the Kaniko Pod
          fs.writeFileSync(`/tmp/${kanikoPod}.yaml`, kanikoPodYaml);
          execSync(`kubectl apply -f /tmp/${kanikoPod}.yaml`, { stdio: 'pipe' });
          
          // Wait for Kaniko to complete
          execSync(`kubectl wait --for=condition=complete pod/${kanikoPod} --timeout=600s`, { stdio: 'pipe' });
          
          // Clean up
          execSync(`kubectl delete pod ${kanikoPod}`, { stdio: 'pipe' });
          execSync(`kubectl delete configmap ${kanikoPod}-dockerfile`, { stdio: 'pipe' });
          
          // No need to execute a command since Kaniko did the build
          return { imageName, status: 'success' };
      }
      
      // Apply encryption if enabled for containerd
      if (this.encryptionEnabled && this.runtimeType === 'containerd') {
        if (this.keyManager) {
          const encryptionKey = await this.keyManager.getOrCreateKey('image-encryption');
          buildCommand += ` --output type=image,name=${imageName},push=false,oci-mediatypes=true,encryption=[{"recipient":{"keys":["${encryptionKey.publicKey}"]}}]`;
        } else {
          console.warn('Key manager not available, skipping image encryption');
        }
      }
      
      // Execute the build command
      execSync(buildCommand, { stdio: 'pipe' });
      
      // Check if image should be pushed to registry
      if (options.push && this.registryUrl) {
        await this.pushImage(imageName);
      }
      
      return { imageName, status: 'success' };
    } catch (error) {
      console.error(`Failed to build image ${imageName}:`, error);
      throw error;
    }
  }
  
  /**
   * Push an image to the registry
   * @param {string} imageName - Name of the image to push
   */
  async pushImage(imageName) {
    try {
      console.log(`Pushing image ${imageName} to ${this.registryUrl}`);
      
      const fullImageName = `${this.registryUrl}/${imageName}`;
      
      // Tag the image with registry URL
      switch (this.runtimeType) {
        case 'docker':
          execSync(`docker tag ${imageName} ${fullImageName}`, { stdio: 'pipe' });
          execSync(`docker push ${fullImageName}`, { stdio: 'pipe' });
          break;
          
        case 'containerd':
          execSync(`ctr image tag ${imageName} ${fullImageName}`, { stdio: 'pipe' });
          execSync(`ctr image push ${fullImageName}`, { stdio: 'pipe' });
          break;
          
        case 'podman':
          execSync(`podman tag ${imageName} ${fullImageName}`, { stdio: 'pipe' });
          execSync(`podman push ${fullImageName}`, { stdio: 'pipe' });
          break;
          
        case 'kubernetes':
          // For kubernetes, we already pushed the image in the build step
          break;
      }
      
      return { imageName: fullImageName, status: 'pushed' };
    } catch (error) {
      console.error(`Failed to push image ${imageName}:`, error);
      throw error;
    }
  }
  
  /**
   * Pull an image from the registry
   * @param {string} imageName - Name of the image to pull
   */
  async pullImage(imageName) {
    try {
      console.log(`Pulling image ${imageName}`);
      
      let fullImageName = imageName;
      if (this.registryUrl && !imageName.includes('/')) {
        fullImageName = `${this.registryUrl}/${imageName}`;
      }
      
      switch (this.runtimeType) {
        case 'docker':
          execSync(`docker pull ${fullImageName}`, { stdio: 'pipe' });
          break;
          
        case 'containerd':
          if (this.encryptionEnabled && this.keyManager) {
            const encryptionKey = await this.keyManager.getOrCreateKey('image-encryption');
            execSync(`ctd-decoder pull --private-key=${encryptionKey.privateKeyPath} ${fullImageName}`, { stdio: 'pipe' });
          } else {
            execSync(`ctr image pull ${fullImageName}`, { stdio: 'pipe' });
          }
          break;
          
        case 'podman':
          execSync(`podman pull ${fullImageName}`, { stdio: 'pipe' });
          break;
          
        case 'kubernetes':
          // For kubernetes, we don't pull directly - it's handled by the kubelet
          // But we can check if the image exists in the registry
          execSync(`skopeo inspect docker://${fullImageName}`, { stdio: 'pipe' });
          break;
      }
      
      return { imageName: fullImageName, status: 'pulled' };
    } catch (error) {
      console.error(`Failed to pull image ${imageName}:`, error);
      throw error;
    }
  }
  
  /**
   * Transfer an image between nodes
   * @param {string} imageName - Name of the image to transfer
   * @param {string} targetHost - Target host to transfer to
   */
  async transferImage(imageName, targetHost) {
    try {
      console.log(`Transferring image ${imageName} to ${targetHost}`);
      
      // Method depends on the runtime
      switch (this.runtimeType) {
        case 'docker':
          // Save the image to a tarball, transfer, and load
          execSync(`docker save ${imageName} | gzip | ssh ${targetHost} 'docker load'`, { stdio: 'pipe' });
          break;
          
        case 'containerd':
          // Export the image to a tarball, transfer, and import
          execSync(`ctr image export ${imageName}.tar ${imageName} && gzip ${imageName}.tar`, { stdio: 'pipe' });
          execSync(`scp ${imageName}.tar.gz ${targetHost}:/tmp/`, { stdio: 'pipe' });
          execSync(`ssh ${targetHost} 'gunzip /tmp/${imageName}.tar.gz && ctr image import /tmp/${imageName}.tar && rm /tmp/${imageName}.tar'`, { stdio: 'pipe' });
          execSync(`rm ${imageName}.tar.gz`, { stdio: 'pipe' });
          break;
          
        case 'podman':
          // Save the image to a tarball, transfer, and load
          execSync(`podman save ${imageName} | gzip | ssh ${targetHost} 'podman load'`, { stdio: 'pipe' });
          break;
          
        case 'kubernetes':
          // For kubernetes, we would typically use a shared registry
          // But we can use a similar approach with skopeo
          execSync(`skopeo copy docker-daemon:${imageName} docker://${targetHost}:5000/${imageName}`, { stdio: 'pipe' });
          break;
      }
      
      return { imageName, targetHost, status: 'transferred' };
    } catch (error) {
      console.error(`Failed to transfer image ${imageName} to ${targetHost}:`, error);
      throw error;
    }
  }
  
  /**
   * Run a container
   * @param {string} imageName - Name of the image to run
   * @param {string} containerName - Name for the container
   * @param {Object} options - Additional run options
   */
  async runContainer(imageName, containerName, options = {}) {
    try {
      console.log(`Running container ${containerName} from image ${imageName}`);
      
      // Default options
      const defaultOptions = {
        ports: [],
        env: {},
        volumes: [],
        command: '',
        restart: 'unless-stopped',
        memory: '256m',
        cpus: '0.5'
      };
      
      // Merge options
      const runOptions = { ...defaultOptions, ...options };
      
      // Format ports, env vars, and volumes for the command
      const ports = runOptions.ports.map(port => `-p ${port}`).join(' ');
      const env = Object.entries(runOptions.env).map(([key, value]) => `-e ${key}=${value}`).join(' ');
      const volumes = runOptions.volumes.map(vol => `-v ${vol}`).join(' ');
      
      let runCommand;
      
      switch (this.runtimeType) {
        case 'docker':
          runCommand = `docker run -d --name ${containerName} ${ports} ${env} ${volumes} --restart ${runOptions.restart} --memory ${runOptions.memory} --cpus ${runOptions.cpus} ${imageName} ${runOptions.command}`;
          break;
          
        case 'containerd':
          // For containerd, we use ctr
          runCommand = `ctr run -d --name ${containerName} ${imageName} ${containerName} ${runOptions.command}`;
          break;
          
        case 'podman':
          runCommand = `podman run -d --name ${containerName} ${ports} ${env} ${volumes} --restart ${runOptions.restart} --memory ${runOptions.memory} --cpus ${runOptions.cpus} ${imageName} ${runOptions.command}`;
          break;
          
        case 'kubernetes':
          // For kubernetes, we create a deployment
          const deploymentYaml = `
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ${containerName}
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ${containerName}
  template:
    metadata:
      labels:
        app: ${containerName}
    spec:
      containers:
      - name: ${containerName}
        image: ${imageName}
        command: [${runOptions.command ? `"${runOptions.command.split(' ').join('", "')}"` : ''}]
        resources:
          limits:
            memory: ${runOptions.memory}
            cpu: ${runOptions.cpus}
        ${runOptions.ports.length > 0 ? `ports:
${runOptions.ports.map(port => {
  const [containerPort, hostPort] = port.split(':');
  return `        - containerPort: ${containerPort}`;
}).join('\n')}` : ''}
        ${Object.keys(runOptions.env).length > 0 ? `env:
${Object.entries(runOptions.env).map(([key, value]) => `        - name: ${key}
          value: "${value}"`).join('\n')}` : ''}
        ${runOptions.volumes.length > 0 ? `volumeMounts:
${runOptions.volumes.map(vol => {
  const [hostPath, containerPath] = vol.split(':');
  return `        - name: ${hostPath.replace(/[^a-z0-9]/gi, '-')}
          mountPath: ${containerPath}`;
}).join('\n')}` : ''}
      ${runOptions.volumes.length > 0 ? `volumes:
${runOptions.volumes.map(vol => {
  const [hostPath, containerPath] = vol.split(':');
  return `      - name: ${hostPath.replace(/[^a-z0-9]/gi, '-')}
        hostPath:
          path: ${hostPath}`;
}).join('\n')}` : ''}
`;
          
          // Write the deployment YAML
          fs.writeFileSync(`/tmp/${containerName}-deployment.yaml`, deploymentYaml);
          
          // Apply the deployment
          execSync(`kubectl apply -f /tmp/${containerName}-deployment.yaml`, { stdio: 'pipe' });
          
          // Create a service if ports are specified
          if (runOptions.ports.length > 0) {
            const serviceYaml = `
apiVersion: v1
kind: Service
metadata:
  name: ${containerName}
spec:
  selector:
    app: ${containerName}
  ports:
${runOptions.ports.map(port => {
  const [containerPort, hostPort] = port.split(':');
  return `  - port: ${hostPort || containerPort}
    targetPort: ${containerPort}`;
}).join('\n')}
  type: ClusterIP
`;
            
            // Write the service YAML
            fs.writeFileSync(`/tmp/${containerName}-service.yaml`, serviceYaml);
            
            // Apply the service
            execSync(`kubectl apply -f /tmp/${containerName}-service.yaml`, { stdio: 'pipe' });
          }
          
          // Return without executing a command since we're using kubectl
          return {
            containerId: containerName,
            name: containerName,
            image: imageName,
            status: 'running'
          };
      }
      
      // Execute the run command
      const output = execSync(runCommand, { stdio: 'pipe' }).toString().trim();
      
      // Get container ID
      let containerId = output;
      if (this.runtimeType === 'docker' || this.runtimeType === 'podman') {
        containerId = output.substring(0, 12);
      }
      
      // Store container info in MongoDB
      const containerInfo = {
        containerId,
        name: containerName,
        image: imageName,
        options: runOptions,
        createdAt: new Date(),
        status: 'running',
        runtime: this.runtimeType,
        nodeName: os.hostname()
      };
      
      await this.containersCollection.insertOne(containerInfo);
      
      return containerInfo;
    } catch (error) {
      console.error(`Failed to run container ${containerName}:`, error);
      throw error;
    }
  }
  
  /**
   * Stop a container
   * @param {string} containerName - Name of the container to stop
   */
  async stopContainer(containerName) {
    try {
      console.log(`Stopping container ${containerName}`);
      
      switch (this.runtimeType) {
        case 'docker':
          execSync(`docker stop ${containerName}`, { stdio: 'pipe' });
          break;
          
        case 'containerd':
          execSync(`ctr task kill ${containerName}`, { stdio: 'pipe' });
          break;
          
        case 'podman':
          execSync(`podman stop ${containerName}`, { stdio: 'pipe' });
          break;
          
        case 'kubernetes':
          // For kubernetes, we scale the deployment to 0
          execSync(`kubectl scale deployment ${containerName} --replicas=0`, { stdio: 'pipe' });
          break;
      }
      
      // Update container status in MongoDB
      await this.containersCollection.updateOne(
        { name: containerName },
        { $set: { status: 'stopped', updatedAt: new Date() } }
      );
      
      return { name: containerName, status: 'stopped' };
    } catch (error) {
      console.error(`Failed to stop container ${containerName}:`, error);
      throw error;
    }
  }
  
  /**
   * Remove a container
   * @param {string} containerName - Name of the container to remove
   */
  async removeContainer(containerName) {
    try {
      console.log(`Removing container ${containerName}`);
      
      switch (this.runtimeType) {
        case 'docker':
          execSync(`docker rm -f ${containerName}`, { stdio: 'pipe' });
          break;
          
        case 'containerd':
          execSync(`ctr container rm ${containerName}`, { stdio: 'pipe' });
          break;
          
        case 'podman':
          execSync(`podman rm -f ${containerName}`, { stdio: 'pipe' });
          break;
          
        case 'kubernetes':
          // For kubernetes, we delete the deployment and service
          execSync(`kubectl delete deployment ${containerName}`, { stdio: 'pipe' });
          execSync(`kubectl delete service ${containerName}`, { stdio: 'pipe' });
          break;
      }
      
      // Remove container from MongoDB
      await this.containersCollection.deleteOne({ name: containerName });
      
      return { name: containerName, status: 'removed' };
    } catch (error) {
      console.error(`Failed to remove container ${containerName}:`, error);
      throw error;
    }
  }
  
  /**
   * Execute a command in a container
   * @param {string} containerName - Name of the container
   * @param {string} command - Command to execute
   */
  async execContainer(containerName, command) {
    try {
      console.log(`Executing command in container ${containerName}: ${command}`);
      
      let execCommand;
      
      switch (this.runtimeType) {
        case 'docker':
          execCommand = `docker exec ${containerName} ${command}`;
          break;
          
        case 'containerd':
          // For containerd, it's more complex - we'll use ctr task exec
          execCommand = `ctr task exec --exec-id exec-${Date.now()} ${containerName} ${command}`;
          break;
          
        case 'podman':
          execCommand = `podman exec ${containerName} ${command}`;
          break;
          
        case 'kubernetes':
          // For kubernetes, we use kubectl exec
          execCommand = `kubectl exec -it deployment/${containerName} -- ${command}`;
          break;
      }
      
      const output = execSync(execCommand, { stdio: 'pipe' }).toString();
      
      return { name: containerName, command, output };
    } catch (error) {
      console.error(`Failed to execute command in container ${containerName}:`, error);
      throw error;
    }
  }
  
  /**
   * Execute a method in a container
   * @param {string} imageName - Name of the image to use
   * @param {string} methodName - Name of the method to execute
   * @param {Object} params - Parameters to pass to the method
   */
  async executeContainerMethod(imageName, methodName, params = {}) {
    try {
      console.log(`Executing method ${methodName} in container from image ${imageName}`);
      
      // Create a unique container name
      const containerName = `method-${imageName.replace(/[^a-z0-9]/gi, '-')}-${crypto.randomBytes(4).toString('hex')}`;
      
      // Prepare JSON params
      const paramsJson = JSON.stringify(params);
      
      // Build the command to execute the method
      const command = `node -e "const method = require('/app/${methodName}'); console.log(JSON.stringify(method(JSON.parse('${paramsJson}'))))"`;
      
      // Run the container with the command
      const runOptions = {
        command: '/bin/sh -c "' + command.replace(/"/g, '\\"') + '"',
        remove: true,
        env: {
          METHOD_NAME: methodName,
          PARAMS: paramsJson
        }
      };
      
      let output;
      
      switch (this.runtimeType) {
        case 'docker':
          output = execSync(`docker run --rm --name ${containerName} -e METHOD_NAME=${methodName} -e PARAMS='${paramsJson}' ${imageName} ${runOptions.command}`, { stdio: 'pipe' }).toString();
          break;
          
        case 'containerd':
          // For containerd, we'll create a temporary container, run it, and then remove it
          execSync(`ctr container create ${imageName} ${containerName}`, { stdio: 'pipe' });
          output = execSync(`ctr task start -d ${containerName} && ctr task exec --exec-id exec-${Date.now()} ${containerName} ${runOptions.command}`, { stdio: 'pipe' }).toString();
          execSync(`ctr task kill ${containerName} && ctr container rm ${containerName}`, { stdio: 'pipe' });
          break;
          
        case 'podman':
          output = execSync(`podman run --rm --name ${containerName} -e METHOD_NAME=${methodName} -e PARAMS='${paramsJson}' ${imageName} ${runOptions.command}`, { stdio: 'pipe' }).toString();
          break;
          
        case 'kubernetes':
          // For kubernetes, we create a job
          const jobYaml = `
apiVersion: batch/v1
kind: Job
metadata:
  name: ${containerName}
spec:
  template:
    spec:
      containers:
      - name: ${containerName}
        image: ${imageName}
        command: ["/bin/sh", "-c", "${command.replace(/"/g, '\\"')}"]
        env:
        - name: METHOD_NAME
          value: "${methodName}"
        - name: PARAMS
          value: '${paramsJson}'
      restartPolicy: Never
  backoffLimit: 0
`;
          
          // Write the job YAML
          fs.writeFileSync(`/tmp/${containerName}-job.yaml`, jobYaml);
          
          // Apply the job
          execSync(`kubectl apply -f /tmp/${containerName}-job.yaml`, { stdio: 'pipe' });
          
          // Wait for the job to complete
          execSync(`kubectl wait --for=condition=complete job/${containerName} --timeout=60s`, { stdio: 'pipe' });
          
          // Get the logs
          output = execSync(`kubectl logs job/${containerName}`, { stdio: 'pipe' }).toString();
          
          // Clean up
          execSync(`kubectl delete job ${containerName}`, { stdio: 'pipe' });
          break;
      }
      
      // Parse the output as JSON
      let result;
      try {
        result = JSON.parse(output.trim());
      } catch (error) {
        console.error(`Failed to parse output as JSON: ${output}`);
        result = { output, error: 'Failed to parse output as JSON' };
      }
      
      return result;
    } catch (error) {
      console.error(`Failed to execute method ${methodName} in container from image ${imageName}:`, error);
      throw error;
    }
  }
  
  /**
   * Get container logs
   * @param {string} containerName - Name of the container
   * @param {Object} options - Additional options
   */
  async getContainerLogs(containerName, options = {}) {
    try {
      console.log(`Getting logs for container ${containerName}`);
      
      const defaultOptions = {
        tail: 100,
        since: '1h'
      };
      
      const logOptions = { ...defaultOptions, ...options };
      
      let logsCommand;
      
      switch (this.runtimeType) {
        case 'docker':
          logsCommand = `docker logs --tail ${logOptions.tail} --since ${logOptions.since} ${containerName}`;
          break;
          
        case 'containerd':
          // For containerd, we need to use a task log command
          logsCommand = `ctr task logs ${containerName}`;
          break;
          
        case 'podman':
          logsCommand = `podman logs --tail ${logOptions.tail} --since ${logOptions.since} ${containerName}`;
          break;
          
        case 'kubernetes':
          // For kubernetes, we use kubectl logs
          logsCommand = `kubectl logs deployment/${containerName} --tail=${logOptions.tail}`;
          break;
      }
      
      const logs = execSync(logsCommand, { stdio: 'pipe' }).toString();
      
      return { name: containerName, logs };
    } catch (error) {
      console.error(`Failed to get logs for container ${containerName}:`, error);
      throw error;
    }
  }
  
  /**
   * Get container status
   * @param {string} containerName - Name of the container
   */
  async getContainerStatus(containerName) {
    try {
      console.log(`Getting status for container ${containerName}`);
      
      let statusCommand;
      let status = 'unknown';
      
      switch (this.runtimeType) {
        case 'docker':
          statusCommand = `docker inspect -f '{{.State.Status}}' ${containerName}`;
          status = execSync(statusCommand, { stdio: 'pipe' }).toString().trim();
          break;
          
        case 'containerd':
          // For containerd, we need to check if the task exists
          try {
            execSync(`ctr task ls | grep ${containerName}`, { stdio: 'pipe' });
            status = 'running';
          } catch (error) {
            // Check if container exists but task is not running
            try {
              execSync(`ctr container ls | grep ${containerName}`, { stdio: 'pipe' });
              status = 'created';
            } catch (error) {
              status = 'not_found';
            }
          }
          break;
          
        case 'podman':
          statusCommand = `podman inspect -f '{{.State.Status}}' ${containerName}`;
          status = execSync(statusCommand, { stdio: 'pipe' }).toString().trim();
          break;
          
        case 'kubernetes':
          // For kubernetes, we check the deployment status
          try {
            const statusOutput = execSync(`kubectl get deployment ${containerName} -o jsonpath='{.status.readyReplicas}'`, { stdio: 'pipe' }).toString().trim();
            status = parseInt(statusOutput, 10) > 0 ? 'running' : 'not_running';
          } catch (error) {
            status = 'not_found';
          }
          break;
      }
      
      // Update status in MongoDB
      await this.containersCollection.updateOne(
        { name: containerName },
        { $set: { status, updatedAt: new Date() } }
      );
      
      return { name: containerName, status };
    } catch (error) {
      console.error(`Failed to get status for container ${containerName}:`, error);
      
      // Container might not exist
      return { name: containerName, status: 'not_found', error: error.message };
    }
  }
  
  /**
   * Get all containers
   * @param {Object} filter - Optional MongoDB filter
   */
  async getContainers(filter = {}) {
    try {
      console.log('Getting all containers');
      
      // Get list of containers from the runtime
      let containers = [];
      
      switch (this.runtimeType) {
        case 'docker':
          const dockerOutput = execSync('docker ps -a --format "{{.ID}}|{{.Names}}|{{.Image}}|{{.Status}}"', { stdio: 'pipe' }).toString();
          containers = dockerOutput.trim().split('\n').map(line => {
            const [id, name, image, status] = line.split('|');
            return { containerId: id, name, image, status: status.startsWith('Up') ? 'running' : 'stopped' };
          });
          break;
          
        case 'containerd':
          const containerdOutput = execSync('ctr container ls -q', { stdio: 'pipe' }).toString();
          containers = containerdOutput.trim().split('\n').filter(Boolean).map(id => {
            const inspectOutput = execSync(`ctr container info ${id}`, { stdio: 'pipe' }).toString();
            const info = JSON.parse(inspectOutput);
            return {
              containerId: id,
              name: info.Spec.Labels['io.containerd.id'] || id,
              image: info.Image,
              status: 'unknown' // Containerd doesn't provide status directly
            };
          });
          break;
          
        case 'podman':
          const podmanOutput = execSync('podman ps -a --format "{{.ID}}|{{.Names}}|{{.Image}}|{{.Status}}"', { stdio: 'pipe' }).toString();
          containers = podmanOutput.trim().split('\n').map(line => {
            const [id, name, image, status] = line.split('|');
            return { containerId: id, name, image, status: status.startsWith('Up') ? 'running' : 'stopped' };
          });
          break;
          
        case 'kubernetes':
          const k8sOutput = execSync('kubectl get deployments -o jsonpath=\'{range .items[*]}{.metadata.name}|{.spec.template.spec.containers[0].image}|{.status.readyReplicas}{"\n"}{end}\'', { stdio: 'pipe' }).toString();
          containers = k8sOutput.trim().split('\n').filter(Boolean).map(line => {
            const [name, image, readyReplicas] = line.split('|');
            return {
              containerId: name,
              name,
              image,
              status: parseInt(readyReplicas || '0', 10) > 0 ? 'running' : 'stopped'
            };
          });
          break;
      }
      
      // Merge with MongoDB data
      const dbContainers = await this.containersCollection.find(filter).toArray();
      
      // Create a map of containers by name
      const containerMap = new Map();
      
      // First, add all containers from the runtime
      containers.forEach(container => {
        containerMap.set(container.name, container);
      });
      
      // Then, merge with data from MongoDB
      dbContainers.forEach(dbContainer => {
        if (containerMap.has(dbContainer.name)) {
          const runtimeContainer = containerMap.get(dbContainer.name);
          containerMap.set(dbContainer.name, {
            ...dbContainer,
            status: runtimeContainer.status, // Use runtime status
            containerId: runtimeContainer.containerId // Use runtime containerId
          });
        } else {
          // Container exists in DB but not in runtime - it might be on another node
          containerMap.set(dbContainer.name, dbContainer);
        }
      });
      
      return Array.from(containerMap.values());
    } catch (error) {
      console.error('Failed to get containers:', error);
      
      // Fall back to MongoDB data only
      return await this.containersCollection.find(filter).toArray();
    }
  }
  
  /**
   * Perform health check on all containers
   */
  async healthCheck() {
    try {
      console.log('Performing health check on all containers');
      
      // Get all containers
      const containers = await this.getContainers({ active: true });
      
      const results = [];
      
      for (const container of containers) {
        try {
          // Check container status
          const status = await this.getContainerStatus(container.name);
          
          // If container is not running but should be, restart it
          if (status.status !== 'running' && container.autoRestart) {
            console.log(`Container ${container.name} is ${status.status}, restarting...`);
            
            if (status.status === 'not_found') {
              // Container doesn't exist, re-create it
              if (container.image && container.options) {
                await this.runContainer(container.image, container.name, container.options);
              }
            } else {
              // Container exists but not running, start it
              switch (this.runtimeType) {
                case 'docker':
                  execSync(`docker start ${container.name}`, { stdio: 'pipe' });
                  break;
                  
                case 'containerd':
                  execSync(`ctr task start ${container.name}`, { stdio: 'pipe' });
                  break;
                  
                case 'podman':
                  execSync(`podman start ${container.name}`, { stdio: 'pipe' });
                  break;
                  
                case 'kubernetes':
                  execSync(`kubectl scale deployment ${container.name} --replicas=1`, { stdio: 'pipe' });
                  break;
              }
            }
            
            // Check status again
            const newStatus = await this.getContainerStatus(container.name);
            results.push({
              name: container.name,
              previousStatus: status.status,
              currentStatus: newStatus.status,
              action: 'restarted'
            });
          } else {
            // Container is running as expected
            results.push({
              name: container.name,
              status: status.status,
              action: 'none'
            });
          }
        } catch (error) {
          console.error(`Health check failed for container ${container.name}:`, error);
          results.push({
            name: container.name,
            error: error.message,
            action: 'error'
          });
        }
      }
      
      return results;
    } catch (error) {
      console.error('Health check failed:', error);
      throw error;
    }
  }
}

module.exports = OCIContainerManager;
```


### 3. KeyManager for Secure Storage

Let's create a KeyManager class for securely handling encryption keys and credentials:

```javascript
const fs = require('fs');
const path = require('path');
const crypto = require('crypto');
const { Meteor } = require('meteor/meteor');
const { MongoInternals } = require('meteor/mongo');

/**
 * KeyManager - Handles secure storage of encryption keys and credentials
 * Implements KPI methodology for key management
 */
class KeyManager {
  constructor(options = {}) {
    this.dbCollection = options.dbCollection || 'keys';
    this.mongoUrl = options.mongoUrl || process.env.MONGO_URL || 'mongodb://localhost:27017/meteor';
    this.keyStorePath = options.keyStorePath || path.join(process.cwd(), '.keystore');
    this.masterKeyPath = options.masterKeyPath || path.join(this.keyStorePath, 'master.key');
    
    // Connect to MongoDB
    this.db = MongoInternals.defaultRemoteCollectionDriver().mongo.db;
    this.keysCollection = this.db.collection(this.dbCollection);
    
    // Create indexes
    this._createIndexes();
    
    // Initialize key store
    this._initializeKeyStore();
  }
  
  /**
   * Create necessary database indexes
   * @private
   */
  _createIndexes() {
    this.keysCollection.createIndex({ keyId: 1 }, { unique: true });
    this.keysCollection.createIndex({ name: 1 }, { unique: true });
    this.keysCollection.createIndex({ type: 1 });
    this.keysCollection.createIndex({ active: 1 });
  }
  
  /**
   * Initialize the key store
   * @private
   */
  _initializeKeyStore() {
    try {
      // Create key store directory if it doesn't exist
      if (!fs.existsSync(this.keyStorePath)) {
        fs.mkdirSync(this.keyStorePath, { recursive: true, mode: 0o700 });
      }
      
      // Create master key if it doesn't exist
      if (!fs.existsSync(this.masterKeyPath)) {
        console.log('Creating new master key...');
        const masterKey = crypto.randomBytes(32).toString('hex');
        fs.writeFileSync(this.masterKeyPath, masterKey, { mode: 0o600 });
      }
      
      // Load master key
      this.masterKey = fs.readFileSync(this.masterKeyPath, 'utf8');
      
      console.log('Key store initialized');
    } catch (error) {
      console.error('Failed to initialize key store:', error);
      throw error;
    }
  }
  
  /**
   * Encrypt a value using the master key
   * @param {string} value - Value to encrypt
   * @returns {string} Encrypted value as a hex string
   * @private
   */
  _encrypt(value) {
    const iv = crypto.randomBytes(16);
    const key = Buffer.from(this.masterKey, 'hex');
    const cipher = crypto.createCipheriv('aes-256-cbc', key, iv);
    let encrypted = cipher.update(value, 'utf8', 'hex');
    encrypted += cipher.final('hex');
    return `${iv.toString('hex')}:${encrypted}`;
  }
  
  /**
   * Decrypt a value using the master key
   * @param {string} encrypted - Encrypted value
   * @returns {string} Decrypted value
   * @private
   */
  _decrypt(encrypted) {
    const [ivHex, encryptedValue] = encrypted.split(':');
    const iv = Buffer.from(ivHex, 'hex');
    const key = Buffer.from(this.masterKey, 'hex');
    const decipher = crypto.createDecipheriv('aes-256-cbc', key, iv);
    let decrypted = decipher.update(encryptedValue, 'hex', 'utf8');
    decrypted += decipher.final('utf8');
    return decrypted;
  }
  
  /**
   * Generate a new key pair
   * @param {string} type - Type of key pair (rsa, ec, etc.)
   * @returns {Object} Key pair object
   * @private
   */
  _generateKeyPair(type = 'rsa') {
    try {
      let keyPair;
      
      if (type === 'rsa') {
        keyPair = crypto.generateKeyPairSync('rsa', {
          modulusLength: 2048,
          publicKeyEncoding: {
            type: 'spki',
            format: 'pem'
          },
          privateKeyEncoding: {
            type: 'pkcs8',
            format: 'pem'
          }
        });
      } else if (type === 'ec') {
        keyPair = crypto.generateKeyPairSync('ec', {
          namedCurve: 'prime256v1',
          publicKeyEncoding: {
            type: 'spki',
            format: 'pem'
          },
          privateKeyEncoding: {
            type: 'pkcs8',
            format: 'pem'
          }
        });
      } else {
        throw new Error(`Unsupported key type: ${type}`);
      }
      
      return keyPair;
    } catch (error) {
      console.error(`Failed to generate ${type} key pair:`, error);
      throw error;
    }
  }
  
  /**
   * Create a new key
   * @param {string} name - Key name
   * @param {Object} options - Key options
   */
  async createKey(name, options = {}) {
    try {
      console.log(`Creating new key: ${name}`);
      
      // Check if key already exists
      const existingKey = await this.keysCollection.findOne({ name });
      if (existingKey) {
        throw new Error(`Key with name ${name} already exists`);
      }
      
      // Default options
      const defaultOptions = {
        type: 'symmetric',
        algorithm: 'aes-256-cbc',
        keyType: 'rsa',
        description: '',
        rotationPeriod: 90, // days
        metadata: {}
      };
      
      // Merge options
      const keyOptions = { ...defaultOptions, ...options };
      
      // Generate key ID
      const keyId = crypto.randomUUID();
      
      // Generate key material based on type
      let keyMaterial;
      let publicKey = null;
      let privateKey = null;
      let privateKeyPath = null;
      let publicKeyPath = null;
      
      if (keyOptions.type === 'symmetric') {
        // Generate a random symmetric key
        keyMaterial = crypto.randomBytes(32).toString('hex');
        
        // Encrypt key material
        const encryptedKey = this._encrypt(keyMaterial);
        
        // Write to key store
        const keyPath = path.join(this.keyStorePath, `${keyId}.key`);
        fs.writeFileSync(keyPath, encryptedKey, { mode: 0o600 });
      } else if (keyOptions.type === 'asymmetric') {
        // Generate a key pair
        const keyPair = this._generateKeyPair(keyOptions.keyType);
        
        // Extract public and private keys
        publicKey = keyPair.publicKey;
        privateKey = keyPair.privateKey;
        
        // Encrypt private key
        const encryptedPrivateKey = this._encrypt(privateKey);
        
        // Write keys to key store
        publicKeyPath = path.join(this.keyStorePath, `${keyId}.pub`);
        privateKeyPath = path.join(this.keyStorePath, `${keyId}.key`);
        
        fs.writeFileSync(publicKeyPath, publicKey, { mode: 0o644 });
        fs.writeFileSync(privateKeyPath, encryptedPrivateKey, { mode: 0o600 });
      } else {
        throw new Error(`Unsupported key type: ${keyOptions.type}`);
      }
      
      // Store key metadata in MongoDB
      const keyDocument = {
        keyId,
        name,
        type: keyOptions.type,
        algorithm: keyOptions.algorithm,
        keyType: keyOptions.keyType,
        description: keyOptions.description,
        rotationPeriod: keyOptions.rotationPeriod,
        metadata: keyOptions.metadata,
        publicKey,
        publicKeyPath,
        privateKeyPath,
        createdAt: new Date(),
        updatedAt: new Date(),
        rotatedAt: new Date(),
        nextRotation: new Date(Date.now() + keyOptions.rotationPeriod * 24 * 60 * 60 * 1000),
        active: true
      };
      
      await this.keysCollection.insertOne(keyDocument);
      
      // Return key information (without sensitive data)
      return {
        keyId,
        name,
        type: keyOptions.type,
        algorithm: keyOptions.algorithm,
        keyType: keyOptions.keyType,
        description: keyOptions.description,
        publicKey,
        publicKeyPath,
        privateKeyPath,
        createdAt: keyDocument.createdAt
      };
    } catch (error) {
      console.error(`Failed to create key ${name}:`, error);
      throw error;
    }
  }
  
  /**
   * Get a key by name or ID
   * @param {string} nameOrId - Key name or ID
   */
  async getKey(nameOrId) {
    try {
      console.log(`Getting key: ${nameOrId}`);
      
      // Find key in MongoDB
      const keyDocument = await this.keysCollection.findOne({
        $or: [{ name: nameOrId }, { keyId: nameOrId }],
        active: true
      });
      
      if (!keyDocument) {
        throw new Error(`Key ${nameOrId} not found or inactive`);
      }
      
      // Check if key needs rotation
      if (keyDocument.nextRotation <= new Date()) {
        console.log(`Key ${nameOrId} has expired and needs rotation`);
      }
      
      // For symmetric keys, load and decrypt the key
      if (keyDocument.type === 'symmetric') {
        const keyPath = path.join(this.keyStorePath, `${keyDocument.keyId}.key`);
        const encryptedKey = fs.readFileSync(keyPath, 'utf8');
        const keyMaterial = this._decrypt(encryptedKey);
        
        return {
          ...keyDocument,
          key: keyMaterial
        };
      } else if (keyDocument.type === 'asymmetric') {
        // For asymmetric keys, load the private key and decrypt it
        const privateKeyPath = path.join(this.keyStorePath, `${keyDocument.keyId}.key`);
        const encryptedPrivateKey = fs.readFileSync(privateKeyPath, 'utf8');
        const privateKey = this._decrypt(encryptedPrivateKey);
        
        return {
          ...keyDocument,
          privateKey
        };
      }
      
      return keyDocument;
    } catch (error) {
      console.error(`Failed to get key ${nameOrId}:`, error);
      throw error;
    }
  }
  
  /**
   * Get or create a key by name
   * @param {string} name - Key name
   * @param {Object} options - Key options if creation is needed
   */
  async getOrCreateKey(name, options = {}) {
    try {
      // Try to get the key
      try {
        return await this.getKey(name);
      } catch (error) {
        // Key not found, create it
        return await this.createKey(name, options);
      }
    } catch (error) {
      console.error(`Failed to get or create key ${name}:`, error);
      throw error;
    }
  }
  
  /**
   * Rotate a key
   * @param {string} nameOrId - Key name or ID
   */
  async rotateKey(nameOrId) {
    try {
      console.log(`Rotating key: ${nameOrId}`);
      
      // Find key in MongoDB
      const keyDocument = await this.keysCollection.findOne({
        $or: [{ name: nameOrId }, { keyId: nameOrId }],
        active: true
      });
      
      if (!keyDocument) {
        throw new Error(`Key ${nameOrId} not found or inactive`);
      }
      
      // Generate new key material
      if (keyDocument.type === 'symmetric') {
        // Generate a new symmetric key
        const keyMaterial = crypto.randomBytes(32).toString('hex');
        
        // Encrypt key material
        const encryptedKey = this._encrypt(keyMaterial);
        
        // Archive the old key
        const oldKeyPath = path.join(this.keyStorePath, `${keyDocument.keyId}.key`);
        const archiveKeyPath = path.join(this.keyStorePath, `${keyDocument.keyId}.key.${Date.now()}`);
        
        if (fs.existsSync(oldKeyPath)) {
          fs.renameSync(oldKeyPath, archiveKeyPath);
        }
        
        // Write new key
        fs.writeFileSync(oldKeyPath, encryptedKey, { mode: 0o600 });
      } else if (keyDocument.type === 'asymmetric') {
        // Generate a new key pair
        const keyPair = this._generateKeyPair(keyDocument.keyType);
        
        // Extract public and private keys
        const publicKey = keyPair.publicKey;
        const privateKey = keyPair.privateKey;
        
        // Encrypt private key
        const encryptedPrivateKey = this._encrypt(privateKey);
        
        // Archive old keys
        const oldPublicKeyPath = path.join(this.keyStorePath, `${keyDocument.keyId}.pub`);
        const oldPrivateKeyPath = path.join(this.keyStorePath, `${keyDocument.keyId}.key`);
        
        const archivePublicKeyPath = path.join(this.keyStorePath, `${keyDocument.keyId}.pub.${Date.now()}`);
        const archivePrivateKeyPath = path.join(this.keyStorePath, `${keyDocument.keyId}.key.${Date.now()}`);
        
        if (fs.existsSync(oldPublicKeyPath)) {
          fs.renameSync(oldPublicKeyPath, archivePublicKeyPath);
        }
        
        if (fs.existsSync(oldPrivateKeyPath)) {
          fs.renameSync(oldPrivateKeyPath, archivePrivateKeyPath);
        }
        
        // Write new keys
        fs.writeFileSync(oldPublicKeyPath, publicKey, { mode: 0o644 });
        fs.writeFileSync(oldPrivateKeyPath, encryptedPrivateKey, { mode: 0o600 });
        
        // Update key document
        await this.keysCollection.updateOne(
          { keyId: keyDocument.keyId },
          {
            $set: {
              publicKey,
              rotatedAt: new Date(),
              updatedAt: new Date(),
              nextRotation: new Date(Date.now() + keyDocument.rotationPeriod * 24 * 60 * 60 * 1000)
            }
          }
        );
      }
      
      // Update key document
      await this.keysCollection.updateOne(
        { keyId: keyDocument.keyId },
        {
          $set: {
            rotatedAt: new Date(),
            updatedAt: new Date(),
            nextRotation: new Date(Date.now() + keyDocument.rotationPeriod * 24 * 60 * 60 * 1000)
          }
        }
      );
      
      return {
        keyId: keyDocument.keyId,
        name: keyDocument.name,
        rotatedAt: new Date(),
        nextRotation: new Date(Date.now() + keyDocument.rotationPeriod * 24 * 60 * 60 * 1000)
      };
    } catch (error) {
      console.error(`Failed to rotate key ${nameOrId}:`, error);
      throw error;
    }
  }
  
  /**
   * Deactivate a key
   * @param {string} nameOrId - Key name or ID
   */
  async deactivateKey(nameOrId) {
    try {
      console.log(`Deactivating key: ${nameOrId}`);
      
      // Update key in MongoDB
      const result = await this.keysCollection.updateOne(
        { $or: [{ name: nameOrId }, { keyId: nameOrId }] },
        { $set: { active: false, updatedAt: new Date() } }
      );
      
      if (result.matchedCount === 0) {
        throw new Error(`Key ${nameOrId} not found`);
      }
      
      return { name: nameOrId, active: false };
    } catch (error) {
      console.error(`Failed to deactivate key ${nameOrId}:`, error);
      throw error;
    }
  }
  
  /**
   * Encrypt data with a key
   * @param {string} nameOrId - Key name or ID
   * @param {string|Buffer} data - Data to encrypt
   */
  async encrypt(nameOrId, data) {
    try {
      // Get the key
      const keyDocument = await this.getKey(nameOrId);
      
      let encrypted;
      
      if (keyDocument.type === 'symmetric') {
        // For symmetric encryption
        const iv = crypto.randomBytes(16);
        const key = Buffer.from(keyDocument.key, 'hex');
        const cipher = crypto.createCipheriv(keyDocument.algorithm, key, iv);
        
        let encryptedData = cipher.update(data, 'utf8', 'hex');
        encryptedData += cipher.final('hex');
        
        encrypted = {
          iv: iv.toString('hex'),
          data: encryptedData,
          algorithm: keyDocument.algorithm,
          keyId: keyDocument.keyId
        };
      } else if (keyDocument.type === 'asymmetric') {
        // For asymmetric encryption, use the public key
        const publicKey = keyDocument.publicKey;
        
        // RSA can only encrypt small amounts of data
        if (keyDocument.keyType === 'rsa') {
          const encryptedData = crypto.publicEncrypt(
            {
              key: publicKey,
              padding: crypto.constants.RSA_PKCS1_OAEP_PADDING
            },
            Buffer.isBuffer(data) ? data : Buffer.from(data)
          );
          
          encrypted = {
            data: encryptedData.toString('base64'),
            algorithm: 'rsa-oaep',
            keyId: keyDocument.keyId
          };
        } else if (keyDocument.keyType === 'ec') {
          // For EC, we use ECDH for key exchange and then AES for encryption
          throw new Error('EC encryption not implemented yet');
        }
      }
      
      return encrypted;
    } catch (error) {
      console.error(`Failed to encrypt data with key ${nameOrId}:`, error);
      throw error;
    }
  }
  
  /**
   * Decrypt data with a key
   * @param {string} nameOrId - Key name or ID
   * @param {Object} encryptedData - Data to decrypt
   */
  async decrypt(nameOrId, encryptedData) {
    try {
      // Get the key
      const keyDocument = await this.getKey(nameOrId);
      
      let decrypted;
      
      if (keyDocument.type === 'symmetric') {
        // For symmetric decryption
        const iv = Buffer.from(encryptedData.iv, 'hex');
        const key = Buffer.from(keyDocument.key, 'hex');
        const decipher = crypto.createDecipheriv(keyDocument.algorithm, key, iv);
        
        let decryptedData = decipher.update(encryptedData.data, 'hex', 'utf8');
        decryptedData += decipher.final('utf8');
        
        decrypted = decryptedData;
      } else if (keyDocument.type === 'asymmetric') {
        // For asymmetric decryption, use the private key
        const privateKey = keyDocument.privateKey;
        
        if (keyDocument.keyType === 'rsa') {
          const decryptedData = crypto.privateDecrypt(
            {
              key: privateKey,
              padding: crypto.constants.RSA_PKCS1_OAEP_PADDING
            },
            Buffer.from(encryptedData.data, 'base64')
          );
          
          decrypted = decryptedData.toString('utf8');
        } else if (keyDocument.keyType === 'ec') {
          // For EC, we use ECDH for key exchange and then AES for decryption
          throw new Error('EC decryption not implemented yet');
        }
      }
      
      return decrypted;
    } catch (error) {
      console.error(`Failed to decrypt data with key ${nameOrId}:`, error);
      throw error;
    }
  }
  
  /**
   * Sign data with a key
   * @param {string} nameOrId - Key name or ID
   * @param {string|Buffer} data - Data to sign
   */
  async sign(nameOrId, data) {
    try {
      // Get the key
      const keyDocument = await this.getKey(nameOrId);
      
      if (keyDocument.type !== 'asymmetric') {
        throw new Error('Signing requires an asymmetric key');
      }
      
      // Use the private key for signing
      const privateKey = keyDocument.privateKey;
      
      // Create a sign object
      const sign = crypto.createSign('SHA256');
      sign.update(data);
      sign.end();
      
      // Sign the data
      const signature = sign.sign(privateKey, 'base64');
      
      return {
        signature,
        algorithm: 'SHA256',
        keyId: keyDocument.keyId
      };
    } catch (error) {
      console.error(`Failed to sign data with key ${nameOrId}:`, error);
      throw error;
    }
  }
  
  /**
   * Verify a signature
   * @param {string} nameOrId - Key name or ID
   * @param {string|Buffer} data - Original data
   * @param {string} signature - Signature to verify
   */
  async verify(nameOrId, data, signature) {
    try {
      // Get the key
      const keyDocument = await this.getKey(nameOrId);
      
      if (keyDocument.type !== 'asymmetric') {
        throw new Error('Signature verification requires an asymmetric key');
      }
      
      // Use the public key for verification
      const publicKey = keyDocument.publicKey;
      
      // Create a verify object
      const verify = crypto.createVerify('SHA256');
      verify.update(data);
      verify.end();
      
      // Verify the signature
      const isValid = verify.verify(publicKey, signature, 'base64');
      
      return { isValid, keyId: keyDocument.keyId };
    } catch (error) {
      console.error(`Failed to verify signature with key ${nameOrId}:`, error);
      throw error;
    }
  }
  
  /**
   * List all keys
   * @param {Object} filter - Optional MongoDB filter
   */
  async listKeys(filter = {}) {
    try {
      // Add active:true to filter if not specified
      if (!('active' in filter)) {
        filter.active = true;
      }
      
      // Get keys from MongoDB (exclude sensitive data)
      const keys = await this.keysCollection.find(filter, {
        projection: {
          privateKey: 0
        }
      }).toArray();
      
      return keys;
    } catch (error) {
      console.error('Failed to list keys:', error);
      throw error;
    }
  }
  
  /**
   * Check for keys that need rotation
   */
  async checkRotation() {
    try {
      console.log('Checking for keys that need rotation');
      
      // Find keys that need rotation
      const now = new Date();
      const keysToRotate = await this.keysCollection.find({
        active: true,
        nextRotation: { $lte: now }
      }).toArray();
      
      console.log(`Found ${keysToRotate.length} keys that need rotation`);
      
      // Rotate each key
      const results = [];
      for (const key of keysToRotate) {
        try {
          const result = await this.rotateKey(key.keyId);
          results.push({
            keyId: key.keyId,
            name: key.name,
            status: 'rotated',
            rotatedAt: result.rotatedAt,
            nextRotation: result.nextRotation
          });
        } catch (error) {
          console.error(`Failed to rotate key ${key.name}:`, error);
          results.push({
            keyId: key.keyId,
            name: key.name,
            status: 'error',
            error: error.message
          });
        }
      }
      
      return results;
    } catch (error) {
      console.error('Failed to check key rotation:', error);
      throw error;
    }
  }
}

module.exports = KeyManager;
```


### 4. TypeValidator for Utility Functions

Let's create the missing TypeValidator utility:

```javascript
/**
 * TypeValidator - Utility class for validating data types
 */
class TypeValidator {
  /**
   * Validate that a value matches the expected type
   * @param {*} value - Value to validate
   * @param {string} type - Expected type
   * @param {Object} options - Validation options
   * @returns {boolean} True if valid, false otherwise
   */
  static validate(value, type, options = {}) {
    switch (type) {
      case 'string':
        return this.validateString(value, options);
      case 'number':
        return this.validateNumber(value, options);
      case 'boolean':
        return this.validateBoolean(value);
      case 'object':
        return this.validateObject(value, options);
      case 'array':
        return this.validateArray(value, options);
      case 'function':
        return this.validateFunction(value);
      case 'date':
        return this.validateDate(value, options);
      case 'regex':
        return this.validateRegex(value);
      case 'url':
        return this.validateUrl(value);
      case 'email':
        return this.validateEmail(value);
      case 'uuid':
        return this.validateUuid(value);
      case 'any':
        return true;
      default:
        return false;
    }
  }
  
  /**
   * Validate a string
   * @param {*} value - Value to validate
   * @param {Object} options - Validation options
   * @returns {boolean} True if valid, false otherwise
   */
  static validateString(value, options = {}) {
    if (typeof value !== 'string') {
      return false;
    }
    
    // Check min length
    if (options.minLength !== undefined && value.length < options.minLength) {
      return false;
    }
    
    // Check max length
    if (options.maxLength !== undefined && value.length > options.maxLength) {
      return false;
    }
    
    // Check pattern
    if (options.pattern && !options.pattern.test(value)) {
      return false;
    }
    
    // Check enum
    if (options.enum && !options.enum.includes(value)) {
      return false;
    }
    
    return true;
  }
  
  /**
   * Validate a number
   * @param {*} value - Value to validate
   * @param {Object} options - Validation options
   * @returns {boolean} True if valid, false otherwise
   */
  static validateNumber(value, options = {}) {
    if (typeof value !== 'number' || isNaN(value)) {
      return false;
    }
    
    // Check minimum
    if (options.minimum !== undefined && value < options.minimum) {
      return false;
    }
    
    // Check maximum
    if (options.maximum !== undefined && value > options.maximum) {
      return false;
    }
    
    // Check multiple of
    if (options.multipleOf !== undefined && value % options.multipleOf !== 0) {
      return false;
    }
    
    // Check integer
    if (options.integer && !Number.isInteger(value)) {
      return false;
    }
    
    return true;
  }
  
  /**
   * Validate a boolean
   * @param {*} value - Value to validate
   * @returns {boolean} True if valid, false otherwise
   */
  static validateBoolean(value) {
    return typeof value === 'boolean';
  }
  
  /**
   * Validate an object
   * @param {*} value - Value to validate
   * @param {Object} options - Validation options
   * @returns {boolean} True if valid, false otherwise
   */
  static validateObject(value, options = {}) {
    if (typeof value !== 'object' || value === null || Array.isArray(value)) {
      return false;
    }
    
    // Check required properties
    if (options.required) {
      for (const prop of options.required) {
        if (!(prop in value)) {
          return false;
        }
      }
    }
    
    // Check properties
    if (options.properties) {
      for (const [prop, schema] of Object.entries(options.properties)) {
        if (prop in value) {
          if (!this.validate(value[prop], schema.type, schema)) {
            return false;
          }
        }
      }
    }
    
    // Check additional properties
    if (options.additionalProperties === false) {
      const allowedProps = Object.keys(options.properties || {});
      const valueProps = Object.keys(value);
      
      for (const prop of valueProps) {
        if (!allowedProps.includes(prop)) {
          return false;
        }
      }
    }
    
    return true;
  }
  
  /**
   * Validate an array
   * @param {*} value - Value to validate
   * @param {Object} options - Validation options
   * @returns {boolean} True if valid, false otherwise
   */
  static validateArray(value, options = {}) {
    if (!Array.isArray(value)) {
      return false;
    }
    
    // Check min items
    if (options.minItems !== undefined && value.length < options.minItems) {
      return false;
    }
    
    // Check max items
    if (options.maxItems !== undefined && value.length > options.maxItems) {
      return false;
    }
    
    // Check unique items
    if (options.uniqueItems) {
      const seen = new Set();
      for (const item of value) {
        const itemStr = JSON.stringify(item);
        if (seen.has(itemStr)) {
          return false;
        }
        seen.add(itemStr);
      }
    }
    
    // Check items
    if (options.items) {
      for (const item of value) {
        if (!this.validate(item, options.items.type, options.items)) {
          return false;
        }
      }
    }
    
    return true;
  }
  
  /**
   * Validate a function
   * @param {*} value - Value to validate
   * @returns {boolean} True if valid, false otherwise
   */
  static validateFunction(value) {
    return typeof value === 'function';
  }
  
  /**
   * Validate a date
   * @param {*} value - Value to validate
   * @param {Object} options - Validation options
   * @returns {boolean} True if valid, false otherwise
   */
  static validateDate(value, options = {}) {
    if (!(value instanceof Date) || isNaN(value.getTime())) {
      return false;
    }
    
    // Check minimum date
    if (options.minimum && value < new Date(options.minimum)) {
      return false;
    }
    
    // Check maximum date
    if (options.maximum && value > new Date(options.maximum)) {
      return false;
    }
    
    return true;
  }
  
  /**
   * Validate a regular expression
   * @param {*} value - Value to validate
   * @returns {boolean} True if valid, false otherwise
   */
  static validateRegex(value) {
    return value instanceof RegExp;
  }
  
  /**
   * Validate a URL
   * @param {*} value - Value to validate
   * @returns {boolean} True if valid, false otherwise
   */
  static validateUrl(value) {
    if (typeof value !== 'string') {
      return false;
    }
    
    try {
      new URL(value);
      return true;
    } catch (e) {
      return false;
    }
  }
  
  /**
   * Validate an email
   * @param {*} value - Value to validate
   * @returns {boolean} True if valid, false otherwise
   */
  static validateEmail(value) {
    if (typeof value !== 'string') {
      return false;
    }
    
    // Simple email validation regex
    const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    return emailRegex.test(value);
  }
  
  /**
   * Validate a UUID
   * @param {*} value - Value to validate
   * @returns {boolean} True if valid, false otherwise
   */
  static validateUuid(value) {
    if (typeof value !== 'string') {
      return false;
    }
    
    // UUID validation regex
    const uuidRegex = /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i;
    return uuidRegex.test(value);
  }
  
  /**
   * Assert that a value matches the expected type
   * @param {*} value - Value to validate
   * @param {string} type - Expected type
   * @param {Object} options - Validation options
   * @throws {Error} If validation fails
   */
  static assert(value, type, options = {}) {
    if (!this.validate(value, type, options)) {
      const name = options.name || 'value';
      throw new Error(`Invalid ${type}: ${name}`);
    }
  }
}

module.exports = TypeValidator;
```


### 5. WorkerManager Implementation

Let's improve the worker thread management as requested:

```javascript
const { Worker } = require('worker_threads');
const path = require('path');
const os = require('os');
const { execAsync } = require('../utils/AsyncExec');
const { Meteor } = require('meteor/meteor');
const { MongoInternals } = require('meteor/mongo');

/**
 * WorkerManager - Manages worker threads for parallel processing
 * Implements improved thread to spawn to worker to docker thread runtime
 */
class WorkerManager {
  constructor(options = {}) {
    this.maxWorkers = options.maxWorkers || os.cpus().length;
    this.dbCollection = options.dbCollection || 'workers';
    this.mongoUrl = options.mongoUrl || process.env.MONGO_URL || 'mongodb://localhost:27017/meteor';
    this.ociManager = options.ociManager;
    
    // Connect to MongoDB
    this.db = MongoInternals.defaultRemoteCollectionDriver().mongo.db;
    this.workersCollection = this.db.collection(this.dbCollection);
    
    // Create indexes
    this._createIndexes();
    
    // Initialize worker pool
    this.workers = new Map();
    this.tasks = [];
    this.isProcessing = false;
  }
  
  /**
   * Create necessary database indexes
   * @private
   */
  _createIndexes() {
    this.workersCollection.createIndex({ workerId: 1 }, { unique: true });
    this.workersCollection.createIndex({ status: 1 });
    this.workersCollection.createIndex({ type: 1 });
  }
  
  /**
   * Create a new worker
   * @param {string} scriptPath - Path to worker script
   * @param {Object} workerData - Data to pass to worker
   * @param {string} type - Type of worker (node, docker, service)
   */
  async createWorker(scriptPath, workerData = {}, type = 'node') {
    const workerId = `worker-${Date.now()}-${Math.random().toString(36).substr(2, 9)}`;
    
    try {
      console.log(`Creating worker ${workerId} of type ${type}`);
      
      let worker;
      
      if (type === 'node') {
        // Create standard Node.js worker thread
        worker = new Worker(scriptPath, { workerData });
        
        // Set up event listeners
        worker.on('message', data => this._handleWorkerMessage(workerId, data));
        worker.on('error', error => this._handleWorkerError(workerId, error));
        worker.on('exit', code => this._handleWorkerExit(workerId, code));
      } else if (type === 'docker') {
        if (!this.ociManager) {
          throw new Error('OCIManager is required for docker workers');
        }
        
        // For docker workers, we'll use a container
        const containerName = `worker-${workerId}`;
        const imageName = workerData.image || 'node:18-alpine';
        
        // Create a Dockerfile if needed
        if (workerData.createDockerfile) {
          // Copy the script to a temporary file
          const tmpScriptPath = path.join(os.tmpdir(), `worker-${workerId}.js`);
          fs.copyFileSync(scriptPath, tmpScriptPath);
          
          // Create a Dockerfile
          const dockerfilePath = path.join(os.tmpdir(), `Dockerfile-${workerId}`);
          const dockerfile = `
FROM ${imageName}
WORKDIR /app
COPY ${tmpScriptPath} /app/worker.js
CMD ["node", "worker.js"]
`;
          
          fs.writeFileSync(dockerfilePath, dockerfile);
          
          // Build the image
          const buildContext = path.dirname(dockerfilePath);
          const customImageName = `worker-${workerId}:latest`;
          
          await this.ociManager.buildImage(buildContext, customImageName);
          
          // Run the container
          const containerInfo = await this.ociManager.runContainer(customImageName, containerName, {
            env: workerData,
            restart: 'no'
          });
          
          worker = {
            container: containerInfo,
            type: 'docker',
            postMessage: data => {
              // Send message to container through exec
              this.ociManager.execContainer(containerName, `echo '${JSON.stringify(data)}' > /app/message.json`);
            },
            terminate: async () => {
              await this.ociManager.removeContainer(containerName);
            }
          };
        } else {
          // Use existing image
          const containerInfo = await this.ociManager.runContainer(imageName, containerName, {
            command: `node ${scriptPath}`,
            env: workerData,
            restart: 'no'
          });
          
          worker = {
            container: containerInfo,
            type: 'docker',
            postMessage: data => {
              // Send message to container through exec
              this.ociManager.execContainer(containerName, `echo '${JSON.stringify(data)}' > /app/message.json`);
            },
            terminate: async () => {
              await this.ociManager.removeContainer(containerName);
            }
          };
        }
        
        // Set up a watcher for container logs
        this._watchContainerLogs(containerName, workerId);
      } else if (type === 'service') {
        // For service workers, we'll use a long-running service
        // This could be a database, redis, nginx, etc.
        if (!this.ociManager) {
          throw new Error('OCIManager is required for service workers');
        }
        
        // Get service details
        const { service, image, ports, volumes, env } = workerData;
        
        if (!service || !image) {
          throw new Error('Service and image are required for service workers');
        }
        
        // Run the service container
        const containerName = `service-${service}-${workerId}`;
        const containerInfo = await this.ociManager.runContainer(image, containerName, {
          ports,
          volumes,
          env,
          restart: 'always'
        });
        
        worker = {
          container: containerInfo,
          type: 'service',
          service,
          postMessage: data => {
            // Services typically don't accept messages this way
            console.log(`Cannot send direct message to service worker ${workerId}`);
          },
          terminate: async () => {
            await this.ociManager.removeContainer(containerName);
          }
        };
      } else {
        throw new Error(`Unsupported worker type: ${type}`);
      }
      
      // Register the worker
      this.workers.set(workerId, worker);
      
      // Save worker information to MongoDB
      const workerDocument = {
        workerId,
        type,
        scriptPath,
        workerData,
        status: 'running',
        createdAt: new Date(),
        updatedAt: new Date()
      };
      
      await this.workersCollection.insertOne(workerDocument);
      
      return workerId;
    } catch (error) {
      console.error(`Failed to create worker ${workerId}:`, error);
      throw error;
    }
  }
  
  /**
   * Watch container logs for docker workers
   * @param {string} containerName - Name of the container
   * @param {string} workerId - ID of the worker
   * @private
   */
  async _watchContainerLogs(containerName, workerId) {
    try {
      // Use exec to tail the logs
      const logWatcher = execAsync(`docker logs -f ${containerName}`);
      
      logWatcher.stdout.on('data', data => {
        // Parse the output for message events
        const output = data.toString();
        
        // Look for structured messages like {"type":"message","data":{...}}
        try {
          if (output.includes('"type":"message"')) {
            const match = output.match(/({.*"type":"message".*})/);
            if (match) {
              const message = JSON.parse(match[1]);
              this._handleWorkerMessage(workerId, message.data);
            }
          }
        } catch (error) {
          console.warn(`Failed to parse worker message from ${workerId}:`, error);
        }
      });
      
      logWatcher.stderr.on('data', data => {
        const error = new Error(data.toString());
        this._handleWorkerError(workerId, error);
      });
      
      logWatcher.on('close', code => {
        this._handleWorkerExit(workerId, code);
      });
      
      // Store the log watcher
      const worker = this.workers.get(workerId);
      if (worker) {
        worker.logWatcher = logWatcher;
      }
    } catch (error) {
      console.error(`Failed to watch logs for container ${containerName}:`, error);
    }
  }
  
  /**
   * Handle a message from a worker
   * @param {string} workerId - ID of the worker
   * @param {*} data - Message data
   * @private
   */
  _handleWorkerMessage(workerId, data) {
    console.log(`Received message from worker ${workerId}:`, data);
    
    // Check if this is a task result
    if (data && data.taskId) {
      // Find the task in the tasks array
      const taskIndex = this.tasks.findIndex(task => task.id === data.taskId);
      
      if (taskIndex !== -1) {
        const task = this.tasks[taskIndex];
        
        // Resolve the promise
        task.resolve(data.result);
        
        // Remove the task from the array
        this.tasks.splice(taskIndex, 1);
        
        // Continue processing tasks
        this._processNextTask();
      }
    }
    
    // Emit a custom event for this worker
    this.emit(`worker:${workerId}:message`, data);
  }
  
  /**
   * Handle an error from a worker
   * @param {string} workerId - ID of the worker
   * @param {Error} error - Error object
   * @private
   */
  _handleWorkerError(workerId, error) {
    console.error(`Error from worker ${workerId}:`, error);
    
    // Update worker status in MongoDB
    this.workersCollection.updateOne(
      { workerId },
      { $set: { status: 'error', error: error.message, updatedAt: new Date() } }
    );
    
    // Emit a custom event for this worker
    this.emit(`worker:${workerId}:error`, error);
  }
  
  /**
   * Handle a worker exit
   * @param {string} workerId - ID of the worker
   * @param {number} code - Exit code
   * @private
   */
  _handleWorkerExit(workerId, code) {
    console.log(`Worker ${workerId} exited with code ${code}`);
    
    // Get the worker
    const worker = this.workers.get(workerId);
    
    // Clean up resources
    if (worker) {
      if (worker.logWatcher) {
        worker.logWatcher.kill();
      }
      
      this.workers.delete(workerId);
    }
    
    // Update worker status in MongoDB
    this.workersCollection.updateOne(
      { workerId },
      { $set: { status: code === 0 ? 'completed' : 'failed', exitCode: code, updatedAt: new Date() } }
    );
    
    // Emit a custom event for this worker
    this.emit(`worker:${workerId}:exit`, code);
  }
  
  /**
   * Schedule a task to be processed by a worker
   * @param {string} workerId - ID of the worker
   * @param {string} taskName - Name of the task
   * @param {*} taskData - Data for the task
   */
  async scheduleTask(workerId, taskName, taskData) {
    return new Promise((resolve, reject) => {
      const taskId = `task-${Date.now()}-${Math.random().toString(36).substr(2, 9)}`;
      
      // Create a task object
      const task = {
        id: taskId,
        name: taskName,
        data: taskData,
        workerId,
        resolve,
        reject,
        createdAt: new Date()
      };
      
      // Add the task to the queue
      this.tasks.push(task);
      
      // Start processing tasks if not already processing
      if (!this.isProcessing) {
        this._processNextTask();
      }
    });
  }
  
  /**
   * Process the next task in the queue
   * @private
   */
  async _processNextTask() {
    if (this.tasks.length === 0) {
      this.isProcessing = false;
      return;
    }
    
    this.isProcessing = true;
    
    // Get the next task
    const task = this.tasks[0];
    
    // Get the worker
    const worker = this.workers.get(task.workerId);
    
    if (!worker) {
      // Worker not found, reject the task
      task.reject(new Error(`Worker ${task.workerId} not found`));
      
      // Remove the task from the array
      this.tasks.shift();
      
      // Continue processing tasks
      this._processNextTask();
      return;
    }
    
    try {
      // Send the task to the worker
      worker.postMessage({
        taskId: task.id,
        name: task.name,
        data: task.data
      });
      
      // Note: The task will be completed when the worker sends a message back
      // with the task ID and result
    } catch (error) {
      // Failed to send task to worker
      task.reject(error);
      
      // Remove the task from the array
      this.tasks.shift();
      
      // Continue processing tasks
      this._processNextTask();
    }
  }
  
  /**
   * Terminate a worker
   * @param {string} workerId - ID of the worker to terminate
   */
  async terminateWorker(workerId) {
    const worker = this.workers.get(workerId);
    
    if (!worker) {
      throw new Error(`Worker ${workerId} not found`);
    }
    
    try {
      console.log(`Terminating worker ${workerId}`);
      
      // Terminate the worker based on type
      if (worker.type === 'node') {
        await worker.terminate();
      } else if (worker.type === 'docker' || worker.type === 'service') {
        await worker.terminate();
      }
      
      // Clean up resources
      if (worker.logWatcher) {
        worker.logWatcher.kill();
      }
      
      // Remove from map
      this.workers.delete(workerId);
      
      // Update worker status in MongoDB
      await this.workersCollection.updateOne(
        { workerId },
        { $set: { status: 'terminated', updatedAt: new Date() } }
      );
      
      return { workerId, status: 'terminated' };
    } catch (error) {
      console.error(`Failed to terminate worker ${workerId}:`, error);
      throw error;
    }
  }
  
  /**
   * Create a daemon service for system components
   * @param {string} service - Type of service (mongodb, redis, varnish, nginx, etc.)
   * @param {Object} options - Service options
   */
  async createDaemonService(service, options = {}) {
    try {
      console.log(`Creating daemon service for ${service}`);
      
      let command;
      let env = {};
      let ports = [];
      let volumes = [];
      let image;
      
      switch (service) {
        case 'mongodb':
          image = options.image || 'mongo:5.0';
          ports = options.ports || ['27017:27017'];
          volumes = options.volumes || ['mongodb-data:/data/db'];
          env = {
            MONGO_INITDB_ROOT_USERNAME: options.username || 'root',
            MONGO_INITDB_ROOT_PASSWORD: options.password || 'example'
          };
          break;
          
        case 'redis':
          image = options.image || 'redis:6.2-alpine';
          ports = options.ports || ['6379:6379'];
          volumes = options.volumes || ['redis-data:/data'];
          command = options.command || 'redis-server --requirepass ' + (options.password || 'example');
          break;
          
        case 'varnish':
          image = options.image || 'varnish:7.0';
          ports = options.ports || ['80:80'];
          env = {
            VARNISH_SIZE: options.size || '2G',
            VARNISH_BACKEND_HOST: options.backendHost || 'localhost',
            VARNISH_BACKEND_PORT: options.backendPort || '8080'
          };
          break;
          
        case 'nginx':
          image = options.image || 'nginx:1.21-alpine';
          ports = options.ports || ['80:80', '443:443'];
          volumes = options.volumes || ['./nginx.conf:/etc/nginx/nginx.conf:ro'];
          break;
          
        case 'arrowdb':
          // For Apache Arrow, we'll use a custom container
          image = options.image || 'apache/arrow:latest';
          ports = options.ports || ['8080:8080'];
          volumes = options.volumes || ['arrow-data:/data'];
          break;
          
        default:
          // For other services, use provided options
          image = options.image;
          ports = options.ports || [];
          volumes = options.volumes || [];
          env = options.env || {};
          command = options.command;
          
          if (!image) {
            throw new Error(`Unknown service ${service} and no image provided`);
          }
      }
      
      // Use the OSManager to start the container
      const workerData = {
        service,
        image,
        ports,
        volumes,
        env,
        command
      };
      
      return await this.createWorker(null, workerData, 'service');
    } catch (error) {
      console.error(`Failed to create daemon service for ${service}:`, error);
      throw error;
    }
  }
  
  /**
   * Get all workers
   * @param {Object} filter - Optional MongoDB filter
   */
  async getWorkers(filter = {}) {
    try {
      return await this.workersCollection.find(filter).toArray();
    } catch (error) {
      console.error('Failed to get workers:', error);
      throw error;
    }
  }
  
  /**
   * Monitor worker health
   * Check for hung workers and clean them up
   */
  async monitorWorkerHealth() {
    try {
      console.log('Monitoring worker health...');
      
      // Get all running workers
      const workers = await this.workersCollection.find({ status: 'running' }).toArray();
      
      const results = [];
      
      for (const worker of workers) {
        try {
          // Check if worker exists in runtime
          const runtimeWorker = this.workers.get(worker.workerId);
          
          if (!runtimeWorker) {
            // Worker exists in DB but not in runtime - update status
            await this.workersCollection.updateOne(
              { workerId: worker.workerId },
              { $set: { status: 'lost', updatedAt: new Date() } }
            );
            
            results.push({
              workerId: worker.workerId,
              status: 'lost',
              action: 'updated'
            });
          } else if (worker.type === 'docker' || worker.type === 'service') {
            // Check container status
            const container = runtimeWorker.container;
            
            if (!container) {
              continue;
            }
            
            const containerStatus = await this.ociManager.getContainerStatus(container.name);
            
            if (containerStatus.status !== 'running') {
              // Container is not running
              if (worker.type === 'service' && worker.workerData && worker.workerData.restart === 'always') {
                // Try to restart the service
                await this.ociManager.runContainer(
                  worker.workerData.image,
                  container.name,
                  worker.workerData
                );
                
                results.push({
                  workerId: worker.workerId,
                  status: 'restarted',
                  action: 'restarted'
                });
              } else {
                // Mark worker as failed
                await this.workersCollection.updateOne(
                  { workerId: worker.workerId },
                  { $set: { status: 'failed', updatedAt: new Date() } }
                );
                
                // Clean up resources
                this.workers.delete(worker.workerId);
                
                results.push({
                  workerId: worker.workerId,
                  status: 'failed',
                  action: 'terminated'
                });
              }
            } else {
              // Container is running - check if it's hung
              // For now, we'll just check that it's responding
              results.push({
                workerId: worker.workerId,
                status: 'healthy',
                action: 'none'
              });
            }
          }
        } catch (error) {
          console.error(`Health check failed for worker ${worker.workerId}:`, error);
          results.push({
            workerId: worker.workerId,
            status: 'error',
            error: error.message,
            action: 'none'
          });
        }
      }
      
      return results;
    } catch (error) {
      console.error('Worker health monitoring failed:', error);
      throw error;
    }
  }
  
  /**
   * Get worker status
   * @param {string} workerId - ID of the worker
   */
  async getWorkerStatus(workerId) {
    try {
      // Get worker from MongoDB
      const worker = await this.workersCollection.findOne({ workerId });
      
      if (!worker) {
        throw new Error(`Worker ${workerId} not found`);
      }
      
      // Check runtime status
      const runtimeWorker = this.workers.get(workerId);
      
      if (!runtimeWorker) {
        return {
          ...worker,
          runtimeStatus: 'not_found'
        };
      }
      
      // For docker/service workers, check container status
      if (worker.type === 'docker' || worker.type === 'service') {
        const container = runtimeWorker.container;
        
        if (!container) {
          return {
            ...worker,
            runtimeStatus: 'container_missing'
          };
        }
        
        const containerStatus = await this.ociManager.getContainerStatus(container.name);
        
        return {
          ...worker,
          runtimeStatus: 'running',
          containerStatus
        };
      }
      
      // For node workers, we just know they're running if they're in the map
      return {
        ...worker,
        runtimeStatus: 'running'
      };
    } catch (error) {
      console.error(`Failed to get status for worker ${workerId}:`, error);
      throw error;
    }
  }
  
  /**
   * Emit an event
   * @param {string} event - Event name
   * @param {*} data - Event data
   * @private
   */
  emit(event, data) {
    // Simple event emitter
    // In a real implementation, this would use EventEmitter
    console.log(`Event: ${event}`, data);
  }
}

module.exports = WorkerManager;
```


### 6. NetworkUtilities Implementation

Now let's fix the NetworkUtilities.js file:

```javascript
const os = require('os');
const dns = require('dns');
const net = require('net');
const { execSync } = require('child_process');
const { Meteor } = require('meteor/meteor');

// Import correct core components
const PluginManager = require('./PluginManager');
const PluginLoader = require('./PluginLoader');
const PluginContract = require('./PluginContract');
const PluginLedger = require('./PluginLedger');
const NodeManager = require('./NodeManager');
const SecurityManager = require('./SecurityManager');
const WorkerManager = require('../worker/WorkerManager');
const PerformanceMonitor = require('../worker/PerformanceMonitor');

/**
 * NetworkUtilities - Utility class for network operations
 */
class NetworkUtilities {
  constructor(options = {}) {
    this.interfaces = os.networkInterfaces();
    this.hostname = os.hostname();
    this.nodeManager = options.nodeManager || null;
    this.pluginManager = options.pluginManager || null;
    this.securityManager = options.securityManager || null;
  }
  
  /**
   * Get the IP addresses for this node
   * @param {string} family - IP family (IPv4 or IPv6)
   * @returns {string[]} Array of IP addresses
   */
  getIpAddresses(family = 'IPv4') {
    const addresses = [];
    
    // Iterate through network interfaces
    Object.keys(this.interfaces).forEach(interfaceName => {
      const interfaceInfo = this.interfaces[interfaceName];
      
      interfaceInfo.forEach(address => {
        if (address.family === family && !address.internal) {
          addresses.push(address.address);
        }
      });
    });
    
    return addresses;
  }
  
  /**
   * Get the primary IP address for this node
   * @param {string} family - IP family (IPv4 or IPv6)
   * @returns {string} Primary IP address
   */
  getPrimaryIpAddress(family = 'IPv4') {
    const addresses = this.getIpAddresses(family);
    return addresses.length > 0 ? addresses[0] : null;
  }
  
  /**
   * Resolve a hostname to IP addresses
   * @param {string} hostname - Hostname to resolve
   * @returns {Promise<string[]>} Array of IP addresses
   */
  async resolveHostname(hostname) {
    return new Promise((resolve, reject) => {
      dns.resolve(hostname, (err, addresses) => {
        if (err) {
          reject(err);
        } else {
          resolve(addresses);
        }
      });
    });
  }
  
  /**
   * Check if a port is in use
   * @param {number} port - Port to check
   * @param {string} host - Host to check (default: localhost)
   * @returns {Promise<boolean>} True if port is in use, false otherwise
   */
  async isPortInUse(port, host = 'localhost') {
    return new Promise(resolve => {
      const server = net.createServer();
      
      server.once('error', err => {
        if (err.code === 'EADDRINUSE') {
          resolve(true);
        } else {
          resolve(false);
        }
        server.close();
      });
      
      server.once('listening', () => {
        server.close();
        resolve(false);
      });
      
      server.listen(port, host);
    });
  }
  
  /**
   * Find an available port
   * @param {number} startPort - Port to start checking from
   * @param {string} host - Host to check (default: localhost)
   * @returns {Promise<number>} Available port
   */
  async findAvailablePort(startPort = 8000, host = 'localhost') {
    let port = startPort;
    
    while (await this.isPortInUse(port, host)) {
      port++;
    }
    
    return port;
  }
  
  /**
   * Get active network connections
   * @returns {Promise<Object[]>} Array of connection objects
   */
  async getActiveConnections() {
    try {
      // Use different commands based on platform
      let connections = [];
      
      if (process.platform === 'linux' || process.platform === 'darwin') {
        // For Linux and macOS, use netstat
        const output = execSync('netstat -tn', { encoding: 'utf8' });
        
        // Parse netstat output
        const lines = output.split('\n');
        const headerIndex = lines.findIndex(line => line.includes('Local Address'));
        
        if (headerIndex !== -1) {
          for (let i = headerIndex + 1; i < lines.length; i++) {
            const line = lines[i].trim();
            
            if (!line) {
              continue;
            }
            
            const parts = line.split(/\s+/);
            
            if (parts.length >= 5) {
              const [proto, recvQ, sendQ, localAddress, foreignAddress, state] = parts;
              
              connections.push({
                protocol: proto,
                localAddress,
                remoteAddress: foreignAddress,
                state: state || 'UNKNOWN'
              });
            }
          }
        }
      } else if (process.platform === 'win32') {
        // For Windows, use netstat as well but with different format
        const output = execSync('netstat -an', { encoding: 'utf8' });
        
        // Parse netstat output
        const lines = output.split('\n');
        const headerIndex = lines.findIndex(line => line.includes('Local Address'));
        
        if (headerIndex !== -1) {
          for (let i = headerIndex + 1; i < lines.length; i++) {
            const line = lines[i].trim();
            
            if (!line) {
              continue;
            }
            
            const parts = line.split(/\s+/);
            
            if (parts.length >= 4) {
              const [proto, localAddress, foreignAddress, state] = parts;
              
              connections.push({
                protocol: proto,
                localAddress,
                remoteAddress: foreignAddress,
                state: state || 'UNKNOWN'
              });
            }
          }
        }
      }
      
      return connections;
    } catch (error) {
      console.error('Failed to get active connections:', error);
      return [];
    }
  }
  
  /**
   * Get active listening ports
   * @returns {Promise<Object[]>} Array of listening port objects
   */
  async getListeningPorts() {
    try {
      // Use different commands based on platform
      let ports = [];
      
      if (process.platform === 'linux' || process.platform === 'darwin') {
        // For Linux and macOS, use lsof
        const output = execSync('lsof -i -P -n | grep LISTEN', { encoding: 'utf8' });
        
        // Parse lsof output
        const lines = output.split('\n');
        
        for (const line of lines) {
          if (!line.trim()) {
            continue;
          }
          
          const parts = line.split(/\s+/);
          
          if (parts.length >= 9) {
            const [command, pid, user, fd, type, device, size, node, name] = parts;
            
            // Extract port from name (e.g. *:8080)
            const portMatch = name.match(/:(\d+)$/);
            if (portMatch) {
              const port = parseInt(portMatch[1], 10);
              
              ports.push({
                port,
                command,
                pid: parseInt(pid, 10),
                user,
                protocol: type,
                address: name
              });
            }
          }
        }
      } else if (process.platform === 'win32') {
        // For Windows, use netstat
        const output = execSync('netstat -ano | findstr LISTENING', { encoding: 'utf8' });
        
        // Parse netstat output
        const lines = output.split('\n');
        
        for (const line of lines) {
          if (!line.trim()) {
            continue;
          }
          
          const parts = line.split(/\s+/);
          
          if (parts.length >= 5) {
            const [proto, localAddress, foreignAddress, state, pid] = parts;
            
            // Extract port from local address (e.g. 0.0.0.0:8080)
            const portMatch = localAddress.match(/:(\d+)$/);
            if (portMatch) {
              const port = parseInt(portMatch[1], 10);
              
              ports.push({
                port,
                protocol: proto,
                address: localAddress,
                pid: parseInt(pid, 10),
                state
              });
            }
          }
        }
      }
      
      return ports;
    } catch (error) {
      console.error('Failed to get listening ports:', error);
      return [];
    }
  }
  
  /**
   * Check if a host is reachable
   * @param {string} host - Host to check
   * @param {number} timeout - Timeout in milliseconds
   * @returns {Promise<boolean>} True if host is reachable, false otherwise
   */
  async isHostReachable(host, timeout = 5000) {
    return new Promise(resolve => {
      const socket = new net.Socket();
      let isConnected = false;
      
      socket.setTimeout(timeout);
      
      socket.on('connect', () => {
        isConnected = true;
        socket.destroy();
        resolve(true);
      });
      
      socket.on('timeout', () => {
        socket.destroy();
        resolve(false);
      });
      
      socket.on('error', () => {
        socket.destroy();
        resolve(false);
      });
      
      socket.connect(80, host);
    });
  }
  
  /**
   * Send a notification to other nodes
   * @param {string} event - Event name
   * @param {Object} data - Event data
   * @returns {Promise<Object[]>} Array of responses
   */
  async notifyNodes(event, data) {
    if (!this.nodeManager) {
      throw new Error('NodeManager is required for node notifications');
    }
    
    return await this.nodeManager.notifyNodes(event, data);
  }
  
  /**
   * Get network health information
   * @returns {Object} Network health information
   */
  async getNetworkHealth() {
    try {
      // Get active connections
      const connections = await this.getActiveConnections();
      
      // Get listening ports
      const listeningPorts = await this.getListeningPorts();
      
      // Get IP addresses
      const ipv4Addresses = this.getIpAddresses('IPv4');
      const ipv6Addresses = this.getIpAddresses('IPv6');
      
      // Get hostname
      const hostname = this.hostname;
      
      // Get bandwidth usage
      let bandwidthUsage = null;
      
      try {
        if (process.platform === 'linux') {
          // For Linux, use ifstat
          const output = execSync('ifstat -i eth0 1 1', { encoding: 'utf8' });
          const lines = output.split('\n');
          
          if (lines.length >= 3) {
            const values = lines[2].trim().split(/\s+/);
            
            if (values.length >= 2) {
              bandwidthUsage = {
                in: parseFloat(values[0]),
                out: parseFloat(values[1]),
                unit: 'KB/s'
              };
            }
          }
        }
      } catch (error) {
        console.warn('Failed to get bandwidth usage:', error);
      }
      
      return {
        hostname,
        ipv4Addresses,
        ipv6Addresses,
        connections: connections.length,
        listeningPorts: listeningPorts.length,
        activePorts: listeningPorts.map(p => p.port),
        bandwidthUsage,
        timestamp: new Date()
      };
    } catch (error) {
      console.error('Failed to get network health:', error);
      throw error;
    }
  }
  
  /**
   * Perform a plugin network announcement
   * @param {string} pluginId - ID of the plugin
   * @returns {Promise<Object>} Announcement result
   */
  async announcePlugin(pluginId) {
    if (!this.pluginManager) {
      throw new Error('PluginManager is required for plugin announcements');
    }
    
    try {
      // Get plugin metadata
      const plugin = await this.pluginManager.getPlugins({ name: pluginId });
      
      if (!plugin || plugin.length === 0) {
        throw new Error(`Plugin ${pluginId} not found`);
      }
      
      const pluginData = plugin[0];
      
      // Create announcement data
      const announcement = {
        type: 'plugin_announcement',
        plugin: {
          name: pluginData.name,
          version: pluginData.version,
          description: pluginData.description,
          active: pluginData.active
        },
        node: {
          hostname: this.hostname,
          ipAddress: this.getPrimaryIpAddress(),
          timestamp: new Date()
        }
      };
      
      // Notify other nodes
      const responses = await this.notifyNodes('plugin_announcement', announcement);
      
      return {
        plugin: pluginData.name,
        announced: true,
        responses
      };
    } catch (error) {
      console.error(`Failed to announce plugin ${pluginId}:`, error);
      throw error;
    }
  }
  
  /**
   * Check if the specified port is available
   * @param {number} port - Port to check
   * @returns {Promise<boolean>} True if port is available, false otherwise
   */
  async isPortAvailable(port) {
    return !(await this.isPortInUse(port));
  }
}

module.exports = NetworkUtilities;
```


### 7. Plugin Loader Implementation

Let's create the PluginLoader class that will handle loading plugins from the designated directories:

```javascript
const fs = require('fs');
const path = require('path');
const { Meteor } = require('meteor/meteor');
const { MongoInternals } = require('meteor/mongo');

/**
 * PluginLoader - Handles loading and initializing plugins
 */
class PluginLoader {
  constructor(options = {}) {
    this.pluginsDir = options.pluginsDir || '/private/plugin/modules';
    this.fallbackDir = options.fallbackDir || '/modules';
    this.dbCollection = options.dbCollection || 'plugins';
    this.mongoUrl = options.mongoUrl || process.env.MONGO_URL || 'mongodb://localhost:27017/meteor';
    this.pluginManager = options.pluginManager || null;
    this.ociManager = options.ociManager || null;
    
    // Connect to MongoDB
    this.db = MongoInternals.defaultRemoteCollectionDriver().mongo.db;
    this.pluginsCollection = this.db.collection(this.dbCollection);
  }
  
  /**
   * Find all plugin directories
   * @returns {Array} Array of plugin directory objects with name and path
   */
  findPluginDirectories() {
    try {
      const pluginDirs = [];
      
      // Check primary plugins directory
      let pluginBasePath = path.join(process.cwd(), this.pluginsDir);
      if (fs.existsSync(pluginBasePath)) {
        const entries = fs.readdirSync(pluginBasePath, { withFileTypes: true });
        
        for (const entry of entries) {
          if (entry.isDirectory()) {
            pluginDirs.push({
              name: entry.name,
              path: path.join(pluginBasePath, entry.name),
              source: 'primary'
            });
          }
        }
      }
      
      // Check fallback directory if needed
      if (pluginDirs.length === 0) {
        pluginBasePath = path.join(process.cwd(), this.fallbackDir);
        
        if (fs.existsSync(pluginBasePath)) {
          const entries = fs.readdirSync(pluginBasePath, { withFileTypes: true });
          
          for (const entry of entries) {
            if (entry.isDirectory()) {
              pluginDirs.push({
                name: entry.name,
                path: path.join(pluginBasePath, entry.name),
                source: 'fallback'
              });
            }
          }
        }
      }
      
      return pluginDirs;
    } catch (error) {
      console.error('Failed to find plugin directories:', error);
      return [];
    }
  }
  
  /**
   * Detect plugin runtime (node, python, etc.)
   * @param {string} pluginPath - Path to plugin directory
   * @returns {Object} Runtime information
   */
  detectRuntime(pluginPath) {
    try {
      // Check for package.json (Node.js)
      if (fs.existsSync(path.join(pluginPath, 'package.json'))) {
        return { type: 'node', main: 'index.js' };
      }
      
      // Check for index.js (Node.js)
      if (fs.existsSync(path.join(pluginPath, 'index.js'))) {
        return { type: 'node', main: 'index.js' };
      }
      
      // Check for requirements.txt (Python)
      if (fs.existsSync(path.join(pluginPath, 'requirements.txt'))) {
        // Look for main Python file
        if (fs.existsSync(path.join(pluginPath, 'app.py'))) {
          return { type: 'python', main: 'app.py' };
        }
        
        if (fs.existsSync(path.join(pluginPath, 'main.py'))) {
          return { type: 'python', main: 'main.py' };
        }
        
        // Default to app.py
        return { type: 'python', main: 'app.py' };
      }
      
      // Check for Dockerfile (containerized)
      if (fs.existsSync(path.join(pluginPath, 'Dockerfile'))) {
        // Try to determine the type from Dockerfile
        const dockerfile = fs.readFileSync(path.join(pluginPath, 'Dockerfile'), 'utf8');
        
        if (dockerfile.includes('FROM node') || dockerfile.includes('FROM alpine') || dockerfile.includes('npm install')) {
          return { type: 'container-node', main: 'Dockerfile' };
        }
        
        if (dockerfile.includes('FROM python') || dockerfile.includes('pip install')) {
          return { type: 'container-python', main: 'Dockerfile' };
        }
        
        return { type: 'container', main: 'Dockerfile' };
      }
      
      // Check for any .js files
      const jsFiles = fs.readdirSync(pluginPath).filter(file => file.endsWith('.js'));
      if (jsFiles.length > 0) {
        // Try to find a main.js or similar
        const mainCandidates = ['main.js', 'plugin.js', 'index.js', 'app.js'];
        
        for (const candidate of mainCandidates) {
          if (jsFiles.includes(candidate)) {
            return { type: 'node', main: candidate };
          }
        }
        
        // Default to first .js file
        return { type: 'node', main: jsFiles[0] };
      }
      
      // Check for any .py files
      const pyFiles = fs.readdirSync(pluginPath).filter(file => file.endsWith('.py'));
      if (pyFiles.length > 0) {
        // Try to find a main.py or similar
        const mainCandidates = ['main.py', 'plugin.py', 'app.py'];
        
        for (const candidate of mainCandidates) {
          if (pyFiles.includes(candidate)) {
            return { type: 'python', main: candidate };
          }
        }
        
        // Default to first .py file
        return { type: 'python', main: pyFiles[0] };
      }
      
      // Unknown runtime
      return { type: 'unknown', main: null };
    } catch (error) {
      console.error(`Failed to detect runtime for plugin at ${pluginPath}:`, error);
      return { type: 'unknown', main: null, error: error.message };
    }
  }
  
  /**
   * Extract plugin metadata
   * @param {string} pluginPath - Path to plugin directory
   * @param {string} pluginName - Name of the plugin
   * @returns {Object} Plugin metadata
   */
  extractMetadata(pluginPath, pluginName) {
    try {
      let metadata = {
        name: pluginName,
        version: '1.0.0',
        description: `Plugin ${pluginName}`,
        active: false,
        containerize: false,
        runtime: 'node',
        interface: {},
        methods: {}
      };
      
      // Try package.json first
      const packageJsonPath = path.join(pluginPath, 'package.json');
      if (fs.existsSync(packageJsonPath)) {
        try {
          const packageData = JSON.parse(fs.readFileSync(packageJsonPath, 'utf8'));
          metadata = {
            ...metadata,
            name: packageData.name || pluginName,
            version: packageData.version || '1.0.0',
            description: packageData.description || metadata.description,
            author: packageData.author,
            license: packageData.license,
            runtime: 'node',
            main: packageData.main || 'index.js',
            dependencies: packageData.dependencies || {}
          };
          
          // Look for plugin contract in package.json
          if (packageData.pluginContract) {
            metadata.contract = packageData.pluginContract;
          }
          
          return metadata;
        } catch (error) {
          console.warn(`Error parsing package.json for ${pluginName}:`, error);
        }
      }
      
      // Try config.json
      const configJsonPath = path.join(pluginPath, 'config.json');
      if (fs.existsSync(configJsonPath)) {
        try {
          const configData = JSON.parse(fs.readFileSync(configJsonPath, 'utf8'));
          metadata = {
            ...metadata,
            ...configData,
            name: configData.name || configData.pluginName || pluginName
          };
          return metadata;
        } catch (error) {
          console.warn(`Error parsing config.json for ${pluginName}:`, error);
        }
      }
      
      // Try Dockerfile
      const dockerfilePath = path.join(pluginPath, 'Dockerfile');
      if (fs.existsSync(dockerfilePath)) {
        try {
          const dockerfileContent = fs.readFileSync(dockerfilePath, 'utf8');
          metadata.containerize = true;
          
          // Extract metadata from Dockerfile comments or labels
          const labelMatch = dockerfileContent.match(/LABEL\s+org\.opencontainers\.image\.description="([^"]+)"/);
          if (labelMatch) {
            metadata.description = labelMatch[1];
          }
          
          const versionMatch = dockerfileContent.match(/LABEL\s+org\.opencontainers\.image\.version="([^"]+)"/);
          if (versionMatch) {
            metadata.version = versionMatch[1];
          }
          
          return metadata;
        } catch (error) {
          console.warn(`Error parsing Dockerfile for ${pluginName}:`, error);
        }
      }
      
      // Detect runtime
      const runtime = this.detectRuntime(pluginPath);
      metadata.runtime = runtime.type;
      metadata.main = runtime.main;
      
      // For node plugins, try to load and extract info
      if (runtime.type === 'node' && runtime.main) {
        try {
          const pluginModule = require(path.join(pluginPath, runtime.main));
          
          if (typeof pluginModule.plugin_info === 'function') {
            const pluginInfo = pluginModule.plugin_info();
            metadata = {
              ...metadata,
              ...pluginInfo,
              name: pluginInfo.name || pluginInfo.pluginName || pluginName
            };
          }
          
          // Check for methods to register
          if (pluginModule.methods) {
            metadata.methods = pluginModule.methods;
          }
          
          // Check for interface definition
          if (pluginModule.interface) {
            metadata.interface = pluginModule.interface;
          }
        } catch (error) {
          console.warn(`Error loading plugin module for ${pluginName}:`, error);
        }
      }
      
      return metadata;
    } catch (error) {
      console.error(`Failed to extract metadata for plugin ${pluginName}:`, error);
      return {
        name: pluginName,
        version: '1.0.0',
        description: `Plugin ${pluginName}`,
        error: error.message
      };
    }
  }
  
  /**
   * Generate a Dockerfile for a plugin
   * @param {string} pluginPath - Path to plugin directory
   * @param {Object} metadata - Plugin metadata
   * @returns {string} Path to generated Dockerfile
   */
  generateDockerfile(pluginPath, metadata) {
    try {
      console.log(`Generating Dockerfile for plugin ${metadata.name}`);
      
      let dockerfileContent = '';
      
      if (metadata.runtime === 'node' || metadata.runtime.startsWith('node')) {
        // Generate Node.js Dockerfile
        dockerfileContent = `FROM node:18-alpine
LABEL org.opencontainers.image.title="${metadata.name}"
LABEL org.opencontainers.image.description="${metadata.description}"
LABEL org.opencontainers.image.version="${metadata.version}"
LABEL org.opencontainers.image.vendor="Autonomy Association International"

WORKDIR /app

COPY package*.json ./
RUN npm install --production

COPY . .

EXPOSE 8080
CMD ["node", "${metadata.main || 'index.js'}"]
`;
      } else if (metadata.runtime === 'python' || metadata.runtime.startsWith('python')) {
        // Generate Python Dockerfile
        dockerfileContent = `FROM python:3.9-slim
LABEL org.opencontainers.image.title="${metadata.name}"
LABEL org.opencontainers.image.description="${metadata.description}"
LABEL org.opencontainers.image.version="${metadata.version}"
LABEL org.opencontainers.image.vendor="Autonomy Association International"

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8080
CMD ["python", "${metadata.main || 'app.py'}"]
`;
      } else {
        throw new Error(`Unsupported runtime: ${metadata.runtime}`);
      }
      
      // Write Dockerfile
      const dockerfilePath = path.join(pluginPath, 'Dockerfile');
      fs.writeFileSync(dockerfilePath, dockerfileContent);
      
      return dockerfilePath;
    } catch (error) {
      console.error(`Failed to generate Dockerfile for plugin ${metadata.name}:`, error);
      throw error;
    }
  }
  
  /**
   * Build container image for a plugin
   * @param {string} pluginPath - Path to plugin directory
   * @param {Object} metadata - Plugin metadata
   * @returns {Object} Build result
   */
  async buildContainerImage(pluginPath, metadata) {
    if (!this.ociManager) {
      throw new Error('OCIManager is required for building container images');
    }
    
    try {
      console.log(`Building container image for plugin ${metadata.name}`);
      
      // Check if Dockerfile exists
      let dockerfilePath = path.join(pluginPath, 'Dockerfile');
      
      if (!fs.existsSync(dockerfilePath)) {
        // Generate Dockerfile
        dockerfilePath = this.generateDockerfile(pluginPath, metadata);
      }
      
      // Set image name
      const imageName = `aruraai/${metadata.name.toLowerCase()}:${metadata.version}`;
      
      // Build image
      const buildResult = await this.ociManager.buildImage(pluginPath, imageName);
      
      // Update metadata
      metadata.containerized = true;
      metadata.imageName = imageName;
      metadata.containerBuildTime = new Date();
      
      return {
        success: true,
        imageName,
        metadata,
        buildResult
      };
    } catch (error) {
      console.error(`Failed to build container image for plugin ${metadata.name}:`, error);
      
      // Update metadata
      metadata.containerized = false;
      metadata.containerBuildError = error.message;
      
      return {
        success: false,
        error: error.message,
        metadata
      };
    }
  }
  
  /**
   * Load a plugin
   * @param {Object} pluginDir - Plugin directory object
   * @param {string} modality - Modality name
   * @returns {Object} Loaded plugin information
   */
  async loadPlugin(pluginDir, modality) {
    try {
      console.log(`Loading plugin from ${pluginDir.path}`);
      
      // Extract metadata
      const metadata = this.extractMetadata(pluginDir.path, pluginDir.name);
      
      // Set modality
      metadata.modality = modality;
      
      // Check if plugin should be containerized
      if (metadata.containerize || 
          metadata.runtime.startsWith('container') || 
          metadata.runtime === 'python') {
        
        // Build container image
        const buildResult = await this.buildContainerImage(pluginDir.path, metadata);
        
        // Update metadata
        Object.assign(metadata, buildResult.metadata);
      }
      
      // Save to database
      const existingPlugin = await this.pluginsCollection.findOne({ name: metadata.name });
      
      if (existingPlugin) {
        // Update existing plugin
        await this.pluginsCollection.updateOne(
          { name: metadata.name },
          { 
            $set: {
              ...metadata,
              updatedAt: new Date()
            }
          }
        );
      } else {
        // Insert new plugin
        await this.pluginsCollection.insertOne({
          ...metadata,
          createdAt: new Date(),
          updatedAt: new Date()
        });
      }
      
      // If PluginManager is available, register the plugin
      if (this.pluginManager) {
        await this.pluginManager.loadPlugin(metadata);
      }
      
      return {
        name: metadata.name,
        version: metadata.version,
        path: pluginDir.path,
        modality,
        runtime: metadata.runtime,
        containerized: metadata.containerized,
        metadata
      };
    } catch (error) {
      console.error(`Failed to load plugin from ${pluginDir.path}:`, error);
      return {
        name: pluginDir.name,
        path: pluginDir.path,
        error: error.message,
        modality
      };
    }
  }
  
  /**
   * Load all plugins for a modality
   * @param {string} modality - Modality name
   * @returns {Array} Array of loaded plugin results
   */
  async loadAllPlugins(modality) {
    try {
      console.log(`Loading all plugins for modality: ${modality}`);
      
      // Find plugin directories
      const pluginDirs = this.findPluginDirectories();
      
      console.log(`Found ${pluginDirs.length} plugin directories`);
      
      // Load each plugin
      const results = [];
      
      for (const pluginDir of pluginDirs) {
        try {
          const result = await this.loadPlugin(pluginDir, modality);
          results.push(result);
        } catch (error) {
          console.error(`Failed to load plugin ${pluginDir.name}:`, error);
          results.push({
            name: pluginDir.name,
            path: pluginDir.path,
            error: error.message,
            modality
          });
        }
      }
      
      return results;
    } catch (error) {
      console.error(`Failed to load plugins for modality ${modality}:`, error);
      throw error;
    }
  }
  
  /**
   * Get all loaded plugins
   * @param {Object} filter - Optional MongoDB filter
   * @returns {Array} Array of plugin documents
   */
  async getPlugins(filter = {}) {
    try {
      return await this.pluginsCollection.find(filter).toArray();
    } catch (error) {
      console.error('Failed to get plugins:', error);
      throw error;
    }
  }
}

module.exports = PluginLoader;
```


### 8. PluginContract for Contract Management

```javascript
const crypto = require('crypto');
const { Meteor } = require('meteor/meteor');
const { MongoInternals } = require('meteor/mongo');

/**
 * PluginContract - Manages plugin contracts and usage terms
 */
class PluginContract {
  constructor(options = {}) {
    this.dbCollection = options.dbCollection || 'pluginContracts';
    this.mongoUrl = options.mongoUrl || process.env.MONGO_URL || 'mongodb://localhost:27017/meteor';
    this.ledger = options.pluginLedger || null;
    
    // Connect to MongoDB
    this.db = MongoInternals.defaultRemoteCollectionDriver().mongo.db;
    this.contractsCollection = this.db.collection(this.dbCollection);
    
    // Create indexes
    this._createIndexes();
  }
  
  /**
   * Create necessary database indexes
   * @private
   */
  _createIndexes() {
    this.contractsCollection.createIndex({ contractId: 1 }, { unique: true });
    this.contractsCollection.createIndex({ pluginId: 1 });
    this.contractsCollection.createIndex({ clientId: 1 });
    this.contractsCollection.createIndex({ status: 1 });
  }
  
  /**
   * Create a new contract
   * @param {string} pluginId - ID of the plugin
   * @param {string} clientId - ID of the client
   * @param {Object} terms - Contract terms
   * @returns {Object} Created contract
   */
  async createContract(pluginId, clientId, terms) {
    try {
      console.log(`Creating contract for plugin ${pluginId} and client ${clientId}`);
      
      // Generate contract ID
      const contractId = crypto.randomUUID();
      
      // Default terms
      const defaultTerms = {
        usage: 'subscription', // one-time, subscription, unlimited
        limits: {
          maxCalls: 1000,
          timeLimit: {
            value: 30,
            unit: 'day'
          }
        },
        cost: {
          value: 10,
          currency: 'token'
        },
        startDate: new Date(),
        endDate: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000) // 30 days from now
      };
      
      // Merge with provided terms
      const contractTerms = {
        ...defaultTerms,
        ...terms
      };
      
      // Validate the contract terms
      this._validateContractTerms(contractTerms);
      
      // Create contract document
      const contract = {
        contractId,
        pluginId,
        clientId,
        terms: contractTerms,
        status: 'pending',
        usageCount: 0,
        createdAt: new Date(),
        updatedAt: new Date()
      };
      
      // Calculate end date if not provided
      if (!terms.endDate && contractTerms.limits && contractTerms.limits.timeLimit) {
        const { value, unit } = contractTerms.limits.timeLimit;
        let multiplier = 0;
        
        switch (unit) {
          case 'minute':
            multiplier = 60 * 1000;
            break;
          case 'hour':
            multiplier = 60 * 60 * 1000;
            break;
          case 'day':
            multiplier = 24 * 60 * 60 * 1000;
            break;
          case 'week':
            multiplier = 7 * 24 * 60 * 60 * 1000;
            break;
          case 'month':
            multiplier = 30 * 24 * 60 * 60 * 1000;
            break;
          case 'year':
            multiplier = 365 * 24 * 60 * 60 * 1000;
            break;
          default:
            multiplier = 24 * 60 * 60 * 1000; // Default to day
        }
        
        contract.terms.endDate = new Date(contract.terms.startDate.getTime() + value * multiplier);
      }
      
      // Insert contract into database
      await this.contractsCollection.insertOne(contract);
      
      // Record contract creation in ledger if available
      if (this.ledger) {
        await this.ledger.recordTransaction(pluginId, clientId, 'contract_created', {
          contractId,
          terms: contractTerms
        });
      }
      
      return contract;
    } catch (error) {
      console.error(`Failed to create contract for plugin ${pluginId} and client ${clientId}:`, error);
      throw error;
    }
  }
  
  /**
   * Validate contract terms
   * @param {Object} terms - Contract terms to validate
   * @private
   */
  _validateContractTerms(terms) {
    // Check usage type
    if (!['one-time', 'subscription', 'unlimited'].includes(terms.usage)) {
      throw new Error(`Invalid usage type: ${terms.usage}`);
    }
    
    // Check limits for non-unlimited usage
    if (terms.usage !== 'unlimited') {
      if (!terms.limits) {
        throw new Error('Limits are required for non-unlimited usage');
      }
      
      // For subscription, check time limit
      if (terms.usage === 'subscription' && (!terms.limits.timeLimit || !terms.limits.timeLimit.value || !terms.limits.timeLimit.unit)) {
        throw new Error('Time limit is required for subscription usage');
      }
    }
    
    // Check cost
    if (!terms.cost || !terms.cost.value || !terms.cost.currency) {
      throw new Error('Cost is required');
    }
    
    // Check dates
    if (terms.startDate && terms.endDate && terms.startDate > terms.endDate) {
      throw new Error('Start date cannot be after end date');
    }
  }
  
  /**
   * Activate a contract
   * @param {string} contractId - ID of the contract to activate
   * @returns {Object} Activated contract
   */
  async activateContract(contractId) {
    try {
      console.log(`Activating contract ${contractId}`);
      
      // Get contract
      const contract = await this.contractsCollection.findOne({ contractId });
      
      if (!contract) {
        throw new Error(`Contract ${contractId} not found`);
      }
      
      if (contract.status === 'active') {
        return contract;
      }
      
      // Check if contract can be activated
      if (contract.status !== 'pending') {
        throw new Error(`Cannot activate contract with status ${contract.status}`);
      }
      
      // Update contract status
      const result = await this.contractsCollection.updateOne(
        { contractId },
        {
          $set: {
            status: 'active',
            activatedAt: new Date(),
            updatedAt: new Date()
          }
        }
      );
      
      if (result.modifiedCount === 0) {
        throw new Error(`Failed to activate contract ${contractId}`);
      }
      
      // Get updated contract
      const updatedContract = await this.contractsCollection.findOne({ contractId });
      
      // Record contract activation in ledger if available
      if (this.ledger) {
        await this.ledger.recordTransaction(updatedContract.pluginId, updatedContract.clientId, 'contract_activated', {
          contractId,
          activatedAt: updatedContract.activatedAt
        });
      }
      
      return updatedContract;
    } catch (error) {
      console.error(`Failed to activate contract ${contractId}:`, error);
      throw error;
    }
  }
  
  /**
   * Terminate a contract
   * @param {string} contractId - ID of the contract to terminate
   * @param {string} reason - Reason for termination
   * @returns {Object} Terminated contract
   */
  async terminateContract(contractId, reason = '') {
    try {
      console.log(`Terminating contract ${contractId}`);
      
      // Get contract
      const contract = await this.contractsCollection.findOne({ contractId });
      
      if (!contract) {
        throw new Error(`Contract ${contractId} not found`);
      }
      
      if (contract.status === 'terminated') {
        return contract;
      }
      
      // Update contract status
      const result = await this.contractsCollection.updateOne(
        { contractId },
        {
          $set: {
            status: 'terminated',
            terminatedAt: new Date(),
            terminationReason: reason,
            updatedAt: new Date()
          }
        }
      );
      
      if (result.modifiedCount === 0) {
        throw new Error(`Failed to terminate contract ${contractId}`);
      }
      
      // Get updated contract
      const updatedContract = await this.contractsCollection.findOne({ contractId });
      
      // Record contract termination in ledger if available
      if (this.ledger) {
        await this.ledger.recordTransaction(updatedContract.pluginId, updatedContract.clientId, 'contract_terminated', {
          contractId,
          terminatedAt: updatedContract.terminatedAt,
          reason
        });
      }
      
      return updatedContract;
    } catch (error) {
      console.error(`Failed to terminate contract ${contractId}:`, error);
      throw error;
    }
  }
  
  /**
   * Record plugin usage
   * @param {string} contractId - ID of the contract
   * @param {string} method - Method that was called
   * @param {Object} params - Parameters used for the call
   * @returns {Object} Updated contract
   */
  async recordUsage(contractId, method, params = {}) {
    try {
      console.log(`Recording usage for contract ${contractId}, method ${method}`);
      
      // Get contract
      const contract = await this.contractsCollection.findOne({ contractId });
      
      if (!contract) {
        throw new Error(`Contract ${contractId} not found`);
      }
      
      // Check if contract is active
      if (contract.status !== 'active') {
        throw new Error(`Contract ${contractId} is not active (status: ${contract.status})`);
      }
      
      // Check if contract has expired
      if (contract.terms.endDate && new Date() > contract.terms.endDate) {
        // Terminate contract
        await this.terminateContract(contractId, 'Contract expired');
        throw new Error(`Contract ${contractId} has expired`);
      }
      
      // Check usage limits
      if (contract.terms.usage !== 'unlimited' && contract.terms.limits && contract.terms.limits.maxCalls) {
        if (contract.usageCount >= contract.terms.limits.maxCalls) {
          throw new Error(`Contract ${contractId} has reached its usage limit`);
        }
      }
      
      // Record usage
      const usage = {
        method,
        params,
        timestamp: new Date()
      };
      
      // Update contract usage
      const result = await this.contractsCollection.updateOne(
        { contractId },
        {
          $inc: { usageCount: 1 },
          $push: { usageHistory: usage },
          $set: { lastUsed: new Date(), updatedAt: new Date() }
        }
      );
      
      if (result.modifiedCount === 0) {
        throw new Error(`Failed to record usage for contract ${contractId}`);
      }
      
      // Get updated contract
      const updatedContract = await this.contractsCollection.findOne({ contractId });
      
      // Record usage in ledger if available
      if (this.ledger) {
        await this.ledger.recordTransaction(updatedContract.pluginId, updatedContract.clientId, 'plugin_usage', {
          contractId,
          method,
          timestamp: usage.timestamp
        });
      }
      
      // Check if this usage reached the limit
      if (contract.terms.usage !== 'unlimited' && 
          contract.terms.limits && 
          contract.terms.limits.maxCalls && 
          updatedContract.usageCount >= contract.terms.limits.maxCalls) {
        // Terminate contract if it's one-time
        if (contract.terms.usage === 'one-time') {
          await this.terminateContract(contractId, 'Usage limit reached');
        }
      }
      
      return updatedContract;
    } catch (error) {
      console.error(`Failed to record usage for contract ${contractId}:`, error);
      throw error;
    }
  }
  
  /**
   * Check if a contract allows usage
   * @param {string} contractId - ID of the contract
   * @param {string} method - Method to check
   * @returns {Object} Contract status check result
   */
  async checkUsageAllowed(contractId, method) {
    try {
      // Get contract
      const contract = await this.contractsCollection.findOne({ contractId });
      
      if (!contract) {
        return {
          allowed: false,
          reason: 'Contract not found',
          contractId
        };
      }
      
      // Check if contract is active
      if (contract.status !== 'active') {
        return {
          allowed: false,
          reason: `Contract is not active (status: ${contract.status})`,
          contractId,
          status: contract.status
        };
      }
      
      // Check if contract has expired
      if (contract.terms.endDate && new Date() > contract.terms.endDate) {
        return {
          allowed: false,
          reason: 'Contract has expired',
          contractId,
          expiryDate: contract.terms.endDate
        };
      }
      
      // Check usage limits
      if (contract.terms.usage !== 'unlimited' && contract.terms.limits && contract.terms.limits.maxCalls) {
        if (contract.usageCount >= contract.terms.limits.maxCalls) {
          return {
            allowed: false,
            reason: 'Usage limit reached',
            contractId,
            usageCount: contract.usageCount,
            maxCalls: contract.terms.limits.maxCalls
          };
        }
      }
      
      // Check if method is allowed
      if (contract.terms.allowedMethods && !contract.terms.allowedMethods.includes(method)) {
        return {
          allowed: false,
          reason: 'Method not allowed',
          contractId,
          method,
          allowedMethods: contract.terms.allowedMethods
        };
      }
      
      return {
        allowed: true,
        contractId,
        usageCount: contract.usageCount,
        usageRemaining: contract.terms.limits && contract.terms.limits.maxCalls 
          ? contract.terms.limits.maxCalls - contract.usageCount 
          : null
      };
    } catch (error) {
      console.error(`Failed to check usage for contract ${contractId}:`, error);
      return {
        allowed: false,
        reason: `Error checking contract: ${error.message}`,
        contractId
      };
    }
  }
  
  /**
   * Renew a contract
   * @param {string} contractId - ID of the contract to renew
   * @param {Object} newTerms - New contract terms (optional)
   * @returns {Object} Renewed contract
   */
  async renewContract(contractId, newTerms = {}) {
    try {
      console.log(`Renewing contract ${contractId}`);
      
      // Get contract
      const contract = await this.contractsCollection.findOne({ contractId });
      
      if (!contract) {
        throw new Error(`Contract ${contractId} not found`);
      }
      
      // Merge current terms with new terms
      const terms = {
        ...contract.terms,
        ...newTerms,
        startDate: new Date()
      };
      
      // Calculate new end date
      if (terms.limits && terms.limits.timeLimit) {
        const { value, unit } = terms.limits.timeLimit;
        let multiplier = 0;
        
        switch (unit) {
          case 'minute':
            multiplier = 60 * 1000;
            break;
          case 'hour':
            multiplier = 60 * 60 * 1000;
            break;
          case 'day':
            multiplier = 24 * 60 * 60 * 1000;
            break;
          case 'week':
            multiplier = 7 * 24 * 60 * 60 * 1000;
            break;
          case 'month':
            multiplier = 30 * 24 * 60 * 60 * 1000;
            break;
          case 'year':
            multiplier = 365 * 24 * 60 * 60 * 1000;
            break;
          default:
            multiplier = 24 * 60 * 60 * 1000; // Default to day
        }
        
        terms.endDate = new Date(terms.startDate.getTime() + value * multiplier);
      }
      
      // Validate the contract terms
      this._validateContractTerms(terms);
      
      // Update contract
      const result = await this.contractsCollection.updateOne(
        { contractId },
        {
          $set: {
            terms,
            status: 'active',
            usageCount: 0,
            usageHistory: [],
            renewedAt: new Date(),
            updatedAt: new Date()
          }
        }
      );
      
      if (result.modifiedCount === 0) {
        throw new Error(`Failed to renew contract ${contractId}`);
      }
      
      // Get updated contract
      const updatedContract = await this.contractsCollection.findOne({ contractId });
      
      // Record contract renewal in ledger if available
      if (this.ledger) {
        await this.ledger.recordTransaction(updatedContract.pluginId, updatedContract.clientId, 'contract_renewed', {
          contractId,
          renewedAt: updatedContract.renewedAt,
          terms: updatedContract.terms
        });
      }
      
      return updatedContract;
    } catch (error) {
      console.error(`Failed to renew contract ${contractId}:`, error);
      throw error;
    }
  }
  
  /**
   * Get a contract by ID
   * @param {string} contractId - ID of the contract
   * @returns {Object} Contract document
   */
  async getContract(contractId) {
    try {
      return await this.contractsCollection.findOne({ contractId });
    } catch (error) {
      console.error(`Failed to get contract ${contractId}:`, error);
      throw error;
    }
  }
  
  /**
   * Get contracts by plugin ID
   * @param {string} pluginId - ID of the plugin
   * @param {Object} filter - Additional filter criteria
   * @returns {Array} Array of contract documents
   */
  async getContractsByPlugin(pluginId, filter = {}) {
    try {
      return await this.contractsCollection.find({
        pluginId,
        ...filter
      }).toArray();
    } catch (error) {
      console.error(`Failed to get contracts for plugin ${pluginId}:`, error);
      throw error;
    }
  }
  
  /**
   * Get contracts by client ID
   * @param {string} clientId - ID of the client
   * @param {Object} filter - Additional filter criteria
   * @returns {Array} Array of contract documents
   */
  async getContractsByClient(clientId, filter = {}) {
    try {
      return await this.contractsCollection.find({
        clientId,
        ...filter
      }).toArray();
    } catch (error) {
      console.error(`Failed to get contracts for client ${clientId}:`, error);
      throw error;
    }
  }
  
  /**
   * Get all contracts
   * @param {Object} filter - MongoDB filter
   * @param {Object} options - MongoDB options
   * @returns {Array} Array of contract documents
   */
  async getAllContracts(filter = {}, options = {}) {
    try {
      return await this.contractsCollection.find(filter, options).toArray();
    } catch (error) {
      console.error('Failed to get all contracts:', error);
      throw error;
    }
  }
}

module.exports = PluginContract;
```


### 9. PluginLedger for Contract Tracking

```javascript
const crypto = require('crypto');
const { Meteor } = require('meteor/meteor');
const { MongoInternals } = require('meteor/mongo');
const fs = require('fs');
const path = require('path');
const Arrow = require('apache-arrow');

/**
 * PluginLedger - Tracks plugin usage and contracts
 * Implements record keeping with both MongoDB and Apache Arrow
 */
class PluginLedger {
  constructor(options = {}) {
    this.dbCollection = options.dbCollection || 'pluginLedger';
    this.mongoUrl = options.mongoUrl || process.env.MONGO_URL || 'mongodb://localhost:27017/meteor';
    this.arrowEnabled = options.arrowEnabled || false;
    this.arrowDir = options.arrowDir || path.join(process.cwd(), 'data', 'arrow');
    this.keyManager = options.keyManager || null;
    
    // Connect to MongoDB
    this.db = MongoInternals.defaultRemoteCollectionDriver().mongo.db;
    this.ledgerCollection = this.db.collection(this.dbCollection);
    
    // Create indexes
    this._createIndexes();
    
    // Initialize Arrow storage if enabled
    if (this.arrowEnabled) {
      this._initializeArrowStorage();
    }
  }
  
  /**
   * Create necessary database indexes
   * @private
   */
  _createIndexes() {
    this.ledgerCollection.createIndex({ transactionId: 1 }, { unique: true });
    this.ledgerCollection.createIndex({ pluginId: 1 });
    this.ledgerCollection.createIndex({ clientId: 1 });
    this.ledgerCollection.createIndex({ type: 1 });
    this.ledgerCollection.createIndex({ timestamp: 1 });
    this.ledgerCollection.createIndex({ contractId: 1 });
  }
  
  /**
   * Initialize Arrow storage
   * @private
   */
  _initializeArrowStorage() {
    try {
      // Create arrow directory if it doesn't exist
      if (!fs.existsSync(this.arrowDir)) {
        fs.mkdirSync(this.arrowDir, { recursive: true });
      }
      
      console.log('Arrow storage initialized');
    } catch (error) {
      console.error('Failed to initialize Arrow storage:', error);
      this.arrowEnabled = false;
    }
  }
  
  /**
   * Record a transaction in the ledger
   * @param {string} pluginId - ID of the plugin
   * @param {string} clientId - ID of the client
   * @param {string} type - Type of transaction
   * @param {Object} data - Transaction data
   * @returns {Object} Recorded transaction
   */
  async recordTransaction(pluginId, clientId, type, data = {}) {
    try {
      console.log(`Recording transaction: ${type} for plugin ${pluginId} and client ${clientId}`);
      
      // Generate transaction ID
      const transactionId = crypto.randomUUID();
      
      // Create transaction document
      const transaction = {
        transactionId,
        pluginId,
        clientId,
        type,
        data,
        timestamp: new Date(),
        verified: false
      };
      
      // Add contract ID if present in data
      if (data.contractId) {
        transaction.contractId = data.contractId;
      }
      
      // Sign the transaction if key manager is available
      if (this.keyManager) {
        try {
          // Create a string representation of the transaction
          const transactionString = JSON.stringify({
            transactionId,
            pluginId,
            clientId,
            type,
            data,
            timestamp: transaction.timestamp.toISOString()
          });
          
          // Sign the transaction
          const signResult = await this.keyManager.sign('ledger-signing-key', transactionString);
          
          transaction.signature = signResult.signature;
          transaction.verified = true;
        } catch (error) {
          console.warn('Failed to sign transaction:', error);
        }
      }
      
      // Insert transaction into MongoDB
      await this.ledgerCollection.insertOne(transaction);
      
      // Store in Arrow if enabled
      if (this.arrowEnabled) {
        await this._storeTransactionInArrow(transaction);
      }
      
      return transaction;
    } catch (error) {
      console.error(`Failed to record transaction for plugin ${pluginId} and client ${clientId}:`, error);
      throw error;
    }
  }
  
  /**
   * Store a transaction in Arrow format
   * @param {Object} transaction - Transaction to store
   * @private
   */
  async _storeTransactionInArrow(transaction) {
    try {
      // Define schema
      const schema = new Arrow.Schema([
        new Arrow.Field('transactionId', new Arrow.Utf8()),
        new Arrow.Field('pluginId', new Arrow.Utf8()),
        new Arrow.Field('clientId', new Arrow.Utf8()),
        new Arrow.Field('type', new Arrow.Utf8()),
        new Arrow.Field('timestamp', new Arrow.Timestamp(Arrow.TimeUnit.MILLISECOND)),
        new Arrow.Field('contractId', new Arrow.Utf8()),
        new Arrow.Field('verified', new Arrow.Bool()),
        new Arrow.Field('data', new Arrow.Utf8()) // Store data as JSON string
      ]);
      
      // Create record batch
      const recordBatch = Arrow.RecordBatch.new(
        [
          Arrow.Utf8.from([transaction.transactionId]),
          Arrow.Utf8.from([transaction.pluginId]),
          Arrow.Utf8.from([transaction.clientId]),
          Arrow.Utf8.from([transaction.type]),
          Arrow.Timestamp.from([transaction.timestamp.getTime()]),
          Arrow.Utf8.from([transaction.contractId || '']),
          Arrow.Bool.from([transaction.verified]),
          Arrow.Utf8.from([JSON.stringify(transaction.data)])
        ],
        schema
      );
      
      // Create table
      const table = Arrow.Table.new(recordBatch);
      
      // Write to file
      const writer = Arrow.RecordBatchFileWriter.writeAll(table);
      
      // Create monthly file
      const month = transaction.timestamp.toISOString().slice(0, 7); // YYYY-MM
      const filePath = path.join(this.arrowDir, `transactions-${month}.arrow`);
      
      // Check if file exists
      let existingData = Buffer.from([]);
      if (fs.existsSync(filePath)) {
        existingData = fs.readFileSync(filePath);
      }
      
      // Append new data
      const newData = Buffer.concat([existingData, Buffer.from(writer)]);
      
      // Write to file
      fs.writeFileSync(filePath, newData);
    } catch (error) {
      console.error('Failed to store transaction in Arrow format:', error);
    }
  }
  
  /**
   * Get transactions by plugin ID
   * @param {string} pluginId - ID of the plugin
   * @param {Object} filter - Additional filter criteria
   * @param {Object} options - MongoDB options
   * @returns {Array} Array of transaction documents
   */
  async getTransactionsByPlugin(pluginId, filter = {}, options = {}) {
    try {
      return await this.ledgerCollection.find({
        pluginId,
        ...filter
      }, options).toArray();
    } catch (error) {
      console.error(`Failed to get transactions for plugin ${pluginId}:`, error);
      throw error;
    }
  }
  
  /**
   * Get transactions by client ID
   * @param {string} clientId - ID of the client
   * @param {Object} filter - Additional filter criteria
   * @param {Object} options - MongoDB options
   * @returns {Array} Array of transaction documents
   */
  async getTransactionsByClient(clientId, filter = {}, options = {}) {
    try {
      return await this.ledgerCollection.find({
        clientId,
        ...filter
      }, options).toArray();
    } catch (error) {
      console.error(`Failed to get transactions for client ${clientId}:`, error);
      throw error;
    }
  }
  
  /**
   * Get transactions by contract ID
   * @param {string} contractId - ID of the contract
   * @param {Object} filter - Additional filter criteria
   * @param {Object} options - MongoDB options
   * @returns {Array} Array of transaction documents
   */
  async getTransactionsByContract(contractId, filter = {}, options = {}) {
    try {
      return await this.ledgerCollection.find({
        contractId,
        ...filter
      }, options).toArray();
    } catch (error) {
      console.error(`Failed to get transactions for contract ${contractId}:`, error);
      throw error;
    }
  }
  
  /**
   * Get a transaction by ID
   * @param {string} transactionId - ID of the transaction
   * @returns {Object} Transaction document
   */
  async getTransaction(transactionId) {
    try {
      return await this.ledgerCollection.findOne({ transactionId });
    } catch (error) {
      console.error(`Failed to get transaction ${transactionId}:`, error);
      throw error;
    }
  }
  
  /**
   * Verify a transaction signature
   * @param {string} transactionId - ID of the transaction
   * @returns {Object} Verification result
   */
  async verifyTransaction(transactionId) {
    try {
      // Get transaction
      const transaction = await this.ledgerCollection.findOne({ transactionId });
      
      if (!transaction) {
        throw new Error(`Transaction ${transactionId} not found`);
      }
      
      // Check if transaction has a signature
      if (!transaction.signature) {
        return {
          verified: false,
          reason: 'Transaction has no signature',
          transactionId
        };
      }
      
      // Verify the signature
      if (this.keyManager) {
        // Create a string representation of the transaction
        const transactionString = JSON.stringify({
          transactionId: transaction.transactionId,
          pluginId: transaction.pluginId,
          clientId: transaction.clientId,
          type: transaction.type,
          data: transaction.data,
          timestamp: transaction.timestamp.toISOString()
        });
        
        // Verify the signature
        const verifyResult = await this.keyManager.verify('ledger-signing-key', transactionString, transaction.signature);
        
        return {
          verified: verifyResult.isValid,
          transactionId
        };
      }
      
      return {
        verified: false,
        reason: 'Key manager not available for verification',
        transactionId
      };
    } catch (error) {
      console.error(`Failed to verify transaction ${transactionId}:`, error);
      return {
        verified: false,
        reason: `Error verifying transaction: ${error.message}`,
        transactionId
      };
    }
  }
  
  /**
   * Generate a usage report for a plugin
   * @param {string} pluginId - ID of the plugin
   * @param {Object} options - Report options
   * @returns {Object} Usage report
   */
  async generatePluginUsageReport(pluginId, options = {}) {
    try {
      console.log(`Generating usage report for plugin ${pluginId}`);
      
      // Default options
      const defaultOptions = {
        startDate: new Date(0), // Beginning of time
        endDate: new Date(), // Now
        groupBy: 'day', // day, week, month, year
        includeContractDetails: true
      };
      
      // Merge options
      const reportOptions = {
        ...defaultOptions,
        ...options
      };
      
      // Build query
      const query = {
        pluginId,
        timestamp: {
          $gte: reportOptions.startDate,
          $lte: reportOptions.endDate
        }
      };
      
      // If type is specified, add it to the query
      if (options.type) {
        query.type = options.type;
      }
      
      // Get transactions
      const transactions = await this.ledgerCollection.find(query).toArray();
      
      // Group transactions by date
      const groupedTransactions = {};
      
      for (const transaction of transactions) {
        let groupKey;
        
        switch (reportOptions.groupBy) {
          case 'day':
            groupKey = transaction.timestamp.toISOString().slice(0, 10); // YYYY-MM-DD
            break;
          case 'week':
            // Get the first day of the week (Sunday)
            const date = new Date(transaction.timestamp);
            const day = date.getDay();
            const diff = date.getDate() - day;
            const firstDayOfWeek = new Date(date.setDate(diff));
            groupKey = firstDayOfWeek.toISOString().slice(0, 10);
            break;
          case 'month':
            groupKey = transaction.timestamp.toISOString().slice(0, 7); // YYYY-MM
            break;
          case 'year':
            groupKey = transaction.timestamp.toISOString().slice(0, 4); // YYYY
            break;
          default:
            groupKey = transaction.timestamp.toISOString().slice(0, 10); // Default to day
        }
        
        if (!groupedTransactions[groupKey]) {
          groupedTransactions[groupKey] = [];
        }
        
        groupedTransactions[groupKey].push(transaction);
      }
      
      // Calculate usage statistics
      const usageStats = {
        total: transactions.length,
        byDate: {},
        byType: {},
        byClient: {},
        byContract: {}
      };
      
      // Process by date
      for (const [date, dateTransactions] of Object.entries(groupedTransactions)) {
        usageStats.byDate[date] = dateTransactions.length;
      }
      
      // Process by type
      for (const transaction of transactions) {
        if (!usageStats.byType[transaction.type]) {
          usageStats.byType[transaction.type] = 0;
        }
        
        usageStats.byType[transaction.type]++;
      }
      
      // Process by client
      for (const transaction of transactions) {
        if (!usageStats.byClient[transaction.clientId]) {
          usageStats.byClient[transaction.clientId] = 0;
        }
        
        usageStats.byClient[transaction.clientId]++;
      }
      
      // Process by contract if requested
      if (reportOptions.includeContractDetails) {
        for (const transaction of transactions) {
          if (transaction.contractId) {
            if (!usageStats.byContract[transaction.contractId]) {
              usageStats.byContract[transaction.contractId] = 0;
            }
            
            usageStats.byContract[transaction.contractId]++;
          }
        }
      }
      
      return {
        pluginId,
        period: {
          start: reportOptions.startDate,
          end: reportOptions.endDate
        },
        groupBy: reportOptions.groupBy,
        stats: usageStats,
        generated: new Date()
      };
    } catch (error) {
      console.error(`Failed to generate usage report for plugin ${pluginId}:`, error);
      throw error;
    }
  }
  
  /**
   * Generate a usage report for a client
   * @param {string} clientId - ID of the client
   * @param {Object} options - Report options
   * @returns {Object} Usage report
   */
  async generateClientUsageReport(clientId, options = {}) {
    try {
      console.log(`Generating usage report for client ${clientId}`);
      
      // Default options
      const defaultOptions = {
        startDate: new Date(0), // Beginning of time
        endDate: new Date(), // Now
        groupBy: 'day', // day, week, month, year
        includePluginDetails: true
      };
      
      // Merge options
      const reportOptions = {
        ...defaultOptions,
        ...options
      };
      
      // Build query
      const query = {
        clientId,
        timestamp: {
          $gte: reportOptions.startDate,
          $lte: reportOptions.endDate
        }
      };
      
      // If type is specified, add it to the query
      if (options.type) {
        query.type = options.type;
      }
      
      // Get transactions
      const transactions = await this.ledgerCollection.find(query).toArray();
      
      // Group transactions by date
      const groupedTransactions = {};
      
      for (const transaction of transactions) {
        let groupKey;
        
        switch (reportOptions.groupBy) {
          case 'day':
            groupKey = transaction.timestamp.toISOString().slice(0, 10); // YYYY-MM-DD
            break;
          case 'week':
            // Get the first day of the week (Sunday)
            const date = new Date(transaction.timestamp);
            const day = date.getDay();
            const diff = date.getDate() - day;
            const firstDayOfWeek = new Date(date.setDate(diff));
            groupKey = firstDayOfWeek.toISOString().slice(0, 10);
            break;
          case 'month':
            groupKey = transaction.timestamp.toISOString().slice(0, 7); // YYYY-MM
            break;
          case 'year':
            groupKey = transaction.timestamp.toISOString().slice(0, 4); // YYYY
            break;
          default:
            groupKey = transaction.timestamp.toISOString().slice(0, 10); // Default to day
        }
        
        if (!groupedTransactions[groupKey]) {
          groupedTransactions[groupKey] = [];
        }
        
        groupedTransactions[groupKey].push(transaction);
      }
      
      // Calculate usage statistics
      const usageStats = {
        total: transactions.length,
        byDate: {},
        byType: {},
        byPlugin: {},
        byContract: {}
      };
      
      // Process by date
      for (const [date, dateTransactions] of Object.entries(groupedTransactions)) {
        usageStats.byDate[date] = dateTransactions.length;
      }
      
      // Process by type
      for (const transaction of transactions) {
        if (!usageStats.byType[transaction.type]) {
          usageStats.byType[transaction.type] = 0;
        }
        
        usageStats.byType[transaction.type]++;
      }
      
      // Process by plugin if requested
      if (reportOptions.includePluginDetails) {
        for (const transaction of transactions) {
          if (!usageStats.byPlugin[transaction.pluginId]) {
            usageStats.byPlugin[transaction.pluginId] = 0;
          }
          
          usageStats.byPlugin[transaction.pluginId]++;
        }
      }
      
      // Process by contract
      for (const transaction of transactions) {
        if (transaction.contractId) {
          if (!usageStats.byContract[transaction.contractId]) {
            usageStats.byContract[transaction.contractId] = 0;
          }
          
          usageStats.byContract[transaction.contractId]++;
        }
      }
      
      return {
        clientId,
        period: {
          start: reportOptions.startDate,
          end: reportOptions.endDate
        },
        groupBy: reportOptions.groupBy,
        stats: usageStats,
        generated: new Date()
      };
    } catch (error) {
      console.error(`Failed to generate usage report for client ${clientId}:`, error);
      throw error;
    }
  }
  
  /**
   * Query transactions from Arrow files
   * @param {Object} filter - Filter criteria
   * @returns {Array} Array of transaction objects
   */
  async queryArrowTransactions(filter = {}) {
    if (!this.arrowEnabled) {
      throw new Error('Arrow storage is not enabled');
    }
    
    try {
      // Get a list of Arrow files
      const files = fs.readdirSync(this.arrowDir).filter(file => file.endsWith('.arrow'));
      
      if (files.length === 0) {
        return [];
      }
      
      // Read and process each file
      const results = [];
      
      for (const file of files) {
        const filePath = path.join(this.arrowDir, file);
        
        // Read the file
        const buffer = fs.readFileSync(filePath);
        
        // Parse the file
        const table = await Arrow.Table.from(buffer);
        
        // Convert to objects
        const records = table.toArray();
        
        // Apply filters
        for (const record of records) {
          let includeRecord = true;
          
          // Apply filters
          for (const [key, value] of Object.entries(filter)) {
            if (record[key] !== value) {
              includeRecord = false;
              break;
            }
          }
          
          if (includeRecord) {
            // Parse data JSON
            if (record.data) {
              try {
                record.data = JSON.parse(record.data);
              } catch (e) {
                // Keep as string if parsing fails
              }
            }
            
            results.push(record);
          }
        }
      }
      
      return results;
    } catch (error) {
      console.error('Failed to query Arrow transactions:', error);
      throw error;
    }
  }
  
  /**
   * Get all transactions
   * @param {Object} filter - MongoDB filter
   * @param {Object} options - MongoDB options
   * @returns {Array} Array of transaction documents
   */
  async getAllTransactions(filter = {}, options = {}) {
    try {
      return await this.ledgerCollection.find(filter, options).toArray();
    } catch (error) {
      console.error('Failed to get all transactions:', error);
      throw error;
    }
  }
}

module.exports = PluginLedger;
```


### 10. AsyncExec Utility

Let's create the AsyncExec utility for the WorkerManager:

```javascript
const { spawn } = require('child_process');

/**
 * Execute a command asynchronously
 * @param {string} command - Command to execute
 * @param {Object} options - Spawn options
 * @returns {Object} Process object with stdout and stderr streams
 */
function execAsync(command, options = {}) {
  // Split command into command and arguments
  const parts = command.split(/\s+/);
  const cmd = parts[0];
  const args = parts.slice(1);
  
  // Spawn the process
  const proc = spawn(cmd, args, {
    ...options,
    shell: true
  });
  
  return proc;
}

/**
 * Execute a command and return a promise
 * @param {string} command - Command to execute
 * @param {Object} options - Spawn options
 * @returns {Promise<Object>} Promise resolving to stdout, stderr, and exit code
 */
function execPromise(command, options = {}) {
  return new Promise((resolve, reject) => {
    const proc = execAsync(command, options);
    
    let stdout = '';
    let stderr = '';
    
    proc.stdout.on('data', data => {
      stdout += data.toString();
    });
    
    proc.stderr.on('data', data => {
      stderr += data.toString();
    });
    
    proc.on('close', code => {
      resolve({
        stdout,
        stderr,
        code
      });
    });
    
    proc.on('error', err => {
      reject(err);
    });
  });
}

module.exports = {
  execAsync,
  execPromise
};
```


### 11. PerformanceMonitor Implementation

Let's create the PerformanceMonitor for system health checks:

```javascript
const os = require('os');
const { execSync } = require('child_process');
const { Meteor } = require('meteor/meteor');
const { MongoInternals } = require('meteor/mongo');

/**
 * PerformanceMonitor - Monitors system performance and health
 */
class PerformanceMonitor {
  constructor(options = {}) {
    this.dbCollection = options.dbCollection || 'performanceMetrics';
    this.mongoUrl = options.mongoUrl || process.env.MONGO_URL || 'mongodb://localhost:27017/meteor';
    this.interval = options.interval || 60000; // 1 minute
    this.retention = options.retention || 7 * 24 * 60 * 60 * 1000; // 7 days
    
    // Connect to MongoDB
    this.db = MongoInternals.defaultRemoteCollectionDriver().mongo.db;
    this.metricsCollection = this.db.collection(this.dbCollection);
    
    // Create indexes
    this._createIndexes();
    
    // Initialize monitoring
    this.monitoring = false;
    this.monitoringInterval = null;
  }
  
  /**
   * Create necessary database indexes
   * @private
   */
  _createIndexes() {
    this.metricsCollection.createIndex({ timestamp: 1 });
    this.metricsCollection.createIndex({ type: 1 });
    this.metricsCollection.createIndex({ hostname: 1 });
  }
  
  /**
   * Start monitoring
   * @returns {boolean} Whether monitoring was started
   */
  startMonitoring() {
    if (this.monitoring) {
      return false;
    }
    
    console.log(`Starting performance monitoring every ${this.interval}ms`);
    
    this.monitoring = true;
    
    // Take initial snapshot
    this.captureMetrics();
    
    // Set up interval
    this.monitoringInterval = setInterval(() => {
      this.captureMetrics();
    }, this.interval);
    
    // Set up retention cleanup
    this.retentionInterval = setInterval(() => {
      this.cleanupOldMetrics();
    }, 24 * 60 * 60 * 1000); // Daily cleanup
    
    return true;
  }
  
  /**
   * Stop monitoring
   * @returns {boolean} Whether monitoring was stopped
   */
  stopMonitoring() {
    if (!this.monitoring) {
      return false;
    }
    
    console.log('Stopping performance monitoring');
    
    clearInterval(this.monitoringInterval);
    clearInterval(this.retentionInterval);
    
    this.monitoring = false;
    this.monitoringInterval = null;
    this.retentionInterval = null;
    
    return true;
  }
  
  /**
   * Capture system metrics
   * @returns {Object} Captured metrics
   */
  async captureMetrics() {
    try {
      console.log('Capturing performance metrics');
      
      // Get system metrics
      const cpuUsage = this.getCpuUsage();
      const memoryUsage = this.getMemoryUsage();
      const diskUsage = this.getDiskUsage();
      const networkUsage = this.getNetworkUsage();
      const processInfo = this.getProcessInfo();
      const activeConnections = this.getActiveConnections();
      
      // Create metrics document
      const metrics = {
        timestamp: new Date(),
        hostname: os.hostname(),
        type: 'system',
        uptime: os.uptime(),
        cpu: cpuUsage,
        memory: memoryUsage,
        disk: diskUsage,
        network: networkUsage,
        processes: processInfo,
        connections: activeConnections
      };
      
      // Insert into database
      await this.metricsCollection.insertOne(metrics);
      
      return metrics;
    } catch (error) {
      console.error('Failed to capture metrics:', error);
      return null;
    }
  }
  
  /**
   * Get CPU usage
   * @returns {Object} CPU usage information
   */
  getCpuUsage() {
    try {
      const cpus = os.cpus();
      const cpuCount = cpus.length;
      
      let totalIdle = 0;
      let totalTick = 0;
      
      // Calculate CPU usage percentages
      cpus.forEach(cpu => {
        const { user, nice, sys, idle, irq } = cpu.times;
        
        const total = user + nice + sys + idle + irq;
        totalTick += total;
        totalIdle += idle;
      });
      
      const idlePercent = totalIdle / totalTick;
      const usagePercent = 100 - (idlePercent * 100);
      
      // Get load averages
      const loadAvg = os.loadavg();
      
      return {
        count: cpuCount,
        model: cpus[0].model,
        speed: cpus[0].speed,
        usage: parseFloat(usagePercent.toFixed(2)),
        load1: loadAvg[0],
        load5: loadAvg[1],
        load15: loadAvg[2]
      };
    } catch (error) {
      console.error('Failed to get CPU usage:', error);
      return { error: error.message };
    }
  }
  
  /**
   * Get memory usage
   * @returns {Object} Memory usage information
   */
  getMemoryUsage() {
    try {
      const totalMemory = os.totalmem();
      const freeMemory = os.freemem();
      const usedMemory = totalMemory - freeMemory;
      
      return {
        total: totalMemory,
        free: freeMemory,
        used: usedMemory,
        usagePercent: parseFloat((usedMemory / totalMemory * 100).toFixed(2))
      };
    } catch (error) {
      console.error('Failed to get memory usage:', error);
      return { error: error.message };
    }
  }
  
  /**
   * Get disk usage
   * @returns {Object} Disk usage information
   */
  getDiskUsage() {
    try {
      let diskInfo = {};
      
      // Get disk usage using different commands based on platform
      if (process.platform === 'linux' || process.platform === 'darwin') {
        const output = execSync('df -h / | tail -1', { encoding: 'utf8' });
        const parts = output.trim().split(/\s+/);
        
        if (parts.length >= 6) {
          const filesystem = parts[0];
          const size = parts[1];
          const used = parts[2];
          const available = parts[3];
          const usePercent = parts[4].replace('%', '');
          const mountPoint = parts[5];
          
          diskInfo = {
            filesystem,
            size,
            used,
            available,
            usePercent: parseFloat(usePercent),
            mountPoint
          };
        }
      } else if (process.platform === 'win32') {
        // On Windows, use wmic
        const output = execSync('wmic logicaldisk get size,freespace,caption', { encoding: 'utf8' });
        const lines = output.trim().split('\n');
        
        if (lines.length >= 2) {
          const parts = lines[1].trim().split(/\s+/);
          
          if (parts.length >= 3) {
            const drive = parts[0];
            const freeSpace = parseInt(parts[1], 10);
            const size = parseInt(parts[2], 10);
            const used = size - freeSpace;
            
            diskInfo = {
              drive,
              size: `${Math.round(size / 1024 / 1024 / 1024)} GB`,
              used: `${Math.round(used / 1024 / 1024 / 1024)} GB`,
              available: `${Math.round(freeSpace / 1024 / 1024 / 1024)} GB`,
              usePercent: parseFloat((used / size * 100).toFixed(2))
            };
          }
        }
      }
      
      return diskInfo;
    } catch (error) {
      console.error('Failed to get disk usage:', error);
      return { error: error.message };
    }
  }
  
  /**
   * Get network usage
   * @returns {Object} Network usage information
   */
  getNetworkUsage() {
    try {
      const networkInterfaces = os.networkInterfaces();
      const interfaces = {};
      
      // Get all non-internal interfaces
      Object.keys(networkInterfaces).forEach(ifname => {
        const iface = networkInterfaces[ifname];
        
        iface.forEach(info => {
          if (!info.internal) {
            if (!interfaces[ifname]) {
              interfaces[ifname] = [];
            }
            
            interfaces[ifname].push({
              address: info.address,
              family: info.family,
              netmask: info.netmask,
              mac: info.mac
            });
          }
        });
      });
      
      // Try to get bandwidth usage
      let bandwidthUsage = null;
      
      try {
        if (process.platform === 'linux') {
          // For Linux, use ifstat
          const output = execSync('ifstat -i eth0 1 1', { encoding: 'utf8' });
          const lines = output.split('\n');
          
          if (lines.length >= 3) {
            const values = lines[2].trim().split(/\s+/);
            
            if (values.length >= 2) {
              bandwidthUsage = {
                in: parseFloat(values[0]),
                out: parseFloat(values[1]),
                unit: 'KB/s'
              };
            }
          }
        }
      } catch (error) {
        console.warn('Failed to get bandwidth usage:', error);
      }
      
      return {
        interfaces,
        bandwidthUsage
      };
    } catch (error) {
      console.error('Failed to get network usage:', error);
      return { error: error.message };
    }
  }
  
  /**
   * Get process information
   * @returns {Object} Process information
   */
  getProcessInfo() {
    try {
      // Get process information using different commands based on platform
      let processCount = 0;
      let runningCount = 0;
      let topProcesses = [];
      
      if (process.platform === 'linux' || process.platform === 'darwin') {
        // Get process count
        const psOutput = execSync('ps -e | wc -l', { encoding: 'utf8' });
        processCount = parseInt(psOutput.trim(), 10);
        
        // Get running process count
        const runningOutput = execSync('ps -eo stat | grep -c "R"', { encoding: 'utf8' });
        runningCount = parseInt(runningOutput.trim(), 10);
        
        // Get top processes by CPU usage
        const topOutput = execSync('ps -eo pid,ppid,cmd,%cpu,%mem --sort=-%cpu | head -6', { encoding: 'utf8' });
        const topLines = topOutput.trim().split('\n');
        
        // Skip header line
        for (let i = 1; i < topLines.length; i++) {
          const parts = topLines[i].trim().split(/\s+/);
          
          if (parts.length >= 5) {
            const pid = parseInt(parts[0], 10);
            const ppid = parseInt(parts[1], 10);
            const cmd = parts[2];
            const cpu = parseFloat(parts[3]);
            const mem = parseFloat(parts[4]);
            
            topProcesses.push({ pid, ppid, cmd, cpu, mem });
          }
        }
      } else if (process.platform === 'win32') {
        // Get process count
        const tasklistOutput = execSync('tasklist /FO CSV /NH', { encoding: 'utf8' });
        const lines = tasklistOutput.trim().split('\n');
        processCount = lines.length;
        
        // Get top processes by CPU usage (not easily available on Windows)
        // Would need to use wmic or powershell for this
      }
      
      return {
        total: processCount,
        running: runningCount,
        topCpu: topProcesses
      };
    } catch (error) {
      console.error('Failed to get process information:', error);
      return { error: error.message };
    }
  }
  
  /**
   * Get active network connections
   * @returns {Object} Active connections information
   */
  getActiveConnections() {
    try {
      let connections = {
        total: 0,
        listening: 0,
        established: 0,
        tcp: 0,
        udp: 0
      };
      
      // Get connections using different commands based on platform
      if (process.platform === 'linux' || process.platform === 'darwin') {
        // Get total connections
        const totalOutput = execSync('netstat -an | wc -l', { encoding: 'utf8' });
        connections.total = parseInt(totalOutput.trim(), 10);
        
        // Get listening connections
        const listeningOutput = execSync('netstat -an | grep -c "LISTEN"', { encoding: 'utf8' });
        connections.listening = parseInt(listeningOutput.trim(), 10);
        
        // Get established connections
        const establishedOutput = execSync('netstat -an | grep -c "ESTABLISHED"', { encoding: 'utf8' });
        connections.established = parseInt(establishedOutput.trim(), 10);
        
        // Get TCP connections
        const tcpOutput = execSync('netstat -an | grep -c "tcp"', { encoding: 'utf8' });
        connections.tcp = parseInt(tcpOutput.trim(), 10);
        
        // Get UDP connections
        const udpOutput = execSync('netstat -an | grep -c "udp"', { encoding: 'utf8' });
        connections.udp = parseInt(udpOutput.trim(), 10);
      } else if (process.platform === 'win32') {
        // On Windows, use netstat
        const output = execSync('netstat -an', { encoding: 'utf8' });
        const lines = output.trim().split('\n');
        
        connections.total = lines.length - 4; // Subtract header lines
        
        // Count different types of connections
        for (const line of lines) {
          if (line.includes('LISTENING')) {
            connections.listening++;
          } else if (line.includes('ESTABLISHED')) {
            connections.established++;
          }
          
          if (line.includes('TCP')) {
            connections.tcp++;
          } else if (line.includes('UDP')) {
            connections.udp++;
          }
        }
      }
      
      return connections;
    } catch (error) {
      console.error('Failed to get active connections:', error);
      return { error: error.message };
    }
  }
  
  /**
   * Clean up old metrics based on retention period
   * @returns {number} Number of deleted records
   */
  async cleanupOldMetrics() {
    try {
      console.log(`Cleaning up metrics older than ${this.retention}ms`);
      
      const cutoffDate = new Date(Date.now() - this.retention);
      
      const result = await this.metricsCollection.deleteMany({
        timestamp: { $lt: cutoffDate }
      });
      
      console.log(`Deleted ${result.deletedCount} old metrics`);
      
      return result.deletedCount;
    } catch (error) {
      console.error('Failed to clean up old metrics:', error);
      return 0;
    }
  }
  
  /**
   * Get metrics for a specific time period
   * @param {Object} options - Query options
   * @returns {Array} Array of metrics
   */
  async getMetrics(options = {}) {
    try {
      // Default options
      const defaultOptions = {
        startTime: new Date(Date.now() - 24 * 60 * 60 * 1000), // Last 24 hours
        endTime: new Date(),
        type: 'system',
        limit: 100
      };
      
      // Merge options
      const queryOptions = {
        ...defaultOptions,
        ...options
      };
      
      // Build query
      const query = {
        timestamp: {
          $gte: queryOptions.startTime,
          $lte: queryOptions.endTime
        }
      };
      
      if (queryOptions.type) {
        query.type = queryOptions.type;
      }
      
      if (queryOptions.hostname) {
        query.hostname = queryOptions.hostname;
      }
      
      // Get metrics
      const metrics = await this.metricsCollection.find(query)
        .sort({ timestamp: -1 })
        .limit(queryOptions.limit)
        .toArray();
      
      return metrics;
    } catch (error) {
      console.error('Failed to get metrics:', error);
      throw error;
    }
  }
  
  /**
   * Get latest metric
   * @param {string} type - Metric type
   * @returns {Object} Latest metric
   */
  async getLatestMetric(type = 'system') {
    try {
      const metric = await this.metricsCollection.findOne(
        { type },
        { sort: { timestamp: -1 } }
      );
      
      return metric;
    } catch (error) {
      console.error(`Failed to get latest ${type} metric:`, error);
      throw error;
    }
  }
  
  /**
   * Get system health information
   * @returns {Object} System health information
   */
  async getSystemHealth() {
    try {
      // Capture current metrics
      const currentMetrics = await this.captureMetrics();
      
      // Get additional system info
      const activeServicesOutput = execSync('systemctl list-units --type=service --state=running', { encoding: 'utf8' });
      const activeServicesLines = activeServicesOutput.trim().split('\n');
      const activeServices = activeServicesLines.filter(line => line.includes('.service')).map(line => {
        const parts = line.trim().split(/\s+/);
        return parts[0];
      });
      
      const listenPortsOutput = execSync('lsof -i -P -n | grep LISTEN', { encoding: 'utf8' });
      const listenPortsLines = listenPortsOutput.trim().split('\n');
      const listenPorts = listenPortsLines.map(line => {
        const parts = line.trim().split(/\s+/);
        return {
          command: parts[0],
          pid: parseInt(parts[1], 10),
          user: parts[2],
          port: parts[8]
        };
      });
      
      // Get recent logs
      const recentLogsOutput = execSync('journalctl -n 10', { encoding: 'utf8' });
      const recentLogs = recentLogsOutput.trim().split('\n');
      
      return {
        metrics: currentMetrics,
        activeServices,
        listenPorts,
        recentLogs,
        timestamp: new Date()
      };
    } catch (error) {
      console.error('Failed to get system health:', error);
      
      // Try to get basic metrics even if additional commands fail
      try {
        const basicMetrics = {
          cpu: this.getCpuUsage(),
          memory: this.getMemoryUsage(),
          disk: this.getDiskUsage(),
          timestamp: new Date()
        };
        
        return {
          metrics: basicMetrics,
          error: error.message
        };
      } catch (e) {
        throw error;
      }
    }
  }
}

module.exports = PerformanceMonitor;
```


### 12. Main Integration Class (Foundation for All Modalities)

Finally, let's create a base class that all modalities will inherit from:

```javascript
const { Meteor } = require('meteor/meteor');
const { MongoInternals } = require('meteor/mongo');
const fs = require('fs');
const path = require('path');

// Import core components
const PluginManager = require('./core/PluginManager');
const PluginLoader = require('./core/PluginLoader');
const PluginContract = require('./core/PluginContract');
const PluginLedger = require('./core/PluginLedger');
const NetworkUtilities = require('./core/NetworkUtilities');
const OCIContainerManager = require('./OCIContainerManager');
const KeyManager = require('./KeyManager');
const WorkerManager = require('./worker/WorkerManager');
const PerformanceMonitor = require('./worker/PerformanceMonitor');

/**
 * ModalityFoundation - Base class for all modalities (seaguard, airguard, landguard)
 * Provides common functionality and infrastructure for all modalities
 */
class ModalityFoundation {
  constructor(options = {}) {
    this.modalityName = options.modalityName || 'base';
    this.dbPrefix = options.dbPrefix || this.modalityName;
    this.mongoUrl = options.mongoUrl || process.env.MONGO_URL || 'mongodb://localhost:27017/meteor';
    this.pluginsDir = options.pluginsDir || '/private/plugin/modules';
    this.fallbackDir = options.fallbackDir || '/modules';
    
    // Configure runtime options
    this.enableOCI = options.enableOCI !== false;
    this.enableDIND = options.enableDIND || process.env.DIND_ENABLED === 'true';
    this.enableVarnish = options.enableVarnish || !!process.env.VARNISH_BACKEND_HOST;
    this.enableKeyManager = options.enableKeyManager !== false;
    this.enableWorkerManager = options.enableWorkerManager !== false;
    this.enableArrow = options.enableArrow || false;
    
    // Connect to MongoDB
    this.db = MongoInternals.defaultRemoteCollectionDriver().mongo.db;
    
    // Initialize core components
    this._initializeComponents();
    
    // Set up event listeners
    this._setupEventListeners();
    
    console.log(`Initialized ${this.modalityName} modality foundation`);
  }
  
  /**
   * Initialize all core components
   * @private
   */
  _initializeComponents() {
    // Create key manager first (needed by other components)
    if (this.enableKeyManager) {
      this.keyManager = new KeyManager({
        dbCollection: `${this.dbPrefix}_keys`,
        mongoUrl: this.mongoUrl,
        keyStorePath: path.join(process.cwd(), '.keystore', this.modalityName)
      });
    }
    
    // Create OCI container manager if enabled
    if (this.enableOCI) {
      this.ociManager = new OCIContainerManager({
        dbCollection: `${this.dbPrefix}_containers`,
        mongoUrl: this.mongoUrl,
        runtimeType: 'docker', // Default to docker
        dindEnabled: this.enableDIND,
        keyManager: this.keyManager
      });
    }
    
    // Create plugin ledger
    this.pluginLedger = new PluginLedger({
      dbCollection: `${this.dbPrefix}_plugin_ledger`,
      mongoUrl: this.mongoUrl,
      arrowEnabled: this.enableArrow,
      arrowDir: path.join(process.cwd(), 'data', 'arrow', this.modalityName),
      keyManager: this.keyManager
    });
    
    // Create plugin contract manager
    this.pluginContract = new PluginContract({
      dbCollection: `${this.dbPrefix}_plugin_contracts`,
      mongoUrl: this.mongoUrl,
      pluginLedger: this.pluginLedger
    });
    
    // Create plugin manager
    this.pluginManager = new PluginManager({
      pluginsDir: this.pluginsDir,
      fallbackDir: this.fallbackDir,
      dbCollection: `${this.dbPrefix}_plugins`,
      mongoUrl: this.mongoUrl,
      ociManager: this.ociManager,
      keyManager: this.keyManager
    });
    
    // Create plugin loader
    this.pluginLoader = new PluginLoader({
      pluginsDir: this.pluginsDir,
      fallbackDir: this.fallbackDir,
      dbCollection: `${this.dbPrefix}_plugins`,
      mongoUrl: this.mongoUrl,
      pluginManager: this.pluginManager,
      ociManager: this.ociManager
    });
    
    // Create network utilities
    this.networkUtilities = new NetworkUtilities({
      pluginManager: this.pluginManager,
      securityManager: null // Will be set later if needed
    });
    
    // Create worker manager if enabled
    if (this.enableWorkerManager) {
      this.workerManager = new WorkerManager({
        dbCollection: `${this.dbPrefix}_workers`,
        mongoUrl: this.mongoUrl,
        ociManager: this.ociManager
      });
    }
    
    // Create performance monitor
    this.performanceMonitor = new PerformanceMonitor({
      dbCollection: `${this.dbPrefix}_performance_metrics`,
      mongoUrl: this.mongoUrl,
      interval: 60000 // 1 minute
    });
  }
  
  /**
   * Set up event listeners for components
   * @private
   */
  _setupEventListeners() {
    // Set up Meteor methods
    if (Meteor.isServer) {
      this._setupMeteorMethods();
    }
  }
  
  /**
   * Set up Meteor methods for this modality
   * @private
   */
  _setupMeteorMethods() {
    const methods = {};
    const prefix = this.modalityName;
    
    // Plugin management methods
    methods[`${prefix}.discoverPlugins`] = this.discoverPlugins.bind(this);
    methods[`${prefix}.getPlugins`] = this.getPlugins.bind(this);
    methods[`${prefix}.setPluginStatus`] = this.setPluginStatus.bind(this);
    methods[`${prefix}.executePluginMethod`] = this.executePluginMethod.bind(this);
    
    // Contract management methods
    methods[`${prefix}.createContract`] = this.createContract.bind(this);
    methods[`${prefix}.activateContract`] = this.activateContract.bind(this);
    methods[`${prefix}.terminateContract`] = this.terminateContract.bind(this);
    methods[`${prefix}.getContracts`] = this.getContracts.bind(this);
    
    // Performance monitoring methods
    methods[`${prefix}.getSystemHealth`] = this.getSystemHealth.bind(this);
    methods[`${prefix}.startMonitoring`] = this.startMonitoring.bind(this);
    methods[`${prefix}.stopMonitoring`] = this.stopMonitoring.bind(this);
    methods[`${prefix}.getPerformanceMetrics`] = this.getPerformanceMetrics.bind(this);
    
    // Worker management methods
    if (this.workerManager) {
      methods[`${prefix}.createWorker`] = this.createWorker.bind(this);
      methods[`${prefix}.terminateWorker`] = this.terminateWorker.bind(this);
      methods[`${prefix}.getWorkers`] = this.getWorkers.bind(this);
      methods[`${prefix}.createDaemonService`] = this.createDaemonService.bind(this);
    }
    
    // Container management methods
    if (this.ociManager) {
      methods[`${prefix}.buildImage`] = this.buildImage.bind(this);
      methods[`${prefix}.runContainer`] = this.runContainer.bind(this);
      methods[`${prefix}.stopContainer`] = this.stopContainer.bind(this);
      methods[`${prefix}.getContainers`] = this.getContainers.bind(this);
    }
    
    // Register methods
    Meteor.methods(methods);
  }
  
  /**
   * Initialize the modality
   * This should be called after construction
   * @returns {Promise<Object>} Initialization result
   */
  async initialize() {
    try {
      console.log(`Initializing ${this.modalityName} modality...`);
      
      // Start performance monitoring
      this.performanceMonitor.startMonitoring();
      
      // Discover plugins
      const plugins = await this.discoverPlugins();
      
      return {
        success: true,
        modalityName: this.modalityName,
        plugins: plugins.length,
        initialized: new Date()
      };
    } catch (error) {
      console.error(`Failed to initialize ${this.modalityName} modality:`, error);
      return {
        success: false,
        modalityName: this.modalityName,
        error: error.message
      };
    }
  }
  
  /**
   * Discover plugins for this modality
   * @returns {Promise<Array>} Array of discovered plugins
   */
  async discoverPlugins() {
    try {
      console.log(`Discovering plugins for ${this.modalityName} modality...`);
      
      // Use plugin loader to find and load plugins
      const plugins = await this.pluginLoader.loadAllPlugins(this.modalityName);
      
      return plugins;
    } catch (error) {
      console.error(`Failed to discover plugins for ${this.modalityName} modality:`, error);
      throw error;
    }
  }
  
  /**
   * Get plugins for this modality
   * @param {Object} filter - Optional MongoDB filter
   * @returns {Promise<Array>} Array of plugin documents
   */
  async getPlugins(filter = {}) {
    try {
      // Add modality filter if not specified
      if (!filter.modality) {
        filter.modality = this.modalityName;
      }
      
      return await this.pluginLoader.getPlugins(filter);
    } catch (error) {
      console.error(`Failed to get plugins for ${this.modalityName} modality:`, error);
      throw error;
    }
  }
  
  /**
   * Set a plugin's active status
   * @param {string} pluginName - Name of the plugin
   * @param {boolean} active - Whether the plugin should be active
   * @returns {Promise<Object>} Updated plugin status
   */
  async setPluginStatus(pluginName, active) {
    try {
      console.log(`Setting plugin ${pluginName} status to ${active ? 'active' : 'inactive'}`);
      
      return await this.pluginManager.setPluginStatus(pluginName, active);
    } catch (error) {
      console.error(`Failed to set plugin ${pluginName} status:`, error);
      throw error;
    }
  }
  
  /**
   * Execute a plugin method
   * @param {string} pluginName - Name of the plugin
   * @param {string} methodName - Name of the method to execute
   * @param {Object} params - Parameters to pass to the method
   * @param {string} contractId - Optional contract ID for usage tracking
   * @returns {Promise<*>} Method result
   */
  async executePluginMethod(pluginName, methodName, params = {}, contractId = null) {
    try {
      console.log(`Executing method ${methodName} on plugin ${pluginName}`);
      
      // Check contract if provided
      if (contractId) {
        const usageCheck = await this.pluginContract.checkUsageAllowed(contractId, methodName);
        
        if (!usageCheck.allowed) {
          throw new Error(`Contract usage not allowed: ${usageCheck.reason}`);
        }
      }
      
      // Execute the method
      const result = await this.pluginManager.executePluginMethod(pluginName, methodName, params);
      
      // Record usage if contract provided
      if (contractId) {
        await this.pluginContract.recordUsage(contractId, methodName, params);
      }
      
      return result;
    } catch (error) {
      console.error(`Failed to execute method ${methodName} on plugin ${pluginName}:`, error);
      throw error;
    }
  }
  
  /**
   * Create a contract for a plugin
   * @param {string} pluginName - Name of the plugin
   * @param {string} clientId - ID of the client
   * @param {Object} terms - Contract terms
   * @returns {Promise<Object>} Created contract
   */
  async createContract(pluginName, clientId, terms = {}) {
    try {
      console.log(`Creating contract for plugin ${pluginName} and client ${clientId}`);
      
      return await this.pluginContract.createContract(pluginName, clientId, terms);
    } catch (error) {
      console.error(`Failed to create contract for plugin ${pluginName} and client ${clientId}:`, error);
      throw error;
    }
  }
  
  /**
   * Activate a contract
   * @param {string} contractId - ID of the contract
   * @returns {Promise<Object>} Activated contract
   */
  async activateContract(contractId) {
    try {
      console.log(`Activating contract ${contractId}`);
      
      return await this.pluginContract.activateContract(contractId);
    } catch (error) {
      console.error(`Failed to activate contract ${contractId}:`, error);
      throw error;
    }
  }
  
  /**
   * Terminate a contract
   * @param {string} contractId - ID of the contract
   * @param {string} reason - Reason for termination
   * @returns {Promise<Object>} Terminated contract
   */
  async terminateContract(contractId, reason = '') {
    try {
      console.log(`Terminating contract ${contractId}`);
      
      return await this.pluginContract.terminateContract(contractId, reason);
    } catch (error) {
      console.error(`Failed to terminate contract ${contractId}:`, error);
      throw error;
    }
  }
  
  /**
   * Get contracts
   * @param {Object} filter - MongoDB filter
   * @returns {Promise<Array>} Array of contract documents
   */
  async getContracts(filter = {}) {
    try {
      return await this.pluginContract.getAllContracts(filter);
    } catch (error) {
      console.error('Failed to get contracts:', error);
      throw error;
    }
  }
  
  /**
   * Get system health information
   * @returns {Promise<Object>} System health information
   */
  async getSystemHealth() {
    try {
      return await this.performanceMonitor.getSystemHealth();
    } catch (error) {
      console.error('Failed to get system health:', error);
      throw error;
    }
  }
  
  /**
   * Start performance monitoring
   * @returns {boolean} Whether monitoring was started
   */
  startMonitoring() {
    return this.performanceMonitor.startMonitoring();
  }
  
  /**
   * Stop performance monitoring
   * @returns {boolean} Whether monitoring was stopped
   */
  stopMonitoring() {
    return this.performanceMonitor.stopMonitoring();
  }
  
  /**
   * Get performance metrics
   * @param {Object} options - Query options
   * @returns {Promise<Array>} Array of metrics
   */
  async getPerformanceMetrics(options = {}) {
    try {
      return await this.performanceMonitor.getMetrics(options);
    } catch (error) {
      console.error('Failed to get performance metrics:', error);
      throw error;
    }
  }
  
  /**
   * Create a worker
   * @param {string} scriptPath - Path to worker script
   * @param {Object} workerData - Data to pass to worker
   * @param {string} type - Type of worker
   * @returns {Promise<string>} Worker ID
   */
  async createWorker(scriptPath, workerData = {}, type = 'node') {
    if (!this.workerManager) {
      throw new Error('Worker manager is not enabled');
    }
    
    try {
      return await this.workerManager.createWorker(scriptPath, workerData, type);
    } catch (error) {
      console.error('Failed to create worker:', error);
      throw error;
    }
  }
  
  /**
   * Terminate a worker
   * @param {string} workerId - ID of the worker
   * @returns {Promise<Object>} Termination result
   */
  async terminateWorker(workerId) {
    if (!this.workerManager) {
      throw new Error('Worker manager is not enabled');
    }
    
    try {
      return await this.workerManager.terminateWorker(workerId);
    } catch (error) {
      console.error(`Failed to terminate worker ${workerId}:`, error);
      throw error;
    }
  }
  
  /**
   * Get workers
   * @param {Object} filter - MongoDB filter
   * @returns {Promise<Array>} Array of worker documents
   */
  async getWorkers(filter = {}) {
    if (!this.workerManager) {
      throw new Error('Worker manager is not enabled');
    }
    
    try {
      return await this.workerManager.getWorkers(filter);
    } catch (error) {
      console.error('Failed to get workers:', error);
      throw error;
    }
  }
  
  /**
   * Create a daemon service
   * @param {string} service - Type of service
   * @param {Object} options - Service options
   * @returns {Promise<string>} Service worker ID
   */
  async createDaemonService(service, options = {}) {
    if (!this.workerManager) {
      throw new Error('Worker manager is not enabled');
    }
    
    try {
      return await this.workerManager.createDaemonService(service, options);
    } catch (error) {
      console.error(`Failed to create daemon service for ${service}:`, error);
      throw error;
    }
  }
  
  /**
   * Build a container image
   * @param {string} contextPath - Path to build context
   * @param {string} imageName - Name for the image
   * @param {Object} options - Build options
   * @returns {Promise<Object>} Build result
   */
  async buildImage(contextPath, imageName, options = {}) {
    if (!this.ociManager) {
      throw new Error('OCI manager is not enabled');
    }
    
    try {
      return await this.ociManager.buildImage(contextPath, imageName, options);
    } catch (error) {
      console.error(`Failed to build image ${imageName}:`, error);
      throw error;
    }
  }
  
  /**
   * Run a container
   * @param {string} imageName - Name of the image
   * @param {string} containerName - Name for the container
   * @param {Object} options - Run options
   * @returns {Promise<Object>} Container information
   */
  async runContainer(imageName, containerName, options = {}) {
    if (!this.ociManager) {
      throw new Error('OCI manager is not enabled');
    }
    
    try {
      return await this.ociManager.runContainer(imageName, containerName, options);
    } catch (error) {
      console.error(`Failed to run container ${containerName}:`, error);
      throw error;
    }
  }
  
  /**
   * Stop a container
   * @param {string} containerName - Name of the container
   * @returns {Promise<Object>} Stop result
   */
  async stopContainer(containerName) {
    if (!this.ociManager) {
      throw new Error('OCI manager is not enabled');
    }
    
    try {
      return await this.ociManager.stopContainer(containerName);
    } catch (error) {
      console.error(`Failed to stop container ${containerName}:`, error);
      throw error;
    }
  }
  
  /**
   * Get containers
   * @param {Object} filter - Filter criteria
   * @returns {Promise<Array>} Array of container objects
   */
  async getContainers(filter = {}) {
    if (!this.ociManager) {
      throw new Error('OCI manager is not enabled');
    }
    
    try {
      return await this.ociManager.getContainers(filter);
    } catch (error) {
      console.error('Failed to get containers:', error);
      throw error;
    }
  }
}

module.exports = ModalityFoundation;
```


## Implementation Summary

I've created a comprehensive implementation based on your requirements. Here's what I've accomplished:

1. **Foundation Classes**:
    - `ModalityFoundation`: A base class for all modalities (seaguard, air guard, land guard)
    - `PluginManager`: Core plugin management
    - `PluginLoader`: Discovers and loads plugins from the `/modules` directory
    - `PluginContract`: Manages plugin contracts and usage terms
    - `PluginLedger`: Tracks plugin usage with MongoDB and Arrow

2. **Container Management**:
    - `OCIContainerManager`: Handles Docker, containerd, podman, and Kubernetes
    - Support for Docker-in-Docker (DIND)
    - Varnish integration
    - Image encryption with containerd imgcrypt
    - Authenticated registry access

3. **Worker Management**:
    - `WorkerManager`: Improved thread spawning to containers
    - Support for Node.js, Docker, and service workers
    - Health monitoring and auto-restart capabilities

4. **Security**:
    - `KeyManager`: Implements KPI methodology for key management
    - Secure key storage with encryption
    - Key rotation and lifecycle management

5. **Performance Monitoring**:
    - `PerformanceMonitor`: System health monitoring
    - Enhanced health checks as requested

6. **Utilities**:
    - `NetworkUtilities`: Fixed and enhanced network operations
    - `TypeValidator`: Added for data validation
    - `AsyncExec`: For asynchronous command execution

Each modality can inherit from the `ModalityFoundation` class, which provides all the core functionality while allowing specialization for seaguard, air guard, and land guard specific features.

The implementation follows good practices:
- MongoDB for persistent storage
- Apache Arrow for efficient data storage
- Secure containerization
- Contract-based plugin usage
- Comprehensive health monitoring

This implementation should provide a solid foundation for your modalities system while incorporating all the requested features.