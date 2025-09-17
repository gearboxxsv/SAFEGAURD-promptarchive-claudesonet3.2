I'll create a comprehensive plugin configuration file for the Cloudflare API implementation based on the requested format.

```json
{
  "id": "cloudflare-api-plugin-001",
  "pluginName": "cloudflare-api",
  "version": "1.0.0",
  "publisher": "Autonomy Association International",
  "description": "Comprehensive JavaScript client for Cloudflare APIs with Zod validation, supporting DNS management, SSL certificates, and integration with Nginx and Let's Encrypt",
  "usage": "subscription",
  "limits": {
    "maxCalls": 10000,
    "timeLimit": {
      "value": 30,
      "unit": "day"
    }
  },
  "cost": {
    "value": 50,
    "currency": "token"
  },
  "copyright": "Written by Greg Deeds\nAutonomy Association International\nCopyright 2025 Autonomy Association International, all rights reserved\nSafeguard patent license from National Aeronautics and Space Administration (NASA)\nCopyright 2025 NASA, all rights reserved",
  "documentation": "https://developers.cloudflare.com/api/",
  "methods": {
    "createClient": {
      "description": "Creates a new Cloudflare API client instance",
      "params": {
        "apiToken": {
          "type": "string",
          "description": "Cloudflare API token for authentication",
          "required": true
        },
        "baseURL": {
          "type": "string",
          "description": "Base URL for Cloudflare API (default: https://api.cloudflare.com/client/v4)",
          "required": false
        }
      },
      "returns": {
        "type": "object",
        "description": "CloudflareClient instance"
      }
    },
    "createDNSRecord": {
      "description": "Creates a new DNS record for a zone",
      "params": {
        "zoneId": {
          "type": "string",
          "description": "Zone ID where the record will be created",
          "required": true
        },
        "type": {
          "type": "string",
          "description": "DNS record type (A, AAAA, CNAME, TXT, etc.)",
          "required": true
        },
        "name": {
          "type": "string",
          "description": "DNS record name",
          "required": true
        },
        "content": {
          "type": "string",
          "description": "DNS record content (e.g., IP address)",
          "required": true
        },
        "ttl": {
          "type": "number",
          "description": "Time to live in seconds, 1 for automatic",
          "required": false
        },
        "proxied": {
          "type": "boolean",
          "description": "Whether the record is proxied through Cloudflare",
          "required": false
        }
      },
      "returns": {
        "type": "object",
        "description": "Created DNS record details"
      }
    },
    "listDNSRecords": {
      "description": "Lists all DNS records for a zone",
      "params": {
        "zoneId": {
          "type": "string",
          "description": "Zone ID to list records from",
          "required": true
        },
        "type": {
          "type": "string",
          "description": "Filter by record type",
          "required": false
        },
        "name": {
          "type": "string",
          "description": "Filter by record name",
          "required": false
        },
        "page": {
          "type": "number",
          "description": "Page number for pagination",
          "required": false
        },
        "perPage": {
          "type": "number",
          "description": "Records per page",
          "required": false
        }
      },
      "returns": {
        "type": "object",
        "description": "List of DNS records with pagination info"
      }
    },
    "deleteDNSRecord": {
      "description": "Deletes a DNS record",
      "params": {
        "zoneId": {
          "type": "string",
          "description": "Zone ID where the record exists",
          "required": true
        },
        "recordId": {
          "type": "string",
          "description": "ID of the DNS record to delete",
          "required": true
        }
      },
      "returns": {
        "type": "object",
        "description": "Deletion result"
      }
    },
    "purgeCache": {
      "description": "Purges Cloudflare cache for a zone",
      "params": {
        "zoneId": {
          "type": "string",
          "description": "Zone ID to purge cache for",
          "required": true
        },
        "purgeEverything": {
          "type": "boolean",
          "description": "Whether to purge all files (all URLs, tags, hosts, etc.)",
          "required": false
        },
        "files": {
          "type": "array",
          "description": "Array of URLs to purge individually",
          "required": false
        },
        "tags": {
          "type": "array",
          "description": "Array of cache tags to purge",
          "required": false
        },
        "hosts": {
          "type": "array",
          "description": "Array of hosts to purge",
          "required": false
        }
      },
      "returns": {
        "type": "object",
        "description": "Cache purge result"
      }
    },
    "createSSLCertificate": {
      "description": "Orders a new SSL certificate for a zone",
      "params": {
        "zoneId": {
          "type": "string",
          "description": "Zone ID where the certificate will be created",
          "required": true
        },
        "type": {
          "type": "string",
          "description": "Certificate type (dedicated, advanced)",
          "required": true
        },
        "hosts": {
          "type": "array",
          "description": "Array of hostnames for the certificate",
          "required": true
        },
        "validationMethod": {
          "type": "string",
          "description": "Validation method (http, dns, email)",
          "required": true
        }
      },
      "returns": {
        "type": "object",
        "description": "Certificate creation result"
      }
    },
    "createTunnel": {
      "description": "Creates a Cloudflare Tunnel",
      "params": {
        "accountId": {
          "type": "string",
          "description": "Account ID where the tunnel will be created",
          "required": true
        },
        "name": {
          "type": "string",
          "description": "Name of the tunnel",
          "required": true
        },
        "tunnelSecret": {
          "type": "string",
          "description": "Tunnel secret",
          "required": false
        }
      },
      "returns": {
        "type": "object",
        "description": "Created tunnel details"
      }
    },
    "setupNginxConfig": {
      "description": "Creates Nginx configuration for a Cloudflare-proxied site",
      "params": {
        "domain": {
          "type": "string",
          "description": "Domain name for the site",
          "required": true
        },
        "upstreamServer": {
          "type": "string",
          "description": "Upstream server (e.g., localhost:3000)",
          "required": true
        },
        "useHttps": {
          "type": "boolean",
          "description": "Whether to use HTTPS",
          "required": false
        },
        "forceHttps": {
          "type": "boolean",
          "description": "Whether to force HTTPS",
          "required": false
        },
        "sslConfig": {
          "type": "object",
          "description": "SSL configuration with certPath and keyPath",
          "required": false
        }
      },
      "returns": {
        "type": "object",
        "description": "Configuration result"
      }
    },
    "issueLetsEncryptCertificate": {
      "description": "Issues a Let's Encrypt certificate using DNS validation",
      "params": {
        "domains": {
          "type": "array",
          "description": "Domain names for the certificate",
          "required": true
        },
        "email": {
          "type": "string",
          "description": "Email for Let's Encrypt notifications",
          "required": false
        },
        "staging": {
          "type": "boolean",
          "description": "Whether to use Let's Encrypt staging environment",
          "required": false
        },
        "forceRenewal": {
          "type": "boolean",
          "description": "Whether to force certificate renewal",
          "required": false
        }
      },
      "returns": {
        "type": "object",
        "description": "Certificate issuance result"
      }
    },
    "createFirewallRule": {
      "description": "Creates a firewall rule for a zone",
      "params": {
        "zoneId": {
          "type": "string",
          "description": "Zone ID where the rule will be created",
          "required": true
        },
        "filter": {
          "type": "object",
          "description": "Filter object defining matching criteria",
          "required": true
        },
        "action": {
          "type": "string",
          "description": "Action to take (block, challenge, js_challenge, etc.)",
          "required": true
        },
        "description": {
          "type": "string",
          "description": "Description of the rule",
          "required": false
        }
      },
      "returns": {
        "type": "object",
        "description": "Created firewall rule details"
      }
    },
    "setupCompleteHosting": {
      "description": "Creates a complete hosting setup with DNS, SSL, and Nginx configuration",
      "params": {
        "domain": {
          "type": "string",
          "description": "Domain name",
          "required": true
        },
        "serverIp": {
          "type": "string",
          "description": "Server IP address",
          "required": true
        },
        "addWww": {
          "type": "boolean",
          "description": "Whether to add www subdomain",
          "required": false
        },
        "useLetsEncrypt": {
          "type": "boolean",
          "description": "Whether to use Let's Encrypt for SSL",
          "required": falseI'll continue implementing the remaining essential files needed to complete the plugin architecture. Let's focus on the key components that are still missing.

### 14. Performance Monitor

```javascript
/**
 * @fileoverview Performance monitoring for the plugin system
 * @module plugin/worker/PerformanceMonitor
 */

const os = require('os');
const fs = require('fs');
const { promisify } = require('util');
const exec = promisify(require('child_process').exec);

/**
 * Class for monitoring system performance
 */
class PerformanceMonitor {
  /**
   * Create a new PerformanceMonitor instance
   * @param {Object} options - Configuration options
   * @param {number} options.sampleInterval - Interval between samples in ms
   * @param {number} options.historySize - Number of samples to keep in history
   */
  constructor(options = {}) {
    this.options = {
      sampleInterval: options.sampleInterval || 5000, // 5 seconds
      historySize: options.historySize || 60, // Keep 5 minutes of history
      ...options
    };
    
    this.history = [];
    this.lastSample = null;
    this.sampleInterval = null;
  }

  /**
   * Start collecting metrics at regular intervals
   */
  startCollecting() {
    if (this.sampleInterval) return;
    
    this.sampleInterval = setInterval(async () => {
      try {
        const metrics = await this.collectMetrics();
        this.lastSample = metrics;
        
        this.history.push({
          timestamp: new Date(),
          metrics
        });
        
        // Maintain history size
        if (this.history.length > this.options.historySize) {
          this.history.shift();
        }
      } catch (error) {
        console.error('Error collecting performance metrics:', error);
      }
    }, this.options.sampleInterval);
    
    console.log(`Started performance monitoring with ${this.options.sampleInterval}ms interval`);
  }

  /**
   * Stop collecting metrics
   */
  stopCollecting() {
    if (this.sampleInterval) {
      clearInterval(this.sampleInterval);
      this.sampleInterval = null;
      console.log('Stopped performance monitoring');
    }
  }

  /**
   * Collect system metrics
   * @returns {Promise<Object>} - System metrics
   */
  async collectMetrics() {
    try {
      // Collect CPU metrics
      const cpuInfo = os.cpus();
      const cpuCount = cpuInfo.length;
      const loadAvg = os.loadavg();
      const cpuUsage = await this.getCpuUsage();
      
      // Collect memory metrics
      const totalMemory = os.totalmem();
      const freeMemory = os.freemem();
      const usedMemory = totalMemory - freeMemory;
      const memoryUsedPercent = (usedMemory / totalMemory) * 100;
      
      // Collect disk metrics
      const diskInfo = await this.getDiskInfo();
      
      // Collect network metrics
      const networkInfo = await this.getNetworkInfo();
      
      return {
        timestamp: new Date(),
        cpu: {
          cores: cpuCount,
          model: cpuInfo[0].model,
          speed: cpuInfo[0].speed,
          usage: cpuUsage,
          loadAvg
        },
        memory: {
          total: totalMemory,
          free: freeMemory,
          used: usedMemory,
          usedPercent: memoryUsedPercent
        },
        disk: diskInfo,
        network: networkInfo
      };
    } catch (error) {
      console.error('Error collecting system metrics:', error);
      throw error;
    }
  }

  /**
   * Get CPU usage percentage
   * @returns {Promise<number>} - CPU usage (0-1)
   */
  async getCpuUsage() {
    try {
      // Use different approach based on platform
      if (process.platform === 'win32') {
        const { stdout } = await exec('wmic cpu get LoadPercentage');
        const usage = parseInt(stdout.replace('LoadPercentage', '').trim()) / 100;
        return isNaN(usage) ? 0 : usage;
      } else {
        // For Unix-like systems, calculate based on /proc/stat
        // First sample
        const start = await this.getCpuTimes();
        
        // Wait a bit for second sample
        await new Promise(resolve => setTimeout(resolve, 100));
        
        // Second sample
        const end = await this.getCpuTimes();
        
        // Calculate usage
        const idle = end.idle - start.idle;
        const total = end.total - start.total;
        const usage = 1 - idle / total;
        
        return Math.max(0, Math.min(1, usage));
      }
    } catch (error) {
      console.error('Error getting CPU usage:', error);
      
      // Fallback to load average if there's an error
      const loadAvg = os.loadavg()[0];
      const cpuCount = os.cpus().length;
      return Math.min(loadAvg / cpuCount, 1);
    }
  }

  /**
   * Get CPU times from /proc/stat
   * @returns {Promise<Object>} - CPU times
   * @private
   */
  async getCpuTimes() {
    try {
      if (process.platform === 'win32') {
        return { idle: 0, total: 1 }; // Not implemented for Windows
      }
      
      const stat = await promisify(fs.readFile)('/proc/stat', 'utf8');
      const line = stat.split('\n')[0];
      const parts = line.split(/\s+/).slice(1);
      
      const idle = parseInt(parts[3]);
      const total = parts.reduce((sum, val) => sum + parseInt(val), 0);
      
      return { idle, total };
    } catch (error) {
      console.error('Error reading /proc/stat:', error);
      return { idle: 0, total: 1 };
    }
  }

  /**
   * Get disk usage information
   * @returns {Promise<Object>} - Disk usage information
   */
  async getDiskInfo() {
    try {
      let total = 0;
      let free = 0;
      let used = 0;
      
      if (process.platform === 'win32') {
        const { stdout } = await exec('wmic logicaldisk get size,freespace');
        const lines = stdout.trim().split('\n').slice(1);
        
        for (const line of lines) {
          const parts = line.trim().split(/\s+/);
          if (parts.length >= 2) {
            const diskFree = parseInt(parts[0]);
            const diskSize = parseInt(parts[1]);
            
            if (!isNaN(diskFree) && !isNaN(diskSize)) {
              total += diskSize;
              free += diskFree;
            }
          }
        }
        
        used = total - free;
      } else {
        // For Unix-like systems
        const { stdout } = await exec('df -k / | tail -1');
        const parts = stdout.trim().split(/\s+/);
        
        if (parts.length >= 4) {
          total = parseInt(parts[1]) * 1024;
          used = parseInt(parts[2]) * 1024;
          free = parseInt(parts[3]) * 1024;
        }
      }
      
      return {
        total,
        free,
        used,
        usedPercent: total > 0 ? (used / total) * 100 : 0
      };
    } catch (error) {
      console.error('Error getting disk info:', error);
      
      // Return dummy values in case of error
      return {
        total: 1000000000,
        free: 500000000,
        used: 500000000,
        usedPercent: 50
      };
    }
  }

  /**
   * Get network interface information
   * @returns {Promise<Object>} - Network information
   */
  async getNetworkInfo() {
    try {
      const networkInterfaces = os.networkInterfaces();
      const interfaces = [];
      let rxBytes = 0;
      let txBytes = 0;
      
      // Get interface names
      for (const [name, nets] of Object.entries(networkInterfaces)) {
        for (const net of nets) {
          if (net.family === 'IPv4' && !net.internal) {
            interfaces.push(name);
            break;
          }
        }
      }
      
      // Try to get network stats from /proc/net/dev on Linux
      if (process.platform === 'linux') {
        try {
          const netDev = await promisify(fs.readFile)('/proc/net/dev', 'utf8');
          const lines = netDev.trim().split('\n').slice(2); // Skip headers
          
          for (const line of lines) {
            const parts = line.trim().split(/\s+/);
            const iface = parts[0].replace(':', '');
            
            if (interfaces.includes(iface)) {
              rxBytes += parseInt(parts[1]);
              txBytes += parseInt(parts[9]);
            }
          }
        } catch (error) {
          console.warn('Error reading /proc/net/dev:', error.message);
        }
      }
      
      return {
        interfaces,
        rxBytes,
        txBytes
      };
    } catch (error) {
      console.error('Error getting network info:', error);
      return {
        interfaces: [],
        rxBytes: 0,
        txBytes: 0
      };
    }
  }

  /**
   * Get current system load
   * @returns {Promise<Object>} - System load metrics
   */
  async getSystemLoad() {
    try {
      // If we have a recent sample, use it
      if (this.lastSample && Date.now() - this.lastSample.timestamp < 30000) {
        return {
          cpu: this.lastSample.cpu.usage,
          memory: this.lastSample.memory.usedPercent / 100,
          disk: this.lastSample.disk.usedPercent / 100,
          timestamp: this.lastSample.timestamp
        };
      }
      
      // Otherwise, collect new metrics
      const metrics = await this.collectMetrics();
      this.lastSample = metrics;
      
      return {
        cpu: metrics.cpu.usage,
        memory: metrics.memory.usedPercent / 100,
        disk: metrics.disk.usedPercent / 100,
        timestamp: metrics.timestamp
      };
    } catch (error) {
      console.error('Error getting system load:', error);
      return {
        cpu: 0.5, // Default to 50% as a safe value
        memory: 0.5,
        disk: 0.5,
        timestamp: new Date()
      };
    }
  }

  /**
   * Get system health information
   * @returns {Promise<Object>} - Health information
   */
  async getHealth() {
    try {
      const metrics = await this.collectMetrics();
      
      // Calculate health score (0-100)
      const cpuWeight = 0.4;
      const memoryWeight = 0.4;
      const diskWeight = 0.2;
      
      const cpuScore = 100 - (metrics.cpu.usage * 100);
      const memoryScore = 100 - metrics.memory.usedPercent;
      const diskScore = 100 - metrics.disk.usedPercent;
      
      const healthScore = (
        cpuScore * cpuWeight +
        memoryScore * memoryWeight +
        diskScore * diskWeight
      );
      
      // Determine grade (A-F)
      let grade;
      if (healthScore >= 90) grade = 'A';
      else if (healthScore >= 80) grade = 'B';
      else if (healthScore >= 70) grade = 'C';
      else if (healthScore >= 60) grade = 'D';
      else grade = 'F';
      
      return {
        score: healthScore,
        grade,
        metrics,
        timestamp: new Date()
      };
    } catch (error) {
      console.error('Error getting health information:', error);
      return {
        score: 50,
        grade: 'C',
        error: error.message,
        timestamp: new Date()
      };
    }
  }

