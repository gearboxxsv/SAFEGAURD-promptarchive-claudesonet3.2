Let's complete the server-side implementation by creating the necessary Meteor publications, methods, and routes to provide data to our React application.

First, let's create the publications for the simulation data:

```javascript
/**
 * /server/IasmsSimulationPublications.js
 * 
 * Publications for IASMS Simulation
 * Provides data subscriptions for simulation components
 * 
 * Copyright 2025 Autonomy Association International Inc., all rights reserved 
 * Safeguard patent license from National Aeronautics and Space Administration (NASA)
 * Copyright 2025 NASA, all rights reserved
 */

import { Meteor } from 'meteor/meteor';
import { check, Match } from 'meteor/check';

// Import collections from the simulation module
import { 
  IasmsSimulationScenarios, 
  IasmsSimulationSessions, 
  IasmsTrainingRecords 
} from './iasms/modules/IasmsSimulationTrainingModule';

// Import collections from core IASMS
import { IasmsVehicleStates, IasmsHazards, IasmsRisks } from './iasms/IAsmsCoreService';

Meteor.startup(() => {
  /**
   * Publish available simulation scenarios
   */
  Meteor.publish('iasms.simulationScenarios', function() {
    // Only publish scenarios for authenticated users
    if (!this.userId) {
      return this.ready();
    }
    
    // Return all scenarios
    return IasmsSimulationScenarios.find({});
  });
  
  /**
   * Publish active simulation sessions
   */
  Meteor.publish('iasms.activeSimulationSessions', function() {
    // Only publish sessions for authenticated users
    if (!this.userId) {
      return this.ready();
    }
    
    // Get user's role
    const user = Meteor.users.findOne(this.userId);
    const isAdmin = user && user.roles && (user.roles.includes('admin') || user.roles.includes('trainer'));
    
    if (isAdmin) {
      // Admins and trainers can see all active sessions
      return IasmsSimulationSessions.find({
        status: { $in: ['ACTIVE', 'PAUSED'] }
      });
    } else {
      // Regular users can only see their own sessions
      return IasmsSimulationSessions.find({
        userId: this.userId,
        status: { $in: ['ACTIVE', 'PAUSED'] }
      });
    }
  });
  
  /**
   * Publish a specific simulation session
   */
  Meteor.publish('iasms.simulationSession', function(sessionId) {
    check(sessionId, String);
    
    // Only publish for authenticated users
    if (!this.userId) {
      return this.ready();
    }
    
    // Get user's role
    const user = Meteor.users.findOne(this.userId);
    const isAdmin = user && user.roles && (user.roles.includes('admin') || user.roles.includes('trainer'));
    
    if (isAdmin) {
      // Admins and trainers can see any session
      return IasmsSimulationSessions.find({ _id: sessionId });
    } else {
      // Regular users can only see their own sessions
      return IasmsSimulationSessions.find({
        _id: sessionId,
        userId: this.userId
      });
    }
  });
  
  /**
   * Publish user's training records
   */
  Meteor.publish('iasms.trainingRecords', function() {
    // Only publish for authenticated users
    if (!this.userId) {
      return this.ready();
    }
    
    // Get user's role
    const user = Meteor.users.findOne(this.userId);
    const isAdmin = user && user.roles && (user.roles.includes('admin') || user.roles.includes('trainer'));
    
    if (isAdmin) {
      // Admins and trainers can see all records
      return IasmsTrainingRecords.find({});
    } else {
      // Regular users can only see their own records
      return IasmsTrainingRecords.find({ userId: this.userId });
    }
  });
  
  /**
   * Publish active vehicles (limit to recent states)
   */
  Meteor.publish('iasms.activeVehicles', function() {
    // Only publish for authenticated users
    if (!this.userId) {
      return this.ready();
    }
    
    const recentThreshold = new Date(Date.now() - 60000); // Last minute
    
    return IasmsVehicleStates.find({
      timestamp: { $gte: recentThreshold }
    });
  });
  
  /**
   * Publish active hazards
   */
  Meteor.publish('iasms.activeHazards', function() {
    // Only publish for authenticated users
    if (!this.userId) {
      return this.ready();
    }
    
    return IasmsHazards.find({
      expiryTime: { $gt: new Date() }
    });
  });
  
  /**
   * Publish risks for a specific vehicle
   */
  Meteor.publish('iasms.vehicleRisks', function(vehicleId) {
    check(vehicleId, Match.Maybe(String));
    
    // Only publish for authenticated users
    if (!this.userId) {
      return this.ready();
    }
    
    // If no vehicle ID, return empty
    if (!vehicleId) {
      return this.ready();
    }
    
    return IasmsRisks.find({ vehicleId });
  });
  
  /**
   * Publish additional user data
   */
  Meteor.publish('userData', function() {
    if (!this.userId) {
      return this.ready();
    }
    
    return Meteor.users.find(this.userId, {
      fields: {
        'roles': 1,
        'profile': 1,
        'settings.iasms': 1
      }
    });
  });
});
```


Now, let's create the methods for the simulation module:

```javascript
/**
 * /server/IasmsSimulationMethods.js
 * 
 * Methods for IASMS Simulation
 * Provides RPC methods for simulation components
 * 
 * Copyright 2025 Autonomy Association International Inc., all rights reserved 
 * Safeguard patent license from National Aeronautics and Space Administration (NASA)
 * Copyright 2025 NASA, all rights reserved
 */

import { Meteor } from 'meteor/meteor';
import { check, Match } from 'meteor/check';

// Import collections from core IASMS
import { IasmsVehicleStates, IasmsHazards, IasmsRisks } from './iasms/IAsmsCoreService';

Meteor.methods({
  /**
   * Get simulation session by ID
   * @param {string} sessionId - Session ID
   * @returns {Object} Session data
   */
  'iasms.getSimulationSession': function(sessionId) {
    check(sessionId, String);
    
    // Only available for authenticated users
    if (!this.userId) {
      throw new Meteor.Error('not-authorized', 'You must be logged in to get session data');
    }
    
    // Get user's role
    const user = Meteor.users.findOne(this.userId);
    const isAdmin = user && user.roles && (user.roles.includes('admin') || user.roles.includes('trainer'));
    
    // Get the session
    const session = IasmsSimulationSessions.findOne(sessionId);
    
    if (!session) {
      throw new Meteor.Error('not-found', 'Session not found');
    }
    
    // Check permissions
    if (!isAdmin && session.userId !== this.userId) {
      throw new Meteor.Error('not-authorized', 'You do not have permission to access this session');
    }
    
    return session;
  },
  
  /**
   * Get recent vehicle state
   * @param {string} vehicleId - Vehicle ID
   * @returns {Object} Vehicle state
   */
  'iasms.getVehicleState': function(vehicleId) {
    check(vehicleId, String);
    
    // Only available for authenticated users
    if (!this.userId) {
      throw new Meteor.Error('not-authorized', 'You must be logged in to get vehicle data');
    }
    
    // Get most recent state for the vehicle
    return IasmsVehicleStates.findOne(
      { vehicleId },
      { sort: { timestamp: -1 } }
    );
  },
  
  /**
   * Get hazard by ID
   * @param {string} hazardId - Hazard ID
   * @returns {Object} Hazard data
   */
  'iasms.getHazard': function(hazardId) {
    check(hazardId, String);
    
    // Only available for authenticated users
    if (!this.userId) {
      throw new Meteor.Error('not-authorized', 'You must be logged in to get hazard data');
    }
    
    return IasmsHazards.findOne(hazardId);
  },
  
  /**
   * Get risks for a vehicle
   * @param {string} vehicleId - Vehicle ID
   * @returns {Array} Risk assessments
   */
  'iasms.getVehicleRisks': function(vehicleId) {
    check(vehicleId, String);
    
    // Only available for authenticated users
    if (!this.userId) {
      throw new Meteor.Error('not-authorized', 'You must be logged in to get risk data');
    }
    
    return IasmsRisks.find(
      { vehicleId },
      { sort: { riskLevel: -1 } }
    ).fetch();
  },
  
  /**
   * Get statistics for dashboard
   * @returns {Object} System statistics
   */
  'iasms.getSystemStats': function() {
    // Only available for authenticated users
    if (!this.userId) {
      throw new Meteor.Error('not-authorized', 'You must be logged in to get system statistics');
    }
    
    const now = new Date();
    const recentThreshold = new Date(now.getTime() - 60000); // Last minute
    
    // Count active vehicles
    const activeVehicleCount = IasmsVehicleStates.find({
      timestamp: { $gte: recentThreshold }
    }).count();
    
    // Count active hazards
    const activeHazardCount = IasmsHazards.find({
      expiryTime: { $gt: now }
    }).count();
    
    // Count high risk assessments
    const highRiskCount = IasmsRisks.find({
      riskLevel: { $gte: 0.7 }, // High risk threshold
      timestamp: { $gte: recentThreshold }
    }).count();
    
    // Get active simulation sessions
    const activeSessionCount = IasmsSimulationSessions.find({
      status: { $in: ['ACTIVE', 'PAUSED'] }
    }).count();
    
    return {
      timestamp: now,
      activeVehicleCount,
      activeHazardCount,
      highRiskCount,
      activeSessionCount
    };
  },
  
  /**
   * Update user's IASMS settings
   * @param {Object} settings - User settings
   * @returns {boolean} Success
   */
  'iasms.updateUserSettings': function(settings) {
    check(settings, Object);
    
    // Only available for authenticated users
    if (!this.userId) {
      throw new Meteor.Error('not-authorized', 'You must be logged in to update settings');
    }
    
    // Update user settings
    Meteor.users.update(this.userId, {
      $set: {
        'settings.iasms': settings
      }
    });
    
    return true;
  }
});
```


Now, let's create WebApp routes to serve static assets for the simulation:

```javascript
/**
 * /server/IasmsStaticAssets.js
 * 
 * Static Assets for IASMS Simulation
 * Sets up static asset routes for simulation models and textures
 * 
 * Copyright 2025 Autonomy Association International Inc., all rights reserved 
 * Safeguard patent license from National Aeronautics and Space Administration (NASA)
 * Copyright 2025 NASA, all rights reserved
 */

import { Meteor } from 'meteor/meteor';
import { WebApp } from 'meteor/webapp';
import fs from 'fs';
import path from 'path';

Meteor.startup(() => {
  console.log('Setting up IASMS static asset routes...');
  
  // Directory for 3D models and textures
  const assetsDirectory = path.join(process.env.PWD, 'private', 'iasms-assets');
  
  // Check if directory exists
  if (!fs.existsSync(assetsDirectory)) {
    console.warn(`IASMS assets directory not found: ${assetsDirectory}`);
    return;
  }
  
  // Map of MIME types
  const mimeTypes = {
    '.gltf': 'model/gltf+json',
    '.glb': 'model/gltf-binary',
    '.png': 'image/png',
    '.jpg': 'image/jpeg',
    '.jpeg': 'image/jpeg',
    '.webp': 'image/webp',
    '.json': 'application/json',
    '.bin': 'application/octet-stream',
    '.draco': 'application/octet-stream',
    '.hdr': 'application/octet-stream'
  };
  
  // Set up route for serving 3D models and textures
  WebApp.connectHandlers.use('/assets', (req, res, next) => {
    // Extract file path from URL
    const urlPath = decodeURIComponent(req.url);
    
    if (!urlPath || urlPath === '/') {
      res.writeHead(403);
      res.end('Forbidden');
      return;
    }
    
    // Construct full file path
    const filePath = path.join(assetsDirectory, urlPath);
    
    // Security check to prevent directory traversal
    if (!filePath.startsWith(assetsDirectory)) {
      res.writeHead(403);
      res.end('Forbidden');
      return;
    }
    
    // Check if file exists
    if (!fs.existsSync(filePath) || !fs.statSync(filePath).isFile()) {
      res.writeHead(404);
      res.end('Not Found');
      return;
    }
    
    // Get file extension
    const ext = path.extname(filePath).toLowerCase();
    
    // Set content type
    const contentType = mimeTypes[ext] || 'application/octet-stream';
    res.setHeader('Content-Type', contentType);
    
    // Set cache control
    res.setHeader('Cache-Control', 'public, max-age=86400'); // 24 hours
    
    // Serve the file
    const fileStream = fs.createReadStream(filePath);
    fileStream.pipe(res);
  });
  
  // Set up route for Draco decoder
  WebApp.connectHandlers.use('/draco', (req, res, next) => {
    // Extract file path from URL
    const urlPath = decodeURIComponent(req.url);
    
    if (!urlPath || urlPath === '/') {
      res.writeHead(403);
      res.end('Forbidden');
      return;
    }
    
    // Construct full file path
    const dracoDirectory = path.join(process.env.PWD, 'private', 'draco');
    const filePath = path.join(dracoDirectory, urlPath);
    
    // Security check to prevent directory traversal
    if (!filePath.startsWith(dracoDirectory)) {
      res.writeHead(403);
      res.end('Forbidden');
      return;
    }
    
    // Check if file exists
    if (!fs.existsSync(filePath) || !fs.statSync(filePath).isFile()) {
      res.writeHead(404);
      res.end('Not Found');
      return;
    }
    
    // Get file extension
    const ext = path.extname(filePath).toLowerCase();
    
    // Set content type
    const contentType = mimeTypes[ext] || 'application/octet-stream';
    res.setHeader('Content-Type', contentType);
    
    // Set cache control
    res.setHeader('Cache-Control', 'public, max-age=2592000'); // 30 days
    
    // Serve the file
    const fileStream = fs.createReadStream(filePath);
    fileStream.pipe(res);
  });
  
  console.log('IASMS static asset routes configured successfully');
});
```


