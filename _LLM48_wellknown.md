I'll analyze the project to identify modules that support agent-to-agent and MCP server access features, then create a comprehensive .well-known discovery service. This will be crucial for enabling system-wide service discovery.

## Current State Analysis

First, I need to understand what code exists for agent-to-agent communication and MCP server access.Based on my review of the code, I'll now create a server module that provides a unified `.well-known` discovery service for the system. This will enable agent-to-agent and MCP server access as specified.

# Implementing .well-known Discovery Service

The `.well-known` design pattern is a standardized way for servers to provide discovery information at well-known URLs. I'll implement a comprehensive solution that:

1. Consolidates all protocol and plugin discovery endpoints
2. Creates server-rendered discovery endpoints
3. Enables dynamic discovery of plugins
4. Supports future extensibility

Let's build this solution:Based on my review of the codebase, I'll now create a centralized `.well-known` service module to enable discovery for agent-to-agent and MCP server access across the system.

# Creating a .well-known Discovery Service for SAFEGUARD

The `.well-known` design pattern is a standardized way to enable service discovery across distributed systems. I'll implement a server module that provides this functionality for all protocol services in the SAFEGUARD platform.

## Key Features to Implement

1. A centralized Express server module to handle `.well-known` routes
2. Support for agent-to-agent protocol discovery
3. Support for Model Context Protocol (MCP) discovery
4. Support for plugin module discovery
5. Extensible architecture for future protocol additions

Let's create the implementation:

```javascript
/**
 * @fileoverview Well-Known Discovery Service for SAFEGUARD platform
 * Provides standardized discovery endpoints for agent-to-agent, MCP, and plugin services
 * 
 * Copyright 2025 Autonomy Association International Inc., all rights reserved
 * Safeguard patent license from National Aeronautics and Space Administration (NASA)
 * Copyright 2025 NASA, all rights reserved
 */

import express from 'express';
import cors from 'cors';
import path from 'path';
import fs from 'fs';
import { v4 as uuidv4 } from 'uuid';
import { WebApp } from 'meteor/webapp';

/**
 * Well-Known Discovery Service
 * Implements the .well-known design pattern for service discovery
 */
export class WellKnownDiscoveryService {
  /**
   * Create a new Well-Known Discovery Service
   * @param {Object} options - Configuration options
   * @param {Object} options.protocols - Protocol references
   * @param {Object} options.pluginManager - Plugin manager reference
   * @param {String} options.baseUrl - Base URL for .well-known endpoints (default: '/.well-known')
   */
  constructor(options = {}) {
    this.options = options;
    this.baseUrl = options.baseUrl || '/.well-known';
    this.protocols = options.protocols || {};
    this.pluginManager = options.pluginManager;
    
    // Router for all .well-known endpoints
    this.router = express.Router();
    
    // Service info cache
    this.serviceInfo = {
      serverInfo: null,
      lastUpdated: null,
      id: uuidv4()
    };
    
    // Initialize
    this.initialize();
  }
  
  /**
   * Initialize the service and set up routes
   */
  initialize() {
    // Apply middleware
    this.router.use(cors());
    this.router.use(express.json());
    
    // Set up routes
    this._setupRoutes();
    
    // Mount router at base URL
    WebApp.connectHandlers.use(this.baseUrl, this.router);
    
    console.log(`Well-Known Discovery Service initialized at ${this.baseUrl}`);
  }
  
  /**
   * Set up all discovery routes
   * @private
   */
  _setupRoutes() {
    // Root discovery endpoint
    this.router.get('/', (req, res) => {
      this._updateServiceInfo();
      
      res.json({
        service: 'SAFEGUARD Discovery',
        version: '1.0.0',
        timestamp: new Date().toISOString(),
        availableEndpoints: [
          '/.well-known/server-info',
          '/.well-known/agent-to-agent',
          '/.well-known/mcp',
          '/.well-known/plugins',
          '/.well-known/protocols'
        ]
      });
    });
    
    // Server info endpoint
    this.router.get('/server-info', (req, res) => {
      this._updateServiceInfo();
      res.json(this.serviceInfo.serverInfo);
    });
    
    // Agent-to-Agent protocol discovery
    this.router.get('/agent-to-agent', (req, res) => {
      const a2aInfo = this._getAgentToAgentInfo();
      
      if (!a2aInfo) {
        return res.status(404).json({
          error: 'Agent-to-Agent protocol not available',
          status: 'not_available'
        });
      }
      
      res.json(a2aInfo);
    });
    
    // MCP discovery
    this.router.get('/mcp', (req, res) => {
      const mcpInfo = this._getMCPInfo();
      
      if (!mcpInfo) {
        return res.status(404).json({
          error: 'Model Context Protocol not available',
          status: 'not_available'
        });
      }
      
      res.json(mcpInfo);
    });
    
    // Plugins discovery
    this.router.get('/plugins', (req, res) => {
      const pluginsInfo = this._getPluginsInfo();
      
      res.json(pluginsInfo);
    });
    
    // Individual plugin discovery
    this.router.get('/plugins/:pluginName', (req, res) => {
      const pluginName = req.params.pluginName;
      const pluginInfo = this._getPluginInfo(pluginName);
      
      if (!pluginInfo) {
        return res.status(404).json({
          error: `Plugin ${pluginName} not found`,
          status: 'not_found'
        });
      }
      
      res.json(pluginInfo);
    });
    
    // All protocols discovery
    this.router.get('/protocols', (req, res) => {
      const protocolsInfo = this._getAllProtocolsInfo();
      
      res.json(protocolsInfo);
    });
    
    // Static .well-known files (serve from /private/.well-known if exists)
    const wellKnownDir = path.join(process.cwd(), 'private', '.well-known');
    if (fs.existsSync(wellKnownDir)) {
      this.router.use('/static', express.static(wellKnownDir));
    }
    
    console.log('Well-Known Discovery Service routes configured');
  }
  
  /**
   * Update service information cache
   * @private
   */
  _updateServiceInfo() {
    // Only update every 60 seconds
    const now = Date.now();
    if (this.serviceInfo.lastUpdated && now - this.serviceInfo.lastUpdated < 60000) {
      return;
    }
    
    // Get server information
    this.serviceInfo.serverInfo = {
      id: this.serviceInfo.id,
      timestamp: new Date().toISOString(),
      serverName: process.env.SERVER_NAME || 'SAFEGUARD',
      version: process.env.VERSION || '1.0.0',
      protocols: {
        agentToAgent: this.protocols.agentToAgent ? true : false,
        modelContext: this.protocols.modelContext ? true : false,
        messageCommunication: this.protocols.messageCommunication ? true : false,
        httpJsonRpc: this.protocols.httpJsonRpc ? true : false
      },
      plugins: this.pluginManager ? this.pluginManager.getPlugins().length : 0,
      endpoints: {
        agentToAgent: '/.well-known/agent-to-agent',
        mcp: '/.well-known/mcp',
        plugins: '/.well-known/plugins',
        protocols: '/.well-known/protocols'
      }
    };
    
    this.serviceInfo.lastUpdated = now;
  }
  
  /**
   * Get Agent-to-Agent protocol information
   * @private
   * @returns {Object|null} Agent-to-Agent protocol info or null if not available
   */
  _getAgentToAgentInfo() {
    const a2a = this.protocols.agentToAgent;
    
    if (!a2a) {
      return null;
    }
    
    return {
      protocol: 'Agent-to-Agent',
      version: '1.0.0',
      status: 'available',
      wsPath: a2a.config?.wsPath || '/a2a',
      securityLevel: a2a.config?.securityLevel || 'AUTHENTICATED',
      endpoints: {
        websocket: a2a.config?.wsPath || '/a2a',
        register: '/api/node/register',
        discover: '/api/node/discover',
        ping: '/api/node/ping'
      },
      documentation: '/docs/protocols/agent_to_agent_communication_protocol.html'
    };
  }
  
  /**
   * Get Model Context Protocol information
   * @private
   * @returns {Object|null} MCP info or null if not available
   */
  _getMCPInfo() {
    const mcp = this.protocols.modelContext;
    
    if (!mcp) {
      return null;
    }
    
    return {
      protocol: 'Model Context Protocol',
      version: '1.0.0',
      status: 'available',
      httpEnabled: mcp.config?.httpEnabled || true,
      socketIOEnabled: mcp.config?.socketIOEnabled || true,
      wsEnabled: mcp.config?.wsEnabled || true,
      arrowEnabled: mcp.config?.arrowEnabled || false,
      endpoints: {
        http: mcp.config?.httpPath || '/mcp',
        socketIO: mcp.config?.socketIOPath || '/mcp/socket.io',
        websocket: mcp.config?.wsPath || '/mcp/ws',
        arrow: mcp.config?.arrowEnabled ? (mcp.config?.arrowPath || '/mcp/arrow') : null
      },
      modelTypes: Object.keys(mcp.models || {}),
      documentation: '/docs/protocols/mcp.html'
    };
  }
  
  /**
   * Get all plugins information
   * @private
   * @returns {Object} Plugins info
   */
  _getPluginsInfo() {
    if (!this.pluginManager) {
      return {
        status: 'unavailable',
        message: 'Plugin system not available'
      };
    }
    
    const plugins = this.pluginManager.getPlugins();
    
    return {
      count: plugins.length,
      status: 'available',
      plugins: plugins.map(plugin => ({
        name: plugin.name,
        version: plugin.version,
        status: plugin.status,
        url: `/.well-known/plugins/${plugin.name}`
      }))
    };
  }
  
  /**
   * Get specific plugin information
   * @private
   * @param {String} pluginName - Plugin name
   * @returns {Object|null} Plugin info or null if not found
   */
  _getPluginInfo(pluginName) {
    if (!this.pluginManager) {
      return null;
    }
    
    const plugin = this.pluginManager.getPluginInfo(pluginName);
    
    if (!plugin) {
      return null;
    }
    
    return {
      name: plugin.name,
      version: plugin.version,
      description: plugin.description,
      author: plugin.author,
      status: plugin.status,
      capabilities: plugin.capabilities || [],
      contract: plugin.contract,
      endpoints: plugin.endpoints || [],
      apiRoot: plugin.apiRoot || `/plugin/${plugin.name}`
    };
  }
  
  /**
   * Get information about all available protocols
   * @private
   * @returns {Object} All protocols info
   */
  _getAllProtocolsInfo() {
    const result = {
      timestamp: new Date().toISOString(),
      protocols: []
    };
    
    // Agent-to-Agent Protocol
    if (this.protocols.agentToAgent) {
      result.protocols.push({
        name: 'Agent-to-Agent',
        status: 'available',
        url: '/.well-known/agent-to-agent'
      });
    }
    
    // Model Context Protocol
    if (this.protocols.modelContext) {
      result.protocols.push({
        name: 'Model Context Protocol',
        status: 'available',
        url: '/.well-known/mcp'
      });
    }
    
    // Message Communication Protocol
    if (this.protocols.messageCommunication) {
      result.protocols.push({
        name: 'Message Communication Protocol',
        status: 'available',
        endpoints: {
          http: this.protocols.messageCommunication.config?.httpPath || '/mcp',
          socketIO: this.protocols.messageCommunication.config?.socketIOPath || '/mcp/socket.io',
          amqp: this.protocols.messageCommunication.config?.amqpEnabled ? this.protocols.messageCommunication.config?.amqpUrl : null,
          mqtt: this.protocols.messageCommunication.config?.mqttEnabled ? this.protocols.messageCommunication.config?.mqttUrl : null,
          kafka: this.protocols.messageCommunication.config?.kafkaEnabled ? this.protocols.messageCommunication.config?.kafkaBrokers : null
        }
      });
    }
    
    // HTTP JSON-RPC Server
    if (this.protocols.httpJsonRpc) {
      result.protocols.push({
        name: 'HTTP JSON-RPC',
        status: 'available',
        endpoints: {
          http: this.protocols.httpJsonRpc.config?.path || '/jsonrpc',
          websocket: this.protocols.httpJsonRpc.config?.enableWebsocket ? this.protocols.httpJsonRpc.config?.path : null
        },
        port: this.protocols.httpJsonRpc.config?.port || 8545,
        host: this.protocols.httpJsonRpc.config?.host || 'localhost'
      });
    }
    
    return result;
  }
  
  /**
   * Register a custom discovery endpoint
   * @param {String} path - URL path (will be prefixed with baseUrl)
   * @param {Function} handler - Express route handler function
   */
  registerCustomEndpoint(path, handler) {
    if (!path || typeof handler !== 'function') {
      console.error('Invalid custom endpoint registration');
      return;
    }
    
    // Register the route handler
    this.router.get(path, handler);
    console.log(`Registered custom discovery endpoint: ${this.baseUrl}${path}`);
  }
}
```


Now, let's create a module to update the main server entry point to initialize our new discovery service:

```javascript
/**
 * @fileoverview Main server entry point for IASMS
 * This file initializes all protocols and systems and provides references to their implementations
 * 
 * Copyright 2025 Autonomy Association International Inc., all rights reserved
 * Safeguard patent license from National Aeronautics and Space Administration (NASA)
 * Copyright 2025 NASA, all rights reserved
 */

import { Meteor } from 'meteor/meteor';
import { WebApp } from 'meteor/webapp';
import { MongoInternals } from 'meteor/mongo';

// Database collections
import { 
  VehiclePositions, 
  Trajectories, 
  GeofenceZones, 
  Beacons, 
  Plugins, 
  PluginContracts,
  IasmsMcpContexts,
  IasmsMcpMessages,
  IasmsMcpModels,
  IasmsMcpKnowledgeBases
} from './collections.js';

// Core protocol implementations
import { ModelContextProtocol } from './protocols/ModelContextProtocol.js';
import { MessageCommunicationProtocol } from './protocols/MessageCommunicationProtocol.js';
import { AgentToAgentProtocol } from './protocols/AgentToAgentCommunicationProtocol.js';
import { HttpJsonRpcServer } from './protocols/HttpJsonRpcServer.js';
import { IasmsMCP } from './protocols/IasmsMessageCommunicationProtocol.js';

// Plugin system
import { PluginManager } from '../private/plugin/core/PluginManager.js';
import { PluginLoader } from '../private/plugin/core/PluginLoader.js';
import { PluginContractManager } from '../private/plugin/core/PluginContractManager.js';

// Services
import { IAMSIntegrationAPI } from './services/IAMSIntegrationAPI.js';
import { OAuth2Server } from './services/OAuth2Server.js';
import { SafeguardServer } from './services/SafeguardServer.js';
import { WellKnownDiscoveryService } from './services/WellKnownDiscoveryService.js';

// Configuration
const config = {
  protocols: {
    modelContext: {
      httpEnabled: true,
      socketIOEnabled: true,
      wsEnabled: true,
      arrowEnabled: true,
      httpPath: '/mcp',
      socketIOPath: '/mcp/socket.io',
      wsPath: '/mcp/ws',
      arrowPath: '/mcp/arrow',
      modelSyncInterval: 5000,
      requireAuth: true,
      autoStart: true
    },
    messageCommunication: {
      httpEnabled: true,
      socketIOEnabled: true,
      amqpEnabled: Meteor.settings.protocols?.mcp?.amqpEnabled || false,
      mqttEnabled: Meteor.settings.protocols?.mcp?.mqttEnabled || false,
      kafkaEnabled: Meteor.settings.protocols?.mcp?.kafkaEnabled || false,
      httpPath: '/mcp',
      socketIOPath: '/mcp/socket.io',
      amqpUrl: Meteor.settings.protocols?.mcp?.amqpUrl || 'amqp://localhost',
      mqttUrl: Meteor.settings.protocols?.mcp?.mqttUrl || 'mqtt://localhost',
      kafkaBrokers: Meteor.settings.protocols?.mcp?.kafkaBrokers || ['localhost:9092'],
      topicPrefix: 'autonomy',
      requireAuth: true,
      autoStart: true
    },
    agentToAgent: {
      wsPath: '/a2a',
      port: null,
      discoveryInterval: 10000,
      heartbeatInterval: 5000,
      securityLevel: 'AUTHENTICATED',
      encryptionKey: Meteor.settings.protocols?.a2a?.encryptionKey || null,
      autoStart: true
    },
    iasmsMcp: {
      defaultModel: 'gpt-4',
      maxMessagesPerContext: 100,
      maxContextAgeHours: 24,
      defaultTemperature: 0.7,
      defaultMaxTokens: 1000,
      enableKnowledgeRetrieval: true,
      defaultRetrievalTopK: 5
    },
    httpJsonRpc: {
      port: Meteor.settings.protocols?.jsonrpc?.port || 8545,
      host: Meteor.settings.protocols?.jsonrpc?.host || 'localhost',
      path: Meteor.settings.protocols?.jsonrpc?.path || '/jsonrpc',
      enableHttp2: true,
      enableWebsocket: true,
      maxBatchSize: 50,
      requireAuth: true
    }
  },
  plugin: {
    pluginsDir: Meteor.settings.plugins?.dir || '/private/plugin/modules',
    fallbackDir: Meteor.settings.plugins?.fallbackDir || '/modules',
    dbCollection: 'plugins',
    mongoUrl: process.env.MONGO_URL || Meteor.settings.mongodb?.url || 'mongodb://localhost:27017/meteor'
  },
  services: {
    oauth2: {
      path: '/oauth2',
      requireHttps: true
    },
    integration: {
      port: Meteor.settings.services?.integration?.port || 4000,
      jwtSecret: Meteor.settings.services?.integration?.jwtSecret || 'iams-jwt-secret'
    },
    discovery: {
      baseUrl: '/.well-known'
    }
  }
};

// Protocol instances
let modelContextProtocol;
let messageCommunicationProtocol;
let agentToAgentProtocol;
let httpJsonRpcServer;
let iasmsMcp;

// Plugin system instances
let pluginContractManager;
let pluginLoader;
let pluginManager;

// Service instances
let iamsIntegrationAPI;
let oauth2Server;
let safeguardServer;
let wellKnownDiscoveryService;

// Database connection
const db = MongoInternals.defaultRemoteCollectionDriver().mongo.db;

Meteor.startup(async function() {
  console.log('Initializing IASMS server...');

  try {
    // Initialize protocol implementations
    console.log('Initializing protocols...');
    
    // Model Context Protocol
    modelContextProtocol = new ModelContextProtocol(config.protocols.modelContext);
    
    // Message Communication Protocol
    messageCommunicationProtocol = new MessageCommunicationProtocol(config.protocols.messageCommunication);
    
    // Agent-to-Agent Protocol
    agentToAgentProtocol = new AgentToAgentProtocol(config.protocols.agentToAgent);
    
    // HTTP/2 JSON-RPC Server
    httpJsonRpcServer = new HttpJsonRpcServer(config.protocols.httpJsonRpc);
    await httpJsonRpcServer.start();
    
    // IASMS Message Communication Protocol
    iasmsMcp = new IasmsMCP(config.protocols.iasmsMcp);
    await iasmsMcp.initialize();
    
    console.log('Protocols initialized successfully');

    // Initialize plugin system
    console.log('Initializing plugin system...');
    
    // Plugin Contract Manager
    pluginContractManager = new PluginContractManager({
      db: db,
      collection: 'pluginContracts'
    });
    
    // Plugin Loader
    pluginLoader = new PluginLoader({
      pluginsDir: config.plugin.pluginsDir,
      fallbackDir: config.plugin.fallbackDir,
      dbCollection: config.plugin.dbCollection,
      mongoUrl: config.plugin.mongoUrl,
      db: db
    });
    
    // Plugin Manager
    pluginManager = new PluginManager({
      contractManager: pluginContractManager,
      pluginLoader: pluginLoader,
      db: db
    });
    
    // Initialize plugin manager
    await pluginManager.initialize();
    
    console.log('Plugin system initialized successfully');

    // Initialize services
    console.log('Initializing services...');
    
    // IAMS Integration API
    iamsIntegrationAPI = new IAMSIntegrationAPI({
      db: db,
      port: config.services.integration.port,
      jwtSecret: config.services.integration.jwtSecret
    });
    await iamsIntegrationAPI.initialize();
    
    // OAuth2 Server
    oauth2Server = new OAuth2Server(config.services.oauth2);
    
    // Safeguard Server
    safeguardServer = new SafeguardServer({
      modelContextProtocol,
      messageCommunicationProtocol,
      agentToAgentProtocol
    });
    
    // Well-Known Discovery Service
    wellKnownDiscoveryService = new WellKnownDiscoveryService({
      baseUrl: config.services.discovery.baseUrl,
      protocols: {
        modelContext: modelContextProtocol,
        messageCommunication: messageCommunicationProtocol,
        agentToAgent: agentToAgentProtocol,
        httpJsonRpc: httpJsonRpcServer
      },
      pluginManager: pluginManager
    });
    
    console.log('Services initialized successfully');

    // Register RPC methods
    registerRpcMethods();

    console.log('IASMS server initialized successfully');
  } catch (error) {
    console.error('Error initializing IASMS server:', error);
  }
});

/**
 * Register RPC methods for HTTP/2 JSON-RPC Server
 */
function registerRpcMethods() {
  // Model Context Protocol methods
  httpJsonRpcServer.registerMethod('mcp.getModels', async (params) => {
    const { type } = params;
    return modelContextProtocol.getModels(type);
  });
  
  httpJsonRpcServer.registerMethod('mcp.getModel', async (params) => {
    const { type, id } = params;
    return modelContextProtocol.getModel(type, id);
  });
  
  httpJsonRpcServer.registerMethod('mcp.updateModel', async (params) => {
    const { type, id, model } = params;
    return modelContextProtocol.updateModel(type, id, model);
  });
  
  httpJsonRpcServer.registerMethod('mcp.removeModel', async (params) => {
    const { type, id } = params;
    return modelContextProtocol.removeModel(type, id);
  });
  
  // IASMS MCP methods
  httpJsonRpcServer.registerMethod('iasms.mcp.createContext', async (params) => {
    return iasmsMcp.createContext(params);
  });
  
  httpJsonRpcServer.registerMethod('iasms.mcp.getContext', async (params) => {
    return iasmsMcp.getContext(params.contextId);
  });
  
  httpJsonRpcServer.registerMethod('iasms.mcp.updateContext', async (params) => {
    return iasmsMcp.updateContext(params.contextId, params.updates);
  });
  
  httpJsonRpcServer.registerMethod('iasms.mcp.sendMessage', async (params) => {
    return iasmsMcp.sendMessage(params);
  });
  
  httpJsonRpcServer.registerMethod('iasms.mcp.getModels', async () => {
    return Array.from(iasmsMcp.models.values());
  });
  
  httpJsonRpcServer.registerMethod('iasms.mcp.getKnowledgeBases', async () => {
    return Array.from(iasmsMcp.knowledgeBases.values());
  });
  
  // Plugin system methods
  httpJsonRpcServer.registerMethod('plugin.getPlugins', async () => {
    return pluginManager.getPlugins();
  });
  
  httpJsonRpcServer.registerMethod('plugin.loadPlugin', async (params) => {
    return pluginManager.loadPlugin(params.pluginInfo);
  });
  
  httpJsonRpcServer.registerMethod('plugin.unloadPlugin', async (params) => {
    return pluginManager.unloadPlugin(params.pluginName);
  });
  
  httpJsonRpcServer.registerMethod('plugin.executeMethod', async (params) => {
    return pluginManager.executePluginMethod(
      params.pluginName,
      params.methodName,
      params.args
    );
  });
  
  // Discovery service methods
  httpJsonRpcServer.registerMethod('discovery.getServerInfo', async () => {
    return wellKnownDiscoveryService._updateServiceInfo();
    return wellKnownDiscoveryService.serviceInfo.serverInfo;
  });
  
  httpJsonRpcServer.registerMethod('discovery.getProtocols', async () => {
    return wellKnownDiscoveryService._getAllProtocolsInfo();
  });
  
  console.log('RPC methods registered successfully');
}

// Export key components for use in other server modules
export {
  modelContextProtocol,
  messageCommunicationProtocol,
  agentToAgentProtocol,
  httpJsonRpcServer,
  iasmsMcp,
  pluginContractManager,
  pluginLoader,
  pluginManager,
  iamsIntegrationAPI,
  oauth2Server,
  safeguardServer,
  wellKnownDiscoveryService,
  VehiclePositions,
  Trajectories,
  GeofenceZones,
  Beacons,
  Plugins,
  PluginContracts,
  IasmsMcpContexts,
  IasmsMcpMessages,
  IasmsMcpModels,
  IasmsMcpKnowledgeBases
};
```


