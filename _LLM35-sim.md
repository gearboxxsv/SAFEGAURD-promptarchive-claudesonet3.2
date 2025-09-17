I'll analyze the current IASMS system and identify gaps to fulfill all the goals of the NASA Integrated Airspace Safety Management System. Let me review the files and implement missing features, particularly focusing on AR/VR capabilities across the codebase.

## Analysis of Current Implementation

Looking at the existing codebase, I notice we have:
1. Core server implementation (`IasmsServer.js`)
2. Various modules for safety management (battery health, vertiport emergency, lost link, etc.)
3. Dashboard views and UI components
4. Contingency planning system
5. Communication protocols (Agent Protocol, Message Communication Protocol)

However, I can identify several missing components:

1. **Simulation and Training Module**: Missing a comprehensive training system
2. **AR/VR Integration**: Minimal AR/VR features for visualization and training
3. **Remote Collaboration Tools**: Limited tools for distributed team operations
4. **Predictive Analytics**: Could enhance with machine learning capabilities
5. **Digital Twin Integration**: Missing digital twin capabilities

Let me create and update these files to provide a complete IASMS implementation.

## Implementation Plan

1. Create `IasmsSimulationTrainingModule.js` for training scenarios
2. Create `IasmsArVrModule.js` for augmented/virtual reality features
3. Create `IasmsDigitalTwinModule.js` for digital twin capabilities
4. Update UI components with AR/VR features
5. Implement machine learning prediction integration

Let's start with these implementations:Let me create the missing simulation training module for IASMS that will enhance the system with comprehensive AR/VR capabilities across the codebase. This module will enable training, simulation, and enhanced visualization for the IASMS system.After analyzing the codebase and reviewing the remaining work, I need to create the `IasmsSimulationTrainingModule.js` file that was mentioned in the previous chat. This module will enhance the IASMS system with simulation and training capabilities, which will be critical for providing AR/VR features and fulfilling the goals of NASA's system-wide information management system.I'll create a comprehensive implementation of the missing simulation and training module for IASMS, along with AR/VR features that enhance the system. Let's start with the simulation training module and then add AR/VR components.