Now, let's create an API endpoint service for integrating with external systems:

```javascript
/**
 * /server/IasmsAPIEndpoints.js
 * 
 * API Endpoints for IASMS Simulation
 * Provides REST API for external systems
 * 
 * Copyright 2025 Autonomy Association International Inc., all rights reserved 
 * Safeguard patent license from National Aeronautics and Space Administration (NASA)
 * Copyright 2025 NASA, all rights reserved
 */

import { Meteor } from 'meteor/meteor';
import { WebApp } from 'meteor/webapp';
import { Accounts } from 'meteor/accounts-base';
import bodyParser from 'body-parser';

// Import collections from core IASMS
import { IasmsVehicleStates, IasmsHazards } from './iasms/IAsmsCoreService';

// Import simulation module
import { getSimulationModule } from './iasms/IasmsSimulationIntegration';

Meteor.startup(() => {
  console.log('Setting up IASMS API endpoints...');
  
  // Configure middleware
  WebApp.connectHandlers.use(bodyParser.json());
  
  // API base path
  const apiBasePath = '/api/iasms';
  
  // Authentication middleware
  const authenticate = (req, res, next) => {
    // Check for API key in header
    const apiKey = req.headers['x-api-key'];
    
    if (apiKey) {
      // Find user with this API key
      const user = Meteor.users.findOne({
        'services.api.key': apiKey
      });
      
      if (user) {
        req.userId = user._id;
        next();
        return;
      }
    }
    
    // Check for JWT token
    const token = req.headers['authorization'];
    
    if (token && token.startsWith('Bearer ')) {
      const jwtToken = token.substring(7);
      
      try {
        // Verify token
        const decoded = Accounts._hashLoginToken(jwtToken);
        const hashedToken = decoded;
        
        const user = Meteor.users.findOne({
          'services.resume.loginTokens.hashedToken': hashedToken
        });
        
        if (user) {
          req.userId = user._id;
          next();
          return;
        }
      } catch (error) {
        console.error('Token verification error:', error);
      }
    }
    
    // Authentication failed
    res.writeHead(401, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ 
      error: 'Unauthorized',
      message: 'Authentication required'
    }));
  };
  
  // Health check endpoint (no auth required)
  WebApp.connectHandlers.use(`${apiBasePath}/health`, (req, res) => {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ 
      status: 'ok',
      timestamp: new Date()
    }));
  });
  
  // Get active vehicles
  WebApp.connectHandlers.use(`${apiBasePath}/vehicles`, authenticate, (req, res) => {
    if (req.method !== 'GET') {
      res.writeHead(405, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ error: 'Method Not Allowed' }));
      return;
    }
    
    try {
      const recentThreshold = new Date(Date.now() - 60000); // Last minute
      
      // Get vehicle states
      const vehicleStates = IasmsVehicleStates.find(
        { timestamp: { $gte: recentThreshold } },
        { sort: { timestamp: -1 } }
      ).fetch();
      
      // Group by vehicle ID (keep most recent)
      const vehiclesMap = new Map();
      
      vehicleStates.forEach(state => {
        if (!vehiclesMap.has(state.vehicleId) || 
            vehiclesMap.get(state.vehicleId).timestamp < state.timestamp) {
          vehiclesMap.set(state.vehicleId, state);
        }
      });
      
      // Convert to array
      const vehicles = Array.from(vehiclesMap.values());
      
      res.writeHead(200, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ 
        vehicles,
        count: vehicles.length,
        timestamp: new Date()
      }));
    } catch (error) {
      console.error('Error in vehicles API:', error);
      res.writeHead(500, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ 
        error: 'Internal Server Error',
        message: error.message
      }));
    }
  });
  
  // Get active hazards
  WebApp.connectHandlers.use(`${apiBasePath}/hazards`, authenticate, (req, res) => {
    if (req.method !== 'GET') {
      res.writeHead(405, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ error: 'Method Not Allowed' }));
      return;
    }
    
    try {
      // Get hazards
      const hazards = IasmsHazards.find({
        expiryTime: { $gt: new Date() }
      }).fetch();
      
      res.writeHead(200, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ 
        hazards,
        count: hazards.length,
        timestamp: new Date()
      }));
    } catch (error) {
      console.error('Error in hazards API:', error);
      res.writeHead(500, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ 
        error: 'Internal Server Error',
        message: error.message
      }));
    }
  });
  
  // Create simulation session
  WebApp.connectHandlers.use(`${apiBasePath}/simulations`, authenticate, (req, res) => {
    if (req.method === 'POST') {
      try {
        const simulationModule = getSimulationModule();
        
        if (!simulationModule) {
          res.writeHead(503, { 'Content-Type': 'application/json' });
          res.end(JSON.stringify({ 
            error: 'Service Unavailable',
            message: 'Simulation module is not available'
          }));
          return;
        }
        
        // Get request body
        const { name, description, scenarioId, syncWithRealWorld, settings } = req.body;
        
        // Create session
        const sessionId = simulationModule.createSimulationSession({
          userId: req.userId,
          name: name || 'API-created Simulation',
          description: description || 'Created via API',
          scenarioId,
          syncWithRealWorld: !!syncWithRealWorld,
          settings: settings || {}
        });
        
        res.writeHead(201, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ 
          sessionId,
          message: 'Simulation session created successfully',
          timestamp: new Date()
        }));
      } catch (error) {
        console.error('Error creating simulation session:', error);
        res.writeHead(500, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ 
          error: 'Internal Server Error',
          message: error.message
        }));
      }
    } else if (req.method === 'GET') {
      try {
        // Get active sessions
        const sessions = IasmsSimulationSessions.find({
          status: { $in: ['ACTIVE', 'PAUSED'] }
        }).fetch();
        
        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ 
          sessions,
          count: sessions.length,
          timestamp: new Date()
        }));
      } catch (error) {
        console.error('Error getting simulation sessions:', error);
        res.writeHead(500, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ 
          error: 'Internal Server Error',
          message: error.message
        }));
      }
    } else {
      res.writeHead(405, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ error: 'Method Not Allowed' }));
    }
  });
  
  // Add entity to simulation
  WebApp.connectHandlers.use(`${apiBasePath}/simulations/:sessionId/entities`, authenticate, (req, res) => {
    if (req.method !== 'POST') {
      res.writeHead(405, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ error: 'Method Not Allowed' }));
      return;
    }
    
    try {
      const simulationModule = getSimulationModule();
      
      if (!simulationModule) {
        res.writeHead(503, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ 
          error: 'Service Unavailable',
          message: 'Simulation module is not available'
        }));
        return;
      }
      
      // Get session ID from URL
      const sessionId = req.params.sessionId;
      
      // Check if session exists and user has access
      const session = IasmsSimulationSessions.findOne(sessionId);
      
      if (!session) {
        res.writeHead(404, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ 
          error: 'Not Found',
          message: 'Simulation session not found'
        }));
        return;
      }
      
      // Check permissions
      if (session.userId !== req.userId) {
        // Check if user is admin
        const user = Meteor.users.findOne(req.userId);
        const isAdmin = user && user.roles && (user.roles.includes('admin') || user.roles.includes('trainer'));
        
        if (!isAdmin) {
          res.writeHead(403, { 'Content-Type': 'application/json' });
          res.end(JSON.stringify({ 
            error: 'Forbidden',
            message: 'You do not have permission to access this session'
          }));
          return;
        }
      }
      
      // Get entity data from request body
      const entity = req.body;
      
      // Add entity to simulation
      const entityId = simulationModule.addEntityToSimulation(sessionId, entity);
      
      res.writeHead(201, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ 
        entityId,
        message: 'Entity added successfully',
        timestamp: new Date()
      }));
    } catch (error) {
      console.error('Error adding entity to simulation:', error);
      res.writeHead(500, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ 
        error: 'Internal Server Error',
        message: error.message
      }));
    }
  });
  
  console.log('IASMS API endpoints configured successfully');
});
```