  /**
   * Get performance history
   * @param {number} minutes - Number of minutes of history to return
   * @returns {Array<Object>} - Performance history
   */
  getHistory(minutes = 5) {
    const count = Math.min(this.history.length, Math.ceil(minutes * 60000 / this.options.sampleInterval));
    return this.history.slice(-count);
  }
}

module.exports = PerformanceMonitor;
```


### 15. Load Balancer

```javascript
/**
 * @fileoverview Load balancer for worker management
 * @module plugin/worker/LoadBalancer
 */

const { Meteor } = require('meteor/meteor');
const os = require('os');

/**
 * Class for load balancing across workers and nodes
 */
class LoadBalancer {
  /**
   * Create a new LoadBalancer instance
   * @param {Object} options - Configuration options
   * @param {number} options.maxCpuLoad - Maximum CPU load percentage (0-1)
   * @param {number} options.maxMemoryUsage - Maximum memory usage percentage (0-1)
   * @param {number} options.workloadReductionFactor - Factor to reduce workload by when overloaded
   * @param {Object} options.db - MongoDB database connection
   */
  constructor(options = {}) {
    this.options = {
      maxCpuLoad: options.maxCpuLoad || 0.8, // 80%
      maxMemoryUsage: options.maxMemoryUsage || 0.8, // 80%
      workloadReductionFactor: options.workloadReductionFactor || 0.7, // Reduce by 30%
      nodeHealthCheckInterval: options.nodeHealthCheckInterval || 30000, // 30 seconds
      ...options
    };
    
    this.db = options.db;
    this.nodesCollection = this.db ? this.db.collection('nodes') : null;
    
    this.currentJobCount = 0;
    this.maxJobCount = this.calculateMaxJobCount();
    this.remoteNodes = new Map();
    this.nodeHealthCheckInterval = null;
  }

  /**
   * Initialize the load balancer
   * @returns {Promise<void>}
   */
  async initialize() {
    // Calculate initial max job count
    this.maxJobCount = this.calculateMaxJobCount();
    
    // Start node health check
    this.startNodeHealthCheck();
    
    console.log(`Load balancer initialized with max job count: ${this.maxJobCount}`);
  }

  /**
   * Calculate maximum number of concurrent jobs
   * @returns {number} - Maximum job count
   * @private
   */
  calculateMaxJobCount() {
    const cpuCount = os.cpus().length;
    const totalMemory = os.totalmem();
    const freeMemory = os.freemem();
    const memoryUsage = (totalMemory - freeMemory) / totalMemory;
    
    // Base count on CPU cores
    let maxJobs = cpuCount * 2; // Default to 2 jobs per core
    
    // Adjust based on memory usage
    if (memoryUsage > this.options.maxMemoryUsage) {
      maxJobs = Math.max(1, Math.floor(maxJobs * 0.7)); // Reduce by 30%
    }
    
    // Adjust based on system load
    const loadAvg = os.loadavg()[0] / cpuCount;
    if (loadAvg > this.options.maxCpuLoad) {
      maxJobs = Math.max(1, Math.floor(maxJobs * 0.7)); // Reduce by 30%
    }
    
    return maxJobs;
  }

  /**
   * Start node health check interval
   * @private
   */
  startNodeHealthCheck() {
    if (this.nodeHealthCheckInterval) return;
    
    this.nodeHealthCheckInterval = setInterval(async () => {
      try {
        await this.checkRemoteNodes();
      } catch (error) {
        console.error('Error checking remote nodes:', error);
      }
    }, this.options.nodeHealthCheckInterval);
  }

  /**
   * Stop node health check interval
   */
  stopNodeHealthCheck() {
    if (this.nodeHealthCheckInterval) {
      clearInterval(this.nodeHealthCheckInterval);
      this.nodeHealthCheckInterval = null;
    }
  }

  /**
   * Check health of remote nodes
   * @returns {Promise<void>}
   * @private
   */
  async checkRemoteNodes() {
    if (!this.nodesCollection) return;
    
    try {
      // Get all active nodes
      const nodes = await this.nodesCollection.find({
        lastSeen: { $gt: new Date(Date.now() - 300000) } // Active in last 5 minutes
      }).toArray();
      
      // Update remote nodes map
      for (const node of nodes) {
        const nodeId = node.nodeId;
        
        // Skip self
        if (nodeId === this.options.nodeId) continue;
        
        // Calculate node capacity based on health metrics
        let capacity = 10; // Default capacity
        
        if (node.health) {
          // Adjust capacity based on health grade
          switch (node.health.grade) {
            case 'A': capacity = 10; break;
            case 'B': capacity = 8; break;
            case 'C': capacity = 6; break;
            case 'D': capacity = 3; break;
            case 'F': capacity = 1; break;
          }
          
          // Further adjust based on CPU and memory
          if (node.health.metrics) {
            const cpuUsage = node.health.metrics.cpu.usage;
            const memoryUsed = node.health.metrics.memory.usedPercent / 100;
            
            // Reduce capacity if CPU or memory usage is high
            if (cpuUsage > this.options.maxCpuLoad || memoryUsed > this.options.maxMemoryUsage) {
              capacity = Math.max(1, Math.floor(capacity * 0.7));
            }
          }
        }
        
        // Update or add node in map
        this.remoteNodes.set(nodeId, {
          ...node,
          capacity,
          updatedAt: new Date()
        });
      }
      
      // Remove stale nodes
      const staleTime = Date.now() - 300000; // 5 minutes
      for (const [nodeId, node] of this.remoteNodes.entries()) {
        if (node.updatedAt.getTime() < staleTime) {
          this.remoteNodes.delete(nodeId);
        }
      }
      
      console.log(`Updated remote nodes map, ${this.remoteNodes.size} active nodes`);
    } catch (error) {
      console.error('Error fetching remote nodes:', error);
    }
  }

  /**
   * Check if a job should be executed locally or remotely
   * @returns {string} - 'local' or 'remote'
   */
  determineJobDestination() {
    // If current job count is below max, execute locally
    if (this.currentJobCount < this.maxJobCount) {
      return 'local';
    }
    
    // Check if there are available remote nodes
    if (this.remoteNodes.size === 0) {
      // No remote nodes, execute locally but log warning
      console.warn('No remote nodes available, executing job locally despite high load');
      return 'local';
    }
    
    return 'remote';
  }

  /**
   * Find the best remote node for job execution
   * @returns {Object|null} - Best remote node or null if none available
   */
  findBestRemoteNode() {
    if (this.remoteNodes.size === 0) return null;
    
    // Convert map to array and sort by capacity (descending)
    const nodes = [...this.remoteNodes.values()].sort((a, b) => b.capacity - a.capacity);
    
    // Return node with highest capacity
    return nodes.length > 0 ? nodes[0] : null;
  }

  /**
   * Reduce workload when system is overloaded
   * @param {number} healthScore - Health score (0-100)
   */
  reduceWorkload(healthScore) {
    // Calculate new max job count
    const reduction = this.options.workloadReductionFactor * (1 - healthScore / 100);
    const newMaxJobCount = Math.max(1, Math.floor(this.maxJobCount * (1 - reduction)));
    
    if (newMaxJobCount < this.maxJobCount) {
      console.log(`Reducing max job count from ${this.maxJobCount} to ${newMaxJobCount} due to health score ${healthScore}`);
      this.maxJobCount = newMaxJobCount;
    }
  }

  /**
   * Job is about to start
   */
  jobStarting() {
    this.currentJobCount++;
  }

  /**
   * Job has completed
   */
  jobCompleted() {
    this.currentJobCount = Math.max(0, this.currentJobCount - 1);
    
    // Recalculate max job count periodically
    if (this.currentJobCount === 0) {
      this.maxJobCount = this.calculateMaxJobCount();
    }
  }

  /**
   * Get load balancer status
   * @returns {Object} - Status information
   */
  getStatus() {
    return {
      currentJobCount: this.currentJobCount,
      maxJobCount: this.maxJobCount,
      remoteNodesCount: this.remoteNodes.size,
      remoteNodes: [...this.remoteNodes.values()].map(node => ({
        nodeId: node.nodeId,
        capacity: node.capacity,
        health: node.health ? node.health.grade : null
      }))
    };
  }

  /**
   * Shutdown the load balancer
   */
  shutdown() {
    this.stopNodeHealthCheck();
    console.log('Load balancer shut down');
  }
}

module.exports = LoadBalancer;
```


### 16. Job Queue

```javascript
/**
 * @fileoverview Job queue for worker management
 * @module plugin/worker/JobQueue
 */

/**
 * Class for managing job queues with priority
 */
class JobQueue {
  /**
   * Create a new JobQueue instance
   * @param {Object} options - Configuration options
   * @param {number} options.maxQueueSize - Maximum size of the queue
   * @param {boolean} options.priorityEnabled - Whether to enable priority-based queuing
   */
  constructor(options = {}) {
    this.options = {
      maxQueueSize: options.maxQueueSize || 1000,
      priorityEnabled: options.priorityEnabled !== false,
      ...options
    };
    
    // Main queue
    this.queue = [];
    
    // Statistics
    this.stats = {
      enqueued: 0,
      dequeued: 0,
      dropped: 0,
      completed: 0,
      failed: 0
    };
  }

  /**
   * Enqueue a job
   * @param {Object} job - Job to enqueue
   * @returns {boolean} - True if job was enqueued successfully
   */
  enqueue(job) {
    // Check if queue is full
    if (this.queue.length >= this.options.maxQueueSize) {
      console.warn(`Job queue is full (${this.queue.length} jobs), dropping new job`);
      this.stats.dropped++;
      return false;
    }
    
    // Add job to queue
    this.queue.push(job);
    this.stats.enqueued++;
    
    // Sort queue by priority if enabled
    if (this.options.priorityEnabled) {
      this.sortQueue();
    }
    
    return true;
  }

  /**
   * Dequeue a job
   * @returns {Object|null} - Next job or null if queue is empty
   */
  dequeue() {
    if (this.queue.length === 0) {
      return null;
    }
    
    const job = this.queue.shift();
    this.stats.dequeued++;
    
    return job;
  }

  /**
   * Peek at the next job without removing it
   * @returns {Object|null} - Next job or null if queue is empty
   */
  peek() {
    return this.queue.length > 0 ? this.queue[0] : null;
  }

  /**
   * Sort the queue by priority (descending)
   * @private
   */
  sortQueue() {
    this.queue.sort((a, b) => {
      // Higher priority value means higher priority
      return (b.priority || 0) - (a.priority || 0);
    });
  }

  /**
   * Get the number of jobs in the queue
   * @returns {number} - Queue size
   */
  size() {
    return this.queue.length;
  }

  /**
   * Clear the queue
   */
  clear() {
    const count = this.queue.length;
    this.queue = [];
    this.stats.dropped += count;
    console.log(`Cleared job queue, dropped ${count} jobs`);
  }

  /**
   * Record job completion
   * @param {boolean} success - Whether job completed successfully
   */
  recordCompletion(success) {
    if (success) {
      this.stats.completed++;
    } else {
      this.stats.failed++;
    }
  }

  /**
   * Get queue statistics
   * @returns {Object} - Queue statistics
   */
  getStats() {
    return {
      ...this.stats,
      queueSize: this.queue.length,
      maxQueueSize: this.options.maxQueueSize
    };
  }

  /**
   * Reset queue statistics
   */
  resetStats() {
    this.stats = {
      enqueued: 0,
      dequeued: 0,
      dropped: 0,
      completed: 0,
      failed: 0
    };
  }
}

module.exports = JobQueue;
```


### 17. Security Manager

```javascript
/**
 * @fileoverview Security management for plugin system
 * @module plugin/core/SecurityManager
 */

const crypto = require('crypto');
const { Meteor } = require('meteor/meteor');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const fs = require('fs').promises;
const path = require('path');

/**
 * Class for managing security aspects of the plugin system
 */
class SecurityManager {
  /**
   * Create a new SecurityManager instance
   * @param {Object} options - Configuration options
   * @param {boolean} options.useJWT - Whether to use JWT for authentication
   * @param {boolean} options.useRSA - Whether to use RSA for encryption
   * @param {boolean} options.useEC2 - Whether to use EC2 credentials
   * @param {string} options.keysDirectory - Directory to store keys
   * @param {Object} options.db - MongoDB database connection
   */
  constructor(options = {}) {
    this.options = {
      useJWT: options.useJWT !== false,
      useRSA: options.useRSA !== false,
      useEC2: options.useEC2 || false,
      keysDirectory: options.keysDirectory || '/private/plugin/keys',
      jwtSecret: options.jwtSecret || process.env.JWT_SECRET,
      jwtExpiration: options.jwtExpiration || '1d', // 1 day
      ...options
    };
    
    this.db = options.db;
    this.securityCollection = this.db ? this.db.collection('security') : null;
    
    this.rsaKeys = null;
    this.jwtSecret = this.options.jwtSecret;
    
    // Initialize security
    this.initialize();
  }

  /**
   * Initialize security
   * @returns {Promise<void>}
   * @private
   */
  async initialize() {
    try {
      // Ensure JWT secret
      if (!this.jwtSecret) {
        this.jwtSecret = await this.getOrCreateJwtSecret();
      }
      
      // Initialize RSA keys if enabled
      if (this.options.useRSA) {
        await this.initializeRsaKeys();
      }
      
      console.log('Security manager initialized');
    } catch (error) {
      console.error('Error initializing security manager:', error);
    }
  }

  /**
   * Get or create JWT secret
   * @returns {Promise<string>} - JWT secret
   * @private
   */
  async getOrCreateJwtSecret() {
    try {
      // Try to get from MongoDB
      if (this.securityCollection) {
        const securityDoc = await this.securityCollection.findOne({ type: 'jwt_secret' });
        if (securityDoc && securityDoc.secret) {
          return securityDoc.secret;
        }
      }
      
      // Generate new secret
      const secret = crypto.randomBytes(32).toString('hex');
      
      // Store in MongoDB
      if (this.securityCollection) {
        await this.securityCollection.updateOne(
          { type: 'jwt_secret' },
          { $set: { secret, createdAt: new Date() } },
          { upsert: true }
        );
      }
      
      return secret;
    } catch (error) {
      console.error('Error getting/creating JWT secret:', error);
      // Fallback to random secret (will change on restart)
      return crypto.randomBytes(32).toString('hex');
    }
  }

  /**
   * Initialize RSA keys
   * @returns {Promise<void>}
   * @private
   */
  async initializeRsaKeys() {
    try {
      // Try to get from MongoDB
      if (this.securityCollection) {
        const keysDoc = await this.securityCollection.findOne({ type: 'rsa_keys' });
        if (keysDoc && keysDoc.publicKey && keysDoc.privateKey) {
          this.rsaKeys = {
            publicKey: keysDoc.publicKey,
            privateKey: keysDoc.privateKey
          };
          return;
        }
      }
      
      // Try to load from file system
      try {
        const publicKey = await fs.readFile(path.join(this.options.keysDirectory, 'public.pem'), 'utf8');
        const privateKey = await fs.readFile(path.join(this.options.keysDirectory, 'private.pem'), 'utf8');
        
        this.rsaKeys = { publicKey, privateKey };
        
        // Store in MongoDB
        if (this.securityCollection) {
          await this.securityCollection.updateOne(
            { type: 'rsa_keys' },
            { $set: { publicKey, privateKey, createdAt: new Date() } },
            { upsert: true }
          );
        }
        
        return;
      } catch (error) {
        console.log('RSA keys not found in file system, generating new keys');
      }
      
      // Generate new keys
      const { publicKey, privateKey } = await this.generateRsaKeyPair();
      this.rsaKeys = { publicKey, privateKey };
      
      // Save to file system
      try {
        await fs.mkdir(this.options.keysDirectory, { recursive: true });
        await fs.writeFile(path.join(this.options.keysDirectory, 'public.pem'), publicKey);
        await fs.writeFile(path.join(this.options.keysDirectory, 'private.pem'), privateKey);
      } catch (error) {
        console.warn('Failed to write RSA keys to file system:', error.message);
      }
      
      // Store in MongoDB
      if (this.securityCollection) {
        await this.securityCollection.updateOne(
          { type: 'rsa_keys' },
          { $set: { publicKey, privateKey, createdAt: new Date() } },
          { upsert: true }
        );
      }
    } catch (error) {
      console.error('Error initializing RSA keys:', error);
      throw error;
    }
  }

  /**
   * Generate RSA key pair
   * @returns {Promise<Object>} - RSA key pair
   * @private
   */
  generateRsaKeyPair() {
    return new Promise((resolve, reject) => {
      crypto.generateKeyPair('rsa', {
        modulusLength: 2048,
        publicKeyEncoding: {
          type: 'spki',
          format: 'pem'
        },
        privateKeyEncoding: {
          type: 'pkcs8',
          format: 'pem'
        }
      }, (err, publicKey, privateKey) => {
        if (err) {
          reject(err);
        } else {
          resolve({ publicKey, privateKey });
        }
      });
    });
  }