```javascript
/**
 * /server/iasms/modules/IasmsSimulationTrainingModule.js
 * 
 * IASMS Simulation & Training Module - Provides simulation capabilities and training scenarios
 * 
 * Copyright 2025 Autonomy Association International Inc., all rights reserved 
 * Safeguard patent license from National Aeronautics and Space Administration (NASA)
 * Copyright 2025 NASA, all rights reserved
 * 
 * @fileoverview This module provides simulation capabilities for training, testing, and
 * evaluation of the IASMS system, including scenario generation, playback, and analysis.
 */

import { Meteor } from 'meteor/meteor';
import { EventEmitter } from 'events';
import { Random } from 'meteor/random';
import turf from '@turf/turf';
import { 
  IasmsVehicleStates, 
  IasmsHazards, 
  IasmsRisks, 
  IasmsMitigations, 
  IasmsTrajectories,
  IasmsWeatherData 
} from '../IAsmsCoreService';

/**
 * IASMS Simulation & Training Module
 * Provides simulation capabilities for training and testing
 */
export class IasmsSimulationTrainingModule extends EventEmitter {
  /**
   * Constructor for the IASMS Simulation & Training Module
   * @param {Object} options - Configuration options
   */
  constructor(options = {}) {
    super();
    
    this.options = {
      scenarioLibraryPath: options.scenarioLibraryPath || '/scenarios',
      maxSimulationDuration: options.maxSimulationDuration || 3600, // 1 hour by default
      simulationSpeedFactor: options.simulationSpeedFactor || 1.0, // Real-time by default
      maxActiveSimulations: options.maxActiveSimulations || 5,
      ...options
    };
    
    this.activeSimulations = new Map();
    this.scenarioLibrary = new Map();
    this.simulationIntervalIds = new Map();
    this.simulationCounters = new Map();
    this.simulationDataSources = new Map();
    this.simulatedVehicles = new Map();
    this.simulatedHazards = new Map();
    
    // Simulation collections (for storing simulation-specific data)
    this.simulationCollections = {
      vehicleStates: new Mongo.Collection('iasmsSimulationVehicleStates'),
      hazards: new Mongo.Collection('iasmsSimulationHazards'),
      risks: new Mongo.Collection('iasmsSimulationRisks'),
      mitigations: new Mongo.Collection('iasmsSimulationMitigations'),
      trajectories: new Mongo.Collection('iasmsSimulationTrajectories'),
      weatherData: new Mongo.Collection('iasmsSimulationWeatherData'),
      metrics: new Mongo.Collection('iasmsSimulationMetrics'),
      events: new Mongo.Collection('iasmsSimulationEvents'),
      userActions: new Mongo.Collection('iasmsSimulationUserActions')
    };
    
    // Virtual Reality session management
    this.vrSessions = new Map();
    this.vrInteractions = new Map();
    this.vrCollectionHandles = new Map();
    
    // Augmented Reality overlays
    this.arOverlays = new Map();
    this.arDataSources = new Map();
    this.arUserSettings = new Map();
  }

  /**
   * Initialize the Simulation & Training Module
   * @returns {Promise<boolean>} True if initialization was successful
   */
  async initialize() {
    try {
      console.log('Initializing IASMS Simulation & Training Module...');
      
      // Load scenarios from database
      await this._loadScenarioLibrary();
      
      // Register simulation data providers
      this._registerDefaultSimulationProviders();
      
      // Set up database collections indexes
      await this._setupCollectionIndexes();
      
      // Register Meteor methods for simulation control
      this._registerMeteorMethods();
      
      // Set up publications for reactive data
      this._setupPublications();
      
      console.log('IASMS Simulation & Training Module initialized successfully');
      return true;
    } catch (error) {
      console.error('Failed to initialize IASMS Simulation & Training Module:', error);
      throw error;
    }
  }

  /**
   * Create a new simulation based on a scenario
   * @param {Object} options - Simulation options
   * @param {string} options.scenarioId - ID of the scenario to simulate
   * @param {string} options.userId - ID of the user running the simulation
   * @param {Object} options.parameters - Custom parameters for the simulation
   * @param {number} options.speedFactor - Simulation speed factor (1.0 = real-time)
   * @param {boolean} options.recordMetrics - Whether to record metrics during simulation
   * @returns {Promise<Object>} Simulation result with simulationId
   */
  async createSimulation(options) {
    try {
      // Validate options
      if (!options.scenarioId) {
        throw new Error('Scenario ID is required');
      }
      
      // Check if we're at the maximum number of active simulations
      if (this.activeSimulations.size >= this.options.maxActiveSimulations) {
        throw new Error(`Maximum number of active simulations (${this.options.maxActiveSimulations}) reached`);
      }
      
      // Get scenario
      const scenario = this.scenarioLibrary.get(options.scenarioId);
      if (!scenario) {
        throw new Error(`Scenario ${options.scenarioId} not found`);
      }
      
      // Create simulation ID
      const simulationId = `sim-${Random.id()}`;
      
      // Create simulation object
      const simulation = {
        simulationId,
        scenarioId: options.scenarioId,
        userId: options.userId,
        status: 'INITIALIZED',
        parameters: options.parameters || {},
        speedFactor: options.speedFactor || this.options.simulationSpeedFactor,
        recordMetrics: options.recordMetrics !== undefined ? options.recordMetrics : true,
        startTime: null,
        currentTime: null,
        endTime: null,
        createdAt: new Date(),
        metrics: {
          vehicleCount: 0,
          hazardCount: 0,
          riskCount: 0,
          mitigationCount: 0,
          collisionCount: 0,
          totalEvents: 0
        }
      };
      
      // Add simulation to active simulations
      this.activeSimulations.set(simulationId, simulation);
      
      // Initialize simulation counters
      this.simulationCounters.set(simulationId, {
        step: 0,
        time: 0,
        entities: {
          vehicles: 0,
          hazards: 0,
          risks: 0,
          mitigations: 0,
          events: 0
        }
      });
      
      // Set up simulation-specific collections for isolation
      await this._setupSimulationCollections(simulationId);
      
      // Initialize simulation data sources
      await this._initializeSimulationDataSources(simulationId, scenario);
      
      // Load initial state
      await this._loadScenarioInitialState(simulationId, scenario);
      
      // Return simulation details
      return {
        success: true,
        simulationId,
        scenario: {
          id: scenario.scenarioId,
          name: scenario.name,
          description: scenario.description
        },
        status: 'INITIALIZED'
      };
    } catch (error) {
      console.error('Error creating simulation:', error);
      return {
        success: false,
        error: error.message
      };
    }
  }

  /**
   * Start a simulation
   * @param {string} simulationId - ID of the simulation to start
   * @returns {Promise<Object>} Start result
   */
  async startSimulation(simulationId) {
    try {
      // Check if simulation exists
      if (!this.activeSimulations.has(simulationId)) {
        throw new Error(`Simulation ${simulationId} not found`);
      }
      
      // Get simulation
      const simulation = this.activeSimulations.get(simulationId);
      
      // Check if simulation is in a startable state
      if (simulation.status !== 'INITIALIZED' && simulation.status !== 'PAUSED') {
        throw new Error(`Simulation ${simulationId} cannot be started (current status: ${simulation.status})`);
      }
      
      // Update simulation status
      simulation.status = 'RUNNING';
      simulation.startTime = simulation.startTime || new Date();
      simulation.currentTime = new Date();
      
      // Set up simulation interval
      const stepInterval = Math.floor(1000 / simulation.speedFactor); // Base interval adjusted by speed factor
      const intervalId = Meteor.setInterval(() => {
        this._runSimulationStep(simulationId);
      }, stepInterval);
      
      // Store interval ID
      this.simulationIntervalIds.set(simulationId, intervalId);
      
      // Emit event
      this.emit('simulation:started', {
        simulationId,
        startTime: simulation.startTime,
        speedFactor: simulation.speedFactor
      });
      
      // Log simulation start
      this._logSimulationEvent(simulationId, 'SIMULATION_STARTED', {
        startTime: simulation.startTime,
        speedFactor: simulation.speedFactor
      });
      
      return {
        success: true,
        simulationId,
        status: 'RUNNING',
        startTime: simulation.startTime
      };
    } catch (error) {
      console.error('Error starting simulation:', error);
      return {
        success: false,
        error: error.message
      };
    }
  }

  /**
   * Pause a simulation
   * @param {string} simulationId - ID of the simulation to pause
   * @returns {Promise<Object>} Pause result
   */
  async pauseSimulation(simulationId) {
    try {
      // Check if simulation exists
      if (!this.activeSimulations.has(simulationId)) {
        throw new Error(`Simulation ${simulationId} not found`);
      }
      
      // Get simulation
      const simulation = this.activeSimulations.get(simulationId);
      
      // Check if simulation is running
      if (simulation.status !== 'RUNNING') {
        throw new Error(`Simulation ${simulationId} is not running (current status: ${simulation.status})`);
      }
      
      // Clear interval
      if (this.simulationIntervalIds.has(simulationId)) {
        Meteor.clearInterval(this.simulationIntervalIds.get(simulationId));
        this.simulationIntervalIds.delete(simulationId);
      }
      
      // Update simulation status
      simulation.status = 'PAUSED';
      simulation.currentTime = new Date();
      
      // Emit event
      this.emit('simulation:paused', {
        simulationId,
        pauseTime: simulation.currentTime
      });
      
      // Log simulation pause
      this._logSimulationEvent(simulationId, 'SIMULATION_PAUSED', {
        pauseTime: simulation.currentTime
      });
      
      return {
        success: true,
        simulationId,
        status: 'PAUSED',
        pauseTime: simulation.currentTime
      };
    } catch (error) {
      console.error('Error pausing simulation:', error);
      return {
        success: false,
        error: error.message
      };
    }
  }

  /**
   * Stop a simulation
   * @param {string} simulationId - ID of the simulation to stop
   * @returns {Promise<Object>} Stop result
   */
  async stopSimulation(simulationId) {
    try {
      // Check if simulation exists
      if (!this.activeSimulations.has(simulationId)) {
        throw new Error(`Simulation ${simulationId} not found`);
      }
      
      // Get simulation
      const simulation = this.activeSimulations.get(simulationId);
      
      // Check if simulation can be stopped
      if (simulation.status === 'COMPLETED' || simulation.status === 'STOPPED') {
        throw new Error(`Simulation ${simulationId} is already stopped (current status: ${simulation.status})`);
      }
      
      // Clear interval
      if (this.simulationIntervalIds.has(simulationId)) {
        Meteor.clearInterval(this.simulationIntervalIds.get(simulationId));
        this.simulationIntervalIds.delete(simulationId);
      }
      
      // Update simulation status
      simulation.status = 'STOPPED';
      simulation.endTime = new Date();
      
      // Generate simulation summary and save metrics
      const summary = await this._generateSimulationSummary(simulationId);
      
      // Emit event
      this.emit('simulation:stopped', {
        simulationId,
        endTime: simulation.endTime,
        metrics: summary.metrics
      });
      
      // Log simulation stop
      this._logSimulationEvent(simulationId, 'SIMULATION_STOPPED', {
        endTime: simulation.endTime,
        metrics: summary.metrics
      });
      
      // Clean up simulation resources (after a delay to allow clients to fetch final state)
      Meteor.setTimeout(() => {
        this._cleanupSimulation(simulationId);
      }, 300000); // 5 minute delay
      
      return {
        success: true,
        simulationId,
        status: 'STOPPED',
        endTime: simulation.endTime,
        summary
      };
    } catch (error) {
      console.error('Error stopping simulation:', error);
      return {
        success: false,
        error: error.message
      };
    }
  }

  /**
   * Set simulation speed factor
   * @param {string} simulationId - ID of the simulation
   * @param {number} speedFactor - New speed factor (1.0 = real-time)
   * @returns {Promise<Object>} Result
   */
  async setSimulationSpeed(simulationId, speedFactor) {
    try {
      // Validate input
      if (speedFactor <= 0) {
        throw new Error('Speed factor must be greater than 0');
      }
      
      // Check if simulation exists
      if (!this.activeSimulations.has(simulationId)) {
        throw new Error(`Simulation ${simulationId} not found`);
      }
      
      // Get simulation
      const simulation = this.activeSimulations.get(simulationId);
      
      // Update speed factor
      simulation.speedFactor = speedFactor;
      
      // If simulation is running, restart interval with new speed
      if (simulation.status === 'RUNNING' && this.simulationIntervalIds.has(simulationId)) {
        Meteor.clearInterval(this.simulationIntervalIds.get(simulationId));
        
        const stepInterval = Math.floor(1000 / speedFactor);
        const intervalId = Meteor.setInterval(() => {
          this._runSimulationStep(simulationId);
        }, stepInterval);
        
        this.simulationIntervalIds.set(simulationId, intervalId);
      }
      
      // Log speed change
      this._logSimulationEvent(simulationId, 'SIMULATION_SPEED_CHANGED', {
        speedFactor,
        timestamp: new Date()
      });
      
      return {
        success: true,
        simulationId,
        speedFactor
      };
    } catch (error) {
      console.error('Error setting simulation speed:', error);
      return {
        success: false,
        error: error.message
      };
    }
  }

  /**
   * Inject a custom event into a simulation
   * @param {string} simulationId - ID of the simulation
   * @param {Object} eventData - Event data to inject
   * @returns {Promise<Object>} Result
   */
  async injectSimulationEvent(simulationId, eventData) {
    try {
      // Check if simulation exists
      if (!this.activeSimulations.has(simulationId)) {
        throw new Error(`Simulation ${simulationId} not found`);
      }
      
      // Get simulation
      const simulation = this.activeSimulations.get(simulationId);
      
      // Check if simulation is running or paused
      if (simulation.status !== 'RUNNING' && simulation.status !== 'PAUSED') {
        throw new Error(`Simulation ${simulationId} is not active (current status: ${simulation.status})`);
      }
      
      // Process event based on type
      switch (eventData.type) {
        case 'ADD_VEHICLE':
          return await this._injectVehicle(simulationId, eventData);
          
        case 'ADD_HAZARD':
          return await this._injectHazard(simulationId, eventData);
          
        case 'MODIFY_WEATHER':
          return await this._injectWeather(simulationId, eventData);
          
        case 'TRIGGER_COMMUNICATION_LOSS':
          return await this._triggerCommunicationLoss(simulationId, eventData);
          
        case 'TRIGGER_EMERGENCY':
          return await this._triggerEmergency(simulationId, eventData);
          
        case 'ADD_TRAJECTORY':
          return await this._injectTrajectory(simulationId, eventData);
          
        default:
          throw new Error(`Unknown event type: ${eventData.type}`);
      }
    } catch (error) {
      console.error('Error injecting simulation event:', error);
      return {
        success: false,
        error: error.message
      };
    }
  }

  /**
   * Get all available training scenarios
   * @returns {Promise<Array>} List of scenarios
   */
  async getScenarios() {
    try {
      return Array.from(this.scenarioLibrary.values()).map(scenario => ({
        id: scenario.scenarioId,
        name: scenario.name,
        description: scenario.description,
        difficulty: scenario.difficulty,
        duration: scenario.duration,
        categories: scenario.categories,
        objectives: scenario.objectives
      }));
    } catch (error) {
      console.error('Error getting scenarios:', error);
      throw error;
    }
  }

  /**
   * Get simulation details
   * @param {string} simulationId - ID of the simulation
   * @returns {Promise<Object>} Simulation details
   */
  async getSimulationDetails(simulationId) {
    try {
      // Check if simulation exists
      if (!this.activeSimulations.has(simulationId)) {
        throw new Error(`Simulation ${simulationId} not found`);
      }
      
      // Get simulation
      const simulation = this.activeSimulations.get(simulationId);
      
      // Get metrics and summary data
      const metrics = await this.simulationCollections.metrics.findOne({ simulationId });
      const events = await this.simulationCollections.events.find({ simulationId }).fetch();
      
      // Get counts
      const vehicleCount = await this.simulationCollections.vehicleStates.find({ simulationId }).count();
      const hazardCount = await this.simulationCollections.hazards.find({ simulationId }).count();
      const riskCount = await this.simulationCollections.risks.find({ simulationId }).count();
      const mitigationCount = await this.simulationCollections.mitigations.find({ simulationId }).count();
      
      // Get scenario
      const scenario = this.scenarioLibrary.get(simulation.scenarioId);
      
      return {
        simulation: {
          id: simulationId,
          status: simulation.status,
          startTime: simulation.startTime,
          currentTime: simulation.currentTime,
          endTime: simulation.endTime,
          speedFactor: simulation.speedFactor,
          recordMetrics: simulation.recordMetrics,
          createdAt: simulation.createdAt,
          userId: simulation.userId
        },
        scenario: scenario ? {
          id: scenario.scenarioId,
          name: scenario.name,
          description: scenario.description,
          difficulty: scenario.difficulty,
          categories: scenario.categories
        } : null,
        statistics: {
          vehicleCount,
          hazardCount,
          riskCount,
          mitigationCount,
          eventCount: events.length
        },
        metrics: metrics || {},
        recentEvents: events.slice(0, 10)
      };
    } catch (error) {
      console.error('Error getting simulation details:', error);
      throw error;
    }
  }

  /**
   * Create an AR/VR session for a simulation
   * @param {Object} options - Session options
   * @param {string} options.simulationId - ID of the simulation
   * @param {string} options.userId - ID of the user
   * @param {string} options.mode - Session mode ('AR' or 'VR')
   * @param {Object} options.deviceInfo - Information about the device
   * @returns {Promise<Object>} Session details
   */
  async createImmersiveSession(options) {
    try {
      // Validate options
      if (!options.simulationId || !options.userId || !options.mode) {
        throw new Error('Missing required options: simulationId, userId, mode');
      }
      
      // Check if simulation exists
      if (!this.activeSimulations.has(options.simulationId)) {
        throw new Error(`Simulation ${options.simulationId} not found`);
      }
      
      // Create session ID
      const sessionId = `${options.mode.toLowerCase()}-${Random.id()}`;
      
      // Create session object
      const session = {
        sessionId,
        simulationId: options.simulationId,
        userId: options.userId,
        mode: options.mode,
        deviceInfo: options.deviceInfo || {},
        status: 'ACTIVE',
        startTime: new Date(),
        endTime: null,
        lastHeartbeat: new Date(),
        viewSettings: {
          showLabels: true,
          showTrajectories: true,
          showRisks: true,
          showMitigations: true,
          showWeather: true,
          labelScale: 1.0,
          objectScale: 1.0
        },
        position: options.position || null,
        viewMatrix: options.viewMatrix || null
      };
      
      // Store session
      if (options.mode === 'VR') {
        this.vrSessions.set(sessionId, session);
      } else {
        this.arOverlays.set(sessionId, session);
      }
      
      // Set up reactive data subscriptions for this session
      await this._setupImmersiveDataHandlers(sessionId, options.mode, options.simulationId);
      
      // Log session creation
      this._logSimulationEvent(options.simulationId, `${options.mode}_SESSION_CREATED`, {
        sessionId,
        userId: options.userId,
        deviceInfo: options.deviceInfo
      });
      
      return {
        success: true,
        sessionId,
        simulationId: options.simulationId,
        mode: options.mode,
        viewSettings: session.viewSettings
      };
    } catch (error) {
      console.error('Error creating immersive session:', error);
      return {
        success: false,
        error: error.message
      };
    }
  }

  /**
   * Update an AR/VR session
   * @param {string} sessionId - ID of the session
   * @param {Object} updates - Updates to apply
   * @returns {Promise<Object>} Update result
   */
  async updateImmersiveSession(sessionId, updates) {
    try {
      // Find session
      let session = this.vrSessions.get(sessionId);
      let isVr = true;
      
      if (!session) {
        session = this.arOverlays.get(sessionId);
        isVr = false;
        
        if (!session) {
          throw new Error(`Session ${sessionId} not found`);
        }
      }
      
      // Update heartbeat timestamp
      session.lastHeartbeat = new Date();
      
      // Apply updates
      if (updates.position) {
        session.position = updates.position;
      }
      
      if (updates.viewMatrix) {
        session.viewMatrix = updates.viewMatrix;
      }
      
      if (updates.viewSettings) {
        session.viewSettings = {
          ...session.viewSettings,
          ...updates.viewSettings
        };
      }
      
      // Store updated session
      if (isVr) {
        this.vrSessions.set(sessionId, session);
      } else {
        this.arOverlays.set(sessionId, session);
      }
      
      return {
        success: true,
        sessionId,
        updated: Object.keys(updates)
      };
    } catch (error) {
      console.error('Error updating immersive session:', error);
      return {
        success: false,
        error: error.message
      };
    }
  }

  /**
   * End an AR/VR session
   * @param {string} sessionId - ID of the session
   * @returns {Promise<Object>} Result
   */
  async endImmersiveSession(sessionId) {
    try {
      // Find session
      let session = this.vrSessions.get(sessionId);
      let isVr = true;
      
      if (!session) {
        session = this.arOverlays.get(sessionId);
        isVr = false;
        
        if (!session) {
          throw new Error(`Session ${sessionId} not found`);
        }
      }
      
      // Update session status
      session.status = 'ENDED';
      session.endTime = new Date();
      
      // Clean up data handlers
      if (this.vrCollectionHandles.has(sessionId)) {
        for (const handle of this.vrCollectionHandles.get(sessionId)) {
          handle.stop();
        }
        this.vrCollectionHandles.delete(sessionId);
      }
      
      // Remove session
      if (isVr) {
        this.vrSessions.delete(sessionId);
      } else {
        this.arOverlays.delete(sessionId);
      }
      
      // Log session end
      this._logSimulationEvent(session.simulationId, `${session.mode}_SESSION_ENDED`, {
        sessionId,
        userId: session.userId,
        duration: (session.endTime - session.startTime) / 1000 // duration in seconds
      });
      
      return {
        success: true,
        sessionId,
        duration: (session.endTime - session.startTime) / 1000
      };
    } catch (error) {
      console.error('Error ending immersive session:', error);
      return {
        success: false,
        error: error.message
      };
    }
  }

  /**
   * Record a user interaction in an AR/VR session
   * @param {string} sessionId - ID of the session
   * @param {Object} interaction - Interaction data
   * @returns {Promise<Object>} Result
   */
  async recordImmersiveInteraction(sessionId, interaction) {
    try {
      // Find session
      let session = this.vrSessions.get(sessionId);
      let isVr = true;
      
      if (!session) {
        session = this.arOverlays.get(sessionId);
        isVr = false;
        
        if (!session) {
          throw new Error(`Session ${sessionId} not found`);
        }
      }
      
      // Create interaction record
      const interactionRecord = {
        interactionId: `int-${Random.id()}`,
        sessionId,
        simulationId: session.simulationId,
        userId: session.userId,
        timestamp: new Date(),
        type: interaction.type,
        target: interaction.target,
        position: interaction.position || session.position,
        data: interaction.data || {}
      };
      
      // Store interaction
      this.vrInteractions.set(interactionRecord.interactionId, interactionRecord);
      
      // Insert into database
      await this.simulationCollections.userActions.insert({
        ...interactionRecord,
        mode: session.mode
      });
      
      // Process interaction based on type
      switch (interaction.type) {
        case 'SELECT_VEHICLE':
          // Process vehicle selection
          break;
          
        case 'SELECT_HAZARD':
          // Process hazard selection
          break;
          
        case 'PLACE_WAYPOINT':
          // Process waypoint placement
          await this._processWaypointPlacement(session.simulationId, interaction);
          break;
          
        case 'MODIFY_TRAJECTORY':
          // Process trajectory modification
          await this._processTrajectoryModification(session.simulationId, interaction);
          break;
          
        case 'TRIGGER_MITIGATION':
          // Process mitigation trigger
          await this._processMitigationTrigger(session.simulationId, interaction);
          break;
      }
      
      return {
        success: true,
        interactionId: interactionRecord.interactionId
      };
    } catch (error) {
      console.error('Error recording immersive interaction:', error);
      return {
        success: false,
        error: error.message
      };
    }
  }

  /**
   * Load scenario library from database
   * @private
   * @returns {Promise<void>}
   */
  async _loadScenarioLibrary() {
    try {
      // In a real implementation, this would load from a database
      // For this example, we'll create some predefined scenarios
      
      const scenariosCollection = new Mongo.Collection('iasmsTrainingScenarios');
      
      // Check if we already have scenarios
      const existingCount = await scenariosCollection.find().count();
      
      if (existingCount === 0) {
        // Create default scenarios
        const defaultScenarios = this._getDefaultScenarios();
        
        for (const scenario of defaultScenarios) {
          await scenariosCollection.insert(scenario);
        }
        
        console.log(`Created ${defaultScenarios.length} default training scenarios`);
      }
      
      // Load scenarios
      const scenarios = await scenariosCollection.find().fetch();
      
      // Add to scenario library
      for (const scenario of scenarios) {
        this.scenarioLibrary.set(scenario.scenarioId, scenario);
      }
      
      console.log(`Loaded ${this.scenarioLibrary.size} training scenarios`);
    } catch (error) {
      console.error('Error loading scenario library:', error);
      throw error;
    }
  }

  /**
   * Get default training scenarios
   * @private
   * @returns {Array} Default scenarios
   */
  _getDefaultScenarios() {
    return [
      {
        scenarioId: 'basic-operations',
        name: 'Basic Operations Training',
        description: 'Introduction to IASMS basic operations and monitoring',
        difficulty: 'BEGINNER',
        duration: 1800, // 30 minutes
        categories: ['TRAINING', 'BASICS'],
        objectives: [
          'Understand the IASMS interface',
          'Monitor vehicle states',
          'Observe risk assessment process',
          'View mitigation strategies'
        ],
        initialState: {
          vehicles: [
            {
              vehicleId: 'UAV-TRAINING-001',
              position: { type: 'Point', coordinates: [-74.012, 40.7128] }, // NYC
              altitude: 120,
              heading: 45,
              speed: 10
            },
            {
              vehicleId: 'UAV-TRAINING-002',
              position: { type: 'Point', coordinates: [-74.010, 40.720] },
              altitude: 100,
              heading: 180,
              speed: 8
            }
          ],
          hazards: [
            {
              hazardType: 'TRAINING_RESTRICTED_AREA',
              location: { type: 'Point', coordinates: [-74.015, 40.718] },
              radius: 500,
              severity: 0.7
            }
          ],
          weather: {
            conditions: {
              wind: { speed: 5, direction: 270 },
              visibility: 10000,
              precipitation: 0
            }
          }
        },
        events: [
          {
            time: 300, // 5 minutes in
            type: 'ADD_VEHICLE',
            data: {
              vehicleId: 'UAV-TRAINING-003',
              position: { type: 'Point', coordinates: [-74.005, 40.715] },
              altitude: 150,
              heading: 90,
              speed: 12
            }
          },
          {
            time: 600, // 10 minutes in
            type: 'ADD_HAZARD',
            data: {
              hazardType: 'WEATHER_THUNDERSTORM',
              location: { type: 'Point', coordinates: [-74.020, 40.725] },
              radius: 2000,
              severity: 0.8
            }
          }
        ]
      },
      {
        scenarioId: 'emergency-response',
        name: 'Emergency Response Training',
        description: 'Training for emergency situations and crisis management',
        difficulty: 'INTERMEDIATE',
        duration: 2700, // 45 minutes
        categories: ['TRAINING', 'EMERGENCY'],
        objectives: [
          'Recognize emergency situations',
          'Implement appropriate mitigation strategies',
          'Coordinate emergency response',
          'Manage multiple simultaneous incidents'
        ],
        initialState: {
          vehicles: [
            {
              vehicleId: 'UAV-EMERG-001',
              position: { type: 'Point', coordinates: [-118.243, 34.052] }, // LA
              altitude: 100,
              heading: 0,
              speed: 12
            },
            {
              vehicleId: 'UAV-EMERG-002',
              position: { type: 'Point', coordinates: [-118.250, 34.060] },
              altitude: 120,
              heading: 270,
              speed: 10
            },
            {
              vehicleId: 'UAV-EMERG-003',
              position: { type: 'Point', coordinates: [-118.260, 34.055] },
              altitude: 90,
              heading: 180,
              speed: 8
            }
          ],
          hazards: [
            {
              hazardType: 'RESTRICTED_AIRSPACE',
              location: { type: 'Point', coordinates: [-118.245, 34.058] },
              radius: 800,
              severity: 0.8
            }
          ],
          weather: {
            conditions: {
              wind: { speed: 10, direction: 315 },
              visibility: 8000,
              precipitation: 0
            }
          }
        },
        events: [
          {
            time: 300, // 5 minutes in
            type: 'TRIGGER_COMMUNICATION_LOSS',
            data: {
              vehicleId: 'UAV-EMERG-002'
            }
          },
          {
            time: 600, // 10 minutes in
            type: 'ADD_HAZARD',
            data: {
              hazardType: 'WEATHER_HIGH_WINDS',
              location: { type: 'Point', coordinates: [-118.240, 34.050] },
              radius: 3000,
              severity: 0.7
            }
          },
          {
            time: 900, // 15 minutes in
            type: 'TRIGGER_EMERGENCY',
            data: {
              vehicleId: 'UAV-EMERG-001',
              emergencyType: 'BATTERY_CRITICAL'
            }
          }
        ]
      },
      {
        scenarioId: 'high-density-operations',
        name: 'High Density Operations',
        description: 'Managing high density urban air mobility operations',
        difficulty: 'ADVANCED',
        duration: 3600, // 60 minutes
        categories: ['TRAINING', 'ADVANCED', 'URBAN'],
        objectives: [
          'Manage high-density urban airspace',
          'Balance operational efficiency and safety',
          'Resolve trajectory conflicts',
          'Implement strategic deconfliction'
        ],
        initialState: {
          vehicles: [
            // Generate 10 vehicles in San Francisco area
            ...[...Array(10)].map((_, i) => ({
              vehicleId: `UAV-SF-${String(i+1).padStart(3, '0')}`,
              position: { 
                type: 'Point', 
                coordinates: [
                  -122.419 + (Math.random() * 0.05 - 0.025), // SF longitude with offset
                  37.774 + (Math.random() * 0.05 - 0.025)    // SF latitude with offset
                ] 
              },
              altitude: 80 + Math.floor(Math.random() * 100), // 80-180m
              heading: Math.floor(Math.random() * 360),
              speed: 5 + Math.floor(Math.random() * 10) // 5-15 m/s
            }))
          ],
          hazards: [
            {
              hazardType: 'RESTRICTED_AIRSPACE',
              location: { type: 'Point', coordinates: [-122.405, 37.785] },
              radius: 1000,
              severity: 0.8
            },
            {
              hazardType: 'TEMPORARY_FLIGHT_RESTRICTION',
              location: { type: 'Point', coordinates: [-122.425, 37.765] },
              radius: 1500,
              severity: 0.7
            }
          ],
          weather: {
            conditions: {
              wind: { speed: 8, direction: 250 },
              visibility: 9000,
              precipitation: 0,
              fog: true
            }
          }
        },
        events: [
          {
            time: 300, // 5 minutes in
            type: 'ADD_VEHICLE',
            data: {
              vehicleId: 'UAV-SF-EMERGENCY',
              position: { type: 'Point', coordinates: [-122.415, 37.780] },
              altitude: 120,
              heading: 0,
              speed: 15
            }
          },
          {
            time: 600, // 10 minutes in
            type: 'MODIFY_WEATHER',
            data: {
              conditions: {
                wind: { speed: 15, direction: 260 },
                visibility: 5000,
                precipitation: 0.5,
                fog: true
              }
            }
          },
          // Add more events throughout the scenario
          ...[...Array(5)].map((_, i) => ({
            time: 900 + (i * 300), // 15, 20, 25, 30, 35 minutes in
            type: 'ADD_VEHICLE',
            data: {
              vehicleId: `UAV-SF-NEW-${String(i+1).padStart(3, '0')}`,
              position: { 
                type: 'Point', 
                coordinates: [
                  -122.419 + (Math.random() * 0.05 - 0.025),
                  37.774 + (Math.random() * 0.05 - 0.025)
                ] 
              },
              altitude: 80 + Math.floor(Math.random() * 100),
              heading: Math.floor(Math.random() * 360),
              speed: 5 + Math.floor(Math.random() * 10)
            }
          }))
        ]
      },
      {
        scenarioId: 'weather-diversion',
        name: 'Weather Diversion Scenario',
        description: 'Managing operations during rapidly changing weather conditions',
        difficulty: 'INTERMEDIATE',
        duration: 2700, // 45 minutes
        categories: ['TRAINING', 'WEATHER', 'DIVERSION'],
        objectives: [
          'Monitor changing weather conditions',
          'Identify weather-related risks',
          'Implement weather avoidance strategies',
          'Manage diversions due to weather'
        ],
        initialState: {
          vehicles: [
            {
              vehicleId: 'UAV-WX-001',
              position: { type: 'Point', coordinates: [-87.632, 41.878] }, // Chicago
              altitude: 150,
              heading: 90,
              speed: 12
            },
            {
              vehicleId: 'UAV-WX-002',
              position: { type: 'Point', coordinates: [-87.640, 41.885] },
              altitude: 130,
              heading: 180,
              speed: 10
            },
            {
              vehicleId: 'UAV-WX-003',
              position: { type: 'Point', coordinates: [-87.625, 41.870] },
              altitude: 140,
              heading: 270,
              speed: 11
            }
          ],
          hazards: [],
          weather: {
            conditions: {
              wind: { speed: 8, direction: 290 },
              visibility: 10000,
              precipitation: 0
            }
          }
        },
        events: [
          {
            time: 300, // 5 minutes in
            type: 'MODIFY_WEATHER',
            data: {
              conditions: {
                wind: { speed: 12, direction: 300 },
                visibility: 8000,
                precipitation: 0.2
              }
            }
          },
          {
            time: 600, // 10 minutes in
            type: 'ADD_HAZARD',
            data: {
              hazardType: 'WEATHER_THUNDERSTORM',
              location: { type: 'Point', coordinates: [-87.620, 41.880] },
              radius: 3000,
              severity: 0.8
            }
          },
          {
            time: 900, // 15 minutes in
            type: 'MODIFY_WEATHER',
            data: {
              conditions: {
                wind: { speed: 20, direction: 310 },
                visibility: 3000,
                precipitation: 0.8
              }
            }
          },
          {
            time: 1200, // 20 minutes in
            type: 'ADD_HAZARD',
            data: {
              hazardType: 'WEATHER_HIGH_WINDS',
              location: { type: 'Point', coordinates: [-87.635, 41.875] },
              radius: 5000,
              severity: 0.7
            }
          }
        ]
      },
      {
        scenarioId: 'vertiport-emergency',
        name: 'Vertiport Emergency Response',
        description: 'Managing operations during a vertiport emergency',
        difficulty: 'ADVANCED',
        duration: 3600, // 60 minutes
        categories: ['TRAINING', 'EMERGENCY', 'VERTIPORT'],
        objectives: [
          'Manage vertiport emergency procedures',
          'Coordinate emergency landings',
          'Implement traffic flow management during emergency',
          'Manage diversions to alternate vertiports'
        ],
        initialState: {
          vehicles: [
            {
              vehicleId: 'UAV-VP-001',
              position: { type: 'Point', coordinates: [-80.191, 25.761] }, // Miami
              altitude: 120,
              heading: 45,
              speed: 10
            },
            {
              vehicleId: 'UAV-VP-002',
              position: { type: 'Point', coordinates: [-80.195, 25.765] },
              altitude: 100,
              heading: 90,
              speed: 12
            },
            {
              vehicleId: 'UAV-VP-003',
              position: { type: 'Point', coordinates: [-80.185, 25.755] },
              altitude: 140,
              heading: 0,
              speed: 8
            },
            {
              vehicleId: 'UAV-VP-004',
              position: { type: 'Point', coordinates: [-80.180, 25.760] },
              altitude: 110,
              heading: 270,
              speed: 9
            },
            {
              vehicleId: 'UAV-VP-005',
              position: { type: 'Point', coordinates: [-80.190, 25.770] },
              altitude: 130,
              heading: 180,
              speed: 11
            }
          ],
          hazards: [],
          vertiports: [
            {
              vertiportId: 'VRTPT-MIA-001',
              name: 'Downtown Miami Vertiport',
              location: { type: 'Point', coordinates: [-80.191, 25.761] },
              status: 'OPERATIONAL',
              landingZones: 4
            },
            {
              vertiportId: 'VRTPT-MIA-002',
              name: 'Miami Beach Vertiport',
              location: { type: 'Point', coordinates: [-80.130, 25.790] },
              status: 'OPERATIONAL',
              landingZones: 2
            }
          ],
          weather: {
            conditions: {
              wind: { speed: 6, direction: 90 },
              visibility: 10000,
              precipitation: 0
            }
          }
        },
        events: [
          {
            time: 900, // 15 minutes in
            type: 'VERTIPORT_EMERGENCY',
            data: {
              vertiportId: 'VRTPT-MIA-001',
              emergencyType: 'FIRE',
              severity: 'HIGH'
            }
          },
          {
            time: 1200, // 20 minutes in
            type: 'ADD_VEHICLE',
            data: {
              vehicleId: 'UAV-VP-EMER-001',
              position: { type: 'Point', coordinates: [-80.150, 25.770] },
              altitude: 150,
              heading: 270,
              speed: 15,
              destination: 'VRTPT-MIA-001' // Headed to emergency vertiport
            }
          },
          {
            time: 1500, // 25 minutes in
            type: 'MODIFY_WEATHER',
            data: {
              conditions: {
                wind: { speed: 12, direction: 110 },
                visibility: 8000,
                precipitation: 0.3
              }
            }
          }
        ]
      }
    ];
  }

  /**
   * Register default simulation data providers
   * @private
   */
  _registerDefaultSimulationProviders() {
    // Vehicle state provider
    this.registerSimulationDataProvider('vehicleState', {
      generateData: (simulationId, step, time) => {
        const vehicles = this.simulatedVehicles.get(simulationId) || [];
        const vehicleStates = [];
        
        for (const vehicle of vehicles) {
          // Update vehicle state based on trajectory
          const updatedState = this._updateVehicleState(vehicle, step);
          
          if (updatedState) {
            vehicleStates.push(updatedState);
          }
        }
        
        return {
          vehicleStates
        };
      }
    });
    
    // Hazard provider
    this.registerSimulationDataProvider('hazard', {
      generateData: (simulationId, step, time) => {
        const hazards = this.simulatedHazards.get(simulationId) || [];
        const activeHazards = [];
        
        for (const hazard of hazards) {
          // Check if hazard is still active
          if (hazard.expiryTime > new Date()) {
            activeHazards.push(hazard);
          }
        }
        
        return {
          hazards: activeHazards
        };
      }
    });
    
    // Weather provider
    this.registerSimulationDataProvider('weather', {
      generateData: (simulationId, step, time) => {
        // Get simulation
        const simulation = this.activeSimulations.get(simulationId);
        if (!simulation) return { weatherData: [] };
        
        // Get scenario
        const scenario = this.scenarioLibrary.get(simulation.scenarioId);
        if (!scenario) return { weatherData: [] };
        
        // Get current weather conditions
        const weatherData = [];
        
        // Add basic weather data based on scenario
        if (scenario.initialState.weather) {
          weatherData.push({
            areaId: 'MAIN',
            location: {
              type: 'Point',
              coordinates: scenario.initialState.vehicles[0]?.position.coordinates || [-100, 40]
            },
            radius: 50000, // 50km radius
            altitude: 5000,
            conditions: {
              ...scenario.initialState.weather.conditions,
              // Add random variations
              wind: {
                speed: scenario.initialState.weather.conditions.wind.speed + (Math.random() * 2 - 1),
                direction: scenario.initialState.weather.conditions.wind.direction
              }
            },
            timestamp: new Date(),
            source: 'SIMULATION'
          });
        }
        
        return {
          weatherData
        };
      }
    });
    
    // Risk assessment provider
    this.registerSimulationDataProvider('risk', {
      generateData: (simulationId, step, time) => {
        // This would normally be computed by the Assess module
        // Here we'll simulate some basic risk assessments
        const vehicles = this.simulatedVehicles.get(simulationId) || [];
        const hazards = this.simulatedHazards.get(simulationId) || [];
        const risks = [];
        
        // For each vehicle, check proximity to hazards
        for (const vehicle of vehicles) {
          for (const hazard of hazards) {
            // Calculate distance
            const vehiclePoint = turf.point(vehicle.position.coordinates);
            const hazardPoint = turf.point(hazard.location.coordinates);
            const distance = turf.distance(vehiclePoint, hazardPoint, { units: 'kilometers' }) * 1000; // Convert to meters
            
            // If vehicle is close to hazard, create risk assessment
            if (distance <= hazard.radius * 2) {
              // Calculate risk level based on distance
              const riskLevel = distance <= hazard.radius ? 
                hazard.severity : 
                hazard.severity * (1 - ((distance - hazard.radius) / hazard.radius));
              
              risks.push({
                vehicleId: vehicle.vehicleId,
                hazardId: hazard._id,
                timestamp: new Date(),
                riskLevel: Math.max(0, Math.min(1, riskLevel)), // Ensure between 0 and 1
                riskCategory: riskLevel >= 0.7 ? 'HIGH' : riskLevel >= 0.4 ? 'MEDIUM' : 'LOW',
                riskFactors: {
                  proximity: riskLevel
                },
                metadata: {
                  distance,
                  hazardType: hazard.hazardType
                }
              });
            }
          }
        }
        
        return {
          risks
        };
      }
    });
  }

  /**
   * Register a simulation data provider
   * @param {string} providerId - Provider identifier
   * @param {Object} provider - Provider object with a generateData method
   */
  registerSimulationDataProvider(providerId, provider) {
    if (!provider || typeof provider.generateData !== 'function') {
      throw new Error('Simulation data provider must have a generateData method');
    }
    
    this.simulationDataSources.set(providerId, provider);
    console.log(`Registered simulation data provider: ${providerId}`);
  }

  /**
   * Set up simulation collections
   * @param {string} simulationId - Simulation ID
   * @private
   * @returns {Promise<void>}
   */
  async _setupSimulationCollections(simulationId) {
    try {
      // Create indexes on simulation collections
      await this.simulationCollections.vehicleStates.createIndex({ simulationId: 1, vehicleId: 1 });
      await this.simulationCollections.hazards.createIndex({ simulationId: 1, _id: 1 });
      await this.simulationCollections.risks.createIndex({ simulationId: 1, vehicleId: 1, hazardId: 1 });
      await this.simulationCollections.mitigations.createIndex({ simulationId: 1, vehicleId: 1 });
      await this.simulationCollections.trajectories.createIndex({ simulationId: 1, vehicleId: 1 });
      await this.simulationCollections.weatherData.createIndex({ simulationId: 1, areaId: 1 });
      await this.simulationCollections.metrics.createIndex({ simulationId: 1 });
      await this.simulationCollections.events.createIndex({ simulationId: 1, timestamp: 1 });
      await this.simulationCollections.userActions.createIndex({ simulationId: 1, sessionId: 1 });
    } catch (error) {
      console.error('Error setting up simulation collections:', error);
      throw error;
    }
  }

  /**
   * Initialize simulation data sources
   * @param {string} simulationId - Simulation ID
   * @param {Object} scenario - Scenario object
   * @private
   * @returns {Promise<void>}
   */
  async _initializeSimulationDataSources(simulationId, scenario) {
    try {
      // Create maps for simulated entities
      this.simulatedVehicles.set(simulationId, []);
      this.simulatedHazards.set(simulationId, []);
    } catch (error) {
      console.error('Error initializing simulation data sources:', error);
      throw error;
    }
  }

  /**
   * Load scenario initial state
   * @param {string} simulationId - Simulation ID
   * @param {Object} scenario - Scenario object
   * @private
   * @returns {Promise<void>}
   */
  async _loadScenarioInitialState(simulationId, scenario) {
    try {
      // Load initial vehicles
      if (scenario.initialState.vehicles) {
        for (const vehicleData of scenario.initialState.vehicles) {
          // Create vehicle state
          const vehicleState = {
            simulationId,
            vehicleId: vehicleData.vehicleId,
            position: vehicleData.position,
            altitude: vehicleData.altitude,
            heading: vehicleData.heading,
            speed: vehicleData.speed,
            status: 'ACTIVE',
            timestamp: new Date(),
            metadata: vehicleData.metadata || {}
          };
          
          // Add to simulated vehicles
          const vehicles = this.simulatedVehicles.get(simulationId) || [];
          vehicles.push(vehicleState);
          this.simulatedVehicles.set(simulationId, vehicles);
          
          // Insert into collection
          await this.simulationCollections.vehicleStates.insert(vehicleState);
        }
      }
      
      // Load initial hazards
      if (scenario.initialState.hazards) {
        for (const hazardData of scenario.initialState.hazards) {
          // Create hazard
          const hazard = {
            _id: `hazard-${Random.id()}`,
            simulationId,
            hazardType: hazardData.hazardType,
            location: hazardData.location,
            radius: hazardData.radius,
            severity: hazardData.severity,
            source: 'SCENARIO',
            timestamp: new Date(),
            expiryTime: new Date(Date.now() + 3600000), // 1 hour default
            metadata: hazardData.metadata || {}
          };
          
          // Add to simulated hazards
          const hazards = this.simulatedHazards.get(simulationId) || [];
          hazards.push(hazard);
          this.simulatedHazards.set(simulationId, hazards);
          
          // Insert into collection
          await this.simulationCollections.hazards.insert(hazard);
        }
      }
      
      // Load initial weather
      if (scenario.initialState.weather) {
        const weatherData = {
          simulationId,
          areaId: 'MAIN',
          location: {
            type: 'Point',
            coordinates: scenario.initialState.vehicles[0]?.position.coordinates || [-100, 40]
          },
          radius: 50000, // 50km radius
          altitude: 5000,
          conditions: scenario.initialState.weather.conditions,
          timestamp: new Date(),
          source: 'SCENARIO'
        };
        
        // Insert into collection
        await this.simulationCollections.weatherData.insert(weatherData);
      }
      
      // Log initial state loaded
      this._logSimulationEvent(simulationId, 'INITIAL_STATE_LOADED', {
        vehicleCount: scenario.initialState.vehicles?.length || 0,
        hazardCount: scenario.initialState.hazards?.length || 0
      });
      
      console.log(`Loaded initial state for simulation ${simulationId}`);
    } catch (error) {
      console.error('Error loading scenario initial state:', error);
      throw error;
    }
  }

  /**
   * Run a simulation step
   * @param {string} simulationId - Simulation ID
   * @private
   */
  _runSimulationStep(simulationId) {
    try {
      // Check if simulation exists
      if (!this.activeSimulations.has(simulationId)) {
        return;
      }
      
      // Get simulation
      const simulation = this.activeSimulations.get(simulationId);
      
      // Check if simulation is running
      if (simulation.status !== 'RUNNING') {
        return;
      }
      
      // Get simulation counter
      const counter = this.simulationCounters.get(simulationId);
      
      // Increment step and time
      counter.step++;
      counter.time += simulation.speedFactor;
      
      // Update current time
      simulation.currentTime = new Date();
      
      // Check for scenario events to trigger
      this._checkScenarioEvents(simulationId, counter.time);
      
      // Process data from providers
      for (const [providerId, provider] of this.simulationDataSources.entries()) {
        try {
          const data = provider.generateData(simulationId, counter.step, counter.time);
          
          if (!data) continue;
          
          // Process based on data type
          if (data.vehicleStates) {
            this._processSimulatedVehicleStates(simulationId, data.vehicleStates);
          }
          
          if (data.hazards) {
            this._processSimulatedHazards(simulationId, data.hazards);
          }
          
          if (data.weatherData) {
            this._processSimulatedWeatherData(simulationId, data.weatherData);
          }
          
          if (data.risks) {
            this._processSimulatedRisks(simulationId, data.risks);
          }
        } catch (error) {
          console.error(`Error processing data from provider ${providerId}:`, error);
        }
      }
      
      // Check if simulation should end
      if (counter.time >= this.options.maxSimulationDuration) {
        this._completeSimulation(simulationId);
      }
    } catch (error) {
      console.error(`Error running simulation step for ${simulationId}:`, error);
      
      // Log error event
      this._logSimulationEvent(simulationId, 'SIMULATION_ERROR', {
        error: error.message,
        stack: error.stack
      });
    }
  }

  /**
   * Check for scenario events to trigger
   * @param {string} simulationId - Simulation ID
   * @param {number} currentTime - Current simulation time in seconds
   * @private
   */
  async _checkScenarioEvents(simulationId, currentTime) {
    try {
      // Get simulation
      const simulation = this.activeSimulations.get(simulationId);
      if (!simulation) return;
      
      // Get scenario
      const scenario = this.scenarioLibrary.get(simulation.scenarioId);
      if (!scenario || !scenario.events) return;
      
      // Check for events to trigger
      for (const event of scenario.events) {
        // Skip if event time doesn't match current time
        // We check within a small window to avoid missing events due to timing precision
        if (currentTime < event.time || currentTime > event.time + simulation.speedFactor) {
          continue;
        }
        
        // Process event based on type
        switch (event.type) {
          case 'ADD_VEHICLE':
            await this._injectVehicle(simulationId, {
              type: 'ADD_VEHICLE',
              data: event.data
            });
            break;
            
          case 'ADD_HAZARD':
            await this._injectHazard(simulationId, {
              type: 'ADD_HAZARD',
              data: event.data
            });
            break;
            
          case 'MODIFY_WEATHER':
            await this._injectWeather(simulationId, {
              type: 'MODIFY_WEATHER',
              data: event.data
            });
            break;
            
          case 'TRIGGER_COMMUNICATION_LOSS':
            await this._triggerCommunicationLoss(simulationId, {
              type: 'TRIGGER_COMMUNICATION_LOSS',
              data: event.data
            });
            break;
            
          case 'TRIGGER_EMERGENCY':
            await this._triggerEmergency(simulationId, {
              type: 'TRIGGER_EMERGENCY',
              data: event.data
            });
            break;
            
          case 'VERTIPORT_EMERGENCY':
            await this._triggerVertiportEmergency(simulationId, {
              type: 'VERTIPORT_EMERGENCY',
              data: event.data
            });
            break;
        }
        
        // Log event
        this._logSimulationEvent(simulationId, 'SCENARIO_EVENT_TRIGGERED', {
          eventType: event.type,
          eventTime: event.time,
          data: event.data
        });
      }
    } catch (error) {
      console.error(`Error checking scenario events for ${simulationId}:`, error);
    }
  }

  /**
   * Process simulated vehicle states
   * @param {string} simulationId - Simulation ID
   * @param {Array} vehicleStates - Vehicle states
   * @private
   */
  async _processSimulatedVehicleStates(simulationId, vehicleStates) {
    try {
      for (const state of vehicleStates) {
        // Add simulation ID
        state.simulationId = simulationId;
        
        // Update timestamp
        state.timestamp = new Date();
        
        // Insert into collection
        await this.simulationCollections.vehicleStates.insert(state);
        
        // Update simulated vehicles
        const vehicles = this.simulatedVehicles.get(simulationId) || [];
        const index = vehicles.findIndex(v => v.vehicleId === state.vehicleId);
        
        if (index >= 0) {
          vehicles[index] = state;
        } else {
          vehicles.push(state);
        }
        
        this.simulatedVehicles.set(simulationId, vehicles);
      }
    } catch (error) {
      console.error(`Error processing simulated vehicle states for ${simulationId}:`, error);
    }
  }

  /**
   * Process simulated hazards
   * @param {string} simulationId - Simulation ID
   * @param {Array} hazards - Hazards
   * @private
   */
  async _processSimulatedHazards(simulationId, hazards) {
    try {
      for (const hazard of hazards) {
        // Add simulation ID
        hazard.simulationId = simulationId;
        
        // Update timestamp
        hazard.timestamp = hazard.timestamp || new Date();
        
        // Insert into collection
        await this.simulationCollections.hazards.insert(hazard);
        
        // Update simulated hazards
        const simulatedHazards = this.simulatedHazards.get(simulationId) || [];
        simulatedHazards.push(hazard);
        this.simulatedHazards.set(simulationId, simulatedHazards);
      }
    } catch (error) {
      console.error(`Error processing simulated hazards for ${simulationId}:`, error);
    }
  }

  /**
   * Process simulated weather data
   * @param {string} simulationId - Simulation ID
   * @param {Array} weatherData - Weather data
   * @private
   */
  async _processSimulatedWeatherData(simulationId, weatherData) {
    try {
      for (const weather of weatherData) {
        // Add simulation ID
        weather.simulationId = simulationId;
        
        // Update timestamp
        weather.timestamp = weather.timestamp || new Date();
        
        // Insert into collection
        await this.simulationCollections.weatherData.insert(weather);
      }
    } catch (error) {
      console.error(`Error processing simulated weather data for ${simulationId}:`, error);
    }
  }

  /**
   * Process simulated risks
   * @param {string} simulationId - Simulation ID
   * @param {Array} risks - Risks
   * @private
   */
  async _processSimulatedRisks(simulationId, risks) {
    try {
      for (const risk of risks) {
        // Add simulation ID
        risk.simulationId = simulationId;
        
        // Generate ID if not provided
        risk._id = risk._id || `risk-${Random.id()}`;
        
        // Update timestamp
        risk.timestamp = risk.timestamp || new Date();
        
        // Insert into collection
        await this.simulationCollections.risks.insert(risk);
        
        // If high risk, generate mitigation
        if (risk.riskCategory === 'HIGH') {
          await this._generateSimulatedMitigation(simulationId, risk);
        }
      }
    } catch (error) {
      console.error(`Error processing simulated risks for ${simulationId}:`, error);
    }
  }

  /**
   * Generate simulated mitigation
   * @param {string} simulationId - Simulation ID
   * @param {Object} risk - Risk assessment
   * @private
   */
  async _generateSimulatedMitigation(simulationId, risk) {
    try {
      // Get vehicle
      const vehicles = this.simulatedVehicles.get(simulationId) || [];
      const vehicle = vehicles.find(v => v.vehicleId === risk.vehicleId);
      
      if (!vehicle) return;
      
      // Get hazard
      const hazards = this.simulatedHazards.get(simulationId) || [];
      const hazard = hazards.find(h => h._id === risk.hazardId);
      
      if (!hazard) return;
      
      // Create mitigation
      const mitigation = {
        _id: `mitigation-${Random.id()}`,
        simulationId,
        riskId: risk._id,
        vehicleId: risk.vehicleId,
        mitigationType: this._selectMitigationType(risk, hazard),
        mitigationAction: this._selectMitigationAction(risk, hazard),
        parameters: {
          hazardId: hazard._id,
          hazardType: hazard.hazardType,
          hazardLocation: hazard.location,
          hazardRadius: hazard.radius,
          currentPosition: vehicle.position,
          currentAltitude: vehicle.altitude,
          currentHeading: vehicle.heading,
          currentSpeed: vehicle.speed
        },
        status: 'PENDING',
        timestamp: new Date(),
        expiryTime: new Date(Date.now() + 600000), // 10 minutes
        metadata: {
          riskLevel: risk.riskLevel,
          riskCategory: risk.riskCategory
        }
      };
      
      // Insert into collection
      await this.simulationCollections.mitigations.insert(mitigation);
      
      // Log mitigation
      this._logSimulationEvent(simulationId, 'MITIGATION_GENERATED', {
        mitigationId: mitigation._id,
        mitigationType: mitigation.mitigationType,
        vehicleId: mitigation.vehicleId,
        riskLevel: risk.riskLevel
      });
      
      // Update vehicle with mitigation
      await this._applyMitigationToVehicle(simulationId, mitigation);
    } catch (error) {
      console.error(`Error generating simulated mitigation for ${simulationId}:`, error);
    }
  }

  /**
   * Select mitigation type based on risk and hazard
   * @param {Object} risk - Risk assessment
   * @param {Object} hazard - Hazard
   * @returns {string} Mitigation type
   * @private
   */
  _selectMitigationType(risk, hazard) {
    // Select mitigation type based on hazard type and risk level
    if (hazard.hazardType.includes('WEATHER')) {
      return 'REROUTE';
    } else if (hazard.hazardType === 'COMMUNICATION_LOSS') {
      return 'RETURN_TO_BASE';
    } else if (hazard.hazardType === 'RESTRICTED_AIRSPACE') {
      return 'REROUTE';
    } else if (risk.riskLevel > 0.9) {
      return 'LAND';
    } else if (risk.riskLevel > 0.8) {
      return 'ALTITUDE_CHANGE';
    } else {
      return 'SPEED_CHANGE';
    }
  }

  /**
   * Select mitigation action based on risk and hazard
   * @param {Object} risk - Risk assessment
   * @param {Object} hazard - Hazard
   * @returns {string} Mitigation action
   * @private
   */
  _selectMitigationAction(risk, hazard) {
    switch (this._selectMitigationType(risk, hazard)) {
      case 'REROUTE':
        return 'GENERATE_ALTERNATE_ROUTE';
      case 'ALTITUDE_CHANGE':
        return risk.metadata.altitude < hazard.altitude ? 'DESCEND' : 'CLIMB';
      case 'SPEED_CHANGE':
        return 'REDUCE_SPEED';
      case 'RETURN_TO_BASE':
        return 'RTB';
      case 'LAND':
        return 'LAND_IMMEDIATELY';
      case 'HOLD':
        return 'HOLD_POSITION';
      default:
        return 'REDUCE_SPEED';
    }
  }

  /**
   * Apply mitigation to vehicle
   * @param {string} simulationId - Simulation ID
   * @param {Object} mitigation - Mitigation
   * @private
   */
  async _applyMitigationToVehicle(simulationId, mitigation) {
    try {
      // Get vehicle
      const vehicles = this.simulatedVehicles.get(simulationId) || [];
      const vehicleIndex = vehicles.findIndex(v => v.vehicleId === mitigation.vehicleId);
      
      if (vehicleIndex < 0) return;
      
      const vehicle = vehicles[vehicleIndex];
      
      // Apply mitigation based on type
      switch (mitigation.mitigationType) {
        case 'SPEED_CHANGE':
          // Reduce speed
          vehicle.speed = Math.max(5, vehicle.speed * 0.7);
          break;
          
        case 'ALTITUDE_CHANGE':
          // Change altitude
          if (mitigation.mitigationAction === 'CLIMB') {
            vehicle.altitude += 50;
          } else {
            vehicle.altitude = Math.max(50, vehicle.altitude - 50);
          }
          break;
          
        case 'REROUTE':
          // Will be handled by trajectory update
          break;
          
        case 'HOLD':
          // Stop movement
          vehicle.speed = 0;
          break;
          
        case 'RETURN_TO_BASE':
          // Change heading to home direction (simplified)
          vehicle.heading = (vehicle.heading + 180) % 360;
          break;
          
        case 'LAND':
          // Start descending
          vehicle.speed = Math.max(2, vehicle.speed * 0.5);
          vehicle.altitude = Math.max(0, vehicle.altitude - 30);
          break;
      }
      
      // Update vehicle in collection
      vehicles[vehicleIndex] = vehicle;
      this.simulatedVehicles.set(simulationId, vehicles);
      
      // Update mitigation status
      await this.simulationCollections.mitigations.update(
        { _id: mitigation._id },
        { $set: { status: 'APPLIED', appliedAt: new Date() } }
      );
    } catch (error) {
      console.error(`Error applying mitigation to vehicle:`, error);
    }
  }

  /**
   * Update vehicle state based on trajectory
   * @param {Object} vehicle - Vehicle state
   * @param {number} step - Simulation step
   * @returns {Object} Updated vehicle state
   * @private
   */
  _updateVehicleState(vehicle, step) {
    try {
      // Skip if speed is 0
      if (vehicle.speed === 0) {
        return vehicle;
      }
      
      // Calculate new position based on heading and speed
      const distance = vehicle.speed * 0.1; // Distance in 100ms in meters
      const distanceKm = distance / 1000; // Convert to kilometers for turf
      
      const point = turf.point(vehicle.position.coordinates);
      const destination = turf.destination(point, distanceKm, vehicle.heading, { units: 'kilometers' });
      
      // Update position
      vehicle.position = {
        type: 'Point',
        coordinates: destination.geometry.coordinates
      };
      
      // Return updated vehicle
      return {
        ...vehicle,
        timestamp: new Date()
      };
    } catch (error) {
      console.error('Error updating vehicle state:', error);
      return vehicle;
    }
  }

  /**
   * Complete a simulation
   * @param {string} simulationId - Simulation ID
   * @private
   */
  async _completeSimulation(simulationId) {
    try {
      // Get simulation
      const simulation = this.activeSimulations.get(simulationId);
      
      if (!simulation) {
        return;
      }
      
      // Clear interval
      if (this.simulationIntervalIds.has(simulationId)) {
        Meteor.clearInterval(this.simulationIntervalIds.get(simulationId));
        this.simulationIntervalIds.delete(simulationId);
      }
      
      // Update simulation status
      simulation.status = 'COMPLETED';
      simulation.endTime = new Date();
      
      // Generate simulation summary
      const summary = await this._generateSimulationSummary(simulationId);
      
      // Emit event
      this.emit('simulation:completed', {
        simulationId,
        endTime: simulation.endTime,
        metrics: summary.metrics
      });
      
      // Log simulation completion
      this._logSimulationEvent(simulationId, 'SIMULATION_COMPLETED', {
        endTime: simulation.endTime,
        metrics: summary.metrics
      });
      
      // Clean up simulation resources (after a delay to allow clients to fetch final state)
      Meteor.setTimeout(() => {
        this._cleanupSimulation(simulationId);
      }, 300000); // 5 minute delay
    } catch (error) {
      console.error(`Error completing simulation ${simulationId}:`, error);
    }
  }

  /**
   * Generate simulation summary
   * @param {string} simulationId - Simulation ID
   * @returns {Promise<Object>} Simulation summary
   * @private
   */
  async _generateSimulationSummary(simulationId) {
    try {
      // Get simulation
      const simulation = this.activeSimulations.get(simulationId);
      
      if (!simulation) {
        throw new Error(`Simulation ${simulationId} not found`);
      }
      
      // Get scenario
      const scenario = this.scenarioLibrary.get(simulation.scenarioId);
      
      // Get counts
      const vehicleCount = await this.simulationCollections.vehicleStates.find({
        simulationId,
      }).count();
      
      const hazardCount = await this.simulationCollections.hazards.find({
        simulationId
      }).count();
      
      const riskCount = await this.simulationCollections.risks.find({
        simulationId
      }).count();
      
      const mitigationCount = await this.simulationCollections.mitigations.find({
        simulationId
      }).count();
      
      const eventCount = await this.simulationCollections.events.find({
        simulationId
      }).count();
      
      const highRiskCount = await this.simulationCollections.risks.find({
        simulationId,
        riskCategory: 'HIGH'
      }).count();
      
      const appliedMitigationCount = await this.simulationCollections.mitigations.find({
        simulationId,
        status: 'APPLIED'
      }).count();
      
      // Calculate duration
      const duration = simulation.endTime ? 
        (simulation.endTime - simulation.startTime) / 1000 : // in seconds
        (new Date() - simulation.startTime) / 1000;
      
      // Calculate risk mitigation ratio
      const riskMitigationRatio = riskCount > 0 ? 
        mitigationCount / riskCount : 0;
      
      // Calculate mitigation effectiveness
      const mitigationEffectiveness = mitigationCount > 0 ? 
        appliedMitigationCount / mitigationCount : 0;
      
      // Create metrics
      const metrics = {
        simulationId,
        scenarioId: simulation.scenarioId,
        scenarioName: scenario ? scenario.name : 'Unknown',
        duration,
        startTime: simulation.startTime,
        endTime: simulation.endTime || new Date(),
        status: simulation.status,
        counts: {
          vehicles: vehicleCount,
          hazards: hazardCount,
          risks: riskCount,
          mitigations: mitigationCount,
          events: eventCount,
          highRisks: highRiskCount,
          appliedMitigations: appliedMitigationCount
        },
        ratios: {
          riskMitigation: riskMitigationRatio,
          mitigationEffectiveness: mitigationEffectiveness
        },
        timestamp: new Date()
      };
      
      // Save metrics
      const existingMetrics = await this.simulationCollections.metrics.findOne({ simulationId });
      
      if (existingMetrics) {
        await this.simulationCollections.metrics.update(
          { simulationId },
          { $set: metrics }
        );
      } else {
        await this.simulationCollections.metrics.insert(metrics);
      }
      
      // Create summary
      const summary = {
        simulation: {
          id: simulationId,
          scenario: scenario ? {
            id: scenario.scenarioId,
            name: scenario.name,
            description: scenario.description
          } : null,
          duration: `${Math.floor(duration / 60)}m ${Math.floor(duration % 60)}s`,
          startTime: simulation.startTime,
          endTime: simulation.endTime || new Date(),
          status: simulation.status
        },
        metrics: {
          vehicles: vehicleCount,
          hazards: hazardCount,
          risks: riskCount,
          mitigations: mitigationCount,
          events: eventCount,
          highRisks: highRiskCount,
          appliedMitigations: appliedMitigationCount,
          riskMitigationRatio: Math.round(riskMitigationRatio * 100) / 100,
          mitigationEffectiveness: Math.round(mitigationEffectiveness * 100) / 100
        }
      };
      
      return summary;
    } catch (error) {
      console.error(`Error generating simulation summary for ${simulationId}:`, error);
      return {
        error: error.message
      };
    }
  }

  /**
   * Clean up simulation resources
   * @param {string} simulationId - Simulation ID
   * @private
   */
  _cleanupSimulation(simulationId) {
    try {
      // Remove from active simulations
      this.activeSimulations.delete(simulationId);
      
      // Remove counters
      this.simulationCounters.delete(simulationId);
      
      // Remove simulated entities
      this.simulatedVehicles.delete(simulationId);
      this.simulatedHazards.delete(simulationId);
      
      console.log(`Cleaned up resources for simulation ${simulationId}`);
    } catch (error) {
      console.error(`Error cleaning up simulation ${simulationId}:`, error);
    }
  }

  /**
   * Log a simulation event
   * @param {string} simulationId - Simulation ID
   * @param {string} eventType - Event type
   * @param {Object} data - Event data
   * @private
   */
  async _logSimulationEvent(simulationId, eventType, data) {
    try {
      // Create event object
      const event = {
        simulationId,
        eventType,
        timestamp: new Date(),
        data
      };
      
      // Insert into collection
      await this.simulationCollections.events.insert(event);
      
      // Increment event counter
      const counter = this.simulationCounters.get(simulationId);
      if (counter) {
        counter.entities.events++;
      }
    } catch (error) {
      console.error(`Error logging simulation event for ${simulationId}:`, error);
    }
  }

  /**
   * Inject a vehicle into a simulation
   * @param {string} simulationId - Simulation ID
   * @param {Object} eventData - Event data
   * @returns {Promise<Object>} Result
   * @private
   */
  async _injectVehicle(simulationId, eventData) {
    try {
      // Create vehicle ID if not provided
      const vehicleId = eventData.data.vehicleId || `UAV-SIM-${Random.id(6)}`;
      
      // Create vehicle state
      const vehicleState = {
        simulationId,
        vehicleId,
        position: eventData.data.position,
        altitude: eventData.data.altitude,
        heading: eventData.data.heading,
        speed: eventData.data.speed,
        status: 'ACTIVE',
        timestamp: new Date(),
        metadata: eventData.data.metadata || {}
      };
      
      // Add to simulated vehicles
      const vehicles = this.simulatedVehicles.get(simulationId) || [];
      vehicles.push(vehicleState);
      this.simulatedVehicles.set(simulationId, vehicles);
      
      // Insert into collection
      await this.simulationCollections.vehicleStates.insert(vehicleState);
      
      // Log event
      this._logSimulationEvent(simulationId, 'VEHICLE_ADDED', {
        vehicleId,
        position: eventData.data.position,
        altitude: eventData.data.altitude
      });
      
      // Increment vehicle counter
      const counter = this.simulationCounters.get(simulationId);
      if (counter) {
        counter.entities.vehicles++;
      }
      
      return {
        success: true,
        vehicleId,
        message: 'Vehicle added to simulation'
      };
    } catch (error) {
      console.error(`Error injecting vehicle into simulation ${simulationId}:`, error);
      return {
        success: false,
        error: error.message
      };
    }
  }

  /**
   * Inject a hazard into a simulation
   * @param {string} simulationId - Simulation ID
   * @param {Object} eventData - Event data
   * @returns {Promise<Object>} Result
   * @private
   */
  async _injectHazard(simulationId, eventData) {
    try {
      // Create hazard ID
      const hazardId = `hazard-${Random.id()}`;
      
      // Create hazard
      const hazard = {
        _id: hazardId,
        simulationId,
        hazardType: eventData.data.hazardType,
        location: eventData.data.location,
        radius: eventData.data.radius,
        severity: eventData.data.severity,
        source: 'SIMULATION_INJECT',
        timestamp: new Date(),
        expiryTime: eventData.data.expiryTime || new Date(Date.now() + 3600000), // 1 hour default
        metadata: eventData.data.metadata || {}
      };
      
      // Add to simulated hazards
      const hazards = this.simulatedHazards.get(simulationId) || [];
      hazards.push(hazard);
      this.simulatedHazards.set(simulationId, hazards);
      
      // Insert into collection
      await this.simulationCollections.hazards.insert(hazard);
      
      // Log event
      this._logSimulationEvent(simulationId, 'HAZARD_ADDED', {
        hazardId,
        hazardType: eventData.data.hazardType,
        location: eventData.data.location,
        severity: eventData.data.severity
      });
      
      // Increment hazard counter
      const counter = this.simulationCounters.get(simulationId);
      if (counter) {
        counter.entities.hazards++;
      }
      
      return {
        success: true,
        hazardId,
        message: 'Hazard added to simulation'
      };
    } catch (error) {
      console.error(`Error injecting hazard into simulation ${simulationId}:`, error);
      return {
        success: false,
        error: error.message
      };
    }
  }

  /**
   * Inject weather data into a simulation
   * @param {string} simulationId - Simulation ID
   * @param {Object} eventData - Event data
   * @returns {Promise<Object>} Result
   * @private
   */
  async _injectWeather(simulationId, eventData) {
    try {
      // Get simulation
      const simulation = this.activeSimulations.get(simulationId);
      if (!simulation) {
        throw new Error(`Simulation ${simulationId} not found`);
      }
      
      // Get scenario
      const scenario = this.scenarioLibrary.get(simulation.scenarioId);
      if (!scenario) {
        throw new Error(`Scenario for simulation ${simulationId} not found`);
      }
      
      // Create weather data
      const weatherData = {
        simulationId,
        areaId: eventData.data.areaId || 'MAIN',
        location: eventData.data.location || {
          type: 'Point',
          coordinates: scenario.initialState.vehicles[0]?.position.coordinates || [-100, 40]
        },
        radius: eventData.data.radius || 50000, // 50km radius
        altitude: eventData.data.altitude || 5000,
        conditions: eventData.data.conditions,
        timestamp: new Date(),
        source: 'SIMULATION_INJECT'
      };
      
      // Insert into collection
      await this.simulationCollections.weatherData.insert(weatherData);
      
      // Log event
      this._logSimulationEvent(simulationId, 'WEATHER_MODIFIED', {
        areaId: weatherData.areaId,
        conditions: weatherData.conditions
      });
      
      return {
        success: true,
        message: 'Weather data injected into simulation'
      };
    } catch (error) {
      console.error(`Error injecting weather into simulation ${simulationId}:`, error);
      return {
        success: false,
        error: error.message
      };
    }
  }

  /**
   * Trigger communication loss for a vehicle
   * @param {string} simulationId - Simulation ID
   * @param {Object} eventData - Event data
   * @returns {Promise<Object>} Result
   * @private
   */
  async _triggerCommunicationLoss(simulationId, eventData) {
    try {
      // Get vehicle
      const vehicles = this.simulatedVehicles.get(simulationId) || [];
      const vehicle = vehicles.find(v => v.vehicleId === eventData.data.vehicleId);
      
      if (!vehicle) {
        throw new Error(`Vehicle ${eventData.data.vehicleId} not found in simulation ${simulationId}`);
      }
      
      // Create hazard
      const hazardId = `hazard-commloss-${Random.id()}`;
      
      const hazard = {
        _id: hazardId,
        simulationId,
        hazardType: 'COMMUNICATION_LOSS',
        location: vehicle.position,
        radius: 100, // 100m default radius
        severity: 0.8,
        source: 'SIMULATION_INJECT',
        timestamp: new Date(),
        expiryTime: eventData.data.expiryTime || new Date(Date.now() + 900000), // 15 minutes default
        metadata: {
          vehicleId: vehicle.vehicleId,
          lastContactTime: new Date()
        }
      };
      
      // Add to simulated hazards
      const hazards = this.simulatedHazards.get(simulationId) || [];
      hazards.push(hazard);
      this.simulatedHazards.set(simulationId, hazards);
      
      // Insert into collection
      await this.simulationCollections.hazards.insert(hazard);
      
      // Update vehicle status
      vehicle.communicationStatus = 'LOST';
      vehicle.lastContactTime = new Date();
      
      // Log event
      this._logSimulationEvent(simulationId, 'COMMUNICATION_LOSS_TRIGGERED', {
        vehicleId: vehicle.vehicleId,
        hazardId,
        position: vehicle.position
      });
      
      // Increment hazard counter
      const counter = this.simulationCounters.get(simulationId);
      if (counter) {
        counter.entities.hazards++;
      }
      
      return {
        success: true,
        hazardId,
        message: 'Communication loss triggered for vehicle'
      };
    } catch (error) {
      console.error(`Error triggering communication loss in simulation ${simulationId}:`, error);
      return {
        success: false,
        error: error.message
      };
    }
  }

  /**
   * Trigger an emergency for a vehicle
   * @param {string} simulationId - Simulation ID
   * @param {Object} eventData - Event data
   * @returns {Promise<Object>} Result
   * @private
   */
  async _triggerEmergency(simulationId, eventData) {
    try {
      // Get vehicle
      const vehicles = this.simulatedVehicles.get(simulationId) || [];
      const vehicle = vehicles.find(v => v.vehicleId === eventData.data.vehicleId);
      
      if (!vehicle) {
        throw new Error(`Vehicle ${eventData.data.vehicleId} not found in simulation ${simulationId}`);
      }
      
      // Create emergency ID
      const emergencyId = `emg-${Random.id()}`;
      
      // Create emergency object
      const emergency = {
        _id: emergencyId,
        simulationId,
        vehicleId: vehicle.vehicleId,
        emergencyType: eventData.data.emergencyType,
        position: vehicle.position,
        altitude: vehicle.altitude,
        severity: eventData.data.severity || 'HIGH',
        status: 'ACTIVE',
        timestamp: new Date(),
        metadata: eventData.data.metadata || {}
      };
      
      // Insert into events collection
      await this.simulationCollections.events.insert({
        simulationId,
        eventType: 'EMERGENCY_DECLARED',
        timestamp: new Date(),
        data: emergency
      });
      
      // Create hazard based on emergency type
      const hazardId = `hazard-emergency-${Random.id()}`;
      
      const hazard = {
        _id: hazardId,
        simulationId,
        hazardType: this._mapEmergencyTypeToHazardType(eventData.data.emergencyType),
        location: vehicle.position,
        radius: 200, // 200m default radius
        severity: eventData.data.emergencyType === 'BATTERY_CRITICAL' ? 0.9 : 0.8,
        source: 'SIMULATION_EMERGENCY',
        timestamp: new Date(),
        expiryTime: new Date(Date.now() + 1800000), // 30 minutes default
        metadata: {
          vehicleId: vehicle.vehicleId,
          emergencyId,
          emergencyType: eventData.data.emergencyType
        }
      };
      
      // Add to simulated hazards
      const hazards = this.simulatedHazards.get(simulationId) || [];
      hazards.push(hazard);
      this.simulatedHazards.set(simulationId, hazards);
      
      // Insert into collection
      await this.simulationCollections.hazards.insert(hazard);
      
      // Update vehicle status
      vehicle.emergencyStatus = 'ACTIVE';
      vehicle.emergencyType = eventData.data.emergencyType;
      vehicle.emergencyId = emergencyId;
      
      // Log event
      this._logSimulationEvent(simulationId, 'EMERGENCY_TRIGGERED', {
        vehicleId: vehicle.vehicleId,
        emergencyId,
        emergencyType: eventData.data.emergencyType,
        hazardId
      });
      
      // Increment hazard counter
      const counter = this.simulationCounters.get(simulationId);
      if (counter) {
        counter.entities.hazards++;
      }
      
      return {
        success: true,
        emergencyId,
        hazardId,
        message: 'Emergency triggered for vehicle'
      };
    } catch (error) {
      console.error(`Error triggering emergency in simulation ${simulationId}:`, error);
      return {
        success: false,
        error: error.message
      };
    }
  }

  /**
   * Trigger a vertiport emergency
   * @param {string} simulationId - Simulation ID
   * @param {Object} eventData - Event data
   * @returns {Promise<Object>} Result
   * @private
   */
  async _triggerVertiportEmergency(simulationId, eventData) {
    try {
      // Get vertiport
      if (!eventData.data.vertiportId) {
        throw new Error('Vertiport ID is required');
      }
      
      // Create emergency ID
      const emergencyId = `vpemg-${Random.id()}`;
      
      // Get vertiport location
      let vertiportLocation;
      
      // In a real implementation, this would get the actual vertiport location
      // For this example, use a default location or try to find it in the scenario
      const simulation = this.activeSimulations.get(simulationId);
      const scenario = simulation ? this.scenarioLibrary.get(simulation.scenarioId) : null;
      
      if (scenario && scenario.initialState.vertiports) {
        const vertiport = scenario.initialState.vertiports.find(
          v => v.vertiportId === eventData.data.vertiportId
        );
        
        if (vertiport) {
          vertiportLocation = vertiport.location;
        }
      }
      
      // If not found, use a default or first vehicle position
      if (!vertiportLocation) {
        const vehicles = this.simulatedVehicles.get(simulationId) || [];
        vertiportLocation = vehicles.length > 0 ? 
          vehicles[0].position : 
          { type: 'Point', coordinates: [-100, 40] };
      }
      
      // Create hazard based on emergency type
      const hazardId = `hazard-vertiport-${Random.id()}`;
      
      const hazard = {
        _id: hazardId,
        simulationId,
        hazardType: 'VERTIPORT_EMERGENCY',
        location: vertiportLocation,
        radius: 1000, // 1km radius
        severity: eventData.data.severity === 'HIGH' ? 0.9 : 0.7,
        source: 'SIMULATION_VERTIPORT_EMERGENCY',
        timestamp: new Date(),
        expiryTime: new Date(Date.now() + 3600000), // 1 hour default
        metadata: {
          vertiportId: eventData.data.vertiportId,
          emergencyId,
          emergencyType: eventData.data.emergencyType,
          severity: eventData.data.severity
        }
      };
      
      // Add to simulated hazards
      const hazards = this.simulatedHazards.get(simulationId) || [];
      hazards.push(hazard);
      this.simulatedHazards.set(simulationId, hazards);
      
      // Insert into collection
      await this.simulationCollections.hazards.insert(hazard);
      
      // Insert into events collection
      await this.simulationCollections.events.insert({
        simulationId,
        eventType: 'VERTIPORT_EMERGENCY_DECLARED',
        timestamp: new Date(),
        data: {
          vertiportId: eventData.data.vertiportId,
          emergencyId,
          emergencyType: eventData.data.emergencyType,
          severity: eventData.data.severity,
          hazardId
        }
      });
      
      // Log event
      this._logSimulationEvent(simulationId, 'VERTIPORT_EMERGENCY_TRIGGERED', {
        vertiportId: eventData.data.vertiportId,
        emergencyId,
        emergencyType: eventData.data.emergencyType,
        hazardId
      });
      
      // Increment hazard counter
      const counter = this.simulationCounters.get(simulationId);
      if (counter) {
        counter.entities.hazards++;
      }
      
      return {
        success: true,
        emergencyId,
        hazardId,
        message: 'Vertiport emergency triggered'
      };
    } catch (error) {
      console.error(`Error triggering vertiport emergency in simulation ${simulationId}:`, error);
      return {
        success: false,
        error: error.message
      };
    }
  }

  /**
   * Inject a trajectory into a simulation
   * @param {string} simulationId - Simulation ID
   * @param {Object} eventData - Event data
   * @returns {Promise<Object>} Result
   * @private
   */
  async _injectTrajectory(simulationId, eventData) {
    try {
      // Validate trajectory data
      if (!eventData.data.vehicleId || !eventData.data.path) {
        throw new Error('Vehicle ID and path are required');
      }
      
      // Get vehicle
      const vehicles = this.simulatedVehicles.get(simulationId) || [];
      const vehicle = vehicles.find(v => v.vehicleId === eventData.data.vehicleId);
      
      if (!vehicle) {
        throw new Error(`Vehicle ${eventData.data.vehicleId} not found in simulation ${simulationId}`);
      }
      
      // Create trajectory ID
      const trajectoryId = `traj-${Random.id()}`;
      
      // Create trajectory object
      const trajectory = {
        _id: trajectoryId,
        simulationId,
        vehicleId: eventData.data.vehicleId,
        path: eventData.data.path,
        timestamp: new Date(),
        source: 'SIMULATION_INJECT',
        metadata: eventData.data.metadata || {}
      };
      
      // Add time points if not provided
      if (!trajectory.timePoints) {
        trajectory.timePoints = this._generateTimePointsForPath(
          trajectory.path,
          vehicle.speed,
          new Date()
        );
      }
      
      // Insert into collection
      await this.simulationCollections.trajectories.insert(trajectory);
      
      // Update vehicle
      vehicle.currentTrajectory = trajectoryId;
      
      // Log event
      this._logSimulationEvent(simulationId, 'TRAJECTORY_ADDED', {
        vehicleId: vehicle.vehicleId,
        trajectoryId
      });
      
      return {
        success: true,
        trajectoryId,
        message: 'Trajectory added to simulation'
      };
    } catch (error) {
      console.error(`Error injecting trajectory into simulation ${simulationId}:`, error);
      return {
        success: false,
        error: error.message
      };
    }
  }

  /**
   * Generate time points for a path
   * @param {Object} path - GeoJSON path
   * @param {number} speed - Speed in m/s
   * @param {Date} startTime - Start time
   * @returns {Array} Time points
   * @private
   */
  _generateTimePointsForPath(path, speed, startTime) {
    try {
      // Check path
      if (!path || !path.coordinates || path.coordinates.length < 2) {
        return [];
      }
      
      // Create line string
      const line = turf.lineString(path.coordinates);
      
      // Calculate total length
      const length = turf.length(line, { units: 'kilometers' }) * 1000; // meters
      
      // Calculate total time
      const totalTime = length / speed; // seconds
      
      // Create time points
      const timePoints = [];
      const numPoints = path.coordinates.length;
      
      for (let i = 0; i < numPoints; i++) {
        const fraction = i / (numPoints - 1);
        timePoints.push({
          time: new Date(startTime.getTime() + fraction * totalTime * 1000),
          coordinates: path.coordinates[i]
        });
      }
      
      return timePoints;
    } catch (error) {
      console.error('Error generating time points for path:', error);
      return [];
    }
  }

  /**
   * Map emergency type to hazard type
   * @param {string} emergencyType - Emergency type
   * @returns {string} Hazard type
   * @private
   */
  _mapEmergencyTypeToHazardType(emergencyType) {
    switch (emergencyType) {
      case 'ENGINE_FAILURE':
        return 'VEHICLE_EMERGENCY';
      case 'BATTERY_CRITICAL':
        return 'BATTERY_EMERGENCY';
      case 'NAVIGATION_FAILURE':
        return 'NAVIGATION_EMERGENCY';
      case 'COMMUNICATION_LOSS':
        return 'COMMUNICATION_LOSS';
      case 'SYSTEM_FAILURE':
        return 'SYSTEM_EMERGENCY';
      default:
        return 'VEHICLE_EMERGENCY';
    }
  }

  /**
   * Set up immersive data handlers
   * @param {string} sessionId - Session ID
   * @param {string} mode - Session mode ('AR' or 'VR')
   * @param {string} simulationId - Simulation ID
   * @private
   * @returns {Promise<void>}
   */
  async _setupImmersiveDataHandlers(sessionId, mode, simulationId) {
    try {
      // Create collection handles array
      const handles = [];
      
      // Set up reactive data subscriptions
      const vehicleStateHandle = this.simulationCollections.vehicleStates.find({
        simulationId
      }).observeChanges({
        added: (id, fields) => {
          this._broadcastImmersiveUpdate(sessionId, mode, 'vehicleState', { id, ...fields });
        },
        changed: (id, fields) => {
          this._broadcastImmersiveUpdate(sessionId, mode, 'vehicleState', { id, ...fields });
        },
        removed: (id) => {
          this._broadcastImmersiveUpdate(sessionId, mode, 'vehicleStateRemoved', { id });
        }
      });
      handles.push(vehicleStateHandle);
      
      const hazardHandle = this.simulationCollections.hazards.find({
        simulationId
      }).observeChanges({
        added: (id, fields) => {
          this._broadcastImmersiveUpdate(sessionId, mode, 'hazard', { id, ...fields });
        },
        changed: (id, fields) => {
          this._broadcastImmersiveUpdate(sessionId, mode, 'hazard', { id, ...fields });
        },
        removed: (id) => {
          this._broadcastImmersiveUpdate(sessionId, mode, 'hazardRemoved', { id });
        }
      });
      handles.push(hazardHandle);
      
      const riskHandle = this.simulationCollections.risks.find({
        simulationId
      }).observeChanges({
        added: (id, fields) => {
          this._broadcastImmersiveUpdate(sessionId, mode, 'risk', { id, ...fields });
        },
        changed: (id, fields) => {
          this._broadcastImmersiveUpdate(sessionId, mode, 'risk', { id, ...fields });
        },
        removed: (id) => {
          this._broadcastImmersiveUpdate(sessionId, mode, 'riskRemoved', { id });
        }
      });
      handles.push(riskHandle);
      
      const trajectoryHandle = this.simulationCollections.trajectories.find({
        simulationId
      }).observeChanges({
        added: (id, fields) => {
          this._broadcastImmersiveUpdate(sessionId, mode, 'trajectory', { id, ...fields });
        },
        changed: (id, fields) => {
          this._broadcastImmersiveUpdate(sessionId, mode, 'trajectory', { id, ...fields });
        },
        removed: (id) => {
          this._broadcastImmersiveUpdate(sessionId, mode, 'trajectoryRemoved', { id });
        }
      });
      handles.push(trajectoryHandle);
      
      // Store handles for cleanup
      this.vrCollectionHandles.set(sessionId, handles);
    } catch (error) {
      console.error(`Error setting up immersive data handlers for session ${sessionId}:`, error);
    }
  }

  /**
   * Broadcast an immersive update
   * @param {string} sessionId - Session ID
   * @param {string} mode - Session mode ('AR' or 'VR')
   * @param {string} updateType - Update type
   * @param {Object} data - Update data
   * @private
   */
  _broadcastImmersiveUpdate(sessionId, mode, updateType, data) {
    try {
      // In a real implementation, this would send updates to clients
      // For this example, we'll just emit an event
      this.emit('immersiveUpdate', {
        sessionId,
        mode,
        updateType,
        data
      });
    } catch (error) {
      console.error(`Error broadcasting immersive update for session ${sessionId}:`, error);
    }
  }

  /**
   * Process waypoint placement interaction
   * @param {string} simulationId - Simulation ID
   * @param {Object} interaction - Interaction data
   * @private
   * @returns {Promise<void>}
   */
  async _processWaypointPlacement(simulationId, interaction) {
    try {
      // Check if target vehicle exists
      const vehicles = this.simulatedVehicles.get(simulationId) || [];
      const vehicle = vehicles.find(v => v.vehicleId === interaction.target.vehicleId);
      
      if (!vehicle) return;
      
      // Get current path or create new one
      let currentPath;
      let trajectoryId;
      
      // Check if vehicle has a current trajectory
      if (vehicle.currentTrajectory) {
        const trajectory = await this.simulationCollections.trajectories.findOne({
          _id: vehicle.currentTrajectory
        });
        
        if (trajectory) {
          currentPath = trajectory.path;
          trajectoryId = trajectory._id;
        }
      }
      
      // Create new path if none exists
      if (!currentPath) {
        currentPath = {
          type: 'LineString',
          coordinates: [vehicle.position.coordinates]
        };
      }
      
      // Add new waypoint
      currentPath.coordinates.push(interaction.position.coordinates);
      
      // Create or update trajectory
      if (trajectoryId) {
        // Update existing trajectory
        await this.simulationCollections.trajectories.update(
          { _id: trajectoryId },
          { 
            $set: { 
              path: currentPath,
              timePoints: this._generateTimePointsForPath(
                currentPath,
                vehicle.speed,
                new Date()
              ),
              updatedAt: new Date()
            } 
          }
        );
      } else {
        // Create new trajectory
        trajectoryId = `traj-${Random.id()}`;
        
        await this.simulationCollections.trajectories.insert({
          _id: trajectoryId,
          simulationId,
          vehicleId: vehicle.vehicleId,
          path: currentPath,
          timePoints: this._generateTimePointsForPath(
            currentPath,
            vehicle.speed,
            new Date()
          ),
          timestamp: new Date(),
          source: 'USER_INTERACTION'
        });
        
        // Update vehicle
        vehicle.currentTrajectory = trajectoryId;
      }
      
      // Log event
      this._logSimulationEvent(simulationId, 'USER_PLACED_WAYPOINT', {
        vehicleId: vehicle.vehicleId,
        trajectoryId,
        waypointPosition: interaction.position.coordinates
      });
    } catch (error) {
      console.error(`Error processing waypoint placement:`, error);
    }
  }

  /**
   * Process trajectory modification interaction
   * @param {string} simulationId - Simulation ID
   * @param {Object} interaction - Interaction data
   * @private
   * @returns {Promise<void>}
   */
  async _processTrajectoryModification(simulationId, interaction) {
    try {
      // Check if target vehicle exists
      const vehicles = this.simulatedVehicles.get(simulationId) || [];
      const vehicle = vehicles.find(v => v.vehicleId === interaction.target.vehicleId);
      
      if (!vehicle) return;
      
      // Update trajectory based on modification type
      if (interaction.data.modificationType === 'REPLACE') {
        // Replace entire trajectory
        const trajectoryId = `traj-${Random.id()}`;
        
        await this.simulationCollections.trajectories.insert({
          _id: trajectoryId,
          simulationId,
          vehicleId: vehicle.vehicleId,
          path: interaction.data.path,
          timePoints: interaction.data.timePoints || this._generateTimePointsForPath(
            interaction.data.path,
            vehicle.speed,
            new Date()
          ),
          timestamp: new Date(),
          source: 'USER_INTERACTION'
        });
        
        // Update vehicle
        vehicle.currentTrajectory = trajectoryId;
      } else if (interaction.data.modificationType === 'EDIT_WAYPOINT') {
        // Edit specific waypoint
        if (!vehicle.currentTrajectory) return;
        
        const trajectory = await this.simulationCollections.trajectories.findOne({
          _id: vehicle.currentTrajectory
        });
        
        if (!trajectory || !trajectory.path || !trajectory.path.coordinates) return;
        
        // Update waypoint at specified index
        if (interaction.data.waypointIndex >= 0 && 
            interaction.data.waypointIndex < trajectory.path.coordinates.length) {
          trajectory.path.coordinates[interaction.data.waypointIndex] = interaction.data.newPosition.coordinates;
          
          // Update trajectory
          await this.simulationCollections.trajectories.update(
            { _id: trajectory._id },
            { 
              $set: { 
                path: trajectory.path,
                timePoints: this._generateTimePointsForPath(
                  trajectory.path,
                  vehicle.speed,
                  new Date()
                ),
                updatedAt: new Date()
              } 
            }
          );
        }
      }
      
      // Log event
      this._logSimulationEvent(simulationId, 'USER_MODIFIED_TRAJECTORY', {
        vehicleId: vehicle.vehicleId,
        modificationType: interaction.data.modificationType
      });
    } catch (error) {
      console.error(`Error processing trajectory modification:`, error);
    }
  }

  /**
   * Process mitigation trigger interaction
   * @param {string} simulationId - Simulation ID
   * @param {Object} interaction - Interaction data
   * @private
   * @returns {Promise<void>}
   */
  async _processMitigationTrigger(simulationId, interaction) {
    try {
      // Check if target vehicle exists
      const vehicles = this.simulatedVehicles.get(simulationId) || [];
      const vehicle = vehicles.find(v => v.vehicleId === interaction.target.vehicleId);
      
      if (!vehicle) return;
      
      // Create mitigation based on type
      const mitigationType = interaction.data.mitigationType || 'REROUTE';
      
      // Create mitigation ID
      const mitigationId = `mitigation-${Random.id()}`;
      
      // Create mitigation object
      const mitigation = {
        _id: mitigationId,
        simulationId,
        vehicleId: vehicle.vehicleId,
        mitigationType,
        mitigationAction: interaction.data.mitigationAction || this._getDefaultMitigationAction(mitigationType),
        parameters: {
          ...interaction.data.parameters,
          currentPosition: vehicle.position,
          currentAltitude: vehicle.altitude,
          currentHeading: vehicle.heading,
          currentSpeed: vehicle.speed
        },
        status: 'PENDING',
        timestamp: new Date(),
        expiryTime: new Date(Date.now() + 600000), // 10 minutes
        source: 'USER_INTERACTION',
        metadata: {
          sessionId: interaction.sessionId,
          userId: interaction.userId
        }
      };
      
      // Insert into collection
      await this.simulationCollections.mitigations.insert(mitigation);
      
      // Apply mitigation to vehicle
      await this._applyMitigationToVehicle(simulationId, mitigation);
      
      // Log event
      this._logSimulationEvent(simulationId, 'USER_TRIGGERED_MITIGATION', {
        vehicleId: vehicle.vehicleId,
        mitigationId,
        mitigationType,
        mitigationAction: mitigation.mitigationAction
      });
      
      // Increment mitigation counter
      const counter = this.simulationCounters.get(simulationId);
      if (counter) {
        counter.entities.mitigations++;
      }
    } catch (error) {
      console.error(`Error processing mitigation trigger:`, error);
    }
  }

  /**
   * Get default mitigation action for a mitigation type
   * @param {string} mitigationType - Mitigation type
   * @returns {string} Default mitigation action
   * @private
   */
  _getDefaultMitigationAction(mitigationType) {
    switch (mitigationType) {
      case 'REROUTE':
        return 'GENERATE_ALTERNATE_ROUTE';
      case 'ALTITUDE_CHANGE':
        return 'CLIMB';
      case 'SPEED_CHANGE':
        return 'REDUCE_SPEED';
      case 'RETURN_TO_BASE':
        return 'RTB';
      case 'LAND':
        return 'LAND_IMMEDIATELY';
      case 'HOLD':
        return 'HOLD_POSITION';
      default:
        return 'REDUCE_SPEED';
    }
  }

  /**
   * Set up collection indexes
   * @private
   * @returns {Promise<void>}
   */
  async _setupCollectionIndexes() {
    try {
      // Create indexes for simulation collections
      await this.simulationCollections.vehicleStates.createIndex({ simulationId: 1, vehicleId: 1 });
      await this.simulationCollections.vehicleStates.createIndex({ timestamp: 1 });
      
      await this.simulationCollections.hazards.createIndex({ simulationId: 1 });
      await this.simulationCollections.hazards.createIndex({ expiryTime: 1 });
      
      await this.simulationCollections.risks.createIndex({ simulationId: 1, vehicleId: 1 });
      await this.simulationCollections.risks.createIndex({ riskLevel: 1 });
      
      await this.simulationCollections.mitigations.createIndex({ simulationId: 1, vehicleId: 1 });
      await this.simulationCollections.mitigations.createIndex({ status: 1 });
      
      await this.simulationCollections.trajectories.createIndex({ simulationId: 1, vehicleId: 1 });
      
      await this.simulationCollections.weatherData.createIndex({ simulationId: 1, areaId: 1 });
      
      await this.simulationCollections.metrics.createIndex({ simulationId: 1 }, { unique: true });
      
      await this.simulationCollections.events.createIndex({ simulationId: 1, timestamp: 1 });
      await this.simulationCollections.events.createIndex({ eventType: 1 });
      
      await this.simulationCollections.userActions.createIndex({ simulationId: 1, sessionId: 1 });
      await this.simulationCollections.userActions.createIndex({ userId: 1 });
    } catch (error) {
      console.error('Error setting up collection indexes:', error);
    }
  }

  /**
   * Register Meteor methods
   * @private
   */
  _registerMeteorMethods() {
    const self = this;
    
    Meteor.methods({
      /**
       * Get all available training scenarios
       * @returns {Promise<Array>} List of scenarios
       */
      'iasms.simulation.getScenarios': async function() {
        return await self.getScenarios();
      },
      
      /**
       * Create a new simulation
       * @param {Object} options - Simulation options
       * @returns {Promise<Object>} Simulation result
       */
      'iasms.simulation.createSimulation': async function(options) {
        // Add user ID
        options.userId = this.userId;
        return await self.createSimulation(options);
      },
      
      /**
       * Start a simulation
       * @param {string} simulationId - Simulation ID
       * @returns {Promise<Object>} Start result
       */
      'iasms.simulation.startSimulation': async function(simulationId) {
        return await self.startSimulation(simulationId);
      },
      
      /**
       * Pause a simulation
       * @param {string} simulationId - Simulation ID
       * @returns {Promise<Object>} Pause result
       */
      'iasms.simulation.pauseSimulation': async function(simulationId) {
        return await self.pauseSimulation(simulationId);
      },
      
      /**
       * Stop a simulation
       * @param {string} simulationId - Simulation ID
       * @returns {Promise<Object>} Stop result
       */
      'iasms.simulation.stopSimulation': async function(simulationId) {
        return await self.stopSimulation(simulationId);
      },
      
      /**
       * Set simulation speed
       * @param {string} simulationId - Simulation ID
       * @param {number} speedFactor - Speed factor
       * @returns {Promise<Object>} Result
       */
      'iasms.simulation.setSimulationSpeed': async function(simulationId, speedFactor) {
        return await self.setSimulationSpeed(simulationId, speedFactor);
      },
      
      /**
       * Inject an event into a simulation
       * @param {string} simulationId - Simulation ID
       * @param {Object} eventData - Event data
       * @returns {Promise<Object>} Result
       */
      'iasms.simulation.injectEvent': async function(simulationId, eventData) {
        return await self.injectSimulationEvent(simulationId, eventData);
      },
      
      /**
       * Get simulation details
       * @param {string} simulationId - Simulation ID
       * @returns {Promise<Object>} Simulation details
       */
      'iasms.simulation.getDetails': async function(simulationId) {
        return await self.getSimulationDetails(simulationId);
      },
      
      /**
       * Create AR/VR session
       * @param {Object} options - Session options
       * @returns {Promise<Object>} Session details
       */
      'iasms.simulation.createImmersiveSession': async function(options) {
        // Add user ID
        options.userId = this.userId;
        return await self.createImmersiveSession(options);
      },
      
      /**
       * Update AR/VR session
       * @param {string} sessionId - Session ID
       * @param {Object} updates - Updates to apply
       * @returns {Promise<Object>} Update result
       */
      'iasms.simulation.updateImmersiveSession': async function(sessionId, updates) {
        return await self.updateImmersiveSession(sessionId, updates);
      },
      
      /**
       * End AR/VR session
       * @param {string} sessionId - Session ID
       * @returns {Promise<Object>} Result
       */
      'iasms.simulation.endImmersiveSession': async function(sessionId) {
        return await self.endImmersiveSession(sessionId);
      },
      
      /**
       * Record interaction in AR/VR session
       * @param {string} sessionId - Session ID
       * @param {Object} interaction - Interaction data
       * @returns {Promise<Object>} Result
       */
      'iasms.simulation.recordInteraction': async function(sessionId, interaction) {
        return await self.recordImmersiveInteraction(sessionId, interaction);
      }
    });
  }

  /**
   * Set up publications
   * @private
   */
  _setupPublications() {
    const self = this;
    
    // Publish available scenarios
    Meteor.publish('iasms.simulation.scenarios', function() {
      return Array.from(self.scenarioLibrary.values());
    });
    
    // Publish active simulations for user
    Meteor.publish('iasms.simulation.userSimulations', function() {
      if (!this.userId) return this.ready();
      
      const simulations = Array.from(self.activeSimulations.values())
        .filter(sim => sim.userId === this.userId)
        .map(sim => ({
          simulationId: sim.simulationId,
          scenarioId: sim.scenarioId,
          status: sim.status,
          startTime: sim.startTime,
          currentTime: sim.currentTime,
          endTime: sim.endTime,
          speedFactor: sim.speedFactor
        }));
      
      this.added('iasmsSimulations', 'active', { simulations });
      this.ready();
    });
    
    // Publish simulation vehicle states
    Meteor.publish('iasms.simulation.vehicleStates', function(simulationId) {
      if (!simulationId) return this.ready();
      
      return self.simulationCollections.vehicleStates.find({
        simulationId
      }, {
        sort: { timestamp: -1 },
        limit: 100
      });
    });
    
    // Publish simulation hazards
    Meteor.publish('iasms.simulation.hazards', function(simulationId) {
      if (!simulationId) return this.ready();
      
      return self.simulationCollections.hazards.find({
        simulationId,
        expiryTime: { $gt: new Date() }
      });
    });
    
    // Publish simulation risks
    Meteor.publish('iasms.simulation.risks', function(simulationId) {
      if (!simulationId) return this.ready();
      
      return self.simulationCollections.risks.find({
        simulationId
      }, {
        sort: { riskLevel: -1 },
        limit: 50
      });
    });
    
    // Publish simulation mitigations
    Meteor.publish('iasms.simulation.mitigations', function(simulationId) {
      if (!simulationId) return this.ready();
      
      return self.simulationCollections.mitigations.find({
        simulationId
      }, {
        sort: { timestamp: -1 },
        limit: 50
      });
    });
    
    // Publish simulation events
    Meteor.publish('iasms.simulation.events', function(simulationId) {
      if (!simulationId) return this.ready();
      
      return self.simulationCollections.events.find({
        simulationId
      }, {
        sort: { timestamp: -1 },
        limit: 50
      });
    });
    
    // Publish immersive session data
    Meteor.publish('iasms.simulation.immersiveData', function(sessionId) {
      if (!sessionId) return this.ready();
      
      // Find session
      let session = self.vrSessions.get(sessionId);
      let isVr = true;
      
      if (!session) {
        session = self.arOverlays.get(sessionId);
        isVr = false;
        
        if (!session) {
          return this.ready();
        }
      }
      
      // Return session data
      this.added('iasmsImmersiveSessions', sessionId, {
        sessionId,
        simulationId: session.simulationId,
        mode: session.mode,
        status: session.status,
        startTime: session.startTime,
        viewSettings: session.viewSettings
      });
      
      this.ready();
    });
  }
}
```