Now, let's create an index file to initialize all the server-side components:

```javascript
/**
 * /server/IasmsServerInit.js
 * 
 * IASMS Server Initialization
 * Initializes all IASMS server components
 * 
 * Copyright 2025 Autonomy Association International Inc., all rights reserved 
 * Safeguard patent license from National Aeronautics and Space Administration (NASA)
 * Copyright 2025 NASA, all rights reserved
 */

import { Meteor } from 'meteor/meteor';

// Import server files
import './IasmsSimulationPublications';
import './IasmsSimulationMethods';
import './IasmsStaticAssets';
import './IasmsAPIEndpoints';

// Import IASMS simulation integration
import './iasms/IasmsSimulationIntegration';

Meteor.startup(() => {
  console.log('IASMS Server Initialization complete');
});
```


Finally, let's update the main server startup file to include our IASMS server initialization:

```javascript
/**
 * /server/main.js
 * 
 * Main server entry point
 * 
 * Copyright 2025 Autonomy Association International Inc., all rights reserved 
 * Safeguard patent license from National Aeronautics and Space Administration (NASA)
 * Copyright 2025 NASA, all rights reserved
 */

import { Meteor } from 'meteor/meteor';
import './IasmsServerMain';
import './IasmsServerInit';

Meteor.startup(() => {
  console.log('Server started');
});
```


This completes the server-side implementation for our integration. Here's a summary of what we've created:

1. **Publications** (`IasmsSimulationPublications.js`): Provides data subscriptions for simulation scenarios, sessions, vehicles, hazards, and risks.

2. **Methods** (`IasmsSimulationMethods.js`): Implements RPC methods for fetching detailed information about simulation entities and system statistics.

3. **Static Assets** (`IasmsStaticAssets.js`): Sets up routes for serving 3D models, textures, and the Draco decoder for compressed models.

4. **API Endpoints** (`IasmsAPIEndpoints.js`): Implements REST API endpoints for external systems to integrate with the simulation platform.

5. **Server Initialization** (`IasmsServerInit.js`): Ties everything together and initializes all server components.

These files provide all the necessary server-side functionality to support our React application. The publications supply reactive data sources, the methods provide ways to fetch detailed information, and the static asset routes ensure that 3D models and textures are properly served. The API endpoints enable integration with external systems.

All of these components work together with the simulation module we created earlier to provide a complete integration between the 3D visualization capabilities and the existing IASMS system.