  /**
   * Generate an authentication token
   * @param {Object} payload - Token payload
   * @param {string} expiresIn - Token expiration
   * @returns {Promise<string>} - Generated token
   */
  async generateAuthToken(payload = {}, expiresIn = null) {
    if (!this.options.useJWT) {
      throw new Error('JWT authentication is disabled');
    }
    
    try {
      const tokenPayload = {
        ...payload,
        iat: Math.floor(Date.now() / 1000),
        sub: payload.userId || 'system'
      };
      
      return jwt.sign(
        tokenPayload, 
        this.jwtSecret, 
        { expiresIn: expiresIn || this.options.jwtExpiration }
      );
    } catch (error) {
      console.error('Error generating auth token:', error);
      throw error;
    }
  }

  /**
   * Verify an authentication token
   * @param {string} token - Token to verify
   * @returns {Promise<Object>} - Decoded token payload
   */
  async verifyAuthToken(token) {
    if (!this.options.useJWT) {
      throw new Error('JWT authentication is disabled');
    }
    
    try {
      return jwt.verify(token, this.jwtSecret);
    } catch (error) {
      console.error('Error verifying auth token:', error);
      throw new Error('Invalid authentication token');
    }
  }

  /**
   * Encrypt data using RSA
   * @param {string|Buffer} data - Data to encrypt
   * @returns {string} - Encrypted data (base64)
   */
  encryptRsa(data) {
    if (!this.options.useRSA || !this.rsaKeys) {
      throw new Error('RSA encryption is disabled or keys not initialized');
    }
    
    try {
      const buffer = Buffer.isBuffer(data) ? data : Buffer.from(data);
      const encrypted = crypto.publicEncrypt(
        {
          key: this.rsaKeys.publicKey,
          padding: crypto.constants.RSA_PKCS1_OAEP_PADDING
        },
        buffer
      );
      
      return encrypted.toString('base64');
    } catch (error) {
      console.error('Error encrypting data with RSA:', error);
      throw error;
    }
  }

  /**
   * Decrypt data using RSA
   * @param {string} encryptedData - Encrypted data (base64)
   * @returns {Buffer} - Decrypted data
   */
  decryptRsa(encryptedData) {
    if (!this.options.useRSA || !this.rsaKeys) {
      throw new Error('RSA encryption is disabled or keys not initialized');
    }
    
    try {
      const buffer = Buffer.from(encryptedData, 'base64');
      const decrypted = crypto.privateDecrypt(
        {
          key: this.rsaKeys.privateKey,
          padding: crypto.constants.RSA_PKCS1_OAEP_PADDING
        },
        buffer
      );
      
      return decrypted;
    } catch (error) {
      console.error('Error decrypting data with RSA:', error);
      throw error;
    }
  }

  /**
   * Hash a password
   * @param {string} password - Password to hash
   * @returns {Promise<string>} - Hashed password
   */
  async hashPassword(password) {
    try {
      const salt = await bcrypt.genSalt(10);
      return bcrypt.hash(password, salt);
    } catch (error) {
      console.error('Error hashing password:', error);
      throw error;
    }
  }

  /**
   * Compare a password with a hash
   * @param {string} password - Password to check
   * @param {string} hash - Hash to compare against
   * @returns {Promise<boolean>} - True if password matches hash
   */
  async comparePassword(password, hash) {
    try {
      return bcrypt.compare(password, hash);
    } catch (error) {
      console.error('Error comparing password:', error);
      throw error;
    }
  }

  /**
   * Generate a random API key
   * @returns {string} - Generated API key
   */
  generateApiKey() {
    return crypto.randomBytes(32).toString('hex');
  }

  /**
   * Validate request authentication
   * @param {Object} req - Express request object
   * @returns {Promise<Object>} - Authentication data
   */
  async validateRequest(req) {
    // Check for JWT token
    if (this.options.useJWT) {
      const authHeader = req.headers.authorization;
      if (authHeader && authHeader.startsWith('Bearer ')) {
        const token = authHeader.substring(7);
        try {
          const decoded = await this.verifyAuthToken(token);
          return {
            authenticated: true,
            type: 'jwt',
            user: decoded.sub,
            payload: decoded
          };
        } catch (error) {
          // Continue to other auth methods
        }
      }
    }
    
    // Check for API key
    const apiKey = req.headers['x-api-key'];
    if (apiKey && this.securityCollection) {
      const apiKeyDoc = await this.securityCollection.findOne({ 
        type: 'api_key', 
        key: apiKey,
        active: true
      });
      
      if (apiKeyDoc) {
        return {
          authenticated: true,
          type: 'api_key',
          user: apiKeyDoc.user,
          payload: apiKeyDoc
        };
      }
    }
    
    // No valid authentication
    return {
      authenticated: false
    };
  }

  /**
   * Register Meteor methods
   */
  registerMeteorMethods() {
    Meteor.methods({
      'security.generateToken': async (payload, expiresIn) => {
        // Ensure user is authenticated
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        return this.generateAuthToken({
          ...payload,
          userId: Meteor.userId()
        }, expiresIn);
      },
      
      'security.generateApiKey': async (description) => {
        // Ensure user is authenticated
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        const apiKey = this.generateApiKey();
        
        if (this.securityCollection) {
          await this.securityCollection.insertOne({
            type: 'api_key',
            key: apiKey,
            user: Meteor.userId(),
            description: description || 'API Key',
            createdAt: new Date(),
            active: true
          });
        }
        
        return apiKey;
      },
      
      'security.getPublicKey': () => {
        if (!this.options.useRSA || !this.rsaKeys) {
          throw new Meteor.Error('rsa-disabled', 'RSA encryption is disabled');
        }
        
        return this.rsaKeys.publicKey;
      }
    });
  }
}

module.exports = SecurityManager;
```


### 18. Plugin Ledger

```javascript
/**
 * @fileoverview Distributed ledger for plugin usage tracking
 * @module plugin/core/PluginLedger
 */

const { Meteor } = require('meteor/meteor');
const { v4: uuidv4 } = require('uuid');
const crypto = require('crypto');

/**
 * Class for managing the distributed ledger of plugin usage
 */
class PluginLedger {
  /**
   * Create a new PluginLedger instance
   * @param {Object} options - Configuration options
   * @param {Object} options.db - MongoDB database connection
   */
  constructor(options = {}) {
    this.options = options;
    this.db = options.db;
    this.ledgerCollection = this.db ? this.db.collection('ledger') : null;
    this.usageCollection = this.db ? this.db.collection('usage') : null;
    this.ratingCollection = this.db ? this.db.collection('ratings') : null;
  }

  /**
   * Record plugin usage
   * @param {string} pluginName - Plugin name
   * @param {string} method - Method name
   * @param {Object} result - Usage result
   * @returns {Promise<Object>} - Created ledger entry
   */
  async recordUsage(pluginName, method, result) {
    try {
      if (!this.ledgerCollection || !this.usageCollection) {
        console.warn('MongoDB not available, skipping usage recording');
        return null;
      }
      
      const entry = {
        id: uuidv4(),
        pluginName,
        method,
        success: result.success,
        error: result.error,
        executionTime: result.executionTime,
        timestamp: new Date(),
        userId: Meteor.userId() || null,
        nodeId: this.options.nodeId || null
      };
      
      // Calculate hash of entry
      const hash = this.calculateEntryHash(entry);
      entry.hash = hash;
      
      // Store in ledger
      await this.ledgerCollection.insertOne(entry);
      
      // Update usage stats
      await this.updateUsageStats(pluginName, method, result);
      
      return entry;
    } catch (error) {
      console.error(`Error recording usage for ${pluginName}.${method}:`, error);
      return null;
    }
  }

  /**
   * Record remote plugin usage
   * @param {string} pluginName - Plugin name
   * @param {string} method - Method name
   * @param {string} nodeId - Remote node ID
   * @param {Object} result - Usage result
   * @returns {Promise<Object>} - Created ledger entry
   */
  async recordRemoteUsage(pluginName, method, nodeId, result) {
    try {
      if (!this.ledgerCollection || !this.usageCollection) {
        console.warn('MongoDB not available, skipping remote usage recording');
        return null;
      }
      
      const entry = {
        id: uuidv4(),
        pluginName,
        method,
        success: result.success,
        error: result.error,
        executionTime: result.executionTime,
        timestamp: new Date(),
        userId: Meteor.userId() || null,
        nodeId: this.options.nodeId || null,
        remoteNodeId: nodeId,
        isRemote: true
      };
      
      // Calculate hash of entry
      const hash = this.calculateEntryHash(entry);
      entry.hash = hash;
      
      // Store in ledger
      await this.ledgerCollection.insertOne(entry);
      
      // Update usage stats
      await this.updateUsageStats(pluginName, method, result);
      
      return entry;
    } catch (error) {
      console.error(`Error recording remote usage for ${pluginName}.${method}:`, error);
      return null;
    }
  }

  /**
   * Calculate hash of ledger entry
   * @param {Object} entry - Ledger entry
   * @returns {string} - SHA-256 hash
   * @private
   */
  calculateEntryHash(entry) {
    // Create a copy without the hash field
    const entryWithoutHash = { ...entry };
    delete entryWithoutHash.hash;
    
    // Convert to string and hash
    const entryString = JSON.stringify(entryWithoutHash);
    return crypto.createHash('sha256').update(entryString).digest('hex');
  }

  /**
   * Update usage statistics
   * @param {string} pluginName - Plugin name
   * @param {string} method - Method name
   * @param {Object} result - Usage result
   * @returns {Promise<void>}
   * @private
   */
  async updateUsageStats(pluginName, method, result) {
    try {
      const updateData = {
        $inc: {
          totalCalls: 1,
          successfulCalls: result.success ? 1 : 0,
          failedCalls: result.success ? 0 : 1,
          totalExecutionTime: result.executionTime || 0
        },
        $set: {
          lastUsed: new Date()
        }
      };
      
      // Update plugin usage stats
      await this.usageCollection.updateOne(
        { pluginName, method },
        updateData,
        { upsert: true }
      );
      
      // Update overall plugin usage stats
      await this.usageCollection.updateOne(
        { pluginName, method: null },
        updateData,
        { upsert: true }
      );
    } catch (error) {
      console.error(`Error updating usage stats for ${pluginName}.${method}:`, error);
    }
  }

  /**
   * Get usage statistics for a plugin
   * @param {string} pluginName - Plugin name
   * @param {string} method - Method name (optional)
   * @returns {Promise<Object>} - Usage statistics
   */
  async getUsageStats(pluginName, method = null) {
    try {
      if (!this.usageCollection) {
        throw new Error('MongoDB not available');
      }
      
      const query = { pluginName };
      if (method) {
        query.method = method;
      } else {
        query.method = null;
      }
      
      const stats = await this.usageCollection.findOne(query);
      if (!stats) {
        return {
          totalCalls: 0,
          successfulCalls: 0,
          failedCalls: 0,
          totalExecutionTime: 0,
          averageExecutionTime: 0
        };
      }
      
      // Calculate average execution time
      const averageExecutionTime = stats.totalCalls > 0 
        ? stats.totalExecutionTime / stats.totalCalls
        : 0;
      
      return {
        ...stats,
        averageExecutionTime
      };
    } catch (error) {
      console.error(`Error getting usage stats for ${pluginName}:`, error);
      throw error;
    }
  }

  /**
   * Submit rating for a plugin
   * @param {string} pluginName - Plugin name
   * @param {number} rating - Rating (1-5)
   * @param {string} comment - Comment (optional)
   * @returns {Promise<Object>} - Created rating entry
   */
  async submitRating(pluginName, rating, comment = null) {
    try {
      if (!this.ratingCollection) {
        throw new Error('MongoDB not available');
      }
      
      // Validate rating
      rating = Math.min(5, Math.max(1, rating));
      
      const ratingEntry = {
        id: uuidv4(),
        pluginName,
        rating,
        comment,
        userId: Meteor.userId() || null,
        timestamp: new Date()
      };
      
      // Store rating
      await this.ratingCollection.insertOne(ratingEntry);
      
      // Update average rating
      await this.updateAverageRating(pluginName);
      
      return ratingEntry;
    } catch (error) {
      console.error(`Error submitting rating for ${pluginName}:`, error);
      throw error;
    }
  }

  /**
   * Update average rating for a plugin
   * @param {string} pluginName - Plugin name
   * @returns {Promise<number>} - New average rating
   * @private
   */
  async updateAverageRating(pluginName) {
    try {
      if (!this.ratingCollection) {
        throw new Error('MongoDB not available');
      }
      
      // Calculate average rating
      const result = await this.ratingCollection.aggregate([
        { $match: { pluginName } },
        { $group: {
          _id: null,
          averageRating: { $avg: '$rating' },
          count: { $sum: 1 }
        } }
      ]).toArray();
      
      const averageRating = result.length > 0 ? result[0].averageRating : 0;
      const count = result.length > 0 ? result[0].count : 0;
      
      // Store average rating in plugin collection
      if (this.options.db) {
        const pluginsCollection = this.options.db.collection('plugins');
        await pluginsCollection.updateOne(
          { name: pluginName },
          { $set: { 
            averageRating,
            ratingCount: count,
            updatedAt: new Date()
          } }
        );
      }
      
      return averageRating;
    } catch (error) {
      console.error(`Error updating average rating for ${pluginName}:`, error);
      throw error;
    }
  }

  /**
   * Get ratings for a plugin
   * @param {string} pluginName - Plugin name
   * @returns {Promise<Object>} - Ratings information
   */
  async getRatings(pluginName) {
    try {
      if (!this.ratingCollection) {
        throw new Error('MongoDB not available');
      }
      
      // Get average rating
      const result = await this.ratingCollection.aggregate([
        { $match: { pluginName } },
        { $group: {
          _id: null,
          averageRating: { $avg: '$rating' },
          count: { $sum: 1 }
        } }
      ]).toArray();
      
      const averageRating = result.length > 0 ? result[0].averageRating : 0;
      const count = result.length > 0 ? result[0].count : 0;
      
      // Get recent ratings
      const recentRatings = await this.ratingCollection.find(
        { pluginName },
        { 
          sort: { timestamp: -1 },
          limit: 10,
          projection: { _id: 0, pluginName: 0 }
        }
      ).toArray();
      
      // Get rating distribution
      const distribution = await this.ratingCollection.aggregate([
        { $match: { pluginName } },
        { $group: {
          _id: '$rating',
          count: { $sum: 1 }
        } },
        { $sort: { _id: -1 } }
      ]).toArray();
      
      const ratingDistribution = {
        '5': 0, '4': 0, '3': 0, '2': 0, '1': 0
      };
      
      distribution.forEach(item => {
        ratingDistribution[item._id.toString()] = item.count;
      });
      
      return {
        averageRating,
        count,
        recentRatings,
        distribution: ratingDistribution
      };
    } catch (error) {
      console.error(`Error getting ratings for ${pluginName}:`, error);
      throw error;
    }
  }

  /**
   * Get ledger entries for a plugin
   * @param {string} pluginName - Plugin name
   * @param {Object} options - Query options
   * @param {number} options.limit - Maximum number of entries to return
   * @param {number} options.skip - Number of entries to skip
   * @param {boolean} options.includeRemote - Whether to include remote usage
   * @returns {Promise<Array<Object>>} - Ledger entries
   */
  async getLedgerEntries(pluginName, options = {}) {
    try {
      if (!this.ledgerCollection) {
        throw new Error('MongoDB not available');
      }
      
      const query = { pluginName };
      if (!options.includeRemote) {
        query.isRemote = { $ne: true };
      }
      
      const entries = await this.ledgerCollection.find(
        query,
        {
          sort: { timestamp: -1 },
          limit: options.limit || 100,
          skip: options.skip || 0,
          projection: { _id: 0 }
        }
      ).toArray();
      
      return entries;
    } catch (error) {
      console.error(`Error getting ledger entries for ${pluginName}:`, error);
      throw error;
    }
  }

  /**
   * Verify ledger integrity
   * @param {string} pluginName - Plugin name (optional)
   * @returns {Promise<Object>} - Verification result
   */
  async verifyLedgerIntegrity(pluginName = null) {
    try {
      if (!this.ledgerCollection) {
        throw new Error('MongoDB not available');
      }
      
      const query = pluginName ? { pluginName } : {};
      
      const entries = await this.ledgerCollection.find(
        query,
        { sort: { timestamp: 1 } }
      ).toArray();
      
      let valid = true;
      const invalidEntries = [];
      
      for (const entry of entries) {
        // Calculate hash of entry
        const calculatedHash = this.calculateEntryHash(entry);
        
        // Compare with stored hash
        if (calculatedHash !== entry.hash) {
          valid = false;
          invalidEntries.push({
            id: entry.id,
            pluginName: entry.pluginName,
            method: entry.method,
            timestamp: entry.timestamp
          });
        }
      }
      
      return {
        valid,
        totalEntries: entries.length,
        invalidEntries
      };
    } catch (error) {
      console.error('Error verifying ledger integrity:', error);
      throw error;
    }
  }

