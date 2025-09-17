I'll continue by creating the main module for integration with the existing IASMS system. This module will connect all our enhanced components together.

## 7. Full Integration with Existing IASMS System

Let's create a main integration module that will bring together all our enhanced components and connect them to the existing IASMS system.

First, let's create the main integration module file:

```javascript
/**
 * /server/iasms/IasmsSimulationTrainingModule.js
 * 
 * IASMS Simulation and Training Integration Module
 * Integrates 3D simulation capabilities with the IASMS system for training
 * and operational visualization.
 * 
 * Copyright 2025 Autonomy Association International Inc., all rights reserved 
 * Safeguard patent license from National Aeronautics and Space Administration (NASA)
 * Copyright 2025 NASA, all rights reserved
 */

import { Meteor } from 'meteor/meteor';
import { check, Match } from 'meteor/check';
import { EventEmitter } from 'events';
import { Mongo } from 'meteor/mongo';

// Collections for simulation scenarios and sessions
export const IasmsSimulationScenarios = new Mongo.Collection('iasms_simulation_scenarios');
export const IasmsSimulationSessions = new Mongo.Collection('iasms_simulation_sessions');
export const IasmsTrainingRecords = new Mongo.Collection('iasms_training_records');

// Create indexes
if (Meteor.isServer) {
  Meteor.startup(() => {
    // Simulation scenarios
    IasmsSimulationScenarios.createIndex({ name: 1 });
    IasmsSimulationScenarios.createIndex({ category: 1 });
    IasmsSimulationScenarios.createIndex({ difficulty: 1 });
    
    // Simulation sessions
    IasmsSimulationSessions.createIndex({ userId: 1 });
    IasmsSimulationSessions.createIndex({ scenarioId: 1 });
    IasmsSimulationSessions.createIndex({ startTime: -1 });
    IasmsSimulationSessions.createIndex({ status: 1 });
    
    // Training records
    IasmsTrainingRecords.createIndex({ userId: 1 });
    IasmsTrainingRecords.createIndex({ sessionId: 1 });
    IasmsTrainingRecords.createIndex({ completionDate: -1 });
  });
}

/**
 * IASMS Simulation and Training Integration Module
 * Provides integration between the 3D simulation system and IASMS core
 */
export class IasmsSimulationTrainingModule extends EventEmitter {
  /**
   * Constructor
   * @param {Object} options - Configuration options
   */
  constructor(options = {}) {
    super();
    
    this.options = {
      enableRealTimeSync: options.enableRealTimeSync !== undefined ? options.enableRealTimeSync : true,
      syncInterval: options.syncInterval || 1000, // 1 second
      maxSessionDuration: options.maxSessionDuration || 7200000, // 2 hours
      recordTelemetry: options.recordTelemetry !== undefined ? options.recordTelemetry : true,
      telemetryInterval: options.telemetryInterval || 5000, // 5 seconds
      ...options
    };
    
    this.syncIntervalId = null;
    this.activeSessions = new Map(); // Map of sessionId to session data
    this.simulationModels = new Map(); // Map of model type to model configuration
    this.currentOperations = new Map(); // Map of operationId to operation data
    this.isInitialized = false;
  }

  /**
   * Initialize the module
   * @returns {Promise<boolean>} True if initialization was successful
   */
  async initialize() {
    if (this.isInitialized) {
      return true;
    }
    
    console.log('Initializing IASMS Simulation and Training Module...');
    
    try {
      // Load active simulation sessions
      this._loadActiveSessions();
      
      // Register default simulation models
      this._registerDefaultModels();
      
      // Register event listeners with IASMS core modules
      this._registerEventListeners();
      
      // Start synchronization interval if enabled
      if (this.options.enableRealTimeSync) {
        this.syncIntervalId = Meteor.setInterval(() => {
          this._syncSimulationWithRealWorld();
        }, this.options.syncInterval);
      }
      
      this.isInitialized = true;
      console.log('IASMS Simulation and Training Module initialized successfully');
      return true;
    } catch (error) {
      console.error('Error initializing Simulation and Training Module:', error);
      return false;
    }
  }

  /**
   * Load active simulation sessions
   * @private
   */
  _loadActiveSessions() {
    const activeSessions = IasmsSimulationSessions.find({
      status: { $in: ['ACTIVE', 'PAUSED'] }
    }).fetch();
    
    activeSessions.forEach(session => {
      this.activeSessions.set(session._id, {
        ...session,
        syncStatus: {
          lastSyncTime: new Date(),
          entities: new Map()
        }
      });
    });
    
    console.log(`Loaded ${activeSessions.length} active simulation sessions`);
  }

  /**
   * Register default simulation models
   * @private
   */
  _registerDefaultModels() {
    // Register aerial vehicle models
    this.registerSimulationModel({
      type: 'drone',
      category: 'aerial',
      name: 'Standard Quadcopter',
      modelPath: '/assets/models/drone.glb',
      scale: 1.0,
      physics: {
        mass: 1.5,
        maxSpeed: 15, // m/s
        maxAcceleration: 5, // m/s²
        rotationSpeed: 2, // rad/s
        maxAltitude: 120 // meters
      },
      sensors: ['camera', 'gps', 'imu'],
      defaultPose: {
        position: { x: 0, y: 0, z: 0 },
        rotation: { x: 0, y: 0, z: 0 }
      }
    });
    
    this.registerSimulationModel({
      type: 'eVTOL',
      category: 'aerial',
      name: 'Urban Air Mobility Vehicle',
      modelPath: '/assets/models/evtol.glb',
      scale: 1.0,
      physics: {
        mass: 1200,
        maxSpeed: 45, // m/s
        maxAcceleration: 3, // m/s²
        rotationSpeed: 0.8, // rad/s
        maxAltitude: 500 // meters
      },
      sensors: ['camera', 'gps', 'imu', 'radar', 'lidar'],
      defaultPose: {
        position: { x: 0, y: 0, z: 0 },
        rotation: { x: 0, y: 0, z: 0 }
      }
    });
    
    this.registerSimulationModel({
      type: 'aircraft',
      category: 'aerial',
      name: 'Small Aircraft',
      modelPath: '/assets/models/aircraft.glb',
      scale: 1.0,
      physics: {
        mass: 2500,
        maxSpeed: 90, // m/s
        maxAcceleration: 2, // m/s²
        rotationSpeed: 0.5, // rad/s
        maxAltitude: 1500 // meters
      },
      sensors: ['camera', 'gps', 'imu', 'radar'],
      defaultPose: {
        position: { x: 0, y: 0, z: 0 },
        rotation: { x: 0, y: 0, z: 0 }
      }
    });
    
    // Register ground vehicle models
    this.registerSimulationModel({
      type: 'car',
      category: 'ground',
      name: 'Passenger Car',
      modelPath: '/assets/models/car.glb',
      scale: 1.0,
      physics: {
        mass: 1500,
        maxSpeed: 30, // m/s
        maxAcceleration: 3, // m/s²
        rotationSpeed: 1.2, // rad/s
      },
      sensors: ['camera', 'gps', 'lidar'],
      defaultPose: {
        position: { x: 0, y: 0, z: 0 },
        rotation: { x: 0, y: 0, z: 0 }
      }
    });
    
    // Register maritime vehicle models
    this.registerSimulationModel({
      type: 'boat',
      category: 'maritime',
      name: 'Small Boat',
      modelPath: '/assets/models/boat.glb',
      scale: 1.0,
      physics: {
        mass: 2000,
        maxSpeed: 12, // m/s
        maxAcceleration: 1, // m/s²
        rotationSpeed: 0.5, // rad/s
      },
      sensors: ['camera', 'gps', 'radar'],
      defaultPose: {
        position: { x: 0, y: 0, z: 0 },
        rotation: { x: 0, y: 0, z: 0 }
      }
    });
    
    console.log('Registered default simulation models');
  }

  /**
   * Register event listeners with IASMS core modules
   * @private
   */
  _registerEventListeners() {
    if (!Meteor.server.iasmsServices) {
      console.warn('IASMS services not available, skipping event listeners');
      return;
    }
    
    // Monitor module events
    const monitorModule = Meteor.server.iasmsServices.monitorModule;
    if (monitorModule) {
      monitorModule.on('vehicleState:updated', (state) => {
        this._handleVehicleStateUpdate(state);
      });
      
      monitorModule.on('hazard:detected', (hazard) => {
        this._handleHazardDetected(hazard);
      });
    }
    
    // Assess module events
    const assessModule = Meteor.server.iasmsServices.assessModule;
    if (assessModule) {
      assessModule.on('risk:assessed', (risk) => {
        this._handleRiskAssessed(risk);
      });
    }
    
    // Lost link module events
    const lostLinkModule = Meteor.server.iasmsServices.lostLinkModule;
    if (lostLinkModule) {
      lostLinkModule.on('lostLink:declared', (event) => {
        this._handleLostLinkDeclared(event);
      });
      
      lostLinkModule.on('lostLink:contingency', (event) => {
        this._handleLostLinkContingency(event);
      });
    }
    
    // Vertiport emergency module events
    const vertiportModule = Meteor.server.iasmsServices.vertiportEmergencyModule;
    if (vertiportModule) {
      vertiportModule.on('vertiportEmergency:declared', (event) => {
        this._handleVertiportEmergency(event);
      });
    }
    
    console.log('Registered event listeners with IASMS core modules');
  }

  /**
   * Handle vehicle state update from monitor module
   * @param {Object} state - Vehicle state
   * @private
   */
  _handleVehicleStateUpdate(state) {
    // Update all active sessions with this vehicle
    for (const [sessionId, session] of this.activeSessions.entries()) {
      // Skip if session is not set to sync with real-world
      if (!session.syncWithRealWorld) continue;
      
      // Convert state to simulation entity update
      const entityUpdate = this._convertVehicleStateToEntity(state);
      
      // Store for next sync
      if (!session.syncStatus.entities.has(state.vehicleId)) {
        session.syncStatus.entities.set(state.vehicleId, {
          entityId: state.vehicleId,
          entityType: 'vehicle',
          updates: []
        });
      }
      
      const entityData = session.syncStatus.entities.get(state.vehicleId);
      entityData.updates.push(entityUpdate);
      
      // Trim updates array to last 10 updates only
      if (entityData.updates.length > 10) {
        entityData.updates = entityData.updates.slice(-10);
      }
    }
  }

  /**
   * Handle hazard detected from monitor module
   * @param {Object} hazard - Hazard
   * @private
   */
  _handleHazardDetected(hazard) {
    // Update all active sessions with this hazard
    for (const [sessionId, session] of this.activeSessions.entries()) {
      // Skip if session is not set to sync with real-world
      if (!session.syncWithRealWorld) continue;
      
      // Convert hazard to simulation entity update
      const entityUpdate = this._convertHazardToEntity(hazard);
      
      // Store for next sync
      if (!session.syncStatus.entities.has(hazard._id)) {
        session.syncStatus.entities.set(hazard._id, {
          entityId: hazard._id,
          entityType: 'hazard',
          updates: []
        });
      }
      
      const entityData = session.syncStatus.entities.get(hazard._id);
      entityData.updates.push(entityUpdate);
    }
  }

  /**
   * Handle risk assessed from assess module
   * @param {Object} risk - Risk assessment
   * @private
   */
  _handleRiskAssessed(risk) {
    // Update all active sessions with this risk
    for (const [sessionId, session] of this.activeSessions.entries()) {
      // Skip if session is not set to sync with real-world
      if (!session.syncWithRealWorld) continue;
      
      // Convert risk to simulation entity update
      const entityUpdate = this._convertRiskToEntity(risk);
      
      // Store for next sync
      const riskId = `risk_${risk.vehicleId}_${risk.hazardId}`;
      if (!session.syncStatus.entities.has(riskId)) {
        session.syncStatus.entities.set(riskId, {
          entityId: riskId,
          entityType: 'risk',
          updates: []
        });
      }
      
      const entityData = session.syncStatus.entities.get(riskId);
      entityData.updates.push(entityUpdate);
    }
  }

  /**
   * Handle lost link declared from lost link module
   * @param {Object} event - Lost link event
   * @private
   */
  _handleLostLinkDeclared(event) {
    // Update all active sessions with this lost link event
    for (const [sessionId, session] of this.activeSessions.entries()) {
      // Skip if session is not set to sync with real-world
      if (!session.syncWithRealWorld) continue;
      
      // Convert lost link to simulation entity update
      const entityUpdate = this._convertLostLinkToEntity(event);
      
      // Store for next sync
      const lostLinkId = `lostlink_${event.vehicleId}`;
      if (!session.syncStatus.entities.has(lostLinkId)) {
        session.syncStatus.entities.set(lostLinkId, {
          entityId: lostLinkId,
          entityType: 'lostlink',
          updates: []
        });
      }
      
      const entityData = session.syncStatus.entities.get(lostLinkId);
      entityData.updates.push(entityUpdate);
    }
  }

  /**
   * Handle lost link contingency from lost link module
   * @param {Object} event - Lost link contingency event
   * @private
   */
  _handleLostLinkContingency(event) {
    // Update all active sessions with this contingency
    for (const [sessionId, session] of this.activeSessions.entries()) {
      // Skip if session is not set to sync with real-world
      if (!session.syncWithRealWorld) continue;
      
      // Convert contingency to simulation entity update
      const entityUpdate = this._convertContingencyToEntity(event);
      
      // Store for next sync
      const contingencyId = `contingency_${event.vehicleId}`;
      if (!session.syncStatus.entities.has(contingencyId)) {
        session.syncStatus.entities.set(contingencyId, {
          entityId: contingencyId,
          entityType: 'contingency',
          updates: []
        });
      }
      
      const entityData = session.syncStatus.entities.get(contingencyId);
      entityData.updates.push(entityUpdate);
    }
  }

  /**
   * Handle vertiport emergency from vertiport module
   * @param {Object} event - Vertiport emergency event
   * @private
   */
  _handleVertiportEmergency(event) {
    // Update all active sessions with this emergency
    for (const [sessionId, session] of this.activeSessions.entries()) {
      // Skip if session is not set to sync with real-world
      if (!session.syncWithRealWorld) continue;
      
      // Convert emergency to simulation entity update
      const entityUpdate = this._convertVertiportEmergencyToEntity(event);
      
      // Store for next sync
      const emergencyId = `vertiport_emergency_${event.vertiportId}`;
      if (!session.syncStatus.entities.has(emergencyId)) {
        session.syncStatus.entities.set(emergencyId, {
          entityId: emergencyId,
          entityType: 'vertiport_emergency',
          updates: []
        });
      }
      
      const entityData = session.syncStatus.entities.get(emergencyId);
      entityData.updates.push(entityUpdate);
    }
  }

  /**
   * Synchronize simulation with real-world data
   * @private
   */
  _syncSimulationWithRealWorld() {
    const now = new Date();
    
    // For each active session, send updates to clients
    for (const [sessionId, session] of this.activeSessions.entries()) {
      // Skip if session is not set to sync with real-world
      if (!session.syncWithRealWorld) continue;
      
      // Collect entity updates
      const updates = [];
      for (const [entityId, entityData] of session.syncStatus.entities.entries()) {
        if (entityData.updates.length > 0) {
          // Get most recent update
          const latestUpdate = entityData.updates[entityData.updates.length - 1];
          updates.push(latestUpdate);
          
          // Clear updates
          entityData.updates = [];
        }
      }
      
      // If there are updates, publish them
      if (updates.length > 0) {
        this._publishSessionUpdates(sessionId, updates);
        
        // Update last sync time
        session.syncStatus.lastSyncTime = now;
      }
    }
  }

  /**
   * Publish session updates to clients
   * @param {string} sessionId - Session ID
   * @param {Array} updates - Array of entity updates
   * @private
   */
  _publishSessionUpdates(sessionId, updates) {
    // Use streamer to send updates to clients
    const streamer = Meteor.server.simulationStreamer;
    if (streamer) {
      streamer.emit(`session_${sessionId}`, {
        type: 'entity_updates',
        sessionId,
        timestamp: new Date(),
        updates
      });
    }
  }

  /**
   * Convert vehicle state to simulation entity
   * @param {Object} state - Vehicle state
   * @returns {Object} Entity update
   * @private
   */
  _convertVehicleStateToEntity(state) {
    // Determine vehicle type and category
    const vehicleType = state.vehicleType || 'drone';
    const vehicleCategory = state.vehicleCategory || 'aerial';
    
    // Get model for this vehicle type
    const model = this.simulationModels.get(vehicleType) || this.simulationModels.get('drone');
    
    return {
      type: 'vehicle_update',
      entityId: state.vehicleId,
      timestamp: state.timestamp,
      vehicleType,
      vehicleCategory,
      modelPath: model?.modelPath || '/assets/models/drone.glb',
      position: {
        x: state.position.coordinates[0],
        y: state.altitude || 100,
        z: state.position.coordinates[1]
      },
      rotation: {
        x: 0,
        y: (state.heading || 0) * (Math.PI / 180), // Convert to radians
        z: 0
      },
      velocity: {
        speed: state.speed || 0,
        heading: state.heading || 0
      },
      scale: model?.scale || 1.0,
      metadata: {
        callsign: state.callsign || state.vehicleId,
        operationId: state.operationId,
        status: state.status || 'UNKNOWN'
      }
    };
  }

  /**
   * Convert hazard to simulation entity
   * @param {Object} hazard - Hazard
   * @returns {Object} Entity update
   * @private
   */
  _convertHazardToEntity(hazard) {
    // Map hazard type to visualization type
    let visualType = 'warning_zone';
    let color = '#ffaa00';
    
    switch (hazard.hazardType) {
      case 'WEATHER_THUNDERSTORM':
      case 'WEATHER_HEAVY_RAIN':
      case 'WEATHER_SNOW':
      case 'WEATHER_FOG':
      case 'WEATHER_HIGH_WINDS':
        visualType = 'weather_zone';
        color = '#0088ff';
        break;
      case 'ROGUE_DRONE':
        visualType = 'drone_zone';
        color = '#ff0000';
        break;
      case 'VERTIPORT_EMERGENCY':
        visualType = 'emergency_zone';
        color = '#ff4400';
        break;
      case 'COMMUNICATION_LOSS':
        visualType = 'comms_zone';
        color = '#aa00ff';
        break;
    }
    
    return {
      type: 'hazard_update',
      entityId: hazard._id,
      timestamp: hazard.timestamp,
      hazardType: hazard.hazardType,
      visualType,
      position: {
        x: hazard.location.coordinates[0],
        y: hazard.altitude || 100,
        z: hazard.location.coordinates[1]
      },
      radius: hazard.radius || 500,
      color,
      severity: hazard.severity || 0.5,
      expiryTime: hazard.expiryTime,
      metadata: hazard.metadata || {}
    };
  }

  /**
   * Convert risk to simulation entity
   * @param {Object} risk - Risk assessment
   * @returns {Object} Entity update
   * @private
   */
  _convertRiskToEntity(risk) {
    // Get vehicle position from metadata
    const vehiclePosition = risk.metadata?.vehicleState?.position || { coordinates: [0, 0] };
    const vehicleAltitude = risk.metadata?.vehicleState?.altitude || 100;
    
    // Get hazard info
    const hazardInfo = risk.metadata?.hazardInfo || {};
    const hazardPosition = hazardInfo.location || { coordinates: [0, 0] };
    
    // Determine color based on risk level
    let color = '#00ff00';
    if (risk.riskLevel >= 0.7) {
      color = '#ff0000';
    } else if (risk.riskLevel >= 0.4) {
      color = '#ffaa00';
    } else if (risk.riskLevel >= 0.2) {
      color = '#ffff00';
    }
    
    return {
      type: 'risk_update',
      entityId: `risk_${risk.vehicleId}_${risk.hazardId}`,
      timestamp: risk.timestamp,
      riskLevel: risk.riskLevel,
      riskCategory: risk.riskCategory,
      vehicleId: risk.vehicleId,
      hazardId: risk.hazardId,
      vehiclePosition: {
        x: vehiclePosition.coordinates[0],
        y: vehicleAltitude,
        z: vehiclePosition.coordinates[1]
      },
      hazardPosition: {
        x: hazardPosition.coordinates[0],
        y: hazardInfo.altitude || 100,
        z: hazardPosition.coordinates[1]
      },
      color,
      riskFactors: risk.riskFactors || {},
      metadata: risk.metadata || {}
    };
  }

  /**
   * Convert lost link to simulation entity
   * @param {Object} event - Lost link event
   * @returns {Object} Entity update
   * @private
   */
  _convertLostLinkToEntity(event) {
    return {
      type: 'lostlink_update',
      entityId: `lostlink_${event.vehicleId}`,
      timestamp: event.timestamp,
      vehicleId: event.vehicleId,
      eventId: event.eventId,
      position: {
        x: event.lastKnownLocation.coordinates[0],
        y: 100, // Default altitude
        z: event.lastKnownLocation.coordinates[1]
      },
      lastHeartbeatTime: event.lastHeartbeatTime,
      visualType: 'lostlink_marker',
      color: '#ff00ff',
      metadata: {}
    };
  }

  /**
   * Convert contingency to simulation entity
   * @param {Object} event - Contingency event
   * @returns {Object} Entity update
   * @private
   */
  _convertContingencyToEntity(event) {
    // Get contingency plan details if available
    const plan = event.contingencyPlan || {};
    
    return {
      type: 'contingency_update',
      entityId: `contingency_${event.vehicleId}`,
      timestamp: event.timestamp,
      vehicleId: event.vehicleId,
      eventId: event.eventId,
      contingencyType: event.contingencyType,
      contingencyAction: event.contingencyAction,
      visualType: 'contingency_path',
      color: '#ffaa00',
      pathPoints: plan.landingPoints || [],
      metadata: {
        contingencyPlanId: event.contingencyPlanId,
        primaryAction: plan.primaryAction,
        backupAction: plan.backupAction
      }
    };
  }

  /**
   * Convert vertiport emergency to simulation entity
   * @param {Object} event - Vertiport emergency event
   * @returns {Object} Entity update
   * @private
   */
  _convertVertiportEmergencyToEntity(event) {
    return {
      type: 'vertiport_emergency_update',
      entityId: `vertiport_emergency_${event.vertiportId}`,
      timestamp: event.timestamp,
      vertiportId: event.vertiportId,
      emergencyId: event.emergencyId,
      emergencyType: event.emergencyType,
      position: {
        x: event.location.coordinates[0],
        y: 0, // Ground level
        z: event.location.coordinates[1]
      },
      status: event.status,
      severity: event.severity || 0.8,
      visualType: 'vertiport_emergency',
      color: '#ff0000',
      expiryTime: event.expiryTime,
      metadata: {}
    };
  }

  /**
   * Create new simulation session
   * @param {Object} options - Session options
   * @returns {string} Session ID
   */
  createSimulationSession(options) {
    const { userId, scenarioId, name, description, syncWithRealWorld, entities } = options;
    
    // Create session
    const sessionId = IasmsSimulationSessions.insert({
      userId,
      scenarioId,
      name: name || 'New Simulation Session',
      description: description || '',
      startTime: new Date(),
      status: 'ACTIVE',
      syncWithRealWorld: syncWithRealWorld || false,
      initialEntities: entities || [],
      eventLog: [],
      metadata: options.metadata || {},
      settings: options.settings || {
        timeScale: 1.0,
        weatherConditions: 'CLEAR',
        timeOfDay: 'DAY'
      }
    });
    
    // Add to active sessions
    this.activeSessions.set(sessionId, {
      _id: sessionId,
      userId,
      scenarioId,
      name: name || 'New Simulation Session',
      status: 'ACTIVE',
      syncWithRealWorld: syncWithRealWorld || false,
      startTime: new Date(),
      syncStatus: {
        lastSyncTime: new Date(),
        entities: new Map()
      }
    });
    
    console.log(`Created new simulation session: ${sessionId}`);
    
    // Set up initial entities
    if (entities && entities.length > 0) {
      this._setupInitialEntities(sessionId, entities);
    }
    
    // Load scenario data if provided
    if (scenarioId) {
      this._loadScenarioData(sessionId, scenarioId);
    }
    
    return sessionId;
  }

  /**
   * Set up initial entities for a session
   * @param {string} sessionId - Session ID
   * @param {Array} entities - Initial entities
   * @private
   */
  _setupInitialEntities(sessionId, entities) {
    const session = this.activeSessions.get(sessionId);
    if (!session) return;
    
    // Create entity updates for initial entities
    const updates = entities.map(entity => {
      switch (entity.type) {
        case 'vehicle':
          return {
            type: 'vehicle_create',
            entityId: entity.id || `vehicle_${Date.now()}_${Math.floor(Math.random() * 1000)}`,
            vehicleType: entity.vehicleType || 'drone',
            vehicleCategory: entity.vehicleCategory || 'aerial',
            modelPath: entity.modelPath || this._getModelPathForType(entity.vehicleType),
            position: entity.position || { x: 0, y: 100, z: 0 },
            rotation: entity.rotation || { x: 0, y: 0, z: 0 },
            scale: entity.scale || 1.0,
            metadata: entity.metadata || {}
          };
        case 'hazard':
          return {
            type: 'hazard_create',
            entityId: entity.id || `hazard_${Date.now()}_${Math.floor(Math.random() * 1000)}`,
            hazardType: entity.hazardType || 'GENERIC',
            visualType: entity.visualType || 'warning_zone',
            position: entity.position || { x: 0, y: 0, z: 0 },
            radius: entity.radius || 500,
            color: entity.color || '#ffaa00',
            severity: entity.severity || 0.5,
            expiryTime: entity.expiryTime || new Date(Date.now() + 3600000), // 1 hour
            metadata: entity.metadata || {}
          };
        case 'static':
          return {
            type: 'static_create',
            entityId: entity.id || `static_${Date.now()}_${Math.floor(Math.random() * 1000)}`,
            objectType: entity.objectType || 'building',
            modelPath: entity.modelPath || '/assets/models/building.glb',
            position: entity.position || { x: 0, y: 0, z: 0 },
            rotation: entity.rotation || { x: 0, y: 0, z: 0 },
            scale: entity.scale || 1.0,
            metadata: entity.metadata || {}
          };
        default:
          return null;
      }
    }).filter(update => update !== null);
    
    // Publish updates
    this._publishSessionUpdates(sessionId, updates);
  }

  /**
   * Get model path for vehicle type
   * @param {string} vehicleType - Vehicle type
   * @returns {string} Model path
   * @private
   */
  _getModelPathForType(vehicleType) {
    const model = this.simulationModels.get(vehicleType);
    return model?.modelPath || '/assets/models/drone.glb';
  }

  /**
   * Load scenario data
   * @param {string} sessionId - Session ID
   * @param {string} scenarioId - Scenario ID
   * @private
   */
  _loadScenarioData(sessionId, scenarioId) {
    const scenario = IasmsSimulationScenarios.findOne(scenarioId);
    if (!scenario) return;
    
    // Create initial entities from scenario
    if (scenario.entities && scenario.entities.length > 0) {
      this._setupInitialEntities(sessionId, scenario.entities);
    }
    
    // Set up scenario events
    if (scenario.events && scenario.events.length > 0) {
      this._setupScenarioEvents(sessionId, scenario.events);
    }
  }

  /**
   * Set up scenario events
   * @param {string} sessionId - Session ID
   * @param {Array} events - Scenario events
   * @private
   */
  _setupScenarioEvents(sessionId, events) {
    const session = this.activeSessions.get(sessionId);
    if (!session) return;
    
    // Sort events by time
    const sortedEvents = [...events].sort((a, b) => a.time - b.time);
    
    // Schedule events
    sortedEvents.forEach(event => {
      const delay = event.time * 1000; // Convert to milliseconds
      
      // Schedule event
      Meteor.setTimeout(() => {
        // Check if session is still active
        const currentSession = this.activeSessions.get(sessionId);
        if (!currentSession || currentSession.status !== 'ACTIVE') return;
        
        // Process event
        this._processScenarioEvent(sessionId, event);
      }, delay);
    });
  }

  /**
   * Process scenario event
   * @param {string} sessionId - Session ID
   * @param {Object} event - Scenario event
   * @private
   */
  _processScenarioEvent(sessionId, event) {
    const session = this.activeSessions.get(sessionId);
    if (!session) return;
    
    // Create update based on event type
    let update = null;
    
    switch (event.type) {
      case 'vehicle_spawn':
        update = {
          type: 'vehicle_create',
          entityId: event.entityId || `vehicle_${Date.now()}_${Math.floor(Math.random() * 1000)}`,
          vehicleType: event.vehicleType || 'drone',
          vehicleCategory: event.vehicleCategory || 'aerial',
          modelPath: event.modelPath || this._getModelPathForType(event.vehicleType),
          position: event.position || { x: 0, y: 100, z: 0 },
          rotation: event.rotation || { x: 0, y: 0, z: 0 },
          scale: event.scale || 1.0,
          metadata: event.metadata || {}
        };
        break;
      case 'hazard_spawn':
        update = {
          type: 'hazard_create',
          entityId: event.entityId || `hazard_${Date.now()}_${Math.floor(Math.random() * 1000)}`,
          hazardType: event.hazardType || 'GENERIC',
          visualType: event.visualType || 'warning_zone',
          position: event.position || { x: 0, y: 0, z: 0 },
          radius: event.radius || 500,
          color: event.color || '#ffaa00',
          severity: event.severity || 0.5,
          expiryTime: event.expiryTime || new Date(Date.now() + 3600000), // 1 hour
          metadata: event.metadata || {}
        };
        break;
      case 'emergency_trigger':
        update = {
          type: 'emergency_trigger',
          entityId: event.entityId,
          emergencyType: event.emergencyType || 'GENERIC',
          position: event.position || { x: 0, y: 0, z: 0 },
          metadata: event.metadata || {}
        };
        break;
      case 'weather_change':
        update = {
          type: 'weather_change',
          weatherType: event.weatherType || 'CLEAR',
          intensity: event.intensity || 0.5,
          affectedArea: event.affectedArea || null,
          transitionTime: event.transitionTime || 10,
          metadata: event.metadata || {}
        };
        break;
      case 'notification':
        update = {
          type: 'notification',
          title: event.title || 'Notification',
          message: event.message || '',
          level: event.level || 'info',
          metadata: event.metadata || {}
        };
        break;
    }
    
    if (update) {
      // Add event to log
      IasmsSimulationSessions.update(sessionId, {
        $push: {
          eventLog: {
            time: new Date(),
            eventType: event.type,
            details: update
          }
        }
      });
      
      // Publish update
      this._publishSessionUpdates(sessionId, [update]);
    }
  }

  /**
   * Update simulation session
   * @param {string} sessionId - Session ID
   * @param {Object} updates - Session updates
   * @returns {boolean} True if update was successful
   */
  updateSimulationSession(sessionId, updates) {
    const session = this.activeSessions.get(sessionId);
    if (!session) {
      throw new Meteor.Error('session-not-found', `Session ${sessionId} not found`);
    }
    
    // Update database
    IasmsSimulationSessions.update(sessionId, { $set: updates });
    
    // Update active session
    Object.assign(session, updates);
    
    // If status changed to PAUSED or COMPLETED, handle accordingly
    if (updates.status === 'PAUSED' || updates.status === 'COMPLETED') {
      // Publish pause/complete event
      this._publishSessionUpdates(sessionId, [{
        type: 'session_status',
        status: updates.status,
        timestamp: new Date()
      }]);
      
      // If completed, remove from active sessions
      if (updates.status === 'COMPLETED') {
        this.activeSessions.delete(sessionId);
      }
    }
    
    return true;
  }

  /**
   * End simulation session
   * @param {string} sessionId - Session ID
   * @param {Object} results - Session results
   * @returns {boolean} True if session was ended successfully
   */
  endSimulationSession(sessionId, results = {}) {
    const session = this.activeSessions.get(sessionId);
    if (!session) {
      throw new Meteor.Error('session-not-found', `Session ${sessionId} not found`);
    }
    
    // Update database
    IasmsSimulationSessions.update(sessionId, {
      $set: {
        status: 'COMPLETED',
        endTime: new Date(),
        duration: new Date() - session.startTime,
        results
      }
    });
    
    // Publish session end event
    this._publishSessionUpdates(sessionId, [{
      type: 'session_end',
      timestamp: new Date(),
      results
    }]);
    
    // Remove from active sessions
    this.activeSessions.delete(sessionId);
    
    return true;
  }

  /**
   * Add entity to simulation
   * @param {string} sessionId - Session ID
   * @param {Object} entity - Entity data
   * @returns {string} Entity ID
   */
  addEntityToSimulation(sessionId, entity) {
    const session = this.activeSessions.get(sessionId);
    if (!session) {
      throw new Meteor.Error('session-not-found', `Session ${sessionId} not found`);
    }
    
    // Generate entity ID if not provided
    const entityId = entity.id || `entity_${Date.now()}_${Math.floor(Math.random() * 1000)}`;
    
    // Create update based on entity type
    let update = null;
    
    switch (entity.type) {
      case 'vehicle':
        update = {
          type: 'vehicle_create',
          entityId,
          vehicleType: entity.vehicleType || 'drone',
          vehicleCategory: entity.vehicleCategory || 'aerial',
          modelPath: entity.modelPath || this._getModelPathForType(entity.vehicleType),
          position: entity.position || { x: 0, y: 100, z: 0 },
          rotation: entity.rotation || { x: 0, y: 0, z: 0 },
          scale: entity.scale || 1.0,
          metadata: entity.metadata || {}
        };
        break;
      case 'hazard':
        update = {
          type: 'hazard_create',
          entityId,
          hazardType: entity.hazardType || 'GENERIC',
          visualType: entity.visualType || 'warning_zone',
          position: entity.position || { x: 0, y: 0, z: 0 },
          radius: entity.radius || 500,
          color: entity.color || '#ffaa00',
          severity: entity.severity || 0.5,
          expiryTime: entity.expiryTime || new Date(Date.now() + 3600000), // 1 hour
          metadata: entity.metadata || {}
        };
        break;
      case 'static':
        update = {
          type: 'static_create',
          entityId,
          objectType: entity.objectType || 'building',
          modelPath: entity.modelPath || '/assets/models/building.glb',
          position: entity.position || { x: 0, y: 0, z: 0 },
          rotation: entity.rotation || { x: 0, y: 0, z: 0 },
          scale: entity.scale || 1.0,
          metadata: entity.metadata || {}
        };
        break;
      default:
        throw new Meteor.Error('invalid-entity-type', `Invalid entity type: ${entity.type}`);
    }
    
    // Publish update
    this._publishSessionUpdates(sessionId, [update]);
    
    // Add to session entities
    IasmsSimulationSessions.update(sessionId, {
      $push: {
        entities: {
          id: entityId,
          type: entity.type,
          createdAt: new Date(),
          ...entity
        }
      }
    });
    
    return entityId;
  }

  /**
   * Update entity in simulation
   * @param {string} sessionId - Session ID
   * @param {string} entityId - Entity ID
   * @param {Object} updates - Entity updates
   * @returns {boolean} True if update was successful
   */
  updateEntity(sessionId, entityId, updates) {
    const session = this.activeSessions.get(sessionId);
    if (!session) {
      throw new Meteor.Error('session-not-found', `Session ${sessionId} not found`);
    }
    
    // Create update based on update type
    let update = {
      entityId,
      timestamp: new Date()
    };
    
    if (updates.position) {
      update.position = updates.position;
    }
    
    if (updates.rotation) {
      update.rotation = updates.rotation;
    }
    
    if (updates.scale) {
      update.scale = updates.scale;
    }
    
    if (updates.metadata) {
      update.metadata = updates.metadata;
    }
    
    // Add type-specific updates
    if (updates.type === 'vehicle') {
      update.type = 'vehicle_update';
      if (updates.vehicleType) update.vehicleType = updates.vehicleType;
      if (updates.vehicleCategory) update.vehicleCategory = updates.vehicleCategory;
      if (updates.modelPath) update.modelPath = updates.modelPath;
      if (updates.velocity) update.velocity = updates.velocity;
    } else if (updates.type === 'hazard') {
      update.type = 'hazard_update';
      if (updates.hazardType) update.hazardType = updates.hazardType;
      if (updates.visualType) update.visualType = updates.visualType;
      if (updates.radius) update.radius = updates.radius;
      if (updates.color) update.color = updates.color;
      if (updates.severity) update.severity = updates.severity;
      if (updates.expiryTime) update.expiryTime = updates.expiryTime;
    } else if (updates.type === 'static') {
      update.type = 'static_update';
      if (updates.objectType) update.objectType = updates.objectType;
      if (updates.modelPath) update.modelPath = updates.modelPath;
    }
    
    // Publish update
    this._publishSessionUpdates(sessionId, [update]);
    
    return true;
  }

  /**
   * Remove entity from simulation
   * @param {string} sessionId - Session ID
   * @param {string} entityId - Entity ID
   * @returns {boolean} True if removal was successful
   */
  removeEntity(sessionId, entityId) {
    const session = this.activeSessions.get(sessionId);
    if (!session) {
      throw new Meteor.Error('session-not-found', `Session ${sessionId} not found`);
    }
    
    // Create removal update
    const update = {
      type: 'entity_remove',
      entityId,
      timestamp: new Date()
    };
    
    // Publish update
    this._publishSessionUpdates(sessionId, [update]);
    
    // Remove from session entities
    IasmsSimulationSessions.update(sessionId, {
      $pull: {
        entities: { id: entityId }
      }
    });
    
    return true;
  }

  /**
   * Register a simulation model
   * @param {Object} model - Model configuration
   */
  registerSimulationModel(model) {
    this.simulationModels.set(model.type, model);
  }

  /**
   * Get registered models by category
   * @param {string} category - Model category
   * @returns {Array} Array of models
   */
  getModelsByCategory(category) {
    const models = [];
    
    for (const [type, model] of this.simulationModels.entries()) {
      if (!category || model.category === category) {
        models.push(model);
      }
    }
    
    return models;
  }

  /**
   * Create simulation scenario
   * @param {Object} scenario - Scenario data
   * @returns {string} Scenario ID
   */
  createScenario(scenario) {
    const { name, description, category, difficulty, entities, events } = scenario;
    
    // Create scenario
    return IasmsSimulationScenarios.insert({
      name: name || 'New Scenario',
      description: description || '',
      category: category || 'training',
      difficulty: difficulty || 'medium',
      entities: entities || [],
      events: events || [],
      createdBy: Meteor.userId() || 'SYSTEM',
      createdAt: new Date(),
      updatedAt: new Date(),
      metadata: scenario.metadata || {}
    });
  }

  /**
   * Get simulation scenario
   * @param {string} scenarioId - Scenario ID
   * @returns {Object} Scenario data
   */
  getScenario(scenarioId) {
    return IasmsSimulationScenarios.findOne(scenarioId);
  }

  /**
   * Get available simulation scenarios
   * @param {Object} filter - Filter criteria
   * @returns {Array} Array of scenarios
   */
  getScenarios(filter = {}) {
    return IasmsSimulationScenarios.find(filter).fetch();
  }

  /**
   * Record training completion
   * @param {string} sessionId - Session ID
   * @param {Object} data - Training data
   * @returns {string} Training record ID
   */
  recordTrainingCompletion(sessionId, data) {
    const session = IasmsSimulationSessions.findOne(sessionId);
    if (!session) {
      throw new Meteor.Error('session-not-found', `Session ${sessionId} not found`);
    }
    
    // Create training record
    return IasmsTrainingRecords.insert({
      userId: session.userId,
      sessionId,
      scenarioId: session.scenarioId,
      completionDate: new Date(),
      duration: session.duration || (session.endTime - session.startTime),
      score: data.score,
      passed: data.passed,
      evaluationData: data.evaluationData || {},
      feedback: data.feedback || '',
      metadata: data.metadata || {}
    });
  }

  /**
   * Get user training records
   * @param {string} userId - User ID
   * @returns {Array} Array of training records
   */
  getUserTrainingRecords(userId) {
    return IasmsTrainingRecords.find({ userId }, { sort: { completionDate: -1 } }).fetch();
  }
}

// Register Meteor methods
if (Meteor.isServer) {
  Meteor.methods({
    /**
     * Create simulation session
     * @param {Object} options - Session options
     * @returns {string} Session ID
     */
    'iasms.createSimulationSession': function(options) {
      check(options, {
        scenarioId: Match.Optional(String),
        name: Match.Optional(String),
        description: Match.Optional(String),
        syncWithRealWorld: Match.Optional(Boolean),
        entities: Match.Optional([Object]),
        settings: Match.Optional(Object),
        metadata: Match.Optional(Object)
      });
      
      const simulationModule = Meteor.server.iasmsServices.simulationTrainingModule;
      
      if (!simulationModule) {
        throw new Meteor.Error('service-unavailable', 'Simulation module is not available');
      }
      
      return simulationModule.createSimulationSession({
        userId: this.userId,
        ...options
      });
    },
    
    /**
     * Update simulation session
     * @param {string} sessionId - Session ID
     * @param {Object} updates - Session updates
     * @returns {boolean} True if update was successful
     */
    'iasms.updateSimulationSession': function(sessionId, updates) {
      check(sessionId, String);
      check(updates, {
        name: Match.Optional(String),
        description: Match.Optional(String),
        status: Match.Optional(String),
        syncWithRealWorld: Match.Optional(Boolean),
        settings: Match.Optional(Object),
        metadata: Match.Optional(Object)
      });
      
      const simulationModule = Meteor.server.iasmsServices.simulationTrainingModule;
      
      if (!simulationModule) {
        throw new Meteor.Error('service-unavailable', 'Simulation module is not available');
      }
      
      return simulationModule.updateSimulationSession(sessionId, updates);
    },
    
    /**
     * End simulation session
     * @param {string} sessionId - Session ID
     * @param {Object} results - Session results
     * @returns {boolean} True if session was ended successfully
     */
    'iasms.endSimulationSession': function(sessionId, results) {
      check(sessionId, String);
      check(results, Match.Optional(Object));
      
      const simulationModule = Meteor.server.iasmsServices.simulationTrainingModule;
      
      if (!simulationModule) {
        throw new Meteor.Error('service-unavailable', 'Simulation module is not available');
      }
      
      return simulationModule.endSimulationSession(sessionId, results);
    },
    
    /**
     * Add entity to simulation
     * @param {string} sessionId - Session ID
     * @param {Object} entity - Entity data
     * @returns {string} Entity ID
     */
    'iasms.addEntityToSimulation': function(sessionId, entity) {
      check(sessionId, String);
      check(entity, {
        type: String,
        id: Match.Optional(String),
        vehicleType: Match.Optional(String),
        vehicleCategory: Match.Optional(String),
        hazardType: Match.Optional(String),
        objectType: Match.Optional(String),
        position: Match.Optional(Object),
        rotation: Match.Optional(Object),
        scale: Match.Optional(Number),
        radius: Match.Optional(Number),
        color: Match.Optional(String),
        severity: Match.Optional(Number),
        expiryTime: Match.Optional(Date),
        modelPath: Match.Optional(String),
        metadata: Match.Optional(Object)
      });
      
      const simulationModule = Meteor.server.iasmsServices.simulationTrainingModule;
      
      if (!simulationModule) {
        throw new Meteor.Error('service-unavailable', 'Simulation module is not available');
      }
      
      return simulationModule.addEntityToSimulation(sessionId, entity);
    },
    
    /**
     * Update entity in simulation
     * @param {string} sessionId - Session ID
     * @param {string} entityId - Entity ID
     * @param {Object} updates - Entity updates
     * @returns {boolean} True if update was successful
     */
    'iasms.updateEntity': function(sessionId, entityId, updates) {
      check(sessionId, String);
      check(entityId, String);
      check(updates, Object);
      
      const simulationModule = Meteor.server.iasmsServices.simulationTrainingModule;
      
      if (!simulationModule) {
        throw new Meteor.Error('service-unavailable', 'Simulation module is not available');
      }
      
      return simulationModule.updateEntity(sessionId, entityId, updates);
    },
    
    /**
     * Remove entity from simulation
     * @param {string} sessionId - Session ID
     * @param {string} entityId - Entity ID
     * @returns {boolean} True if removal was successful
     */
    'iasms.removeEntity': function(sessionId, entityId) {
      check(sessionId, String);
      check(entityId, String);
      
      const simulationModule = Meteor.server.iasmsServices.simulationTrainingModule;
      
      if (!simulationModule) {
        throw new Meteor.Error('service-unavailable', 'Simulation module is not available');
      }
      
      return simulationModule.removeEntity(sessionId, entityId);
    },
    
    /**
     * Create simulation scenario
     * @param {Object} scenario - Scenario data
     * @returns {string} Scenario ID
     */
    'iasms.createScenario': function(scenario) {
      check(scenario, {
        name: String,
        description: Match.Optional(String),
        category: Match.Optional(String),
        difficulty: Match.Optional(String),
        entities: Match.Optional([Object]),
        events: Match.Optional([Object]),
        metadata: Match.Optional(Object)
      });
      
      const simulationModule = Meteor.server.iasmsServices.simulationTrainingModule;
      
      if (!simulationModule) {
        throw new Meteor.Error('service-unavailable', 'Simulation module is not available');
      }
      
      return simulationModule.createScenario(scenario);
    },
    
    /**
     * Get available simulation scenarios
     * @param {Object} filter - Filter criteria
     * @returns {Array} Array of scenarios
     */
    'iasms.getScenarios': function(filter) {
      check(filter, Match.Optional(Object));
      
      const simulationModule = Meteor.server.iasmsServices.simulationTrainingModule;
      
      if (!simulationModule) {
        throw new Meteor.Error('service-unavailable', 'Simulation module is not available');
      }
      
      return simulationModule.getScenarios(filter || {});
    },
    
    /**
     * Record training completion
     * @param {string} sessionId - Session ID
     * @param {Object} data - Training data
     * @returns {string} Training record ID
     */
    'iasms.recordTrainingCompletion': function(sessionId, data) {
      check(sessionId, String);
      check(data, {
        score: Number,
        passed: Boolean,
        evaluationData: Match.Optional(Object),
        feedback: Match.Optional(String),
        metadata: Match.Optional(Object)
      });
      
      const simulationModule = Meteor.server.iasmsServices.simulationTrainingModule;
      
      if (!simulationModule) {
        throw new Meteor.Error('service-unavailable', 'Simulation module is not available');
      }
      
      return simulationModule.recordTrainingCompletion(sessionId, data);
    },
    
    /**
     * Get user training records
     * @returns {Array} Array of training records
     */
    'iasms.getUserTrainingRecords': function() {
      if (!this.userId) {
        throw new Meteor.Error('not-authorized', 'You must be logged in to get training records');
      }
      
      const simulationModule = Meteor.server.iasmsServices.simulationTrainingModule;
      
      if (!simulationModule) {
        throw new Meteor.Error('service-unavailable', 'Simulation module is not available');
      }
      
      return simulationModule.getUserTrainingRecords(this.userId);
    }
  });
}
```