Let's complete the integration by adding a few more components that will ensure our system is fully functional and well-integrated with the existing IASMS system.

First, let's create a configuration file for the simulation module to make it more configurable:

```javascript
/**
 * /server/config/iasms-simulation-config.js
 * 
 * Configuration for IASMS Simulation
 * Contains configurable parameters for the simulation system
 * 
 * Copyright 2025 Autonomy Association International Inc., all rights reserved 
 * Safeguard patent license from National Aeronautics and Space Administration (NASA)
 * Copyright 2025 NASA, all rights reserved
 */

export const IasmsSimulationConfig = {
  // Synchronization settings
  sync: {
    enabled: true,
    interval: 1000, // ms
    batchSize: 50
  },
  
  // Performance settings
  performance: {
    maxEntitiesPerSession: 500,
    maxActiveSessions: 10,
    maxTelemetryAge: 3600000, // 1 hour
    cleanupInterval: 300000 // 5 minutes
  },
  
  // Model settings
  models: {
    defaultPath: '/assets/models/',
    cacheDuration: 3600000, // 1 hour
    compressionEnabled: true
  },
  
  // Default physics settings
  physics: {
    enabled: true,
    gravityX: 0,
    gravityY: -9.8,
    gravityZ: 0,
    timeStep: 1/60
  },
  
  // Default environment settings
  environment: {
    skyboxEnabled: true,
    ambientLightColor: 0xffffff,
    ambientLightIntensity: 0.5,
    sunLightColor: 0xffffff,
    sunLightIntensity: 1.0,
    fogEnabled: true,
    fogColor: 0x87ceeb,
    fogNear: 2000,
    fogFar: 10000
  },
  
  // Feature flags
  features: {
    xrEnabled: true,
    multimodalityEnabled: true,
    telemetryRecordingEnabled: true,
    hazardVisualizationEnabled: true,
    riskVisualizationEnabled: true
  },
  
  // Security settings
  security: {
    apiKeyRequired: true,
    jwtTokenEnabled: true,
    accessControlEnabled: true,
    rateLimitRequests: 100,
    rateLimitWindow: 60000 // 1 minute
  }
};
```


Now, let's create a logging module specific to our simulation functionality:

```javascript
/**
 * /server/utils/IasmsSimulationLogger.js
 * 
 * Logging Utility for IASMS Simulation
 * Provides consistent logging for simulation components
 * 
 * Copyright 2025 Autonomy Association International Inc., all rights reserved 
 * Safeguard patent license from National Aeronautics and Space Administration (NASA)
 * Copyright 2025 NASA, all rights reserved
 */

import { Meteor } from 'meteor/meteor';
import { IasmsSimulationConfig } from '../config/iasms-simulation-config';

// Create a custom logger for simulation components
export class IasmsSimulationLogger {
  constructor(module) {
    this.module = module;
    this.enabled = true;
    this.logToDatabase = true;
    this.logLevel = 'info'; // 'debug', 'info', 'warn', 'error'
    
    // Log levels
    this.levels = {
      debug: 0,
      info: 1,
      warn: 2,
      error: 3
    };
  }
  
  /**
   * Check if we should log at this level
   * @param {string} level - Log level
   * @returns {boolean} True if we should log
   * @private
   */
  _shouldLog(level) {
    if (!this.enabled) return false;
    return this.levels[level] >= this.levels[this.logLevel];
  }
  
  /**
   * Format a log message
   * @param {string} level - Log level
   * @param {string} message - Message to log
   * @param {Object} data - Additional data
   * @returns {string} Formatted message
   * @private
   */
  _formatMessage(level, message, data) {
    const timestamp = new Date().toISOString();
    let formattedMessage = `[${timestamp}] [${level.toUpperCase()}] [IASMS:${this.module}] ${message}`;
    
    if (data) {
      if (typeof data === 'object') {
        try {
          formattedMessage += ` ${JSON.stringify(data)}`;
        } catch (err) {
          formattedMessage += ` [Object could not be stringified]`;
        }
      } else {
        formattedMessage += ` ${data}`;
      }
    }
    
    return formattedMessage;
  }
  
  /**
   * Log to database if enabled
   * @param {string} level - Log level
   * @param {string} message - Message to log
   * @param {Object} data - Additional data
   * @private
   */
  _logToDatabase(level, message, data) {
    if (!this.logToDatabase) return;
    
    try {
      // Check if IasmsLogs collection exists
      if (typeof IasmsLogs !== 'undefined') {
        IasmsLogs.insert({
          timestamp: new Date(),
          level,
          module: this.module,
          message,
          data
        });
      }
    } catch (err) {
      console.error('Error logging to database:', err);
    }
  }
  
  /**
   * Log a debug message
   * @param {string} message - Message to log
   * @param {Object} data - Additional data
   */
  debug(message, data) {
    if (!this._shouldLog('debug')) return;
    
    const formattedMessage = this._formatMessage('debug', message, data);
    console.log(formattedMessage);
    this._logToDatabase('debug', message, data);
  }
  
  /**
   * Log an info message
   * @param {string} message - Message to log
   * @param {Object} data - Additional data
   */
  info(message, data) {
    if (!this._shouldLog('info')) return;
    
    const formattedMessage = this._formatMessage('info', message, data);
    console.log(formattedMessage);
    this._logToDatabase('info', message, data);
  }
  
  /**
   * Log a warning message
   * @param {string} message - Message to log
   * @param {Object} data - Additional data
   */
  warn(message, data) {
    if (!this._shouldLog('warn')) return;
    
    const formattedMessage = this._formatMessage('warn', message, data);
    console.warn(formattedMessage);
    this._logToDatabase('warn', message, data);
  }
  
  /**
   * Log an error message
   * @param {string} message - Message to log
   * @param {Object} data - Additional data
   */
  error(message, data) {
    if (!this._shouldLog('error')) return;
    
    const formattedMessage = this._formatMessage('error', message, data);
    console.error(formattedMessage);
    this._logToDatabase('error', message, data);
  }
  
  /**
   * Set log level
   * @param {string} level - Log level
   */
  setLevel(level) {
    if (this.levels[level] !== undefined) {
      this.logLevel = level;
    }
  }
  
  /**
   * Enable or disable logging
   * @param {boolean} enabled - Whether logging is enabled
   */
  setEnabled(enabled) {
    this.enabled = enabled;
  }
  
  /**
   * Enable or disable database logging
   * @param {boolean} enabled - Whether database logging is enabled
   */
  setDatabaseLogging(enabled) {
    this.logToDatabase = enabled;
  }
}

// Create default export - a logger for the simulation system
export default new IasmsSimulationLogger('SimulationSystem');
```