  /**
   * Register Meteor methods
   */
  registerMeteorMethods() {
    Meteor.methods({
      'ledger.getUsageStats': async (pluginName, method) => {
        return this.getUsageStats(pluginName, method);
      },
      
      'ledger.submitRating': async (pluginName, rating, comment) => {
        // Ensure user is logged in
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'You must be logged in to submit a rating');
        }
        
        return this.submitRating(pluginName, rating, comment);
      },
      
      'ledger.getRatings': async (pluginName) => {
        return this.getRatings(pluginName);
      },
      
      'ledger.getLedgerEntries': async (pluginName, options) => {
        return this.getLedgerEntries(pluginName, options);
      },
      
      'ledger.verifyLedgerIntegrity': async (pluginName) => {
        // This is an admin-only method
        if (!Meteor.userId() || !Meteor.user().isAdmin) {
          throw new Meteor.Error('not-authorized', 'You must be an admin to verify ledger integrity');
        }
        
        return this.verifyLedgerIntegrity(pluginName);
      }
    });
  }
}

module.exports = PluginLedger;
```


### 19. MongoDB Utilities

```javascript
/**
 * @fileoverview MongoDB utilities for plugin system
 * @module plugin/utils/MongoUtils
 */

const { MongoClient } = require('mongodb');
const zod = require('zod');

/**
 * Utility class for MongoDB operations
 */
class MongoUtils {
  /**
   * Create a new MongoUtils instance
   * @param {Object} options - Configuration options
   * @param {string} options.mongoUrl - MongoDB connection URL
   * @param {string} options.dbName - Database name
   */
  constructor(options = {}) {
    this.options = {
      mongoUrl: options.mongoUrl || process.env.MONGO_URL || 'mongodb://localhost:27017',
      dbName: options.dbName || 'plugins',
      ...options
    };
    
    this.client = null;
    this.db = null;
    this.collections = new Map();
  }

  /**
   * Connect to MongoDB
   * @returns {Promise<Object>} - MongoDB database connection
   */
  async connect() {
    if (this.db) return this.db;
    
    try {
      this.client = new MongoClient(this.options.mongoUrl);
      await this.client.connect();
      this.db = this.client.db(this.options.dbName);
      
      console.log(`Connected to MongoDB: ${this.options.mongoUrl}`);
      return this.db;
    } catch (error) {
      console.error('Error connecting to MongoDB:', error);
      throw error;
    }
  }

  /**
   * Get a collection with schema validation
   * @param {string} collectionName - Collection name
   * @param {Object} schema - Zod schema for validation
   * @returns {Promise<Object>} - MongoDB collection
   */
  async getCollection(collectionName, schema = null) {
    if (this.collections.has(collectionName)) {
      return this.collections.get(collectionName);
    }
    
    if (!this.db) {
      await this.connect();
    }
    
    const collection = this.db.collection(collectionName);
    
    if (schema) {
      const validatedCollection = this.createValidatedCollection(collection, schema);
      this.collections.set(collectionName, validatedCollection);
      return validatedCollection;
    }
    
    this.collections.set(collectionName, collection);
    return collection;
  }

  /**
   * Create a collection with schema validation
   * @param {Object} collection - MongoDB collection
   * @param {Object} schema - Zod schema for validation
   * @returns {Object} - Validated collection
   * @private
   */
  createValidatedCollection(collection, schema) {
    // Create proxy to intercept operations and validate data
    return new Proxy(collection, {
      get: (target, prop) => {
        // Intercept insert operations
        if (prop === 'insertOne') {
          return async (doc, options) => {
            const validatedDoc = schema.parse(doc);
            return target.insertOne(validatedDoc, options);
          };
        }
        
        if (prop === 'insertMany') {
          return async (docs, options) => {
            const validatedDocs = docs.map(doc => schema.parse(doc));
            return target.insertMany(validatedDocs, options);
          };
        }
        
        // Intercept update operations
        if (prop === 'updateOne') {
          return async (filter, update, options) => {
            // Only validate if not using operators
            if (update.$set) {
              update.$set = schema.partial().parse(update.$set);
            }
            return target.updateOne(filter, update, options);
          };
        }
        
        if (prop === 'updateMany') {
          return async (filter, update, options) => {
            // Only validate if not using operators
            if (update.$set) {
              update.$set = schema.partial().parse(update.$set);
            }
            return target.updateMany(filter, update, options);
          };
        }
        
        // Return original method for other operations
        return target[prop];
      }
    });
  }

  /**
   * Store a file in MongoDB
   * @param {string} collectionName - Collection name
   * @param {string} filename - File name
   * @param {Buffer|string} data - File data
   * @param {string} contentType - Content type
   * @returns {Promise<Object>} - Stored file information
   */
  async storeFile(collectionName, filename, data, contentType) {
    try {
      if (!this.db) {
        await this.connect();
      }
      
      const collection = await this.getCollection(collectionName);
      
      const fileData = Buffer.isBuffer(data) ? data : Buffer.from(data);
      const base64Data = fileData.toString('base64');
      
      const fileDoc = {
        filename,
        contentType,
        data: base64Data,
        size: fileData.length,
        uploadedAt: new Date()
      };
      
      const result = await collection.insertOne(fileDoc);
      
      return {
        id: result.insertedId,
        filename,
        contentType,
        size: fileData.length
      };
    } catch (error) {
      console.error(`Error storing file ${filename}:`, error);
      throw error;
    }
  }

  /**
   * Retrieve a file from MongoDB
   * @param {string} collectionName - Collection name
   * @param {string} fileId - File ID
   * @returns {Promise<Object>} - Retrieved file
   */
  async retrieveFile(collectionName, fileId) {
    try {
      if (!this.db) {
        await this.connect();
      }
      
      const collection = await this.getCollection(collectionName);
      
      const fileDoc = await collection.findOne({ _id: fileId });
      if (!fileDoc) {
        throw new Error(`File ${fileId} not found`);
      }
      
      return {
        id: fileDoc._id,
        filename: fileDoc.filename,
        contentType: fileDoc.contentType,
        data: Buffer.from(fileDoc.data, 'base64'),
        size: fileDoc.size,
        uploadedAt: fileDoc.uploadedAt
      };
    } catch (error) {
      console.error(`Error retrieving file ${fileId}:`, error);
      throw error;
    }
  }

  /**
   * Search for documents in a collection
   * @param {string} collectionName - Collection name
   * @param {Object} query - Search query
   * @param {Object} options - Search options
   * @returns {Promise<Array<Object>>} - Search results
   */
  async search(collectionName, query, options = {}) {
    try {
      if (!this.db) {
        await this.connect();
      }
      
      const collection = await this.getCollection(collectionName);
      
      const searchOptions = {
        limit: options.limit || 100,
        skip: options.skip || 0,
        sort: options.sort || { _id: -1 },
        projection: options.projection || {}
      };
      
      const results = await collection.find(query, searchOptions).toArray();
      return results;
    } catch (error) {
      console.error(`Error searching in ${collectionName}:`, error);
      throw error;
    }
  }

  /**
   * Create indexes on a collection
   * @param {string} collectionName - Collection name
   * @param {Array<Object>} indexes - Indexes to create
   * @returns {Promise<void>}
   */
  async createIndexes(collectionName, indexes) {
    try {
      if (!this.db) {
        await this.connect();
      }
      
      const collection = await this.getCollection(collectionName);
      
      for (const index of indexes) {
        await collection.createIndex(index.fields, index.options || {});
      }
      
      console.log(`Created ${indexes.length} indexes on ${collectionName}`);
    } catch (error) {
      console.error(`Error creating indexes on ${collectionName}:`, error);
      throw error;
    }
  }

  /**
   * Close MongoDB connection
   * @returns {Promise<void>}
   */
  async close() {
    if (this.client) {
      await this.client.close();
      this.client = null;
      this.db = null;
      this.collections.clear();
      console.log('Closed MongoDB connection');
    }
  }
}

module.exports = MongoUtils;
```


### 20. OCI Container Manager

```javascript
/**
 * @fileoverview OCI Container Manager for plugin system
 * Provides support for Open Container Initiative (OCI) containers
 * @module plugin/protocols/OCIManager
 */

const { Meteor } = require('meteor/meteor');
const { exec, spawn } = require('child_process');
const util = require('util');
const execAsync = util.promisify(exec);
const fs = require('fs').promises;
const path = require('path');
const yaml = require('js-yaml');

/**
 * Class for managing OCI containers (Docker, Podman)
 */
class OCIManager {
  /**
   * Create a new OCIManager instance
   * @param {Object} options - Configuration options
   * @param {string} options.containerEngine - Container engine to use ('docker', 'podman')
   * @param {string} options.composeVersion - Docker Compose version to use ('v1', 'v2')
   * @param {boolean} options.enablePrivileged - Whether to allow privileged containers
   * @param {string} options.networkName - Default container network
   * @param {Object} options.defaultResources - Default resource limits
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
      ...options
    };
    
    this.initialized = false;
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
      console.log(`Using container engine: ${this.options.containerEngine} ${engineVersion}`);
      
      // Create default network if it doesn't exist
      await this.createNetwork(this.options.networkName);
      
      this.initialized = true;
    } catch (error) {
      console.error('Failed to initialize OCI Manager:', error);
      throw error;
    }
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
      console.error(`Error getting ${this.options.containerEngine} version:`, error);
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
        console.log(`Network ${networkName} already exists`);
        return;
      }
      
      // Create network
      await execAsync(`${this.options.containerEngine} network create ${networkName}`);
      console.log(`Created container network: ${networkName}`);
    } catch (error) {
      console.error(`Error creating network ${networkName}:`, error);
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
      console.log(`Pulling image: ${image}`);
      
      // Pull with progress output
      const pull = spawn(this.options.containerEngine, ['pull', image], { 
        stdio: ['ignore', 'pipe', 'pipe'] 
      });
      
      pull.stdout.on('data', (data) => {
        console.log(`Pull progress: ${data.toString().trim()}`);
      });
      
      pull.stderr.on('data', (data) => {
        console.error(`Pull error: ${data.toString().trim()}`);
      });
      
      return new Promise((resolve, reject) => {
        pull.on('close', (code) => {
          if (code === 0) {
            console.log(`Successfully pulled image: ${image}`);
            resolve();
          } else {
            reject(new Error(`Failed to pull image: ${image}, exit code: ${code}`));
          }
        });
      });
    } catch (error) {
      console.error(`Error pulling image ${image}:`, error);
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
        detach = true
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
      console.log(`Running container: ${cmd.join(' ')}`);
      
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
          console.log(`Container output: ${text.trim()}`);
        });
        
        container.stderr.on('data', (data) => {
          const text = data.toString();
          output += text;
          console.error(`Container error: ${text.trim()}`);
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
      console.error('Error running container:', error);
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
        ip: info.NetworkSettings.Networks[this.options.networkName]?.IPAddress
      };
    } catch (error) {
      console.error(`Error getting container info for ${containerIdOrName}:`, error);
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
      console.log(`Stopped container: ${containerIdOrName}`);
    } catch (error) {
      console.error(`Error stopping container ${containerIdOrName}:`, error);
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
      console.log(`Removed container: ${containerIdOrName}`);
    } catch (error) {
      console.error(`Error removing container ${containerIdOrName}:`, error);
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
          console.log(`Container logs: ${text.trim()}`);
        });
        
        logs.stderr.on('data', (data) => {
          const text = data.toString();
          output += text;
          console.error(`Container error logs: ${text.trim()}`);
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
      console.error(`Error getting logs for container ${containerIdOrName}:`, error);
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
      console.log(`Running compose stack: ${projectName} from ${composePath}`);
      
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
        output: stdout
      };
    } catch (error) {
      console.error('Error running compose stack:', error);
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
        services = this.parseComposePs(psOutput);
      }
      
      // Load compose file to get service definitions
      const composeContent = await fs.readFile(composePath, 'utf8');
      const composeConfig = yaml.load(composeContent);
      
      return {
        projectName,
        composePath,
        services,
        config: composeConfig
      };
    } catch (error) {
      console.error(`Error getting compose stack info for ${projectName}:`, error);
      throw error;
    }
  }

  /**
   * Parse docker-compose ps table output
   * @param {string} output - Command output
   * @returns {Array<Object>} - Parsed services
   * @private
   */
  parseComposePs(output) {
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
      console.log(`Stopped compose stack: ${projectName}`);
    } catch (error) {
      console.error(`Error stopping compose stack ${projectName}:`, error);
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
        exposedPort = 3000
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
      
      // Add default command
      dockerfileContent += 'CMD ["node", "index.js"]\n';
      
      // Write Dockerfile
      const dockerfilePath = path.join(targetDir, 'Dockerfile');
      await fs.writeFile(dockerfilePath, dockerfileContent);
      
      console.log(`Created Dockerfile at ${dockerfilePath}`);
      return dockerfilePath;
    } catch (error) {
      console.error('Error creating Dockerfile:', error);
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
      console.log(`Building image: ${cmd.join(' ')}`);
      
      const build = spawn(cmd[0], cmd.slice(1), { 
        stdio: ['ignore', 'pipe', 'pipe'] 
      });
      
      let output = '';
      build.stdout.on('data', (data) => {
        const text = data.toString();
        output += text;
        console.log(`Build output: ${text.trim()}`);
      });
      
      build.stderr.on('data', (data) => {
        const text = data.toString();
        output += text;
        console.error(`Build error: ${text.trim()}`);
      });
      
      return new Promise((resolve, reject) => {
        build.on('close', (code) => {
          if (code === 0) {
            console.log(`Successfully built image: ${imageName}`);
            resolve(imageName);
          } else {
            reject(new Error(`Failed to build image: ${imageName}, exit code: ${code}`));
          }
        });
      });
    } catch (error) {
      console.error('Error building image:', error);
      throw error;
    }
  }

  /**
   * Register Meteor methods
   */
  registerMeteorMethods() {
    Meteor.methods({
      'oci.runContainer': async (options) => {
        // Ensure user is authenticated
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        return this.runContainer(options);
      },
      
      'oci.stopContainer': async (containerIdOrName, timeout) => {
        // Ensure user is authenticated
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        return this.stopContainer(containerIdOrName, timeout);
      },
      
      'oci.getContainerLogs': async (containerIdOrName, options) => {
        // Ensure user is authenticated
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        return this.getContainerLogs(containerIdOrName, options);
      },
      
      'oci.runComposeStack': async (options) => {
        // Ensure user is authenticated
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        return this.runComposeStack(options);
      },
      
      'oci.stopComposeStack': async (projectName, composePath) => {
        // Ensure user is authenticated
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        return this.stopComposeStack(projectName, composePath);
      },
      
      'oci.buildImage': async (options) => {
        // Ensure user is authenticated
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        return this.buildImage(options);
      }
    });
  }
}

module.exports = OCIManager;
```


### 21. Model Context Protocol (MCP) Implementation

```javascript
/**
 * @fileoverview Model Context Protocol implementation
 * @module plugin/protocols/MCP
 */

const { Meteor } = require('meteor/meteor');
const { WebApp } = require('meteor/webapp');
const express = require('express');
const bodyParser = require('body-parser');
const zod = require('zod');
const { v4: uuidv4 } = require('uuid');
const WebSocket = require('ws');

/**
 * Message schema validation
 */
const messageSchema = zod.object({
  id: zod.string().optional(),
  type: zod.enum(['request', 'response', 'notification', 'error']),
  method: zod.string().optional(),
  params: zod.any().optional(),
  result: zod.any().optional(),
  error: zod.object({
    code: zod.number(),
    message: zod.string(),
    data: zod.any().optional()
  }).optional(),
  context: zod.object({
    modelId: zod.string().optional(),
    sessionId: zod.string().optional(),
    userId: zod.string().optional(),
    metadata: zod.record(zod.string(), zod.any()).optional()
  }).optional()
});

/**
 * Class for implementing the Model Context Protocol
 */
class MCPServer {
  /**
   * Create a new MCPServer instance
   * @param {Object} options - Configuration options
   * @param {Object} options.db - MongoDB database connection
   * @param {Object} options.pluginManager - Plugin manager instance
   * @param {Object} options.securityManager - Security manager instance
   */
  constructor(options = {}) {
    this.options = options;
    this.db = options.db;
    this.pluginManager = options.pluginManager;
    this.securityManager = options.securityManager;
    
    this.sessionsCollection = this.db ? this.db.collection('mcp_sessions') : null;
    this.messagesCollection = this.db ? this.db.collection('mcp_messages') : null;
    
    this.activeSessions = new Map();
    this.handlers = new Map();
    this.wss = null;
    this.router = null;
    
    // Register default handlers
    this.registerDefaultHandlers();
  }

  /**
   * Initialize the MCP server
   * @returns {Promise<void>}
   */
  async initialize() {
    try {
      console.log('Initializing MCP Server...');
      
      // Set up HTTP routes
      this.setupHttpRoutes();
      
      // Set up WebSocket server
      this.setupWebSocketServer();
      
      // Register Meteor methods
      this.registerMeteorMethods();
      
      console.log('MCP Server initialized successfully');
    } catch (error) {
      console.error('Error initializing MCP Server:', error);
      throw error;
    }
  }