```textmate
import React, { useState, useEffect } from 'react';
import { Meteor } from 'meteor/meteor';
import { useTracker } from 'meteor/react-meteor-data';
import LoadingSpinnerComponent from './LoadingSpinnerComponent';

/**
 * Simulation Control Panel Component
 * Provides controls for creating, starting, pausing, and stopping simulations
 */
const SimulationControlPanel = () => {
  // State for available scenarios
  const [scenarios, setScenarios] = useState([]);
  const [selectedScenario, setSelectedScenario] = useState('');
  const [speedFactor, setSpeedFactor] = useState(1.0);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState('');
  
  // State for active simulation
  const [simulationId, setSimulationId] = useState('');
  const [simulationStatus, setSimulationStatus] = useState('');
  const [simulationDetails, setSimulationDetails] = useState(null);
  
  // Fetch scenarios on component mount
  useEffect(() => {
    setIsLoading(true);
    Meteor.call('iasms.simulation.getScenarios', (err, result) => {
      setIsLoading(false);
      if (err) {
        console.error('Error fetching scenarios:', err);
        setError('Failed to load scenarios. Please try again.');
      } else {
        setScenarios(result);
        if (result.length > 0) {
          setSelectedScenario(result[0].id);
        }
      }
    });
  }, []);
  
  // Track active simulation
  const simulationData = useTracker(() => {
    const sub = Meteor.subscribe('iasms.simulation.userSimulations');
    if (!sub.ready()) {
      return { isLoading: true };
    }
    
    const data = Meteor.connection._stores.iasmsSimulations?.documents?.get('active');
    return {
      isLoading: false,
      simulations: data?.simulations || []
    };
  });
  
  // Update simulation ID and status if there's an active simulation
  useEffect(() => {
    if (!simulationData.isLoading && simulationData.simulations.length > 0) {
      const activeSimulation = simulationData.simulations.find(s => 
        s.status === 'RUNNING' || s.status === 'PAUSED' || s.status === 'INITIALIZED'
      );
      
      if (activeSimulation) {
        setSimulationId(activeSimulation.simulationId);
        setSimulationStatus(activeSimulation.status);
        
        // Fetch simulation details
        fetchSimulationDetails(activeSimulation.simulationId);
      }
    }
  }, [simulationData]);
  
  // Fetch simulation details
  const fetchSimulationDetails = (simId) => {
    Meteor.call('iasms.simulation.getDetails', simId, (err, result) => {
      if (err) {
        console.error('Error fetching simulation details:', err);
      } else {
        setSimulationDetails(result);
      }
    });
  };
  
  // Create a new simulation
  const createSimulation = () => {
    if (!selectedScenario) {
      setError('Please select a scenario first');
      return;
    }
    
    setIsLoading(true);
    setError('');
    
    Meteor.call(
      'iasms.simulation.createSimulation', 
      {
        scenarioId: selectedScenario,
        speedFactor,
        recordMetrics: true
      },
      (err, result) => {
        setIsLoading(false);
        if (err) {
          console.error('Error creating simulation:', err);
          setError('Failed to create simulation. Please try again.');
        } else if (result.success) {
          setSimulationId(result.simulationId);
          setSimulationStatus('INITIALIZED');
          setError('');
        } else {
          setError(result.error || 'Failed to create simulation. Please try again.');
        }
      }
    );
  };
  
  // Start simulation
  const startSimulation = () => {
    if (!simulationId) return;
    
    setIsLoading(true);
    setError('');
    
    Meteor.call('iasms.simulation.startSimulation', simulationId, (err, result) => {
      setIsLoading(false);
      if (err) {
        console.error('Error starting simulation:', err);
        setError('Failed to start simulation. Please try again.');
      } else if (result.success) {
        setSimulationStatus('RUNNING');
        setError('');
      } else {
        setError(result.error || 'Failed to start simulation. Please try again.');
      }
    });
  };
  
  // Pause simulation
  const pauseSimulation = () => {
    if (!simulationId) return;
    
    setIsLoading(true);
    setError('');
    
    Meteor.call('iasms.simulation.pauseSimulation', simulationId, (err, result) => {
      setIsLoading(false);
      if (err) {
        console.error('Error pausing simulation:', err);
        setError('Failed to pause simulation. Please try again.');
      } else if (result.success) {
        setSimulationStatus('PAUSED');
        setError('');
      } else {
        setError(result.error || 'Failed to pause simulation. Please try again.');
      }
    });
  };
  
  // Stop simulation
  const stopSimulation = () => {
    if (!simulationId) return;
    
    setIsLoading(true);
    setError('');
    
    Meteor.call('iasms.simulation.stopSimulation', simulationId, (err, result) => {
      setIsLoading(false);
      if (err) {
        console.error('Error stopping simulation:', err);
        setError('Failed to stop simulation. Please try again.');
      } else if (result.success) {
        setSimulationStatus('STOPPED');
        setSimulationId('');
        setSimulationDetails(result.summary);
        setError('');
      } else {
        setError(result.error || 'Failed to stop simulation. Please try again.');
      }
    });
  };
  
  // Change speed factor
  const changeSpeedFactor = (newFactor) => {
    if (!simulationId) return;
    
    setIsLoading(true);
    setError('');
    
    Meteor.call('iasms.simulation.setSimulationSpeed', simulationId, newFactor, (err, result) => {
      setIsLoading(false);
      if (err) {
        console.error('Error changing simulation speed:', err);
        setError('Failed to change simulation speed. Please try again.');
      } else if (result.success) {
        setSpeedFactor(newFactor);
        setError('');
      } else {
        setError(result.error || 'Failed to change simulation speed. Please try again.');
      }
    });
  };
  
  // Inject event
  const injectEvent = (eventType) => {
    if (!simulationId) return;
    
    const eventData = getEventDataForType(eventType);
    if (!eventData) return;
    
    setIsLoading(true);
    setError('');
    
    Meteor.call('iasms.simulation.injectEvent', simulationId, eventData, (err, result) => {
      setIsLoading(false);
      if (err) {
        console.error('Error injecting event:', err);
        setError(`Failed to inject ${eventType} event. Please try again.`);
      } else if (result.success) {
        setError('');
        // Refresh simulation details
        fetchSimulationDetails(simulationId);
      } else {
        setError(result.error || `Failed to inject ${eventType} event. Please try again.`);
      }
    });
  };
  
  // Helper to get event data based on type
  const getEventDataForType = (eventType) => {
    // Get a random vehicle if available
    const randomVehicle = simulationDetails?.statistics?.vehicleCount > 0 ? 
      `UAV-SIM-${Math.floor(Math.random() * 100).toString().padStart(3, '0')}` :
      'UAV-SIM-001';
    
    switch (eventType) {
      case 'WEATHER':
        return {
          type: 'MODIFY_WEATHER',
          data: {
            conditions: {
              wind: { speed: 15 + Math.random() * 10, direction: Math.random() * 360 },
              visibility: 5000,
              precipitation: 0.5,
              fog: true
            }
          }
        };
        
      case 'HAZARD':
        return {
          type: 'ADD_HAZARD',
          data: {
            hazardType: 'WEATHER_THUNDERSTORM',
            location: { 
              type: 'Point', 
              coordinates: [-122.419 + (Math.random() * 0.05 - 0.025), 37.774 + (Math.random() * 0.05 - 0.025)] 
            },
            radius: 2000,
            severity: 0.8
          }
        };
        
      case 'COMMUNICATION_LOSS':
        return {
          type: 'TRIGGER_COMMUNICATION_LOSS',
          data: {
            vehicleId: randomVehicle
          }
        };
        
      case 'EMERGENCY':
        return {
          type: 'TRIGGER_EMERGENCY',
          data: {
            vehicleId: randomVehicle,
            emergencyType: 'BATTERY_CRITICAL',
            severity: 'HIGH'
          }
        };
        
      case 'NEW_VEHICLE':
        return {
          type: 'ADD_VEHICLE',
          data: {
            vehicleId: `UAV-NEW-${Math.floor(Math.random() * 1000)}`,
            position: { 
              type: 'Point', 
              coordinates: [-122.419 + (Math.random() * 0.05 - 0.025), 37.774 + (Math.random() * 0.05 - 0.025)] 
            },
            altitude: 100 + Math.random() * 100,
            heading: Math.random() * 360,
            speed: 5 + Math.random() * 10
          }
        };
        
      default:
        return null;
    }
  };
  
  // Launch AR experience
  const launchARExperience = () => {
    if (!simulationId) return;
    
    // In a real implementation, this would launch an AR experience
    // For this example, we'll just create an AR session
    Meteor.call(
      'iasms.simulation.createImmersiveSession',
      {
        simulationId,
        mode: 'AR',
        deviceInfo: {
          platform: 'WebAR',
          browser: navigator.userAgent
        }
      },
      (err, result) => {
        if (err) {
          console.error('Error creating AR session:', err);
          setError('Failed to launch AR experience. Please try again.');
        } else if (result.success) {
          // In a real implementation, this would redirect to the AR experience
          console.log('AR session created:', result.sessionId);
          window.open(`/ar-experience?sessionId=${result.sessionId}&simulationId=${simulationId}`, '_blank');
        } else {
          setError(result.error || 'Failed to launch AR experience. Please try again.');
        }
      }
    );
  };
  
  // Launch VR experience
  const launchVRExperience = () => {
    if (!simulationId) return;
    
    // In a real implementation, this would launch a VR experience
    // For this example, we'll just create a VR session
    Meteor.call(
      'iasms.simulation.createImmersiveSession',
      {
        simulationId,
        mode: 'VR',
        deviceInfo: {
          platform: 'WebVR',
          browser: navigator.userAgent
        }
      },
      (err, result) => {
        if (err) {
          console.error('Error creating VR session:', err);
          setError('Failed to launch VR experience. Please try again.');
        } else if (result.success) {
          // In a real implementation, this would redirect to the VR experience
          console.log('VR session created:', result.sessionId);
          window.open(`/vr-experience?sessionId=${result.sessionId}&simulationId=${simulationId}`, '_blank');
        } else {
          setError(result.error || 'Failed to launch VR experience. Please try again.');
        }
      }
    );
  };
  
  // Render scenario selection and controls
  return (
    <div className="simulation-control-panel">
      <h2 className="mb-4">Simulation & Training Control</h2>
      
      {error && <div className="alert alert-danger">{error}</div>}
      
      {isLoading ? (
        <LoadingSpinnerComponent />
      ) : (
        <>
          {!simulationId ? (
            <div className="card mb-4">
              <div className="card-header">
                <h5 className="mb-0">Create New Simulation</h5>
              </div>
              <div className="card-body">
                <div className="mb-3">
                  <label htmlFor="scenarioSelect" className="form-label">Select Training Scenario</label>
                  <select 
                    id="scenarioSelect" 
                    className="form-select"
                    value={selectedScenario}
                    onChange={(e) => setSelectedScenario(e.target.value)}
                  >
                    {scenarios.map(scenario => (
                      <option key={scenario.id} value={scenario.id}>
                        {scenario.name} ({scenario.difficulty})
                      </option>
                    ))}
                  </select>
                </div>
                
                {selectedScenario && (
                  <div className="scenario-details mb-3">
                    <h6>Scenario Details</h6>
                    <p>
                      {scenarios.find(s => s.id === selectedScenario)?.description}
                    </p>
                    <div className="objectives">
                      <h6>Objectives:</h6>
                      <ul>
                        {scenarios.find(s => s.id === selectedScenario)?.objectives.map((obj, idx) => (
                          <li key={idx}>{obj}</li>
                        ))}
                      </ul>
                    </div>
                  </div>
                )}
                
                <div className="mb-3">
                  <label htmlFor="speedFactorRange" className="form-label">
                    Simulation Speed Factor: {speedFactor}x
                  </label>
                  <input 
                    type="range" 
                    className="form-range" 
                    id="speedFactorRange"
                    min="0.1" 
                    max="10" 
                    step="0.1" 
                    value={speedFactor}
                    onChange={(e) => setSpeedFactor(parseFloat(e.target.value))}
                  />
                </div>
                
                <button 
                  className="btn btn-primary" 
                  onClick={createSimulation}
                  disabled={!selectedScenario}
                >
                  Create Simulation
                </button>
              </div>
            </div>
          ) : (
            <div className="card mb-4">
              <div className="card-header d-flex justify-content-between align-items-center">
                <h5 className="mb-0">Simulation Controls</h5>
                <div className="simulation-status">
                  Status: <span className={`badge bg-${getStatusColor(simulationStatus)}`}>{simulationStatus}</span>
                </div>
              </div>
              <div className="card-body">
                <div className="simulation-info mb-3">
                  <p><strong>Scenario:</strong> {simulationDetails?.scenario?.name || 'Loading...'}</p>
                  <p><strong>Simulation ID:</strong> {simulationId}</p>
                  {simulationDetails && (
                    <>
                      <p><strong>Vehicles:</strong> {simulationDetails.statistics.vehicleCount}</p>
                      <p><strong>Hazards:</strong> {simulationDetails.statistics.hazardCount}</p>
                      <p><strong>Risks:</strong> {simulationDetails.statistics.riskCount}</p>
                    </>
                  )}
                </div>
                
                <div className="btn-toolbar mb-3" role="toolbar">
                  {simulationStatus === 'INITIALIZED' && (
                    <button className="btn btn-success me-2" onClick={startSimulation}>
                      <i className="bi bi-play-fill"></i> Start
                    </button>
                  )}
                  
                  {simulationStatus === 'RUNNING' && (
                    <button className="btn btn-warning me-2" onClick={pauseSimulation}>
                      <i className="bi bi-pause-fill"></i> Pause
                    </button>
                  )}
                  
                  {simulationStatus === 'PAUSED' && (
                    <button className="btn btn-success me-2" onClick={startSimulation}>
                      <i className="bi bi-play-fill"></i> Resume
                    </button>
                  )}
                  
                  {(simulationStatus === 'RUNNING' || simulationStatus === 'PAUSED') && (
                    <button className="btn btn-danger me-2" onClick={stopSimulation}>
                      <i className="bi bi-stop-fill"></i> Stop
                    </button>
                  )}
                </div>
                
                {(simulationStatus === 'RUNNING' || simulationStatus === 'PAUSED') && (
                  <>
                    <div className="speed-controls mb-3">
                      <label htmlFor="runningSpeedFactor" className="form-label">
                        Speed Factor: {speedFactor}x
                      </label>
                      <div className="d-flex align-items-center">
                        <input 
                          type="range" 
                          className="form-range me-2" 
                          id="runningSpeedFactor"
                          min="0.1" 
                          max="10" 
                          step="0.1" 
                          value={speedFactor}
                          onChange={(e) => changeSpeedFactor(parseFloat(e.target.value))}
                        />
                        <div className="btn-group" role="group">
                          <button 
                            className="btn btn-sm btn-outline-secondary" 
                            onClick={() => changeSpeedFactor(0.5)}
                          >0.5x</button>
                          <button 
                            className="btn btn-sm btn-outline-secondary" 
                            onClick={() => changeSpeedFactor(1.0)}
                          >1x</button>
                          <button 
                            className="btn btn-sm btn-outline-secondary" 
                            onClick={() => changeSpeedFactor(2.0)}
                          >2x</button>
                          <button 
                            className="btn btn-sm btn-outline-secondary" 
                            onClick={() => changeSpeedFactor(5.0)}
                          >5x</button>
                        </div>
                      </div>
                    </div>
                    
                    <div className="event-injection mb-3">
                      <h6>Inject Events</h6>
                      <div className="btn-group" role="group">
                        <button 
                          className="btn btn-sm btn-outline-primary" 
                          onClick={() => injectEvent('WEATHER')}
                        >
                          <i className="bi bi-cloud"></i> Weather
                        </button>
                        <button 
                          className="btn btn-sm btn-outline-primary" 
                          onClick={() => injectEvent('HAZARD')}
                        >
                          <i className="bi bi-exclamation-triangle"></i> Hazard
                        </button>
                        <button 
                          className="btn btn-sm btn-outline-primary" 
                          onClick={() => injectEvent('COMMUNICATION_LOSS')}
                        >
                          <i className="bi bi-x-circle"></i> Comm Loss
                        </button>
                        <button 
                          className="btn btn-sm btn-outline-primary" 
                          onClick={() => injectEvent('EMERGENCY')}
                        >
                          <i className="bi bi-exclamation-circle"></i> Emergency
                        </button>
                        <button 
                          className="btn btn-sm btn-outline-primary" 
                          onClick={() => injectEvent('NEW_VEHICLE')}
                        >
                          <i className="bi bi-plus-circle"></i> Vehicle
                        </button>
                      </div>
                    </div>
                    
                    <div className="immersive-experiences">
                      <h6>Immersive Experiences</h6>
                      <div className="d-flex">
                        <button 
                          className="btn btn-outline-success me-2" 
                          onClick={launchARExperience}
                        >
                          <i className="bi bi-phone"></i> Launch AR Experience
                        </button>
                        <button 
                          className="btn btn-outline-info" 
                          onClick={launchVRExperience}
                        >
                          <i className="bi bi-badge-vr"></i> Launch VR Experience
                        </button>
                      </div>
                    </div>
                  </>
                )}
              </div>
            </div>
          )}
          
          {simulationStatus === 'STOPPED' && simulationDetails && (
            <div className="card mb-4">
              <div className="card-header">
                <h5 className="mb-0">Simulation Summary</h5>
              </div>
              <div className="card-body">
                <div className="row">
                  <div className="col-md-6">
                    <h6>Scenario</h6>
                    <p>{simulationDetails.simulation.scenario.name}</p>
                    <p><small>{simulationDetails.simulation.scenario.description}</small></p>
                    
                    <h6>Duration</h6>
                    <p>{simulationDetails.simulation.duration}</p>
                    
                    <h6>Status</h6>
                    <p><span className="badge bg-secondary">{simulationDetails.simulation.status}</span></p>
                  </div>
                  <div className="col-md-6">
                    <h6>Statistics</h6>
                    <ul className="list-group">
                      <li className="list-group-item d-flex justify-content-between align-items-center">
                        Vehicles
                        <span className="badge bg-primary rounded-pill">{simulationDetails.metrics.vehicles}</span>
                      </li>
                      <li className="list-group-item d-flex justify-content-between align-items-center">
                        Hazards
                        <span className="badge bg-warning rounded-pill">{simulationDetails.metrics.hazards}</span>
                      </li>
                      <li className="list-group-item d-flex justify-content-between align-items-center">
                        Risks
                        <span className="badge bg-danger rounded-pill">{simulationDetails.metrics.risks}</span>
                      </li>
                      <li className="list-group-item d-flex justify-content-between align-items-center">
                        Mitigations
                        <span className="badge bg-success rounded-pill">{simulationDetails.metrics.mitigations}</span>
                      </li>
                      <li className="list-group-item d-flex justify-content-between align-items-center">
                        Events
                        <span className="badge bg-info rounded-pill">{simulationDetails.metrics.events}</span>
                      </li>
                    </ul>
                    
                    <h6 className="mt-3">Performance</h6>
                    <p>Risk Mitigation Ratio: {simulationDetails.metrics.riskMitigationRatio}</p>
                    <p>Mitigation Effectiveness: {simulationDetails.metrics.mitigationEffectiveness}</p>
                  </div>
                </div>
                
                <div className="d-grid gap-2 d-md-flex justify-content-md-end mt-3">
                  <button className="btn btn-primary" onClick={() => setSimulationDetails(null)}>
                    Create New Simulation
                  </button>
                </div>
              </div>
            </div>
          )}
        </>
      )}
    </div>
  );
};

// Helper function to get color for status badge
const getStatusColor = (status) => {
  switch (status) {
    case 'RUNNING':
      return 'success';
    case 'PAUSED':
      return 'warning';
    case 'INITIALIZED':
      return 'info';
    case 'STOPPED':
    case 'COMPLETED':
      return 'secondary';
    default:
      return 'secondary';
  }
};

export default SimulationControlPanel;
```