Finally, let's create an extension for the Plugin Manager to allow plugins to register their own .well-known endpoints:

```javascript
// ... existing code ...

/**
 * Register plugin's .well-known discovery endpoints
 * @param {string} pluginName - Name of the plugin
 * @param {Object} discoveryInfo - Discovery information
 * @returns {Promise<boolean>} - Success status
 */
async registerPluginDiscovery(pluginName, discoveryInfo) {
  try {
    const plugin = this.loadedPlugins.get(pluginName);
    
    if (!plugin) {
      console.warn(`Cannot register discovery for unknown plugin: ${pluginName}`);
      return false;
    }
    
    // Get well-known discovery service from main.js
    const { wellKnownDiscoveryService } = require('../../../server/main.js');
    
    if (!wellKnownDiscoveryService) {
      console.warn('Well-Known Discovery Service not available');
      return false;
    }
    
    // Register custom endpoint for this plugin
    wellKnownDiscoveryService.registerCustomEndpoint(
      `/plugins/${pluginName}/discovery`,
      (req, res) => {
        res.json({
          name: plugin.name,
          version: plugin.version,
          discoveryInfo,
          timestamp: new Date().toISOString()
        });
      }
    );
    
    // Store discovery info with plugin
    plugin.discoveryInfo = discoveryInfo;
    
    console.log(`Registered discovery endpoints for plugin: ${pluginName}`);
    return true;
  } catch (error) {
    console.error(`Error registering plugin discovery for ${pluginName}:`, error);
    return false;
  }
}

// ... rest of existing code ...
```


## How This Solution Works

The implementation creates a comprehensive `.well-known` discovery service that:

1. **Centralizes Discovery**: All protocol and service discovery endpoints are accessible via a standardized URL structure (`/.well-known/...`)

2. **Supports Key Protocols**:
    - Agent-to-Agent protocol via `/.well-known/agent-to-agent`
    - Model Context Protocol via `/.well-known/mcp`
    - All protocols via `/.well-known/protocols`

3. **Enables Plugin Discovery**:
    - Lists all plugins via `/.well-known/plugins`
    - Individual plugin details via `/.well-known/plugins/{pluginName}`
    - Custom plugin-specific discovery endpoints

4. **Is Extensible**:
    - Plugins can register their own discovery endpoints
    - New protocols can be easily added
    - Static .well-known files are supported (from `/private/.well-known`)

5. **Provides Server Info**:
    - Server capabilities via `/.well-known/server-info`
    - Available protocol endpoints
    - Plugin counts and capabilities

This implementation follows industry best practices for service discovery, making the SAFEGUARD platform's features and capabilities discoverable in a standardized, machine-readable way. This will facilitate agent-to-agent communication, MCP server access, and plugin discovery across the distributed system.

The service is integrated into the main server startup sequence and has appropriate connections to all relevant protocol and plugin systems.

continue, what path should the routes be located, update main.js

I'll update the main.js file and organize the routes properly for the .well-known discovery service.

## Well-Known Discovery Service Implementation

Based on your request, I'll modify the design to ensure the `.well-known` routes are located in the correct path structure and update the main.js file accordingly.