  /**
   * Set up HTTP routes
   * @private
   */
  setupHttpRoutes() {
    // Create router
    this.router = express.Router();
    
    // Add middleware
    this.router.use(bodyParser.json());
    
    // Add routes
    this.router.post('/message', async (req, res) => {
      try {
        // Validate request
        const auth = await this.securityManager.validateRequest(req);
        if (!auth.authenticated) {
          return res.status(401).json({
            error: {
              code: 401,
              message: 'Unauthorized'
            }
          });
        }
        
        // Validate message
        let message;
        try {
          message = messageSchema.parse(req.body);
        } catch (error) {
          return res.status(400).json({
            error: {
              code: 400,
              message: 'Invalid message format',
              data: error.errors
            }
          });
        }
        
        // Add message ID if not provided
        if (!message.id) {
          message.id = uuidv4();
        }
        
        // Add user ID to context
        if (!message.context) {
          message.context = {};
        }
        message.context.userId = auth.user;
        
        // Process message
        const response = await this.processMessage(message);
        
        res.json(response);
      } catch (error) {
        console.error('Error processing HTTP message:', error);
        res.status(500).json({
          error: {
            code: 500,
            message: error.message
          }
        });
      }
    });
    
    this.router.post('/session', async (req, res) => {
      try {
        // Validate request
        const auth = await this.securityManager.validateRequest(req);
        if (!auth.authenticated) {
          return res.status(401).json({
            error: {
              code: 401,
              message: 'Unauthorized'
            }
          });
        }
        
        // Create session
        const { modelId, metadata } = req.body;
        const session = await this.createSession(modelId, auth.user, metadata);
        
        res.json(session);
      } catch (error) {
        console.error('Error creating session:', error);
        res.status(500).json({
          error: {
            code: 500,
            message: error.message
          }
        });
      }
    });
    
    this.router.get('/session/:sessionId', async (req, res) => {
      try {
        // Validate request
        const auth = await this.securityManager.validateRequest(req);
        if (!auth.authenticated) {
          return res.status(401).json({
            error: {
              code: 401,
              message: 'Unauthorized'
            }
          });
        }
        
        // Get session
        const sessionId = req.params.sessionId;
        const session = await this.getSession(sessionId);
        
        if (!session) {
          return res.status(404).json({
            error: {
              code: 404,
              message: 'Session not found'
            }
          });
        }
        
        // Check if user has access to session
        if (session.userId !== auth.user) {
          return res.status(403).json({
            error: {
              code: 403,
              message: 'Forbidden'
            }
          });
        }
        
        res.json(session);
      } catch (error) {
        console.error('Error getting session:', error);
        res.status(500).json({
          error: {
            code: 500,
            message: error.message
          }
        });
      }
    });
    
    this.router.delete('/session/:sessionId', async (req, res) => {
      try {
        // Validate request
        const auth = await this.securityManager.validateRequest(req);
        if (!auth.authenticated) {
          return res.status(401).json({
            error: {
              code: 401,
              message: 'Unauthorized'
            }
          });
        }
        
        // Get session
        const sessionId = req.params.sessionId;
        const session = await this.getSession(sessionId);
        
        if (!session) {
          return res.status(404).json({
            error: {
              code: 404,
              message: 'Session not found'
            }
          });
        }
        
        // Check if user has access to session
        if (session.userId !== auth.user) {
          return res.status(403).json({
            error: {
              code: 403,
              message: 'Forbidden'
            }
          });
        }
        
        // Close session
        await this.closeSession(sessionId);
        
        res.json({ success: true });
      } catch (error) {
        console.error('Error closing session:', error);
        res.status(500).json({
          error: {
            code: 500,
            message: error.message
          }
        });
      }
    });
    
    // Add router to WebApp
    WebApp.connectHandlers.use('/api/mcp', this.router);
    console.log('MCP HTTP routes initialized');
  }

  /**
   * Set up WebSocket server
   * @private
   */
  setupWebSocketServer() {
    // Create WebSocket server
    this.wss = new WebSocket.Server({ 
      noServer: true,
      path: '/api/mcp/ws'
    });
    
    // Handle connection
    this.wss.on('connection', (ws, req, session) => {
      console.log(`WebSocket connection established for session ${session.sessionId}`);
      
      // Store WebSocket in session
      session.ws = ws;
      
      // Handle messages
      ws.on('message', async (data) => {
        try {
          // Parse message
          const message = JSON.parse(data);
          
          // Validate message
          try {
            messageSchema.parse(message);
          } catch (error) {
            const errorResponse = {
              id: message.id || uuidv4(),
              type: 'error',
              error: {
                code: 400,
                message: 'Invalid message format',
                data: error.errors
              }
            };
            
            ws.send(JSON.stringify(errorResponse));
            return;
          }
          
          // Add session ID to context
          if (!message.context) {
            message.context = {};
          }
          message.context.sessionId = session.sessionId;
          message.context.userId = session.userId;
          
          // Process message
          const response = await this.processMessage(message);
          
          // Send response
          ws.send(JSON.stringify(response));
        } catch (error) {
          console.error('Error processing WebSocket message:', error);
          
          const errorResponse = {
            id: message?.id || uuidv4(),
            type: 'error',
            error: {
              code: 500,
              message: error.message
            }
          };
          
          ws.send(JSON.stringify(errorResponse));
        }
      });
      
      // Handle close
      ws.on('close', () => {
        console.log(`WebSocket connection closed for session ${session.sessionId}`);
        delete session.ws;
      });
      
      // Send welcome message
      const welcomeMessage = {
        type: 'notification',
        method: 'session.connected',
        params: {
          sessionId: session.sessionId,
          modelId: session.modelId,
          timestamp: new Date()
        }
      };
      
      ws.send(JSON.stringify(welcomeMessage));
    });
    
    // Handle WebSocket upgrade
    WebApp.httpServer.on('upgrade', async (request, socket, head) => {
      if (request.url.startsWith('/api/mcp/ws')) {
        try {
          // Extract session ID from URL
          const url = new URL(request.url, `http://${request.headers.host}`);
          const sessionId = url.searchParams.get('sessionId');
          const token = url.searchParams.get('token');
          
          if (!sessionId || !token) {
            socket.write('HTTP/1.1 401 Unauthorized\r\n\r\n');
            socket.destroy();
            return;
          }
          
          // Validate token
          let decoded;
          try {
            decoded = await this.securityManager.verifyAuthToken(token);
          } catch (error) {
            socket.write('HTTP/1.1 401 Unauthorized\r\n\r\n');
            socket.destroy();
            return;
          }
          
          // Get session
          const session = await this.getSession(sessionId);
          if (!session) {
            socket.write('HTTP/1.1 404 Not Found\r\n\r\n');
            socket.destroy();
            return;
          }
          
          // Check if user has access to session
          if (session.userId !== decoded.sub) {
            socket.write('HTTP/1.1 403 Forbidden\r\n\r\n');
            socket.destroy();
            return;
          }
          
          // Upgrade connection
          this.wss.handleUpgrade(request, socket, head, (ws) => {
            this.wss.emit('connection', ws, request, session);
          });
        } catch (error) {
          console.error('Error handling WebSocket upgrade:', error);
          socket.write('HTTP/1.1 500 Internal Server Error\r\n\r\n');
          socket.destroy();
        }
      }
    });
    
    console.log('MCP WebSocket server initialized');
  }

  /**
   * Register default message handlers
   * @private
   */
  registerDefaultHandlers() {
    // Plugin method execution
    this.registerHandler('plugin.execute', async (message) => {
      const { pluginName, method, params } = message.params;
      
      if (!pluginName || !method) {
        throw new Error('Plugin name and method are required');
      }
      
      const result = await this.pluginManager.executePluginMethod(
        pluginName,
        method,
        params || {}
      );
      
      return {
        id: message.id,
        type: 'response',
        result
      };
    });
    
    // Model execution
    this.registerHandler('model.execute', async (message) => {
      const { modelId, input, options } = message.params;
      
      if (!modelId) {
        throw new Error('Model ID is required');
      }
      
      // Get session
      const sessionId = message.context?.sessionId;
      if (!sessionId) {
        throw new Error('Session ID is required');
      }
      
      const session = await this.getSession(sessionId);
      if (!session) {
        throw new Error('Session not found');
      }
      
      // Execute model
      const result = await this.executeModel(modelId, input, options, session);
      
      return {
        id: message.id,
        type: 'response',
        result
      };
    });
    
    // Session management
    this.registerHandler('session.get', async (message) => {
      const sessionId = message.params?.sessionId || message.context?.sessionId;
      
      if (!sessionId) {
        throw new Error('Session ID is required');
      }
      
      const session = await this.getSession(sessionId);
      if (!session) {
        throw new Error('Session not found');
      }
      
      // Check if user has access to session
      if (session.userId !== message.context?.userId) {
        throw new Error('Forbidden');
      }
      
      return {
        id: message.id,
        type: 'response',
        result: session
      };
    });
    
    // Context management
    this.registerHandler('context.update', async (message) => {
      const sessionId = message.context?.sessionId;
      if (!sessionId) {
        throw new Error('Session ID is required');
      }
      
      const { metadata } = message.params || {};
      if (!metadata) {
        throw new Error('Metadata is required');
      }
      
      // Update session context
      await this.updateSessionContext(sessionId, metadata);
      
      return {
        id: message.id,
        type: 'response',
        result: { success: true }
      };
    });
  }

  /**
   * Register a message handler
   * @param {string} method - Method name
   * @param {Function} handler - Handler function
   */
  registerHandler(method, handler) {
    this.handlers.set(method, handler);
  }

  /**
   * Process an MCP message
   * @param {Object} message - Message to process
   * @returns {Promise<Object>} - Response message
   */
  async processMessage(message) {
    try {
      // Store message in database
      if (this.messagesCollection) {
        await this.messagesCollection.insertOne({
          ...message,
          timestamp: new Date()
        });
      }
      
      // Handle request
      if (message.type === 'request') {
        const method = message.method;
        if (!method) {
          return {
            id: message.id,
            type: 'error',
            error: {
              code: 400,
              message: 'Method is required for request'
            }
          };
        }
        
        // Find handler
        const handler = this.handlers.get(method);
        if (!handler) {
          return {
            id: message.id,
            type: 'error',
            error: {
              code: 404,
              message: `Method not found: ${method}`
            }
          };
        }
        
        // Execute handler
        try {
          const response = await handler(message);
          
          // Store response
          if (this.messagesCollection) {
            await this.messagesCollection.insertOne({
              ...response,
              timestamp: new Date()
            });
          }
          
          return response;
        } catch (error) {
          console.error(`Error executing handler for method ${method}:`, error);
          
          return {
            id: message.id,
            type: 'error',
            error: {
              code: 500,
              message: error.message
            }
          };
        }
      } else {
        // Return error for non-request messages
        return {
          id: message.id,
          type: 'error',
          error: {
            code: 400,
            message: 'Only request messages are supported via HTTP'
          }
        };
      }
    } catch (error) {
      console.error('Error processing message:', error);
      
      return {
        id: message.id,
        type: 'error',
        error: {
          code: 500,
          message: error.message
        }
      };
    }
  }

  /**
   * Create a new session
   * @param {string} modelId - Model ID
   * @param {string} userId - User ID
   * @param {Object} metadata - Session metadata
   * @returns {Promise<Object>} - Created session
   */
  async createSession(modelId, userId, metadata = {}) {
    try {
      const sessionId = uuidv4();
      
      const session = {
        sessionId,
        modelId,
        userId,
        metadata,
        createdAt: new Date(),
        updatedAt: new Date(),
        active: true
      };
      
      // Store in memory
      this.activeSessions.set(sessionId, session);
      
      // Store in database
      if (this.sessionsCollection) {
        await this.sessionsCollection.insertOne(session);
      }
      
      console.log(`Created MCP session ${sessionId} for user ${userId}`);
      return session;
    } catch (error) {
      console.error('Error creating session:', error);
      throw error;
    }
  }

  /**
   * Get a session by ID
   * @param {string} sessionId - Session ID
   * @returns {Promise<Object|null>} - Session or null if not found
   */
  async getSession(sessionId) {
    try {
      // Check memory cache
      if (this.activeSessions.has(sessionId)) {
        return this.activeSessions.get(sessionId);
      }
      
      // Check database
      if (this.sessionsCollection) {
        const session = await this.sessionsCollection.findOne({ sessionId });
        
        if (session && session.active) {
          // Cache in memory
          this.activeSessions.set(sessionId, session);
          return session;
        }
      }
      
      return null;
    } catch (error) {
      console.error(`Error getting session ${sessionId}:`, error);
      throw error;
    }
  }

  /**
   * Update session context
   * @param {string} sessionId - Session ID
   * @param {Object} metadata - New metadata
   * @returns {Promise<Object>} - Updated session
   */
  async updateSessionContext(sessionId, metadata) {
    try {
      // Get session
      const session = await this.getSession(sessionId);
      if (!session) {
        throw new Error('Session not found');
      }
      
      // Update metadata
      session.metadata = {
        ...session.metadata,
        ...metadata
      };
      session.updatedAt = new Date();
      
      // Update in memory
      this.activeSessions.set(sessionId, session);
      
      // Update in database
      if (this.sessionsCollection) {
        await this.sessionsCollection.updateOne(
          { sessionId },
          { 
            $set: { 
              metadata: session.metadata,
              updatedAt: session.updatedAt
            } 
          }
        );
      }
      
      return session;
    } catch (error) {
      console.error(`Error updating session context for ${sessionId}:`, error);
      throw error;
    }
  }

  /**
   * Close a session
   * @param {string} sessionId - Session ID
   * @returns {Promise<void>}
   */
  async closeSession(sessionId) {
    try {
      // Get session
      const session = await this.getSession(sessionId);
      if (!session) {
        throw new Error('Session not found');
      }
      
      // Close WebSocket if connected
      if (session.ws) {
        session.ws.close();
      }
      
      // Remove from memory
      this.activeSessions.delete(sessionId);
      
      // Update in database
      if (this.sessionsCollection) {
        await this.sessionsCollection.updateOne(
          { sessionId },
          { 
            $set: { 
              active: false,
              closedAt: new Date()
            } 
          }
        );
      }
      
      console.log(`Closed MCP session ${sessionId}`);
    } catch (error) {
      console.error(`Error closing session ${sessionId}:`, error);
      throw error;
    }
  }

  /**
   * Execute a model
   * @param {string} modelId - Model ID
   * @param {any} input - Model input
   * @param {Object} options - Execution options
   * @param {Object} session - Session information
   * @returns {Promise<any>} - Model result
   * @private
   */
  async executeModel(modelId, input, options = {}, session) {
    try {
      // This is a placeholder for actual model execution
      // In a real implementation, this would call a model service
      
      console.log(`Executing model ${modelId} with input:`, input);
      
      // For demonstration, use a plugin to process the input
      // In a real implementation, this would use a machine learning model
      const result = await this.pluginManager.executePluginMethod(
        'model-executor',
        'execute',
        {
          modelId,
          input,
          options,
          sessionContext: session.metadata
        }
      );
      
      return result;
    } catch (error) {
      console.error(`Error executing model ${modelId}:`, error);
      throw error;
    }
  }

  /**
   * Send a notification to a session
   * @param {string} sessionId - Session ID
   * @param {string} method - Notification method
   * @param {any} params - Notification parameters
   * @returns {Promise<boolean>} - True if notification was sent
   */
  async sendNotification(sessionId, method, params) {
    try {
      // Get session
      const session = await this.getSession(sessionId);
      if (!session) {
        throw new Error('Session not found');
      }
      
      // Create notification
      const notification = {
        type: 'notification',
        method,
        params,
        context: {
          sessionId,
          modelId: session.modelId,
          userId: session.userId
        }
      };
      
      // Store notification
      if (this.messagesCollection) {
        await this.messagesCollection.insertOne({
          ...notification,
          timestamp: new Date()
        });
      }
      
      // Send via WebSocket if connected
      if (session.ws) {
        session.ws.send(JSON.stringify(notification));
        return true;
      }
      
      return false;
    } catch (error) {
      console.error(`Error sending notification to session ${sessionId}:`, error);
      return false;
    }
  }

  /**
   * Broadcast a notification to all active sessions
   * @param {string} method - Notification method
   * @param {any} params - Notification parameters
   * @returns {Promise<number>} - Number of sessions notified
   */
  async broadcastNotification(method, params) {
    try {
      let notifiedCount = 0;
      
      // Send to all active sessions
      for (const [sessionId, session] of this.activeSessions.entries()) {
        if (session.ws) {
          const notification = {
            type: 'notification',
            method,
            params,
            context: {
              sessionId,
              modelId: session.modelId,
              userId: session.userId
            }
          };
          
          session.ws.send(JSON.stringify(notification));
          notifiedCount++;
        }
      }
      
      // Store notification
      if (this.messagesCollection) {
        await this.messagesCollection.insertOne({
          type: 'notification',
          method,
          params,
          broadcast: true,
          timestamp: new Date()
        });
      }
      
      return notifiedCount;
    } catch (error) {
      console.error('Error broadcasting notification:', error);
      throw error;
    }
  }