Now, let's create a server-side initialization module that will integrate our simulation module with the IASMS system:

```javascript
/**
 * /server/iasms/IasmsSimulationIntegration.js
 * 
 * IASMS Simulation Integration
 * Initializes and integrates the simulation and training module with the IASMS system
 * 
 * Copyright 2025 Autonomy Association International Inc., all rights reserved 
 * Safeguard patent license from National Aeronautics and Space Administration (NASA)
 * Copyright 2025 NASA, all rights reserved
 */

import { Meteor } from 'meteor/meteor';
import { WebApp } from 'meteor/webapp';
import { IasmsSimulationTrainingModule } from './modules/IasmsSimulationTrainingModule';

// Create streamer for real-time updates
import { Streamer } from 'meteor/rocketchat:streamer';

// Initialize integration
Meteor.startup(() => {
  console.log('Initializing IASMS Simulation Integration...');
  
  // Create simulation streamer
  const simulationStreamer = new Streamer('iasms-simulation');
  
  // Make streamer available globally
  Meteor.server.simulationStreamer = simulationStreamer;
  
  // Create simulation module
  const simulationModule = new IasmsSimulationTrainingModule({
    enableRealTimeSync: true,
    syncInterval: 1000,
    recordTelemetry: true
  });
  
  // Initialize the module
  simulationModule.initialize().then(() => {
    // Register module with IASMS server
    if (Meteor.server.iasmsServices) {
      Meteor.server.iasmsServices.simulationTrainingModule = simulationModule;
      console.log('Simulation Training Module registered with IASMS server');
    } else {
      console.warn('IASMS services not available, running simulation module standalone');
      // Create services object if it doesn't exist
      Meteor.server.iasmsServices = {
        simulationTrainingModule: simulationModule
      };
    }
  }).catch(error => {
    console.error('Failed to initialize Simulation Training Module:', error);
  });
  
  // Setup WebSockets for simulation
  setupSimulationWebSockets();
});

/**
 * Setup WebSockets for simulation
 */
function setupSimulationWebSockets() {
  // Configure authentication for streamer
  const simulationStreamer = Meteor.server.simulationStreamer;
  
  simulationStreamer.allowRead('all');
  simulationStreamer.allowWrite('all');
  
  console.log('Simulation WebSockets initialized');
}

// Export module for use in other server code
export const getSimulationModule = () => {
  return Meteor.server.iasmsServices?.simulationTrainingModule;
};
```