```javascript
/**
 * @fileoverview Well-Known Discovery Service for SAFEGUARD platform
 * Provides standardized discovery endpoints for agent-to-agent, MCP, and plugin services
 * 
 * Copyright 2025 Autonomy Association International Inc., all rights reserved
 * Safeguard patent license from National Aeronautics and Space Administration (NASA)
 * Copyright 2025 NASA, all rights reserved
 */

import express from 'express';
import cors from 'cors';
import path from 'path';
import fs from 'fs';
import { v4 as uuidv4 } from 'uuid';
import { WebApp } from 'meteor/webapp';

/**
 * Well-Known Discovery Service
 * Implements the .well-known design pattern for service discovery
 */
export class WellKnownDiscoveryService {
  /**
   * Create a new Well-Known Discovery Service
   * @param {Object} options - Configuration options
   * @param {Object} options.protocols - Protocol references
   * @param {Object} options.pluginManager - Plugin manager reference
   * @param {String} options.baseUrl - Base URL for .well-known endpoints (default: '/.well-known')
   */
  constructor(options = {}) {
    this.options = options;
    this.baseUrl = options.baseUrl || '/.well-known';
    this.protocols = options.protocols || {};
    this.pluginManager = options.pluginManager;
    
    // Router for all .well-known endpoints
    this.router = express.Router();
    
    // Service info cache
    this.serviceInfo = {
      serverInfo: null,
      lastUpdated: null,
      id: uuidv4()
    };
    
    // Initialize
    this.initialize();
  }
  
  /**
   * Initialize the service and set up routes
   */
  initialize() {
    // Apply middleware
    this.router.use(cors());
    this.router.use(express.json());
    
    // Set up routes
    this._setupRoutes();
    
    // Mount router at base URL
    WebApp.connectHandlers.use(this.baseUrl, this.router);
    
    console.log(`Well-Known Discovery Service initialized at ${this.baseUrl}`);
  }
  
  /**
   * Set up all discovery routes
   * @private
   */
  _setupRoutes() {
    // Root discovery endpoint
    this.router.get('/', (req, res) => {
      this._updateServiceInfo();
      
      res.json({
        service: 'SAFEGUARD Discovery',
        version: '1.0.0',
        timestamp: new Date().toISOString(),
        availableEndpoints: [
          '/.well-known/server-info',
          '/.well-known/agent-to-agent',
          '/.well-known/mcp',
          '/.well-known/plugins',
          '/.well-known/protocols'
        ]
      });
    });
    
    // Server info endpoint
    this.router.get('/server-info', (req, res) => {
      this._updateServiceInfo();
      res.json(this.serviceInfo.serverInfo);
    });
    
    // Agent-to-Agent protocol discovery
    this.router.get('/agent-to-agent', (req, res) => {
      const a2aInfo = this._getAgentToAgentInfo();
      
      if (!a2aInfo) {
        return res.status(404).json({
          error: 'Agent-to-Agent protocol not available',
          status: 'not_available'
        });
      }
      
      res.json(a2aInfo);
    });
    
    // MCP discovery
    this.router.get('/mcp', (req, res) => {
      const mcpInfo = this._getMCPInfo();
      
      if (!mcpInfo) {
        return res.status(404).json({
          error: 'Model Context Protocol not available',
          status: 'not_available'
        });
      }
      
      res.json(mcpInfo);
    });
    
    // Plugins discovery
    this.router.get('/plugins', (req, res) => {
      const pluginsInfo = this._getPluginsInfo();
      
      res.json(pluginsInfo);
    });
    
    // Individual plugin discovery
    this.router.get('/plugins/:pluginName', (req, res) => {
      const pluginName = req.params.pluginName;
      const pluginInfo = this._getPluginInfo(pluginName);
      
      if (!pluginInfo) {
        return res.status(404).json({
          error: `Plugin ${pluginName} not found`,
          status: 'not_found'
        });
      }
      
      res.json(pluginInfo);
    });
    
    // All protocols discovery
    this.router.get('/protocols', (req, res) => {
      const protocolsInfo = this._getAllProtocolsInfo();
      
      res.json(protocolsInfo);
    });
    
    // Static .well-known files (serve from /private/.well-known if exists)
    const wellKnownDir = path.join(process.cwd(), 'private', '.well-known');
    if (fs.existsSync(wellKnownDir)) {
      this.router.use('/static', express.static(wellKnownDir));
    }
    
    console.log('Well-Known Discovery Service routes configured');
  }
  
  /**
   * Update service information cache
   * @private
   */
  _updateServiceInfo() {
    // Only update every 60 seconds
    const now = Date.now();
    if (this.serviceInfo.lastUpdated && now - this.serviceInfo.lastUpdated < 60000) {
      return;
    }
    
    // Get server information
    this.serviceInfo.serverInfo = {
      id: this.serviceInfo.id,
      timestamp: new Date().toISOString(),
      serverName: process.env.SERVER_NAME || 'SAFEGUARD',
      version: process.env.VERSION || '1.0.0',
      protocols: {
        agentToAgent: this.protocols.agentToAgent ? true : false,
        modelContext: this.protocols.modelContext ? true : false,
        messageCommunication: this.protocols.messageCommunication ? true : false,
        httpJsonRpc: this.protocols.httpJsonRpc ? true : false
      },
      plugins: this.pluginManager ? this.pluginManager.getPlugins().length : 0,
      endpoints: {
        agentToAgent: '/.well-known/agent-to-agent',
        mcp: '/.well-known/mcp',
        plugins: '/.well-known/plugins',
        protocols: '/.well-known/protocols'
      }
    };
    
    this.serviceInfo.lastUpdated = now;
    return this.serviceInfo.serverInfo;
  }
  
  /**
   * Get Agent-to-Agent protocol information
   * @private
   * @returns {Object|null} Agent-to-Agent protocol info or null if not available
   */
  _getAgentToAgentInfo() {
    const a2a = this.protocols.agentToAgent;
    
    if (!a2a) {
      return null;
    }
    
    return {
      protocol: 'Agent-to-Agent',
      version: '1.0.0',
      status: 'available',
      wsPath: a2a.config?.wsPath || '/a2a',
      securityLevel: a2a.config?.securityLevel || 'AUTHENTICATED',
      endpoints: {
        websocket: a2a.config?.wsPath || '/a2a',
        register: '/api/node/register',
        discover: '/api/node/discover',
        ping: '/api/node/ping'
      },
      documentation: '/docs/protocols/agent_to_agent_communication_protocol.html'
    };
  }
  
  /**
   * Get Model Context Protocol information
   * @private
   * @returns {Object|null} MCP info or null if not available
   */
  _getMCPInfo() {
    const mcp = this.protocols.modelContext;
    
    if (!mcp) {
      return null;
    }
    
    return {
      protocol: 'Model Context Protocol',
      version: '1.0.0',
      status: 'available',
      httpEnabled: mcp.config?.httpEnabled || true,
      socketIOEnabled: mcp.config?.socketIOEnabled || true,
      wsEnabled: mcp.config?.wsEnabled || true,
      arrowEnabled: mcp.config?.arrowEnabled || false,
      endpoints: {
        http: mcp.config?.httpPath || '/mcp',
        socketIO: mcp.config?.socketIOPath || '/mcp/socket.io',
        websocket: mcp.config?.wsPath || '/mcp/ws',
        arrow: mcp.config?.arrowEnabled ? (mcp.config?.arrowPath || '/mcp/arrow') : null
      },
      modelTypes: Object.keys(mcp.models || {}),
      documentation: '/docs/protocols/mcp.html'
    };
  }
  
  /**
   * Get all plugins information
   * @private
   * @returns {Object} Plugins info
   */
  _getPluginsInfo() {
    if (!this.pluginManager) {
      return {
        status: 'unavailable',
        message: 'Plugin system not available'
      };
    }
    
    const plugins = this.pluginManager.getPlugins();
    
    return {
      count: plugins.length,
      status: 'available',
      plugins: plugins.map(plugin => ({
        name: plugin.name,
        version: plugin.version,
        status: plugin.status,
        url: `/.well-known/plugins/${plugin.name}`
      }))
    };
  }
  
  /**
   * Get specific plugin information
   * @private
   * @param {String} pluginName - Plugin name
   * @returns {Object|null} Plugin info or null if not found
   */
  _getPluginInfo(pluginName) {
    if (!this.pluginManager) {
      return null;
    }
    
    const plugin = this.pluginManager.getPluginInfo(pluginName);
    
    if (!plugin) {
      return null;
    }
    
    return {
      name: plugin.name,
      version: plugin.version,
      description: plugin.description,
      author: plugin.author,
      status: plugin.status,
      capabilities: plugin.capabilities || [],
      contract: plugin.contract,
      endpoints: plugin.endpoints || [],
      apiRoot: plugin.apiRoot || `/plugin/${plugin.name}`
    };
  }
  
  /**
   * Get information about all available protocols
   * @private
   * @returns {Object} All protocols info
   */
  _getAllProtocolsInfo() {
    const result = {
      timestamp: new Date().toISOString(),
      protocols: []
    };
    
    // Agent-to-Agent Protocol
    if (this.protocols.agentToAgent) {
      result.protocols.push({
        name: 'Agent-to-Agent',
        status: 'available',
        url: '/.well-known/agent-to-agent'
      });
    }
    
    // Model Context Protocol
    if (this.protocols.modelContext) {
      result.protocols.push({
        name: 'Model Context Protocol',
        status: 'available',
        url: '/.well-known/mcp'
      });
    }
    
    // Message Communication Protocol
    if (this.protocols.messageCommunication) {
      result.protocols.push({
        name: 'Message Communication Protocol',
        status: 'available',
        endpoints: {
          http: this.protocols.messageCommunication.config?.httpPath || '/mcp',
          socketIO: this.protocols.messageCommunication.config?.socketIOPath || '/mcp/socket.io',
          amqp: this.protocols.messageCommunication.config?.amqpEnabled ? this.protocols.messageCommunication.config?.amqpUrl : null,
          mqtt: this.protocols.messageCommunication.config?.mqttEnabled ? this.protocols.messageCommunication.config?.mqttUrl : null,
          kafka: this.protocols.messageCommunication.config?.kafkaEnabled ? this.protocols.messageCommunication.config?.kafkaBrokers : null
        }
      });
    }
    
    // HTTP JSON-RPC Server
    if (this.protocols.httpJsonRpc) {
      result.protocols.push({
        name: 'HTTP JSON-RPC',
        status: 'available',
        endpoints: {
          http: this.protocols.httpJsonRpc.config?.path || '/jsonrpc',
          websocket: this.protocols.httpJsonRpc.config?.enableWebsocket ? this.protocols.httpJsonRpc.config?.path : null
        },
        port: this.protocols.httpJsonRpc.config?.port || 8545,
        host: this.protocols.httpJsonRpc.config?.host || 'localhost'
      });
    }
    
    return result;
  }
  
  /**
   * Register a custom discovery endpoint
   * @param {String} path - URL path (will be prefixed with baseUrl)
   * @param {Function} handler - Express route handler function
   */
  registerCustomEndpoint(path, handler) {
    if (!path || typeof handler !== 'function') {
      console.error('Invalid custom endpoint registration');
      return;
    }
    
    // Register the route handler
    this.router.get(path, handler);
    console.log(`Registered custom discovery endpoint: ${this.baseUrl}${path}`);
  }
}
```