  /**
   * Register Meteor methods
   * @private
   */
  registerMeteorMethods() {
    Meteor.methods({
      'mcp.createSession': async (modelId, metadata) => {
        // Ensure user is logged in
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        return this.createSession(modelId, Meteor.userId(), metadata);
      },
      
      'mcp.closeSession': async (sessionId) => {
        // Ensure user is logged in
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        // Get session
        const session = await this.getSession(sessionId);
        if (!session) {
          throw new Meteor.Error('not-found', 'Session not found');
        }
        
        // Check if user has access to session
        if (session.userId !== Meteor.userId()) {
          throw new Meteor.Error('forbidden', 'Not authorized to access this session');
        }
        
        return this.closeSession(sessionId);
      },
      
      'mcp.sendMessage': async (sessionId, method, params) => {
        // Ensure user is logged in
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        // Get session
        const session = await this.getSession(sessionId);
        if (!session) {
          throw new Meteor.Error('not-found', 'Session not found');
        }
        
        // Check if user has access to session
        if (session.userId !== Meteor.userId()) {
          throw new Meteor.Error('forbidden', 'Not authorized to access this session');
        }
        
        // Create message
        const message = {
          id: uuidv4(),
          type: 'request',
          method,
          params,
          context: {
            sessionId,
            modelId: session.modelId,
            userId: Meteor.userId()
          }
        };
        
        // Process message
        return this.processMessage(message);
      },
      
      'mcp.getActiveSessions': async () => {
        // Ensure user is logged in
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        // Get user's active sessions
        const sessions = Array.from(this.activeSessions.values())
          .filter(session => session.userId === Meteor.userId())
          .map(session => ({
            sessionId: session.sessionId,
            modelId: session.modelId,
            createdAt: session.createdAt,
            updatedAt: session.updatedAt,
            metadata: session.metadata,
            connected: !!session.ws
          }));
        
        return sessions;
      }
    });
    
    console.log('MCP Meteor methods registered');
  }

  /**
   * Shutdown the MCP server
   * @returns {Promise<void>}
   */
  async shutdown() {
    try {
      console.log('Shutting down MCP Server...');
      
      // Close all WebSocket connections
      if (this.wss) {
        for (const client of this.wss.clients) {
          client.close();
        }
        
        this.wss.close();
      }
      
      // Mark all sessions as inactive
      if (this.sessionsCollection) {
        await this.sessionsCollection.updateMany(
          { active: true },
          { 
            $set: { 
              active: false,
              closedAt: new Date()
            } 
          }
        );
      }
      
      // Clear active sessions
      this.activeSessions.clear();
      
      console.log('MCP Server shut down successfully');
    } catch (error) {
      console.error('Error shutting down MCP Server:', error);
    }
  }
}

module.exports = MCPServer;
```


### 22. Agent Protocol Implementation

```javascript
/**
 * @fileoverview Agent-to-Agent Protocol implementation
 * @module plugin/protocols/AgentProtocol
 */

const { Meteor } = require('meteor/meteor');
const { WebApp } = require('meteor/webapp');
const express = require('express');
const bodyParser = require('body-parser');
const zod = require('zod');
const { v4: uuidv4 } = require('uuid');
const WebSocket = require('ws');

/**
 * Message schema validation
 */
const messageSchema = zod.object({
  id: zod.string().optional(),
  type: zod.enum(['request', 'response', 'event', 'error']),
  sender: zod.object({
    id: zod.string(),
    name: zod.string().optional(),
    type: zod.string().optional()
  }),
  recipient: zod.object({
    id: zod.string(),
    name: zod.string().optional(),
    type: zod.string().optional()
  }).optional(),
  action: zod.string().optional(),
  data: zod.any().optional(),
  error: zod.object({
    code: zod.number(),
    message: zod.string(),
    details: zod.any().optional()
  }).optional(),
  metadata: zod.record(zod.string(), zod.any()).optional(),
  timestamp: zod.number().optional()
});

/**
 * Class for implementing Agent-to-Agent Protocol
 */
class AgentProtocol {
  /**
   * Create a new AgentProtocol instance
   * @param {Object} options - Configuration options
   * @param {string} options.agentId - Agent ID
   * @param {string} options.agentName - Agent name
   * @param {string} options.agentType - Agent type
   * @param {Object} options.db - MongoDB database connection
   * @param {Object} options.pluginManager - Plugin manager instance
   * @param {Object} options.securityManager - Security manager instance
   */
  constructor(options = {}) {
    this.options = {
      agentId: options.agentId || uuidv4(),
      agentName: options.agentName || 'Plugin System Agent',
      agentType: options.agentType || 'plugin-system',
      ...options
    };
    
    this.db = options.db;
    this.pluginManager = options.pluginManager;
    this.securityManager = options.securityManager;
    
    this.agentsCollection = this.db ? this.db.collection('agents') : null;
    this.messagesCollection = this.db ? this.db.collection('agent_messages') : null;
    
    this.agents = new Map();
    this.connections = new Map();
    this.handlers = new Map();
    this.wss = null;
    this.router = null;
    
    // Register self
    this.agents.set(this.options.agentId, {
      id: this.options.agentId,
      name: this.options.agentName,
      type: this.options.agentType,
      status: 'online',
      lastSeen: new Date(),
      self: true
    });
    
    // Register default handlers
    this.registerDefaultHandlers();
  }

  /**
   * Initialize the Agent Protocol
   * @returns {Promise<void>}
   */
  async initialize() {
    try {
      console.log('Initializing Agent Protocol...');
      
      // Register self in database
      if (this.agentsCollection) {
        await this.agentsCollection.updateOne(
          { id: this.options.agentId },
          { 
            $set: { 
              name: this.options.agentName,
              type: this.options.agentType,
              status: 'online',
              lastSeen: new Date(),
              self: true
            } 
          },
          { upsert: true }
        );
      }
      
      // Set up HTTP routes
      this.setupHttpRoutes();
      
      // Set up WebSocket server
      this.setupWebSocketServer();
      
      // Register Meteor methods
      this.registerMeteorMethods();
      
      console.log('Agent Protocol initialized successfully');
    } catch (error) {
      console.error('Error initializing Agent Protocol:', error);
      throw error;
    }
  }

  /**
   * Set up HTTP routes
   * @private
   */
  setupHttpRoutes() {
    // Create router
    this.router = express.Router();
    
    // Add middleware
    this.router.use(bodyParser.json());
    
    // Add routes
    this.router.post('/message', async (req, res) => {
      try {
        // Validate request
        const auth = await this.securityManager.validateRequest(req);
        if (!auth.authenticated) {
          return res.status(401).json({
            error: {
              code: 401,
              message: 'Unauthorized'
            }
          });
        }
        
        // Validate message
        let message;
        try {
          message = messageSchema.parse(req.body);
        } catch (error) {
          return res.status(400).json({
            error: {
              code: 400,
              message: 'Invalid message format',
              data: error.errors
            }
          });
        }
        
        // Add message ID if not provided
        if (!message.id) {
          message.id = uuidv4();
        }
        
        // Add timestamp if not provided
        if (!message.timestamp) {
          message.timestamp = Date.now();
        }
        
        // Process message
        const response = await this.processMessage(message);
        
        res.json(response);
      } catch (error) {
        console.error('Error processing HTTP message:', error);
        res.status(500).json({
          error: {
            code: 500,
            message: error.message
          }
        });
      }
    });
    
    this.router.post('/register', async (req, res) => {
      try {
        // Validate request
        const auth = await this.securityManager.validateRequest(req);
        if (!auth.authenticated) {
          return res.status(401).json({
            error: {
              code: 401,
              message: 'Unauthorized'
            }
          });
        }
        
        // Register agent
        const { id, name, type, capabilities } = req.body;
        
        if (!id) {
          return res.status(400).json({
            error: {
              code: 400,
              message: 'Agent ID is required'
            }
          });
        }
        
        const agent = await this.registerAgent(id, name, type, capabilities);
        
        res.json(agent);
      } catch (error) {
        console.error('Error registering agent:', error);
        res.status(500).json({
          error: {
            code: 500,
            message: error.message
          }
        });
      }
    });
    
    this.router.get('/agents', async (req, res) => {
      try {
        // Validate request
        const auth = await this.securityManager.validateRequest(req);
        if (!auth.authenticated) {
          return res.status(401).json({
            error: {
              code: 401,
              message: 'Unauthorized'
            }
          });
        }
        
        // Get agents
        const agents = await this.getAgents();
        
        res.json(agents);
      } catch (error) {
        console.error('Error getting agents:', error);
        res.status(500).json({
          error: {
            code: 500,
            message: error.message
          }
        });
      }
    });
    
    this.router.get('/agent/:agentId', async (req, res) => {
      try {
        // Validate request
        const auth = await this.securityManager.validateRequest(req);
        if (!auth.authenticated) {
          return res.status(401).json({
            error: {
              code: 401,
              message: 'Unauthorized'
            }
          });
        }
        
        // Get agent
        const agentId = req.params.agentId;
        const agent = await this.getAgent(agentId);
        
        if (!agent) {
          return res.status(404).json({
            error: {
              code: 404,
              message: 'Agent not found'
            }
          });
        }
        
        res.json(agent);
      } catch (error) {
        console.error('Error getting agent:', error);
        res.status(500).json({
          error: {
            code: 500,
            message: error.message
          }
        });
      }
    });
    
    // Add router to WebApp
    WebApp.connectHandlers.use('/api/agent', this.router);
    console.log('Agent Protocol HTTP routes initialized');
  }

  /**
   * Set up WebSocket server
   * @private
   */
  setupWebSocketServer() {
    // Create WebSocket server
    this.wss = new WebSocket.Server({ 
      noServer: true,
      path: '/api/agent/ws'
    });
    
    // Handle connection
    this.wss.on('connection', (ws, req, agent) => {
      console.log(`WebSocket connection established for agent ${agent.id}`);
      
      // Store WebSocket connection
      this.connections.set(agent.id, ws);
      
      // Handle messages
      ws.on('message', async (data) => {
        try {
          // Parse message
          const message = JSON.parse(data);
          
          // Validate message
          try {
            messageSchema.parse(message);
          } catch (error) {
            const errorResponse = {
              id: message.id || uuidv4(),
              type: 'error',
              sender: {
                id: this.options.agentId,
                name: this.options.agentName,
                type: this.options.agentType
              },
              recipient: message.sender,
              error: {
                code: 400,
                message: 'Invalid message format',
                details: error.errors
              },
              timestamp: Date.now()
            };
            
            ws.send(JSON.stringify(errorResponse));
            return;
          }
          
          // Process message
          const response = await this.processMessage(message);
          
          // Send response if it's not null
          if (response) {
            ws.send(JSON.stringify(response));
          }
        } catch (error) {
          console.error('Error processing WebSocket message:', error);
          
          const errorResponse = {
            id: message?.id || uuidv4(),
            type: 'error',
            sender: {
              id: this.options.agentId,
              name: this.options.agentName,
              type: this.options.agentType
            },
            recipient: message?.sender,
            error: {
              code: 500,
              message: error.message
            },
            timestamp: Date.now()
          };
          
          ws.send(JSON.stringify(errorResponse));
        }
      });
      
      // Handle close
      ws.on('close', () => {
        console.log(`WebSocket connection closed for agent ${agent.id}`);
        this.connections.delete(agent.id);
        
        // Update agent status
        this.updateAgentStatus(agent.id, 'offline');
      });
      
      // Send welcome message
      const welcomeMessage = {
        type: 'event',
        sender: {
          id: this.options.agentId,
          name: this.options.agentName,
          type: this.options.agentType
        },
        recipient: {
          id: agent.id,
          name: agent.name,
          type: agent.type
        },
        action: 'agent.connected',
        data: {
          message: `Welcome, ${agent.name || agent.id}!`,
          timestamp: new Date()
        },
        timestamp: Date.now()
      };
      
      ws.send(JSON.stringify(welcomeMessage));
    });
    
    // Handle WebSocket upgrade
    WebApp.httpServer.on('upgrade', async (request, socket, head) => {
      if (request.url.startsWith('/api/agent/ws')) {
        try {
          // Extract agent ID from URL
          const url = new URL(request.url, `http://${request.headers.host}`);
          const agentId = url.searchParams.get('agentId');
          const token = url.searchParams.get('token');
          
          if (!agentId || !token) {
            socket.write('HTTP/1.1 401 Unauthorized\r\n\r\n');
            socket.destroy();
            return;
          }
          
          // Validate token
          let decoded;
          try {
            decoded = await this.securityManager.verifyAuthToken(token);
          } catch (error) {
            socket.write('HTTP/1.1 401 Unauthorized\r\n\r\n');
            socket.destroy();
            return;
          }
          
          // Get or register agent
          let agent = await this.getAgent(agentId);
          if (!agent) {
            agent = await this.registerAgent(agentId, agentId, 'unknown', []);
          }
          
          // Update agent status
          await this.updateAgentStatus(agentId, 'online');
          
          // Upgrade connection
          this.wss.handleUpgrade(request, socket, head, (ws) => {
            this.wss.emit('connection', ws, request, agent);
          });
        } catch (error) {
          console.error('Error handling WebSocket upgrade:', error);
          socket.write('HTTP/1.1 500 Internal Server Error\r\n\r\n');
          socket.destroy();
        }
      }
    });
    
    console.log('Agent Protocol WebSocket server initialized');
  }

  /**
   * Register default message handlers
   * @private
   */
  registerDefaultHandlers() {
    // Register a ping/pong handler
    this.registerHandler('ping', async (message) => {
      return {
        id: uuidv4(),
        type: 'response',
        sender: {
          id: this.options.agentId,
          name: this.options.agentName,
          type: this.options.agentType
        },
        recipient: message.sender,
        action: 'pong',
        data: {
          receivedAt: new Date(),
          echo: message.data
        },
        timestamp: Date.now()
      };
    });
    
    // Register a discovery handler
    this.registerHandler('discover', async (message) => {
      const agents = await this.getAgents();
      
      return {
        id: uuidv4(),
        type: 'response',
        sender: {
          id: this.options.agentId,
          name: this.options.agentName,
          type: this.options.agentType
        },
        recipient: message.sender,
        action: 'discover.response',
        data: {
          agents
        },
        timestamp: Date.now()
      };
    });
    
    // Register a capabilities handler
    this.registerHandler('capabilities', async (message) => {
      return {
        id: uuidv4(),
        type: 'response',
        sender: {
          id: this.options.agentId,
          name: this.options.agentName,
          type: this.options.agentType
        },
        recipient: message.sender,
        action: 'capabilities.response',
        data: {
          capabilities: [
            'plugin.execute',
            'plugin.discover',
            'worker.execute',
            'agent.discover',
            'agent.message'
          ]
        },
        timestamp: Date.now()
      };
    });
    
    // Register a plugin execution handler
    this.registerHandler('plugin.execute', async (message) => {
      const { pluginName, method, params } = message.data || {};
      
      if (!pluginName || !method) {
        throw new Error('Plugin name and method are required');
      }
      
      const result = await this.pluginManager.executePluginMethod(
        pluginName,
        method,
        params || {}
      );
      
      return {
        id: uuidv4(),
        type: 'response',
        sender: {
          id: this.options.agentId,
          name: this.options.agentName,
          type: this.options.agentType
        },
        recipient: message.sender,
        action: 'plugin.execute.response',
        data: {
          result
        },
        timestamp: Date.now()
      };
    });
    
    // Register a plugin discovery handler
    this.registerHandler('plugin.discover', async (message) => {
      const plugins = await this.pluginManager.getPluginCatalog();
      
      return {
        id: uuidv4(),
        type: 'response',
        sender: {
          id: this.options.agentId,
          name: this.options.agentName,
          type: this.options.agentType
        },
        recipient: message.sender,
        action: 'plugin.discover.response',
        data: {
          plugins: plugins.map(plugin => ({
            name: plugin.name,
            version: plugin.version,
            description: plugin.description,
            methods: Object.keys(plugin.contract?.methods || {})
          }))
        },
        timestamp: Date.now()
      };
    });
    
    // Register a worker execution handler
    this.registerHandler('worker.execute', async (message) => {
      const { job, options } = message.data || {};
      
      if (!job) {
        throw new Error('Job is required');
      }
      
      const result = await this.pluginManager.workerManager.executeJob(
        job,
        options || {}
      );
      
      return {
        id: uuidv4(),
        type: 'response',
        sender: {
          id: this.options.agentId,
          name: this.options.agentName,
          type: this.options.agentType
        },
        recipient: message.sender,
        action: 'worker.execute.response',
        data: {
          result
        },
        timestamp: Date.now()
      };
    });
  }

  /**
   * Register a message handler
   * @param {string} action - Action name
   * @param {Function} handler - Handler function
   */
  registerHandler(action, handler) {
    this.handlers.set(action, handler);
  }