Let's create a helper for managing user roles and permissions specific to the simulation functionality:

```javascript
/**
 * /server/utils/IasmsSimulationRoles.js
 * 
 * Role Management for IASMS Simulation
 * Manages user roles and permissions for simulation components
 * 
 * Copyright 2025 Autonomy Association International Inc., all rights reserved 
 * Safeguard patent license from National Aeronautics and Space Administration (NASA)
 * Copyright 2025 NASA, all rights reserved
 */

import { Meteor } from 'meteor/meteor';
import { Roles } from 'meteor/alanning:roles';
import logger from './IasmsSimulationLogger';

// Define simulation-specific roles
export const SimulationRoles = {
  // Can create and manage all simulations
  ADMIN: 'simulation-admin',
  
  // Can create and manage training scenarios
  TRAINER: 'simulation-trainer',
  
  // Can participate in training
  TRAINEE: 'simulation-trainee',
  
  // Can view real-time simulations
  VIEWER: 'simulation-viewer',
  
  // Can control simulations
  CONTROLLER: 'simulation-controller',
  
  // Can integrate with simulation API
  API_USER: 'simulation-api-user'
};

// Define permission rules for simulation features
export const SimulationPermissions = {
  // Creating and managing simulations
  CREATE_SIMULATION: [SimulationRoles.ADMIN, SimulationRoles.TRAINER, SimulationRoles.CONTROLLER],
  EDIT_SIMULATION: [SimulationRoles.ADMIN, SimulationRoles.TRAINER, SimulationRoles.CONTROLLER],
  DELETE_SIMULATION: [SimulationRoles.ADMIN, SimulationRoles.TRAINER],
  
  // Scenarios
  CREATE_SCENARIO: [SimulationRoles.ADMIN, SimulationRoles.TRAINER],
  EDIT_SCENARIO: [SimulationRoles.ADMIN, SimulationRoles.TRAINER],
  DELETE_SCENARIO: [SimulationRoles.ADMIN],
  
  // Training
  MANAGE_TRAINING: [SimulationRoles.ADMIN, SimulationRoles.TRAINER],
  PARTICIPATE_TRAINING: [SimulationRoles.ADMIN, SimulationRoles.TRAINER, SimulationRoles.TRAINEE],
  VIEW_TRAINING_RECORDS: [SimulationRoles.ADMIN, SimulationRoles.TRAINER],
  
  // Real-time operations
  VIEW_REALTIME: [SimulationRoles.ADMIN, SimulationRoles.TRAINER, SimulationRoles.CONTROLLER, SimulationRoles.VIEWER],
  CONTROL_REALTIME: [SimulationRoles.ADMIN, SimulationRoles.TRAINER, SimulationRoles.CONTROLLER],
  
  // API access
  API_ACCESS: [SimulationRoles.ADMIN, SimulationRoles.API_USER]
};

/**
 * Check if a user has a specific permission
 * @param {string} userId - User ID to check
 * @param {string} permission - Permission to check
 * @returns {boolean} True if user has permission
 */
export const hasPermission = (userId, permission) => {
  if (!userId) return false;
  if (!SimulationPermissions[permission]) return false;
  
  // Get user roles
  const userRoles = Roles.getRolesForUser(userId);
  
  // Check if user has any of the required roles
  return SimulationPermissions[permission].some(role => 
    userRoles.includes(role) || 
    // Also check legacy roles
    (role === SimulationRoles.ADMIN && userRoles.includes('admin')) ||
    (role === SimulationRoles.TRAINER && userRoles.includes('trainer')) ||
    (role === SimulationRoles.TRAINEE && userRoles.includes('trainee'))
  );
};

/**
 * Initialize simulation roles
 */
export const initializeSimulationRoles = () => {
  logger.info('Initializing simulation roles');
  
  // Create roles if they don't exist
  Object.values(SimulationRoles).forEach(role => {
    if (!Roles.roleExists(role)) {
      Roles.createRole(role);
      logger.debug(`Created role: ${role}`);
    }
  });
  
  // Set up default role assignments if no simulation roles are assigned yet
  // This helps with migration from the old role system
  try {
    // Find users with old roles
    const adminUsers = Meteor.users.find({ roles: 'admin' }).fetch();
    const trainerUsers = Meteor.users.find({ roles: 'trainer' }).fetch();
    const traineeUsers = Meteor.users.find({ roles: 'trainee' }).fetch();
    
    // Assign new roles based on old roles
    adminUsers.forEach(user => {
      if (!Roles.userIsInRole(user._id, Object.values(SimulationRoles))) {
        Roles.addUsersToRoles(user._id, [SimulationRoles.ADMIN, SimulationRoles.CONTROLLER]);
        logger.debug(`Assigned admin roles to user: ${user._id}`);
      }
    });
    
    trainerUsers.forEach(user => {
      if (!Roles.userIsInRole(user._id, [SimulationRoles.TRAINER])) {
        Roles.addUsersToRoles(user._id, [SimulationRoles.TRAINER, SimulationRoles.CONTROLLER]);
        logger.debug(`Assigned trainer roles to user: ${user._id}`);
      }
    });
    
    traineeUsers.forEach(user => {
      if (!Roles.userIsInRole(user._id, [SimulationRoles.TRAINEE])) {
        Roles.addUsersToRoles(user._id, [SimulationRoles.TRAINEE, SimulationRoles.VIEWER]);
        logger.debug(`Assigned trainee roles to user: ${user._id}`);
      }
    });
    
    logger.info('Simulation roles initialized successfully');
  } catch (error) {
    logger.error('Error initializing simulation roles', error);
  }
};

// Export default methods
export default {
  hasPermission,
  initializeSimulationRoles,
  SimulationRoles,
  SimulationPermissions
};
```