Finally, let's create a client-side integration component that will connect to our simulation module:

```javascript
/**
 * /client/iasms/SimulationIntegrationClient.js
 * 
 * IASMS Simulation Integration Client
 * Provides client-side integration with the IASMS simulation system
 * 
 * Copyright 2025 Autonomy Association International Inc., all rights reserved 
 * Safeguard patent license from National Aeronautics and Space Administration (NASA)
 * Copyright 2025 NASA, all rights reserved
 */

import { Meteor } from 'meteor/meteor';
import { ReactiveVar } from 'meteor/reactive-var';
import { Streamer } from 'meteor/rocketchat:streamer';

class SimulationClient {
  constructor() {
    this.activeSession = new ReactiveVar(null);
    this.entities = new ReactiveVar({});
    this.events = new ReactiveVar([]);
    this.status = new ReactiveVar('DISCONNECTED');
    this.streamer = new Streamer('iasms-simulation');
    this.subscriptions = [];
    this.callbacks = {
      entityUpdate: [],
      sessionStatus: [],
      notification: []
    };
  }
  
  /**
   * Initialize the simulation client
   * @returns {Promise<boolean>} True if initialization was successful
   */
  async initialize() {
    this.status.set('INITIALIZING');
    
    try {
      // Setup streamer
      this._setupStreamer();
      
      // Subscribe to active sessions
      this._subscribeToSessions();
      
      this.status.set('READY');
      return true;
    } catch (error) {
      console.error('Failed to initialize Simulation Client:', error);
      this.status.set('ERROR');
      return false;
    }
  }
  
  /**
   * Setup streamer for real-time updates
   * @private
   */
  _setupStreamer() {
    this.streamer.on('connect', () => {
      console.log('Connected to simulation streamer');
    });
    
    this.streamer.on('disconnect', () => {
      console.log('Disconnected from simulation streamer');
    });
  }
  
  /**
   * Subscribe to active sessions
   * @private
   */
  _subscribeToSessions() {
    const sub = Meteor.subscribe('iasms.activeSimulationSessions');
    this.subscriptions.push(sub);
  }
  
  /**
   * Join a simulation session
   * @param {string} sessionId - Session ID
   * @returns {Promise<boolean>} True if join was successful
   */
  async joinSession(sessionId) {
    this.status.set('CONNECTING');
    
    try {
      // Get session details
      const session = await this._getSessionDetails(sessionId);
      
      if (!session) {
        throw new Error(`Session ${sessionId} not found`);
      }
      
      // Subscribe to session updates
      this._subscribeToSessionStream(sessionId);
      
      // Store active session
      this.activeSession.set(session);
      
      // Clear entities
      this.entities.set({});
      
      // Clear events
      this.events.set([]);
      
      this.status.set('CONNECTED');
      return true;
    } catch (error) {
      console.error(`Failed to join session ${sessionId}:`, error);
      this.status.set('ERROR');
      return false;
    }
  }
  
  /**
   * Get session details
   * @param {string} sessionId - Session ID
   * @returns {Promise<Object>} Session details
   * @private
   */
  async _getSessionDetails(sessionId) {
    return new Promise((resolve, reject) => {
      Meteor.call('iasms.getSimulationSession', sessionId, (error, result) => {
        if (error) {
          reject(error);
        } else {
          resolve(result);
        }
      });
    });
  }
  
  /**
   * Subscribe to session stream
   * @param {string} sessionId - Session ID
   * @private
   */
  _subscribeToSessionStream(sessionId) {
    // Unsubscribe from previous streams
    this._unsubscribeFromStreams();
    
    // Subscribe to session stream
    this.streamer.on(`session_${sessionId}`, this._handleSessionUpdate.bind(this));
  }
  
  /**
   * Unsubscribe from streams
   * @private
   */
  _unsubscribeFromStreams() {
    const session = this.activeSession.get();
    
    if (session) {
      this.streamer.removeListener(`session_${session._id}`);
    }
  }
  
  /**
   * Handle session update
   * @param {Object} update - Session update
   * @private
   */
  _handleSessionUpdate(update) {
    if (!update) return;
    
    switch (update.type) {
      case 'entity_updates':
        this._handleEntityUpdates(update.updates);
        break;
      case 'session_status':
        this._handleSessionStatus(update);
        break;
      case 'session_end':
        this._handleSessionEnd(update);
        break;
      case 'notification':
        this._handleNotification(update);
        break;
    }
  }
  
  /**
   * Handle entity updates
   * @param {Array} updates - Entity updates
   * @private
   */
  _handleEntityUpdates(updates) {
    if (!updates || !Array.isArray(updates)) return;
    
    const entities = { ...this.entities.get() };
    
    updates.forEach(update => {
      const entityId = update.entityId;
      
      if (!entityId) return;
      
      switch (update.type) {
        case 'vehicle_create':
        case 'vehicle_update':
          entities[entityId] = {
            ...entities[entityId],
            ...update,
            lastUpdated: new Date()
          };
          break;
        case 'hazard_create':
        case 'hazard_update':
          entities[entityId] = {
            ...entities[entityId],
            ...update,
            lastUpdated: new Date()
          };
          break;
        case 'static_create':
        case 'static_update':
          entities[entityId] = {
            ...entities[entityId],
            ...update,
            lastUpdated: new Date()
          };
          break;
        case 'risk_update':
          entities[entityId] = {
            ...entities[entityId],
            ...update,
            lastUpdated: new Date()
          };
          break;
        case 'lostlink_update':
          entities[entityId] = {
            ...entities[entityId],
            ...update,
            lastUpdated: new Date()
          };
          break;
        case 'contingency_update':
          entities[entityId] = {
            ...entities[entityId],
            ...update,
            lastUpdated: new Date()
          };
          break;
        case 'vertiport_emergency_update':
          entities[entityId] = {
            ...entities[entityId],
            ...update,
            lastUpdated: new Date()
          };
          break;
        case 'entity_remove':
          delete entities[entityId];
          break;
      }
    });
    
    this.entities.set(entities);
    
    // Call entity update callbacks
    this.callbacks.entityUpdate.forEach(callback => {
      try {
        callback(updates);
      } catch (error) {
        console.error('Error in entity update callback:', error);
      }
    });
  }
  
  /**
   * Handle session status update
   * @param {Object} update - Status update
   * @private
   */
  _handleSessionStatus(update) {
    const session = this.activeSession.get();
    
    if (session) {
      // Update session status
      session.status = update.status;
      this.activeSession.set(session);
      
      // Call session status callbacks
      this.callbacks.sessionStatus.forEach(callback => {
        try {
          callback(update);
        } catch (error) {
          console.error('Error in session status callback:', error);
        }
      });
    }
  }
  
  /**
   * Handle session end
   * @param {Object} update - End update
   * @private
   */
  _handleSessionEnd(update) {
    // Update session status
    const session = this.activeSession.get();
    
    if (session) {
      session.status = 'COMPLETED';
      session.results = update.results;
      this.activeSession.set(session);
      
      // Unsubscribe from streams
      this._unsubscribeFromStreams();
      
      // Call session status callbacks
      this.callbacks.sessionStatus.forEach(callback => {
        try {
          callback({
            type: 'session_status',
            status: 'COMPLETED',
            results: update.results
          });
        } catch (error) {
          console.error('Error in session status callback:', error);
        }
      });
    }
  }
  
  /**
   * Handle notification
   * @param {Object} notification - Notification
   * @private
   */
  _handleNotification(notification) {
    // Add to events
    const events = this.events.get();
    events.push({
      time: new Date(),
      ...notification
    });
    this.events.set(events);
    
    // Call notification callbacks
    this.callbacks.notification.forEach(callback => {
      try {
        callback(notification);
      } catch (error) {
        console.error('Error in notification callback:', error);
      }
    });
  }
  
  /**
   * Leave current session
   */
  leaveSession() {
    // Unsubscribe from streams
    this._unsubscribeFromStreams();
    
    // Clear active session
    this.activeSession.set(null);
    
    // Clear entities
    this.entities.set({});
    
    // Clear events
    this.events.set([]);
    
    this.status.set('DISCONNECTED');
  }
  
  /**
   * Create a new simulation session
   * @param {Object} options - Session options
   * @returns {Promise<string>} Session ID
   */
  async createSession(options) {
    return new Promise((resolve, reject) => {
      Meteor.call('iasms.createSimulationSession', options, (error, result) => {
        if (error) {
          reject(error);
        } else {
          resolve(result);
        }
      });
    });
  }
  
  /**
   * Update current session
   * @param {Object} updates - Session updates
   * @returns {Promise<boolean>} True if update was successful
   */
  async updateSession(updates) {
    const session = this.activeSession.get();
    
    if (!session) {
      throw new Error('No active session');
    }
    
    return new Promise((resolve, reject) => {
      Meteor.call('iasms.updateSimulationSession', session._id, updates, (error, result) => {
        if (error) {
          reject(error);
        } else {
          resolve(result);
        }
      });
    });
  }
  
  /**
   * End current session
   * @param {Object} results - Session results
   * @returns {Promise<boolean>} True if session was ended successfully
   */
  async endSession(results = {}) {
    const session = this.activeSession.get();
    
    if (!session) {
      throw new Error('No active session');
    }
    
    return new Promise((resolve, reject) => {
      Meteor.call('iasms.endSimulationSession', session._id, results, (error, result) => {
        if (error) {
          reject(error);
        } else {
          resolve(result);
        }
      });
    });
  }
  
  /**
   * Add entity to simulation
   * @param {Object} entity - Entity data
   * @returns {Promise<string>} Entity ID
   */
  async addEntity(entity) {
    const session = this.activeSession.get();
    
    if (!session) {
      throw new Error('No active session');
    }
    
    return new Promise((resolve, reject) => {
      Meteor.call('iasms.addEntityToSimulation', session._id, entity, (error, result) => {
        if (error) {
          reject(error);
        } else {
          resolve(result);
        }
      });
    });
  }
  
  /**
   * Update entity in simulation
   * @param {string} entityId - Entity ID
   * @param {Object} updates - Entity updates
   * @returns {Promise<boolean>} True if update was successful
   */
  async updateEntity(entityId, updates) {
    const session = this.activeSession.get();
    
    if (!session) {
      throw new Error('No active session');
    }
    
    return new Promise((resolve, reject) => {
      Meteor.call('iasms.updateEntity', session._id, entityId, updates, (error, result) => {
        if (error) {
          reject(error);
        } else {
          resolve(result);
        }
      });
    });
  }
  
  /**
   * Remove entity from simulation
   * @param {string} entityId - Entity ID
   * @returns {Promise<boolean>} True if removal was successful
   */
  async removeEntity(entityId) {
    const session = this.activeSession.get();
    
    if (!session) {
      throw new Error('No active session');
    }
    
    return new Promise((resolve, reject) => {
      Meteor.call('iasms.removeEntity', session._id, entityId, (error, result) => {
        if (error) {
          reject(error);
        } else {
          resolve(result);
        }
      });
    });
  }
  
  /**
   * Get available scenarios
   * @param {Object} filter - Filter criteria
   * @returns {Promise<Array>} Array of scenarios
   */
  async getScenarios(filter = {}) {
    return new Promise((resolve, reject) => {
      Meteor.call('iasms.getScenarios', filter, (error, result) => {
        if (error) {
          reject(error);
        } else {
          resolve(result);
        }
      });
    });
  }
  
  /**
   * Record training completion
   * @param {Object} data - Training data
   * @returns {Promise<string>} Training record ID
   */
  async recordTrainingCompletion(data) {
    const session = this.activeSession.get();
    
    if (!session) {
      throw new Error('No active session');
    }
    
    return new Promise((resolve, reject) => {
      Meteor.call('iasms.recordTrainingCompletion', session._id, data, (error, result) => {
        if (error) {
          reject(error);
        } else {
          resolve(result);
        }
      });
    });
  }
  
  /**
   * Get user training records
   * @returns {Promise<Array>} Array of training records
   */
  async getUserTrainingRecords() {
    return new Promise((resolve, reject) => {
      Meteor.call('iasms.getUserTrainingRecords', (error, result) => {
        if (error) {
          reject(error);
        } else {
          resolve(result);
        }
      });
    });
  }
  
  /**
   * Register entity update callback
   * @param {Function} callback - Callback function
   * @returns {number} Callback ID
   */
  onEntityUpdate(callback) {
    if (typeof callback === 'function') {
      this.callbacks.entityUpdate.push(callback);
      return this.callbacks.entityUpdate.length - 1;
    }
    return -1;
  }
  
  /**
   * Register session status callback
   * @param {Function} callback - Callback function
   * @returns {number} Callback ID
   */
  onSessionStatus(callback) {
    if (typeof callback === 'function') {
      this.callbacks.sessionStatus.push(callback);
      return this.callbacks.sessionStatus.length - 1;
    }
    return -1;
  }
  
  /**
   * Register notification callback
   * @param {Function} callback - Callback function
   * @returns {number} Callback ID
   */
  onNotification(callback) {
    if (typeof callback === 'function') {
      this.callbacks.notification.push(callback);
      return this.callbacks.notification.length - 1;
    }
    return -1;
  }
  
  /**
   * Remove callback
   * @param {string} type - Callback type
   * @param {number} id - Callback ID
   */
  removeCallback(type, id) {
    if (this.callbacks[type] && id >= 0 && id < this.callbacks[type].length) {
      this.callbacks[type][id] = null;
    }
  }
}

// Create singleton instance
export const SimulationIntegration = new SimulationClient();

// Initialize on startup
Meteor.startup(() => {
  SimulationIntegration.initialize().then(() => {
    console.log('Simulation Integration Client initialized');
  }).catch(error => {
    console.error('Failed to initialize Simulation Integration Client:', error);
  });
});
```