  /**
   * Process an agent message
   * @param {Object} message - Message to process
   * @returns {Promise<Object|null>} - Response message or null if no response needed
   */
  async processMessage(message) {
    try {
      // Store message in database
      if (this.messagesCollection) {
        await this.messagesCollection.insertOne({
          ...message,
          receivedAt: new Date()
        });
      }
      
      // Update sender agent's last seen timestamp
      if (message.sender && message.sender.id) {
        await this.updateAgentLastSeen(message.sender.id);
      }
      
      // Check if message is for this agent
      if (message.recipient && message.recipient.id !== this.options.agentId) {
        // Forward message to recipient if connected
        return this.forwardMessage(message);
      }
      
      // Handle message based on type
      if (message.type === 'request') {
        const action = message.action;
        if (!action) {
          return {
            id: uuidv4(),
            type: 'error',
            sender: {
              id: this.options.agentId,
              name: this.options.agentName,
              type: this.options.agentType
            },
            recipient: message.sender,
            error: {
              code: 400,
              message: 'Action is required for request'
            },
            timestamp: Date.now()
          };
        }
        
        // Find handler
        const handler = this.handlers.get(action);
        if (!handler) {
          return {
            id: uuidv4(),
            type: 'error',
            sender: {
              id: this.options.agentId,
              name: this.options.agentName,
              type: this.options.agentType
            },
            recipient: message.sender,
            error: {
              code: 404,
              message: `Action not found: ${action}`
            },
            timestamp: Date.now()
          };
        }
        
        // Execute handler
        try {
          const response = await handler(message);
          
          // Store response
          if (this.messagesCollection && response) {
            await this.messagesCollection.insertOne({
              ...response,
              sentAt: new Date()
            });
          }
          
          return response;
        } catch (error) {
          console.error(`Error executing handler for action ${action}:`, error);
          
          return {
            id: uuidv4(),
            type: 'error',
            sender: {
              id: this.options.agentId,
              name: this.options.agentName,
              type: this.options.agentType
            },
            recipient: message.sender,
            error: {
              code: 500,
              message: error.message
            },
            timestamp: Date.now()
          };
        }
      } else if (message.type === 'response' || message.type === 'event') {
        // No response needed for responses or events
        return null;
      } else if (message.type === 'error') {
        console.error('Received error message:', message.error);
        return null;
      } else {
        // Unknown message type
        return {
          id: uuidv4(),
          type: 'error',
          sender: {
            id: this.options.agentId,
            name: this.options.agentName,
            type: this.options.agentType
          },
          recipient: message.sender,
          error: {
            code: 400,
            message: `Unknown message type: ${message.type}`
          },
          timestamp: Date.now()
        };
      }
    } catch (error) {
      console.error('Error processing message:', error);
      
      return {
        id: uuidv4(),
        type: 'error',
        sender: {
          id: this.options.agentId,
          name: this.options.agentName,
          type: this.options.agentType
        },
        recipient: message.sender,
        error: {
          code: 500,
          message: error.message
        },
        timestamp: Date.now()
      };
    }
  }

  /**
   * Forward a message to its recipient
   * @param {Object} message - Message to forward
   * @returns {Promise<null>} - Null response (no response needed)
   * @private
   */
  async forwardMessage(message) {
    if (!message.recipient || !message.recipient.id) {
      throw new Error('Recipient is required for forwarding');
    }
    
    const recipientId = message.recipient.id;
    
    // Check if recipient is connected
    if (this.connections.has(recipientId)) {
      const ws = this.connections.get(recipientId);
      
      // Forward message
      ws.send(JSON.stringify(message));
      
      // Store forwarded message
      if (this.messagesCollection) {
        await this.messagesCollection.insertOne({
          ...message,
          forwarded: true,
          forwardedAt: new Date()
        });
      }
      
      return null;
    } else {
      // Recipient not connected
      return {
        id: uuidv4(),
        type: 'error',
        sender: {
          id: this.options.agentId,
          name: this.options.agentName,
          type: this.options.agentType
        },
        recipient: message.sender,
        error: {
          code: 404,
          message: `Recipient agent not connected: ${recipientId}`
        },
        timestamp: Date.now()
      };
    }
  }

  /**
   * Register an agent
   * @param {string} id - Agent ID
   * @param {string} name - Agent name
   * @param {string} type - Agent type
   * @param {Array<string>} capabilities - Agent capabilities
   * @returns {Promise<Object>} - Registered agent
   */
  async registerAgent(id, name, type, capabilities = []) {
    try {
      const agent = {
        id,
        name: name || id,
        type: type || 'unknown',
        capabilities: capabilities || [],
        status: 'registered',
        registeredAt: new Date(),
        lastSeen: new Date()
      };
      
      // Store in memory
      this.agents.set(id, agent);
      
      // Store in database
      if (this.agentsCollection) {
        await this.agentsCollection.updateOne(
          { id },
          { $set: agent },
          { upsert: true }
        );
      }
      
      console.log(`Registered agent ${id} (${name || 'unnamed'})`);
      return agent;
    } catch (error) {
      console.error(`Error registering agent ${id}:`, error);
      throw error;
    }
  }

  /**
   * Get an agent by ID
   * @param {string} agentId - Agent ID
   * @returns {Promise<Object|null>} - Agent or null if not found
   */
  async getAgent(agentId) {
    try {
      // Check memory cache
      if (this.agents.has(agentId)) {
        return this.agents.get(agentId);
      }
      
      // Check database
      if (this.agentsCollection) {
        const agent = await this.agentsCollection.findOne({ id: agentId });
        
        if (agent) {
          // Cache in memory
          this.agents.set(agentId, agent);
          return agent;
        }
      }
      
      return null;
    } catch (error) {
      console.error(`Error getting agent ${agentId}:`, error);
      throw error;
    }
  }

  /**
   * Get all registered agents
   * @returns {Promise<Array<Object>>} - Array of agents
   */
  async getAgents() {
    try {
      if (this.agentsCollection) {
        const agents = await this.agentsCollection.find({}).toArray();
        
        // Update memory cache
        for (const agent of agents) {
          this.agents.set(agent.id, agent);
        }
        
        return agents;
      } else {
        return Array.from(this.agents.values());
      }
    } catch (error) {
      console.error('Error getting agents:', error);
      throw error;
    }
  }

  /**
   * Update agent status
   * @param {string} agentId - Agent ID
   * @param {string} status - Agent status
   * @returns {Promise<void>}
   */
  async updateAgentStatus(agentId, status) {
    try {
      // Update in memory
      if (this.agents.has(agentId)) {
        const agent = this.agents.get(agentId);
        agent.status = status;
        agent.lastSeen = new Date();
      }
      
      // Update in database
      if (this.agentsCollection) {
        await this.agentsCollection.updateOne(
          { id: agentId },
          { 
            $set: { 
              status,
              lastSeen: new Date()
            } 
          }
        );
      }
    } catch (error) {
      console.error(`Error updating agent status for ${agentId}:`, error);
    }
  }

  /**
   * Update agent last seen timestamp
   * @param {string} agentId - Agent ID
   * @returns {Promise<void>}
   */
  async updateAgentLastSeen(agentId) {
    try {
      // Update in memory
      if (this.agents.has(agentId)) {
        const agent = this.agents.get(agentId);
        agent.lastSeen = new Date();
      }
      
      // Update in database
      if (this.agentsCollection) {
        await this.agentsCollection.updateOne(
          { id: agentId },
          { 
            $set: { 
              lastSeen: new Date()
            } 
          }
        );
      }
    } catch (error) {
      console.error(`Error updating agent last seen for ${agentId}:`, error);
    }
  }

  /**
   * Send a message to an agent
   * @param {string} recipientId - Recipient agent ID
   * @param {string} action - Message action
   * @param {any} data - Message data
   * @returns {Promise<Object|null>} - Response message or null if no response
   */
  async sendMessage(recipientId, action, data) {
    try {
      // Get recipient agent
      const recipient = await this.getAgent(recipientId);
      if (!recipient) {
        throw new Error(`Agent not found: ${recipientId}`);
      }
      
      // Create message
      const message = {
        id: uuidv4(),
        type: 'request',
        sender: {
          id: this.options.agentId,
          name: this.options.agentName,
          type: this.options.agentType
        },
        recipient: {
          id: recipientId,
          name: recipient.name,
          type: recipient.type
        },
        action,
        data,
        timestamp: Date.now()
      };
      
      // Store message
      if (this.messagesCollection) {
        await this.messagesCollection.insertOne({
          ...message,
          sentAt: new Date()
        });
      }
      
      // Send message
      if (this.connections.has(recipientId)) {
        const ws = this.connections.get(recipientId);
        
        // Send via WebSocket
        ws.send(JSON.stringify(message));
        
        // No response for WebSocket messages
        return null;
      } else {
        // Try to send via HTTP if agent has a URL
        if (recipient.url) {
          const response = await fetch(`${recipient.url}/api/agent/message`, {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
              'Authorization': `Bearer ${await this.securityManager.generateAuthToken()}`
            },
            body: JSON.stringify(message)
          });
          
          if (!response.ok) {
            throw new Error(`HTTP error: ${response.status}`);
          }
          
          return await response.json();
        } else {
          throw new Error(`Agent ${recipientId} is not connected and has no URL`);
        }
      }
    } catch (error) {
      console.error(`Error sending message to agent ${recipientId}:`, error);
      throw error;
    }
  }

  /**
   * Broadcast a message to all connected agents
   * @param {string} action - Message action
   * @param {any} data - Message data
   * @returns {Promise<number>} - Number of agents the message was sent to
   */
  async broadcastMessage(action, data) {
    try {
      let sentCount = 0;
      
      // Create message
      const message = {
        id: uuidv4(),
        type: 'event',
        sender: {
          id: this.options.agentId,
          name: this.options.agentName,
          type: this.options.agentType
        },
        action,
        data,
        timestamp: Date.now()
      };
      
      // Store message
      if (this.messagesCollection) {
        await this.messagesCollection.insertOne({
          ...message,
          broadcast: true,
          sentAt: new Date()
        });
      }
      
      // Send to all connected agents
      for (const [agentId, ws] of this.connections.entries()) {
        if (agentId !== this.options.agentId) {
          try {
            // Add recipient to message
            const agent = await this.getAgent(agentId);
            const agentMessage = {
              ...message,
              recipient: {
                id: agentId,
                name: agent?.name,
                type: agent?.type
              }
            };
            
            ws.send(JSON.stringify(agentMessage));
            sentCount++;
          } catch (error) {
            console.error(`Error broadcasting to agent ${agentId}:`, error);
          }
        }
      }
      
      return sentCount;
    } catch (error) {
      console.error('Error broadcasting message:', error);
      throw error;
    }
  }

  /**
   * Register Meteor methods
   * @private
   */
  registerMeteorMethods() {
    Meteor.methods({
      'agent.register': async (name, type, capabilities) => {
        // Ensure user is logged in
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        // Generate agent ID
        const agentId = `agent-${Meteor.userId()}-${Date.now()}`;
        
        // Register agent
        return this.registerAgent(agentId, name, type, capabilities);
      },
      
      'agent.sendMessage': async (recipientId, action, data) => {
        // Ensure user is logged in
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        return this.sendMessage(recipientId, action, data);
      },
      
      'agent.getAgents': async () => {
        // Ensure user is logged in
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        return this.getAgents();
      },
      
      'agent.broadcastMessage': async (action, data) => {
        // Ensure user is logged in
        if (!Meteor.userId()) {
          throw new Meteor.Error('not-authorized', 'User must be logged in');
        }
        
        return this.broadcastMessage(action, data);
      }
    });
    
    console.log('Agent Protocol Meteor methods registered');
  }

  /**
   * Shutdown the Agent Protocol
   * @returns {Promise<void>}
   */
  async shutdown() {
    try {
      console.log('Shutting down Agent Protocol...');
      
      // Close all WebSocket connections
      if (this.wss) {
        for (const client of this.wss.clients) {
          client.close();
        }
        
        this.wss.close();
      }
      
      // Clear connections
      this.connections.clear();
      
      // Update self status
      if (this.agentsCollection) {
        await this.agentsCollection.updateOne(
          { id: this.options.agentId },
          { 
            $set: { 
              status: 'offline',
              lastSeen: new Date()
            } 
          }
        );
      }
      
      console.log('Agent Protocol shut down successfully');
    } catch (error) {
      console.error('Error shutting down Agent Protocol:', error);
    }
  }
}

module.exports = AgentProtocol;
```


### 23. JSONRPC Implementation

```javascript
/**
 * @fileoverview JSON-RPC implementation for plugin system
 * @module plugin/protocols/JSONRPC
 */

const { Meteor } = require('meteor/meteor');
const { WebApp } = require('meteor/webapp');
const express = require('express');
const bodyParser = require('body-parser');
const zod = require('zod');

/**
 * Request schema validation
 */
const requestSchema = zod.object({
  jsonrpc: zod.literal('2.0'),
  id: zod.union([zod.string(), zod.number(), zod.null()]).optional(),
  method: zod.string(),
  params: zod.union([zod.array(zod.any()), zod.record(zod.string(), zod.any())]).optional()
});

/**
 * Batch request schema validation
 */
const batchRequestSchema = zod.array(requestSchema);

/**
 * Class for implementing JSON-RPC protocol
 */
class JSONRPCServer {
  /**
   * Create a new JSONRPCServer instance
   * @param {Object} options - Configuration options
   * @param {Object} options.pluginManager - Plugin manager instance
   * @param {Object} options.securityManager - Security manager instance
   * @param {string} options.endpoint - API endpoint
   */
  constructor(options = {}) {
    this.options = {
      endpoint: options.endpoint || '/api/jsonrpc',
      ...options
    };
    
    this.pluginManager = options.pluginManager;
    this.securityManager = options.securityManager;
    
    this.methods = new Map();
    this.router = null;
    
    // Register default methods
    this.registerDefaultMethods();
  }

  /**
   * Initialize the JSON-RPC server
   * @returns {Promise<void>}
   */
  async initialize() {
    try {
      console.log('Initializing JSON-RPC Server...');
      
      // Set up HTTP routes
      this.setupHttpRoutes();
      
      console.log('JSON-RPC Server initialized successfully');
    } catch (error) {
      console.error('Error initializing JSON-RPC Server:', error);
      throw error;
    }
  }

  /**
   * Set up HTTP routes
   * @private
   */
  setupHttpRoutes() {
    // Create router
    this.router = express.Router();
    
    // Add middleware
    this.router.use(bodyParser.json());
    
    // Add JSON-RPC endpoint
    this.router.post('/', async (req, res) => {
      try {
        // Validate request
        const auth = await this.securityManager.validateRequest(req);
        if (!auth.authenticated) {
          return res.status(401).json({
            jsonrpc: '2.0',
            error: {
              code: -32000,
              message: 'Unauthorized'
            },
            id: null
          });
        }
        
        // Check if request is a batch or single request
        const isBatch = Array.isArray(req.body);
        
        let requests;
        try {
          if (isBatch) {
            requests = batchRequestSchema.parse(req.body);
          } else {
            requests = [requestSchema.parse(req.body)];
          }
        } catch (error) {
          return res.json({
            jsonrpc: '2.0',
            error: {
              code: -32600,
              message: 'Invalid Request',
              data: error.errors
            },
            id: req.body.id || null
          });
        }
        
        // Process requests
        const responses = await Promise.all(
          requests.map(request => this.processRequest(request, auth))
        );
        
        // Filter out null responses (notifications)
        const filteredResponses = responses.filter(response => response !== null);
        
        // Return responses
        if (isBatch) {
          if (filteredResponses.length === 0) {
            // All requests were notifications, return nothing
            return res.status(204).end();
          }
          return res.json(filteredResponses);
        } else {
          if (filteredResponses.length === 0) {
            // Request was a notification, return nothing
            return res.status(204).end();
          }
          return res.json(filteredResponses[0]);
        }
      } catch (error) {
        console.error('Error processing JSON-RPC request:', error);
        
        res.json({
          jsonrpc: '2.0',
          error: {
            code: -32603,
            message: 'Internal error',
            data: error.message
          },
          id: null
        });
      }
    });
    
    // Add router to WebApp
    WebApp.connectHandlers.use(this.options.endpoint, this.router);
    console.log(`JSON-RPC endpoint initialized at ${this.options.endpoint}`);
  }

  /**
   * Register default JSON-RPC methods
   * @private
   */
  registerDefaultMethods() {
    // System methods
    this.registerMethod('system.listMethods', () => {
      return Array.from(this.methods.keys());
    });
    
    // Plugin methods
    this.registerMethod('plugin.execute', async (params) => {
      const { pluginName, method, params: methodParams } = params;
      
      if (!pluginName || !method) {
        throw new JSONRPCError(-32602, 'Invalid params', 'Plugin name and method are required');
      }
      
      return this.pluginManager.executePluginMethod(
        pluginName,
        method,
        methodParams || {}
      );
    });
    
    this.registerMethod('plugin.info', async (params) => {
      const { pluginName } = params;
      
      if (!pluginName) {
        throw new JSONRPCError(-32602, 'Invalid params', 'Plugin name is required');
      }
      
      return this.pluginManager.getPluginInfo(pluginName);
    });
    
    this.registerMethod('plugin.catalog', async () => {
      return this.pluginManager.getPluginCatalog();
    });
    
    // Worker methods
    this.registerMethod('worker.execute', async (params) => {
      const { job, options } = params;
      
      if (!job) {
        throw new JSONRPCError(-32602, 'Invalid params', 'Job is required');
      }
      
      return this.pluginManager.workerManager.executeJob(job, options || {});
    });
    
    this.registerMethod('worker.status', async () => {
      return this.pluginManager.workerManager.getStatus();
    });
    
    // Node methods
    this.registerMethod('node.info', async () => {
      return {
        nodeId: this.pluginManager.nodeManager.getNodeId(),
        host: this.pluginManager.nodeManager.host,
        port: this.pluginManager.nodeManager.port,
        url: this.pluginManager.nodeManager.url,
        isSuperNode: this.pluginManager.nodeManager.isSuperNode
      };
    });
    
    this.registerMethod('node.connected', async () => {
      return this.pluginManager.nodeManager.getConnectedNodes();
    });
  }

  /**
   * Register a JSON-RPC method
   * @param {string} name - Method name
   * @param {Function} handler - Method handler
   */
  registerMethod(name, handler) {
    this.methods.set(name, handler);
  }