```javascript
/**
 * @fileoverview Main server entry point for IASMS
 * This file initializes all protocols and systems and provides references to their implementations
 * 
 * Copyright 2025 Autonomy Association International Inc., all rights reserved
 * Safeguard patent license from National Aeronautics and Space Administration (NASA)
 * Copyright 2025 NASA, all rights reserved
 */

import { Meteor } from 'meteor/meteor';
import { WebApp } from 'meteor/webapp';
import { MongoInternals } from 'meteor/mongo';

// Database collections
import { 
  VehiclePositions, 
  Trajectories, 
  GeofenceZones, 
  Beacons, 
  Plugins, 
  PluginContracts,
  IasmsMcpContexts,
  IasmsMcpMessages,
  IasmsMcpModels,
  IasmsMcpKnowledgeBases
} from './collections.js';

// Core protocol implementations
import { ModelContextProtocol } from './protocols/ModelContextProtocol.js';
import { MessageCommunicationProtocol } from './protocols/MessageCommunicationProtocol.js';
import { AgentToAgentProtocol } from './protocols/AgentToAgentCommunicationProtocol.js';
import { HttpJsonRpcServer } from './protocols/HttpJsonRpcServer.js';
import { IasmsMCP } from './protocols/IasmsMessageCommunicationProtocol.js';

// Plugin system
import { PluginManager } from '../private/plugin/core/PluginManager.js';
import { PluginLoader } from '../private/plugin/core/PluginLoader.js';
import { PluginContractManager } from '../private/plugin/core/PluginContractManager.js';

// Services
import { IAMSIntegrationAPI } from './services/IAMSIntegrationAPI.js';
import { OAuth2Server } from './services/OAuth2Server.js';
import { SafeguardServer } from './services/SafeguardServer.js';
import { WellKnownDiscoveryService } from './services/WellKnownDiscoveryService.js';

// Configuration
const config = {
  protocols: {
    modelContext: {
      httpEnabled: true,
      socketIOEnabled: true,
      wsEnabled: true,
      arrowEnabled: true,
      httpPath: '/mcp',
      socketIOPath: '/mcp/socket.io',
      wsPath: '/mcp/ws',
      arrowPath: '/mcp/arrow',
      modelSyncInterval: 5000,
      requireAuth: true,
      autoStart: true
    },
    messageCommunication: {
      httpEnabled: true,
      socketIOEnabled: true,
      amqpEnabled: Meteor.settings.protocols?.mcp?.amqpEnabled || false,
      mqttEnabled: Meteor.settings.protocols?.mcp?.mqttEnabled || false,
      kafkaEnabled: Meteor.settings.protocols?.mcp?.kafkaEnabled || false,
      httpPath: '/mcp',
      socketIOPath: '/mcp/socket.io',
      amqpUrl: Meteor.settings.protocols?.mcp?.amqpUrl || 'amqp://localhost',
      mqttUrl: Meteor.settings.protocols?.mcp?.mqttUrl || 'mqtt://localhost',
      kafkaBrokers: Meteor.settings.protocols?.mcp?.kafkaBrokers || ['localhost:9092'],
      topicPrefix: 'autonomy',
      requireAuth: true,
      autoStart: true
    },
    agentToAgent: {
      wsPath: '/a2a',
      port: null,
      discoveryInterval: 10000,
      heartbeatInterval: 5000,
      securityLevel: 'AUTHENTICATED',
      encryptionKey: Meteor.settings.protocols?.a2a?.encryptionKey || null,
      autoStart: true
    },
    iasmsMcp: {
      defaultModel: 'gpt-4',
      maxMessagesPerContext: 100,
      maxContextAgeHours: 24,
      defaultTemperature: 0.7,
      defaultMaxTokens: 1000,
      enableKnowledgeRetrieval: true,
      defaultRetrievalTopK: 5
    },
    httpJsonRpc: {
      port: Meteor.settings.protocols?.jsonrpc?.port || 8545,
      host: Meteor.settings.protocols?.jsonrpc?.host || 'localhost',
      path: Meteor.settings.protocols?.jsonrpc?.path || '/jsonrpc',
      enableHttp2: true,
      enableWebsocket: true,
      maxBatchSize: 50,
      requireAuth: true
    }
  },
  plugin: {
    pluginsDir: Meteor.settings.plugins?.dir || '/private/plugin/modules',
    fallbackDir: Meteor.settings.plugins?.fallbackDir || '/modules',
    dbCollection: 'plugins',
    mongoUrl: process.env.MONGO_URL || Meteor.settings.mongodb?.url || 'mongodb://localhost:27017/meteor'
  },
  services: {
    oauth2: {
      path: '/oauth2',
      requireHttps: true
    },
    integration: {
      port: Meteor.settings.services?.integration?.port || 4000,
      jwtSecret: Meteor.settings.services?.integration?.jwtSecret || 'iams-jwt-secret'
    },
    discovery: {
      baseUrl: '/.well-known',
      enablePluginDiscovery: true,
      enableStaticResources: true
    }
  }
};

// Protocol instances
let modelContextProtocol;
let messageCommunicationProtocol;
let agentToAgentProtocol;
let httpJsonRpcServer;
let iasmsMcp;

// Plugin system instances
let pluginContractManager;
let pluginLoader;
let pluginManager;

// Service instances
let iamsIntegrationAPI;
let oauth2Server;
let safeguardServer;
let wellKnownDiscoveryService;

// Database connection
const db = MongoInternals.defaultRemoteCollectionDriver().mongo.db;

Meteor.startup(async function() {
  console.log('Initializing IASMS server...');

  try {
    // Initialize protocol implementations
    console.log('Initializing protocols...');
    
    // Model Context Protocol
    modelContextProtocol = new ModelContextProtocol(config.protocols.modelContext);
    
    // Message Communication Protocol
    messageCommunicationProtocol = new MessageCommunicationProtocol(config.protocols.messageCommunication);
    
    // Agent-to-Agent Protocol
    agentToAgentProtocol = new AgentToAgentProtocol(config.protocols.agentToAgent);
    
    // HTTP/2 JSON-RPC Server
    httpJsonRpcServer = new HttpJsonRpcServer(config.protocols.httpJsonRpc);
    await httpJsonRpcServer.start();
    
    // IASMS Message Communication Protocol
    iasmsMcp = new IasmsMCP(config.protocols.iasmsMcp);
    await iasmsMcp.initialize();
    
    console.log('Protocols initialized successfully');

    // Initialize plugin system
    console.log('Initializing plugin system...');
    
    // Plugin Contract Manager
    pluginContractManager = new PluginContractManager({
      db: db,
      collection: 'pluginContracts'
    });
    
    // Plugin Loader
    pluginLoader = new PluginLoader({
      pluginsDir: config.plugin.pluginsDir,
      fallbackDir: config.plugin.fallbackDir,
      dbCollection: config.plugin.dbCollection,
      mongoUrl: config.plugin.mongoUrl,
      db: db
    });
    
    // Plugin Manager
    pluginManager = new PluginManager({
      contractManager: pluginContractManager,
      pluginLoader: pluginLoader,
      db: db
    });
    
    // Initialize plugin manager
    await pluginManager.initialize();
    
    console.log('Plugin system initialized successfully');

    // Initialize services
    console.log('Initializing services...');
    
    // IAMS Integration API
    iamsIntegrationAPI = new IAMSIntegrationAPI({
      db: db,
      port: config.services.integration.port,
      jwtSecret: config.services.integration.jwtSecret
    });
    await iamsIntegrationAPI.initialize();
    
    // OAuth2 Server
    oauth2Server = new OAuth2Server(config.services.oauth2);
    
    // Safeguard Server
    safeguardServer = new SafeguardServer({
      modelContextProtocol,
      messageCommunicationProtocol,
      agentToAgentProtocol
    });
    
    // Well-Known Discovery Service - Initialize after all other services
    wellKnownDiscoveryService = new WellKnownDiscoveryService({
      baseUrl: config.services.discovery.baseUrl,
      protocols: {
        modelContext: modelContextProtocol,
        messageCommunication: messageCommunicationProtocol,
        agentToAgent: agentToAgentProtocol,
        httpJsonRpc: httpJsonRpcServer
      },
      pluginManager: pluginManager
    });
    
    console.log('Services initialized successfully');

    // Register RPC methods
    registerRpcMethods();

    // Set up short URLs for common discovery endpoints
    setupShortDiscoveryUrls();

    console.log('IASMS server initialized successfully');
  } catch (error) {
    console.error('Error initializing IASMS server:', error);
  }
});

/**
 * Set up short URLs for common discovery endpoints
 * These redirect to the full .well-known URLs
 */
function setupShortDiscoveryUrls() {
  // Create router for short URLs
  const express = require('express');
  const router = express.Router();
  
  // Short URLs for common discovery endpoints
  router.get('/discovery', (req, res) => {
    res.redirect('/.well-known');
  });
  
  router.get('/a2a-discovery', (req, res) => {
    res.redirect('/.well-known/agent-to-agent');
  });
  
  router.get('/mcp-discovery', (req, res) => {
    res.redirect('/.well-known/mcp');
  });
  
  router.get('/plugins-discovery', (req, res) => {
    res.redirect('/.well-known/plugins');
  });
  
  // Mount router
  WebApp.connectHandlers.use(router);
  
  console.log('Short discovery URLs configured');
}

/**
 * Register RPC methods for HTTP/2 JSON-RPC Server
 */
function registerRpcMethods() {
  // Model Context Protocol methods
  httpJsonRpcServer.registerMethod('mcp.getModels', async (params) => {
    const { type } = params;
    return modelContextProtocol.getModels(type);
  });
  
  httpJsonRpcServer.registerMethod('mcp.getModel', async (params) => {
    const { type, id } = params;
    return modelContextProtocol.getModel(type, id);
  });
  
  httpJsonRpcServer.registerMethod('mcp.updateModel', async (params) => {
    const { type, id, model } = params;
    return modelContextProtocol.updateModel(type, id, model);
  });
  
  httpJsonRpcServer.registerMethod('mcp.removeModel', async (params) => {
    const { type, id } = params;
    return modelContextProtocol.removeModel(type, id);
  });
  
  // IASMS MCP methods
  httpJsonRpcServer.registerMethod('iasms.mcp.createContext', async (params) => {
    return iasmsMcp.createContext(params);
  });
  
  httpJsonRpcServer.registerMethod('iasms.mcp.getContext', async (params) => {
    return iasmsMcp.getContext(params.contextId);
  });
  
  httpJsonRpcServer.registerMethod('iasms.mcp.updateContext', async (params) => {
    return iasmsMcp.updateContext(params.contextId, params.updates);
  });
  
  httpJsonRpcServer.registerMethod('iasms.mcp.sendMessage', async (params) => {
    return iasmsMcp.sendMessage(params);
  });
  
  httpJsonRpcServer.registerMethod('iasms.mcp.getModels', async () => {
    return Array.from(iasmsMcp.models.values());
  });
  
  httpJsonRpcServer.registerMethod('iasms.mcp.getKnowledgeBases', async () => {
    return Array.from(iasmsMcp.knowledgeBases.values());
  });
  
  // Plugin system methods
  httpJsonRpcServer.registerMethod('plugin.getPlugins', async () => {
    return pluginManager.getPlugins();
  });
  
  httpJsonRpcServer.registerMethod('plugin.loadPlugin', async (params) => {
    return pluginManager.loadPlugin(params.pluginInfo);
  });
  
  httpJsonRpcServer.registerMethod('plugin.unloadPlugin', async (params) => {
    return pluginManager.unloadPlugin(params.pluginName);
  });
  
  httpJsonRpcServer.registerMethod('plugin.executeMethod', async (params) => {
    return pluginManager.executePluginMethod(
      params.pluginName,
      params.methodName,
      params.args
    );
  });
  
  // Discovery service methods
  httpJsonRpcServer.registerMethod('discovery.getServerInfo', async () => {
    return wellKnownDiscoveryService._updateServiceInfo();
  });
  
  httpJsonRpcServer.registerMethod('discovery.getProtocols', async () => {
    return wellKnownDiscoveryService._getAllProtocolsInfo();
  });
  
  httpJsonRpcServer.registerMethod('discovery.getPlugins', async () => {
    return wellKnownDiscoveryService._getPluginsInfo();
  });
  
  console.log('RPC methods registered successfully');
}

// Export key components for use in other server modules
export {
  modelContextProtocol,
  messageCommunicationProtocol,
  agentToAgentProtocol,
  httpJsonRpcServer,
  iasmsMcp,
  pluginContractManager,
  pluginLoader,
  pluginManager,
  iamsIntegrationAPI,
  oauth2Server,
  safeguardServer,
  wellKnownDiscoveryService,
  VehiclePositions,
  Trajectories,
  GeofenceZones,
  Beacons,
  Plugins,
  PluginContracts,
  IasmsMcpContexts,
  IasmsMcpMessages,
  IasmsMcpModels,
  IasmsMcpKnowledgeBases
};
```