Now, let's create a simple React component to integrate with our 3D environment:

```textmate
/**
 * /client/iasms/components/Simulation3DViewer.jsx
 * 
 * 3D Simulation Viewer Component
 * Integrates with the IASMS simulation system
 * 
 * Copyright 2025 Autonomy Association International Inc., all rights reserved 
 * Safeguard patent license from National Aeronautics and Space Administration (NASA)
 * Copyright 2025 NASA, all rights reserved
 */

import React, { useEffect, useRef, useState } from 'react';
import { SimulationIntegration } from '../SimulationIntegrationClient';
import * as THREE from 'three';
import { AerialModalityManager } from '../../simulator-3-webXR-Meta-react/AerialVehicleManager';

const Simulation3DViewer = ({ sessionId, width = '100%', height = '600px' }) => {
  const containerRef = useRef(null);
  const [isInitialized, setIsInitialized] = useState(false);
  const [entities, setEntities] = useState({});
  const [session, setSession] = useState(null);
  const [status, setStatus] = useState('INITIALIZING');
  
  // Store Three.js objects
  const sceneRef = useRef(null);
  const cameraRef = useRef(null);
  const rendererRef = useRef(null);
  const aerialManagerRef = useRef(null);
  const animationFrameRef = useRef(null);
  
  // Initialize Three.js scene
  useEffect(() => {
    if (!containerRef.current) return;
    
    // Create scene
    const scene = new THREE.Scene();
    sceneRef.current = scene;
    
    // Add ambient light
    const ambientLight = new THREE.AmbientLight(0xffffff, 0.5);
    scene.add(ambientLight);
    
    // Add directional light (sun)
    const sunLight = new THREE.DirectionalLight(0xffffff, 1);
    sunLight.position.set(100, 100, 50);
    sunLight.castShadow = true;
    scene.add(sunLight);
    
    // Configure shadow properties
    sunLight.shadow.mapSize.width = 2048;
    sunLight.shadow.mapSize.height = 2048;
    sunLight.shadow.camera.near = 0.5;
    sunLight.shadow.camera.far = 500;
    sunLight.shadow.camera.left = -100;
    sunLight.shadow.camera.right = 100;
    sunLight.shadow.camera.top = 100;
    sunLight.shadow.camera.bottom = -100;
    
    // Create camera
    const camera = new THREE.PerspectiveCamera(
      75,
      containerRef.current.clientWidth / containerRef.current.clientHeight,
      0.1,
      10000
    );
    camera.position.set(0, 200, 200);
    camera.lookAt(0, 0, 0);
    cameraRef.current = camera;
    
    // Create renderer
    const renderer = new THREE.WebGLRenderer({ antialias: true });
    renderer.setSize(containerRef.current.clientWidth, containerRef.current.clientHeight);
    renderer.shadowMap.enabled = true;
    renderer.shadowMap.type = THREE.PCFSoftShadowMap;
    containerRef.current.appendChild(renderer.domElement);
    rendererRef.current = renderer;
    
    // Create ground plane
    const groundGeometry = new THREE.PlaneGeometry(5000, 5000);
    const groundMaterial = new THREE.MeshStandardMaterial({
      color: 0x88aa88,
      roughness: 0.8,
      metalness: 0.2,
      side: THREE.DoubleSide
    });
    const ground = new THREE.Mesh(groundGeometry, groundMaterial);
    ground.rotation.x = Math.PI / 2;
    ground.position.y = -0.1;
    ground.receiveShadow = true;
    scene.add(ground);
    
    // Create aerial modality manager
    const aerialManager = new AerialModalityManager(scene, null);
    aerialManager.initialize();
    aerialManagerRef.current = aerialManager;
    
    // Animation loop
    const animate = () => {
      animationFrameRef.current = requestAnimationFrame(animate);
      
      // Update aerial vehicles
      if (aerialManagerRef.current) {
        aerialManagerRef.current.update(0.016, null, false);
      }
      
      // Render scene
      rendererRef.current.render(sceneRef.current, cameraRef.current);
    };
    
    animate();
    
    // Handle window resize
    const handleResize = () => {
      if (!containerRef.current || !cameraRef.current || !rendererRef.current) return;
      
      const width = containerRef.current.clientWidth;
      const height = containerRef.current.clientHeight;
      
      cameraRef.current.aspect = width / height;
      cameraRef.current.updateProjectionMatrix();
      
      rendererRef.current.setSize(width, height);
    };
    
    window.addEventListener('resize', handleResize);
    
    setIsInitialized(true);
    
    // Cleanup
    return () => {
      window.removeEventListener('resize', handleResize);
      
      if (animationFrameRef.current) {
        cancelAnimationFrame(animationFrameRef.current);
      }
      
      if (rendererRef.current && containerRef.current) {
        containerRef.current.removeChild(rendererRef.current.domElement);
      }
      
      if (aerialManagerRef.current) {
        aerialManagerRef.current.cleanup();
      }
    };
  }, []);
  
  // Join simulation session
  useEffect(() => {
    if (!isInitialized || !sessionId) return;
    
    setStatus('CONNECTING');
    
    SimulationIntegration.joinSession(sessionId)
      .then(success => {
        if (success) {
          setStatus('CONNECTED');
          setSession(SimulationIntegration.activeSession.get());
        } else {
          setStatus('ERROR');
        }
      })
      .catch(error => {
        console.error('Error joining session:', error);
        setStatus('ERROR');
      });
    
    // Register for entity updates
    const entityUpdateId = SimulationIntegration.onEntityUpdate(handleEntityUpdates);
    const sessionStatusId = SimulationIntegration.onSessionStatus(handleSessionStatus);
    
    // Cleanup
    return () => {
      SimulationIntegration.removeCallback('entityUpdate', entityUpdateId);
      SimulationIntegration.removeCallback('sessionStatus', sessionStatusId);
      SimulationIntegration.leaveSession();
    };
  }, [isInitialized, sessionId]);
  
  // Handle entity updates
  const handleEntityUpdates = updates => {
    // Update entities state
    setEntities(SimulationIntegration.entities.get());
    
    // Process updates to add/update 3D objects
    if (!updates || !Array.isArray(updates)) return;
    
    updates.forEach(update => {
      const entityId = update.entityId;
      
      if (!entityId) return;
      
      switch (update.type) {
        case 'vehicle_create':
        case 'vehicle_update':
          updateVehicleEntity(entityId, update);
          break;
        case 'hazard_create':
        case 'hazard_update':
          updateHazardEntity(entityId, update);
          break;
        case 'entity_remove':
          removeEntity(entityId);
          break;
      }
    });
  };
  
  // Handle session status updates
  const handleSessionStatus = update => {
    setSession(SimulationIntegration.activeSession.get());
    setStatus(update.status);
  };
  
  // Update vehicle entity
  const updateVehicleEntity = (entityId, update) => {
    if (!aerialManagerRef.current) return;
    
    // Check if vehicle already exists
    let vehicle = sceneRef.current.getObjectByName(entityId);
    
    if (!vehicle) {
      // Create new vehicle
      vehicle = aerialManagerRef.current.createVehicle({
        id: entityId,
        type: update.vehicleType || 'drone',
        position: {
          x: update.position.x,
          y: update.position.y,
          z: update.position.z
        },
        rotation: {
          x: update.rotation.x,
          y: update.rotation.y,
          z: update.rotation.z
        },
        color: update.metadata?.color
      });
    } else {
      // Update existing vehicle
      vehicle.position.set(
        update.position.x,
        update.position.y,
        update.position.z
      );
      
      vehicle.rotation.set(
        update.rotation.x,
        update.rotation.y,
        update.rotation.z
      );
    }
  };
  
  // Update hazard entity
  const updateHazardEntity = (entityId, update) => {
    if (!sceneRef.current) return;
    
    // Check if hazard already exists
    let hazard = sceneRef.current.getObjectByName(entityId);
    
    if (!hazard) {
      // Create new hazard
      const geometry = new THREE.SphereGeometry(update.radius, 32, 32);
      const material = new THREE.MeshBasicMaterial({
        color: update.color || 0xffaa00,
        transparent: true,
        opacity: 0.3,
        side: THREE.DoubleSide
      });
      
      hazard = new THREE.Mesh(geometry, material);
      hazard.name = entityId;
      hazard.position.set(
        update.position.x,
        update.position.y,
        update.position.z
      );
      
      sceneRef.current.add(hazard);
    } else {
      // Update existing hazard
      hazard.position.set(
        update.position.x,
        update.position.y,
        update.position.z
      );
      
      // Update radius if changed
      if (update.radius !== hazard.geometry.parameters.radius) {
        hazard.geometry.dispose();
        hazard.geometry = new THREE.SphereGeometry(update.radius, 32, 32);
      }
      
      // Update color if changed
      if (update.color && hazard.material.color.getHex() !== new THREE.Color(update.color).getHex()) {
        hazard.material.color.set(update.color);
      }
      
      // Update opacity based on severity
      if (update.severity !== undefined) {
        hazard.material.opacity = 0.2 + (update.severity * 0.3);
      }
    }
  };
  
  // Remove entity
  const removeEntity = (entityId) => {
    if (!sceneRef.current) return;
    
    const entity = sceneRef.current.getObjectByName(entityId);
    
    if (entity) {
      sceneRef.current.remove(entity);
      
      if (entity.geometry) entity.geometry.dispose();
      if (entity.material) {
        if (Array.isArray(entity.material)) {
          entity.material.forEach(material => material.dispose());
        } else {
          entity.material.dispose();
        }
      }
    }
  };
  
  return (
    <div style={{ position: 'relative', width, height }}>
      <div 
        ref={containerRef} 
        style={{ 
          width: '100%', 
          height: '100%', 
          overflow: 'hidden',
          borderRadius: '4px',
          backgroundColor: '#87ceeb'
        }}
      />
      
      {status !== 'CONNECTED' && (
        <div style={{
          position: 'absolute',
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
          backgroundColor: 'rgba(0, 0, 0, 0.5)',
          color: 'white',
          fontSize: '18px',
          fontWeight: 'bold'
        }}>
          {status === 'INITIALIZING' && 'Initializing...'}
          {status === 'CONNECTING' && 'Connecting to simulation...'}
          {status === 'ERROR' && 'Error connecting to simulation'}
          {status === 'DISCONNECTED' && 'Disconnected from simulation'}
        </div>
      )}
      
      {/* Session info overlay */}
      {session && status === 'CONNECTED' && (
        <div style={{
          position: 'absolute',
          top: '10px',
          left: '10px',
          backgroundColor: 'rgba(0, 0, 0, 0.7)',
          color: 'white',
          padding: '10px',
          borderRadius: '4px',
          maxWidth: '300px'
        }}>
          <div style={{ fontSize: '16px', fontWeight: 'bold', marginBottom: '5px' }}>
            {session.name || 'Simulation Session'}
          </div>
          <div style={{ fontSize: '12px' }}>
            Status: {session.status}
          </div>
          <div style={{ fontSize: '12px' }}>
            Entities: {Object.keys(entities).length}
          </div>
        </div>
      )}
    </div>
  );
};

export default Simulation3DViewer;
```


Finally, let's create a higher-level component that will use our 3D viewer to integrate with the IASMS system:

```textmate
/**
 * /client/iasms/components/SimulationTrainingModule.jsx
 * 
 * Simulation Training Module Component
 * Main component for the IASMS simulation and training module
 * 
 * Copyright 2025 Autonomy Association International Inc., all rights reserved 
 * Safeguard patent license from National Aeronautics and Space Administration (NASA)
 * Copyright 2025 NASA, all rights reserved
 */

import React, { useState, useEffect } from 'react';
import { Meteor } from 'meteor/meteor';
import { useTracker } from 'meteor/react-meteor-data';
import { SimulationIntegration } from '../SimulationIntegrationClient';
import Simulation3DViewer from './Simulation3DViewer';

const SimulationTrainingModule = ({ onClose }) => {
  const [activeTab, setActiveTab] = useState('scenarios');
  const [selectedScenario, setSelectedScenario] = useState(null);
  const [activeSession, setActiveSession] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  
  // Track available scenarios
  const { scenarios, scenariosLoading } = useTracker(() => {
    const handle = Meteor.subscribe('iasms.simulationScenarios');
    
    return {
      scenarios: IasmsSimulationScenarios.find({}, { sort: { category: 1, name: 1 } }).fetch(),
      scenariosLoading: !handle.ready()
    };
  }, []);
  
  // Track active sessions
  const { sessions, sessionsLoading } = useTracker(() => {
    const handle = Meteor.subscribe('iasms.activeSimulationSessions');
    
    return {
      sessions: IasmsSimulationSessions.find({ status: { $in: ['ACTIVE', 'PAUSED'] } }, { sort: { startTime: -1 } }).fetch(),
      sessionsLoading: !handle.ready()
    };
  }, []);
  
  // Start a new simulation session
  const startSimulation = async (scenario) => {
    setLoading(true);
    setError(null);
    
    try {
      const sessionId = await SimulationIntegration.createSession({
        scenarioId: scenario._id,
        name: `${scenario.name} Session`,
        description: scenario.description,
        syncWithRealWorld: true
      });
      
      setActiveSession(sessionId);
      setActiveTab('simulation');
      setLoading(false);
    } catch (error) {
      console.error('Error starting simulation:', error);
      setError('Failed to start simulation. Please try again.');
      setLoading(false);
    }
  };
  
  // Join an existing session
  const joinSession = (sessionId) => {
    setActiveSession(sessionId);
    setActiveTab('simulation');
  };
  
  // End the current session
  const endSession = async () => {
    setLoading(true);
    
    try {
      await SimulationIntegration.endSession();
      setActiveSession(null);
      setActiveTab('scenarios');
      setLoading(false);
    } catch (error) {
      console.error('Error ending session:', error);
      setError('Failed to end session. Please try again.');
      setLoading(false);
    }
  };
  
  // Render scenarios tab
  const renderScenariosTab = () => {
    if (scenariosLoading) {
      return <div className="loading">Loading scenarios...</div>;
    }
    
    if (!scenarios || scenarios.length === 0) {
      return <div className="empty-state">No simulation scenarios available.</div>;
    }
    
    // Group scenarios by category
    const categorizedScenarios = scenarios.reduce((acc, scenario) => {
      const category = scenario.category || 'Uncategorized';
      if (!acc[category]) {
        acc[category] = [];
      }
      acc[category].push(scenario);
      return acc;
    }, {});
    
    return (
      <div className="scenarios-container">
        {Object.entries(categorizedScenarios).map(([category, scenarioList]) => (
          <div key={category} className="scenario-category">
            <h3>{category}</h3>
            <div className="scenario-list">
              {scenarioList.map(scenario => (
                <div 
                  key={scenario._id} 
                  className={`scenario-card ${selectedScenario?._id === scenario._id ? 'selected' : ''}`}
                  onClick={() => setSelectedScenario(scenario)}
                >
                  <h4>{scenario.name}</h4>
                  <div className="difficulty">
                    Difficulty: {scenario.difficulty || 'Medium'}
                  </div>
                  <p>{scenario.description}</p>
                  
                  <button 
                    className="start-button"
                    onClick={(e) => {
                      e.stopPropagation();
                      startSimulation(scenario);
                    }}
                    disabled={loading}
                  >
                    Start Simulation
                  </button>
                </div>
              ))}
            </div>
          </div>
        ))}
      </div>
    );
  };
  
  // Render sessions tab
  const renderSessionsTab = () => {
    if (sessionsLoading) {
      return <div className="loading">Loading active sessions...</div>;
    }
    
    if (!sessions || sessions.length === 0) {
      return <div className="empty-state">No active simulation sessions.</div>;
    }
    
    return (
      <div className="sessions-container">
        <div className="session-list">
          {sessions.map(session => (
            <div key={session._id} className="session-card">
              <h4>{session.name}</h4>
              <div className="session-info">
                <div>Status: {session.status}</div>
                <div>Started: {new Date(session.startTime).toLocaleString()}</div>
                {session.scenarioId && (
                  <div>
                    Scenario: {
                      scenarios.find(s => s._id === session.scenarioId)?.name || 'Unknown'
                    }
                  </div>
                )}
              </div>
              
              <button 
                className="join-button"
                onClick={() => joinSession(session._id)}
              >
                Join Session
              </button>
            </div>
          ))}
        </div>
      </div>
    );
  };
  
  // Render simulation tab
  const renderSimulationTab = () => {
    if (!activeSession) {
      return <div className="empty-state">No active simulation session.</div>;
    }
    
    return (
      <div className="simulation-container">
        <Simulation3DViewer sessionId={activeSession} width="100%" height="600px" />
        
        <div className="simulation-controls">
          <button 
            className="end-session-button"
            onClick={endSession}
            disabled={loading}
          >
            End Session
          </button>
        </div>
      </div>
    );
  };
  
  return (
    <div className="simulation-training-module">
      <div className="module-header">
        <h2>IASMS Simulation & Training</h2>
        
        {activeTab !== 'simulation' && (
          <div className="tab-navigation">
            <button 
              className={activeTab === 'scenarios' ? 'active' : ''}
              onClick={() => setActiveTab('scenarios')}
            >
              Scenarios
            </button>
            <button 
              className={activeTab === 'sessions' ? 'active' : ''}
              onClick={() => setActiveTab('sessions')}
            >
              Active Sessions
            </button>
          </div>
        )}
        
        {activeTab === 'simulation' && (
          <button 
            className="back-button"
            onClick={() => {
              if (window.confirm('Are you sure you want to leave the simulation?')) {
                setActiveSession(null);
                setActiveTab('scenarios');
              }
            }}
          >
            Back to Scenarios
          </button>
        )}
        
        {onClose && (
          <button className="close-button" onClick={onClose}>
            Close
          </button>
        )}
      </div>
      
      {error && <div className="error-message">{error}</div>}
      
      <div className="module-content">
        {activeTab === 'scenarios' && renderScenariosTab()}
        {activeTab === 'sessions' && renderSessionsTab()}
        {activeTab === 'simulation' && renderSimulationTab()}
      </div>
    </div>
  );
};

export default SimulationTrainingModule;
```


These files work together to provide a complete integration between our 3D simulation components and the IASMS system. Here's how they fit together:

1. `IasmsSimulationTrainingModule.js` - The server-side module that integrates with the IASMS core services, handling data exchange and events.
2. `IasmsSimulationIntegration.js` - Server-side initialization code that sets up the module and registers it with the IASMS system.
3. `SimulationIntegrationClient.js` - Client-side integration that handles communication with the server.
4. `Simulation3DViewer.jsx` - React component that renders the 3D simulation and handles real-time updates.
5. `SimulationTrainingModule.jsx` - Higher-level React component that provides a user interface for managing simulation sessions and scenarios.

This integration allows the IASMS system to:
- Visualize real-time data from the IASMS core modules
- Run simulation scenarios for training purposes
- View hazards, vehicles, and other entities in a 3D environment
- Monitor operations in real-time
- Train operators on emergency procedures and risk assessment

The architecture is designed to be flexible and extensible, allowing for new entity types and visualizations to be added as needed.

Let's continue with the remaining components for our full integration with the existing IASMS system.

Now, we need to create the React components for visualizing the 3D simulation in the IASMS application. Let's first create a component for visualizing aerial traffic:

```textmate
/**
 * /client/iasms/components/AerialTrafficVisualization.jsx
 * 
 * Aerial Traffic Visualization Component
 * Visualizes aerial vehicles and their trajectories in 3D space
 * 
 * Copyright 2025 Autonomy Association International Inc., all rights reserved 
 * Safeguard patent license from National Aeronautics and Space Administration (NASA)
 * Copyright 2025 NASA, all rights reserved
 */

import React, { useEffect, useRef, useState } from 'react';
import * as THREE from 'three';
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js';
import { SimulationIntegration } from '../SimulationIntegrationClient';

const AerialTrafficVisualization = ({ 
  sessionId, 
  width = '100%', 
  height = '500px',
  onVehicleSelected,
  selectedVehicleId
}) => {
  const containerRef = useRef(null);
  const rendererRef = useRef(null);
  const sceneRef = useRef(null);
  const cameraRef = useRef(null);
  const controlsRef = useRef(null);
  const animationFrameRef = useRef(null);
  const vehiclesRef = useRef({});
  const trafficLayerRef = useRef(new THREE.Group());
  const hazardsLayerRef = useRef(new THREE.Group());
  const terrainsLayerRef = useRef(new THREE.Group());
  
  const [isInitialized, setIsInitialized] = useState(false);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState(null);
  
  // Raycaster for object selection
  const raycasterRef = useRef(new THREE.Raycaster());
  const mouseRef = useRef(new THREE.Vector2());
  
  // Initialize Three.js scene
  useEffect(() => {
    if (!containerRef.current) return;
    
    try {
      // Create scene
      const scene = new THREE.Scene();
      scene.background = new THREE.Color(0x87ceeb); // Sky blue
      scene.fog = new THREE.Fog(0x87ceeb, 2000, 10000);
      sceneRef.current = scene;
      
      // Create camera
      const camera = new THREE.PerspectiveCamera(
        60, 
        containerRef.current.clientWidth / containerRef.current.clientHeight, 
        1, 
        30000
      );
      camera.position.set(0, 1000, 1000);
      camera.lookAt(0, 0, 0);
      cameraRef.current = camera;
      
      // Create renderer
      const renderer = new THREE.WebGLRenderer({ antialias: true });
      renderer.setSize(containerRef.current.clientWidth, containerRef.current.clientHeight);
      renderer.setPixelRatio(window.devicePixelRatio);
      renderer.shadowMap.enabled = true;
      renderer.shadowMap.type = THREE.PCFSoftShadowMap;
      containerRef.current.appendChild(renderer.domElement);
      rendererRef.current = renderer;
      
      // Add controls
      const controls = new OrbitControls(camera, renderer.domElement);
      controls.enableDamping = true;
      controls.dampingFactor = 0.05;
      controls.screenSpacePanning = false;
      controls.minDistance = 100;
      controls.maxDistance = 10000;
      controls.maxPolarAngle = Math.PI / 2;
      controlsRef.current = controls;
      
      // Add lights
      const ambientLight = new THREE.AmbientLight(0xffffff, 0.5);
      scene.add(ambientLight);
      
      const directionalLight = new THREE.DirectionalLight(0xffffff, 1);
      directionalLight.position.set(1000, 1000, 1000);
      directionalLight.castShadow = true;
      
      // Configure shadow properties
      directionalLight.shadow.mapSize.width = 2048;
      directionalLight.shadow.mapSize.height = 2048;
      directionalLight.shadow.camera.near = 10;
      directionalLight.shadow.camera.far = 4000;
      directionalLight.shadow.camera.left = -2000;
      directionalLight.shadow.camera.right = 2000;
      directionalLight.shadow.camera.top = 2000;
      directionalLight.shadow.camera.bottom = -2000;
      
      scene.add(directionalLight);
      
      // Create layers
      scene.add(terrainsLayerRef.current);
      scene.add(hazardsLayerRef.current);
      scene.add(trafficLayerRef.current);
      
      // Create ground
      createTerrain();
      
      // Add grid helper
      const gridHelper = new THREE.GridHelper(10000, 100, 0x444444, 0x888888);
      gridHelper.position.y = 0.1;
      scene.add(gridHelper);
      
      // Add north indicator
      createNorthIndicator();
      
      // Add mouse event listeners
      window.addEventListener('resize', handleResize);
      containerRef.current.addEventListener('click', handleClick);
      
      // Start animation loop
      const animate = () => {
        animationFrameRef.current = requestAnimationFrame(animate);
        
        // Update controls
        if (controlsRef.current) {
          controlsRef.current.update();
        }
        
        // Update vehicle rotations or animations
        updateVehicles();
        
        // Render
        if (rendererRef.current && sceneRef.current && cameraRef.current) {
          rendererRef.current.render(sceneRef.current, cameraRef.current);
        }
      };
      
      animate();
      
      setIsInitialized(true);
      setIsLoading(false);
      
      // Cleanup function
      return () => {
        window.removeEventListener('resize', handleResize);
        if (containerRef.current) {
          containerRef.current.removeEventListener('click', handleClick);
        }
        
        if (animationFrameRef.current) {
          cancelAnimationFrame(animationFrameRef.current);
        }
        
        if (rendererRef.current && containerRef.current) {
          containerRef.current.removeChild(rendererRef.current.domElement);
        }
        
        // Dispose of resources
        if (sceneRef.current) {
          disposeScene(sceneRef.current);
        }
      };
    } catch (err) {
      console.error('Error initializing 3D visualization:', err);
      setError('Failed to initialize 3D visualization. Please try refreshing the page.');
      setIsLoading(false);
    }
  }, []);
  
  // Handle window resize
  const handleResize = () => {
    if (!containerRef.current || !cameraRef.current || !rendererRef.current) return;
    
    const width = containerRef.current.clientWidth;
    const height = containerRef.current.clientHeight;
    
    cameraRef.current.aspect = width / height;
    cameraRef.current.updateProjectionMatrix();
    
    rendererRef.current.setSize(width, height);
  };
  
  // Handle click for object selection
  const handleClick = (event) => {
    if (!containerRef.current || !cameraRef.current || !sceneRef.current) return;
    
    // Calculate mouse position in normalized device coordinates
    const rect = containerRef.current.getBoundingClientRect();
    mouseRef.current.x = ((event.clientX - rect.left) / containerRef.current.clientWidth) * 2 - 1;
    mouseRef.current.y = -((event.clientY - rect.top) / containerRef.current.clientHeight) * 2 + 1;
    
    // Update the picking ray
    raycasterRef.current.setFromCamera(mouseRef.current, cameraRef.current);
    
    // Find all intersections with traffic layer
    const intersects = raycasterRef.current.intersectObjects(trafficLayerRef.current.children, true);
    
    if (intersects.length > 0) {
      // Find the first object with userData containing vehicleId
      let selectedObject = null;
      
      for (const intersect of intersects) {
        let obj = intersect.object;
        
        // Walk up the parent chain to find an object with vehicleId
        while (obj && !obj.userData.vehicleId) {
          obj = obj.parent;
        }
        
        if (obj && obj.userData.vehicleId) {
          selectedObject = obj;
          break;
        }
      }
      
      if (selectedObject && onVehicleSelected) {
        onVehicleSelected(selectedObject.userData.vehicleId);
      }
    }
  };
  
  // Create terrain (ground)
  const createTerrain = () => {
    if (!sceneRef.current) return;
    
    // Simple ground plane
    const groundGeometry = new THREE.PlaneGeometry(10000, 10000, 1, 1);
    const groundMaterial = new THREE.MeshStandardMaterial({
      color: 0x7cba5e,
      roughness: 0.8,
      metalness: 0.2,
      side: THREE.DoubleSide
    });
    
    const ground = new THREE.Mesh(groundGeometry, groundMaterial);
    ground.rotation.x = -Math.PI / 2;
    ground.position.y = 0;
    ground.receiveShadow = true;
    ground.name = 'ground';
    
    terrainsLayerRef.current.add(ground);
  };
  
  // Create north indicator
  const createNorthIndicator = () => {
    if (!sceneRef.current) return;
    
    const group = new THREE.Group();
    group.name = 'northIndicator';
    
    // Arrow
    const arrowGeometry = new THREE.ConeGeometry(20, 60, 4);
    const arrowMaterial = new THREE.MeshBasicMaterial({ color: 0xff0000 });
    const arrow = new THREE.Mesh(arrowGeometry, arrowMaterial);
    arrow.position.y = 30;
    arrow.rotation.x = Math.PI;
    
    // Line
    const lineGeometry = new THREE.CylinderGeometry(5, 5, 100, 8);
    const lineMaterial = new THREE.MeshBasicMaterial({ color: 0xffffff });
    const line = new THREE.Mesh(lineGeometry, lineMaterial);
    line.position.y = -20;
    
    // Label
    const labelCanvas = document.createElement('canvas');
    labelCanvas.width = 100;
    labelCanvas.height = 50;
    const ctx = labelCanvas.getContext('2d');
    ctx.fillStyle = 'white';
    ctx.font = 'Bold 40px Arial';
    ctx.textAlign = 'center';
    ctx.fillText('N', 50, 40);
    
    const labelTexture = new THREE.CanvasTexture(labelCanvas);
    const labelMaterial = new THREE.SpriteMaterial({ map: labelTexture });
    const label = new THREE.Sprite(labelMaterial);
    label.position.set(0, 60, 0);
    label.scale.set(100, 50, 1);
    
    group.add(arrow);
    group.add(line);
    group.add(label);
    
    // Position the indicator in the top-right corner of the scene
    group.position.set(800, 0, -800);
    
    // Add to scene
    sceneRef.current.add(group);
  };
  
  // Update vehicles
  const updateVehicles = () => {
    Object.values(vehiclesRef.current).forEach(vehicle => {
      // Rotate propellers if they exist
      if (vehicle.propellers && vehicle.propellers.length > 0) {
        vehicle.propellers.forEach(propeller => {
          propeller.rotation.y += 0.3;
        });
      }
    });
  };
  
  // Dispose of scene resources
  const disposeScene = (scene) => {
    scene.traverse((object) => {
      if (object.geometry) {
        object.geometry.dispose();
      }
      
      if (object.material) {
        if (Array.isArray(object.material)) {
          object.material.forEach(material => material.dispose());
        } else {
          object.material.dispose();
        }
      }
    });
  };
  
  // Connect to session when ready and sessionId changes
  useEffect(() => {
    if (!isInitialized || !sessionId) return;
    
    let entityUpdateId = -1;
    
    const connectToSession = async () => {
      try {
        setIsLoading(true);
        
        // Join session
        const success = await SimulationIntegration.joinSession(sessionId);
        
        if (!success) {
          setError('Failed to connect to simulation session.');
          setIsLoading(false);
          return;
        }
        
        // Register for entity updates
        entityUpdateId = SimulationIntegration.onEntityUpdate(handleEntityUpdates);
        
        setIsLoading(false);
      } catch (err) {
        console.error('Error connecting to session:', err);
        setError('Failed to connect to simulation session.');
        setIsLoading(false);
      }
    };
    
    connectToSession();
    
    return () => {
      // Cleanup
      if (entityUpdateId >= 0) {
        SimulationIntegration.removeCallback('entityUpdate', entityUpdateId);
      }
      
      // Clear all vehicles
      clearAllEntities();
      
      // Leave session
      SimulationIntegration.leaveSession();
    };
  }, [isInitialized, sessionId]);
  
  // Handle entity updates from simulation
  const handleEntityUpdates = (updates) => {
    if (!updates || !Array.isArray(updates) || !sceneRef.current) return;
    
    updates.forEach(update => {
      switch (update.type) {
        case 'vehicle_create':
        case 'vehicle_update':
          handleVehicleUpdate(update);
          break;
        case 'hazard_create':
        case 'hazard_update':
          handleHazardUpdate(update);
          break;
        case 'entity_remove':
          handleEntityRemove(update);
          break;
      }
    });
  };
  
  // Handle vehicle creation/update
  const handleVehicleUpdate = (update) => {
    const { entityId, vehicleType, position, rotation, scale, velocity, metadata } = update;
    
    // Skip if no entity ID
    if (!entityId) return;
    
    // Check if vehicle already exists
    if (vehiclesRef.current[entityId]) {
      // Update existing vehicle
      const vehicleGroup = vehiclesRef.current[entityId].group;
      
      if (position) {
        vehicleGroup.position.set(position.x, position.y, position.z);
      }
      
      if (rotation) {
        vehicleGroup.rotation.set(rotation.x, rotation.y, rotation.z);
      }
      
      // Update userData if needed
      if (metadata) {
        vehicleGroup.userData = {
          ...vehicleGroup.userData,
          ...metadata,
          vehicleId: entityId,
          vehicleType
        };
      }
      
      // Update highlight based on selection
      updateVehicleHighlight(entityId);
    } else {
      // Create new vehicle
      createVehicle(entityId, vehicleType, position, rotation, scale, metadata);
    }
  };
  
  // Create a new vehicle
  const createVehicle = (entityId, vehicleType, position, rotation, scale = 1, metadata = {}) => {
    if (!trafficLayerRef.current) return;
    
    // Create vehicle group
    const vehicleGroup = new THREE.Group();
    vehicleGroup.name = `vehicle_${entityId}`;
    vehicleGroup.userData = {
      vehicleId: entityId,
      vehicleType,
      ...metadata
    };
    
    if (position) {
      vehicleGroup.position.set(position.x, position.y, position.z);
    }
    
    if (rotation) {
      vehicleGroup.rotation.set(rotation.x, rotation.y, rotation.z);
    }
    
    // Create vehicle based on type
    let vehicleMesh;
    const propellers = [];
    
    switch (vehicleType) {
      case 'drone':
        vehicleMesh = createDroneModel(propellers);
        break;
      case 'eVTOL':
        vehicleMesh = createEVTOLModel(propellers);
        break;
      case 'aircraft':
        vehicleMesh = createAircraftModel(propellers);
        break;
      default:
        vehicleMesh = createDefaultModel();
    }
    
    // Apply scale
    vehicleGroup.scale.set(scale, scale, scale);
    
    // Add vehicle mesh to group
    vehicleGroup.add(vehicleMesh);
    
    // Add to traffic layer
    trafficLayerRef.current.add(vehicleGroup);
    
    // Store reference
    vehiclesRef.current[entityId] = {
      group: vehicleGroup,
      propellers: propellers
    };
    
    // Update highlight based on selection
    updateVehicleHighlight(entityId);
    
    return vehicleGroup;
  };
  
  // Create drone model
  const createDroneModel = (propellers) => {
    const droneGroup = new THREE.Group();
    
    // Main body
    const bodyGeometry = new THREE.BoxGeometry(1, 0.3, 1);
    const bodyMaterial = new THREE.MeshStandardMaterial({
      color: 0x333333,
      metalness: 0.5,
      roughness: 0.5
    });
    const body = new THREE.Mesh(bodyGeometry, bodyMaterial);
    body.castShadow = true;
    droneGroup.add(body);
    
    // Arms
    const armGeometry = new THREE.BoxGeometry(1.8, 0.1, 0.1);
    const armMaterial = new THREE.MeshStandardMaterial({
      color: 0x666666,
      metalness: 0.2,
      roughness: 0.8
    });
    
    const arm1 = new THREE.Mesh(armGeometry, armMaterial);
    arm1.castShadow = true;
    droneGroup.add(arm1);
    
    const arm2 = new THREE.Mesh(armGeometry, armMaterial);
    arm2.rotation.y = Math.PI / 2;
    arm2.castShadow = true;
    droneGroup.add(arm2);
    
    // Rotors
    const rotorGeometry = new THREE.CylinderGeometry(0.05, 0.05, 0.05, 8);
    const rotorMaterial = new THREE.MeshStandardMaterial({
      color: 0x111111,
      metalness: 0.7,
      roughness: 0.3
    });
    
    const rotorPositions = [
      { x: 0.8, y: 0.05, z: 0 },
      { x: -0.8, y: 0.05, z: 0 },
      { x: 0, y: 0.05, z: 0.8 },
      { x: 0, y: 0.05, z: -0.8 }
    ];
    
    rotorPositions.forEach(pos => {
      const rotor = new THREE.Mesh(rotorGeometry, rotorMaterial);
      rotor.position.set(pos.x, pos.y, pos.z);
      rotor.castShadow = true;
      droneGroup.add(rotor);
      
      // Propeller blade
      const bladeGeometry = new THREE.BoxGeometry(0.6, 0.02, 0.1);
      const bladeMaterial = new THREE.MeshStandardMaterial({
        color: 0x888888,
        metalness: 0.3,
        roughness: 0.7
      });
      const blade = new THREE.Mesh(bladeGeometry, bladeMaterial);
      blade.castShadow = true;
      
      // Add blade to rotor
      rotor.add(blade);
      
      // Store propeller reference for animation
      propellers.push(rotor);
    });
    
    // Scale properly
    droneGroup.scale.set(2, 2, 2);
    
    return droneGroup;
  };
  
  // Create eVTOL model
  const createEVTOLModel = (propellers) => {
    const evtolGroup = new THREE.Group();
    
    // Main body
    const bodyGeometry = new THREE.CapsuleGeometry(0.5, 2, 8, 16);
    bodyGeometry.rotateZ(Math.PI / 2);
    const bodyMaterial = new THREE.MeshStandardMaterial({
      color: 0xf0f0f0,
      metalness: 0.6,
      roughness: 0.4
    });
    const body = new THREE.Mesh(bodyGeometry, bodyMaterial);
    body.castShadow = true;
    evtolGroup.add(body);
    
    // Wings
    const wingGeometry = new THREE.BoxGeometry(6, 0.1, 0.8);
    const wingMaterial = new THREE.MeshStandardMaterial({
      color: 0xcccccc,
      metalness: 0.5,
      roughness: 0.5
    });
    const wing = new THREE.Mesh(wingGeometry, wingMaterial);
    wing.position.set(0, 0, 0);
    wing.castShadow = true;
    evtolGroup.add(wing);
    
    // Rotors
    const rotorGeometry = new THREE.CylinderGeometry(0.1, 0.1, 0.2, 8);
    const rotorMaterial = new THREE.MeshStandardMaterial({
      color: 0x222222,
      metalness: 0.7,
      roughness: 0.3
    });
    
    const rotorPositions = [
      { x: -2.5, y: 0.2, z: 0 },
      { x: -1.5, y: 0.2, z: 0 },
      { x: 1.5, y: 0.2, z: 0 },
      { x: 2.5, y: 0.2, z: 0 }
    ];
    
    rotorPositions.forEach(pos => {
      const rotor = new THREE.Mesh(rotorGeometry, rotorMaterial);
      rotor.position.set(pos.x, pos.y, pos.z);
      rotor.castShadow = true;
      evtolGroup.add(rotor);
      
      // Propeller blade
      const bladeGeometry = new THREE.BoxGeometry(1.2, 0.05, 0.1);
      const bladeMaterial = new THREE.MeshStandardMaterial({
        color: 0x888888,
        metalness: 0.3,
        roughness: 0.7
      });
      const blade = new THREE.Mesh(bladeGeometry, bladeMaterial);
      blade.castShadow = true;
      
      // Add blade to rotor
      rotor.add(blade);
      
      // Store propeller reference for animation
      propellers.push(rotor);
    });
    
    // Tail
    const tailGeometry = new THREE.BoxGeometry(0.3, 0.3, 1.5);
    const tailMaterial = new THREE.MeshStandardMaterial({
      color: 0xf0f0f0,
      metalness: 0.6,
      roughness: 0.4
    });
    const tail = new THREE.Mesh(tailGeometry, tailMaterial);
    tail.position.set(0, 0, -1.5);
    tail.castShadow = true;
    evtolGroup.add(tail);
    
    // Vertical stabilizer
    const stabilizerGeometry = new THREE.BoxGeometry(0.1, 0.8, 0.8);
    const stabilizerMaterial = new THREE.MeshStandardMaterial({
      color: 0xf0f0f0,
      metalness: 0.6,
      roughness: 0.4
    });
    const stabilizer = new THREE.Mesh(stabilizerGeometry, stabilizerMaterial);
    stabilizer.position.set(0, 0.4, -1.8);
    stabilizer.castShadow = true;
    evtolGroup.add(stabilizer);
    
    // Cockpit
    const cockpitGeometry = new THREE.SphereGeometry(0.6, 32, 16, 0, Math.PI * 2, 0, Math.PI / 2);
    const cockpitMaterial = new THREE.MeshStandardMaterial({
      color: 0x88aaff,
      metalness: 0.2,
      roughness: 0.3,
      transparent: true,
      opacity: 0.7
    });
    const cockpit = new THREE.Mesh(cockpitGeometry, cockpitMaterial);
    cockpit.rotation.x = Math.PI;
    cockpit.position.set(0, 0, 1);
    cockpit.castShadow = true;
    evtolGroup.add(cockpit);
    
    // Scale properly
    evtolGroup.scale.set(3, 3, 3);
    
    return evtolGroup;
  };
  
  // Create aircraft model
  const createAircraftModel = (propellers) => {
    const aircraftGroup = new THREE.Group();
    
    // Main body
    const bodyGeometry = new THREE.CylinderGeometry(0.5, 0.4, 6, 16);
    bodyGeometry.rotateX(Math.PI / 2);
    const bodyMaterial = new THREE.MeshStandardMaterial({
      color: 0xffffff,
      metalness: 0.5,
      roughness: 0.5
    });
    const body = new THREE.Mesh(bodyGeometry, bodyMaterial);
    body.castShadow = true;
    aircraftGroup.add(body);
    
    // Wings
    const wingGeometry = new THREE.BoxGeometry(10, 0.1, 1.5);
    const wingMaterial = new THREE.MeshStandardMaterial({
      color: 0xdddddd,
      metalness: 0.5,
      roughness: 0.5
    });
    const wing = new THREE.Mesh(wingGeometry, wingMaterial);
    wing.position.set(0, 0, 0);
    wing.castShadow = true;
    aircraftGroup.add(wing);
    
    // Tail wings
    const tailWingGeometry = new THREE.BoxGeometry(4, 0.1, 1);
    const tailWing = new THREE.Mesh(tailWingGeometry, wingMaterial);
    tailWing.position.set(0, 0, -2.5);
    tailWing.castShadow = true;
    aircraftGroup.add(tailWing);
    
    // Vertical stabilizer
    const stabilizerGeometry = new THREE.BoxGeometry(0.1, 1, 1.5);
    const stabilizerMaterial = new THREE.MeshStandardMaterial({
      color: 0xdddddd,
      metalness: 0.5,
      roughness: 0.5
    });
    const stabilizer = new THREE.Mesh(stabilizerGeometry, stabilizerMaterial);
    stabilizer.position.set(0, 0.5, -2.5);
    stabilizer.castShadow = true;
    aircraftGroup.add(stabilizer);
    
    // Engines
    const engineGeometry = new THREE.CylinderGeometry(0.3, 0.3, 1.2, 16);
    const engineMaterial = new THREE.MeshStandardMaterial({
      color: 0x333333,
      metalness: 0.7,
      roughness: 0.3
    });
    
    const leftEngine = new THREE.Mesh(engineGeometry, engineMaterial);
    leftEngine.rotation.z = Math.PI / 2;
    leftEngine.position.set(-2.5, -0.3, 0.2);
    leftEngine.castShadow = true;
    aircraftGroup.add(leftEngine);
    
    const rightEngine = new THREE.Mesh(engineGeometry, engineMaterial);
    rightEngine.rotation.z = Math.PI / 2;
    rightEngine.position.set(2.5, -0.3, 0.2);
    rightEngine.castShadow = true;
    aircraftGroup.add(rightEngine);
    
    // Propellers
    const propellerGeometry = new THREE.BoxGeometry(1.5, 0.05, 0.2);
    const propellerMaterial = new THREE.MeshStandardMaterial({
      color: 0x888888,
      metalness: 0.3,
      roughness: 0.7
    });
    
    const leftPropeller = new THREE.Mesh(propellerGeometry, propellerMaterial);
    leftPropeller.position.set(-2.5, -0.3, 0.9);
    leftPropeller.castShadow = true;
    aircraftGroup.add(leftPropeller);
    propellers.push(leftPropeller);
    
    const rightPropeller = new THREE.Mesh(propellerGeometry, propellerMaterial);
    rightPropeller.position.set(2.5, -0.3, 0.9);
    rightPropeller.castShadow = true;
    aircraftGroup.add(rightPropeller);
    propellers.push(rightPropeller);
    
    // Cockpit
    const cockpitGeometry = new THREE.SphereGeometry(0.6, 32, 16, 0, Math.PI * 2, 0, Math.PI / 2);
    const cockpitMaterial = new THREE.MeshStandardMaterial({
      color: 0x88aaff,
      metalness: 0.2,
      roughness: 0.3,
      transparent: true,
      opacity: 0.7
    });
    const cockpit = new THREE.Mesh(cockpitGeometry, cockpitMaterial);
    cockpit.rotation.x = Math.PI;
    cockpit.position.set(0, 0.3, 2.5);
    cockpit.castShadow = true;
    aircraftGroup.add(cockpit);
    
    // Scale properly
    aircraftGroup.scale.set(4, 4, 4);
    
    return aircraftGroup;
  };
  
  // Create default model
  const createDefaultModel = () => {
    const group = new THREE.Group();
    
    // Simple box
    const geometry = new THREE.BoxGeometry(1, 1, 1);
    const material = new THREE.MeshStandardMaterial({
      color: 0xff0000,
      metalness: 0.3,
      roughness: 0.7
    });
    const box = new THREE.Mesh(geometry, material);
    box.castShadow = true;
    group.add(box);
    
    return group;
  };
  
  // Handle hazard creation/update
  const handleHazardUpdate = (update) => {
    const { entityId, hazardType, visualType, position, radius, color, severity, expiryTime, metadata } = update;
    
    // Skip if no entity ID
    if (!entityId) return;
    
    // Check if hazard already exists
    let hazardMesh = sceneRef.current.getObjectByName(`hazard_${entityId}`);
    
    if (hazardMesh) {
      // Update existing hazard
      if (position) {
        hazardMesh.position.set(position.x, position.y, position.z);
      }
      
      // Update radius if different
      if (radius && hazardMesh.geometry.parameters.radius !== radius) {
        hazardMesh.geometry.dispose();
        hazardMesh.geometry = new THREE.SphereGeometry(radius, 24, 16);
      }
      
      // Update color if different
      if (color) {
        hazardMesh.material.color.set(color);
      }
      
      // Update opacity based on severity
      if (severity !== undefined) {
        hazardMesh.material.opacity = 0.2 + (severity * 0.3);
      }
      
      // Update userData if needed
      if (metadata) {
        hazardMesh.userData = {
          ...hazardMesh.userData,
          ...metadata,
          hazardType,
          visualType,
          expiryTime
        };
      }
    } else {
      // Create new hazard
      createHazard(entityId, hazardType, visualType, position, radius, color, severity, expiryTime, metadata);
    }
  };
  
  // Create a new hazard
  const createHazard = (entityId, hazardType, visualType, position, radius = 500, color = '#ffaa00', severity = 0.5, expiryTime, metadata = {}) => {
    if (!hazardsLayerRef.current) return;
    
    // Create hazard geometry based on visual type
    let geometry;
    let material;
    
    switch (visualType) {
      case 'weather_zone':
        geometry = new THREE.SphereGeometry(radius, 24, 16);
        material = new THREE.MeshBasicMaterial({
          color: color,
          transparent: true,
          opacity: 0.2 + (severity * 0.3),
          side: THREE.DoubleSide,
          depthWrite: false
        });
        break;
      case 'warning_zone':
        geometry = new THREE.CylinderGeometry(radius, radius, 1000, 32, 1, true);
        material = new THREE.MeshBasicMaterial({
          color: color,
          transparent: true,
          opacity: 0.2 + (severity * 0.3),
          side: THREE.DoubleSide,
          depthWrite: false
        });
        break;
      case 'emergency_zone':
        geometry = new THREE.SphereGeometry(radius, 24, 16);
        material = new THREE.MeshBasicMaterial({
          color: color,
          transparent: true,
          opacity: 0.2 + (severity * 0.3),
          side: THREE.DoubleSide,
          depthWrite: false,
          wireframe: true
        });
        break;
      default:
        geometry = new THREE.SphereGeometry(radius, 24, 16);
        material = new THREE.MeshBasicMaterial({
          color: color,
          transparent: true,
          opacity: 0.2 + (severity * 0.3),
          side: THREE.DoubleSide,
          depthWrite: false
        });
    }
    
    const hazardMesh = new THREE.Mesh(geometry, material);
    hazardMesh.name = `hazard_${entityId}`;
    hazardMesh.userData = {
      hazardId: entityId,
      hazardType,
      visualType,
      expiryTime,
      ...metadata
    };
    
    if (position) {
      hazardMesh.position.set(position.x, position.y, position.z);
    }
    
    // Add to hazards layer
    hazardsLayerRef.current.add(hazardMesh);
    
    return hazardMesh;
  };
  
  // Handle entity removal
  const handleEntityRemove = (update) => {
    const { entityId } = update;
    
    // Skip if no entity ID
    if (!entityId) return;
    
    // Check if it's a vehicle
    if (vehiclesRef.current[entityId]) {
      // Remove from traffic layer
      const vehicleGroup = vehiclesRef.current[entityId].group;
      trafficLayerRef.current.remove(vehicleGroup);
      
      // Dispose resources
      vehicleGroup.traverse((object) => {
        if (object.geometry) {
          object.geometry.dispose();
        }
        
        if (object.material) {
          if (Array.isArray(object.material)) {
            object.material.forEach(material => material.dispose());
          } else {
            object.material.dispose();
          }
        }
      });
      
      // Remove from references
      delete vehiclesRef.current[entityId];
    }
    
    // Check if it's a hazard
    const hazardMesh = sceneRef.current.getObjectByName(`hazard_${entityId}`);
    if (hazardMesh) {
      // Remove from hazards layer
      hazardsLayerRef.current.remove(hazardMesh);
      
      // Dispose resources
      if (hazardMesh.geometry) {
        hazardMesh.geometry.dispose();
      }
      
      if (hazardMesh.material) {
        if (Array.isArray(hazardMesh.material)) {
          hazardMesh.material.forEach(material => material.dispose());
        } else {
          hazardMesh.material.dispose();
        }
      }
    }
  };
  
  // Clear all entities
  const clearAllEntities = () => {
    // Clear vehicles
    Object.keys(vehiclesRef.current).forEach(entityId => {
      const vehicleGroup = vehiclesRef.current[entityId].group;
      trafficLayerRef.current.remove(vehicleGroup);
      
      // Dispose resources
      vehicleGroup.traverse((object) => {
        if (object.geometry) {
          object.geometry.dispose();
        }
        
        if (object.material) {
          if (Array.isArray(object.material)) {
            object.material.forEach(material => material.dispose());
          } else {
            object.material.dispose();
          }
        }
      });
    });
    
    vehiclesRef.current = {};
    
    // Clear hazards
    while (hazardsLayerRef.current.children.length) {
      const hazard = hazardsLayerRef.current.children[0];
      
      // Dispose resources
      if (hazard.geometry) {
        hazard.geometry.dispose();
      }
      
      if (hazard.material) {
        if (Array.isArray(hazard.material)) {
          hazard.material.forEach(material => material.dispose());
        } else {
          hazard.material.dispose();
        }
      }
      
      hazardsLayerRef.current.remove(hazard);
    }
  };
  
  // Update vehicle highlight based on selection
  const updateVehicleHighlight = (entityId) => {
    const vehicle = vehiclesRef.current[entityId];
    
    if (!vehicle) return;
    
    const isSelected = selectedVehicleId === entityId;
    
    // Add or remove highlight
    if (isSelected) {
      // Create highlight if it doesn't exist
      if (!vehicle.highlight) {
        // Create highlight object (wireframe box)
        const boundingBox = new THREE.Box3().setFromObject(vehicle.group);
        const size = boundingBox.getSize(new THREE.Vector3());
        const highlightGeometry = new THREE.BoxGeometry(size.x * 1.2, size.y * 1.2, size.z * 1.2);
        const highlightMaterial = new THREE.MeshBasicMaterial({
          color: 0x00ffff,
          wireframe: true,
          transparent: true,
          opacity: 0.7
        });
        
        const highlightMesh = new THREE.Mesh(highlightGeometry, highlightMaterial);
        highlightMesh.name = 'highlight';
        vehicle.group.add(highlightMesh);
        
        vehicle.highlight = highlightMesh;
      }
    } else {
      // Remove highlight if it exists
      if (vehicle.highlight) {
        vehicle.group.remove(vehicle.highlight);
        
        if (vehicle.highlight.geometry) {
          vehicle.highlight.geometry.dispose();
        }
        
        if (vehicle.highlight.material) {
          vehicle.highlight.material.dispose();
        }
        
        vehicle.highlight = null;
      }
    }
  };
  
  // Update all vehicle highlights when selection changes
  useEffect(() => {
    Object.keys(vehiclesRef.current).forEach(entityId => {
      updateVehicleHighlight(entityId);
    });
  }, [selectedVehicleId]);
  
  return (
    <div style={{ position: 'relative', width, height }}>
      <div 
        ref={containerRef} 
        style={{ 
          width: '100%', 
          height: '100%',
          overflow: 'hidden',
          borderRadius: '8px',
          backgroundColor: '#87ceeb'
        }}
      />
      
      {isLoading && (
        <div style={{
          position: 'absolute',
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
          backgroundColor: 'rgba(0, 0, 0, 0.5)',
          color: 'white',
          fontSize: '18px',
          zIndex: 10
        }}>
          <div>Loading...</div>
        </div>
      )}
      
      {error && (
        <div style={{
          position: 'absolute',
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
          backgroundColor: 'rgba(0, 0, 0, 0.7)',
          color: 'white',
          fontSize: '16px',
          zIndex: 10
        }}>
          <div style={{ padding: '20px', maxWidth: '80%', textAlign: 'center' }}>
            <div style={{ color: '#ff6666', marginBottom: '10px' }}>Error</div>
            <div>{error}</div>
          </div>
        </div>
      )}
      
      <div style={{
        position: 'absolute',
        bottom: '10px',
        left: '10px',
        padding: '8px',
        backgroundColor: 'rgba(0, 0, 0, 0.6)',
        color: 'white',
        borderRadius: '4px',
        fontSize: '12px'
      }}>
        <div>Vehicle count: {Object.keys(vehiclesRef.current).length}</div>
        <div>Hazard count: {hazardsLayerRef.current ? hazardsLayerRef.current.children.length : 0}</div>
      </div>
    </div>
  );
};

export default AerialTrafficVisualization;
```