  /**
   * Process a JSON-RPC request
   * @param {Object} request - JSON-RPC request
   * @param {Object} auth - Authentication information
   * @returns {Promise<Object|null>} - JSON-RPC response or null for notifications
   * @private
   */
  async processRequest(request, auth) {
    const { jsonrpc, id, method, params } = request;
    
    // Check if request is a notification (no id)
    const isNotification = id === undefined;
    
    try {
      // Find method handler
      const handler = this.methods.get(method);
      if (!handler) {
        if (isNotification) return null;
        
        return {
          jsonrpc: '2.0',
          error: {
            code: -32601,
            message: 'Method not found'
          },
          id
        };
      }
      
      // Execute method
      const result = await handler(params || {}, auth);
      
      // Return result
      if (isNotification) return null;
      
      return {
        jsonrpc: '2.0',
        result,
        id
      };
    } catch (error) {
      if (isNotification) return null;
      
      // Check if it's a JSONRPCError
      if (error instanceof JSONRPCError) {
        return {
          jsonrpc: '2.0',
          error: {
            code: error.code,
            message: error.message,
            data: error.data
          },
          id
        };
      }
      
      // Other errors
      console.error(`Error executing method ${method}:`, error);
      
      return {
        jsonrpc: '2.0',
        error: {
          code: -32603,
          message: 'Internal error',
          data: error.message
        },
        id
      };
    }
  }

  /**
   * Shutdown the JSON-RPC server
   * @returns {Promise<void>}
   */
  async shutdown() {
    // Nothing to do for now
    console.log('JSON-RPC Server shut down successfully');
  }
}

/**
 * JSON-RPC error class
 */
class JSONRPCError extends Error {
  /**
   * Create a new JSONRPCError
   * @param {number} code - Error code
   * @param {string} message - Error message
   * @param {any} data - Additional error data
   */
  constructor(code, message, data = undefined) {
    super(message);
    this.code = code;
    this.data = data;
    this.name = 'JSONRPCError';
  }
}

module.exports = {
  JSONRPCServer,
  JSONRPCError
};
```


### 24. Documentation: Plugin Development Guide

```markdown
# Plugin Development Guide

This guide will walk you through the process of creating plugins for our extensible plugin architecture.

## Table of Contents

1. [Plugin Structure](#plugin-structure)
2. [Core Plugin Functions](#core-plugin-functions)
3. [Plugin Contract](#plugin-contract)
4. [Configuration Management](#configuration-management)
5. [Plugin Documentation](#plugin-documentation)
6. [Testing Plugins](#testing-plugins)
7. [Best Practices](#best-practices)
8. [Debugging Plugins](#debugging-plugins)
9. [Plugin Examples](#plugin-examples)

## Plugin Structure

A plugin must follow a specific directory structure:
```

/my-plugin/
├── index.js           # Main entry point
├── package.json       # Node.js dependencies (optional)
├── requirements.txt   # Python dependencies (optional)
├── config.json        # Default configuration (optional)
├── README.md          # Plugin documentation (optional)
└── ... (other files)
```
The `index.js` file is the entry point for your plugin and must export the required plugin functions.

## Core Plugin Functions

### 1. plugin_info()

This function returns information about the plugin, including name, version, interface version, configuration schema, and contract details.
```
javascript
function plugin_info() {
return {
name: 'my-plugin',
version: '1.0.0',
interface: '1.0.0',
description: 'My awesome plugin',
configuration: {
// Configuration schema (see Configuration Management section)
},
contract: {
// Contract details (see Plugin Contract section)
}
};
}
```
### 2. plugin_init(config)

This function initializes the plugin with the provided configuration. It should return a handle that will be passed to other plugin functions.
```
javascript
async function plugin_init(config) {
// Initialize plugin state
const state = {
config,
initialized: true,
startTime: new Date()
};

// Perform any setup operations

return state;
}
```
### 3. plugin_reconfigure(handle, newConfig)

This function updates the plugin configuration. It should return an updated handle.
```
javascript
async function plugin_reconfigure(handle, newConfig) {
// Update configuration
handle.config = newConfig;
handle.reconfiguredAt = new Date();

// Apply configuration changes

return handle;
}
```
### 4. plugin_shutdown(handle)

This function performs cleanup when the plugin is unloaded.
```
javascript
async function plugin_shutdown(handle) {
// Perform cleanup operations

handle.initialized = false;
handle.shutdownAt = new Date();
}
```
### 5. documentation()

This function returns HTML documentation for the plugin.
```
javascript
function documentation() {
return `
<!DOCTYPE html>
<html>
<head>
  <title>My Plugin Documentation</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
  <div class="container">
    <h1>My Plugin</h1>
    <p>Documentation for my awesome plugin.</p>
    <!-- Additional documentation content -->
  </div>
</body>
</html>
`;
}
```
## Plugin Contract

The plugin contract defines how the plugin can be used, including usage limits, cost, and method definitions. It follows this format:
```
javascript
{
  id: 'my-plugin-contract',
  pluginName: 'my-plugin',
  version: '1.0.0',
  publisher: 'Your Name',
  usage: 'subscription', // 'oneTime', 'subscription', or 'unlimited'
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
  copyright: 'Copyright (c) 2025 Your Name',
  methods: {
    // Method definitions (see below)
  }
}
```
### Method Definitions

Each method in your plugin should be defined in the contract's `methods` object:
```
javascript
methods: {
  methodName: {
    description: 'Description of what this method does',
    params: {
      param1: {
        type: 'string',
        description: 'Description of parameter 1',
        required: true
      },
      param2: {
        type: 'number',
        description: 'Description of parameter 2',
        required: false
      }
    },
    returns: {
      type: 'object',
      description: 'Description of the return value'
    }
  }
}
```
## Configuration Management

Plugins can define their configuration schema in the `configuration` property of the plugin information. The schema follows this format:
```
javascript
configuration: {
  'setting1': {
    'description': 'Description of setting 1',
    'type': 'string',
    'default': 'default value'
  },
  'setting2': {
    'description': 'Description of setting 2',
    'type': 'integer',
    'default': '42'
  },
  'enableFeature': {
    'description': 'Enable an optional feature',
    'type': 'boolean',
    'default': 'false'
  }
}
```
### Configuration Types

The following configuration types are supported:

- `string`: Text value
- `integer`: Whole number
- `float`: Decimal number
- `boolean`: True/false value
- `enumeration`: Selection from predefined options
- `list`: List of values
- `kvlist`: Key-value pairs
- `object`: Complex object

### Advanced Configuration Example
```
javascript
'advancedSetting': {
  'description': 'Advanced configuration setting',
  'type': 'enumeration',
  'options': ['option1', 'option2', 'option3'],
  'default': 'option1',
  'displayName': 'Advanced Setting',
  'order': '1',
  'mandatory': 'true',
  'readonly': 'false',
  'validity': 'otherSetting == "enabled"'
}
```
## Plugin Documentation

The `documentation()` function should return HTML content that describes your plugin. The documentation should include:

1. Overview of the plugin
2. Configuration options
3. Available methods
4. Example usage
5. Troubleshooting tips

Use Bootstrap 4 for styling to ensure consistent appearance. Example:
```
html
<!DOCTYPE html>
<html>
<head>
  <title>My Plugin Documentation</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
  <div class="container">
    <h1>My Plugin</h1>
    <p class="lead">A brief description of what my plugin does.</p>
    
    <h2 id="overview">Overview</h2>
    <p>Detailed description of the plugin's functionality...</p>
    
    <h2 id="configuration">Configuration</h2>
    <table class="table">
      <thead>
        <tr>
          <th>Setting</th>
          <th>Type</th>
          <th>Default</th>
          <th>Description</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>setting1</td>
          <td>string</td>
          <td>"default value"</td>
          <td>Description of setting 1</td>
        </tr>
        <!-- Additional settings -->
      </tbody>
    </table>
    
    <h2 id="methods">Methods</h2>
    
    <div class="method" id="methodName">
      <h3>methodName</h3>
      <p>Description of what this method does.</p>
      
      <h4>Parameters</h4>
      <table class="table">
        <thead>
          <tr>
            <th>Name</th>
            <th>Type</th>
            <th>Required</th>
            <th>Description</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>param1</td>
            <td>string</td>
            <td>Yes</td>
            <td>Description of parameter 1</td>
          </tr>
          <!-- Additional parameters -->
        </tbody>
      </table>
      
      <h4>Returns</h4>
      <p>Description of the return value.</p>
      
      <h4>Example</h4>
      <pre><code>
const result = await methodName({
  param1: "value1",
  param2: 42
});
      </code></pre>
    </div>
    
    <!-- Additional methods -->
    
    <h2 id="examples">Examples</h2>
    <p>Examples of how to use the plugin...</p>
    
    <h2 id="troubleshooting">Troubleshooting</h2>
    <p>Common issues and solutions...</p>
  </div>
</body>
</html>
```
## Testing Plugins

### Creating Test Files

Create test files for your plugin to verify its functionality. You can use Mocha and Chai for testing:
```
javascript
// test/my-plugin.test.js
const { expect } = require('chai');
const plugin = require('../index');

describe('My Plugin', () => {
  let handle;
  
  before(async () => {
    const config = {
      setting1: 'test value',
      setting2: 100
    };
    handle = await plugin.plugin_init(config);
  });
  
  after(async () => {
    await plugin.plugin_shutdown(handle);
  });
  
  it('should return plugin info', () => {
    const info = plugin.plugin_info();
    expect(info).to.be.an('object');
    expect(info.name).to.equal('my-plugin');
    expect(info.version).to.be.a('string');
  });
  
  it('should execute methodName correctly', async () => {
    const result = await plugin.methodName({
      param1: 'value1',
      param2: 42
    });
    
    expect(result).to.be.an('object');
    expect(result.success).to.equal(true);
  });
  
  // Additional tests
});
```
### Running Tests

Run tests using Mocha:
```
bash
mocha test/my-plugin.test.js
```
## Best Practices

1. **Error Handling**: Always handle errors properly and provide meaningful error messages.

2. **Async/Await**: Use async/await for asynchronous operations instead of callbacks or raw promises.

3. **Resource Management**: Clean up resources in the `plugin_shutdown` function.

4. **Validation**: Validate all inputs to your plugin methods.

5. **Documentation**: Provide comprehensive documentation for your plugin.

6. **Configuration**: Use the configuration system for all configurable aspects of your plugin.

7. **Performance**: Optimize for performance, especially for long-running operations.

8. **Logging**: Use appropriate logging levels for different types of messages.

Example of good error handling:
```
javascript
async function methodName(params) {
  try {
    // Validate parameters
    if (!params.param1) {
      throw new Error('param1 is required');
    }
    
    // Perform operation
    const result = await performOperation(params);
    
    return {
      success: true,
      data: result
    };
  } catch (error) {
    console.error(`Error in methodName: ${error.message}`);
    
    return {
      success: false,
      error: error.message
    };
  }
}
```
## Debugging Plugins

### Console Logging

Use console.log, console.error, etc. for debugging:
```
javascript
console.log('Debug info:', variable);
console.error('Error occurred:', error);
```
### Debugging in Development

During development, you can use the Node.js debugger:

1. Start the application with the `--inspect` flag
2. Use Chrome DevTools or VS Code to connect to the debugger
3. Set breakpoints in your plugin code

### Inspecting Plugin State

You can add methods to your plugin to inspect its state:
```
javascript
function getDebugInfo(handle) {
  return {
    config: handle.config,
    state: {
      initialized: handle.initialized,
      startTime: handle.startTime,
      // Other state information
    }
  };
}
```
## Plugin Examples

### Simple Plugin Example

```javascript
// index.js
const os = require('os');

function plugin_info() {
  return {
    name: 'system-info',
    version: '1.0.0',
    interface: '1.0.0',
    description: 'Provides system information',
    configuration: {
      'refreshInterval': {
        'description': 'Refresh interval in seconds',
        'type': 'integer',
        'default': '60'
      }
    },
    contract: {
      id: 'system-info-contract',
      pluginName: 'system-info',
      version: '1.0.0',
      publisher: 'Example Developer',
      usage: 'unlimited',
      methods: {
        getSystemInfo: {
          description: 'Get system information',
          params: {},
          returns: {
            type: 'object',
            description: 'System information'
          }
        },
        getCpuInfo: {
          description: 'Get CPU information',
          params: {},
          returns: {
            type: 'object',
            description: 'CPU information'
          }
        }
      }
    }
  };
}

async function plugin_init(config) {
  const state = {
    config,
    initialized: true,
    startTime: new Date(),
    refreshInterval: parseInt(config.refreshInterval) || 60,
    lastRefresh: null,
    cachedInfo: null
  };
  
  // Initial data refresh
  state.cachedInfo = await refreshSystemInfo();
  state.lastRefresh = new Date();
  
  return state;
}

async function plugin_reconfigure(handle, newConfig) {
  handle.config = newConfig;
  handle.refreshInterval = parseInt(newConfig.refreshInterval) || 60;
  handle.reconfiguredAt = new Date();
  
  return handle;
}

async function plugin_shutdown(handle) {
  handle.initialized = false;
  handle.shutdownAt = new Date();
}

async function getSystemInfo(params, handle) {
  // Check if cache is stale
  const now = new Date();
  if (!handle.lastRefresh || (now - handle.lastRefresh) / 1000 > handle.refreshInterval) {
    handle.cachedInfo = await refreshSystemInfo();
    handle.lastRefresh = now;
  }
  
  return handle.cachedInfo;
}

async function getCpuInfo(params, handle) {
  return {
    cpus: os.cpus(),
    loadAvg: os.loadavg(),
    uptime: os.uptime()
  };
}

async function refreshSystemInfo() {
  return {
    hostname: os.hostname(),
    platform: os.platform(),
    arch: os.arch(),
    release: os.release(),
    cpus: os.cpus().length,
    totalMemory: os.totalmem(),
    freeMemory: os.freemem(),
    uptime: os.uptime(),
    loadAvg: os.loadavg(),
    timestamp: new Date()
  };
}

function documentation() {
  return `
<!DOCTYPE html>
<html>
<head>
  <title>System Info Plugin Documentation</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
  <div class="container">
    <h1>System Info Plugin</h1>
    <p class="lead">Provides information about the system.</p>
    
    <h2 id="overview">Overview</h2>
    <p>This plugin provides methods to retrieve information about the system, including CPU, memory, and platform details.</p>
    
    <h2 id="configuration">Configuration</h2>
    <table class="table">
      <thead>
        <tr>
          <th>Setting</th>
          <th>Type</th>
          <th>Default</th>
          <th>Description</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>refreshInterval</td>
          <td>integer</td>
          <td>60</td>
          <td>Refresh interval in seconds</td>
        </tr>
      </tbody>
    </table>
    
    <h2 id="methods">Methods</h2>
    
    <div class="method" id="getSystemInfo">
      <h3>getSystemInfo</h3>
      <p>Get comprehensive system information.</p>
      
      <h4>Parameters</h4>
      <p>None</p>
      
      <h4>Returns</h4>
      <p>Object containing system information.</p>
      
      <h4>Example</h4>
      <pre><code>
const systemInfo = await getSystemInfo();
console.log(systemInfo.hostname);
console.log(systemInfo.totalMemory);
      </code></pre>
    </div>
    
    <div class="method" id="getCpuInfo">
      <h3>getCpuInfo</h3>
      <p>Get CPU-specific information.</p>
      
      <h4>Parameters</h4>
      <p>None</p>
      
      <h4>Returns</h4>
      <p>Object containing CPU information.</p>
      
      <h4>Example</h4>
      <pre><code>
const cpuInfo = await getCpuInfo();
console.log(cpuInfo.loadAvg);
console.log(cpuInfo.cpus.length);
      </code></pre>
    </div>
  </div>
</body>
</html>
`;
}

module.exports = {
  plugin_info,
  plugin_init,
  plugin_reconfigure,
  plugin_shutdown,
  getSystemInfo,
  getCpuInfo,
  documentation
};
```
```


## Conclusion

This guide covers the basics of creating plugins for our plugin architecture. Remember to follow the best practices for creating maintainable, efficient, and well-documented plugins. If you have any questions or need assistance, refer to the API documentation or contact the development team.
```
These implementations should complete the core functionality required for the plugin architecture. The system now has all the necessary components for managing plugins, handling worker threads, communicating between nodes, managing contracts, supporting various protocols (JSON-RPC, MCP, Agent Protocol), and working with containers.

The architecture is designed to be extensible, secure, and distributed, allowing plugins to be discovered, shared, and executed across a network of nodes. It includes comprehensive documentation for plugin developers and robust error handling throughout.
```

        },
        "zoneId": {
          "type": "string",
          "description": "Zone ID",
          "required": true
        }
      },
      "returns": {
        "type": "object",
        "description": "Setup result with DNS, SSL, and Nginx details"
      }
    }
  }
}
```


This plugin configuration file defines a comprehensive contract for the Cloudflare API plugin, including:

1. **Basic Information**:
    - Unique ID, name, version, and publisher details
    - Description of the plugin's capabilities
    - Usage model set as "subscription"
    - Appropriate limits and cost settings

2. **Copyright Notice**:
    - Includes the required copyright information for Autonomy Association International and NASA

3. **Methods**:
    - Defines 10 key methods that represent the core functionality of the Cloudflare API client
    - Each method includes detailed parameter definitions with types and descriptions
    - All return types are properly documented

The contract covers the primary Cloudflare API operations including DNS management, cache control, SSL certificates, tunnels, firewall rules, and integration with Nginx and Let's Encrypt. This provides a clear interface for developers to understand what functionality is available and how to use it correctly.