Now let's add a file to expose a method for plugins to register their own .well-known discovery endpoints:

```javascript
/**
 * @fileoverview Helper utility for plugins to register discovery endpoints
 * 
 * Copyright 2025 Autonomy Association International Inc., all rights reserved
 * Safeguard patent license from National Aeronautics and Space Administration (NASA)
 * Copyright 2025 NASA, all rights reserved
 */

import { wellKnownDiscoveryService } from '../main.js';

/**
 * Registers a plugin's discovery endpoint with the .well-known service
 * 
 * @param {string} pluginName - Name of the plugin
 * @param {string} endpointPath - Path for the endpoint (will be added after /.well-known/plugins/{pluginName}/)
 * @param {function} handler - Express route handler function
 * @returns {boolean} - Success status
 */
export function registerPluginDiscoveryEndpoint(pluginName, endpointPath, handler) {
  if (!wellKnownDiscoveryService) {
    console.error('Well-Known Discovery Service not available');
    return false;
  }

  if (!pluginName || !endpointPath || typeof handler !== 'function') {
    console.error('Invalid parameters for registering plugin discovery endpoint');
    return false;
  }

  try {
    // Create the full path
    const fullPath = `/plugins/${pluginName}/${endpointPath}`.replace(/\/+/g, '/');
    
    // Register the endpoint
    wellKnownDiscoveryService.registerCustomEndpoint(fullPath, handler);
    
    console.log(`Registered discovery endpoint for plugin ${pluginName}: ${fullPath}`);
    return true;
  } catch (error) {
    console.error(`Error registering discovery endpoint for plugin ${pluginName}:`, error);
    return false;
  }
}

/**
 * Registers a plugin's capabilities for discovery
 * 
 * @param {string} pluginName - Name of the plugin
 * @param {Object} capabilities - Object describing plugin capabilities
 * @returns {boolean} - Success status
 */
export function registerPluginCapabilities(pluginName, capabilities) {
  if (!wellKnownDiscoveryService) {
    console.error('Well-Known Discovery Service not available');
    return false;
  }

  if (!pluginName || !capabilities) {
    console.error('Invalid parameters for registering plugin capabilities');
    return false;
  }

  try {
    // Create endpoint path
    const path = `/plugins/${pluginName}/capabilities`;
    
    // Register the endpoint
    wellKnownDiscoveryService.registerCustomEndpoint(path, (req, res) => {
      res.json({
        pluginName,
        capabilities,
        timestamp: new Date().toISOString()
      });
    });
    
    console.log(`Registered capabilities endpoint for plugin ${pluginName}`);
    return true;
  } catch (error) {
    console.error(`Error registering capabilities for plugin ${pluginName}:`, error);
    return false;
  }
}
```