```textmate
import React, { useState, useEffect, useRef } from 'react';
import { Meteor } from 'meteor/meteor';
import { useTracker } from 'meteor/react-meteor-data';
import * as THREE from 'three';
import { ARButton } from 'three/examples/jsm/webxr/ARButton.js';

/**
 * AR View Component
 * Provides an augmented reality view of simulation data
 */
const ARViewComponent = ({ sessionId, simulationId }) => {
  // State for session data
  const [session, setSession] = useState(null);
  const [viewSettings, setViewSettings] = useState({
    showLabels: true,
    showTrajectories: true,
    showRisks: true,
    showMitigations: true,
    showWeather: true,
    labelScale: 1.0,
    objectScale: 1.0
  });
  const [error, setError] = useState('');
  const [arSupported, setArSupported] = useState(false);
  
  // Refs for THREE.js objects
  const containerRef = useRef(null);
  const sceneRef = useRef(null);
  const cameraRef = useRef(null);
  const rendererRef = useRef(null);
  const vehiclesRef = useRef({});
  const hazardsRef = useRef({});
  const trajectoriesRef = useRef({});
  const overlaysRef = useRef({});
  
  // Track immersive session data
  const sessionData = useTracker(() => {
    const sub = Meteor.subscribe('iasms.simulation.immersiveData', sessionId);
    if (!sub.ready()) {
      return { isLoading: true };
    }
    
    return {
      isLoading: false,
      session: Meteor.connection._stores.iasmsImmersiveSessions?.documents?.get(sessionId)
    };
  });

  // Subscribe to simulation vehicle states
  const vehicleStates = useTracker(() => {
    const sub = Meteor.subscribe('iasms.simulation.vehicleStates', simulationId);
    return {
      isLoading: !sub.ready(),
      vehicles: Meteor.connection._stores.iasmsSimulationVehicleStates?.documents?.find(doc => 
        doc.simulationId === simulationId
      ).fetch() || []
    };
  });
  
  // Subscribe to simulation hazards
  const hazards = useTracker(() => {
    const sub = Meteor.subscribe('iasms.simulation.hazards', simulationId);
    return {
      isLoading: !sub.ready(),
      hazards: Meteor.connection._stores.iasmsSimulationHazards?.documents?.find(doc => 
        doc.simulationId === simulationId
      ).fetch() || []
    };
  });
  
  // Subscribe to simulation trajectories
  const trajectories = useTracker(() => {
    const sub = Meteor.subscribe('iasms.simulation.trajectories', simulationId);
    return {
      isLoading: !sub.ready(),
      trajectories: Meteor.connection._stores.iasmsSimulationTrajectories?.documents?.find(doc => 
        doc.simulationId === simulationId
      ).fetch() || []
    };
  });

  // Initialize AR view on component mount
  useEffect(() => {
    if (!sessionId || !simulationId) return;
    
    // Check for WebXR support
    if ('xr' in navigator) {
      navigator.xr.isSessionSupported('immersive-ar')
        .then((supported) => {
          setArSupported(supported);
          
          if (supported) {
            initARView();
          } else {
            setError('WebXR AR is not supported in your browser or device.');
          }
        })
        .catch(err => {
          console.error('Error checking AR support:', err);
          setError('Error checking AR support: ' + err.message);
        });
    } else {
      setError('WebXR is not available in your browser.');
    }
    
    // Cleanup on unmount
    return () => {
      cleanupARView();
      
      // End immersive session
      Meteor.call('iasms.simulation.endImmersiveSession', sessionId, (err) => {
        if (err) {
          console.error('Error ending AR session:', err);
        }
      });
    };
  }, [sessionId, simulationId]);
  
  // Update session when data changes
  useEffect(() => {
    if (sessionData.isLoading) return;
    
    if (sessionData.session) {
      setSession(sessionData.session);
      
      if (sessionData.session.viewSettings) {
        setViewSettings(sessionData.session.viewSettings);
      }
    }
  }, [sessionData]);
  
  // Update vehicles in scene when vehicle states change
  useEffect(() => {
    if (vehicleStates.isLoading || !sceneRef.current) return;
    
    updateVehiclesInScene(vehicleStates.vehicles);
  }, [vehicleStates]);
  
  // Update hazards in scene when hazards change
  useEffect(() => {
    if (hazards.isLoading || !sceneRef.current) return;
    
    updateHazardsInScene(hazards.hazards);
  }, [hazards]);
  
  // Update trajectories in scene when trajectories change
  useEffect(() => {
    if (trajectories.isLoading || !sceneRef.current) return;
    
    updateTrajectoriesInScene(trajectories.trajectories);
  }, [trajectories]);
  
  // Update view settings when they change
  useEffect(() => {
    if (!sessionId) return;
    
    // Update session view settings
    Meteor.call(
      'iasms.simulation.updateImmersiveSession',
      sessionId,
      { viewSettings },
      (err) => {
        if (err) {
          console.error('Error updating AR session settings:', err);
        }
      }
    );
    
    // Apply view settings to scene
    applyViewSettings();
  }, [viewSettings]);
  
  // Initialize AR view
  const initARView = () => {
    try {
      // Create scene
      const scene = new THREE.Scene();
      sceneRef.current = scene;
      
      // Create camera
      const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
      camera.position.set(0, 1.6, 0);
      cameraRef.current = camera;
      
      // Create renderer
      const renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true });
      renderer.setSize(window.innerWidth, window.innerHeight);
      renderer.setPixelRatio(window.devicePixelRatio);
      renderer.xr.enabled = true;
      rendererRef.current = renderer;
      
      // Add AR button
      document.body.appendChild(
        ARButton.createButton(renderer, {
          requiredFeatures: ['hit-test'],
          optionalFeatures: ['dom-overlay'],
          domOverlay: { root: document.getElementById('ar-overlay') }
        })
      );
      
      // Add renderer to container
      containerRef.current.appendChild(renderer.domElement);
      
      // Add lighting
      const ambientLight = new THREE.AmbientLight(0xffffff, 0.5);
      scene.add(ambientLight);
      
      const directionalLight = new THREE.DirectionalLight(0xffffff, 0.8);
      directionalLight.position.set(0, 10, 0);
      scene.add(directionalLight);
      
      // Add ground grid helper for debugging
      const gridHelper = new THREE.GridHelper(10, 10);
      scene.add(gridHelper);
      
      // Start animation loop
      renderer.setAnimationLoop(animateAR);
      
      // Handle window resize
      const handleResize = () => {
        camera.aspect = window.innerWidth / window.innerHeight;
        camera.updateProjectionMatrix();
        renderer.setSize(window.innerWidth, window.innerHeight);
      };
      
      window.addEventListener('resize', handleResize);
      
      // Return cleanup function
      return () => {
        window.removeEventListener('resize', handleResize);
        renderer.setAnimationLoop(null);
      };
    } catch (error) {
      console.error('Error initializing AR view:', error);
      setError('Error initializing AR view: ' + error.message);
    }
  };
  
  // Animation loop
  const animateAR = () => {
    if (!sceneRef.current || !rendererRef.current || !cameraRef.current) return;
    
    // Update vehicle animations
    Object.values(vehiclesRef.current).forEach(vehicle => {
      if (vehicle.mixer) {
        vehicle.mixer.update(0.01);
      }
    });
    
    // Update overlay positions to face camera
    Object.values(overlaysRef.current).forEach(overlay => {
      if (overlay.element) {
        overlay.element.lookAt(cameraRef.current.position);
      }
```
continue, restart the last document and create more wow factor
I'll create the missing simulation training module and enhance the IASMS system with comprehensive AR/VR capabilities. Let me implement this to provide an impressive and immersive experience.