Now, let's create a visualization dashboard for the IASMS system that incorporates our 3D visualization:

```textmate
/**
 * /client/iasms/components/IAMSVisualizationDashboard.jsx
 * 
 * IAMS Visualization Dashboard
 * Provides integrated visualization of all IASMS data
 * 
 * Copyright 2025 Autonomy Association International Inc., all rights reserved 
 * Safeguard patent license from National Aeronautics and Space Administration (NASA)
 * Copyright 2025 NASA, all rights reserved
 */

import React, { useState, useEffect } from 'react';
import { Meteor } from 'meteor/meteor';
import { useTracker } from 'meteor/react-meteor-data';
import AerialTrafficVisualization from './AerialTrafficVisualization';
import { SimulationIntegration } from '../SimulationIntegrationClient';

const IAMSVisualizationDashboard = () => {
  const [activeTab, setActiveTab] = useState('3dView');
  const [selectedVehicleId, setSelectedVehicleId] = useState(null);
  const [selectedVehicle, setSelectedVehicle] = useState(null);
  const [selectedHazardId, setSelectedHazardId] = useState(null);
  const [selectedHazard, setSelectedHazard] = useState(null);
  const [activeSession, setActiveSession] = useState(null);
  const [showSidebar, setShowSidebar] = useState(true);
  
  // Track active simulation sessions
  const { sessions, loading } = useTracker(() => {
    const handle = Meteor.subscribe('iasms.activeSimulationSessions');
    
    return {
      sessions: IasmsSimulationSessions.find(
        { status: { $in: ['ACTIVE', 'PAUSED'] } },
        { sort: { startTime: -1 } }
      ).fetch(),
      loading: !handle.ready()
    };
  }, []);
  
  // Track vehicle data
  const { vehicles, vehiclesLoading } = useTracker(() => {
    const handle = Meteor.subscribe('iasms.activeVehicles');
    
    return {
      vehicles: IasmsVehicleStates.find({}, { sort: { timestamp: -1 } }).fetch(),
      vehiclesLoading: !handle.ready()
    };
  }, []);
  
  // Track hazard data
  const { hazards, hazardsLoading } = useTracker(() => {
    const handle = Meteor.subscribe('iasms.activeHazards');
    
    return {
      hazards: IasmsHazards.find({ expiryTime: { $gt: new Date() } }).fetch(),
      hazardsLoading: !handle.ready()
    };
  }, []);
  
  // Track risk data
  const { risks, risksLoading } = useTracker(() => {
    const handle = Meteor.subscribe('iasms.vehicleRisks', selectedVehicleId);
    
    return {
      risks: selectedVehicleId ? 
        IasmsRisks.find({ vehicleId: selectedVehicleId }).fetch() : 
        [],
      risksLoading: !handle.ready()
    };
  }, [selectedVehicleId]);
  
  // Select the most recent session by default
  useEffect(() => {
    if (sessions && sessions.length > 0 && !activeSession) {
      setActiveSession(sessions[0]._id);
    }
  }, [sessions]);
  
  // Update selected vehicle when ID changes
  useEffect(() => {
    if (selectedVehicleId && vehicles) {
      const vehicle = vehicles.find(v => v.vehicleId === selectedVehicleId);
      setSelectedVehicle(vehicle || null);
    } else {
      setSelectedVehicle(null);
    }
  }, [selectedVehicleId, vehicles]);
  
  // Update selected hazard when ID changes
  useEffect(() => {
    if (selectedHazardId && hazards) {
      const hazard = hazards.find(h => h._id === selectedHazardId);
      setSelectedHazard(hazard || null);
    } else {
      setSelectedHazard(null);
    }
  }, [selectedHazardId, hazards]);
  
  // Handle vehicle selection
  const handleVehicleSelected = (vehicleId) => {
    setSelectedVehicleId(vehicleId);
    setSelectedHazardId(null);
  };
  
  // Handle hazard selection
  const handleHazardSelected = (hazardId) => {
    setSelectedHazardId(hazardId);
    setSelectedVehicleId(null);
  };
  
  // Create a new simulation session
  const createSimulationSession = async () => {
    try {
      const sessionId = await SimulationIntegration.createSession({
        name: `IASMS Visualization Session`,
        description: 'Real-time visualization of IASMS data',
        syncWithRealWorld: true
      });
      
      setActiveSession(sessionId);
    } catch (error) {
      console.error('Error creating simulation session:', error);
      alert('Failed to create simulation session. Please try again.');
    }
  };
  
  // Render active sessions dropdown
  const renderSessionSelector = () => {
    if (loading) {
      return <div className="loading">Loading sessions...</div>;
    }
    
    return (
      <div className="session-selector">
        <select 
          value={activeSession || ''} 
          onChange={(e) => setActiveSession(e.target.value)}
          disabled={loading}
        >
          <option value="">Select a session</option>
          {sessions.map(session => (
            <option key={session._id} value={session._id}>
              {session.name} ({new Date(session.startTime).toLocaleTimeString()})
            </option>
          ))}
        </select>
        
        <button 
          onClick={createSimulationSession}
          disabled={loading}
          className="create-session-button"
        >
          Create New Session
        </button>
      </div>
    );
  };
  
  // Render vehicle details panel
  const renderVehicleDetails = () => {
    if (!selectedVehicle) {
      return (
        <div className="empty-selection">
          <p>No vehicle selected</p>
          <p className="hint">Click on a vehicle in the 3D view to see details</p>
        </div>
      );
    }
    
    return (
      <div className="vehicle-details">
        <h3>Vehicle: {selectedVehicle.callsign || selectedVehicle.vehicleId}</h3>
        
        <div className="detail-item">
          <div className="label">Type:</div>
          <div className="value">{selectedVehicle.vehicleType || 'Unknown'}</div>
        </div>
        
        <div className="detail-item">
          <div className="label">Status:</div>
          <div className="value status-value">
            <span className={`status-indicator ${selectedVehicle.status?.toLowerCase() || 'unknown'}`}></span>
            {selectedVehicle.status || 'Unknown'}
          </div>
        </div>
        
        <div className="detail-item">
          <div className="label">Position:</div>
          <div className="value">
            {selectedVehicle.position ? 
              `${selectedVehicle.position.coordinates[1].toFixed(6)}, ${selectedVehicle.position.coordinates[0].toFixed(6)}` : 
              'Unknown'}
          </div>
        </div>
        
        <div className="detail-item">
          <div className="label">Altitude:</div>
          <div className="value">{selectedVehicle.altitude ? `${selectedVehicle.altitude.toFixed(1)} m` : 'Unknown'}</div>
        </div>
        
        <div className="detail-item">
          <div className="label">Speed:</div>
          <div className="value">{selectedVehicle.speed ? `${selectedVehicle.speed.toFixed(1)} m/s` : 'Unknown'}</div>
        </div>
        
        <div className="detail-item">
          <div className="label">Heading:</div>
          <div className="value">{selectedVehicle.heading ? `${selectedVehicle.heading.toFixed(1)}°` : 'Unknown'}</div>
        </div>
        
        <div className="detail-item">
          <div className="label">Last Update:</div>
          <div className="value">{new Date(selectedVehicle.timestamp).toLocaleTimeString()}</div>
        </div>
        
        {/* Risks section */}
        <h4>Risks</h4>
        {risksLoading ? (
          <div className="loading">Loading risks...</div>
        ) : risks.length === 0 ? (
          <div className="no-risks">No active risks</div>
        ) : (
          <div className="risks-list">
            {risks.map(risk => (
              <div key={risk._id} className={`risk-item risk-${risk.riskCategory?.toLowerCase()}`}>
                <div className="risk-header">
                  <span className="risk-level">{risk.riskCategory}</span>
                  <span className="risk-value">{(risk.riskLevel * 100).toFixed(0)}%</span>
                </div>
                <div className="risk-hazard">
                  {risk.metadata?.hazardInfo?.type || 'Unknown Hazard'}
                </div>
                <div className="risk-factors">
                  {Object.entries(risk.riskFactors || {}).map(([factor, value]) => (
                    <div key={factor} className="risk-factor">
                      <span className="factor-name">{factor}:</span>
                      <span className="factor-value">{(value * 100).toFixed(0)}%</span>
                    </div>
                  ))}
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    );
  };
  
  // Render hazard details panel
  const renderHazardDetails = () => {
    if (!selectedHazard) {
      return (
        <div className="empty-selection">
          <p>No hazard selected</p>
          <p className="hint">Click on a hazard in the 3D view to see details</p>
        </div>
      );
    }
    
    return (
      <div className="hazard-details">
        <h3>Hazard: {selectedHazard.hazardType}</h3>
        
        <div className="detail-item">
          <div className="label">Type:</div>
          <div className="value">{selectedHazard.hazardType}</div>
        </div>
        
        <div className="detail-item">
          <div className="label">Severity:</div>
          <div className="value">
            <div className="severity-bar">
              <div 
                className="severity-fill" 
                style={{ width: `${selectedHazard.severity * 100}%`, backgroundColor: getSeverityColor(selectedHazard.severity) }}
              ></div>
            </div>
            <div className="severity-value">{(selectedHazard.severity * 100).toFixed(0)}%</div>
          </div>
        </div>
        
        <div className="detail-item">
          <div className="label">Location:</div>
          <div className="value">
            {selectedHazard.location ? 
              `${selectedHazard.location.coordinates[1].toFixed(6)}, ${selectedHazard.location.coordinates[0].toFixed(6)}` : 
              'Unknown'}
          </div>
        </div>
        
        <div className="detail-item">
          <div className="label">Altitude:</div>
          <div className="value">{selectedHazard.altitude ? `${selectedHazard.altitude.toFixed(1)} m` : 'N/A'}</div>
        </div>
        
        <div className="detail-item">
          <div className="label">Radius:</div>
          <div className="value">{selectedHazard.radius ? `${selectedHazard.radius.toFixed(1)} m` : 'Unknown'}</div>
        </div>
        
        <div className="detail-item">
          <div className="label">Created:</div>
          <div className="value">{new Date(selectedHazard.timestamp).toLocaleTimeString()}</div>
        </div>
        
        <div className="detail-item">
          <div className="label">Expires:</div>
          <div className="value">{new Date(selectedHazard.expiryTime).toLocaleTimeString()}</div>
        </div>
        
        {selectedHazard.metadata && Object.keys(selectedHazard.metadata).length > 0 && (
          <>
            <h4>Additional Information</h4>
            <div className="metadata">
              {Object.entries(selectedHazard.metadata).map(([key, value]) => (
                <div key={key} className="metadata-item">
                  <div className="label">{formatKey(key)}:</div>
                  <div className="value">{formatValue(value)}</div>
                </div>
              ))}
            </div>
          </>
        )}
      </div>
    );
  };
  
  // Helper function to get severity color
  const getSeverityColor = (severity) => {
    if (severity >= 0.7) return '#ff4444';
    if (severity >= 0.4) return '#ffaa00';
    return '#44aa44';
  };
  
  // Helper function to format metadata keys
  const formatKey = (key) => {
    // Convert camelCase to Title Case With Spaces
    return key
      .replace(/([A-Z])/g, ' $1')
      .replace(/^./, str => str.toUpperCase());
  };
  
  // Helper function to format metadata values
  const formatValue = (value) => {
    if (value === null || value === undefined) return 'N/A';
    
    if (typeof value === 'object') {
      if (value instanceof Date) {
        return value.toLocaleString();
      }
      
      // Try to format GeoJSON coordinates
      if (value.coordinates && Array.isArray(value.coordinates)) {
        return `${value.coordinates[1].toFixed(6)}, ${value.coordinates[0].toFixed(6)}`;
      }
      
      return JSON.stringify(value);
    }
    
    return String(value);
  };
  
  // Render the dashboard
  return (
    <div className="iasms-visualization-dashboard">
      <div className="dashboard-header">
        <h2>IASMS Visualization Dashboard</h2>
        
        <div className="view-tabs">
          <button 
            className={activeTab === '3dView' ? 'active' : ''}
            onClick={() => setActiveTab('3dView')}
          >
            3D View
          </button>
          <button 
            className={activeTab === 'mapView' ? 'active' : ''}
            onClick={() => setActiveTab('mapView')}
          >
            Map View
          </button>
          <button 
            className={activeTab === 'analyticsView' ? 'active' : ''}
            onClick={() => setActiveTab('analyticsView')}
          >
            Analytics
          </button>
        </div>
        
        {renderSessionSelector()}
        
        <button 
          className="sidebar-toggle"
          onClick={() => setShowSidebar(!showSidebar)}
        >
          {showSidebar ? 'Hide Details' : 'Show Details'}
        </button>
      </div>
      
      <div className={`dashboard-content ${showSidebar ? 'with-sidebar' : 'without-sidebar'}`}>
        <div className="visualization-container">
          {activeTab === '3dView' && (
            <AerialTrafficVisualization 
              sessionId={activeSession}
              width="100%"
              height="100%"
              onVehicleSelected={handleVehicleSelected}
              selectedVehicleId={selectedVehicleId}
            />
          )}
          
          {activeTab === 'mapView' && (
            <div className="map-placeholder">
              <p>Map View Coming Soon</p>
            </div>
          )}
          
          {activeTab === 'analyticsView' && (
            <div className="analytics-placeholder">
              <p>Analytics View Coming Soon</p>
            </div>
          )}
        </div>
        
        {showSidebar && (
          <div className="details-sidebar">
            <div className="sidebar-tabs">
              <button 
                className={selectedVehicleId ? 'active' : ''}
                onClick={() => setActiveTab('3dView')}
                disabled={!selectedVehicleId}
              >
                Vehicle Details
              </button>
              <button 
                className={selectedHazardId ? 'active' : ''}
                onClick={() => setActiveTab('3dView')}
                disabled={!selectedHazardId}
              >
                Hazard Details
              </button>
            </div>
            
            <div className="details-content">
              {selectedVehicleId ? renderVehicleDetails() : renderHazardDetails()}
            </div>
            
            <div className="system-stats">
              <div className="stat-item">
                <div className="stat-label">Vehicles:</div>
                <div className="stat-value">{vehiclesLoading ? '...' : vehicles.length}</div>
              </div>
              <div className="stat-item">
                <div className="stat-label">Hazards:</div>
                <div className="stat-value">{hazardsLoading ? '...' : hazards.length}</div>
              </div>
              <div className="stat-item">
                <div className="stat-label">Last Update:</div>
                <div className="stat-value">{new Date().toLocaleTimeString()}</div>
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
};

export default IAMSVisualizationDashboard;
```


Finally, let's create the main integration component that ties everything together:

```textmate
/**
 * /client/iasms/components/IAMSIntegratedSimulation.jsx
 * 
 * IAMS Integrated Simulation
 * Main component for integrating simulation with IASMS
 * 
 * Copyright 2025 Autonomy Association International Inc., all rights reserved 
 * Safeguard patent license from National Aeronautics and Space Administration (NASA)
 * Copyright 2025 NASA, all rights reserved
 */

import React, { useState, useEffect } from 'react';
import { Meteor } from 'meteor/meteor';
import { useTracker } from 'meteor/react-meteor-data';
import IAMSVisualizationDashboard from './IAMSVisualizationDashboard';
import SimulationTrainingModule from './SimulationTrainingModule';
import { SimulationIntegration } from '../SimulationIntegrationClient';

const IAMSIntegratedSimulation = () => {
  const [activeMode, setActiveMode] = useState('dashboard');
  const [isInitialized, setIsInitialized] = useState(false);
  const [error, setError] = useState(null);
  
  // Track user permissions
  const { user, userLoading } = useTracker(() => {
    const handle = Meteor.subscribe('userData');
    
    return {
      user: Meteor.user(),
      userLoading: !handle.ready()
    };
  }, []);
  
  // Initialize simulation integration
  useEffect(() => {
    const initializeSimulation = async () => {
      try {
        const success = await SimulationIntegration.initialize();
        
        if (success) {
          setIsInitialized(true);
        } else {
          setError('Failed to initialize simulation integration. Please try refreshing the page.');
        }
      } catch (err) {
        console.error('Error initializing simulation integration:', err);
        setError('Failed to initialize simulation integration. Please try refreshing the page.');
      }
    };
    
    initializeSimulation();
  }, []);
  
  // Check if user has required permissions
  const hasTrainingPermission = () => {
    if (!user) return false;
    
    return user.roles && (
      user.roles.includes('admin') || 
      user.roles.includes('trainer') || 
      user.roles.includes('trainee')
    );
  };
  
  // Render loading state
  if (userLoading || !isInitialized) {
    return (
      <div className="iasms-loading">
        <div className="loading-spinner"></div>
        <div className="loading-text">Loading IASMS Integration...</div>
      </div>
    );
  }
  
  // Render error state
  if (error) {
    return (
      <div className="iasms-error">
        <div className="error-icon">⚠️</div>
        <div className="error-title">Initialization Error</div>
        <div className="error-message">{error}</div>
        <button onClick={() => window.location.reload()}>Refresh Page</button>
      </div>
    );
  }
  
  // Render the integrated interface
  return (
    <div className="iasms-integrated-simulation">
      <div className="mode-selector">
        <button 
          className={activeMode === 'dashboard' ? 'active' : ''}
          onClick={() => setActiveMode('dashboard')}
        >
          Visualization Dashboard
        </button>
        
        {hasTrainingPermission() && (
          <button 
            className={activeMode === 'training' ? 'active' : ''}
            onClick={() => setActiveMode('training')}
          >
            Training Module
          </button>
        )}
      </div>
      
      <div className="integrated-content">
        {activeMode === 'dashboard' && (
          <IAMSVisualizationDashboard />
        )}
        
        {activeMode === 'training' && hasTrainingPermission() && (
          <SimulationTrainingModule />
        )}
      </div>
    </div>
  );
};

export default IAMSIntegratedSimulation;
```


Now, let's create the necessary CSS for styling these components:

```css
/**
 * /client/iasms/styles/simulation.css
 * 
 * Styles for IASMS simulation and visualization components
 * 
 * Copyright 2025 Autonomy Association International Inc., all rights reserved 
 * Safeguard patent license from National Aeronautics and Space Administration (NASA)
 * Copyright 2025 NASA, all rights reserved
 */

/* Main container styles */
.iasms-integrated-simulation {
  display: flex;
  flex-direction: column;
  height: 100%;
  width: 100%;
  overflow: hidden;
  background-color: #f7f9fc;
}

/* Mode selector styles */
.mode-selector {
  display: flex;
  background-color: #2c3e50;
  padding: 8px 16px;
  border-bottom: 1px solid #34495e;
}

.mode-selector button {
  background-color: transparent;
  border: none;
  color: #ecf0f1;
  padding: 8px 16px;
  margin-right: 8px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;
  font-weight: 500;
  transition: background-color 0.2s;
}

.mode-selector button:hover {
  background-color: rgba(255, 255, 255, 0.1);
}

.mode-selector button.active {
  background-color: #3498db;
  color: white;
}

/* Integrated content styles */
.integrated-content {
  flex: 1;
  overflow: hidden;
}

/* Dashboard styles */
.iasms-visualization-dashboard {
  display: flex;
  flex-direction: column;
  height: 100%;
  width: 100%;
  overflow: hidden;
}

.dashboard-header {
  display: flex;
  align-items: center;
  padding: 12px 16px;
  background-color: #f0f2f5;
  border-bottom: 1px solid #dde1e6;
}

.dashboard-header h2 {
  margin: 0;
  font-size: 18px;
  font-weight: 500;
  color: #2c3e50;
  margin-right: 20px;
}

.view-tabs {
  display: flex;
  margin-right: 20px;
}

.view-tabs button {
  background-color: transparent;
  border: none;
  padding: 6px 12px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;
  color: #555;
  transition: all 0.2s;
}

.view-tabs button:hover {
  background-color: rgba(0, 0, 0, 0.05);
}

.view-tabs button.active {
  background-color: #3498db;
  color: white;
}

.session-selector {
  display: flex;
  align-items: center;
  margin-left: auto;
}

.session-selector select {
  padding: 6px 12px;
  border-radius: 4px;
  border: 1px solid #ddd;
  background-color: white;
  font-size: 14px;
  margin-right: 10px;
  min-width: 200px;
}

.create-session-button {
  background-color: #2ecc71;
  color: white;
  border: none;
  padding: 6px 12px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;
  transition: background-color 0.2s;
}

.create-session-button:hover {
  background-color: #27ae60;
}

.sidebar-toggle {
  background-color: #7f8c8d;
  color: white;
  border: none;
  padding: 6px 12px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;
  margin-left: 10px;
  transition: background-color 0.2s;
}

.sidebar-toggle:hover {
  background-color: #95a5a6;
}

/* Dashboard content */
.dashboard-content {
  display: flex;
  flex: 1;
  overflow: hidden;
}

.visualization-container {
  flex: 1;
  overflow: hidden;
  position: relative;
}

/* Sidebar styles */
.details-sidebar {
  width: 320px;
  background-color: white;
  border-left: 1px solid #dde1e6;
  display: flex;
  flex-direction: column;
  overflow: hidden;
}

.dashboard-content.with-sidebar .visualization-container {
  width: calc(100% - 320px);
}

.dashboard-content.without-sidebar .visualization-container {
  width: 100%;
}

.sidebar-tabs {
  display: flex;
  border-bottom: 1px solid #dde1e6;
}

.sidebar-tabs button {
  flex: 1;
  background-color: #f7f9fc;
  border: none;
  padding: 12px;
  cursor: pointer;
  font-size: 14px;
  color: #7f8c8d;
  transition: background-color 0.2s;
}

.sidebar-tabs button:hover:not(:disabled) {
  background-color: #ecf0f1;
}

.sidebar-tabs button.active {
  background-color: white;
  color: #3498db;
  border-bottom: 2px solid #3498db;
}

.sidebar-tabs button:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.details-content {
  flex: 1;
  overflow-y: auto;
  padding: 16px;
}

/* Vehicle and hazard details */
.vehicle-details,
.hazard-details {
  font-size: 14px;
}

.vehicle-details h3,
.hazard-details h3 {
  margin-top: 0;
  margin-bottom: 16px;
  font-size: 16px;
  font-weight: 500;
  color: #2c3e50;
}

.vehicle-details h4,
.hazard-details h4 {
  margin-top: 20px;
  margin-bottom: 12px;
  font-size: 14px;
  font-weight: 500;
  color: #34495e;
}

.detail-item {
  display: flex;
  margin-bottom: 8px;
}

.detail-item .label {
  width: 100px;
  font-weight: 500;
  color: #7f8c8d;
}

.detail-item .value {
  flex: 1;
  color: #2c3e50;
}

.status-value {
  display: flex;
  align-items: center;
}

.status-indicator {
  width: 10px;
  height: 10px;
  border-radius: 50%;
  margin-right: 6px;
}

.status-indicator.active {
  background-color: #2ecc71;
}

.status-indicator.inactive {
  background-color: #95a5a6;
}

.status-indicator.warning {
  background-color: #f39c12;
}

.status-indicator.error {
  background-color: #e74c3c;
}

.status-indicator.unknown {
  background-color: #bdc3c7;
}

.severity-bar {
  height: 8px;
  width: 100%;
  background-color: #ecf0f1;
  border-radius: 4px;
  overflow: hidden;
  margin-bottom: 4px;
}

.severity-fill {
  height: 100%;
  border-radius: 4px;
}

.severity-value {
  text-align: right;
  font-size: 12px;
  color: #7f8c8d;
}

/* Risks list */
.risks-list {
  margin-top: 8px;
}

.risk-item {
  margin-bottom: 12px;
  padding: 10px;
  border-radius: 4px;
  background-color: #f8f9fa;
  border-left: 4px solid #95a5a6;
}

.risk-item.risk-high {
  border-left-color: #e74c3c;
  background-color: rgba(231, 76, 60, 0.05);
}

.risk-item.risk-medium {
  border-left-color: #f39c12;
  background-color: rgba(243, 156, 18, 0.05);
}

.risk-item.risk-low {
  border-left-color: #2ecc71;
  background-color: rgba(46, 204, 113, 0.05);
}

.risk-header {
  display: flex;
  justify-content: space-between;
  margin-bottom: 6px;
}

.risk-level {
  font-weight: 500;
}

.risk-high .risk-level {
  color: #c0392b;
}

.risk-medium .risk-level {
  color: #d35400;
}

.risk-low .risk-level {
  color: #27ae60;
}

.risk-value {
  font-weight: 500;
}

.risk-hazard {
  margin-bottom: 8px;
  font-size: 13px;
}

.risk-factors {
  font-size: 12px;
  color: #7f8c8d;
}

.risk-factor {
  display: flex;
  justify-content: space-between;
  margin-bottom: 4px;
}

/* Metadata */
.metadata {
  font-size: 13px;
}

.metadata-item {
  display: flex;
  margin-bottom: 6px;
}

.metadata-item .label {
  width: 120px;
  font-weight: 500;
  color: #7f8c8d;
}

.metadata-item .value {
  flex: 1;
  color: #2c3e50;
  word-break: break-word;
}

/* Empty selection */
.empty-selection {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 200px;
  color: #95a5a6;
  text-align: center;
}

.empty-selection p {
  margin: 0;
  margin-bottom: 8px;
}

.empty-selection .hint {
  font-size: 12px;
  opacity: 0.7;
}

/* System stats */
.system-stats {
  padding: 12px 16px;
  border-top: 1px solid #dde1e6;
  background-color: #f7f9fc;
  font-size: 12px;
}

.stat-item {
  display: flex;
  margin-bottom: 4px;
}

.stat-label {
  width: 80px;
  color: #7f8c8d;
}

.stat-value {
  flex: 1;
  color: #2c3e50;
  font-weight: 500;
}

/* Loading states */
.iasms-loading {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100%;
  width: 100%;
}

.loading-spinner {
  width: 40px;
  height: 40px;
  border: 4px solid rgba(52, 152, 219, 0.2);
  border-radius: 50%;
  border-top-color: #3498db;
  animation: spin 1s ease-in-out infinite;
  margin-bottom: 16px;
}

@keyframes spin {
  to { transform: rotate(360deg); }
}

.loading-text {
  color: #7f8c8d;
  font-size: 16px;
}

/* Error states */
.iasms-error {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100%;
  width: 100%;
  padding: 20px;
}

.error-icon {
  font-size: 48px;
  margin-bottom: 16px;
}

.error-title {
  font-size: 20px;
  font-weight: 500;
  color: #e74c3c;
  margin-bottom: 8px;
}

.error-message {
  font-size: 16px;
  color: #7f8c8d;
  margin-bottom: 16px;
  text-align: center;
  max-width: 600px;
}

.iasms-error button {
  background-color: #3498db;
  color: white;
  border: none;
  padding: 8px 16px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;
  transition: background-color 0.2s;
}

.iasms-error button:hover {
  background-color: #2980b9;
}

/* Placeholder styles */
.map-placeholder,
.analytics-placeholder {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100%;
  color: #95a5a6;
  font-size: 18px;
  background-color: #f0f2f5;
}

/* Training module styles */
.simulation-training-module {
  display: flex;
  flex-direction: column;
  height: 100%;
  width: 100%;
  overflow: hidden;
  background-color: #f7f9fc;
}

.module-header {
  display: flex;
  align-items: center;
  padding: 12px 16px;
  background-color: #2c3e50;
  color: white;
}

.module-header h2 {
  margin: 0;
  font-size: 18px;
  font-weight: 500;
  margin-right: 20px;
}

.tab-navigation {
  display: flex;
}

.tab-navigation button {
  background-color: transparent;
  border: none;
  color: #ecf0f1;
  padding: 8px 16px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;
  transition: background-color 0.2s;
}

.tab-navigation button:hover {
  background-color: rgba(255, 255, 255, 0.1);
}

.tab-navigation button.active {
  background-color: #3498db;
}

.back-button {
  background-color: transparent;
  border: none;
  color: #ecf0f1;
  padding: 8px 16px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;
  transition: background-color 0.2s;
  margin-right: auto;
}

.back-button:hover {
  background-color: rgba(255, 255, 255, 0.1);
}

.close-button {
  background-color: rgba(231, 76, 60, 0.8);
  border: none;
  color: white;
  padding: 6px 12px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;
  transition: background-color 0.2s;
  margin-left: auto;
}

.close-button:hover {
  background-color: #e74c3c;
}

.error-message {
  background-color: #fdedec;
  color: #c0392b;
  padding: 12px;
  margin: 10px;
  border-radius: 4px;
  font-size: 14px;
  border-left: 4px solid #e74c3c;
}

.module-content {
  flex: 1;
  overflow: auto;
  padding: 16px;
}

/* Scenarios */
.scenarios-container {
  margin-bottom: 20px;
}

.scenario-category {
  margin-bottom: 24px;
}

.scenario-category h3 {
  margin-top: 0;
  margin-bottom: 12px;
  font-size: 16px;
  font-weight: 500;
  color: #2c3e50;
  border-bottom: 1px solid #ecf0f1;
  padding-bottom: 8px;
}

.scenario-list {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 16px;
}

.scenario-card {
  background-color: white;
  border-radius: 8px;
  padding: 16px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  cursor: pointer;
  transition: transform 0.2s, box-shadow 0.2s;
  border: 2px solid transparent;
}

.scenario-card:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.scenario-card.selected {
  border-color: #3498db;
}

.scenario-card h4 {
  margin-top: 0;
  margin-bottom: 8px;
  font-size: 16px;
  font-weight: 500;
  color: #2c3e50;
}

.scenario-card .difficulty {
  display: inline-block;
  padding: 4px 8px;
  border-radius: 4px;
  font-size: 12px;
  font-weight: 500;
  margin-bottom: 12px;
  background-color: #ecf0f1;
  color: #7f8c8d;
}

.scenario-card p {
  margin: 0;
  margin-bottom: 16px;
  font-size: 14px;
  color: #7f8c8d;
  line-height: 1.4;
}

.start-button {
  width: 100%;
  background-color: #3498db;
  color: white;
  border: none;
  padding: 8px 16px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;
  transition: background-color 0.2s;
}

.start-button:hover {
  background-color: #2980b9;
}

/* Sessions */
.sessions-container {
  margin-bottom: 20px;
}

.session-list {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 16px;
}

.session-card {
  background-color: white;
  border-radius: 8px;
  padding: 16px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.session-card h4 {
  margin-top: 0;
  margin-bottom: 12px;
  font-size: 16px;
  font-weight: 500;
  color: #2c3e50;
}

.session-info {
  margin-bottom: 16px;
  font-size: 14px;
  color: #7f8c8d;
}

.session-info div {
  margin-bottom: 4px;
}

.join-button {
  width: 100%;
  background-color: #2ecc71;
  color: white;
  border: none;
  padding: 8px 16px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;
  transition: background-color 0.2s;
}

.join-button:hover {
  background-color: #27ae60;
}

/* Simulation */
.simulation-container {
  background-color: white;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.simulation-controls {
  padding: 16px;
  display: flex;
  justify-content: flex-end;
  background-color: #f7f9fc;
  border-top: 1px solid #ecf0f1;
}

.end-session-button {
  background-color: #e74c3c;
  color: white;
  border: none;
  padding: 8px 16px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;
  transition: background-color 0.2s;
}

.end-session-button:hover {
  background-color: #c0392b;
}
```


These components and styles will create a comprehensive integration of our 3D simulation capabilities with the existing IASMS system. The integration includes:

1. A visualization dashboard that shows real-time aerial vehicle data in 3D
2. A training module for running simulation scenarios
3. Detailed vehicle and hazard information panels
4. Real-time synchronization with the IASMS system's data

To complete the integration, we need to add these files to the project and update the main application component to include our new integrated simulation component.

Let's create a final file to import the styles and register the components:

```textmate
/**
 * /client/iasms/IAMSIntegrationModule.js
 * 
 * IAMS Integration Module
 * Main entry point for IAMS visualization and simulation integration
 * 
 * Copyright 2025 Autonomy Association International Inc., all rights reserved 
 * Safeguard patent license from National Aeronautics and Space Administration (NASA)
 * Copyright 2025 NASA, all rights reserved
 */

import { Meteor } from 'meteor/meteor';
import { Template } from 'meteor/templating';
import { ReactiveVar } from 'meteor/reactive-var';
import React from 'react';
import { render } from 'react-dom';

import './styles/simulation.css';
import IAMSIntegratedSimulation from './components/IAMSIntegratedSimulation';
import { SimulationIntegration } from './SimulationIntegrationClient';

// Register template helper
Template.registerHelper('IAMSIntegrationReady', () => {
  return SimulationIntegration.status.get() === 'READY';
});

// Register startup code
Meteor.startup(() => {
  // Add integration to main app if needed
  const integrationContainer = document.getElementById('iasms-integration-container');
  
  if (integrationContainer) {
    render(<IAMSIntegratedSimulation />, integrationContainer);
  }
});

// Export components for direct use
export {
  IAMSIntegratedSimulation,
  SimulationIntegration
};
```


This completes the full integration of our 3D simulation capabilities with the IASMS system. The integration provides:

1. Real-time visualization of aerial vehicles, hazards, and risks
2. Simulation and training scenarios for operators
3. Detailed information about vehicles and hazards
4. A unified interface that connects to the existing IASMS modules

The components are designed to be modular and extensible, making it easy to add new features or visualizations as needed.