Now, let's update our server initialization file to use these new components:

```javascript
/**
 * /server/IasmsServerInit.js
 * 
 * IASMS Server Initialization
 * Initializes all IASMS server components
 * 
 * Copyright 2025 Autonomy Association International Inc., all rights reserved 
 * Safeguard patent license from National Aeronautics and Space Administration (NASA)
 * Copyright 2025 NASA, all rights reserved
 */

import { Meteor } from 'meteor/meteor';
import logger from './utils/IasmsSimulationLogger';
import { initializeSimulationRoles } from './utils/IasmsSimulationRoles';
import { IasmsSimulationConfig } from './config/iasms-simulation-config';

// Import server files
import './IasmsSimulationPublications';
import './IasmsSimulationMethods';
import './IasmsStaticAssets';
import './IasmsAPIEndpoints';

// Import IASMS simulation integration
import { getSimulationModule } from './iasms/IasmsSimulationIntegration';

Meteor.startup(() => {
  logger.info('Starting IASMS Simulation Server Initialization');
  
  // Initialize roles
  initializeSimulationRoles();
  
  // Ensure simulation module is initialized
  const simulationModule = getSimulationModule();
  
  if (!simulationModule) {
    logger.error('Failed to get simulation module!');
  } else {
    logger.info('Simulation module is available');
    
    // Apply configuration
    if (simulationModule.configure) {
      simulationModule.configure(IasmsSimulationConfig);
      logger.info('Applied configuration to simulation module');
    }
  }
  
  // Create index for logs collection if it exists
  if (typeof IasmsLogs !== 'undefined') {
    IasmsLogs._ensureIndex({ timestamp: 1 });
    IasmsLogs._ensureIndex({ level: 1 });
    IasmsLogs._ensureIndex({ module: 1 });
  }
  
  logger.info('IASMS Server Initialization complete');
});
```


Let's create a file to define simulation-specific collections:

```javascript
/**
 * /server/IasmsSimulationCollections.js
 * 
 * IASMS Simulation Collections
 * Defines MongoDB collections for simulation components
 * 
 * Copyright 2025 Autonomy Association International Inc., all rights reserved 
 * Safeguard patent license from National Aeronautics and Space Administration (NASA)
 * Copyright 2025 NASA, all rights reserved
 */

import { Mongo } from 'meteor/mongo';
import { Meteor } from 'meteor/meteor';
import SimpleSchema from 'simpl-schema';

// Logs collection for simulation components
export const IasmsLogs = new Mongo.Collection('iasms_logs');

// Define schema for logs
const LogsSchema = new SimpleSchema({
  timestamp: {
    type: Date,
    defaultValue: new Date()
  },
  level: {
    type: String,
    allowedValues: ['debug', 'info', 'warn', 'error']
  },
  module: {
    type: String
  },
  message: {
    type: String
  },
  data: {
    type: Object,
    blackbox: true,
    optional: true
  }
});

// Apply schema to collection
IasmsLogs.attachSchema(LogsSchema);

// Telemetry collection for recording simulation data
export const IasmsTelemetry = new Mongo.Collection('iasms_telemetry');

// Define schema for telemetry
const TelemetrySchema = new SimpleSchema({
  sessionId: {
    type: String
  },
  timestamp: {
    type: Date,
    defaultValue: new Date()
  },
  entityId: {
    type: String
  },
  entityType: {
    type: String
  },
  position: {
    type: Object,
    blackbox: true
  },
  rotation: {
    type: Object,
    blackbox: true,
    optional: true
  },
  velocity: {
    type: Object,
    blackbox: true,
    optional: true
  },
  metadata: {
    type: Object,
    blackbox: true,
    optional: true
  }
});

// Apply schema to collection
IasmsTelemetry.attachSchema(TelemetrySchema);

// User settings collection
export const IasmsUserSettings = new Mongo.Collection('iasms_user_settings');

// Define schema for user settings
const UserSettingsSchema = new SimpleSchema({
  userId: {
    type: String
  },
  updatedAt: {
    type: Date,
    defaultValue: new Date()
  },
  visualization: {
    type: Object,
    blackbox: true,
    optional: true
  },
  notifications: {
    type: Object,
    blackbox: true,
    optional: true
  },
  preferences: {
    type: Object,
    blackbox: true,
    optional: true
  }
});

// Apply schema to collection
IasmsUserSettings.attachSchema(UserSettingsSchema);

// Create indexes if running on server
if (Meteor.isServer) {
  Meteor.startup(() => {
    // Logs indexes
    IasmsLogs._ensureIndex({ timestamp: 1 });
    IasmsLogs._ensureIndex({ level: 1 });
    IasmsLogs._ensureIndex({ module: 1 });
    
    // Telemetry indexes
    IasmsTelemetry._ensureIndex({ sessionId: 1 });
    IasmsTelemetry._ensureIndex({ timestamp: 1 });
    IasmsTelemetry._ensureIndex({ entityId: 1 });
    
    // User settings indexes
    IasmsUserSettings._ensureIndex({ userId: 1 });
  });
}
```


Finally, let's create a file for automated database cleanup to ensure our database doesn't grow too large:

```javascript
/**
 * /server/utils/IasmsSimulationCleanup.js
 * 
 * IASMS Simulation Cleanup
 * Handles cleanup of old simulation data
 * 
 * Copyright 2025 Autonomy Association International Inc., all rights reserved 
 * Safeguard patent license from National Aeronautics and Space Administration (NASA)
 * Copyright 2025 NASA, all rights reserved
 */

import { Meteor } from 'meteor/meteor';
import { IasmsSimulationConfig } from '../config/iasms-simulation-config';
import logger from './IasmsSimulationLogger';
import { IasmsLogs, IasmsTelemetry } from '../IasmsSimulationCollections';
import { IasmsSimulationSessions } from '../iasms/modules/IasmsSimulationTrainingModule';

/**
 * Cleanup class for simulation data
 */
export class IasmsSimulationCleanup {
  constructor() {
    this.initialized = false;
    this.intervalHandle = null;
  }
  
  /**
   * Initialize the cleanup scheduler
   */
  initialize() {
    if (this.initialized) return;
    
    logger.info('Initializing simulation data cleanup scheduler');
    
    // Schedule regular cleanup
    const interval = IasmsSimulationConfig.performance.cleanupInterval || 300000; // Default: 5 minutes
    
    this.intervalHandle = Meteor.setInterval(() => {
      this.performCleanup();
    }, interval);
    
    this.initialized = true;
    logger.info(`Scheduled cleanup to run every ${interval / 60000} minutes`);
  }
  
  /**
   * Perform database cleanup
   */
  async performCleanup() {
    logger.info('Starting simulation data cleanup');
    
    try {
      // Clean up old logs
      await this._cleanupLogs();
      
      // Clean up old telemetry
      await this._cleanupTelemetry();
      
      // Clean up completed sessions
      await this._cleanupSessions();
      
      logger.info('Simulation data cleanup completed successfully');
    } catch (error) {
      logger.error('Error during simulation data cleanup', error);
    }
  }
  
  /**
   * Clean up old logs
   * @private
   */
  async _cleanupLogs() {
    try {
      // Keep logs for 30 days
      const cutoff = new Date(Date.now() - (30 * 24 * 60 * 60 * 1000));
      
      // Remove old logs
      const removed = IasmsLogs.remove({ timestamp: { $lt: cutoff } });
      
      logger.info(`Removed ${removed} old log entries`);
    } catch (error) {
      logger.error('Error cleaning up logs', error);
    }
  }
  
  /**
   * Clean up old telemetry
   * @private
   */
  async _cleanupTelemetry() {
    try {
      // Keep telemetry for the configured duration
      const maxAge = IasmsSimulationConfig.performance.maxTelemetryAge || 3600000; // Default: 1 hour
      const cutoff = new Date(Date.now() - maxAge);
      
      // Remove old telemetry
      const removed = IasmsTelemetry.remove({ timestamp: { $lt: cutoff } });
      
      logger.info(`Removed ${removed} old telemetry records`);
    } catch (error) {
      logger.error('Error cleaning up telemetry', error);
    }
  }
  
  /**
   * Clean up old completed sessions
   * @private
   */
  async _cleanupSessions() {
    try {
      // Find completed sessions older than 7 days
      const cutoff = new Date(Date.now() - (7 * 24 * 60 * 60 * 1000));
      
      // Remove old completed sessions
      const removed = IasmsSimulationSessions.remove({ 
        status: 'COMPLETED', 
        endTime: { $lt: cutoff } 
      });
      
      logger.info(`Removed ${removed} old completed sessions`);
    } catch (error) {
      logger.error('Error cleaning up sessions', error);
    }
  }
  
  /**
   * Stop the cleanup scheduler
   */
  stop() {
    if (this.intervalHandle) {
      Meteor.clearInterval(this.intervalHandle);
      this.intervalHandle = null;
      this.initialized = false;
      logger.info('Stopped simulation data cleanup scheduler');
    }
  }
}

// Create and export singleton instance
export const simulationCleanup = new IasmsSimulationCleanup();

// Auto-initialize at startup
Meteor.startup(() => {
  simulationCleanup.initialize();
});

export default simulationCleanup;
```


Let's update our main server file to include these new components:

```javascript
/**
 * /server/IasmsServerInit.js
 * 
 * IASMS Server Initialization
 * Initializes all IASMS server components
 * 
 * Copyright 2025 Autonomy Association International Inc., all rights reserved 
 * Safeguard patent license from National Aeronautics and Space Administration (NASA)
 * Copyright 2025 NASA, all rights reserved
 */

import { Meteor } from 'meteor/meteor';
import logger from './utils/IasmsSimulationLogger';
import { initializeSimulationRoles } from './utils/IasmsSimulationRoles';
import { IasmsSimulationConfig } from './config/iasms-simulation-config';
import { simulationCleanup } from './utils/IasmsSimulationCleanup';
import './IasmsSimulationCollections';

// Import server files
import './IasmsSimulationPublications';
import './IasmsSimulationMethods';
import './IasmsStaticAssets';
import './IasmsAPIEndpoints';

// Import IASMS simulation integration
import { getSimulationModule } from './iasms/IasmsSimulationIntegration';

Meteor.startup(() => {
  logger.info('Starting IASMS Simulation Server Initialization');
  
  // Initialize roles
  initializeSimulationRoles();
  
  // Initialize simulation cleanup
  simulationCleanup.initialize();
  
  // Ensure simulation module is initialized
  const simulationModule = getSimulationModule();
  
  if (!simulationModule) {
    logger.error('Failed to get simulation module!');
  } else {
    logger.info('Simulation module is available');
    
    // Apply configuration
    if (simulationModule.configure) {
      simulationModule.configure(IasmsSimulationConfig);
      logger.info('Applied configuration to simulation module');
    }
  }
  
  logger.info('IASMS Server Initialization complete');
});
```


This completes our server-side implementation. We've added:

1. **Configuration** - A centralized configuration file for the simulation module.
2. **Logging** - A dedicated logger for simulation components.
3. **Role Management** - A comprehensive role and permission system for simulation features.
4. **Database Collections** - Additional collections for logs, telemetry, and user settings.
5. **Automated Cleanup** - A scheduler for cleaning up old data to keep the database size manageable.

These components ensure that our integration is robust, secure, and maintainable. The configuration system allows for easy adjustment of simulation parameters, the logging system provides detailed information for troubleshooting, the role system ensures proper access control, and the cleanup system prevents database bloat.

With these additions, our integration with the existing IASMS system is complete. The simulation module can now be used to visualize real-time data from the IASMS system, provide training scenarios, and enhance the overall capabilities of the system.