```javascript
/**
 * /server/iasms/modules/IasmsSimulationTrainingModule.js
 * 
 * IASMS Simulation & Training Module - Provides simulation capabilities and training scenarios
 * with AR/VR integration for NASA's Integrated Airspace Safety Management System
 * 
 * Copyright 2025 Autonomy Association International Inc., all rights reserved 
 * Safeguard patent license from National Aeronautics and Space Administration (NASA)
 * Copyright 2025 NASA, all rights reserved
 * 
 * @fileoverview This module provides advanced simulation capabilities for training, testing, and
 * evaluation of the IASMS system, including scenario generation, playback, AR/VR integration,
 * and analytics for NASA's system-wide information management system.
 */

import { Meteor } from 'meteor/meteor';
import { EventEmitter } from 'events';
import { Random } from 'meteor/random';
import turf from '@turf/turf';
import { 
  IasmsVehicleStates, 
  IasmsHazards, 
  IasmsRisks, 
  IasmsMitigations, 
  IasmsTrajectories,
  IasmsWeatherData 
} from '../IAsmsCoreService';

/**
 * IASMS Simulation & Training Module
 * Provides simulation capabilities for training and testing with AR/VR integration
 */
export class IasmsSimulationTrainingModule extends EventEmitter {
  /**
   * Constructor for the IASMS Simulation & Training Module
   * @param {Object} options - Configuration options
   */
  constructor(options = {}) {
    super();
    
    this.options = {
      scenarioLibraryPath: options.scenarioLibraryPath || '/scenarios',
      maxSimulationDuration: options.maxSimulationDuration || 3600, // 1 hour by default
      simulationSpeedFactor: options.simulationSpeedFactor || 1.0, // Real-time by default
      maxActiveSimulations: options.maxActiveSimulations || 5,
      realTimePhysicsEngine: options.realTimePhysicsEngine || true, // Enable real-time physics for VR
      highFidelityMode: options.highFidelityMode || false, // Enhanced fidelity for training simulations
      hapticFeedbackEnabled: options.hapticFeedbackEnabled || true, // For VR controllers
      spatialAudioEnabled: options.spatialAudioEnabled || true, // 3D audio for immersive experience
      neuralInterfaceEnabled: options.neuralInterfaceEnabled || false, // For advanced BCI integration
      ...options
    };
    
    // Simulation state
    this.activeSimulations = new Map();
    this.scenarioLibrary = new Map();
    this.simulationIntervalIds = new Map();
    this.simulationCounters = new Map();
    this.simulationDataSources = new Map();
    this.simulatedVehicles = new Map();
    this.simulatedHazards = new Map();
    this.simulationAnalytics = new Map();
    this.digitalTwins = new Map();
    
    // AR/VR specific
    this.arSessions = new Map();
    this.vrSessions = new Map();
    this.vrInteractions = new Map();
    this.arOverlays = new Map();
    this.gestureMappings = new Map();
    this.voiceCommands = new Map();
    this.spatialAnchors = new Map();
    this.immersiveScenarios = new Map();
    
    // Simulation collections (for storing simulation-specific data)
    this.simulationCollections = {
      vehicleStates: new Mongo.Collection('iasmsSimulationVehicleStates'),
      hazards: new Mongo.Collection('iasmsSimulationHazards'),
      risks: new Mongo.Collection('iasmsSimulationRisks'),
      mitigations: new Mongo.Collection('iasmsSimulationMitigations'),
      trajectories: new Mongo.Collection('iasmsSimulationTrajectories'),
      weatherData: new Mongo.Collection('iasmsSimulationWeatherData'),
      metrics: new Mongo.Collection('iasmsSimulationMetrics'),
      events: new Mongo.Collection('iasmsSimulationEvents'),
      userActions: new Mongo.Collection('iasmsSimulationUserActions'),
      arObjects: new Mongo.Collection('iasmsSimulationArObjects'),
      vrEnvironments: new Mongo.Collection('iasmsSimulationVrEnvironments'),
      trainingScores: new Mongo.Collection('iasmsSimulationTrainingScores'),
      digitalTwins: new Mongo.Collection('iasmsSimulationDigitalTwins'),
      heatmaps: new Mongo.Collection('iasmsSimulationHeatmaps'),
      emergencyResponses: new Mongo.Collection('iasmsSimulationEmergencyResponses')
    };
    
    // Training assessment
    this.trainingModules = new Map();
    this.competencyFrameworks = new Map();
    this.certificationPaths = new Map();
    this.userPerformanceData = new Map();
    
    // Neural networks for predictive assistance
    this.predictionModels = {
      hazardPrediction: null,
      riskAssessment: null,
      mitigationRecommender: null,
      trafficFlow: null,
      weatherImpact: null
    };
  }

  /**
   * Initialize the Simulation & Training Module
   * @returns {Promise<boolean>} True if initialization was successful
   */
  async initialize() {
    try {
      console.log('Initializing IASMS Simulation & Training Module...');
      
      // Load scenarios from database
      await this._loadScenarioLibrary();
      
      // Register simulation data providers
      this._registerDefaultSimulationProviders();
      
      // Set up database collections indexes
      await this._setupCollectionIndexes();
      
      // Initialize AR/VR subsystems
      await this._initializeImmersiveSubsystems();
      
      // Load training modules and competency frameworks
      await this._loadTrainingFrameworks();
      
      // Initialize neural networks for simulation enhancement
      await this._initializePredictionModels();
      
      // Register Meteor methods for simulation control
      this._registerMeteorMethods();
      
      // Set up publications for reactive data
      this._setupPublications();
      
      console.log('IASMS Simulation & Training Module initialized successfully');
      return true;
    } catch (error) {
      console.error('Failed to initialize IASMS Simulation & Training Module:', error);
      throw error;
    }
  }

  /**
   * Initialize AR/VR subsystems
   * @private
   * @returns {Promise<void>}
   */
  async _initializeImmersiveSubsystems() {
    console.log('Initializing AR/VR subsystems...');
    
    // Set up gesture recognition mappings
    this._initializeGestureMappings();
    
    // Set up voice command recognition
    this._initializeVoiceCommands();
    
    // Initialize spatial anchor system for persistent AR
    this._initializeSpatialAnchors();
    
    // Load immersive environment configurations
    await this._loadImmersiveEnvironments();
    
    // Initialize haptic feedback patterns
    this._initializeHapticPatterns();
    
    // Set up shared collaborative spaces
    this._initializeCollaborativeSpaces();
    
    console.log('AR/VR subsystems initialized successfully');
  }

  /**
   * Initialize gesture mappings for VR interaction
   * @private
   */
  _initializeGestureMappings() {
    // Basic gesture controls
    this.gestureMappings.set('grab', {
      action: 'selectObject',
      handPose: 'closedFist',
      fingers: ['thumb', 'index', 'middle', 'ring', 'pinky'],
      threshold: 0.7
    });
    
    this.gestureMappings.set('point', {
      action: 'highlightObject',
      handPose: 'pointingIndex',
      fingers: ['index'],
      threshold: 0.8
    });
    
    this.gestureMappings.set('pinch', {
      action: 'scaleObject',
      handPose: 'pinch',
      fingers: ['thumb', 'index'],
      threshold: 0.75
    });
    
    this.gestureMappings.set('swipe', {
      action: 'cycleMenu',
      handPose: 'flat',
      direction: 'horizontal',
      threshold: 0.6
    });
    
    this.gestureMappings.set('thumbsUp', {
      action: 'approveAction',
      handPose: 'thumbsUp',
      fingers: ['thumb'],
      threshold: 0.85
    });
    
    // Advanced gestures for expert users
    this.gestureMappings.set('twoHandedScale', {
      action: 'zoomMap',
      handPose: ['pinch', 'pinch'],
      hands: 'both',
      threshold: 0.7
    });
    
    this.gestureMappings.set('circleMotion', {
      action: 'selectCircularRegion',
      handPose: 'pointingIndex',
      motion: 'circle',
      threshold: 0.65
    });
    
    this.gestureMappings.set('palmUp', {
      action: 'showControlPanel',
      handPose: 'palmUp',
      threshold: 0.8
    });
    
    console.log(`Initialized ${this.gestureMappings.size} gesture mappings`);
  }

  /**
   * Initialize voice commands for hands-free control
   * @private
   */
  _initializeVoiceCommands() {
    // Basic system commands
    this.voiceCommands.set('start simulation', {
      action: 'startSimulation',
      parameters: ['scenarioName'],
      phrases: ['start simulation', 'begin scenario', 'run simulation']
    });
    
    this.voiceCommands.set('pause simulation', {
      action: 'pauseSimulation',
      parameters: [],
      phrases: ['pause', 'pause simulation', 'hold simulation']
    });
    
    this.voiceCommands.set('resume simulation', {
      action: 'resumeSimulation',
      parameters: [],
      phrases: ['resume', 'continue', 'resume simulation']
    });
    
    this.voiceCommands.set('stop simulation', {
      action: 'stopSimulation',
      parameters: [],
      phrases: ['stop', 'end simulation', 'terminate simulation']
    });
    
    // Navigation commands
    this.voiceCommands.set('go to location', {
      action: 'navigateToLocation',
      parameters: ['locationName'],
      phrases: ['go to', 'navigate to', 'show me', 'take me to']
    });
    
    this.voiceCommands.set('follow vehicle', {
      action: 'followVehicle',
      parameters: ['vehicleId'],
      phrases: ['follow', 'track', 'monitor vehicle']
    });
    
    this.voiceCommands.set('first person view', {
      action: 'setFirstPersonView',
      parameters: ['vehicleId'],
      phrases: ['first person view', 'cockpit view', 'pilot view']
    });
    
    // Simulation control commands
    this.voiceCommands.set('inject hazard', {
      action: 'injectHazard',
      parameters: ['hazardType', 'location'],
      phrases: ['create hazard', 'add hazard', 'inject hazard']
    });
    
    this.voiceCommands.set('create emergency', {
      action: 'createEmergency',
      parameters: ['emergencyType', 'vehicleId'],
      phrases: ['declare emergency', 'emergency situation', 'trigger emergency']
    });
    
    this.voiceCommands.set('set weather', {
      action: 'setWeather',
      parameters: ['weatherType', 'intensity'],
      phrases: ['change weather', 'set weather', 'update weather']
    });
    
    // UI commands
    this.voiceCommands.set('show menu', {
      action: 'showMenu',
      parameters: ['menuName'],
      phrases: ['open menu', 'show menu', 'display menu']
    });
    
    this.voiceCommands.set('toggle layer', {
      action: 'toggleLayer',
      parameters: ['layerName'],
      phrases: ['show layer', 'hide layer', 'toggle layer']
    });
    
    this.voiceCommands.set('take screenshot', {
      action: 'takeScreenshot',
      parameters: [],
      phrases: ['capture screen', 'take screenshot', 'screenshot']
    });
    
    console.log(`Initialized ${this.voiceCommands.size} voice commands`);
  }

  /**
   * Initialize spatial anchors for persistent AR
   * @private
   */
  _initializeSpatialAnchors() {
    // System anchors for UI elements
    this.spatialAnchors.set('mainControlPanel', {
      type: 'system',
      position: { x: 0, y: 1.2, z: -0.5 },
      rotation: { x: 0, y: 0, z: 0 },
      scale: { x: 1, y: 1, z: 1 },
      persistent: true
    });
    
    this.spatialAnchors.set('dataDashboard', {
      type: 'system',
      position: { x: 0.5, y: 1.4, z: -0.8 },
      rotation: { x: 0, y: -15, z: 0 },
      scale: { x: 0.8, y: 0.8, z: 1 },
      persistent: true
    });
    
    this.spatialAnchors.set('alertPanel', {
      type: 'system',
      position: { x: -0.5, y: 1.5, z: -0.7 },
      rotation: { x: 0, y: 15, z: 0 },
      scale: { x: 0.6, y: 0.6, z: 1 },
      persistent: true,
      priority: 'high'
    });
    
    // Environment anchors for mapping to physical spaces
    this.spatialAnchors.set('mapTable', {
      type: 'environment',
      position: { x: 0, y: 0.8, z: -1.2 },
      rotation: { x: -45, y: 0, z: 0 },
      scale: { x: 2, y: 2, z: 1 },
      persistent: true,
      physicalDimensions: { width: 1.5, height: 0.8, depth: 1.5 }
    });
    
    this.spatialAnchors.set('operationsWall', {
      type: 'environment',
      position: { x: 0, y: 1.8, z: -3 },
      rotation: { x: 0, y: 0, z: 0 },
      scale: { x: 4, y: 2, z: 1 },
      persistent: true,
      physicalDimensions: { width: 4, height: 2, depth: 0.1 }
    });
    
    console.log(`Initialized ${this.spatialAnchors.size} spatial anchors`);
  }

  /**
   * Initialize haptic feedback patterns for VR controllers
   * @private
   */
  _initializeHapticPatterns() {
    // Define haptic feedback patterns for different events
    this.hapticPatterns = {
      // Basic feedback patterns
      select: [
        { duration: 20, intensity: 0.3 }
      ],
      
      confirm: [
        { duration: 20, intensity: 0.5 },
        { duration: 10, intensity: 0 },
        { duration: 40, intensity: 0.7 }
      ],
      
      deny: [
        { duration: 40, intensity: 0.7 },
        { duration: 10, intensity: 0 },
        { duration: 20, intensity: 0.5 }
      ],
      
      // Event feedback patterns
      collision: [
        { duration: 100, intensity: 1.0 }
      ],
      
      hazardWarning: [
        { duration: 20, intensity: 0.8 },
        { duration: 20, intensity: 0 },
        { duration: 20, intensity: 0.8 },
        { duration: 20, intensity: 0 },
        { duration: 20, intensity: 0.8 }
      ],
      
      emergencyAlert: [
        { duration: 100, intensity: 1.0 },
        { duration: 50, intensity: 0 },
        { duration: 100, intensity: 1.0 },
        { duration: 50, intensity: 0 },
        { duration: 100, intensity: 1.0 }
      ],
      
      // Interactive patterns
      grab: [
        { duration: 10, intensity: 0.2 },
        { duration: 10, intensity: 0.3 },
        { duration: 10, intensity: 0.4 },
        { duration: 10, intensity: 0.5 }
      ],
      
      release: [
        { duration: 10, intensity: 0.5 },
        { duration: 10, intensity: 0.4 },
        { duration: 10, intensity: 0.3 },
        { duration: 10, intensity: 0.2 }
      ],
      
      boundary: [
        { duration: 10, intensity: 0.1 },
        { duration: 10, intensity: 0.2 },
        { duration: 10, intensity: 0.3 },
        { duration: 10, intensity: 0.2 },
        { duration: 10, intensity: 0.1 }
      ]
    };
    
    console.log('Initialized haptic feedback patterns');
  }

  /**
   * Initialize collaborative spaces for multi-user VR
   * @private
   */
  _initializeCollaborativeSpaces() {
    // Initialize collaborative spaces for multi-user training
    this.collaborativeSpaces = {
      // Main operations center
      operationsCenter: {
        id: 'ops-center',
        name: 'Operations Center',
        capacity: 10,
        stations: [
          { id: 'commander', name: 'Commander Station', role: 'commander', position: { x: 0, y: 0, z: 0 } },
          { id: 'traffic-mgr', name: 'Traffic Manager', role: 'traffic', position: { x: -1.5, y: 0, z: 0 } },
          { id: 'hazard-mgr', name: 'Hazard Manager', role: 'hazard', position: { x: 1.5, y: 0, z: 0 } },
          { id: 'emergency-mgr', name: 'Emergency Manager', role: 'emergency', position: { x: -1.5, y: 0, z: 1.5 } },
          { id: 'weather-mgr', name: 'Weather Manager', role: 'weather', position: { x: 1.5, y: 0, z: 1.5 } }
        ],
        sharedElements: [
          { id: 'main-map', name: 'Main Map Table', type: 'map', position: { x: 0, y: 0.8, z: -1 } },
          { id: 'ops-dashboard', name: 'Operations Dashboard', type: 'dashboard', position: { x: 0, y: 1.7, z: -3 } },
          { id: 'comms-panel', name: 'Communications Panel', type: 'panel', position: { x: -2, y: 1.5, z: -2 } }
        ],
        audioZones: [
          { id: 'global', name: 'Global Comms', range: null },
          { id: 'commander', name: 'Commander Channel', range: 2 },
          { id: 'emergency', name: 'Emergency Channel', range: 3 }
        ]
      },
      
      // Training classroom
      trainingRoom: {
        id: 'training-room',
        name: 'Training Classroom',
        capacity: 20,
        stations: [
          { id: 'instructor', name: 'Instructor Station', role: 'instructor', position: { x: 0, y: 0, z: -3 } },
          // Student stations are created dynamically
        ],
        sharedElements: [
          { id: 'presentation', name: 'Presentation Screen', type: 'screen', position: { x: 0, y: 2, z: -4 } },
          { id: 'scenario-controls', name: 'Scenario Controls', type: 'controls', position: { x: -2, y: 1.2, z: -3 } }
        ],
        audioZones: [
          { id: 'classroom', name: 'Classroom Audio', range: null },
          { id: 'breakout-1', name: 'Breakout Group 1', range: 3 },
          { id: 'breakout-2', name: 'Breakout Group 2', range: 3 }
        ]
      },
      
      // Emergency simulation arena
      emergencyArena: {
        id: 'emergency-arena',
        name: 'Emergency Simulation Arena',
        capacity: 15,
        stations: [
          { id: 'coordinator', name: 'Emergency Coordinator', role: 'coordinator', position: { x: 0, y: 0, z: 0 } },
          { id: 'rescue-1', name: 'Rescue Team 1', role: 'rescue', position: { x: -3, y: 0, z: 3 } },
          { id: 'rescue-2', name: 'Rescue Team 2', role: 'rescue', position: { x: 3, y: 0, z: 3 } },
          { id: 'medical', name: 'Medical Response', role: 'medical', position: { x: 0, y: 0, z: 5 } }
        ],
        sharedElements: [
          { id: 'emergency-map', name: 'Emergency Map', type: 'map', position: { x: 0, y: 1, z: -2 } },
          { id: 'casualty-tracker', name: 'Casualty Tracker', type: 'tracker', position: { x: -2, y: 1.5, z: -1 } },
          { id: 'resource-manager', name: 'Resource Manager', type: 'manager', position: { x: 2, y: 1.5, z: -1 } }
        ],
        audioZones: [
          { id: 'command', name: 'Command Channel', range: null },
          { id: 'team-1', name: 'Team 1 Channel', range: 5 },
          { id: 'team-2', name: 'Team 2 Channel', range: 5 },
          { id: 'medical', name: 'Medical Channel', range: 5 }
        ],
        simulatedElements: [
          { id: 'fire', name: 'Fire Simulation', type: 'hazard', position: { x: 0, y: 0, z: 10 } },
          { id: 'smoke', name: 'Smoke Simulation', type: 'effect', position: { x: 0, y: 2, z: 10 } },
          { id: 'casualties', name: 'Casualty Simulation', type: 'npcs', count: 5, area: { center: { x: 0, y: 0, z: 10 }, radius: 10 } }
        ]
      }
    };
    
    console.log('Initialized collaborative VR spaces');
  }

  /**
   * Load immersive environments for AR/VR training
   * @private
   * @returns {Promise<void>}
   */
  async _loadImmersiveEnvironments() {
    try {
      // Check if environments are already in the database
      const count = await this.simulationCollections.vrEnvironments.find().count();
      
      if (count === 0) {
        // Create default environments
        const defaultEnvironments = this._getDefaultImmersiveEnvironments();
        
        for (const env of defaultEnvironments) {
          await this.simulationCollections.vrEnvironments.insert(env);
          this.immersiveScenarios.set(env.id, env);
        }
        
        console.log(`Created ${defaultEnvironments.length} default immersive environments`);
      } else {
        // Load environments from database
        const environments = await this.simulationCollections.vrEnvironments.find().fetch();
        
        for (const env of environments) {
          this.immersiveScenarios.set(env.id, env);
        }
        
        console.log(`Loaded ${environments.length} immersive environments from database`);
      }
    } catch (error) {
      console.error('Error loading immersive environments:', error);
      throw error;
    }
  }

  /**
   * Get default immersive environments
   * @private
   * @returns {Array<Object>} Default immersive environments
   */
  _getDefaultImmersiveEnvironments() {
    return [
      {
        id: 'urban-airspace',
        name: 'Urban Airspace Operations',
        type: 'vr',
        description: 'Simulated urban environment with high-density air traffic and multiple vertiports',
        terrainType: 'urban',
        timeOfDay: 'day',
        weatherEnabled: true,
        defaultWeather: 'clear',
        trafficDensity: 'high',
        landmarks: [
          { id: 'downtown', name: 'Downtown District', position: { x: 0, y: 0, z: 0 } },
          { id: 'central-park', name: 'Central Park', position: { x: 500, y: 0, z: 300 } },
          { id: 'hospital', name: 'City Hospital', position: { x: -300, y: 0, z: 400 } },
          { id: 'stadium', name: 'Sports Stadium', position: { x: 800, y: 0, z: -200 } }
        ],
        vertiports: [
          { id: 'vp-downtown', name: 'Downtown Vertiport', position: { x: 100, y: 150, z: 50 }, size: 'large', landingPads: 4 },
          { id: 'vp-medical', name: 'Hospital Vertiport', position: { x: -300, y: 120, z: 450 }, size: 'medium', landingPads: 2 },
          { id: 'vp-park', name: 'Park Vertiport', position: { x: 550, y: 100, z: 350 }, size: 'small', landingPads: 1 },
          { id: 'vp-stadium', name: 'Stadium Vertiport', position: { x: 850, y: 130, z: -150 }, size: 'medium', landingPads: 3 }
        ],
        obstacles: [
          { type: 'buildings', count: 200, heightRange: [50, 300], distribution: 'clustered' },
          { type: 'antennas', count: 30, heightRange: [200, 350], distribution: 'sparse' },
          { type: 'construction-cranes', count: 5, heightRange: [150, 250], distribution: 'sparse' }
        ],
        scenarios: [
          'high-density-operations',
          'weather-diversion',
          'vertiport-emergency',
          'non-participant-encounter'
        ],
        assets: {
          textures: ['urban_textures.glb'],
          models: ['city_buildings.glb', 'vertiports.glb', 'urban_vehicles.glb'],
          sounds: ['urban_ambience.mp3', 'vertiport_operations.mp3', 'traffic_sounds.mp3']
        }
      },
      {
        id: 'emergency-response',
        name: 'Emergency Response Training',
        type: 'vr',
        description: 'Emergency scenario training environment for practicing critical response procedures',
        terrainType: 'mixed',
        timeOfDay: 'variable',
        weatherEnabled: true,
        defaultWeather: 'stormy',
        trafficDensity: 'medium',
        landmarks: [
          { id: 'command-center', name: 'Emergency Command Center', position: { x: 0, y: 0, z: 0 } },
          { id: 'disaster-zone', name: 'Disaster Zone', position: { x: 1000, y: 0, z: 1000 } },
          { id: 'evacuation-zone', name: 'Evacuation Zone', position: { x: -800, y: 0, z: 500 } },
          { id: 'medical-center', name: 'Field Medical Center', position: { x: 300, y: 0, z: 800 } }
        ],
        vertiports: [
          { id: 'vp-command', name: 'Command Center Vertiport', position: { x: 50, y: 100, z: 50 }, size: 'large', landingPads: 6 },
          { id: 'vp-disaster', name: 'Disaster Zone LZ', position: { x: 1000, y: 80, z: 900 }, size: 'medium', landingPads: 4 },
          { id: 'vp-medical', name: 'Medical Evacuation Point', position: { x: 300, y: 90, z: 750 }, size: 'medium', landingPads: 3 },
          { id: 'vp-temp', name: 'Temporary LZ', position: { x: 600, y: 70, z: 600 }, size: 'small', landingPads: 1 }
        ],
        emergencyElements: [
          { type: 'fire', areas: 3, intensity: 'high', spreading: true },
          { type: 'smoke', areas: 5, intensity: 'variable', spreading: true },
          { type: 'debris', areas: 4, density: 'medium', hazardLevel: 'high' },
          { type: 'casualties', count: 25, distribution: 'clustered', mobility: 'variable' }
        ],
        scenarios: [
          'mass-casualty-event',
          'natural-disaster-response',
          'hazardous-material-incident',
          'multi-agency-coordination'
        ],
        assets: {
          textures: ['emergency_textures.glb'],
          models: ['emergency_vehicles.glb', 'disaster_scene.glb', 'medical_equipment.glb'],
          sounds: ['emergency_sirens.mp3', 'helicopter_operations.mp3', 'emergency_radio.mp3'],
          effects: ['fire_system.vfx', 'smoke_system.vfx', 'weather_system.vfx']
        }
      },
      {
        id: 'ar-operations-overlay',
        name: 'AR Operations Overlay',
        type: 'ar',
        description: 'Augmented reality overlay for real-world operations center',
        overlayType: 'persistent',
        interfaceElements: [
          { id: 'main-display', name: 'Main Operations Display', type: 'wall', dimensions: { width: 4, height: 2 } },
          { id: 'operator-console', name: 'Operator Console Overlay', type: 'desk', dimensions: { width: 1.2, height: 0.6 } },
          { id: 'map-table', name: '3D Map Table', type: 'table', dimensions: { width: 1.5, height: 0.8, depth: 1.5 } },
          { id: 'alert-panel', name: 'Alert Notification Panel', type: 'floating', dimensions: { width: 0.4, height: 0.6 } }
        ],
        dataVisualizations: [
          { id: 'traffic-flow', name: 'Traffic Flow Visualization', type: '3d-flow', updateRate: 'realtime' },
          { id: 'risk-heatmap', name: 'Risk Assessment Heatmap', type: 'heatmap', updateRate: '5s' },
          { id: 'weather-overlay', name: 'Weather Impact Overlay', type: 'layer', updateRate: '60s' },
          { id: 'vehicle-status', name: 'Vehicle Status Indicators', type: 'markers', updateRate: '1s' }
        ],
        interactionModes: [
          { id: 'gesture', name: 'Gesture Control', enabled: true },
          { id: 'voice', name: 'Voice Command', enabled: true },
          { id: 'gaze', name: 'Gaze Selection', enabled: true },
          { id: 'touch', name: 'Touch Interaction', enabled: true }
        ],
        scenarios: [
          'real-time-operations',
          'emergency-management',
          'collaborative-planning',
          'handoff-procedures'
        ],
        assets: {
          hologramModels: ['ar_interface_elements.glb', 'data_visualization.glb'],
          icons: ['ar_icons.png'],
          sounds: ['notification_sounds.mp3', 'interface_feedback.mp3']
        }
      }
    ];
  }

  /**
   * Load training frameworks and competency models
   * @private
   * @returns {Promise<void>}
   */
  async _loadTrainingFrameworks() {
    try {
      // Load training modules
      this.trainingModules.set('basic-operations', {
        id: 'basic-operations',
        name: 'Basic IASMS Operations',
        description: 'Introduction to IASMS basic operations and monitoring',
        difficulty: 'beginner',
        duration: 120, // minutes
        objectives: [
          'Understand the IASMS interface and core components',
          'Monitor vehicle states and system status',
          'Identify and interpret alerts and notifications',
          'Perform basic system interactions'
        ],
        competencies: [
          'system-navigation',
          'situation-awareness',
          'basic-monitoring',
          'alert-response'
        ],
        scenarios: [
          'basic-operations',
          'normal-conditions-monitoring'
        ],
        assessmentMethods: [
          'simulation-performance',
          'knowledge-check',
          'time-to-completion'
        ]
      });
      
      this.trainingModules.set('hazard-management', {
        id: 'hazard-management',
        name: 'Hazard Management and Mitigation',
        description: 'Training for identifying, assessing, and mitigating hazards in the airspace',
        difficulty: 'intermediate',
        duration: 180, // minutes
        objectives: [
          'Identify different types of hazards in the airspace',
          'Assess hazard severity and impact',
          'Select appropriate mitigation strategies',
          'Implement and monitor mitigation effectiveness'
        ],
        competencies: [
          'hazard-identification',
          'risk-assessment',
          'mitigation-selection',
          'mitigation-implementation'
        ],
        scenarios: [
          'weather-hazards',
          'airspace-conflicts',
          'ground-infrastructure-issues',
          'multi-hazard-scenarios'
        ],
        assessmentMethods: [
          'simulation-performance',
          'decision-quality',
          'response-time',
          'situational-judgment-test'
        ]
      });
      
      this.trainingModules.set('emergency-response', {
        id: 'emergency-response',
        name: 'Emergency Response and Crisis Management',
        description: 'Advanced training for emergency situations and crisis management',
        difficulty: 'advanced',
        duration: 240, // minutes
        objectives: [
          'Recognize and classify emergency situations',
          'Implement appropriate emergency procedures',
          'Coordinate multi-agency emergency response',
          'Manage post-emergency recovery operations'
        ],
        competencies: [
          'emergency-identification',
          'procedure-execution',
          'inter-agency-coordination',
          'stress-management',
          'decision-making-under-pressure'
        ],
        scenarios: [
          'vehicle-emergency',
          'vertiport-incident',
          'natural-disaster',
          'security-threat',
          'mass-casualty-event'
        ],
        assessmentMethods: [
          'simulation-performance',
          'decision-quality',
          'coordination-quality',
          'time-critical-response',
          'stress-resilience'
        ]
      });
      
      // Load competency frameworks
      this.competencyFrameworks.set('iasms-operations', {
        id: 'iasms-operations',
        name: 'IASMS Operations Competency Framework',
        description: 'Core competencies for IASMS operations personnel',
        competencies: [
          {
            id: 'system-navigation',
            name: 'System Navigation',
            description: 'Ability to navigate the IASMS interface efficiently',
            levels: [
              { level: 1, description: 'Basic familiarity with main screens' },
              { level: 2, description: 'Efficient navigation between functions' },
              { level: 3, description: 'Advanced interface mastery and shortcuts' }
            ],
            assessmentMethods: [
              'task-completion-time',
              'navigation-efficiency-score'
            ]
          },
          {
            id: 'situation-awareness',
            name: 'Situational Awareness',
            description: 'Ability to maintain awareness of the current airspace situation',
            levels: [
              { level: 1, description: 'Basic awareness of primary elements' },
              { level: 2, description: 'Comprehensive awareness with predictions' },
              { level: 3, description: 'Strategic awareness with system-wide understanding' }
            ],
            assessmentMethods: [
              'situation-awareness-probes',
              'anomaly-detection-rate'
            ]
          },
          {
            id: 'risk-assessment',
            name: 'Risk Assessment',
            description: 'Ability to assess risks in the airspace system',
            levels: [
              { level: 1, description: 'Recognition of obvious risks' },
              { level: 2, description: 'Comprehensive risk evaluation' },
              { level: 3, description: 'Advanced predictive risk assessment' }
            ],
            assessmentMethods: [
              'risk-assessment-accuracy',
              'risk-prioritization-quality'
            ]
          }
          // Additional competencies would be defined here
        ]
      });
      
      // Load certification paths
      this.certificationPaths.set('iasms-operator', {
        id: 'iasms-operator',
        name: 'IASMS Operator Certification',
        description: 'Certification path for IASMS operators',
        levels: [
          {
            level: 'Associate',
            requiredModules: ['basic-operations'],
            requiredCompetencies: {
              'system-navigation': 1,
              'situation-awareness': 1,
              'basic-monitoring': 1
            },
            assessmentThreshold: 0.7
          },
          {
            level: 'Operator',
            requiredModules: ['basic-operations', 'hazard-management'],
            requiredCompetencies: {
              'system-navigation': 2,
              'situation-awareness': 2,
              'risk-assessment': 1,
              'mitigation-selection': 1
            },
            assessmentThreshold: 0.8
          },
          {
            level: 'Senior Operator',
            requiredModules: ['basic-operations', 'hazard-management', 'emergency-response'],
            requiredCompetencies: {
              'system-navigation': 3,
              'situation-awareness': 2,
              'risk-assessment': 2,
              'mitigation-selection': 2,
              'emergency-identification': 1
            },
            assessmentThreshold: 0.85
          },
          {
            level: 'Specialist',
            requiredModules: ['basic-operations', 'hazard-management', 'emergency-response'],
            requiredCompetencies: {
              'system-navigation': 3,
              'situation-awareness': 3,
              'risk-assessment': 3,
              'mitigation-selection': 3,
              'emergency-identification': 2,
              'procedure-execution': 2
            },
            assessmentThreshold: 0.9
          }
        ]
      });
      
      console.log(`Loaded ${this.trainingModules.size} training modules`);
      console.log(`Loaded ${this.competencyFrameworks.size} competency frameworks`);
      console.log(`Loaded ${this.certificationPaths.size} certification paths`);
    } catch (error) {
      console.error('Error loading training frameworks:', error);
      throw error;
    }
  }

  /**
   * Initialize prediction models for simulation enhancement
   * @private
   * @returns {Promise<void>}
   */
  async _initializePredictionModels() {
    try {
      // In a real implementation, these would load actual ML models
      // Here we're setting up placeholder functions

      // Hazard prediction model - predicts potential hazards based on current conditions
      this.predictionModels.hazardPrediction = {
        predict: (currentState, timeHorizon) => {
          // Placeholder for ML prediction
          return {
            predictedHazards: [],
            confidence: 0.85,
            timeHorizon
          };
        },
        update: (trainingData) => {
          // Model updating functionality
          console.log(`Updating hazard prediction model with ${trainingData.length} samples`);
          return true;
        }
      };

      // Risk assessment model - assesses risks based on vehicle states and hazards
      this.predictionModels.riskAssessment = {
        predict: (vehicleState, hazards) => {
          // Placeholder for ML prediction
          return {
            riskLevel: 0.5,
            riskFactors: {},
            confidence: 0.8
          };
        },
        update: (trainingData) => {
          // Model updating functionality
          console.log(`Updating risk assessment model with ${trainingData.length} samples`);
          return true;
        }
      };

      // Mitigation recommender - recommends mitigations based on risks
      this.predictionModels.mitigationRecommender = {
        predict: (risk, vehicleState) => {
          // Placeholder for ML prediction
          return {
            recommendedMitigations: [],
            effectiveness: 0.75,
            confidence: 0.7
          };
        },
        update: (trainingData) => {
          // Model updating functionality
          console.log(`Updating mitigation recommender model with ${trainingData.length} samples`);
          return true;
        }
      };

      console.log('Initialized prediction models for simulation enhancement');
    } catch (error) {
      console.error('Error initializing prediction models:', error);
      // Continue without prediction models
      console.log('Continuing without prediction models');
    }
  }

  /**
   * Create a new simulation based on a scenario
   * @param {Object} options - Simulation options
   * @param {string} options.scenarioId - ID of the scenario to simulate
   * @param {string} options.userId - ID of the user running the simulation
   * @param {Object} options.parameters - Custom parameters for the simulation
   * @param {number} options.speedFactor - Simulation speed factor (1.0 = real-time)
   * @param {boolean} options.recordMetrics - Whether to record metrics during simulation
   * @param {boolean} options.immersiveMode - Whether to enable immersive AR/VR mode
   * @returns {Promise<Object>} Simulation result with simulationId
   */
  async createSimulation(options) {
    try {
      // Validate options
      if (!options.scenarioId) {
        throw new Error('Scenario ID is required');
      }
      
      // Check if we're at the maximum number of active simulations
      if (this.activeSimulations.size >= this.options.maxActiveSimulations) {
        throw new Error(`Maximum number of active simulations (${this.options.maxActiveSimulations}) reached`);
      }
      
      // Get scenario
      const scenario = this.scenarioLibrary.get(options.scenarioId);
      if (!scenario) {
        throw new Error(`Scenario ${options.scenarioId} not found`);
      }
      
      // Create simulation ID
      const simulationId = `sim-${Random.id()}`;
      
      // Create simulation object
      const simulation = {
        simulationId,
        scenarioId: options.scenarioId,
        userId: options.userId,
        status: 'INITIALIZED',
        parameters: options.parameters || {},
        speedFactor: options.speedFactor || this.options.simulationSpeedFactor,
        recordMetrics: options.recordMetrics !== undefined ? options.recordMetrics : true,
        immersiveMode: options.immersiveMode || false,
        physicsEnabled: options.physicsEnabled || this.options.realTimePhysicsEngine,
        highFidelityMode: options.highFidelityMode || this.options.highFidelityMode,
        startTime: null,
        currentTime: null,
        endTime: null,
        createdAt: new Date(),
        metrics: {
          vehicleCount: 0,
          hazardCount: 0,
          riskCount: 0,
          mitigationCount: 0,
          collisionCount: 0,
          totalEvents: 0,
          userActions: 0,
          performanceScore: 0
        }
      };
      
      // Add simulation to active simulations
      this.activeSimulations.set(simulationId, simulation);
      
      // Initialize simulation counters
      this.simulationCounters.set(simulationId, {
        step: 0,
        time: 0,
        entities: {
          vehicles: 0,
          hazards: 0,
          risks: 0,
          mitigations: 0,
          events: 0,
          userActions: 0
        }
      });
      
      // Set up simulation-specific collections for isolation
      await this._setupSimulationCollections(simulationId);
      
      // Initialize simulation data sources
      await this._initializeSimulationDataSources(simulationId, scenario);
      
      // Initialize digital twins if enabled
      if (options.enableDigitalTwins) {
        await this._initializeDigitalTwins(simulationId, scenario);
      }
      
      // Load initial state
      await this._loadScenarioInitialState(simulationId, scenario);
      
      // Set up immersive environment if requested
      if (options.immersiveMode) {
        await this._setupImmersiveEnvironment(simulationId, options.immersiveEnvironmentId || 'urban-airspace');
      }
      
      // Return simulation details
      return {
        success: true,
        simulationId,
        scenario: {
          id: scenario.scenarioId,
          name: scenario.name,
          description: scenario.description
        },
        status: 'INITIALIZED',
        immersiveReady: options.immersiveMode
      };
    } catch (error) {
      console.error('Error creating simulation:', error);
      return {
        success: false,
        error: error.message
      };
    }
  }

  /**
   * Set up immersive environment for a simulation
   * @param {string} simulationId - Simulation ID
   * @param {string} environmentId - Immersive environment ID
   * @private
   * @returns {Promise<void>}
   */
  async _setupImmersiveEnvironment(simulationId, environmentId) {
    try {
      // Get environment configuration
      const environment = this.immersiveScenarios.get(environmentId);
      if (!environment) {
        throw new Error(`Immersive environment ${environmentId} not found`);
      }
      
      console.log(`Setting up immersive environment ${environmentId} for simulation ${simulationId}`);
      
      // Initialize AR/VR elements based on environment type
      if (environment.type === 'vr') {
        // Create VR world for this simulation
        await this.simulationCollections.vrEnvironments.insert({
          simulationId,
          environmentId,
          status: 'READY',
          createdAt: new Date(),
          activeUsers: 0,
          worldState: {
            terrain: environment.terrainType,
            timeOfDay: environment.timeOfDay,
            weather: environment.defaultWeather,
            landmarks: environment.landmarks,
            vertiports: environment.vertiports,
            obstacles: environment.obstacles
          },
          renderSettings: {
            quality: 'high',
            drawDistance: 5000,
            shadowsEnabled: true,
            reflectionsEnabled: true,
            particleEffectsLevel: 'high',
            soundEnabled: true,
            spatialAudioEnabled: true
          }
        });
      } else if (environment.type === 'ar') {
        // Create AR overlay configuration for this simulation
        await this.simulationCollections.arObjects.insert({
          simulationId,
          environmentId,
          status: 'READY',
          createdAt: new Date(),
          activeUsers: 0,
          overlayElements: environment.interfaceElements,
          visualizations: environment.dataVisualizations,
          interactionModes: environment.interactionModes,
          anchors: Array.from(this.spatialAnchors.values())
        });
      }
      
      // Update simulation with immersive information
      const simulation = this.activeSimulations.get(simulationId);
      if (simulation) {
        simulation.immersiveEnvironmentId = environmentId;
        simulation.immersiveType = environment.type;
        this.activeSimulations.set(simulationId, simulation);
      }
      
      console.log(`Immersive environment setup complete for simulation ${simulationId}`);
    } catch (error) {
      console.error(`Error setting up immersive environment for simulation ${simulationId}:`, error);
      throw error;
    }
  }

  /**
   * Initialize digital twins for a simulation
   * @param {string} simulationId - Simulation ID
   * @param {Object} scenario - Scenario object
   * @private
   * @returns {Promise<void>}
   */
  async _initializeDigitalTwins(simulationId, scenario) {
    try {
      console.log(`Initializing digital twins for simulation ${simulationId}`);
      
      // Set up digital twins for various components
      
      // 1. Vertiport Digital Twins
      if (scenario.initialState.vertiports) {
        for (const vertiport of scenario.initialState.vertiports) {
          const digitalTwin = {
            simulationId,
            twinId: `vp-twin-${vertiport.vertiportId}`,
            twinType: 'vertiport',
            entityId: vertiport.vertiportId,
            status: 'ACTIVE',
            physicalState: {
              location: vertiport.location,
              infrastructure: {
                landingPads: vertiport.landingZones || 3,
                terminals: vertiport.terminals || 1,
                chargingStations: vertiport.chargingStations || 2
              },
              weatherConditions: {
                wind: { speed: 0, direction: 0 },
                visibility: 10000,
                precipitation: 0
              }
            },
            operationalState: {
              status: vertiport.status || 'OPERATIONAL',
              capacity: {
                current: 0,
                maximum: vertiport.landingZones || 3
              },
              queueLength: 0,
              estimatedWaitTime: 0,
              landingZones: Array.from({ length: vertiport.landingZones || 3 }, (_, i) => ({
                id: `lz-${i+1}`,
                status: 'AVAILABLE',
                nextAvailableTime: null
              }))
            },
            simulationParams: {
              faultInjectionEnabled: false,
              weatherImpactEnabled: true,
              operationalDelaysProbability: 0.1
            },
            createdAt: new Date()
          };
          
          await this.simulationCollections.digitalTwins.insert(digitalTwin);
          this.digitalTwins.set(digitalTwin.twinId, digitalTwin);
        }
      }
      
      // 2. Vehicle Digital Twins
      if (scenario.initialState.vehicles) {
        for (const vehicle of scenario.initialState.vehicles) {
          const digitalTwin = {
            simulationId,
            twinId: `vehicle-twin-${vehicle.vehicleId}`,
            twinType: 'vehicle',
            entityId: vehicle.vehicleId,
            status: 'ACTIVE',
            physicalState: {
              position: vehicle.position,
              altitude: vehicle.altitude,
              heading: vehicle.heading,
              speed: vehicle.speed,
              batteryLevel: vehicle.batteryLevel || 100,
              payload: vehicle.payload || 0
            },
            operationalState: {
              status: vehicle.status || 'ACTIVE',
              operationalMode: vehicle.operationalMode || 'NORMAL',
              communicationStatus: 'NOMINAL',
              navigationStatus: 'NOMINAL',
              propulsionStatus: 'NOMINAL',
              missionPhase: vehicle.missionPhase || 'CRUISE'
            },
            simulationParams: {
              faultInjectionEnabled: false,
              batteryDrainRate: 0.05, // % per minute
              communicationReliability: 0.99,
              navigationAccuracy: 0.95
            },
            createdAt: new Date()
          };
          
          await this.simulationCollections.digitalTwins.insert(digitalTwin);
          this.digitalTwins.set(digitalTwin.twinId, digitalTwin);
        }
      }
      
      // 3. Airspace Digital Twin
      const airspaceTwin = {
        simulationId,
        twinId: `airspace-twin-${simulationId}`,
        twinType: 'airspace',
        entityId: 'global-airspace',
        status: 'ACTIVE',
        physicalState: {
          boundaries: scenario.boundaries || {
            type: 'Polygon',
            coordinates: [[
              [-122.5, 37.7],
              [-122.5, 37.9],
              [-122.3, 37.9],
              [-122.3, 37.7],
              [-122.5, 37.7]
            ]]
          },
          weather: {
            conditions: scenario.initialState.weather?.conditions || {
              wind: { speed: 5, direction: 270 },
              visibility: 10000,
              precipitation: 0,
              temperature: 22
            },
            forecastUpdates: []
          }
        },
        operationalState: {
          status: 'NORMAL',
          restrictions: [],
          trafficDensity: 'MEDIUM',
          conflicts: [],
          hazards: []
        },
        simulationParams: {
          weatherDynamicsEnabled: true,
          trafficComplexityLevel: 0.6,
          hazardInjectionRate: 0.01
        },
        createdAt: new Date()
      };
      
      await this.simulationCollections.digitalTwins.insert(airspaceTwin);
      this.digitalTwins.set(airspaceTwin.twinId, airspaceTwin);
      
      console.log(`Digital twins initialized for simulation ${simulationId}`);
    } catch (error) {
      console.error(`Error initializing digital twins for simulation ${simulationId}:`, error);
      throw error;
    }
  }

  /**
   * Update digital twins based on simulation state
   * @param {string} simulationId - Simulation ID
   * @private
   */
  _updateDigitalTwins(simulationId) {
    try {
      const simulation = this.activeSimulations.get(simulationId);
      if (!simulation) return;
      
      // Get current simulation time
      const simulationTime = this.simulationCounters.get(simulationId)?.time || 0;
      
      // Update each digital twin
      for (const [twinId, twin] of this.digitalTwins.entries()) {
        if (twin.simulationId !== simulationId) continue;
        
        switch (twin.twinType) {
          case 'vehicle':
            this._updateVehicleTwin(twin, simulationTime);
            break;
          case 'vertiport':
            this._updateVertiportTwin(twin, simulationTime);
            break;
          case 'airspace':
            this._updateAirspaceTwin(twin, simulationTime);
            break;
        }
      }
    } catch (error) {
      console.error(`Error updating digital twins for simulation ${simulationId}:`, error);
    }
  }

  /**
   * Update vehicle digital twin
   * @param {Object} twin - Vehicle digital twin
   * @param {number} simulationTime - Current simulation time
   * @private
   */
  _updateVehicleTwin(twin, simulationTime) {
    try {
      // Update battery level based on drain rate
      const timeStep = 1 / 60; // 1 second in minutes
      const batteryDrain = twin.simulationParams.batteryDrainRate * timeStep;
      twin.physicalState.batteryLevel = Math.max(0, twin.physicalState.batteryLevel - batteryDrain);
      
      // Check for battery-related events
      if (twin.physicalState.batteryLevel < 20 && twin.operationalState.status === 'ACTIVE') {
        twin.operationalState.status = 'LOW_BATTERY';
        
        // Log event
        this.simulationCollections.events.insert({
          simulationId: twin.simulationId,
          eventType: 'VEHICLE_LOW_BATTERY',
          timestamp: new Date(),
          data: {
            vehicleId: twin.entityId,
            batteryLevel: twin.physicalState.batteryLevel,
            estimatedRemainingTime: twin.physicalState.batteryLevel / twin.simulationParams.batteryDrainRate
          }
        });
      }
      
      // Check for communication issues
      if (Math.random() > twin.simulationParams.communicationReliability) {
        twin.operationalState.communicationStatus = 'DEGRADED';
        
        // Log event
        this.simulationCollections.events.insert({
          simulationId: twin.simulationId,
          eventType: 'VEHICLE_COMM_DEGRADED',
          timestamp: new Date(),
          data: {
            vehicleId: twin.entityId,
            previousStatus: 'NOMINAL',
            currentStatus: 'DEGRADED'
          }
        });
      } else if (twin.operationalState.communicationStatus === 'DEGRADED') {
        // Restore communication
        twin.operationalState.communicationStatus = 'NOMINAL';
      }
      
      // Update twin in database
      this.simulationCollections.digitalTwins.update(
        { twinId: twin.twinId },
        { $set: {
            'physicalState.batteryLevel': twin.physicalState.batteryLevel,
            'operationalState.status': twin.operationalState.status,
            'operationalState.communicationStatus': twin.operationalState.communicationStatus
          }
        }
      );
    } catch (error) {
      console.error(`Error updating vehicle twin ${twin.twinId}:`, error);
    }
  }

  /**
   * Update vertiport digital twin
   * @param {Object} twin - Vertiport digital twin
   * @param {number} simulationTime - Current simulation time
   * @private
   */
  _updateVertiportTwin(twin, simulationTime) {
    try {
      // Update landing zone availability
      for (const zone of twin.operationalState.landingZones) {
        if (zone.status === 'OCCUPIED' && zone.nextAvailableTime) {
          const availableTime = new Date(zone.nextAvailableTime).getTime();
          if (Date.now() >= availableTime) {
            zone.status = 'AVAILABLE';
            zone.nextAvailableTime = null;
            
            // Log event
            this.simulationCollections.events.insert({
              simulationId: twin.simulationId,
              eventType: 'LANDING_ZONE_AVAILABLE',
              timestamp: new Date(),
              data: {
                vertiportId: twin.entityId,
                zoneId: zone.id
              }
            });
          }
        }
      }
      
      // Update vertiport capacity
      const availableZones = twin.operationalState.landingZones.filter(z => z.status === 'AVAILABLE').length;
      twin.operationalState.capacity.current = availableZones;
      
      // Check for operational delays
      if (Math.random() < twin.simulationParams.operationalDelaysProbability) {
        // Select a random available landing zone to temporarily restrict
        const availableZones = twin.operationalState.landingZones.filter(z => z.status === 'AVAILABLE');
        if (availableZones.length > 0) {
          const randomZone = availableZones[Math.floor(Math.random() * availableZones.length)];
          randomZone.status = 'MAINTENANCE';
          randomZone.nextAvailableTime = new Date(Date.now() + 5 * 60000); // 5 minutes
          
          // Log event
          this.simulationCollections.events.insert({
            simulationId: twin.simulationId,
            eventType: 'LANDING_ZONE_MAINTENANCE',
            timestamp: new Date(),
            data: {
              vertiportId: twin.entityId,
              zoneId: randomZone.id,
              expectedDuration: 5, // minutes
              reason: 'Unscheduled maintenance'
            }
          });
        }
      }
      
      // Update twin in database
      this.simulationCollections.digitalTwins.update(
        { twinId: twin.twinId },
        { $set: {
            'operationalState.landingZones': twin.operationalState.landingZones,
            'operationalState.capacity.current': twin.operationalState.capacity.current
          }
        }
      );
    } catch (error) {
      console.error(`Error updating vertiport twin ${twin.twinId}:`, error);
    }
  }

  /**
   * Update airspace digital twin
   * @param {Object} twin - Airspace digital twin
   * @param {number} simulationTime - Current simulation time
   * @private
   */
  _updateAirspaceTwin(twin, simulationTime) {
    try {
      // Update weather conditions if enabled
      if (twin.simulationParams.weatherDynamicsEnabled) {
        // Gradually change wind direction
        const windDirection = twin.physicalState.weather.conditions.wind.direction;
        const windSpeed = twin.physicalState.weather.conditions.wind.speed;
        
        // Small random changes
        const newWindDirection = (windDirection + (Math.random() * 10 - 5)) % 360;
        const newWindSpeed = Math.max(0, Math.min(30, windSpeed + (Math.random() * 2 - 1)));
        
        twin.physicalState.weather.conditions.wind.direction = newWindDirection;
        twin.physicalState.weather.conditions.wind.speed = newWindSpeed;
        
        // Occasionally update visibility
        if (Math.random() < 0.05) {
          const visibilityChange = Math.random() < 0.5 ? -500 : 500;
          twin.physicalState.weather.conditions.visibility = Math.max(
            1000, 
            Math.min(10000, twin.physicalState.weather.conditions.visibility + visibilityChange)
          );
        }
        
        // Occasionally update precipitation
        if (Math.random() < 0.02) {
          const precipitationChange = Math.random() < 0.5 ? -0.1 : 0.1;
          twin.physicalState.weather.conditions.precipitation = Math.max(
            0, 
            Math.min(1, twin.physicalState.weather.conditions.precipitation + precipitationChange)
          );
        }
      }
      
      // Inject random hazards
      if (Math.random() < twin.simulationParams.hazardInjectionRate) {
        // Create a random hazard in the airspace
        const hazardTypes = ['WEATHER_CELL', 'RESTRICTED_AIRSPACE', 'COMMUNICATION_OUTAGE'];
        const randomType = hazardTypes[Math.floor(Math.random() * hazardTypes.length)];
        
        // Generate random position within airspace
        const bbox = turf.bbox(turf.polygon(twin.physicalState.boundaries.coordinates));
        const randomPosition = {
          type: 'Point',
          coordinates: [
            bbox[0] + Math.random() * (bbox[2] - bbox[0]),
            bbox[1] + Math.random() * (bbox[3] - bbox[1])
          ]
        };
        
        // Add hazard to operational state
        twin.operationalState.hazards.push({
          id: `hzd-${Random.id(8)}`,
          type: randomType,
          location: randomPosition,
          radius: 500 + Math.random() * 1500, // 500m to 2000m
          severity: 0.5 + Math.random() * 0.4, // 0.5 to 0.9
          createdAt: new Date()
```