## Implementation Details and Organization

This implementation creates a comprehensive `.well-known` discovery service for the SAFEGUARD platform. Here's a breakdown of the changes:

1. **Server Structure**:
    - The WellKnownDiscoveryService is placed in `server/services/` directory along with other services
    - Helper utilities for plugins are placed in `server/utils/`
    - All routes are properly mounted at the `/.well-known/` path

2. **Well-Known Routes**:
    - `/.well-known/` - Main discovery endpoint listing all available services
    - `/.well-known/server-info` - Server capabilities and information
    - `/.well-known/agent-to-agent` - Agent-to-Agent protocol details
    - `/.well-known/mcp` - Model Context Protocol details
    - `/.well-known/plugins` - Available plugins list
    - `/.well-known/plugins/{pluginName}` - Specific plugin details
    - `/.well-known/protocols` - All available protocols

3. **Short URL Redirects**:
    - `/discovery` → `/.well-known/`
    - `/a2a-discovery` → `/.well-known/agent-to-agent`
    - `/mcp-discovery` → `/.well-known/mcp`
    - `/plugins-discovery` → `/.well-known/plugins`

4. **Plugin Integration**:
    - Plugins can register their own discovery endpoints
    - Plugins can publish their capabilities through the discovery service
    - Support for static .well-known files from `/private/.well-known/`

5. **JSON-RPC Methods**:
    - Added methods to query discovery information programmatically
    - Accessible through the HTTP/2 JSON-RPC server

This implementation provides a robust, future-proof solution for service discovery in the SAFEGUARD platform. It follows the `.well-known` URL standard, which is widely recognized for service discovery across systems, and enables all modules and plugins to publish their capabilities in a standardized way.

The service is integrated directly into the main server startup sequence and correctly accesses all relevant protocol and plugin systems.