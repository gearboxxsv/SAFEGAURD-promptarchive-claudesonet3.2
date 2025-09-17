I'll help you create the IASMS (Integrated Airspace Management System) prediction toolset. First, let's explore the existing project structure to understand what we're working with, then create the required predictive capabilities.Let me first check if there's any existing IASMS code in the project:Based on my review of the codebase, I'll now create the IASMS (Integrated Advanced Safety Management System) prediction toolset, which will address the provided narratives and use cases, focusing on predictive capabilities for UAM and UAS operations.

# IASMS Prediction Toolset - Implementation Plan

## Understanding the Current Codebase

The existing codebase has several prediction modules for different domains:
- `AAMSwarmPredictor.js` - Advanced Air Mobility prediction
- `SpaceSatelliteSwarmPredictor.js` - Space satellite prediction
- `LandSwarmPredictor.js` - Land vehicle prediction
- `PeopleSwarmPredictor.js` - Pedestrian movement prediction
- `IndustrialRoboticsSwarmPredictor.js` - Industrial robotics prediction

These modules use a common pattern:
1. Maintain a database connection for persistent storage
2. Provide trajectory prediction based on current state and physics models
3. Detect potential conflicts between entities
4. Generate resolution maneuvers for conflict avoidance
5. Include uncertainty modeling in predictions

## IASMS Architecture Overview

I'll create the following components for the IASMS prediction toolset:

1. `IAMSPredictor.js` - Core prediction engine for Integrated Airspace Management
2. `IAMSBatteryHealthPredictor.js` - Battery health prediction model
3. `IAMSVertiportManager.js` - Vertiport operations management
4. `IAMSWeatherRiskAssessor.js` - Weather risk assessment for UAM operations
5. `IAMSContingencyPlanner.js` - Contingency planning for emergency scenarios
6. `IAMSCommunicationLossHandler.js` - Resilience during communication loss
7. `IAMSTimeBasedFlowManager.js` - Time-based flow management
8. `IAMSCollisionRiskPredictor.js` - Bird strike and other collision risk prediction
9. `IAMSServiceDisruptionHandler.js` - Graceful degradation during service disruptions
10. `IAMSIntegrationAPI.js` - Integration layer with external systems (USS, SDSPs)

Let me start implementing each component:

```javascript
// Path: /IAMSPredictor.js
// Written by Greg Deeds, Autonomy Association International, Inc.
// Copyright 2025 Autonomy Association International Inc., all rights reserved 
// Safeguard patent license from National Aeronautics and Space Administration (NASA)
// Copyright 2025 NASA, all rights reserved

/**
 * @fileoverview Core Integrated Airspace Management System (IASMS) Predictor
 * @module safeguard/iams-predictor
 */

const { Meteor } = require('meteor/meteor');
const turf = require('@turf/turf');
const { GeospatialUtils } = require('./GeospatialUtilityFunctions');

/**
 * Class for Integrated Airspace Management System prediction
 * Serves as the core predictor for UAM/UAS operations with integration
 * to various safety-critical services
 */
class IAMSPredictor {
  /**
   * Create a new IAMSPredictor instance
   * @param {Object} options - Configuration options
   * @param {Object} options.db - MongoDB database connection
   * @param {number} options.predictionTimeHorizon - Time horizon for predictions in seconds
   * @param {number} options.updateFrequency - Update frequency in milliseconds
   * @param {number} options.horizontalSeparation - Minimum horizontal separation in meters
   * @param {number} options.verticalSeparation - Minimum vertical separation in meters
   * @param {Object} options.airspaceConfig - Airspace configuration
   * @param {boolean} options.emergencyMode - Whether the system is in emergency mode
   * @param {Object} options.serviceRegistry - Registry of available services
   * @param {Object} options.externalProviders - External data provider configurations
   */
  constructor(options = {}) {
    this.options = {
      predictionTimeHorizon: options.predictionTimeHorizon || 300, // 5 minutes
      updateFrequency: options.updateFrequency || 1000, // 1 second
      horizontalSeparation: options.horizontalSeparation || 150, // 150 meters
      verticalSeparation: options.verticalSeparation || 50, // 50 meters
      conflictLookahead: options.conflictLookahead || 120, // 2 minutes
      trajectoryUncertainty: options.trajectoryUncertainty || 0.15, // 15% uncertainty
      emergencyMode: options.emergencyMode || false,
      graceTime: options.graceTime || 30, // 30 seconds grace time for degraded operations
      ...options
    };
    
    this.db = options.db;
    this.airVehicleCollection = this.db ? this.db.collection('iamsAirVehicles') : null;
    this.trajectoriesCollection = this.db ? this.db.collection('iamsTrajectories') : null;
    this.conflictsCollection = this.db ? this.db.collection('iamsConflicts') : null;
    this.vertiportsCollection = this.db ? this.db.collection('iamsVertiports') : null;
    this.landingZonesCollection = this.db ? this.db.collection('iamsLandingZones') : null;
    this.weatherDataCollection = this.db ? this.db.collection('iamsWeatherData') : null;
    this.serviceStatusCollection = this.db ? this.db.collection('iamsServiceStatus') : null;
    
    // Operational vehicles and trajectories
    this.vehicles = new Map();
    this.trajectories = new Map();
    this.predictedConflicts = new Map();
    this.landingZones = new Map();
    this.vertiports = new Map();
    
    // Service management
    this.serviceRegistry = options.serviceRegistry || {};
    this.serviceStatus = new Map();
    this.degradedServices = new Map();
    
    // Active contingency plans
    this.activeContingencyPlans = new Map();
    
    // External service connections
    this.externalProviders = options.externalProviders || {};
    
    // Processing state
    this.lastUpdate = 0;
    this.updateInterval = null;
    this.isProcessing = false;

    // Register with system monitor
    this.registerWithSystemMonitor();
  }

  /**
   * Initialize the IAMS predictor
   * @async
   * @returns {Promise<void>}
   */
  async initialize() {
    // Create indexes if needed
    if (this.airVehicleCollection) {
      await this.airVehicleCollection.createIndex({ vehicleId: 1 }, { unique: true });
      await this.airVehicleCollection.createIndex({ "position.coordinates": "2dsphere" });
      await this.airVehicleCollection.createIndex({ vehicleType: 1 });
      await this.airVehicleCollection.createIndex({ status: 1 });
      await this.airVehicleCollection.createIndex({ batteryHealth: 1 });
    }
    
    if (this.trajectoriesCollection) {
      await this.trajectoriesCollection.createIndex({ vehicleId: 1 });
      await this.trajectoriesCollection.createIndex({ timestamp: 1 });
      await this.trajectoriesCollection.createIndex({ "points.position.coordinates": "2dsphere" });
    }
    
    if (this.conflictsCollection) {
      await this.conflictsCollection.createIndex({ conflictId: 1 }, { unique: true });
      await this.conflictsCollection.createIndex({ status: 1 });
      await this.conflictsCollection.createIndex({ predictedTime: 1 });
      await this.conflictsCollection.createIndex({ severity: 1 });
      await this.conflictsCollection.createIndex({ vehicleIds: 1 });
    }
    
    if (this.vertiportsCollection) {
      await this.vertiportsCollection.createIndex({ vertiportId: 1 }, { unique: true });
      await this.vertiportsCollection.createIndex({ "location.coordinates": "2dsphere" });
      await this.vertiportsCollection.createIndex({ status: 1 });
    }
    
    if (this.landingZonesCollection) {
      await this.landingZonesCollection.createIndex({ zoneId: 1 }, { unique: true });
      await this.landingZonesCollection.createIndex({ "location.coordinates": "2dsphere" });
      await this.landingZonesCollection.createIndex({ vertiportId: 1 });
      await this.landingZonesCollection.createIndex({ status: 1 });
    }
    
    if (this.weatherDataCollection) {
      await this.weatherDataCollection.createIndex({ timestamp: 1 });
      await this.weatherDataCollection.createIndex({ "location.coordinates": "2dsphere" });
      await this.weatherDataCollection.createIndex({ type: 1 });
    }

    if (this.serviceStatusCollection) {
      await this.serviceStatusCollection.createIndex({ serviceId: 1 }, { unique: true });
      await this.serviceStatusCollection.createIndex({ status: 1 });
      await this.serviceStatusCollection.createIndex({ lastUpdate: 1 });
    }
    
    // Load vertiports and landing zones
    await this.loadVertiports();
    await this.loadLandingZones();
    
    // Check service status
    await this.checkServiceStatus();
    
    // Start the update interval
    this.startUpdateCycle();
    
    console.log('IAMS predictor initialized');
  }
  
  /**
   * Register with system health monitor
   * @private
   */
  registerWithSystemMonitor() {
    // Register this service with the system health monitor
    if (this.serviceRegistry.systemMonitor) {
      this.serviceRegistry.systemMonitor.registerService({
        serviceId: 'iams-predictor',
        serviceName: 'IAMS Predictor',
        serviceType: 'core',
        status: 'online',
        lastHeartbeat: new Date(),
        dependencies: [
          'weather-service',
          'uss-connector',
          'fims-connector',
          'surveillance-system',
          'communication-system'
        ]
      });
    }
  }

  /**
   * Load vertiports from database
   * @async
   * @private
   */
  async loadVertiports() {
    if (!this.vertiportsCollection) return;
    
    try {
      const vertiports = await this.vertiportsCollection.find({}).toArray();
      
      this.vertiports.clear();
      for (const vertiport of vertiports) {
        this.vertiports.set(vertiport.vertiportId, vertiport);
      }
      
      console.log(`Loaded ${this.vertiports.size} vertiports`);
    } catch (error) {
      console.error('Error loading vertiports:', error);
    }
  }

  /**
   * Load landing zones from database
   * @async
   * @private
   */
  async loadLandingZones() {
    if (!this.landingZonesCollection) return;
    
    try {
      const landingZones = await this.landingZonesCollection.find({}).toArray();
      
      this.landingZones.clear();
      for (const zone of landingZones) {
        this.landingZones.set(zone.zoneId, zone);
      }
      
      console.log(`Loaded ${this.landingZones.size} landing zones`);
    } catch (error) {
      console.error('Error loading landing zones:', error);
    }
  }

  /**
   * Check status of dependent services
   * @async
   * @private
   */
  async checkServiceStatus() {
    if (!this.serviceStatusCollection) return;
    
    try {
      const services = await this.serviceStatusCollection.find({}).toArray();
      
      this.serviceStatus.clear();
      this.degradedServices.clear();
      
      const now = new Date();
      const staleThreshold = 60000; // 60 seconds
      
      for (const service of services) {
        this.serviceStatus.set(service.serviceId, service);
        
        // Check if service is stale
        const lastUpdate = new Date(service.lastUpdate);
        const timeSinceUpdate = now - lastUpdate;
        
        if (service.status !== 'online' || timeSinceUpdate > staleThreshold) {
          this.degradedServices.set(service.serviceId, {
            ...service,
            timeSinceUpdate,
            degradedSince: now
          });
        }
      }
      
      if (this.degradedServices.size > 0) {
        console.warn(`${this.degradedServices.size} services are degraded or offline`);
      }
    } catch (error) {
      console.error('Error checking service status:', error);
    }
  }

  /**
   * Start the prediction update cycle
   * @private
   */
  startUpdateCycle() {
    if (this.updateInterval) {
      clearInterval(this.updateInterval);
    }
    
    this.updateInterval = setInterval(() => {
      this.updatePredictions().catch(err => {
        console.error('Error updating IAMS predictions:', err);
      });
    }, this.options.updateFrequency);
  }
  
  /**
   * Stop the prediction update cycle
   */
  stopUpdateCycle() {
    if (this.updateInterval) {
      clearInterval(this.updateInterval);
      this.updateInterval = null;
    }
  }
  
  /**
   * Update predictions for all vehicles
   * @async
   * @private
   */
  async updatePredictions() {
    if (this.isProcessing) return;
    
    this.isProcessing = true;
    try {
      // 1. Check service status
      await this.checkServiceStatus();
      
      // 2. Update vehicle cache from database
      await this.updateVehicleCache();
      
      // 3. Generate trajectory predictions
      this.generateTrajectoryPredictions();
      
      // 4. Detect potential conflicts
      const conflicts = this.detectPotentialConflicts();
      
      // 5. Generate resolution maneuvers
      await this.generateResolutionManeuvers(conflicts);
      
      // 6. Update database with predictions and conflicts
      await this.storeConflictData(conflicts);
      
      // 7. Process contingency plans
      await this.processContingencyPlans();
      
      // 8. Send heartbeat to system monitor
      this.sendHeartbeat();
      
      this.lastUpdate = Date.now();
    } catch (error) {
      console.error('Error in IAMS prediction cycle:', error);
    } finally {
      this.isProcessing = false;
    }
  }
  
  /**
   * Update vehicle cache from database
   * @async
   * @private
   */
  async updateVehicleCache() {
    if (!this.airVehicleCollection) return;
    
    try {
      // Get all active vehicles
      const activeVehicles = await this.airVehicleCollection.find({
        status: { $in: ['active', 'en-route', 'hovering', 'landing', 'taking-off', 'contingency'] }
      }).toArray();
      
      // Update cache
      this.vehicles.clear();
      for (const vehicle of activeVehicles) {
        // Calculate vehicle state
        const state = this.calculateVehicleState(vehicle);
        
        // Store in cache
        this.vehicles.set(vehicle.vehicleId, {
          ...vehicle,
          state,
          updatedAt: new Date()
        });
      }
      
      console.log(`Updated vehicle cache: ${this.vehicles.size} active vehicles`);
    } catch (error) {
      console.error('Error fetching active vehicles:', error);
    }
  }
  
  /**
   * Calculate vehicle state based on position and past history
   * @param {Object} vehicle - Vehicle data
   * @returns {Object} Vehicle state including velocity vector
   * @private
   */
  calculateVehicleState(vehicle) {
    // Default state
    const state = {
      position: vehicle.position,
      altitude: vehicle.position.altitude || 0,
      heading: vehicle.heading || 0,
      speed: vehicle.speed || 0,
      verticalSpeed: vehicle.verticalSpeed || 0,
      turnRate: 0,
      acceleration: 0,
      verticalAcceleration: 0,
      batteryHealth: vehicle.batteryHealth || 100,
      batteryRemaining: vehicle.batteryRemaining || 100,
      communicationStatus: vehicle.communicationStatus || 'normal',
      timeStamp: new Date()
    };
    
    // Get past positions if available
    if (vehicle.pastPositions && vehicle.pastPositions.length > 0) {
      const recentPositions = vehicle.pastPositions.slice(-5); // Last 5 positions
      
      if (recentPositions.length >= 2) {
        const newest = recentPositions[recentPositions.length - 1];
        const oldest = recentPositions[0];
        
        // Calculate time difference
        const timeDiff = (newest.timestamp - oldest.timestamp) / 1000; // seconds
        
        if (timeDiff > 0) {
          // Calculate speed and heading changes
          const distance = GeospatialUtils.distance(
            oldest.position,
            newest.position,
            'meters'
          );
          
          state.speed = distance / timeDiff; // m/s
          state.heading = GeospatialUtils.bearing(oldest.position, newest.position);
          
          // Vertical speed
          if (newest.position.altitude !== undefined && oldest.position.altitude !== undefined) {
            state.verticalSpeed = (newest.position.altitude - oldest.position.altitude) / timeDiff;
          }
          
          // Calculate turn rate if more than 2 positions
          if (recentPositions.length >= 3) {
            const midPosition = recentPositions[Math.floor(recentPositions.length / 2)];
            const firstHeading = GeospatialUtils.bearing(oldest.position, midPosition.position);
            const secondHeading = GeospatialUtils.bearing(midPosition.position, newest.position);
            
            let headingChange = secondHeading - firstHeading;
            // Normalize to -180 to 180
            if (headingChange > 180) headingChange -= 360;
            if (headingChange < -180) headingChange += 360;
            
            state.turnRate = headingChange / timeDiff; // degrees per second
          }
          
          // Calculate acceleration if more than 2 positions
          if (recentPositions.length >= 3) {
            const midPosition = recentPositions[Math.floor(recentPositions.length / 2)];
            const firstTimeDiff = (midPosition.timestamp - oldest.timestamp) / 1000;
            const secondTimeDiff = (newest.timestamp - midPosition.timestamp) / 1000;
            
            if (firstTimeDiff > 0 && secondTimeDiff > 0) {
              const firstDistance = GeospatialUtils.distance(
                oldest.position,
                midPosition.position,
                'meters'
              );
              
              const secondDistance = GeospatialUtils.distance(
                midPosition.position,
                newest.position,
                'meters'
              );
              
              const firstSpeed = firstDistance / firstTimeDiff;
              const secondSpeed = secondDistance / secondTimeDiff;
              
              state.acceleration = (secondSpeed - firstSpeed) / ((firstTimeDiff + secondTimeDiff) / 2);
              
              // Vertical acceleration
              if (newest.position.altitude !== undefined && 
                  midPosition.position.altitude !== undefined && 
                  oldest.position.altitude !== undefined) {
                const firstVSpeed = (midPosition.position.altitude - oldest.position.altitude) / firstTimeDiff;
                const secondVSpeed = (newest.position.altitude - midPosition.position.altitude) / secondTimeDiff;
                
                state.verticalAcceleration = (secondVSpeed - firstVSpeed) / ((firstTimeDiff + secondTimeDiff) / 2);
              }
            }
          }
        }
      }
    }
    
    // Calculate estimated remaining flight time based on battery
    if (state.batteryRemaining !== undefined && state.batteryHealth !== undefined) {
      // Simple model: adjust remaining percentage based on battery health
      const adjustedRemaining = state.batteryRemaining * (state.batteryHealth / 100);
      
      // Calculate estimated time in minutes (simplified model)
      // This would be replaced with a more sophisticated model in production
      const estimatedMinutesRemaining = adjustedRemaining * 0.3; // 30 minutes at 100%
      state.estimatedFlightTimeRemaining = estimatedMinutesRemaining * 60; // in seconds
    }
    
    return state;
  }
  
  /**
   * Generate trajectory predictions for all vehicles
   * @private
   */
  generateTrajectoryPredictions() {
    this.trajectories.clear();
    
    // For each vehicle, predict future positions
    for (const [vehicleId, vehicle] of this.vehicles.entries()) {
      // Get vehicle intended route/flight plan if available
      const flightPlan = vehicle.flightPlan || null;
      
      // Predict trajectory
      const trajectory = this.predictTrajectory(vehicle, flightPlan);
      
      // Store the trajectory
      this.trajectories.set(vehicleId, trajectory);
    }
    
    console.log(`Generated trajectories for ${this.trajectories.size} vehicles`);
  }
  
  /**
   * Predict trajectory for a single vehicle
   * @param {Object} vehicle - Vehicle data with state
   * @param {Object|null} flightPlan - Flight plan data if available
   * @returns {Object} Predicted trajectory
   * @private
   */
  predictTrajectory(vehicle, flightPlan) {
    // Use flight plan if available, otherwise use dead reckoning
    if (flightPlan && flightPlan.waypoints && flightPlan.waypoints.length > 0) {
      return this.predictFromFlightPlan(vehicle, flightPlan);
    }
    
    // Basic dead reckoning prediction
    const state = vehicle.state;
    const timeHorizon = this.options.predictionTimeHorizon;
    const timeStep = 5; // 5-second steps
    const steps = Math.ceil(timeHorizon / timeStep);
    const points = [];
    
    // Add current position as first point
    points.push({
      position: {
        lat: state.position.lat,
        lng: state.position.lng,
        altitude: state.altitude
      },
      timeOffset: 0,
      timestamp: new Date(state.timeStamp),
      uncertainty: {
        horizontal: 0,
        vertical: 0
      },
      batteryRemaining: state.batteryRemaining,
      estimatedFlightTimeRemaining: state.estimatedFlightTimeRemaining
    });
    
    let currentLat = state.position.lat;
    let currentLng = state.position.lng;
    let currentAlt = state.altitude;
    let currentSpeed = state.speed;
    let currentHeading = state.heading;
    let currentVerticalSpeed = state.verticalSpeed;
    let currentBatteryRemaining = state.batteryRemaining || 100;
    let estimatedFlightTimeRemaining = state.estimatedFlightTimeRemaining;
    
    // For acceleration and turn rate
    const acceleration = state.acceleration || 0;
    const turnRate = state.turnRate || 0;
    const verticalAcceleration = state.verticalAcceleration || 0;
    
    // Generate future points
    for (let i = 1; i <= steps; i++) {
      const timeOffset = i * timeStep;
      
      // Update speed based on acceleration
      currentSpeed += acceleration * timeStep;
      if (currentSpeed < 0) currentSpeed = 0;
      
      // Update heading based on turn rate
      currentHeading += turnRate * timeStep;
      // Normalize heading to 0-360
      currentHeading = (currentHeading + 360) % 360;
      
      // Update vertical speed based on vertical acceleration
      currentVerticalSpeed += verticalAcceleration * timeStep;
      
      // Calculate distance traveled in this step
      const distance = currentSpeed * timeStep; // meters
      
      // Calculate new position
      const newPosition = GeospatialUtils.destination(
        { lat: currentLat, lng: currentLng },
        distance / 1000, // convert to km for the function
        currentHeading
      );
      
      // Update current position
      currentLat = newPosition.lat;
      currentLng = newPosition.lng;
      
      // Update altitude
      currentAlt += currentVerticalSpeed * timeStep;
      
      // Update battery remaining (simple linear model)
      // In a real implementation, this would be more sophisticated
      if (currentBatteryRemaining !== undefined) {
        // Simplified battery drain model
        const batteryDrainRate = this.calculateBatteryDrainRate(
          vehicle,
          currentSpeed,
          currentVerticalSpeed,
          currentAlt
        );
        
        currentBatteryRemaining -= batteryDrainRate * timeStep;
        if (currentBatteryRemaining < 0) currentBatteryRemaining = 0;
        
        // Update estimated flight time remaining
        if (estimatedFlightTimeRemaining !== undefined) {
          estimatedFlightTimeRemaining -= timeStep;
          if (estimatedFlightTimeRemaining < 0) estimatedFlightTimeRemaining = 0;
        }
      }
      
      // Calculate uncertainty (increases with time)
      const timeUncertaintyFactor = Math.sqrt(timeOffset / timeStep);
      const uncertaintyFactor = this.options.trajectoryUncertainty;
      const horizontalUncertainty = distance * uncertaintyFactor * timeUncertaintyFactor;
      const verticalUncertainty = Math.abs(currentVerticalSpeed * timeStep * uncertaintyFactor * timeUncertaintyFactor);
      
      // Add point to trajectory
      points.push({
        position: {
          lat: currentLat,
          lng: currentLng,
          altitude: currentAlt
        },
        timeOffset,
        timestamp: new Date(state.timeStamp.getTime() + timeOffset * 1000),
        speed: currentSpeed,
        heading: currentHeading,
        verticalSpeed: currentVerticalSpeed,
        batteryRemaining: currentBatteryRemaining,
        estimatedFlightTimeRemaining: estimatedFlightTimeRemaining,
        uncertainty: {
          horizontal: horizontalUncertainty,
          vertical: verticalUncertainty
        }
      });
    }
    
    return {
      vehicleId: vehicle.vehicleId,
      callSign: vehicle.callSign,
      vehicleType: vehicle.vehicleType,
      generatedAt: new Date(),
      points,
      predictionMethod: 'dead-reckoning'
    };
  }
  
  /**
   * Calculate battery drain rate based on vehicle state
   * @param {Object} vehicle - Vehicle data
   * @param {number} speed - Current speed in m/s
   * @param {number} verticalSpeed - Current vertical speed in m/s
   * @param {number} altitude - Current altitude in meters
   * @returns {number} Battery drain rate in percentage per second
   * @private
   */
  calculateBatteryDrainRate(vehicle, speed, verticalSpeed, altitude) {
    // Simple model, in reality this would be much more sophisticated
    const vehicleType = vehicle.vehicleType || 'uam';
    const batteryHealth = vehicle.state.batteryHealth || 100;
    
    // Base drain rate (percentage per second)
    let baseDrainRate = 0.01; // 0.01% per second = 36% per hour
    
    // Adjust based on vehicle type
    if (vehicleType === 'uas-delivery') {
      baseDrainRate *= 0.8; // More efficient
    } else if (vehicleType === 'uas-inspection') {
      baseDrainRate *= 0.7; // Most efficient
    }
    
    // Adjust for vertical speed (climbing uses more power)
    const verticalFactor = 1 + Math.max(0, verticalSpeed) * 0.01;
    
    // Adjust for horizontal speed (non-linear relationship)
    // Efficiency often improves at cruise speed, then decreases at high speeds
    let speedFactor = 1;
    if (speed < 5) {
      speedFactor = 1.2; // Hovering or very slow flight is less efficient
    } else if (speed > 20) {
      speedFactor = 1 + (speed - 20) * 0.01; // High speed is less efficient
    } else {
      speedFactor = 0.9; // Cruise speed is most efficient
    }
    
    // Adjust for altitude (higher altitude has thinner air, affects some vehicles)
    const altitudeFactor = 1 + Math.max(0, (altitude - 500) / 10000);
    
    // Adjust for battery health (degraded batteries drain faster)
    const healthFactor = Math.max(1, 100 / batteryHealth);
    
    // Combined drain rate
    return baseDrainRate * verticalFactor * speedFactor * altitudeFactor * healthFactor;
  }
  
  /**
   * Predict trajectory using flight plan waypoints
   * @param {Object} vehicle - Vehicle data
   * @param {Object} flightPlan - Flight plan with waypoints
   * @returns {Object} Predicted trajectory
   * @private
   */
  predictFromFlightPlan(vehicle, flightPlan) {
    const state = vehicle.state;
    const waypoints = flightPlan.waypoints;
    const timeHorizon = this.options.predictionTimeHorizon;
    const timeStep = 5; // 5-second steps
    const points = [];
    
    // Add current position as first point
    points.push({
      position: {
        lat: state.position.lat,
        lng: state.position.lng,
        altitude: state.altitude
      },
      timeOffset: 0,
      timestamp: new Date(state.timeStamp),
      batteryRemaining: state.batteryRemaining,
      estimatedFlightTimeRemaining: state.estimatedFlightTimeRemaining,
      uncertainty: {
        horizontal: 0,
        vertical: 0
      }
    });
    
    // Find the next waypoint based on current position
    let nextWaypointIndex = 0;
    let minDistance = Infinity;
    
    for (let i = 0; i < waypoints.length; i++) {
      const waypoint = waypoints[i];
      const distance = GeospatialUtils.distance(
        state.position,
        waypoint.position,
        'meters'
      );
      
      if (distance < minDistance) {
        minDistance = distance;
        nextWaypointIndex = i;
      }
    }
    
    // Current position and state
    let currentLat = state.position.lat;
    let currentLng = state.position.lng;
    let currentAlt = state.altitude;
    let currentSpeed = state.speed;
    let currentBatteryRemaining = state.batteryRemaining || 100;
    let estimatedFlightTimeRemaining = state.estimatedFlightTimeRemaining;
    
    // Total time elapsed
    let timeElapsed = 0;
    
    // Follow waypoints until we reach the time horizon
    while (timeElapsed < timeHorizon && nextWaypointIndex < waypoints.length) {
      const waypoint = waypoints[nextWaypointIndex];
      
      // Calculate distance and bearing to the waypoint
      const distance = GeospatialUtils.distance(
        { lat: currentLat, lng: currentLng },
        waypoint.position,
        'meters'
      );
      
      const bearing = GeospatialUtils.bearing(
        { lat: currentLat, lng: currentLng },
        waypoint.position
      );
      
      // Calculate time to reach the waypoint at current speed
      // If no speed, assume a default speed
      const effectiveSpeed = currentSpeed > 0 ? currentSpeed : 10; // m/s
      const timeToWaypoint = distance / effectiveSpeed;
      
      // If we can reach the waypoint within the time horizon
      if (timeElapsed + timeToWaypoint <= timeHorizon) {
        // Calculate intermediate points
        const numSteps = Math.max(1, Math.floor(timeToWaypoint / timeStep));
        const actualTimeStep = timeToWaypoint / numSteps;
        
        // Calculate altitude change
        const altitudeChange = waypoint.position.altitude - currentAlt;
        const altitudeStepChange = altitudeChange / numSteps;
        
        // Generate points along the path to waypoint
        for (let i = 1; i <= numSteps; i++) {
          const stepTimeOffset = timeElapsed + i * actualTimeStep;
          const stepDistance = distance * (i / numSteps);
          
          // Calculate position
          const position = GeospatialUtils.destination(
            { lat: currentLat, lng: currentLng },
            stepDistance / 1000, // convert to km
            bearing
          );
          
          // Update battery remaining
          if (currentBatteryRemaining !== undefined) {
            // Calculate vertical speed for this segment
            const verticalSpeed = altitudeStepChange / actualTimeStep;
            
            // Calculate battery drain
            const batteryDrainRate = this.calculateBatteryDrainRate(
              vehicle,
              effectiveSpeed,
              verticalSpeed,
              currentAlt + i * altitudeStepChange
            );
            
            currentBatteryRemaining -= batteryDrainRate * actualTimeStep;
            if (currentBatteryRemaining < 0) currentBatteryRemaining = 0;
            
            // Update estimated flight time
            if (estimatedFlightTimeRemaining !== undefined) {
              estimatedFlightTimeRemaining -= actualTimeStep;
              if (estimatedFlightTimeRemaining < 0) estimatedFlightTimeRemaining = 0;
            }
          }
          
          // Calculate uncertainty
          const timeUncertaintyFactor = Math.sqrt(stepTimeOffset / timeStep);
          const uncertaintyFactor = this.options.trajectoryUncertainty;
          const horizontalUncertainty = stepDistance * uncertaintyFactor * timeUncertaintyFactor;
          const verticalUncertainty = Math.abs(altitudeStepChange * uncertaintyFactor * timeUncertaintyFactor);
          
          // Add point
          points.push({
            position: {
              lat: position.lat,
              lng: position.lng,
              altitude: currentAlt + i * altitudeStepChange
            },
            timeOffset: stepTimeOffset,
            timestamp: new Date(state.timeStamp.getTime() + stepTimeOffset * 1000),
            speed: effectiveSpeed,
            heading: bearing,
            verticalSpeed: altitudeStepChange / actualTimeStep,
            batteryRemaining: currentBatteryRemaining,
            estimatedFlightTimeRemaining: estimatedFlightTimeRemaining,
            uncertainty: {
              horizontal: horizontalUncertainty,
              vertical: verticalUncertainty
            }
          });
        }
        
        // Update current position to waypoint
        currentLat = waypoint.position.lat;
        currentLng = waypoint.position.lng;
        currentAlt = waypoint.position.altitude;
        
        // Update time elapsed
        timeElapsed += timeToWaypoint;
        
        // Move to next waypoint
        nextWaypointIndex++;
      } else {
        // We can't reach the waypoint within the time horizon
        // Calculate how far we can go
        const partialDistance = effectiveSpeed * (timeHorizon - timeElapsed);
        
        // Calculate position
        const finalPosition = GeospatialUtils.destination(
          { lat: currentLat, lng: currentLng },
          partialDistance / 1000, // convert to km
          bearing
        );
        
        // Calculate altitude
        const altitudeProgress = partialDistance / distance;
        const finalAltitude = currentAlt + (waypoint.position.altitude - currentAlt) * altitudeProgress;
        const verticalSpeed = (finalAltitude - currentAlt) / (timeHorizon - timeElapsed);
        
        // Update battery
        if (currentBatteryRemaining !== undefined) {
          const batteryDrainRate = this.calculateBatteryDrainRate(
            vehicle,
            effectiveSpeed,
            verticalSpeed,
            (currentAlt + finalAltitude) / 2 // average altitude during this segment
          );
          
          currentBatteryRemaining -= batteryDrainRate * (timeHorizon - timeElapsed);
          if (currentBatteryRemaining < 0) currentBatteryRemaining = 0;
          
          // Update estimated flight time
          if (estimatedFlightTimeRemaining !== undefined) {
            estimatedFlightTimeRemaining -= (timeHorizon - timeElapsed);
            if (estimatedFlightTimeRemaining < 0) estimatedFlightTimeRemaining = 0;
          }
        }
        
        // Calculate uncertainty
        const timeUncertaintyFactor = Math.sqrt(timeHorizon / timeStep);
        const uncertaintyFactor = this.options.trajectoryUncertainty;
        const horizontalUncertainty = partialDistance * uncertaintyFactor * timeUncertaintyFactor;
        const verticalUncertainty = Math.abs((finalAltitude - currentAlt) * uncertaintyFactor * timeUncertaintyFactor);
        
        // Add final point
        points.push({
          position: {
            lat: finalPosition.lat,
            lng: finalPosition.lng,
            altitude: finalAltitude
          },
          timeOffset: timeHorizon,
          timestamp: new Date(state.timeStamp.getTime() + timeHorizon * 1000),
          speed: effectiveSpeed,
          heading: bearing,
          verticalSpeed: verticalSpeed,
          batteryRemaining: currentBatteryRemaining,
          estimatedFlightTimeRemaining: estimatedFlightTimeRemaining,
          uncertainty: {
            horizontal: horizontalUncertainty,
            vertical: verticalUncertainty
          }
        });
        
        // Update time elapsed to end
        timeElapsed = timeHorizon;
      }
    }
    
    return {
      vehicleId: vehicle.vehicleId,
      callSign: vehicle.callSign,
      vehicleType: vehicle.vehicleType,
      generatedAt: new Date(),
      points,
      predictionMethod: 'flight-plan'
    };
  }
  
  /**
   * Detect potential conflicts between vehicle trajectories
   * @returns {Array} Array of detected conflicts
   * @private
   */
  detectPotentialConflicts() {
    const conflicts = [];
    const vehicleIds = Array.from(this.trajectories.keys());
    
    // Compare each pair of vehicles
    for (let i = 0; i < vehicleIds.length; i++) {
      const vehicle1Id = vehicleIds[i];
      const trajectory1 = this.trajectories.get(vehicle1Id);
      
      for (let j = i + 1; j < vehicleIds.length; j++) {
        const vehicle2Id = vehicleIds[j];
        const trajectory2 = this.trajectories.get(vehicle2Id);
        
        // Skip if either trajectory is invalid
        if (!trajectory1 || !trajectory2) continue;
        
        // Detect conflicts between these two trajectories
        const vehicleConflicts = this.detectConflictBetweenTrajectories(trajectory1, trajectory2);
        
        // Add any detected conflicts to the result
        if (vehicleConflicts.length > 0) {
          conflicts.push(...vehicleConflicts);
        }
      }
      
      // Also check for conflicts with vertiports and landing zones
      const vertiportConflicts = this.detectVertiportConflicts(trajectory1);
      if (vertiportConflicts.length > 0) {
        conflicts.push(...vertiportConflicts);
      }
      
      // Check for battery-related conflicts
      const batteryConflicts = this.detectBatteryConflicts(trajectory1);
      if (batteryConflicts.length > 0) {
        conflicts.push(...batteryConflicts);
      }
    }
    
    console.log(`Detected ${conflicts.length} potential conflicts`);
    return conflicts;
  }
  
  /**
   * Detect conflicts between two vehicle trajectories
   * @param {Object} trajectory1 - First vehicle trajectory
   * @param {Object} trajectory2 - Second vehicle trajectory
   * @returns {Array} Array of conflicts between the two trajectories
   * @private
   */
  detectConflictBetweenTrajectories(trajectory1, trajectory2) {
    const conflicts = [];
    const minSeparation = this.options.horizontalSeparation;
    const verticalSeparation = this.options.verticalSeparation;
    
    // Check each time step for conflicts
    for (let i = 0; i < trajectory1.points.length; i++) {
      const point1 = trajectory1.points[i];
      
      // Skip the current position (i=0)
      if (i === 0) continue;
      
      // Find the corresponding point in trajectory2 (same timeOffset)
      const point2 = trajectory2.points.find(p => p.timeOffset === point1.timeOffset);
      
      if (!point2) continue;
      
      // Calculate horizontal distance
      const horizontalDistance = GeospatialUtils.distance(
        point1.position,
        point2.position,
        'meters'
      );
      
      // Calculate vertical distance
      const verticalDistance = Math.abs(point1.position.altitude - point2.position.altitude);
      
      // Add uncertainty to required separation
      const totalHorizontalUncertainty = (point1.uncertainty?.horizontal || 0) + (point2.uncertainty?.horizontal || 0);
      const totalVerticalUncertainty = (point1.uncertainty?.vertical || 0) + (point2.uncertainty?.vertical || 0);
      
      const requiredHorizontalSeparation = minSeparation + totalHorizontalUncertainty;
      const requiredVerticalSeparation = verticalSeparation + totalVerticalUncertainty;
      
      // Check if separation requirements are violated
      if (horizontalDistance < requiredHorizontalSeparation && 
          verticalDistance < requiredVerticalSeparation) {
        // We have a conflict
        const conflictId = `conflict-${trajectory1.vehicleId}-${trajectory2.vehicleId}-${point1.timeOffset}`;
        
        // Get vehicle objects
        const vehicle1 = this.vehicles.get(trajectory1.vehicleId);
        const vehicle2 = this.vehicles.get(trajectory2.vehicleId);
        
        conflicts.push({
          conflictId,
          conflictType: 'vehicle-vehicle',
          vehicle1: {
            vehicleId: trajectory1.vehicleId,
            callSign: trajectory1.callSign,
            vehicleType: trajectory1.vehicleType,
            operatorId: vehicle1?.operatorId,
            position: point1.position,
            velocity: {
              speed: point1.speed,
              heading: point1.heading,
              verticalSpeed: point1.verticalSpeed
            }
          },
          vehicle2: {
            vehicleId: trajectory2.vehicleId,
            callSign: trajectory2.callSign,
            vehicleType: trajectory2.vehicleType,
            operatorId: vehicle2?.operatorId,
            position: point2.position,
            velocity: {
              speed: point2.speed,
              heading: point2.heading,
              verticalSpeed: point2.verticalSpeed
            }
          },
          predictedTime: point1.timestamp,
          timeOffset: point1.timeOffset,
          horizontalDistance,
          verticalDistance,
          requiredHorizontalSeparation,
          requiredVerticalSeparation,
          severity: this.calculateConflictSeverity(
            horizontalDistance, 
            verticalDistance, 
            requiredHorizontalSeparation, 
            requiredVerticalSeparation,
            point1.timeOffset
          ),
          detectedAt: new Date(),
          status: 'active'
        });
      }
    }
    
    return conflicts;
  }
  
  /**
   * Detect conflicts between vehicle trajectory and vertiports/landing zones
   * @param {Object} trajectory - Vehicle trajectory
   * @returns {Array} Array of vertiport/landing zone conflicts
   * @private
   */
  detectVertiportConflicts(trajectory) {
    const conflicts = [];
    
    // Check each point against vertiports and landing zones
    for (let i = 1; i < trajectory.points.length; i++) {
      const point = trajectory.points[i];
      
      // Check vertiports
      for (const [vertiportId, vertiport] of this.vertiports.entries()) {
        // Skip if vertiport is closed
        if (vertiport.status === 'closed') continue;
        
        // Calculate distance to vertiport
        const distance = GeospatialUtils.distance(
          point.position,
          vertiport.location,
          'meters'
        );
        
        // Check if vehicle is approaching vertiport but not approved
        if (distance < 500 && 
            trajectory.flightPlan && 
            trajectory.flightPlan.destination !== vertiportId &&
            trajectory.flightPlan.origin !== vertiportId) {
          
          conflicts.push({
            conflictId: `conflict-vertiport-${trajectory.vehicleId}-${vertiportId}-${point.timeOffset}`,
            conflictType: 'vehicle-vertiport',
            vehicle: {
              vehicleId: trajectory.vehicleId,
              callSign: trajectory.callSign,
              position: point.position
            },
            vertiport: {
              vertiportId: vertiport.vertiportId,
              name: vertiport.name,
              location: vertiport.location
            },
            predictedTime: point.timestamp,
            timeOffset: point.timeOffset,
            distance,
            severity: 'medium',
            detectedAt: new Date(),
            status: 'active',
            description: 'Vehicle approaching vertiport without approval'
          });
        }
      }
      
      // Check landing zones
      for (const [zoneId, zone] of this.landingZones.entries()) {
        // Skip if zone is closed or unavailable
        if (zone.status !== 'available') continue;
        
        // Calculate distance to landing zone
        const distance = GeospatialUtils.distance(
          point.position,
          zone.location,
          'meters'
        );
        
        // Calculate altitude difference
        const altitudeDiff = Math.abs(point.position.altitude - zone.location.altitude);
        
        // Check if vehicle is approaching landing zone but not assigned
        if (distance < 200 && altitudeDiff < 100 && 
            (!trajectory.flightPlan || 
             trajectory.flightPlan.assignedLandingZone !== zoneId)) {
          
          conflicts.push({
            conflictId: `conflict-landingzone-${trajectory.vehicleId}-${zoneId}-${point.timeOffset}`,
            conflictType: 'vehicle-landingzone',
            vehicle: {
              vehicleId: trajectory.vehicleId,
              callSign: trajectory.callSign,
              position: point.position
            },
            landingZone: {
              zoneId: zone.zoneId,
              vertiportId: zone.vertiportId,
              location: zone.location
            },
            predictedTime: point.timestamp,
            timeOffset: point.timeOffset,
            distance,
            altitudeDiff,
            severity: 'high',
            detectedAt: new Date(),
            status: 'active',
            description: 'Vehicle approaching landing zone without assignment'
          });
        }
      }
    }
    
    return conflicts;
  }
  
  /**
   * Detect battery-related conflicts for a vehicle trajectory
   * @param {Object} trajectory - Vehicle trajectory
   * @returns {Array} Array of battery-related conflicts
   * @private
   */
  detectBatteryConflicts(trajectory) {
    const conflicts = [];
    const vehicle = this.vehicles.get(trajectory.vehicleId);
    
    if (!vehicle) return conflicts;
    
    // Check if battery information is available
    if (!trajectory.points.some(p => p.batteryRemaining !== undefined)) {
      return conflicts;
    }
    
    // Check each point for battery issues
    for (let i = 1; i < trajectory.points.length; i++) {
      const point = trajectory.points[i];
      
      // Skip points without battery info
      if (point.batteryRemaining === undefined) continue;
      
      // Critical battery level (below 15%)
      if (point.batteryRemaining < 15) {
        // Find nearest vertiport or landing zone
        const [nearestVertiport, vertiportDistance] = this.findNearestVertiport(point.position);
        
        // Calculate if vehicle can reach vertiport
        let canReachVertiport = false;
        if (nearestVertiport && point.estimatedFlightTimeRemaining !== undefined) {
          // Simple time-to-reach calculation
          const speed = point.speed || 10; // m/s
          const timeToReach = vertiportDistance / speed; // seconds
          
          canReachVertiport = timeToReach < point.estimatedFlightTimeRemaining;
        }
        
        conflicts.push({
          conflictId: `conflict-battery-${trajectory.vehicleId}-${point.timeOffset}`,
          conflictType: 'battery',
          vehicle: {
            vehicleId: trajectory.vehicleId,
            callSign: trajectory.callSign,
            position: point.position
          },
          batteryRemaining: point.batteryRemaining,
          estimatedFlightTimeRemaining: point.estimatedFlightTimeRemaining,
          nearestVertiport: nearestVertiport ? {
            vertiportId: nearestVertiport.vertiportId,
            name: nearestVertiport.name,
            distance: vertiportDistance
          } : null,
          canReachVertiport,
          predictedTime: point.timestamp,
          timeOffset: point.timeOffset,
          severity: point.batteryRemaining < 10 ? 'critical' : 'high',
          detectedAt: new Date(),
          status: 'active',
          description: `Critical battery level predicted (${point.batteryRemaining.toFixed(1)}%)`
        });
        
        // Only report the first critical battery point
        break;
      }
    }
    
    return conflicts;
  }
  
  /**
   * Find the nearest vertiport to a position
   * @param {Object} position - Position to find nearest vertiport for
   * @returns {[Object, number]} Tuple of [vertiport, distance]
   * @private
   */
  findNearestVertiport(position) {
    let nearestVertiport = null;
    let minDistance = Infinity;
    
    for (const vertiport of this.vertiports.values()) {
      // Skip closed vertiports
      if (vertiport.status === 'closed') continue;
      
      const distance = GeospatialUtils.distance(
        position,
        vertiport.location,
        'meters'
      );
      
      if (distance < minDistance) {
        minDistance = distance;
        nearestVertiport = vertiport;
      }
    }
    
    return [nearestVertiport, minDistance];
  }
  
  /**
   * Calculate conflict severity
   * @param {number} horizontalDistance - Horizontal distance between vehicles
   * @param {number} verticalDistance - Vertical distance between vehicles
   * @param {number} requiredHorizontalSeparation - Required horizontal separation
   * @param {number} requiredVerticalSeparation - Required vertical separation
   * @param {number} timeOffset - Time offset in seconds
   * @returns {string} Conflict severity ('critical', 'high', 'medium', 'low')
   * @private
   */
  calculateConflictSeverity(
    horizontalDistance, 
    verticalDistance, 
    requiredHorizontalSeparation, 
    requiredVerticalSeparation,
    timeOffset
  ) {
    // Calculate penetration as percentage of required separation
    const horizontalPenetration = 1 - (horizontalDistance / requiredHorizontalSeparation);
    const verticalPenetration = 1 - (verticalDistance / requiredVerticalSeparation);
    
    // Overall penetration (combined horizontal and vertical)
    const overallPenetration = Math.sqrt(horizontalPenetration * horizontalPenetration + 
                                        verticalPenetration * verticalPenetration);
    
    // Time factor (conflicts in near future are more severe)
    const timeFactor = Math.max(0, 1 - (timeOffset / this.options.predictionTimeHorizon));
    
    // Combined severity score
    const severityScore = overallPenetration * (0.7 + 0.3 * timeFactor);
    
    // Determine severity category
    if (severityScore > 0.8) return 'critical';
    if (severityScore > 0.6) return 'high';
    if (severityScore > 0.4) return 'medium';
    return 'low';
  }
  
  /**
   * Generate resolution maneuvers for detected conflicts
   * @param {Array} conflicts - Array of detected conflicts
   * @returns {Promise<void>}
   * @private
   */
  async generateResolutionManeuvers(conflicts) {
    // Group conflicts by vehicle
    const vehicleConflicts = new Map();
    
    for (const conflict of conflicts) {
      if (conflict.conflictType === 'vehicle-vehicle') {
        // Add to vehicle1's conflicts
        if (!vehicleConflicts.has(conflict.vehicle1.vehicleId)) {
          vehicleConflicts.set(conflict.vehicle1.vehicleId, []);
        }
        vehicleConflicts.get(conflict.vehicle1.vehicleId).push({
          conflict,
          isVehicle1: true
        });
        
        // Add to vehicle2's conflicts
        if (!vehicleConflicts.has(conflict.vehicle2.vehicleId)) {
          vehicleConflicts.set(conflict.vehicle2.vehicleId, []);
        }
        vehicleConflicts.get(conflict.vehicle2.vehicleId).push({
          conflict,
          isVehicle1: false
        });
      } else if (conflict.conflictType === 'battery' || 
                conflict.conflictType === 'vehicle-vertiport' ||
                conflict.conflictType === 'vehicle-landingzone') {
        // Add to vehicle's conflicts
        if (!vehicleConflicts.has(conflict.vehicle.vehicleId)) {
          vehicleConflicts.set(conflict.vehicle.vehicleId, []);
        }
        vehicleConflicts.get(conflict.vehicle.vehicleId).push({
          conflict,
          isSpecialConflict: true
        });
      }
    }
    
    // Generate resolution maneuvers for each vehicle with conflicts
    const resolutions = [];
    for (const [vehicleId, vehicleConflictList] of vehicleConflicts.entries()) {
      // Sort conflicts by severity and time
      vehicleConflictList.sort((a, b) => {
        // First by severity
        const severityOrder = { 'critical': 0, 'high': 1, 'medium': 2, 'low': 3 };
        const severityDiff = severityOrder[a.conflict.severity] - severityOrder[b.conflict.severity];
        
        if (severityDiff !== 0) return severityDiff;
        
        // Then by time
        return a.conflict.timeOffset - b.conflict.timeOffset;
      });
      
      // Get the vehicle
      const vehicle = this.vehicles.get(vehicleId);
      if (!vehicle) continue;
      
      // Generate resolution based on most severe conflict
      const mostSevereConflict = vehicleConflictList[0];
      
      // Special handling for battery conflicts
      if (mostSevereConflict.isSpecialConflict && 
          mostSevereConflict.conflict.conflictType === 'battery') {
        
        const resolution = await this.generateBatteryResolution(vehicle, mostSevereConflict.conflict);
        if (resolution) {
          resolutions.push(resolution);
        }
        continue;
      }
      
      // Special handling for vertiport/landing zone conflicts
      if (mostSevereConflict.isSpecialConflict && 
          (mostSevereConflict.conflict.conflictType === 'vehicle-vertiport' ||
           mostSevereConflict.conflict.conflictType === 'vehicle-landingzone')) {
        
        const resolution = await this.generateNavigationResolution(vehicle, mostSevereConflict.conflict);
        if (resolution) {
          resolutions.push(resolution);
        }
        continue;
      }
      
      // Handle vehicle-vehicle conflicts
      if (mostSevereConflict.conflict.conflictType === 'vehicle-vehicle') {
        const resolution = await this.generateConflictResolution(
          vehicle, 
          mostSevereConflict.conflict, 
          mostSevereConflict.isVehicle1
        );
        
        if (resolution) {
          resolutions.push(resolution);
        }
      }
    }
    
    // Store resolutions if any were generated
    if (resolutions.length > 0) {
      await this.storeResolutions(resolutions);
    }
  }
  
  /**
   * Generate battery-related resolution
   * @param {Object} vehicle - Vehicle with battery issue
   * @param {Object} conflict - Battery conflict
   * @returns {Promise<Object|null>} Resolution or null
   * @private
   */
  async generateBatteryResolution(vehicle, conflict) {
    // Get current vehicle position and state
    const currentPosition = vehicle.state.position;
    const batteryRemaining = vehicle.state.batteryRemaining;
    const estimatedFlightTimeRemaining = vehicle.state.estimatedFlightTimeRemaining;
    
    // If vertiport information is available in conflict
    if (conflict.nearestVertiport) {
      const vertiport = this.vertiports.get(conflict.nearestVertiport.vertiportId);
      
      if (vertiport && conflict.canReachVertiport) {
        // Generate diversion to nearest vertiport
        return {
          resolutionId: `battery-resolution-${vehicle.vehicleId}-${Date.now()}`,
          vehicleId: vehicle.vehicleId,
          conflictId: conflict.conflictId,
          type: 'battery-diversion',
          action: 'divert-to-vertiport',
          severity: conflict.severity,
          generatedAt: new Date(),
          parameters: {
            targetVertiport: {
              vertiportId: vertiport.vertiportId,
              name: vertiport.name,
              location: vertiport.location
            },
            batteryRemaining,
            estimatedFlightTimeRemaining,
            priority: 'emergency'
          },
          description: `Divert to nearest vertiport (${vertiport.name}) due to critical battery level (${batteryRemaining.toFixed(1)}%)`
        };
      }
    }
    
    // No viable vertiport available, find nearest suitable landing zone
    const [nearestLandingZone, landingZoneDistance] = this.findNearestSuitableLandingZone(currentPosition);
    
    if (nearestLandingZone) {
      // Calculate if vehicle can reach landing zone
      const speed = vehicle.state.speed || 10; // m/s
      const timeToReach = landingZoneDistance / speed; // seconds
      
      if (timeToReach < estimatedFlightTimeRemaining) {
        return {
          resolutionId: `battery-resolution-${vehicle.vehicleId}-${Date.now()}`,
          vehicleId: vehicle.vehicleId,
          conflictId: conflict.conflictId,
          type: 'battery-diversion',
          action: 'divert-to-landing-zone',
          severity: conflict.severity,
          generatedAt: new Date(),
          parameters: {
            targetLandingZone: {
              zoneId: nearestLandingZone.zoneId,
              location: nearestLandingZone.location
            },
            batteryRemaining,
            estimatedFlightTimeRemaining,
            priority: 'emergency'
          },
          description: `Divert to nearest suitable landing zone due to critical battery level (${batteryRemaining.toFixed(1)}%)`
        };
      }
    }
    
    // Emergency landing required
    return {
      resolutionId: `battery-resolution-${vehicle.vehicleId}-${Date.now()}`,
      vehicleId: vehicle.vehicleId,
      conflictId: conflict.conflictId,
      type: 'battery-emergency',
      action: 'emergency-landing',
      severity: 'critical',
      generatedAt: new Date(),
      parameters: {
        batteryRemaining,
        estimatedFlightTimeRemaining,
        priority: 'immediate'
      },
      description: `Immediate emergency landing required due to critical battery level (${batteryRemaining.toFixed(1)}%)`
    };
  }
  
  /**
   * Find nearest suitable landing zone for emergency
   * @param {Object} position - Current position
   * @returns {[Object, number]} Tuple of [landingZone, distance]
   * @private
   */
  findNearestSuitableLandingZone(position) {
    let nearestZone = null;
    let minDistance = Infinity;
    
    for (const zone of this.landingZones.values()) {
      // Only consider available landing zones
      if (zone.status !== 'available') continue;
      
      // Calculate distance
      const distance = GeospatialUtils.distance(
        position,
        zone.location,
        'meters'
      );
      
      if (distance < minDistance) {
        minDistance = distance;
        nearestZone = zone;
      }
    }
    
    return [nearestZone, minDistance];
  }
  
  /**
   * Generate navigation resolution for vertiport/landing zone conflicts
   * @param {Object} vehicle - Vehicle with navigation issue
   * @param {Object} conflict - Navigation conflict
   * @returns {Promise<Object|null>} Resolution or null
   * @private
   */
  async generateNavigationResolution(vehicle, conflict) {
    if (conflict.conflictType === 'vehicle-vertiport') {
      // Divert away from unauthorized vertiport
      return {
        resolutionId: `nav-resolution-${vehicle.vehicleId}-${Date.now()}`,
        vehicleId: vehicle.vehicleId,
        conflictId: conflict.conflictId,
        type: 'navigation-correction',
        action: 'divert-from-vertiport',
        severity: conflict.severity,
        generatedAt: new Date(),
        parameters: {
          vertiport: {
            vertiportId: conflict.vertiport.vertiportId,
            name: conflict.vertiport.name
          },
          divertHeading: this.calculateDiversionHeading(
            conflict.vehicle.position,
            conflict.vertiport.location
          )
        },
        description: `Divert away from unauthorized vertiport (${conflict.vertiport.name})`
      };
    } else if (conflict.conflictType === 'vehicle-landingzone') {
      // Divert away from unauthorized landing zone
      return {
        resolutionId: `nav-resolution-${vehicle.vehicleId}-${Date.now()}`,
        vehicleId: vehicle.vehicleId,
        conflictId: conflict.conflictId,
        type: 'navigation-correction',
        action: 'divert-from-landing-zone',
        severity: conflict.severity,
        generatedAt: new Date(),
        parameters: {
          landingZone: {
            zoneId: conflict.landingZone.zoneId,
            vertiportId: conflict.landingZone.vertiportId
          },
          divertHeading: this.calculateDiversionHeading(
            conflict.vehicle.position,
            conflict.landingZone.location
          ),
          altitude: conflict.vehicle.position.altitude + 50 // Climb 50m
        },
        description: 'Divert away from unauthorized landing zone'
      };
    }
    
    return null;
  }
  
  /**
   * Calculate heading for diversion (opposite of current bearing)
   * @param {Object} vehiclePosition - Vehicle position
   * @param {Object} avoidPosition - Position to avoid
   * @returns {number} Heading in degrees
   * @private
   */
  calculateDiversionHeading(vehiclePosition, avoidPosition) {
    // Calculate bearing from vehicle to position to avoid
    const bearingTo = GeospatialUtils.bearing(
      vehiclePosition,
      avoidPosition
    );
    
    // Opposite direction (add 180 degrees)
    let diversionHeading = (bearingTo + 180) % 360;
    
    return diversionHeading;
  }
  
  /**
   * Generate resolution for vehicle-vehicle conflict
   * @param {Object} vehicle - Vehicle to generate resolution for
   * @param {Object} conflict - Conflict data
   * @param {boolean} isVehicle1 - Whether this vehicle is vehicle1 in the conflict
   * @returns {Promise<Object|null>} Resolution or null
   * @private
   */
  async generateConflictResolution(vehicle, conflict, isVehicle1) {
    // Get conflict data for this vehicle and the other vehicle
    const thisVehicle = isVehicle1 ? conflict.vehicle1 : conflict.vehicle2;
    const otherVehicle = isVehicle1 ? conflict.vehicle2 : conflict.vehicle1;
    
    // Get the other vehicle's full data
    const otherVehicleData = this.vehicles.get(otherVehicle.vehicleId);
    
    // Determine which vehicle should give way
    // This could be based on right-of-way rules, priority, etc.
    const shouldGiveWay = this.determineRightOfWay(vehicle, otherVehicleData, conflict);
    
    if (!shouldGiveWay) {
      // This vehicle has right of way, no resolution needed
      return null;
    }
    
    // Calculate conflict vector
    const bearing = GeospatialUtils.bearing(
      thisVehicle.position,
      otherVehicle.position
    );
    
    // Calculate perpendicular direction (turn right 90 degrees)
    const avoidanceHeading = (bearing + 90) % 360;
    
    // Generate resolution based on conflict severity and time
    if (conflict.severity === 'critical' || conflict.severity === 'high') {
      // Immediate action required
      return {
        resolutionId: `conflict-resolution-${vehicle.vehicleId}-${Date.now()}`,
        vehicleId: vehicle.vehicleId,
        conflictId: conflict.conflictId,
        type: 'conflict-avoidance',
        action: 'immediate-diversion',
        severity: conflict.severity,
        generatedAt: new Date(),
        parameters: {
          newHeading: avoidanceHeading,
          verticalChange: this.calculateVerticalAvoidance(thisVehicle, otherVehicle),
          speedChange: -2, // Slow down by 2 m/s
          minimumDistance: this.options.horizontalSeparation * 1.2, // 20% buffer
          duration: 30 // seconds
        },
        description: `Immediate avoidance maneuver to prevent conflict with ${otherVehicle.callSign || otherVehicle.vehicleId}`
      };
    } else {
      // Planned avoidance
      return {
        resolutionId: `conflict-resolution-${vehicle.vehicleId}-${Date.now()}`,
        vehicleId: vehicle.vehicleId,
        conflictId: conflict.conflictId,
        type: 'conflict-avoidance',
        action: 'planned-avoidance',
        severity: conflict.severity,
        generatedAt: new Date(),
        parameters: {
          newHeading: avoidanceHeading,
          verticalChange: this.calculateVerticalAvoidance(thisVehicle, otherVehicle),
          speedChange: -1, // Slow down slightly
          minimumDistance: this.options.horizontalSeparation * 1.1, // 10% buffer
          executionTime: new Date(conflict.predictedTime.getTime() - 60000) // 1 minute before conflict
        },
        description: `Planned avoidance maneuver for predicted conflict with ${otherVehicle.callSign || otherVehicle.vehicleId}`
      };
    }
  }
  
  /**
   * Determine which vehicle should give way
   * @param {Object} vehicle1 - First vehicle
   * @param {Object} vehicle2 - Second vehicle
   * @param {Object} conflict - Conflict data
   * @returns {boolean} True if vehicle1 should give way
   * @private
   */
  determineRightOfWay(vehicle1, vehicle2, conflict) {
    // Emergency vehicles always have right of way
    if (vehicle1.priority === 'emergency' && vehicle2.priority !== 'emergency') {
      return false;
    }
    if (vehicle2.priority === 'emergency' && vehicle1.priority !== 'emergency') {
      return true;
    }
    
    // Priority levels
    const priorityLevels = {
      'emergency': 0,
      'high': 1,
      'medium': 2,
      'low': 3,
      'normal': 3
    };
    
    // Compare priority levels
    const priority1 = priorityLevels[vehicle1.priority || 'normal'];
    const priority2 = priorityLevels[vehicle2.priority || 'normal'];
    
    if (priority1 < priority2) return false;
    if (priority2 < priority1) return true;
    
    // If same priority, use heading rules (similar to aviation right-of-way)
    if (vehicle1.state && vehicle2.state) {
      const bearing = GeospatialUtils.bearing(
        vehicle1.state.position,
        vehicle2.state.position
      );
      
      // Calculate relative bearing
      const relativeBearing = (bearing - vehicle1.state.heading + 360) % 360;
      
      // If approaching from the right, give way
      if (relativeBearing > 0 && relativeBearing < 180) {
        return true;
      } else {
        return false;
      }
    }
    
    // Default: use vehicle ID as tiebreaker (deterministic but arbitrary)
    return vehicle1.vehicleId > vehicle2.vehicleId;
  }
  
  /**
   * Calculate vertical avoidance maneuver
   * @param {Object} thisVehicle - This vehicle
   * @param {Object} otherVehicle - Other vehicle
   * @returns {number} Vertical change in meters
   * @private
   */
  calculateVerticalAvoidance(thisVehicle, otherVehicle) {
    // If this vehicle is higher, climb further; if lower, descend further
    if (thisVehicle.position.altitude > otherVehicle.position.altitude) {
      return 30; // Climb 30m
    } else {
      return -30; // Descend 30m
    }
  }
  
  /**
   * Store resolution maneuvers in database
   * @param {Array} resolutions - Array of resolutions
   * @returns {Promise<void>}
   * @private
   */
  async storeResolutions(resolutions) {
    if (!this.db) return;
    
    try {
      const resolutionsCollection = this.db.collection('iamsResolutions');
      
      // Upsert each resolution
      for (const resolution of resolutions) {
        await resolutionsCollection.updateOne(
          { resolutionId: resolution.resolutionId },
          { $set: resolution },
          { upsert: true }
        );
      }
      
      console.log(`Stored ${resolutions.length} resolution maneuvers`);
    } catch (error) {
      console.error('Error storing resolutions:', error);
    }
  }
  
  /**
   * Store conflict data in database
   * @param {Array} conflicts - Array of conflicts
   * @returns {Promise<void>}
   * @private
   */
  async storeConflictData(conflicts) {
    if (!this.conflictsCollection) return;
    
    try {
      // Upsert each conflict
      for (const conflict of conflicts) {
        await this.conflictsCollection.updateOne(
          { conflictId: conflict.conflictId },
          { $set: conflict },
          { upsert: true }
        );
      }
      
      // Update trajectories
      for (const [vehicleId, trajectory] of this.trajectories.entries()) {
        await this.trajectoriesCollection.updateOne(
          { vehicleId },
          { $set: trajectory },
          { upsert: true }
        );
      }
      
      console.log(`Stored ${conflicts.length} conflicts and ${this.trajectories.size} trajectories`);
    } catch (error) {
      console.error('Error storing conflicts:', error);
    }
  }
  
  /**
   * Process active contingency plans
   * @returns {Promise<void>}
   * @private
   */
  async processContingencyPlans() {
    // Check for contingency plan triggers
    const newContingencyPlans = await this.checkForContingencyTriggers();
    
    // Add new contingency plans
    for (const plan of newContingencyPlans) {
      this.activeContingencyPlans.set(plan.planId, plan);
    }
    
    // Process all active plans
    for (const [planId, plan] of this.activeContingencyPlans.entries()) {
      // Check if plan is completed or expired
      const now = new Date();
      if (plan.completedAt || (plan.expiresAt && now > plan.expiresAt)) {
        this.activeContingencyPlans.delete(planId);
        continue;
      }
      
      // Execute plan actions
      await this.executeContingencyPlanActions(plan);
    }
  }
  
  /**
   * Check for conditions that trigger contingency plans
   * @returns {Promise<Array>} New contingency plans
   * @private
   */
  async checkForContingencyTriggers() {
    const newPlans = [];
    
    // Check for degraded services
    if (this.degradedServices.size > 0) {
      for (const [serviceId, service] of this.degradedServices.entries()) {
        // Skip if we already have an active plan for this service
        if (Array.from(this.activeContingencyPlans.values())
            .some(p => p.trigger === 'service-degradation' && p.parameters.serviceId === serviceId)) {
          continue;
        }
        
        // Create new contingency plan
        newPlans.push({
          planId: `contingency-${serviceId}-${Date.now()}`,
          trigger: 'service-degradation',
          status: 'active',
          createdAt: new Date(),
          expiresAt: new Date(Date.now() + 3600000), // 1 hour expiration
          parameters: {
            serviceId,
            serviceName: service.serviceName,
            degradationType: service.status === 'offline' ? 'complete-loss' : 'degraded-performance',
            degradedSince: service.degradedSince
          },
          actions: []
        });
      }
    }
    
    // Check for battery emergencies (affecting multiple vehicles)
    const batteryEmergencies = Array.from(this.vehicles.values())
      .filter(v => v.state.batteryRemaining < 15 && v.state.batteryHealth < 80);
    
    if (batteryEmergencies.length >= 3) {
      // Multiple vehicles with battery issues could indicate system-wide problem
      newPlans.push({
        planId: `contingency-battery-emergency-${Date.now()}`,
        trigger: 'system-battery-emergency',
        status: 'active',
        createdAt: new Date(),
        expiresAt: new Date(Date.now() + 1800000), // 30 minute expiration
        parameters: {
          affectedVehicles: batteryEmergencies.map(v => ({
            vehicleId: v.vehicleId,
            callSign: v.callSign,
            batteryRemaining: v.state.batteryRemaining,
            batteryHealth: v.state.batteryHealth
          }))
        },
        actions: []
      });
    }
    
    // Check for communication loss with multiple vehicles
    const commsLossVehicles = Array.from(this.vehicles.values())
      .filter(v => v.state.communicationStatus === 'lost' || v.state.communicationStatus === 'degraded');
    
    if (commsLossVehicles.length >= 3) {
      // Multiple vehicles with comms issues could indicate system-wide problem
      newPlans.push({
        planId: `contingency-comms-loss-${Date.now()}`,
        trigger: 'system-communication-loss',
        status: 'active',
        createdAt: new Date(),
        expiresAt: new Date(Date.now() + 1800000), // 30 minute expiration
        parameters: {
          affectedVehicles: commsLossVehicles.map(v => ({
            vehicleId: v.vehicleId,
            callSign: v.callSign,
            communicationStatus: v.state.communicationStatus,
            lastContactTime: v.state.lastContactTime
          }))
        },
        actions: []
      });
    }
    
    return newPlans;
  }
  
  /**
   * Execute actions for a contingency plan
   * @param {Object} plan - Contingency plan
   * @returns {Promise<void>}
   * @private
   */
  async executeContingencyPlanActions(plan) {
    // Different actions based on trigger type
    switch (plan.trigger) {
      case 'service-degradation':
        await this.executeDegradedServiceActions(plan);
        break;
      
      case 'system-battery-emergency':
        await this.executeSystemBatteryEmergencyActions(plan);
        break;
      
      case 'system-communication-loss':
        await this.executeSystemCommsLossActions(plan);
        break;
    }
  }
  
  /**
   * Execute actions for degraded service
   * @param {Object} plan - Contingency plan
   * @returns {Promise<void>}
   * @private
   */
  async executeDegradedServiceActions(plan) {
    const { serviceId, serviceName, degradationType } = plan.parameters;
    
    // Log for monitoring
    console.warn(`Executing contingency plan for degraded service: ${serviceName} (${serviceId})`);
    
    // Record action if not already recorded
    if (!plan.actions.some(a => a.type === 'notification')) {
      plan.actions.push({
        type: 'notification',
        executedAt: new Date(),
        details: {
          message: `Service degradation detected: ${serviceName}`,
          severity: degradationType === 'complete-loss' ? 'high' : 'medium'
        }
      });
    }
    
    // For complete loss of critical services, take more drastic action
    if (degradationType === 'complete-loss' && 
        ['uss-connector', 'fims-connector', 'surveillance-system'].includes(serviceId)) {
      
      if (!plan.actions.some(a => a.type === 'airspace-restriction')) {
        // Restrict operations in affected airspace
        plan.actions.push({
          type: 'airspace-restriction',
          executedAt: new Date(),
          details: {
            restrictionType: 'flow-control',
            reason: `Loss of ${serviceName} service`,
            impact: 'Reduced capacity and increased separation'
          }
        });
        
        // Notify affected vehicles
        const affectedVehicles = Array.from(this.vehicles.values());
        
        for (const vehicle of affectedVehicles) {
          const notification = {
            notificationId: `notification-${vehicle.vehicleId}-${Date.now()}`,
            vehicleId: vehicle.vehicleId,
            type: 'service-degradation',
            severity: 'high',
            timestamp: new Date(),
            message: `Critical service ${serviceName} is unavailable. Operating with reduced capacity.`,
            actionRequired: true
          };
          
          // Store notification
          if (this.db) {
            const notificationsCollection = this.db.collection('iamsNotifications');
            await notificationsCollection.insertOne(notification);
          }
        }
      }
    }
  }
  
  /**
   * Execute actions for system-wide battery emergency
   * @param {Object} plan - Contingency plan
   * @returns {Promise<void>}
   * @private
   */
  async executeSystemBatteryEmergencyActions(plan) {
    const { affectedVehicles } = plan.parameters;
    
    // Log for monitoring
    console.warn(`Executing contingency plan for system battery emergency affecting ${affectedVehicles.length} vehicles`);
    
    // Record action if not already recorded
    if (!plan.actions.some(a => a.type === 'system-notification')) {
      plan.actions.push({
        type: 'system-notification',
        executedAt: new Date(),
        details: {
          message: `System battery emergency affecting ${affectedVehicles.length} vehicles`,
          severity: 'critical'
        }
      });
    }
    
    // Implement emergency measures for affected vehicles
    if (!plan.actions.some(a => a.type === 'emergency-landing-directive')) {
      // Direct affected vehicles to nearest landing zones
      const landingAssignments = [];
      
      for (const affectedVehicle of affectedVehicles) {
        const vehicle = this.vehicles.get(affectedVehicle.vehicleId);
        if (!vehicle) continue;
        
        // Find nearest landing zone
        const [landingZone, distance] = this.findNearestSuitableLandingZone(vehicle.state.position);
        
        if (landingZone) {
          landingAssignments.push({
            vehicleId: vehicle.vehicleId,
            landingZoneId: landingZone.zoneId,
            distance
          });
        }
      }
      
      plan.actions.push({
        type: 'emergency-landing-directive',
        executedAt: new Date(),
        details: {
          landingAssignments,
          priority: 'immediate'
        }
      });
      
      // Store emergency directives
      if (this.db) {
        const directivesCollection = this.db.collection('iamsDirectives');
        
        for (const assignment of landingAssignments) {
          const directive = {
            directiveId: `directive-${assignment.vehicleId}-${Date.now()}`,
            vehicleId: assignment.vehicleId,
            type: 'emergency-landing',
            timestamp: new Date(),
            parameters: {
              landingZoneId: assignment.landingZoneId,
              reason: 'System battery emergency',
              priority: 'immediate'
            }
          };
          
          await directivesCollection.insertOne(directive);
        }
      }
    }
  }
  
  /**
   * Execute actions for system-wide communication loss
   * @param {Object} plan - Contingency plan
   * @returns {Promise<void>}
   * @private
   */
  async executeSystemCommsLossActions(plan) {
    const { affectedVehicles } = plan.parameters;
    
    // Log for monitoring
    console.warn(`Executing contingency plan for system communication loss affecting ${affectedVehicles.length} vehicles`);
    
    // Record action if not already recorded
    if (!plan.actions.some(a => a.type === 'system-notification')) {
      plan.actions.push({
        type: 'system-notification',
        executedAt: new Date(),
        details: {
          message: `System communication loss affecting ${affectedVehicles.length} vehicles`,
          severity: 'high'
        }
      });
    }
    
    // Implement contingency measures
    if (!plan.actions.some(a => a.type === 'communication-contingency')) {
      // Store last known trajectories for affected vehicles
      const lastKnownTrajectories = [];
      
      for (const affectedVehicle of affectedVehicles) {
        const trajectory = this.trajectories.get(affectedVehicle.vehicleId);
        if (trajectory) {
          lastKnownTrajectories.push({
            vehicleId: affectedVehicle.vehicleId,
            lastUpdateTime: new Date(),
            trajectory: trajectory
          });
        }
      }
      
      plan.actions.push({
        type: 'communication-contingency',
        executedAt: new Date(),
        details: {
          lastKnownTrajectories,
          contingencyType: 'lost-link'
        }
      });
      
      // Store contingency data
      if (this.db) {
        const contingencyCollection = this.db.collection('iamsContingencyData');
        
        await contingencyCollection.insertOne({
          contingencyId: `contingency-comms-loss-${Date.now()}`,
          type: 'system-communication-loss',
          timestamp: new Date(),
          affectedVehicles: affectedVehicles.map(v => v.vehicleId),
          lastKnownTrajectories
        });
      }
      
      // Increase separation for all vehicles
      this.options.horizontalSeparation *= 1.5;
      this.options.verticalSeparation *= 1.5;
      
      console.warn(`Increased separation minima due to communication loss: H=${this.options.horizontalSeparation}m, V=${this.options.verticalSeparation}m`);
    }
  }
  
  /**
   * Send heartbeat to system monitor
   * @private
   */
  sendHeartbeat() {
    if (this.serviceRegistry.systemMonitor) {
      this.serviceRegistry.systemMonitor.updateServiceStatus({
        serviceId: 'iams-predictor',
        status: 'online',
        lastHeartbeat: new Date(),
        metrics: {
          activeVehicles: this.vehicles.size,
          trajectories: this.trajectories.size,
          activeContingencyPlans: this.activeContingencyPlans.size,
          degradedServices: this.degradedServices.size
        }
      });
    }
  }
  
  /**
   * Get predicted trajectory for a specific vehicle
   * @param {string} vehicleId - Vehicle ID
   * @returns {Object|null} Predicted trajectory or null if not found
   */
  getVehicleTrajectory(vehicleId) {
    return this.trajectories.get(vehicleId) || null;
  }
  
  /**
   * Get all active conflicts for a specific vehicle
   * @param {string} vehicleId - Vehicle ID
   * @returns {Promise<Array>} Array of conflicts
   */
  async getVehicleConflicts(vehicleId) {
    if (!this.conflictsCollection) return [];
    
    try {
      const conflicts = await this.conflictsCollection.find({
        $or: [
          { 'vehicle1.vehicleId': vehicleId },
          { 'vehicle2.vehicleId': vehicleId },
          { 'vehicle.vehicleId': vehicleId }
        ],
        status: 'active'
      }).toArray();
      
      return conflicts;
    } catch (error) {
      console.error(`Error getting conflicts for vehicle ${vehicleId}:`, error);
      return [];
    }
  }
  
  /**
   * Get all vertiports within a specified range of a position
   * @param {Object} position - Position to search from
   * @param {number} rangeMeters - Range in meters
   * @returns {Array} Array of vertiports within range
   */
  getVertiportsInRange(position, rangeMeters) {
    const vertiportsInRange = [];
    
    for (const vertiport of this.vertiports.values()) {
      const distance = GeospatialUtils.distance(
        position,
        vertiport.location,
        'meters'
      );
      
      if (distance <= rangeMeters) {
        vertiportsInRange.push({
          ...vertiport,
          distance
        });
      }
    }
    
    // Sort by distance
    vertiportsInRange.sort((a, b) => a.distance - b.distance);
    
    return vertiportsInRange;
  }
  
  /**
   * Check if a vehicle is in an emergency situation
   * @param {string} vehicleId - Vehicle ID
   * @returns {boolean} Whether the vehicle is in emergency
   */
  isVehicleInEmergency(vehicleId) {
    const vehicle = this.vehicles.get(vehicleId);
    if (!vehicle) return false;
    
    // Check battery level
    if (vehicle.state.batteryRemaining < 15) return true;
    
    // Check communication status
    if (vehicle.state.communicationStatus === 'lost') return true;
    
    // Check for active critical conflicts
    for (const conflict of this.predictedConflicts.values()) {
      if ((conflict.vehicle1?.vehicleId === vehicleId || conflict.vehicle2?.vehicleId === vehicleId) &&
          conflict.severity === 'critical' && 
          conflict.timeOffset < 60) { // Less than 60 seconds away
        return true;
      }
    }
    
    return false;
  }
}

module.exports = { IAMSPredictor };
```


```javascript
// Path: /IAMSBatteryHealthPredictor.js
// Written by Greg Deeds, Autonomy Association International, Inc.
// Copyright 2025 Autonomy Association International Inc., all rights reserved 
// Safeguard patent license from National Aeronautics and Space Administration (NASA)
// Copyright 2025 NASA, all rights reserved

/**
 * @fileoverview Battery health and flight time prediction for IASMS
 * @module safeguard/iams-battery-health-predictor
 */

const { Meteor } = require('meteor/meteor');

/**
 * Class for predicting battery health and remaining flight time
 * in UAM and UAS vehicles
 */
class IAMSBatteryHealthPredictor {
  /**
   * Create a new IAMSBatteryHealthPredictor instance
   * @param {Object} options - Configuration options
   * @param {Object} options.db - MongoDB database connection
   * @param {Object} options.modelProvider - ML model provider
   * @param {boolean} options.useHistoricalData - Whether to use historical data for predictions
   * @param {number} options.safetyMargin - Safety margin percentage for predictions
   * @param {Object} options.environmentalFactors - Environmental factors affecting battery
   */
  constructor(options = {}) {
    this.options = {
      useHistoricalData: options.useHistoricalData !== undefined ? options.useHistoricalData : true,
      safetyMargin: options.safetyMargin || 15, // 15% safety margin
      environmentalFactors: options.environmentalFactors || {
        temperatureEffect: true,
        altitudeEffect: true,
        windEffect: true,
        humidityEffect: true
      },
      ...options
    };
    
    this.db = options.db;
    this.batteryDataCollection = this.db ? this.db.collection('iamsBatteryData') : null;
    this.batteryModelsCollection = this.db ? this.db.collection('iamsBatteryModels') : null;
    this.weatherDataCollection = this.db ? this.db.collection('iamsWeatherData') : null;
    
    // Model provider (e.g. TensorFlow.js, custom model, etc.)
    this.modelProvider = options.modelProvider;
    
    // Cache for battery models by vehicle type
    this.batteryModels = new Map();
    
    // Battery health factor mappings
    this.healthFactors = {
      temperature: {
        optimal: { min: 15, max: 25 }, // °C
        factors: {
          cold: { temp: -10, factor: 0.6 }, // -10°C reduces capacity to 60%
          hot: { temp: 40, factor: 0.75 }   // 40°C reduces capacity to 75%
        }
      },
      altitude: {
        // Factor per 1000m altitude (due to temperature and air density)
        // At 2000m, factor would be 0.96 (4% reduction)
        factorPer1000m: 0.98
      },
      wind: {
        // Factor per 10 knots headwind
        // 20 knot headwind would use 1.12x energy (12% increase)
        factorPer10Knots: 1.06
      },
      humidity: {
        // High humidity can affect battery cooling
        // Factor at 100% humidity
        highHumidityFactor: 0.97
      },
      cycleCount: {
        // Battery capacity reduction per 100 cycles
        // After 500 cycles, capacity would be reduced to 90%
        factorPer100Cycles: 0.98
      }
    };
    
    // Battery performance models by vehicle type
    this.vehicleTypeModels = {
      'uam-passenger': {
        baseCapacity: 75, // kWh
        baseRange: 120, // km
        hoverConsumption: 40, // kW
        cruiseConsumption: 60, // kW
        maxTime: 90, // minutes
        chargeCurve: [
          { percent: 0, rate: 45 }, // kW
          { percent: 50, rate: 45 },
          { percent: 80, rate: 30 },
          { percent: 90, rate: 15 },
          { percent: 100, rate: 5 }
        ]
      },
      'uas-delivery': {
        baseCapacity: 2.5, // kWh
        baseRange: 40, // km
        hoverConsumption: 0.8, // kW
        cruiseConsumption: 1.2, // kW
        maxTime: 45, // minutes
        chargeCurve: [
          { percent: 0, rate: 1.8 }, // kW
          { percent: 50, rate: 1.8 },
          { percent: 80, rate: 1.2 },
          { percent: 90, rate: 0.6 },
          { percent: 100, rate: 0.2 }
        ]
      },
      'uas-inspection': {
        baseCapacity: 1.2, // kWh
        baseRange: 25, // km
        hoverConsumption: 0.4, // kW
        cruiseConsumption: 0.6, // kW
        maxTime: 40, // minutes
        chargeCurve: [
          { percent: 0, rate: 0.9 }, // kW
          { percent: 50, rate: 0.9 },
          { percent: 80, rate: 0.6 },
          { percent: 90, rate: 0.3 },
          { percent: 100, rate: 0.1 }
        ]
      }
    };
  }

  /**
   * Initialize the battery health predictor
   * @async
   * @returns {Promise<void>}
   */
  async initialize() {
    // Create indexes if needed
    if (this.batteryDataCollection) {
      await this.batteryDataCollection.createIndex({ vehicleId: 1 });
      await this.batteryDataCollection.createIndex({ timestamp: 1 });
      await this.batteryDataCollection.createIndex({ vehicleType: 1 });
    }
    
    if (this.batteryModelsCollection) {
      await this.batteryModelsCollection.createIndex({ vehicleType: 1 }, { unique: true });
      await this.batteryModelsCollection.createIndex({ lastUpdated: 1 });
    }
    
    // Load battery models
    await this.loadBatteryModels();
    
    console.log('IAMS Battery Health Predictor initialized');
  }
  
  /**
   * Load battery models from database
   * @async
   * @private
   */
  async loadBatteryModels() {
    if (!this.batteryModelsCollection) return;
    
    try {
      const models = await this.batteryModelsCollection.find({}).toArray();
      
      this.batteryModels.clear();
      for (const model of models) {
        this.batteryModels.set(model.vehicleType, model);
      }
      
      console.log(`Loaded ${this.batteryModels.size} battery models`);
    } catch (error) {
      console.error('Error loading battery models:', error);
    }
  }
  
  /**
   * Predict battery health and remaining flight time
   * @param {Object} vehicle - Vehicle data
   * @param {Object} flightPlan - Flight plan data
   * @param {Object} environmentalConditions - Current environmental conditions
   * @returns {Object} Battery prediction
   */
  predictBatteryHealth(vehicle, flightPlan = null, environmentalConditions = null) {
    const vehicleType = vehicle.vehicleType || 'uam-passenger';
    const batteryLevel = vehicle.batteryLevel || vehicle.batteryRemaining || 100;
    const batteryHealth = vehicle.batteryHealth || 100;
    
    // Get battery model for this vehicle type
    const baseModel = this.vehicleTypeModels[vehicleType] || this.vehicleTypeModels['uam-passenger'];
    
    // Get trained model if available
    const trainedModel = this.batteryModels.get(vehicleType);
    
    // Calculate base flight time remaining
    let baseTimeRemaining = (batteryLevel / 100) * baseModel.maxTime * 60; // in seconds
    
    // Adjust for battery health
    baseTimeRemaining *= (batteryHealth / 100);
    
    // If we have environmental conditions, apply adjustments
    if (environmentalConditions) {
      baseTimeRemaining = this.adjustForEnvironmentalFactors(
        baseTimeRemaining,
        environmentalConditions,
        vehicleType
      );
    }
    
    // If we have a flight plan, calculate more precise estimate
    let adjustedTimeRemaining = baseTimeRemaining;
    let energyRequired = null;
    let minimumSafeLevel = null;
    let recommendedReserve = null;
    
    if (flightPlan && flightPlan.waypoints && flightPlan.waypoints.length > 0) {
      const flightPlanAnalysis = this.analyzeFlightPlan(
        vehicle,
        flightPlan,
        batteryLevel,
        batteryHealth,
        environmentalConditions
      );
      
      adjustedTimeRemaining = flightPlanAnalysis.flightTimeRemaining;
      energyRequired = flightPlanAnalysis.energyRequired;
      minimumSafeLevel = flightPlanAnalysis.minimumSafeLevel;
      recommendedReserve = flightPlanAnalysis.recommendedReserve;
    }
    
    // Apply safety margin
    const safetyFactor = 1 - (this.options.safetyMargin / 100);
    const safeTimeRemaining = adjustedTimeRemaining * safetyFactor;
    
    // Determine battery risk level
    const riskLevel = this.assessBatteryRisk(
      batteryLevel,
      batteryHealth,
      safeTimeRemaining,
      flightPlan
    );
    
    // Prepare prediction result
    return {
      vehicleId: vehicle.vehicleId,
      timestamp: new Date(),
      batteryLevel,
      batteryHealth,
      baseTimeRemaining, // seconds
      adjustedTimeRemaining, // seconds
      safeTimeRemaining, // seconds
      energyRequired,
      minimumSafeLevel,
      recommendedReserve,
      riskLevel,
      safetyMargin: this.options.safetyMargin,
      modelConfidence: trainedModel ? trainedModel.confidence : 0.85,
      environmentalFactors: environmentalConditions ? 
        this.summarizeEnvironmentalImpact(environmentalConditions) : null
    };
  }
  
  /**
   * Adjust flight time for environmental factors
   * @param {number} baseTimeRemaining - Base flight time in seconds
   * @param {Object} conditions - Environmental conditions
   * @param {string} vehicleType - Vehicle type
   * @returns {number} Adjusted flight time in seconds
   * @private
   */
  adjustForEnvironmentalFactors(baseTimeRemaining, conditions, vehicleType) {
    let adjustedTime = baseTimeRemaining;
    const factors = this.healthFactors;
    
    // Adjust for temperature if enabled
    if (this.options.environmentalFactors.temperatureEffect && conditions.temperature !== undefined) {
      const temp = conditions.temperature;
      let tempFactor = 1.0;
      
      if (temp < factors.temperature.optimal.min) {
        // Interpolate for cold temperatures
        const coldTemp = factors.temperature.factors.cold.temp;
        const coldFactor = factors.temperature.factors.cold.factor;
        const optimalTemp = factors.temperature.optimal.min;
        
        if (temp <= coldTemp) {
          tempFactor = coldFactor;
        } else {
          // Linear interpolation
          tempFactor = coldFactor + (1.0 - coldFactor) * 
            ((temp - coldTemp) / (optimalTemp - coldTemp));
        }
      } else if (temp > factors.temperature.optimal.max) {
        // Interpolate for hot temperatures
        const hotTemp = factors.temperature.factors.hot.temp;
        const hotFactor = factors.temperature.factors.hot.factor;
        const optimalTemp = factors.temperature.optimal.max;
        
        if (temp >= hotTemp) {
          tempFactor = hotFactor;
        } else {
          // Linear interpolation
          tempFactor = 1.0 - (1.0 - hotFactor) * 
            ((temp - optimalTemp) / (hotTemp - optimalTemp));
        }
      }
      
      adjustedTime *= tempFactor;
    }
    
    // Adjust for altitude if enabled
    if (this.options.environmentalFactors.altitudeEffect && conditions.altitude !== undefined) {
      const altitudeInMeters = conditions.altitude;
      const altitudeFactor = Math.pow(
        factors.altitude.factorPer1000m,
        altitudeInMeters / 1000
      );
      
      adjustedTime *= altitudeFactor;
    }
    
    // Adjust for wind if enabled
    if (this.options.environmentalFactors.windEffect && 
        conditions.windSpeed !== undefined && 
        conditions.windDirection !== undefined &&
        conditions.heading !== undefined) {
      
      // Calculate headwind component
      const relativeAngle = Math.abs(conditions.windDirection - conditions.heading) % 360;
      const headwindAngle = relativeAngle > 180 ? 360 - relativeAngle : relativeAngle;
      const headwindComponent = conditions.windSpeed * Math.cos(headwindAngle * Math.PI / 180);
      
      // Only apply factor for headwind (positive headwindComponent)
      if (headwindComponent > 0) {
        const windFactor = Math.pow(
          factors.wind.factorPer10Knots,
          headwindComponent / 10
        );
        
        // Wind increases energy usage, so we divide by the factor
        adjustedTime /= windFactor;
      }
    }
    
    // Adjust for humidity if enabled
    if (this.options.environmentalFactors.humidityEffect && conditions.humidity !== undefined) {
      const humidity = conditions.humidity; // 0-100
      
      if (humidity > 80) {
        // Only high humidity has an effect
        const humidityImpact = (humidity - 80) / 20; // 0-1 scale for 80-100% humidity
        const humidityFactor = 1 - ((1 - factors.humidity.highHumidityFactor) * humidityImpact);
        
        adjustedTime *= humidityFactor;
      }
    }
    
    return adjustedTime;
  }
  
  /**
   * Analyze flight plan to predict energy usage and flight time
   * @param {Object} vehicle - Vehicle data
   * @param {Object} flightPlan - Flight plan with waypoints
   * @param {number} batteryLevel - Current battery level percentage
   * @param {number} batteryHealth - Current battery health percentage
   * @param {Object} environmentalConditions - Environmental conditions
   * @returns {Object} Flight plan analysis
   * @private
   */
  analyzeFlightPlan(vehicle, flightPlan, batteryLevel, batteryHealth, environmentalConditions) {
    const vehicleType = vehicle.vehicleType || 'uam-passenger';
    const baseModel = this.vehicleTypeModels[vehicleType] || this.vehicleTypeModels['uam-passenger'];
    
    // Calculate total distance
    let totalDistance = 0;
    let totalClimb = 0;
    let totalDescent = 0;
    let hoverTime = 0;
    
    const waypoints = flightPlan.waypoints;
    
    // Add current position as first waypoint if not included
    let effectiveWaypoints = [...waypoints];
    if (vehicle.position && waypoints.length > 0) {
      const firstWaypoint = waypoints[0];
      const distanceToFirst = this.calculateDistance(
        vehicle.position, 
        firstWaypoint.position
      );
      
      if (distanceToFirst > 100) { // If more than 100m away
        effectiveWaypoints = [
          { 
            position: vehicle.position,
            waypointType: 'current-position'
          },
          ...waypoints
        ];
      }
    }
    
    // Calculate segments
    for (let i = 0; i < effectiveWaypoints.length - 1; i++) {
      const wp1 = effectiveWaypoints[i];
      const wp2 = effectiveWaypoints[i + 1];
      
      // Calculate horizontal distance
      const distance = this.calculateDistance(wp1.position, wp2.position);
      totalDistance += distance;
      
      // Calculate vertical distance
      const altDiff = (wp2.position.altitude || 0) - (wp1.position.altitude || 0);
      if (altDiff > 0) {
        totalClimb += altDiff;
      } else {
        totalDescent += Math.abs(altDiff);
      }
      
      // Add hover time at waypoints
      if (wp2.waypointType === 'hover' || wp2.waypointType === 'loiter') {
        hoverTime += wp2.hoverTime || 30; // Default 30 seconds
      }
    }
    
    // Add takeoff and landing
    if (effectiveWaypoints.length > 0) {
      if (effectiveWaypoints[0].waypointType === 'takeoff') {
        hoverTime += 60; // 60 seconds for takeoff
      }
      
      if (effectiveWaypoints[effectiveWaypoints.length - 1].waypointType === 'landing') {
        hoverTime += 60; // 60 seconds for landing
      }
    }
    
    // Calculate energy usage
    // Base energy in kWh
    const baseCapacity = baseModel.baseCapacity * (batteryHealth / 100);
    const availableEnergy = baseCapacity * (batteryLevel / 100);
    
    // Energy usage calculations
    const cruiseEnergy = (totalDistance / 1000) * (baseModel.cruiseConsumption / baseModel.baseRange) * baseCapacity;
    const hoverEnergy = (hoverTime / 3600) * baseModel.hoverConsumption; // kWh
    const climbEnergy = totalClimb * 0.001 * baseModel.hoverConsumption / 100; // Simplified model
    
    // Total energy required for the flight
    let totalEnergyRequired = cruiseEnergy + hoverEnergy + climbEnergy;
    
    // Apply environmental adjustments if available
    if (environmentalConditions) {
      const environmentalFactor = this.calculateEnvironmentalEnergyFactor(
        environmentalConditions,
        vehicleType
      );
      
      totalEnergyRequired *= environmentalFactor;
    }
    
    // Calculate minimum safe battery level (percentage)
    const minimumSafeLevel = Math.ceil((totalEnergyRequired / baseCapacity) * 100) + 10;
    
    // Calculate recommended reserve (percentage)
    const recommendedReserve = Math.max(20, minimumSafeLevel);
    
    // Calculate flight time remaining
    let flightTimeRemaining;
    
    if (totalEnergyRequired >= availableEnergy) {
      // Not enough energy
      const energyRatio = availableEnergy / totalEnergyRequired;
      flightTimeRemaining = this.estimateFlightDuration(
        effectiveWaypoints, 
        baseModel
      ) * energyRatio;
    } else {
      // Enough energy for the flight
      const remainingEnergy = availableEnergy - totalEnergyRequired;
      const baseFlightTime = this.estimateFlightDuration(
        effectiveWaypoints, 
        baseModel
      );
      
      // Add time for remaining energy (using cruise consumption as average)
      const additionalTime = (remainingEnergy / baseModel.cruiseConsumption) * 3600;
      flightTimeRemaining = baseFlightTime + additionalTime;
    }
    
    return {
      flightTimeRemaining, // seconds
      energyRequired: totalEnergyRequired, // kWh
      minimumSafeLevel, // percentage
      recommendedReserve, // percentage
      analysis: {
        totalDistance, // meters
        totalClimb, // meters
        totalDescent, // meters
        hoverTime, // seconds
        cruiseEnergy, // kWh
        hoverEnergy, // kWh
        climbEnergy, // kWh
        availableEnergy // kWh
      }
    };
  }
  
  /**
   * Calculate distance between two positions
   * @param {Object} pos1 - First position {lat, lng}
   * @param {Object} pos2 - Second position {lat, lng}
   * @returns {number} Distance in meters
   * @private
   */
  calculateDistance(pos1, pos2) {
    const R = 6371000; // Earth radius in meters
    const lat1 = pos1.lat * Math.PI / 180;
    const lat2 = pos2.lat * Math.PI / 180;
    const deltaLat = (pos2.lat - pos1.lat) * Math.PI / 180;
    const deltaLng = (pos2.lng - pos1.lng) * Math.PI / 180;
    
    const a = Math.sin(deltaLat/2) * Math.sin(deltaLat/2) +
              Math.cos(lat1) * Math.cos(lat2) *
              Math.sin(deltaLng/2) * Math.sin(deltaLng/2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
    
    return R * c;
  }
  
  /**
   * Calculate energy factor based on environmental conditions
   * @param {Object} conditions - Environmental conditions
   * @param {string} vehicleType - Vehicle type
   * @returns {number} Energy factor (multiplier)
   * @private
   */
  calculateEnvironmentalEnergyFactor(conditions, vehicleType) {
    let factor = 1.0;
    const factors = this.healthFactors;
    
    // Temperature effect
    if (this.options.environmentalFactors.temperatureEffect && conditions.temperature !== undefined) {
      const temp = conditions.temperature;
      
      if (temp < factors.temperature.optimal.min) {
        // Cold temperature increases energy usage
        const coldTemp = factors.temperature.factors.cold.temp;
        const coldFactor = 1 / factors.temperature.factors.cold.factor; // Invert for energy usage
        const optimalTemp = factors.temperature.optimal.min;
        
        if (temp <= coldTemp) {
          factor *= coldFactor;
        } else {
          // Linear interpolation
          factor *= 1.0 + (coldFactor - 1.0) * 
            ((optimalTemp - temp) / (optimalTemp - coldTemp));
        }
      } else if (temp > factors.temperature.optimal.max) {
        // Hot temperature increases energy usage
        const hotTemp = factors.temperature.factors.hot.temp;
        const hotFactor = 1 / factors.temperature.factors.hot.factor; // Invert for energy usage
        const optimalTemp = factors.temperature.optimal.max;
        
        if (temp >= hotTemp) {
          factor *= hotFactor;
        } else {
          // Linear interpolation
          factor *= 1.0 + (hotFactor - 1.0) * 
            ((temp - optimalTemp) / (hotTemp - optimalTemp));
        }
      }
    }
    
    // Wind effect
    if (this.options.environmentalFactors.windEffect && 
        conditions.windSpeed !== undefined && 
        conditions.windDirection !== undefined &&
        conditions.heading !== undefined) {
      
      // Calculate headwind component
      const relativeAngle = Math.abs(conditions.windDirection - conditions.heading) % 360;
      const headwindAngle = relativeAngle > 180 ? 360 - relativeAngle : relativeAngle;
      const headwindComponent = conditions.windSpeed * Math.cos(headwindAngle * Math.PI / 180);
      
      // Only apply factor for headwind (positive headwindComponent)
      if (headwindComponent > 0) {
        const windFactor = Math.pow(
          factors.wind.factorPer10Knots,
          headwindComponent / 10
        );
        
        factor *= windFactor;
      }
    }
    
    // Additional factors specific to vehicle type
    if (vehicleType === 'uam-passenger') {
      // Larger vehicles are more affected by strong winds
      if (conditions.windSpeed && conditions.windSpeed > 15) {
        factor *= 1 + ((conditions.windSpeed - 15) * 0.01);
      }
    } else if (vehicleType === 'uas-inspection') {
      // Smaller vehicles are more affected by gusting
      if (conditions.windGust && conditions.windGust > 10) {
        factor *= 1 + ((conditions.windGust - 10) * 0.02);
      }
    }
    
    return factor;
  }
  
  /**
   * Estimate flight duration based on waypoints and vehicle model
   * @param {Array} waypoints - Flight plan waypoints
   * @param {Object} vehicleModel - Vehicle performance model
   * @returns {number} Estimated flight duration in seconds
   * @private
   */
  estimateFlightDuration(waypoints, vehicleModel) {
    let totalTime = 0;
    const cruiseSpeed = 20; // m/s
    
    // Calculate time for each segment
    for (let i = 0; i < waypoints.length - 1; i++) {
      const wp1 = waypoints[i];
      const wp2 = waypoints[i + 1];
      
      // Calculate horizontal distance
      const distance = this.calculateDistance(wp1.position, wp2.position);
      
      // Calculate time for this segment
      const segmentTime = distance / cruiseSpeed;
      totalTime += segmentTime;
      
      // Add hover time at waypoints
      if (wp2.waypointType === 'hover' || wp2.waypointType === 'loiter') {
        totalTime += wp2.hoverTime || 30; // Default 30 seconds
      }
    }
    
    // Add takeoff and landing
    if (waypoints.length > 0) {
      if (waypoints[0].waypointType === 'takeoff') {
        totalTime += 60; // 60 seconds for takeoff
      }
      
      if (waypoints[waypoints.length - 1].waypointType === 'landing') {
        totalTime += 60; // 60 seconds for landing
      }
    }
    
    return totalTime;
  }
  
  /**
   * Assess battery risk level
   * @param {number} batteryLevel - Current battery level percentage
   * @param {number} batteryHealth - Current battery health percentage
   * @param {number} safeTimeRemaining - Safe flight time remaining in seconds
   * @param {Object} flightPlan - Flight plan
   * @returns {string} Risk level ('critical', 'high', 'medium', 'low')
   * @private
   */
  assessBatteryRisk(batteryLevel, batteryHealth, safeTimeRemaining, flightPlan) {
    // Calculate estimated flight time needed
    let estimatedTimeNeeded = 0;
    
    if (flightPlan && flightPlan.estimatedDuration) {
      estimatedTimeNeeded = flightPlan.estimatedDuration;
    } else if (flightPlan && flightPlan.waypoints && flightPlan.waypoints.length > 1) {
      // Rough estimate based on distance to final waypoint
      const finalWaypoint = flightPlan.waypoints[flightPlan.waypoints.length - 1];
      const cruiseSpeed = 20; // m/s
      
      // Estimate time to reach final waypoint
      estimatedTimeNeeded = this.calculateDistance(
        flightPlan.waypoints[0].position,
        finalWaypoint.position
      ) / cruiseSpeed;
      
      // Add time for takeoff and landing
      estimatedTimeNeeded += 120; // 2 minutes
    }
    
    // Time margin ratio (how much extra time we have)
    const timeMarginRatio = estimatedTimeNeeded > 0 ? 
      safeTimeRemaining / estimatedTimeNeeded : 
      batteryLevel / 20; // Fallback if no flight plan
    
    // Battery health factor
    const healthFactor = batteryHealth / 100;
    
    // Combined risk assessment
    if (batteryLevel < 10 || timeMarginRatio < 1.0) {
      return 'critical';
    } else if (batteryLevel < 20 || timeMarginRatio < 1.25 || batteryHealth < 60) {
      return 'high';
    } else if (batteryLevel < 30 || timeMarginRatio < 1.5 || batteryHealth < 80) {
      return 'medium';
    } else {
      return 'low';
    }
  }
  
  /**
   * Summarize environmental impact on battery
   * @param {Object} conditions - Environmental conditions
   * @returns {Object} Summary of environmental impact
   * @private
   */
  summarizeEnvironmentalImpact(conditions) {
    const impacts = {};
    
    if (conditions.temperature !== undefined) {
      const temp = conditions.temperature;
      const optMin = this.healthFactors.temperature.optimal.min;
      const optMax = this.healthFactors.temperature.optimal.max;
      
      if (temp < optMin) {
        impacts.temperature = {
          condition: 'below_optimal',
          value: temp,
          impact: 'negative',
          description: `Temperature ${temp}°C is below optimal range (${optMin}-${optMax}°C)`
        };
      } else if (temp > optMax) {
        impacts.temperature = {
          condition: 'above_optimal',
          value: temp,
          impact: 'negative',
          description: `Temperature ${temp}°C is above optimal range (${optMin}-${optMax}°C)`
        };
      } else {
        impacts.temperature = {
          condition: 'optimal',
          value: temp,
          impact: 'neutral',
          description: `Temperature ${temp}°C is within optimal range (${optMin}-${optMax}°C)`
        };
      }
    }
    
    if (conditions.altitude !== undefined) {
      const altitude = conditions.altitude;
      
      if (altitude > 1000) {
        impacts.altitude = {
          condition: 'high_altitude',
          value: altitude,
          impact: 'negative',
          description: `Altitude ${altitude}m reduces battery efficiency`
        };
      } else {
        impacts.altitude = {
          condition: 'normal_altitude',
          value: altitude,
          impact: 'neutral',
          description: `Altitude ${altitude}m has minimal impact on battery`
        };
      }
    }
    
    if (conditions.windSpeed !== undefined) {
      const windSpeed = conditions.windSpeed;
      
      if (windSpeed > 15) {
        impacts.wind = {
          condition: 'strong_wind',
          value: windSpeed,
          impact: 'negative',
          description: `Wind speed ${windSpeed} knots significantly increases energy consumption`
        };
      } else if (windSpeed > 8) {
        impacts.wind = {
          condition: 'moderate_wind',
          value: windSpeed,
          impact: 'negative',
          description: `Wind speed ${windSpeed} knots increases energy consumption`
        };
      } else {
        impacts.wind = {
          condition: 'light_wind',
          value: windSpeed,
          impact: 'neutral',
          description: `Wind speed ${windSpeed} knots has minimal impact`
        };
      }
    }
    
    return impacts;
  }
  
  /**
   * Estimate time to safe charge level
   * @param {Object} vehicle - Vehicle data
   * @param {number} targetLevel - Target battery level percentage
   * @param {Object} chargingStation - Charging station data
   * @returns {Object} Charging time estimate
   */
  estimateChargingTime(vehicle, targetLevel, chargingStation) {
    const vehicleType = vehicle.vehicleType || 'uam-passenger';
    const currentLevel = vehicle.batteryLevel || 0;
    const batteryHealth = vehicle.batteryHealth || 100;
    
    // Skip if already at or above target
    if (currentLevel >= targetLevel) {
      return {
        currentLevel,
        targetLevel,
        estimatedTimeMinutes: 0,
        estimatedTimeSeconds: 0,
        immediatelyAvailable: true
      };
    }
    
    // Get vehicle model
    const vehicleModel = this.vehicleTypeModels[vehicleType] || this.vehicleTypeModels['uam-passenger'];
    
    // Get charging power
    const maxChargingPower = chargingStation ? 
      chargingStation.maxPower : 
      vehicleModel.chargeCurve[0].rate;
    
    // Calculate charge time based on charge curve
    let totalChargeTime = 0;
    let currentPercent = currentLevel;
    
    while (currentPercent < targetLevel) {
      // Find charging rate for current percentage
      let chargingRate = maxChargingPower;
      
      for (let i = vehicleModel.chargeCurve.length - 1; i >= 0; i--) {
        if (currentPercent >= vehicleModel.chargeCurve[i].percent) {
          chargingRate = Math.min(maxChargingPower, vehicleModel.chargeCurve[i].rate);
          break;
        }
      }
      
      // Adjust for battery health
      chargingRate *= (batteryHealth / 100);
      
      // Calculate time to charge 1% at this rate
      const timePerPercent = (vehicleModel.baseCapacity / 100) / chargingRate; // Hours per percent
      
      // Determine how much to charge in this step
      const nextThreshold = this.getNextChargeThreshold(currentPercent, vehicleModel.chargeCurve);
      const chargeStep = Math.min(targetLevel - currentPercent, nextThreshold - currentPercent);
      
      // Add time for this charging step
      totalChargeTime += timePerPercent * chargeStep;
      
      // Update current percentage
      currentPercent += chargeStep;
    }
    
    // Convert to minutes and seconds
    const totalMinutes = Math.ceil(totalChargeTime * 60);
    
    return {
      currentLevel,
      targetLevel,
      estimatedTimeMinutes: totalMinutes,
      estimatedTimeSeconds: totalMinutes * 60,
      immediatelyAvailable: totalMinutes < 5,
      chargingProfile: {
        vehicleType,
        batteryCapacity: vehicleModel.baseCapacity,
        maxChargingPower,
        adjustedForHealth: batteryHealth < 100
      }
    };
  }
  
  /**
   * Get next threshold in charge curve
   * @param {number} currentPercent - Current battery percentage
   * @param {Array} chargeCurve - Charging curve data
   * @returns {number} Next percentage threshold
   * @private
   */
  getNextChargeThreshold(currentPercent, chargeCurve) {
    for (const point of chargeCurve) {
      if (point.percent > currentPercent) {
        return point.percent;
      }
    }
    return 100;
  }
  
  /**
   * Update battery health model with new data
   * @param {Object} vehicleData - Vehicle battery data
   * @returns {Promise<boolean>} Success indicator
   */
  async updateBatteryHealthModel(vehicleData) {
    if (!this.batteryDataCollection || !this.batteryModelsCollection) {
      return false;
    }
    
    try {
      // Store battery data
      await this.batteryDataCollection.insertOne({
        vehicleId: vehicleData.vehicleId,
        vehicleType: vehicleData.vehicleType,
        timestamp: new Date(),
        batteryLevel: vehicleData.batteryLevel,
        batteryHealth: vehicleData.batteryHealth,
        cycleCount: vehicleData.cycleCount,
        temperature: vehicleData.temperature,
        voltage: vehicleData.voltage,
        current: vehicleData.current,
        energyUsed: vehicleData.energyUsed,
        flightTime: vehicleData.flightTime
      });
      
      // Only update model periodically (e.g., once we have enough new data)
      const dataCount = await this.batteryDataCollection.countDocuments({
        vehicleType: vehicleData.vehicleType,
        timestamp: { $gt: new Date(Date.now() - 86400000) } // Last 24 hours
      });
      
      if (dataCount >= 10) { // At least 10 data points
        await this.retrainBatteryModel(vehicleData.vehicleType);
      }
      
      return true;
    } catch (error) {
      console.error('Error updating battery health model:', error);
      return false;
    }
  }
  
  /**
   * Retrain battery model for a specific vehicle type
   * @param {string} vehicleType - Vehicle type
   * @returns {Promise<Object|null>} Updated model or null
   * @private
   */
  async retrainBatteryModel(vehicleType) {
    try {
      // Get historical data
      const historicalData = await this.batteryDataCollection.find({
        vehicleType
      }).sort({ timestamp: -1 }).limit(1000).toArray();
      
      if (historicalData.length < 50) {
        console.log(`Not enough data to train model for ${vehicleType}`);
        return null;
      }
      
      // In a real implementation, this would use the model provider to train
      // For now, we'll simulate a model update
      const modelUpdate = {
        vehicleType,
        lastUpdated: new Date(),
        dataPoints: historicalData.length,
        confidence: 0.85 + Math.min(0.1, historicalData.length / 10000),
        parameters: {
          batteryHealthDecayRate: 0.02, // % per cycle
          temperatureSensitivity: 0.05,
          predictedRange: this.vehicleTypeModels[vehicleType].baseRange * 0.95
        }
      };
      
      // Update model in database
      await this.batteryModelsCollection.updateOne(
        { vehicleType },
        { $set: modelUpdate },
        { upsert: true }
      );
      
      // Update local cache
      this.batteryModels.set(vehicleType, modelUpdate);
      
      console.log(`Updated battery model for ${vehicleType}`);
      return modelUpdate;
    } catch (error) {
      console.error(`Error retraining battery model for ${vehicleType}:`, error);
      return null;
    }
  }
  
  /**
   * Get current weather conditions for a location
   * @param {Object} position - Position {lat, lng}
   * @returns {Promise<Object|null>} Weather conditions or null
   * @private
   */
  async getWeatherConditions(position) {
    if (!this.weatherDataCollection) {
      return null;
    }
    
    try {
      // Find weather data near the position
      const weatherData = await this.weatherDataCollection.findOne({
        'location.coordinates': {
          $near: {
            $geometry: {
              type: 'Point',
              coordinates: [position.lng, position.lat]
            },
            $maxDistance: 10000 // 10km
          }
        },
        timestamp: { $gt: new Date(Date.now() - 3600000) } // Last hour
      });
      
      if (weatherData) {
        return {
          temperature: weatherData.temperature,
          windSpeed: weatherData.windSpeed,
          windDirection: weatherData.windDirection,
          windGust: weatherData.windGust,
          humidity: weatherData.humidity,
          precipitation: weatherData.precipitation,
          timestamp: weatherData.timestamp
        };
      }
      
      return null;
    } catch (error) {
      console.error('Error getting weather conditions:', error);
      return null;
    }
  }
}

module.exports = { IAMSBatteryHealthPredictor };
```


```javascript
// Path: /IAMSVertiportManager.js
// Written by Greg Deeds, Autonomy Association International, Inc.
// Copyright 2025 Autonomy Association International Inc., all rights reserved 
// Safeguard patent license from National Aeronautics and Space Administration (NASA)
// Copyright 2025 NASA, all rights reserved

/**
 * @fileoverview Vertiport operations management for IASMS
 * @module safeguard/iams-vertiport-manager
 */

const { Meteor } = require('meteor/meteor');
const turf = require('@turf/turf');
const { GeospatialUtils } = require('./GeospatialUtilityFunctions');

/**
 * Class for managing vertiport operations including
 * landing zone assignment, scheduling, and contingency planning
 */
class IAMSVertiportManager {
  /**
   * Create a new IAMSVertiportManager instance
   * @param {Object} options - Configuration options
   * @param {Object} options.db - MongoDB database connection
   * @param {Object} options.timeBasedFlowManager - Reference to time-based flow manager
   * @param {number} options.landingSpacing - Minimum time spacing between landings in seconds
   * @param {number} options.takeoffSpacing - Minimum time spacing between takeoffs in seconds
   * @param {number} options.emergencyBuffer - Time buffer for emergency operations in seconds
   * @param {boolean} options.optimizeForThroughput - Whether to optimize for maximum throughput
   */
  constructor(options = {}) {
    this.options = {
      landingSpacing: options.landingSpacing || 120, // 2 minutes
      takeoffSpacing: options.takeoffSpacing || 90, // 1.5 minutes
      emergencyBuffer: options.emergencyBuffer || 300, // 5 minutes
      optimizeForThroughput: options.optimizeForThroughput !== undefined ? 
        options.optimizeForThroughput : true,
      ...options
    };
    
    this.db = options.db;
    this.timeBasedFlowManager = options.timeBasedFlowManager;
    
    this.vertiportsCollection = this.db ? this.db.collection('iamsVertiports') : null;
    this.landingZonesCollection = this.db ? this.db.collection('iamsLandingZones') : null;
    this.landingReservationsCollection = this.db ? this.db.collection('iamsLandingReservations') : null;
    this.takeoffReservationsCollection = this.db ? this.db.collection('iamsTakeoffReservations') : null;
    
    // Cache for vertiport and landing zone data
    this.vertiports = new Map();
    this.landingZones = new Map();
    
    // Active reservations
    this.landingReservations = new Map();
    this.takeoffReservations = new Map();
    
    // Emergency resources
    this.emergencyLandingZones = new Map();
    this.emergencyStatusByVertiport = new Map();
    
    // Performance metrics
    this.vertiportMetrics = new Map();
  }

  /**
   * Initialize the vertiport manager
   * @async
   * @returns {Promise<void>}
   */
  async initialize() {
    // Create indexes if needed
    if (this.vertiportsCollection) {
      await this.vertiportsCollection.createIndex({ vertiportId: 1 }, { unique: true });
      await this.vertiportsCollection.createIndex({ "location.coordinates": "2dsphere" });
      await this.vertiportsCollection.createIndex({ status: 1 });
    }
    
    if (this.landingZonesCollection) {
      await this.landingZonesCollection.createIndex({ zoneId: 1 }, { unique: true });
      await this.landingZonesCollection.createIndex({ "location.coordinates": "2dsphere" });
      await this.landingZonesCollection.createIndex({ vertiportId: 1 });
      await this.landingZonesCollection.createIndex({ status: 1 });
    }
    
    if (this.landingReservationsCollection) {
      await this.landingReservationsCollection.createIndex({ reservationId: 1 }, { unique: true });
      await this.landingReservationsCollection.createIndex({ zoneId: 1 });
      await this.landingReservationsCollection.createIndex({ vertiportId: 1 });
      await this.landingReservationsCollection.createIndex({ vehicleId: 1 });
      await this.landingReservationsCollection.createIndex({ scheduledTime: 1 });
      await this.landingReservationsCollection.createIndex({ status: 1 });
    }
    
    if (this.takeoffReservationsCollection) {
      await this.takeoffReservationsCollection.createIndex({ reservationId: 1 }, { unique: true });
      await this.takeoffReservationsCollection.createIndex({ zoneId: 1 });
      await this.takeoffReservationsCollection.createIndex({ vertiportId: 1 });
      await this.takeoffReservationsCollection.createIndex({ vehicleId: 1 });
      await this.takeoffReservationsCollection.createIndex({ scheduledTime: 1 });
      await this.takeoffReservationsCollection.createIndex({ status: 1 });
    }
    
    // Load vertiports and landing zones
    await this.loadVertiports();
    await this.loadLandingZones();
    
    // Load active reservations
    await this.loadActiveReservations();
    
    // Initialize emergency landing zones
    await this.initializeEmergencyResources();
    
    console.log('IAMS Vertiport Manager initialized');
  }
  
  /**
   * Load vertiports from database
   * @async
   * @private
   */
  async loadVertiports() {
    if (!this.vertiportsCollection) return;
    
    try {
      const vertiports = await this.vertiportsCollection.find({}).toArray();
      
      this.vertiports.clear();
      for (const vertiport of vertiports) {
        this.vertiports.set(vertiport.vertiportId, vertiport);
      }
      
      console.log(`Loaded ${this.vertiports.size} vertiports`);
    } catch (error) {
      console.error('Error loading vertiports:', error);
    }
  }

  /**
   * Load landing zones from database
   * @async
   * @private
   */
  async loadLandingZones() {
    if (!this.landingZonesCollection) return;
    
    try {
      const landingZones = await this.landingZonesCollection.find({}).toArray();
      
      this.landingZones.clear();
      for (const zone of landingZones) {
        this.landingZones.set(zone.zoneId, zone);
      }
      
      console.log(`Loaded ${this.landingZones.size} landing zones`);
    } catch (error) {
      console.error('Error loading landing zones:', error);
    }
  }
  
  /**
   * Load active reservations from database
   * @async
   * @private
   */
  async loadActiveReservations() {
    if (!this.landingReservationsCollection || !this.takeoffReservationsCollection) return;
    
    try {
      // Load landing reservations
      const landingReservations = await this.landingReservationsCollection.find({
        status: { $in: ['scheduled', 'in-progress'] },
        scheduledTime: { $gte: new Date(Date.now() - 3600000) } // Last hour and future
      }).toArray();
      
      this.landingReservations.clear();
      for (const reservation of landingReservations) {
        this.landingReservations.set(reservation.reservationId, reservation);
      }
      
      // Load takeoff reservations
      const takeoffReservations = await this.takeoffReservationsCollection.find({
        status: { $in: ['scheduled', 'in-progress'] },
        scheduledTime: { $gte: new Date(Date.now() - 3600000) } // Last hour and future
      }).toArray();
      
      this.takeoffReservations.clear();
      for (const reservation of takeoffReservations) {
        this.takeoffReservations.set(reservation.reservationId, reservation);
      }
      
      console.log(`Loaded ${this.landingReservations.size} landing reservations and ${this.takeoffReservations.size} takeoff reservations`);
    } catch (error) {
      console.error('Error loading reservations:', error);
    }
  }
  
  /**
   * Initialize emergency resources
   * @async
   * @private
   */
  async initializeEmergencyResources() {
    // Designate emergency landing zones at each vertiport
    for (const [vertiportId, vertiport] of this.vertiports.entries()) {
      // Find all landing zones for this vertiport
      const vertiportLandingZones = Array.from(this.landingZones.values())
        .filter(zone => zone.vertiportId === vertiportId);
      
      // Designate at least one emergency landing zone if possible
      if (vertiportLandingZones.length > 0) {
        // Sort by capacity/size (larger is better for emergency)
        vertiportLandingZones.sort((a, b) => 
          (b.capacity || 1) - (a.capacity || 1)
        );
        
        // Designate the largest as emergency zone
        const emergencyZone = vertiportLandingZones[0];
        this.emergencyLandingZones.set(vertiportId, {
          zoneId: emergencyZone.zoneId,
          vertiportId,
          priority: 'emergency',
          reservedUntil: null // No current reservation
        });
      }
      
      // Initialize emergency status for this vertiport
      this.emergencyStatusByVertiport.set(vertiportId, {
        vertiportId,
        emergencyMode: false,
        lastEmergency: null,
        emergencyCount: 0
      });
    }
    
    console.log(`Designated ${this.emergencyLandingZones.size} emergency landing zones`);
  }
  
  /**
   * Get available landing zones for a vertiport
   * @param {string} vertiportId - Vertiport ID
   * @param {Date} requestedTime - Requested landing time
   * @param {boolean} isEmergency - Whether this is an emergency landing
   * @returns {Promise<Array>} Available landing zones
   */
  async getAvailableLandingZones(vertiportId, requestedTime, isEmergency = false) {
    // Get vertiport
    const vertiport = this.vertiports.get(vertiportId);
    if (!vertiport || vertiport.status === 'closed') {
      return [];
    }
    
    // Get all landing zones for this vertiport
    const vertiportLandingZones = Array.from(this.landingZones.values())
      .filter(zone => zone.vertiportId === vertiportId);
    
    // Filter by status (available or in emergency mode)
    const availableZones = vertiportLandingZones.filter(zone => 
      zone.status === 'available' || (isEmergency && zone.status !== 'unavailable')
    );
    
    // Check reservations for each zone
    const zoneAvailability = [];
    
    for (const zone of availableZones) {
      const isAvailable = await this.isLandingZoneAvailable(
        zone.zoneId, 
        requestedTime,
        isEmergency
      );
      
      if (isAvailable) {
        // Calculate next available time if the requested time is not available
        const nextAvailableTime = isAvailable === true ? 
          requestedTime : isAvailable;
        
        zoneAvailability.push({
          ...zone,
          available: isAvailable === true,
          nextAvailableTime
        });
      }
    }
    
    // In emergency mode, include the emergency landing zone regardless of current reservations
    if (isEmergency) {
      const emergencyZone = this.emergencyLandingZones.get(vertiportId);
      if (emergencyZone) {
        const zone = this.landingZones.get(emergencyZone.zoneId);
        if (zone && !zoneAvailability.some(z => z.zoneId === zone.zoneId)) {
          zoneAvailability.push({
            ...zone,
            available: true,
            isEmergencyZone: true,
            priority: 'emergency'
          });
        }
      }
    }
    
    // Sort by availability and priority
    zoneAvailability.sort((a, b) => {
      // First by availability
      if (a.available && !b.available) return -1;
      if (!a.available && b.available) return 1;
      
      // Then by emergency status
      if (a.isEmergencyZone && !b.isEmergencyZone) return -1;
      if (!a.isEmergencyZone && b.isEmergencyZone) return 1;
      
      // Then by priority
      const priorityOrder = { 'emergency': 0, 'high': 1, 'normal': 2, 'low': 3 };
      const aPriority = priorityOrder[a.priority || 'normal'];
      const bPriority = priorityOrder[b.priority || 'normal'];
      
      if (aPriority !== bPriority) return aPriority - bPriority;
      
      // Finally by next available time
      if (a.nextAvailableTime && b.nextAvailableTime) {
        return a.nextAvailableTime - b.nextAvailableTime;
      }
      
      return 0;
    });
    
    return zoneAvailability;
  }
  
  /**
   * Check if a landing zone is available at a specific time
   * @param {string} zoneId - Landing zone ID
   * @param {Date} requestedTime - Requested time
   * @param {boolean} isEmergency - Whether this is an emergency
   * @returns {boolean|Date} True if available, next available time if not
   * @private
   */
  async isLandingZoneAvailable(zoneId, requestedTime, isEmergency = false) {
    // If emergency, we bypass normal availability checks
    if (isEmergency) {
      return true;
    }
    
    // Get landing zone
    const zone = this.landingZones.get(zoneId);
    if (!zone || zone.status !== 'available') {
      return false;
    }
    
    // Check if there are any conflicting reservations
    const spacing = this.options.landingSpacing * 1000; // Convert to milliseconds
    const requestedTimeMs = requestedTime.getTime();
    const startWindow = new Date(requestedTimeMs - spacing);
    const endWindow = new Date(requestedTimeMs + spacing);
    
    // Get all reservations for this zone
    const landingReservations = Array.from(this.landingReservations.values())
      .filter(res => res.zoneId === zoneId && 
               res.status !== 'cancelled' &&
               res.status !== 'completed');
    
    const takeoffReservations = Array.from(this.takeoffReservations.values())
      .filter(res => res.zoneId === zoneId && 
               res.status !== 'cancelled' &&
               res.status !== 'completed');
    
    // Combine all reservations
    const allReservations = [...landingReservations, ...takeoffReservations];
    
    // Check for conflicts
    const conflicts = allReservations.filter(res => {
      const resTime = res.scheduledTime.getTime();
      return resTime >= startWindow.getTime() && resTime <= endWindow.getTime();
    });
    
    if (conflicts.length === 0) {
      return true;
    }
    
    // If there are conflicts, find the next available time
    const sortedReservations = allReservations.sort((a, b) => 
      a.scheduledTime.getTime() - b.scheduledTime.getTime()
    );
    
    // Find a slot after the requested time
    let candidateTime = requestedTimeMs;
    let foundSlot = false;
    
    while (!foundSlot && candidateTime < requestedTimeMs + 3600000) { // Look up to 1 hour ahead
      foundSlot = true;
      
      for (const res of sortedReservations) {
        const resTime = res.scheduledTime.getTime();
        if (Math.abs(resTime - candidateTime) < spacing) {
          // This slot won't work, try after this reservation
          candidateTime = resTime + spacing;
          foundSlot = false;
          break;
        }
      }
    }
    
    return foundSlot ? new Date(candidateTime) : false;
  }
  
  /**
   * Reserve a landing zone
   * @param {Object} params - Reservation parameters
   * @param {string} params.vertiportId - Vertiport ID
   * @param {string} params.zoneId - Landing zone ID
   * @param {string} params.vehicleId - Vehicle ID
   * @param {Date} params.scheduledTime - Scheduled landing time
   * @param {boolean} params.isEmergency - Whether this is an emergency landing
   * @param {string} params.priority - Reservation priority
   * @returns {Promise<Object>} Reservation result
   */
  async reserveLandingZone(params) {
    const { vertiportId, zoneId, vehicleId, scheduledTime, isEmergency, priority } = params;
    
    // Verify vertiport
    const vertiport = this.vertiports.get(vertiportId);
    if (!vertiport) {
      return {
        success: false,
        error: 'Vertiport not found',
        vertiportId
      };
    }
    
    // Verify landing zone
    const landingZone = this.landingZones.get(zoneId);
    if (!landingZone || landingZone.vertiportId !== vertiportId) {
      return {
        success: false,
        error: 'Landing zone not found or does not belong to vertiport',
        vertiportId,
        zoneId
      };
    }
    
    // Check availability (unless emergency)
    if (!isEmergency) {
      const isAvailable = await this.isLandingZoneAvailable(zoneId, scheduledTime, isEmergency);
      
      if (!isAvailable) {
        return {
          success: false,
          error: 'Landing zone not available at requested time',
          vertiportId,
          zoneId,
          requestedTime: scheduledTime,
          nextAvailableTime: isAvailable !== false ? isAvailable : null
        };
      }
    }
    
    // Create reservation
    const reservationId = `landing-${vehicleId}-${Date.now()}`;
    const reservation = {
      reservationId,
      vertiportId,
      zoneId,
      vehicleId,
      scheduledTime,
      isEmergency: isEmergency || false,
      priority: priority || (isEmergency ? 'emergency' : 'normal'),
      status: 'scheduled',
      createdAt: new Date(),
      updatedAt: new Date()
    };
    
    // Store in database
    if (this.landingReservationsCollection) {
      try {
        await this.landingReservationsCollection.insertOne(reservation);
      } catch (error) {
        console.error('Error storing landing reservation:', error);
        return {
          success: false,
          error: 'Database error storing reservation',
          vertiportId,
          zoneId
        };
      }
    }
    
    // Add to cache
    this.landingReservations.set(reservationId, reservation);
    
    // If emergency, update vertiport emergency status
    if (isEmergency) {
      const emergencyStatus = this.emergencyStatusByVertiport.get(vertiportId) || {
        vertiportId,
        emergencyMode: false,
        lastEmergency: null,
        emergencyCount: 0
      };
      
      emergencyStatus.emergencyMode = true;
      emergencyStatus.lastEmergency = new Date();
      emergencyStatus.emergencyCount++;
      
      this.emergencyStatusByVertiport.set(vertiportId, emergencyStatus);
      
      // Reserve the emergency landing zone
      const emergencyZone = this.emergencyLandingZones.get(vertiportId);
      if (emergencyZone) {
        emergencyZone.reservedUntil = new Date(scheduledTime.getTime() + 600000); // 10 minutes after
        this.emergencyLandingZones.set(vertiportId, emergencyZone);
      }
    }
    
    // Add to flow manager if available
    if (this.timeBasedFlowManager) {
      this.timeBasedFlowManager.registerLanding({
        vehicleId,
        vertiportId,
        zoneId,
        scheduledTime,
        isEmergency,
        priority: reservation.priority
      });
    }
    
    return {
      success: true,
      reservation,
      vertiport: {
        name: vertiport.name,
        location: vertiport.location
      },
      landingZone: {
        zoneId: landingZone.zoneId,
        name: landingZone.name,
        location: landingZone.location
      }
    };
  }
  
  /**
   * Reserve a takeoff slot
   * @param {Object} params - Reservation parameters
   * @param {string} params.vertiportId - Vertiport ID
   * @param {string} params.zoneId - Landing zone ID
   * @param {string} params.vehicleId - Vehicle ID
   * @param {Date} params.scheduledTime - Scheduled takeoff time
   * @param {string} params.priority - Reservation priority
   * @returns {Promise<Object>} Reservation result
   */
  async reserveTakeoffSlot(params) {
    const { vertiportId, zoneId, vehicleId, scheduledTime, priority } = params;
    
    // Verify vertiport
    const vertiport = this.vertiports.get(vertiportId);
    if (!vertiport) {
      return {
        success: false,
        error: 'Vertiport not found',
        vertiportId
      };
    }
    
    // Verify landing zone
    const landingZone = this.landingZones.get(zoneId);
    if (!landingZone || landingZone.vertiportId !== vertiportId) {
      return {
        success: false,
        error: 'Takeoff zone not found or does not belong to vertiport',
        vertiportId,
        zoneId
      };
    }
    
    // Check if vertiport is in emergency mode
    const emergencyStatus = this.emergencyStatusByVertiport.get(vertiportId);
    if (emergencyStatus && emergencyStatus.emergencyMode) {
      // Only allow takeoffs with high priority during emergency
      if (priority !== 'high' && priority !== 'emergency') {
        return {
          success: false,
          error: 'Vertiport is in emergency mode - only high priority takeoffs allowed',
          vertiportId,
          emergencySince: emergencyStatus.lastEmergency
        };
      }
    }
    
    // Check availability
    const isAvailable = await this.isTakeoffSlotAvailable(zoneId, scheduledTime);
    
    if (!isAvailable) {
      return {
        success: false,
        error: 'Takeoff slot not available at requested time',
        vertiportId,
        zoneId,
        requestedTime: scheduledTime,
        nextAvailableTime: isAvailable !== false ? isAvailable : null
      };
    }
    
    // Create reservation
    const reservationId = `takeoff-${vehicleId}-${Date.now()}`;
    const reservation = {
      reservationId,
      vertiportId,
      zoneId,
      vehicleId,
      scheduledTime,
      priority: priority || 'normal',
      status: 'scheduled',
      createdAt: new Date(),
      updatedAt: new Date()
    };
    
    // Store in database
    if (this.takeoffReservationsCollection) {
      try {
        await this.takeoffReservationsCollection.insertOne(reservation);
      } catch (error) {
        console.error('Error storing takeoff reservation:', error);
        return {
          success: false,
          error: 'Database error storing reservation',
          vertiportId,
          zoneId
        };
      }
    }
    
    // Add to cache
    this.takeoffReservations.set(reservationId, reservation);
    
    // Add to flow manager if available
    if (this.timeBasedFlowManager) {
      this.timeBasedFlowManager.registerTakeoff({
        vehicleId,
        vertiportId,
        zoneId,
        scheduledTime,
        priority: reservation.priority
      });
    }
    
    return {
      success: true,
      reservation,
      vertiport: {
        name: vertiport.name,
        location: vertiport.location
      },
      landingZone: {
        zoneId: landingZone.zoneId,
        name: landingZone.name,
        location: landingZone.location
      }
    };
  }
  
  /**
   * Check if a takeoff slot is available
   * @param {string} zoneId - Landing zone ID
   * @param {Date} requestedTime - Requested time
   * @returns {boolean|Date} True if available, next available time if not
   * @private
   */
  async isTakeoffSlotAvailable(zoneId, requestedTime) {
    // Get landing zone
    const zone = this.landingZones.get(zoneId);
    if (!zone || zone.status !== 'available') {
      return false;
    }
    
    // Check if there are any conflicting reservations
    const spacing = this.options.takeoffSpacing * 1000; // Convert to milliseconds
    const requestedTimeMs = requestedTime.getTime();
    const startWindow = new Date(requestedTimeMs - spacing);
    const endWindow = new Date(requestedTimeMs + spacing);
    
    // Get all reservations for this zone
    const takeoffReservations = Array.from(this.takeoffReservations.values())
      .filter(res => res.zoneId === zoneId && 
               res.status !== 'cancelled' &&
               res.status !== 'completed');
    
    const landingReservations = Array.from(this.landingReservations.values())
      .filter(res => res.zoneId === zoneId && 
               res.status !== 'cancelled' &&
               res.status !== 'completed');
    
    // Combine all reservations
    const allReservations = [...takeoffReservations, ...landingReservations];
    
    // Check for conflicts
    const conflicts = allReservations.filter(res => {
      const resTime = res.scheduledTime.getTime();
      return resTime >= startWindow.getTime() && resTime <= endWindow.getTime();
    });
    
    if (conflicts.length === 0) {
      return true;
    }
    
    // If there are conflicts, find the next available time
    const sortedReservations = allReservations.sort((a, b) => 
      a.scheduledTime.getTime() - b.scheduledTime.getTime()
    );
    
    // Find a slot after the requested time
    let candidateTime = requestedTimeMs;
    let foundSlot = false;
    
    while (!foundSlot && candidateTime < requestedTimeMs + 3600000) { // Look up to 1 hour ahead
      foundSlot = true;
      
      for (const res of sortedReservations) {
        const resTime = res.scheduledTime.getTime();
        if (Math.abs(resTime - candidateTime) < spacing) {
          // This slot won't work, try after this reservation
          candidateTime = resTime + spacing;
          foundSlot = false;
          break;
        }
      }
    }
    
    return foundSlot ? new Date(candidateTime) : false;
  }
  
  /**
   * Update reservation status
   * @param {Object} params - Update parameters
   * @param {string} params.reservationId - Reservation ID
   * @param {string} params.status - New status
   * @param {string} params.notes - Optional notes
   * @returns {Promise<Object>} Update result
   */
  async updateReservationStatus(params) {
    const { reservationId, status, notes } = params;
    
    // Check if it's a landing or takeoff reservation
    let reservation = this.landingReservations.get(reservationId);
    let isLanding = true;
    
    if (!reservation) {
      reservation = this.takeoffReservations.get(reservationId);
      isLanding = false;
      
      if (!reservation) {
        return {
          success: false,
          error: 'Reservation not found',
          reservationId
        };
      }
    }
    
    // Update status
    reservation.status = status;
    reservation.updatedAt = new Date();
    
    if (notes) {
      reservation.notes = notes;
    }
    
    // Store in database
    const collection = isLanding ? 
      this.landingReservationsCollection : 
      this.takeoffReservationsCollection;
    
    if (collection) {
      try {
        await collection.updateOne(
          { reservationId },
          { $set: { 
              status, 
              updatedAt: reservation.updatedAt,
              notes: notes || reservation.notes
            } 
          }
        );
      } catch (error) {
        console.error(`Error updating ${isLanding ? 'landing' : 'takeoff'} reservation:`, error);
        return {
          success: false,
          error: 'Database error updating reservation',
          reservationId
        };
      }
    }
    
    // Update cache
    if (isLanding) {
      this.landingReservations.set(reservationId, reservation);
      
      // If this was an emergency landing that completed, check if we can exit emergency mode
      if (status === 'completed' && reservation.isEmergency) {
        await this.checkEmergencyModeStatus(reservation.vertiportId);
      }
    } else {
      this.takeoffReservations.set(reservationId, reservation);
    }
    
    // Update flow manager if available
    if (this.timeBasedFlowManager) {
      if (isLanding) {
        this.timeBasedFlowManager.updateLandingStatus({
          vehicleId: reservation.vehicleId,
          vertiportId: reservation.vertiportId,
          status
        });
      } else {
        this.timeBasedFlowManager.updateTakeoffStatus({
          vehicleId: reservation.vehicleId,
          vertiportId: reservation.vertiportId,
          status
        });
      }
    }
    
    return {
      success: true,
      reservation
    };
  }
  
  /**
   * Check if vertiport can exit emergency mode
   * @param {string} vertiportId - Vertiport ID
   * @returns {Promise<boolean>} Whether emergency mode was exited
   * @private
   */
  async checkEmergencyModeStatus(vertiportId) {
    const emergencyStatus = this.emergencyStatusByVertiport.get(vertiportId);
    if (!emergencyStatus || !emergencyStatus.emergencyMode) {
      return false;
    }
    
    // Check if there are any active emergency landings
    const activeEmergencyLandings = Array.from(this.landingReservations.values())
      .filter(res => res.vertiportId === vertiportId && 
               res.isEmergency && 
               res.status !== 'completed' &&
               res.status !== 'cancelled');
    
    if (activeEmergencyLandings.length === 0) {
      // No active emergencies, exit emergency mode
      emergencyStatus.emergencyMode = false;
      this.emergencyStatusByVertiport.set(vertiportId, emergencyStatus);
      
      // Free up emergency landing zone
      const emergencyZone = this.emergencyLandingZones.get(vertiportId);
      if (emergencyZone) {
        emergencyZone.reservedUntil = null;
        this.emergencyLandingZones.set(vertiportId, emergencyZone);
      }
      
      return true;
    }
    
    return false;
  }
  
  /**
   * Handle a diversion request to a vertiport
   * @param {Object} params - Diversion parameters
   * @param {string} params.vehicleId - Vehicle ID
   * @param {string} params.vertiportId - Target vertiport ID
   * @param {Date} params.estimatedArrivalTime - Estimated arrival time
   * @param {boolean} params.isEmergency - Whether this is an emergency
   * @param {string} params.reason - Reason for diversion
   * @returns {Promise<Object>} Diversion result
   */
  async handleDiversion(params) {
    const { vehicleId, vertiportId, estimatedArrivalTime, isEmergency, reason } = params;
    
    // Find the best available landing zone
    const availableZones = await this.getAvailableLandingZones(
      vertiportId,
      estimatedArrivalTime,
      isEmergency
    );
    
    if (availableZones.length === 0) {
      return {
        success: false,
        error: 'No available landing zones',
        vertiportId,
        isEmergency,
        suggestedAlternatives: await this.findAlternativeVertiports(params)
      };
    }
    
    // Get the best landing zone
    const bestZone = availableZones[0];
    
    // Create landing reservation
    const reservationResult = await this.reserveLandingZone({
      vertiportId,
      zoneId: bestZone.zoneId,
      vehicleId,
      scheduledTime: estimatedArrivalTime,
      isEmergency,
      priority: isEmergency ? 'emergency' : 'high'
    });
    
    if (!reservationResult.success) {
      return {
        success: false,
        error: 'Failed to create landing reservation',
        vertiportId,
        isEmergency,
        details: reservationResult,
        suggestedAlternatives: await this.findAlternativeVertiports(params)
      };
    }
    
    // Record diversion
    const diversionId = `diversion-${vehicleId}-${Date.now()}`;
    const diversion = {
      diversionId,
      vehicleId,
      originalVertiportId: params.originalVertiportId,
      targetVertiportId: vertiportId,
      reservationId: reservationResult.reservation.reservationId,
      estimatedArrivalTime,
      isEmergency,
      reason,
      status: 'in-progress',
      createdAt: new Date()
    };
    
    // Store in database if available
    if (this.db) {
      const diversionsCollection = this.db.collection('iamsDiversions');
      try {
        await diversionsCollection.insertOne(diversion);
      } catch (error) {
        console.error('Error storing diversion:', error);
        // Continue anyway as the reservation is already made
      }
    }
    
    return {
      success: true,
      diversion,
      reservation: reservationResult.reservation,
      landingZone: reservationResult.landingZone,
      vertiport: reservationResult.vertiport,
      approachInstructions: this.generateApproachInstructions(
        vertiportId,
        bestZone.zoneId,
        isEmergency
      )
    };
  }
  
  /**
   * Find alternative vertiports for diversion
   * @param {Object} params - Diversion parameters
   * @returns {Promise<Array>} Alternative vertiports
   * @private
   */
  async findAlternativeVertiports(params) {
    const { vehicleId, vertiportId, estimatedArrivalTime, isEmergency, position } = params;
    
    // Can't suggest alternatives without position
    if (!position) {
      return [];
    }
    
    // Get all vertiports
    const allVertiports = Array.from(this.vertiports.values())
      .filter(v => v.vertiportId !== vertiportId && v.status !== 'closed');
    
    // Calculate distance to each vertiport
    const vertiportsWithDistance = allVertiports.map(v => ({
      ...v,
      distance: this.calculateDistance(position, v.location)
    }));
    
    // Sort by distance
    vertiportsWithDistance.sort((a, b) => a.distance - b.distance);
    
    // Take top 3 closest
    const closestVertiports = vertiportsWithDistance.slice(0, 3);
    
    // Check availability at each vertiport
    const alternatives = [];
    
    for (const vertiport of closestVertiports) {
      const availableZones = await this.getAvailableLandingZones(
        vertiport.vertiportId,
        estimatedArrivalTime,
        isEmergency
      );
      
      if (availableZones.length > 0) {
        alternatives.push({
          vertiportId: vertiport.vertiportId,
          name: vertiport.name,
          location: vertiport.location,
          distance: vertiport.distance,
          availableZones: availableZones.length,
          estimatedTime: this.estimateArrivalTime(position, vertiport.location)
        });
      }
    }
    
    return alternatives;
  }
  
  /**
   * Calculate distance between two positions
   * @param {Object} pos1 - First position {lat, lng}
   * @param {Object} pos2 - Second position {lat, lng}
   * @returns {number} Distance in meters
   * @private
   */
  calculateDistance(pos1, pos2) {
    const R = 6371000; // Earth radius in meters
    const lat1 = pos1.lat * Math.PI / 180;
    const lat2 = pos2.lat * Math.PI / 180;
    const deltaLat = (pos2.lat - pos1.lat) * Math.PI / 180;
    const deltaLng = (pos2.lng - pos1.lng) * Math.PI / 180;
    
    const a = Math.sin(deltaLat/2) * Math.sin(deltaLat/2) +
              Math.cos(lat1) * Math.cos(lat2) *
              Math.sin(deltaLng/2) * Math.sin(deltaLng/2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
    
    return R * c;
  }
  
  /**
   * Estimate arrival time based on distance
   * @param {Object} position - Current position
   * @param {Object} destination - Destination position
   * @returns {number} Estimated time in seconds
   * @private
   */
  estimateArrivalTime(position, destination) {
    const distance = this.calculateDistance(position, destination);
    const averageSpeed = 50; // m/s (about 180 km/h or 111 mph)
    
    return Math.ceil(distance / averageSpeed);
  }
  
  /**
   * Generate approach instructions for a landing zone
   * @param {string} vertiportId - Vertiport ID
   * @param {string} zoneId - Landing zone ID
   * @param {boolean} isEmergency - Whether this is an emergency
   * @returns {Object} Approach instructions
   * @private
   */
  generateApproachInstructions(vertiportId, zoneId, isEmergency) {
    const vertiport = this.vertiports.get(vertiportId);
    const landingZone = this.landingZones.get(zoneId);
    
    if (!vertiport || !landingZone) {
      return {
        instructions: 'Unable to generate approach instructions - missing data',
        isEmergency
      };
    }
    
    // Get approach direction (if specified)
    const approachDirection = landingZone.approachDirection || 0;
    
    // Get approach path
    const approachPath = landingZone.approachPath || [];
    
    // Create instructions
    const instructions = {
      vertiportName: vertiport.name,
      landingZoneName: landingZone.name,
      approachDirection,
      approachPath,
      isEmergency,
      minimumAltitude: landingZone.minimumAltitude || 100, // meters
      contactFrequency: vertiport.controlFrequency || '122.8',
      specialInstructions: isEmergency ? 
        'EMERGENCY APPROACH - direct approach authorized, notify other traffic' : 
        'Follow standard approach procedures'
    };
    
    if (isEmergency) {
      instructions.emergencyProcedures = [
        'Declare emergency to ATC and control facility',
        'Maintain stable approach',
        'Emergency services standing by',
        'Follow controller instructions'
      ];
    }
    
    return instructions;
  }
  
  /**
   * Get vertiport capacity metrics
   * @param {string} vertiportId - Vertiport ID
   * @returns {Promise<Object>} Capacity metrics
   */
  async getVertiportCapacityMetrics(vertiportId) {
    const vertiport = this.vertiports.get(vertiportId);
    if (!vertiport) {
      return {
        success: false,
        error: 'Vertiport not found',
        vertiportId
      };
    }
    
    // Get all landing zones for this vertiport
    const vertiportLandingZones = Array.from(this.landingZones.values())
      .filter(zone => zone.vertiportId === vertiportId);
    
    const availableZones = vertiportLandingZones.filter(zone => zone.status === 'available');
    
    // Get active reservations for this vertiport
    const activeReservations = {
      landings: Array.from(this.landingReservations.values())
        .filter(res => res.vertiportId === vertiportId && 
                 res.status !== 'completed' &&
                 res.status !== 'cancelled'),
      takeoffs: Array.from(this.takeoffReservations.values())
        .filter(res => res.vertiportId === vertiportId && 
                 res.status !== 'completed' &&
                 res.status !== 'cancelled')
    };
    
    // Calculate hourly capacity
    const hourlyCapacity = this.calculateHourlyCapacity(vertiportId);
    
    // Check emergency status
    const emergencyStatus = this.emergencyStatusByVertiport.get(vertiportId) || {
      emergencyMode: false,
      lastEmergency: null,
      emergencyCount: 0
    };
    
    return {
      success: true,
      vertiportId,
      name: vertiport.name,
      status: vertiport.status,
      totalLandingZones: vertiportLandingZones.length,
      availableLandingZones: availableZones.length,
      currentUtilization: {
        scheduledLandings: activeReservations.landings.length,
        scheduledTakeoffs: activeReservations.takeoffs.length,
        totalScheduled: activeReservations.landings.length + activeReservations.takeoffs.length
      },
      capacity: hourlyCapacity,
      emergencyStatus: {
        inEmergencyMode: emergencyStatus.emergencyMode,
        lastEmergency: emergencyStatus.lastEmergency,
        totalEmergencies: emergencyStatus.emergencyCount
      },
      timestamp: new Date()
    };
  }
  
  /**
   * Calculate hourly capacity for a vertiport
   * @param {string} vertiportId - Vertiport ID
   * @returns {Object} Hourly capacity
   * @private
   */
  calculateHourlyCapacity(vertiportId) {
    // Get all landing zones for this vertiport
    const vertiportLandingZones = Array.from(this.landingZones.values())
      .filter(zone => zone.vertiportId === vertiportId && zone.status === 'available');
    
    // Calculate capacity based on spacing requirements
    const landingCapacity = Math.floor(3600 / this.options.landingSpacing) * vertiportLandingZones.length;
    const takeoffCapacity = Math.floor(3600 / this.options.takeoffSpacing) * vertiportLandingZones.length;
    
    // Combined capacity is limited by the smaller of the two
    const combinedCapacity = Math.min(
      landingCapacity + takeoffCapacity,
      Math.floor(3600 / Math.min(this.options.landingSpacing, this.options.takeoffSpacing)) * vertiportLandingZones.length
    );
    
    return {
      landingsPerHour: landingCapacity,
      takeoffsPerHour: takeoffCapacity,
      combinedOperationsPerHour: combinedCapacity
    };
  }
  
  /**
   * Update vertiport status
   * @param {Object} params - Update parameters
   * @param {string} params.vertiportId - Vertiport ID
   * @param {string} params.status - New status
   * @param {string} params.reason - Reason for status change
   * @returns {Promise<Object>} Update result
   */
  async updateVertiportStatus(params) {
    const { vertiportId, status, reason } = params;
    
    // Get vertiport
    const vertiport = this.vertiports.get(vertiportId);
    if (!vertiport) {
      return {
        success: false,
        error: 'Vertiport not found',
        vertiportId
      };
    }
    
    // Update status
    vertiport.status = status;
    vertiport.statusReason = reason;
    vertiport.statusUpdatedAt = new Date();
    
    // Store in database
    if (this.vertiportsCollection) {
      try {
        await this.vertiportsCollection.updateOne(
          { vertiportId },
          { $set: { 
              status, 
              statusReason: reason,
              statusUpdatedAt: vertiport.statusUpdatedAt
            } 
          }
        );
      } catch (error) {
        console.error('Error updating vertiport status:', error);
        return {
          success: false,
          error: 'Database error updating vertiport status',
          vertiportId
        };
      }
    }
    
    // Update cache
    this.vertiports.set(vertiportId, vertiport);
    
    // If closing vertiport, handle active reservations
    if (status === 'closed') {
      await this.handleVertiportClosure(vertiportId, reason);
    }
    
    return {
      success: true,
      vertiport: {
        vertiportId,
        name: vertiport.name,
        status,
        statusReason: reason,
        statusUpdatedAt: vertiport.statusUpdatedAt
      }
    };
  }
  
  /**
   * Handle vertiport closure
   * @param {string} vertiportId - Vertiport ID
   * @param {string} reason - Closure reason
   * @returns {Promise<void>}
   * @private
   */
  async handleVertiportClosure(vertiportId, reason) {
    // Get all active reservations for this vertiport
    const activeReservations = {
      landings: Array.from(this.landingReservations.values())
        .filter(res => res.vertiportId === vertiportId && 
                 res.status !== 'completed' &&
                 res.status !== 'cancelled'),
      takeoffs: Array.from(this.takeoffReservations.values())
        .filter(res => res.vertiportId === vertiportId && 
                 res.status !== 'completed' &&
                 res.status !== 'cancelled')
    };
    
    // Cancel all scheduled takeoffs
    for (const takeoff of activeReservations.takeoffs) {
      if (takeoff.status === 'scheduled') {
        await this.updateReservationStatus({
          reservationId: takeoff.reservationId,
          status: 'cancelled',
          notes: `Vertiport closure: ${reason}`
        });
      }
    }
    
    // For scheduled landings, find alternatives
    for (const landing of activeReservations.landings) {
      if (landing.status === 'scheduled') {
        // Cancel original reservation
        await this.updateReservationStatus({
          reservationId: landing.reservationId,
          status: 'cancelled',
          notes: `Vertiport closure: ${reason}`
        });
        
        // Trigger diversion notifications (through database)
        if (this.db) {
          const diversionsCollection = this.db.collection('iamsDiversionRequests');
          await diversionsCollection.insertOne({
            vehicleId: landing.vehicleId,
            originalVertiportId: vertiportId,
            originalReservationId: landing.reservationId,
            reason: `Vertiport closure: ${reason}`,
            isEmergency: false,
            status: 'pending',
            createdAt: new Date()
          });
        }
      }
    }
    
    // Update all landing zones at this vertiport
    for (const zone of this.landingZones.values()) {
      if (zone.vertiportId === vertiportId) {
        zone.status = 'unavailable';
        zone.statusReason = `Vertiport closure: ${reason}`;
        
        // Update in database
        if (this.landingZonesCollection) {
          try {
            await this.landingZonesCollection.updateOne(
              { zoneId: zone.zoneId },
              { $set: { 
                  status: 'unavailable',
                  statusReason: zone.statusReason
                } 
              }
            );
          } catch (error) {
            console.error('Error updating landing zone status:', error);
          }
        }
      }
    }
  }
  
  /**
   * Get landing reservations for a vehicle
   * @param {string} vehicleId - Vehicle ID
   * @returns {Promise<Array>} Landing reservations
   */
  async getVehicleLandingReservations(vehicleId) {
    // Get reservations from cache
    const cachedReservations = Array.from(this.landingReservations.values())
      .filter(res => res.vehicleId === vehicleId);
    
    // If we have a database, get from there as well (more complete)
    if (this.landingReservationsCollection) {
      try {
        const dbReservations = await this.landingReservationsCollection.find({
          vehicleId
        }).toArray();
        
        // Combine and deduplicate
        const allReservations = [...cachedReservations];
        
        for (const dbRes of dbReservations) {
          if (!allReservations.some(r => r.reservationId === dbRes.reservationId)) {
            allReservations.push(dbRes);
          }
        }
        
        // Sort by scheduled time
        allReservations.sort((a, b) => a.scheduledTime - b.scheduledTime);
        
        return allReservations;
      } catch (error) {
        console.error('Error getting vehicle landing reservations:', error);
      }
    }
    
    // Return cached reservations if database query failed
    return cachedReservations.sort((a, b) => a.scheduledTime - b.scheduledTime);
  }
  
  /**
   * Get scheduled operations for a vertiport
   * @param {string} vertiportId - Vertiport ID
   * @param {Date} startTime - Start time
   * @param {Date} endTime - End time
   * @returns {Promise<Object>} Scheduled operations
   */
  async getVertiportSchedule(vertiportId, startTime, endTime) {
    // Get vertiport
    const vertiport = this.vertiports.get(vertiportId);
    if (!vertiport) {
      return {
        success: false,
        error: 'Vertiport not found',
        vertiportId
      };
    }
    
    // Default time window if not specified
    const effectiveStartTime = startTime || new Date();
    const effectiveEndTime = endTime || new Date(effectiveStartTime.getTime() + 3600000); // 1 hour
    
    // Get landing reservations
    let landingReservations;
    if (this.landingReservationsCollection) {
      try {
        landingReservations = await this.landingReservationsCollection.find({
          vertiportId,
          scheduledTime: { 
            $gte: effectiveStartTime,
            $lte: effectiveEndTime
          },
          status: { $in: ['scheduled', 'in-progress'] }
        }).toArray();
      } catch (error) {
        console.error('Error getting landing reservations:', error);
        landingReservations = Array.from(this.landingReservations.values())
          .filter(res => res.vertiportId === vertiportId && 
                   res.scheduledTime >= effectiveStartTime &&
                   res.scheduledTime <= effectiveEndTime &&
                   (res.status === 'scheduled' || res.status === 'in-progress'));
      }
    } else {
      landingReservations = Array.from(this.landingReservations.values())
        .filter(res => res.vertiportId === vertiportId && 
                 res.scheduledTime >= effectiveStartTime &&
                 res.scheduledTime <= effectiveEndTime &&
                 (res.status === 'scheduled' || res.status === 'in-progress'));
    }
    
    // Get takeoff reservations
    let takeoffReservations;
    if (this.takeoffReservationsCollection) {
      try {
        takeoffReservations = await this.takeoffReservationsCollection.find({
          vertiportId,
          scheduledTime: { 
            $gte: effectiveStartTime,
            $lte: effectiveEndTime
          },
          status: { $in: ['scheduled', 'in-progress'] }
        }).toArray();
      } catch (error) {
        console.error('Error getting takeoff reservations:', error);
        takeoffReservations = Array.from(this.takeoffReservations.values())
          .filter(res => res.vertiportId === vertiportId && 
                   res.scheduledTime >= effectiveStartTime &&
                   res.scheduledTime <= effectiveEndTime &&
                   (res.status === 'scheduled' || res.status === 'in-progress'));
      }
    } else {
      takeoffReservations = Array.from(this.takeoffReservations.values())
        .filter(res => res.vertiportId === vertiportId && 
                 res.scheduledTime >= effectiveStartTime &&
                 res.scheduledTime <= effectiveEndTime &&
                 (res.status === 'scheduled' || res.status === 'in-progress'));
    }
    
    // Get current landing zone status
    const landingZoneStatus = Array.from(this.landingZones.values())
      .filter(zone => zone.vertiportId === vertiportId)
      .map(zone => ({
        zoneId: zone.zoneId,
        name: zone.name,
        status: zone.status,
        location: zone.location
      }));
    
    // Combine into timeline of operations
    const operations = [
      ...landingReservations.map(res => ({
        type: 'landing',
        reservationId: res.reservationId,
        vehicleId: res.vehicleId,
        zoneId: res.zoneId,
        scheduledTime: res.scheduledTime,
        status: res.status,
        isEmergency: res.isEmergency || false,
        priority: res.priority
      })),
      ...takeoffReservations.map(res => ({
        type: 'takeoff',
        reservationId: res.reservationId,
        vehicleId: res.vehicleId,
        zoneId: res.zoneId,
        scheduledTime: res.scheduledTime,
        status: res.status,
        priority: res.priority
      }))
    ];
    
    // Sort by scheduled time
    operations.sort((a, b) => a.scheduledTime - b.scheduledTime);
    
    return {
      success: true,
      vertiportId,
      vertiportName: vertiport.name,
      status: vertiport.status,
      startTime: effectiveStartTime,
      endTime: effectiveEndTime,
      operations,
      landingZones: landingZoneStatus,
      emergencyStatus: this.emergencyStatusByVertiport.get(vertiportId) || {
        emergencyMode: false,
        lastEmergency: null,
        emergencyCount: 0
      }
    };
  }
}

module.exports = { IAMSVertiportManager };
```


```javascript
// Path: /IAMSContingencyPlanner.js
// Written by Greg Deeds, Autonomy Association International, Inc.
// Copyright 2025 Autonomy Association International Inc., all rights reserved 
// Safeguard patent license from National Aeronautics and Space Administration (NASA)
// Copyright 2025 NASA, all rights reserved

/**
 * @fileoverview Contingency planning for IASMS
 * @module safeguard/iams-contingency-planner
 */

const { Meteor } = require('meteor/meteor');
const turf = require('@turf/turf');
const { GeospatialUtils } = require('./GeospatialUtilityFunctions');

/**
 * Class for managing contingency plans for IASMS
 * Handles emergency scenarios, service disruptions, and recovery planning
 */
class IAMSContingencyPlanner {
  /**
   * Create a new IAMSContingencyPlanner instance
   * @param {Object} options - Configuration options
   * @param {Object} options.db - MongoDB database connection
   * @param {Object} options.predictor - IAMS Predictor reference
   * @param {Object} options.vertiportManager - Vertiport manager reference
   * @param {Object} options.weatherRiskAssessor - Weather risk assessor reference
   * @param {Object} options.serviceRegistry - Service registry
   */
  constructor(options = {}) {
    this.options = {
      contingencyUpdateFrequency: options.contingencyUpdateFrequency || 5000, // 5 seconds
      emergencyTriggers: options.emergencyTriggers || {
        batteryThreshold: 15, // 15% battery remaining
        communicationLossThreshold: 30, // 30 seconds without communication
        collisionTimeThreshold: 60, // 60 seconds to potential collision
        serviceDegradationTimeThreshold: 60 // 60 seconds grace period
      },
      ...options
    };
    
    this.db = options.db;
    this.predictor = options.predictor;
    this.vertiportManager = options.vertiportManager;
    this.weatherRiskAssessor = options.weatherRiskAssessor;
    this.serviceRegistry = options.serviceRegistry || {};
    
    // Collections
    this.contingencyPlansCollection = this.db ? this.db.collection('iamsContingencyPlans') : null;
    this.emergencyEventsCollection = this.db ? this.db.collection('iamsEmergencyEvents') : null;
    this.serviceStatusCollection = this.db ? this.db.collection('iamsServiceStatus') : null;
    
    // Active contingency plans
    this.activeContingencyPlans = new Map();
    
    // Contingency templates
    this.contingencyTemplates = new Map();
    
    // Emergency event history
    this.recentEmergencyEvents = [];
    
    // Update cycle
    this.updateInterval = null;
    this.isProcessing = false;
  }

  /**
   * Initialize the contingency planner
   * @async
   * @returns {Promise<void>}
   */
  async initialize() {
    // Create indexes if needed
    if (this.contingencyPlansCollection) {
      await this.contingencyPlansCollection.createIndex({ planId: 1 }, { unique: true });
      await this.contingencyPlansCollection.createIndex({ vehicleId: 1 });
      await this.contingencyPlansCollection.createIndex({ planType: 1 });
      await this.contingencyPlansCollection.createIndex({ status: 1 });
      await this.contingencyPlansCollection.createIndex({ createdAt: 1 });
    }
    
    if (this.emergencyEventsCollection) {
      await this.emergencyEventsCollection.createIndex({ eventId: 1 }, { unique: true });
      await this.emergencyEventsCollection.createIndex({ vehicleId: 1 });
      await this.emergencyEventsCollection.createIndex({ eventType: 1 });
      await this.emergencyEventsCollection.createIndex({ timestamp: 1 });
    }
    
    if (this.serviceStatusCollection) {
      await this.serviceStatusCollection.createIndex({ serviceId: 1 }, { unique: true });
      await this.serviceStatusCollection.createIndex({ status: 1 });
      await this.serviceStatusCollection.createIndex({ lastUpdate: 1 });
    }
    
    // Load contingency templates
    await this.loadContingencyTemplates();
    
    // Load active contingency plans
    await this.loadActiveContingencyPlans();
    
    // Start the update cycle
    this.startUpdateCycle();
    
    console.log('IAMS Contingency Planner initialized');
  }
  
  /**
   * Load contingency plan templates
   * @async
   * @private
   */
  async loadContingencyTemplates() {
    // Load templates (could be from database or hardcoded)
    this.contingencyTemplates.set('battery-emergency', {
      templateId: 'battery-emergency',
      name: 'Battery Emergency Response',
      description: 'Contingency plan for critical battery level',
      applicableVehicleTypes: ['uam-passenger', 'uas-delivery', 'uas-inspection'],
      priority: 'critical',
      actions: [
        {
          type: 'notify-vehicle',
          parameters: {
            message: 'CRITICAL BATTERY EMERGENCY - IMMEDIATE ACTION REQUIRED',
            priority: 'emergency'
          }
        },
        {
          type: 'find-emergency-landing',
          parameters: {
            searchRadius: 5000, // meters
            prioritizeVertiports: true
          }
        },
        {
          type: 'divert-to-landing-site',
          parameters: {
            priority: 'emergency'
          }
        },
        {
          type: 'notify-stakeholders',
          parameters: {
            notifyGroups: ['operators', 'atc', 'emergency-services']
          }
        }
      ]
    });
    
    this.contingencyTemplates.set('communication-loss', {
      templateId: 'communication-loss',
      name: 'Communication Loss Response',
      description: 'Contingency plan for complete loss of communication',
      applicableVehicleTypes: ['uam-passenger', 'uas-delivery', 'uas-inspection'],
      priority: 'high',
      actions: [
        {
          type: 'activate-autonomous-mode',
          parameters: {
            mode: 'lost-link'
          }
        },
        {
          type: 'store-last-known-trajectory',
          parameters: {
            extrapolationTime: 600 // seconds
          }
        },
        {
          type: 'notify-stakeholders',
          parameters: {
            notifyGroups: ['operators', 'atc']
          }
        },
        {
          type: 'monitor-last-known-path',
          parameters: {
            checkIntersections: true,
            notifyConflicts: true
          }
        }
      ]
    });
    
    this.contingencyTemplates.set('service-disruption', {
      templateId: 'service-disruption',
      name: 'Service Disruption Response',
      description: 'Contingency plan for USS or other service disruption',
      applicableVehicleTypes: ['uam-passenger', 'uas-delivery', 'uas-inspection'],
      priority: 'high',
      actions: [
        {
          type: 'increase-separation',
          parameters: {
            horizontalMultiplier: 1.5,
            verticalMultiplier: 1.5
          }
        },
        {
          type: 'reduce-operations-rate',
          parameters: {
            rateReduction: 0.5 // 50% reduction
          }
        },
        {
          type: 'notify-all-vehicles',
          parameters: {
            message: 'SERVICE DISRUPTION - OPERATING WITH INCREASED SEPARATION',
            priority: 'high'
          }
        },
        {
          type: 'activate-resilience-mode',
          parameters: {
            mode: 'reduced-dependency'
          }
        }
      ]
    });
    
    this.contingencyTemplates.set('collision-risk', {
      templateId: 'collision-risk',
      name: 'Collision Risk Response',
      description: 'Contingency plan for imminent collision risk (including bird strike)',
      applicableVehicleTypes: ['uam-passenger', 'uas-delivery', 'uas-inspection'],
      priority: 'critical',
      actions: [
        {
          type: 'execute-immediate-avoidance',
          parameters: {
            avoidanceStrategy: 'maximum-separation',
            notifyOtherVehicles: true
          }
        },
        {
          type: 'notify-vehicle',
          parameters: {
            message: 'IMMINENT COLLISION RISK - EXECUTE AVOIDANCE MANEUVER',
            priority: 'emergency'
          }
        },
        {
          type: 'assess-post-maneuver-status',
          parameters: {
            checkTrajectory: true,
            checkSystemStatus: true
          }
        },
        {
          type: 'notify-stakeholders',
          parameters: {
            notifyGroups: ['operators', 'atc']
          }
        }
      ]
    });
    
    this.contingencyTemplates.set('weather-emergency', {
      templateId: 'weather-emergency',
      name: 'Severe Weather Response',
      description: 'Contingency plan for severe weather conditions',
      applicableVehicleTypes: ['uam-passenger', 'uas-delivery', 'uas-inspection'],
      priority: 'high',
      actions: [
        {
          type: 'assess-weather-impact',
          parameters: {
            updateFrequency: 60, // seconds
            thresholds: {
              wind: 25, // knots
              visibility: 1000, // meters
              precipitation: 10 // mm/h
            }
          }
        },
        {
          type: 'calculate-weather-avoidance',
          parameters: {
            marginDistance: 2000 // meters
          }
        },
        {
          type: 'notify-all-vehicles',
          parameters: {
            message: 'WEATHER ALERT - POSSIBLE DIVERSION REQUIRED',
            priority: 'high'
          }
        },
        {
          type: 'prepare-alternate-landing-sites',
          parameters: {
            numberOfAlternates: 3
          }
        }
      ]
    });
    
    // Add more templates as needed
    
    console.log(`Loaded ${this.contingencyTemplates.size} contingency plan templates`);
  }
  
  /**
   * Load active contingency plans from database
   * @async
   * @private
   */
  async loadActiveContingencyPlans() {
    if (!this.contingencyPlansCollection) return;
    
    try {
      // Get all active plans
      const activePlans = await this.contingencyPlansCollection.find({
        status: { $in: ['active', 'in-progress'] }
      }).toArray();
      
      this.activeContingencyPlans.clear();
      for (const plan of activePlans) {
        this.activeContingencyPlans.set(plan.planId, plan);
      }
      
      console.log(`Loaded ${this.activeContingencyPlans.size} active contingency plans`);
    } catch (error) {
      console.error('Error loading active contingency plans:', error);
    }
  }
  
  /**
   * Start the contingency update cycle
   * @private
   */
  startUpdateCycle() {
    if (this.updateInterval) {
      clearInterval(this.updateInterval);
    }
    
    this.updateInterval = setInterval(() => {
      this.updateContingencyPlans().catch(err => {
        console.error('Error updating contingency plans:', err);
      });
    }, this.options.contingencyUpdateFrequency);
  }
  
  /**
   * Stop the contingency update cycle
   */
  stopUpdateCycle() {
    if (this.updateInterval) {
      clearInterval(this.updateInterval);
      this.updateInterval = null;
    }
  }
  
  /**
   * Update contingency plans
   * @async
   * @private
   */
  async updateContingencyPlans() {
    if (this.isProcessing) return;
    
    this.isProcessing = true;
    try {
      // 1. Check for new contingency triggers
      const newPlans = await this.checkForContingencyTriggers();
      
      // 2. Add new plans
      for (const plan of newPlans) {
        this.activeContingencyPlans.set(plan.planId, plan);
        await this.storePlan(plan);
      }
      
      // 3. Process active plans
      for (const [planId, plan] of this.activeContingencyPlans.entries()) {
        // Skip completed or failed plans
        if (plan.status === 'completed' || plan.status === 'failed') {
          this.activeContingencyPlans.delete(planId);
          continue;
        }
        
        // Check if plan is expired
        if (plan.expiresAt && new Date() > new Date(plan.expiresAt)) {
          plan.status = 'expired';
          await this.updatePlanStatus(planId, 'expired', 'Plan expired');
          this.activeContingencyPlans.delete(planId);
          continue;
        }
        
        // Process plan actions
        await this.processContingencyPlan(plan);
      }
      
      // 4. Cleanup old emergency events
      this.cleanupOldEmergencyEvents();
      
    } catch (error) {
      console.error('Error in contingency plan update cycle:', error);
    } finally {
      this.isProcessing = false;
    }
  }
  
  /**
   * Check for conditions that trigger contingency plans
   * @returns {Promise<Array>} New contingency plans
   * @private
   */
  async checkForContingencyTriggers() {
    const newPlans = [];
    
    // Only check if we have a predictor to get vehicle data
    if (!this.predictor) return newPlans;
    
    try {
      // Get all active vehicles
      const vehicles = this.predictor.vehicles || new Map();
      
      // Check each vehicle for contingency triggers
      for (const [vehicleId, vehicle] of vehicles.entries()) {
        // Skip if already has an active plan of the same type
        const hasActivePlan = (planType) => {
          return Array.from(this.activeContingencyPlans.values()).some(
            p => p.vehicleId === vehicleId && p.planType === planType && 
                 (p.status === 'active' || p.status === 'in-progress')
          );
        };
        
        // Check battery emergencies
        if (vehicle.state && 
            vehicle.state.batteryRemaining !== undefined && 
            vehicle.state.batteryRemaining <= this.options.emergencyTriggers.batteryThreshold) {
          
          if (!hasActivePlan('battery-emergency')) {
            const plan = await this.createContingencyPlan(
              'battery-emergency', 
              vehicle, 
              { batteryLevel: vehicle.state.batteryRemaining }
            );
            
            if (plan) newPlans.push(plan);
          }
        }
        
        // Check communication loss
        if (vehicle.state && 
            vehicle.state.communicationStatus === 'lost' && 
            vehicle.state.lastContactTime && 
            (Date.now() - vehicle.state.lastContactTime) / 1000 >= this.options.emergencyTriggers.communicationLossThreshold) {
          
          if (!hasActivePlan('communication-loss')) {
            const plan = await this.createContingencyPlan(
              'communication-loss', 
              vehicle, 
              { 
                lastContactTime: vehicle.state.lastContactTime,
                timeSinceContact: (Date.now() - vehicle.state.lastContactTime) / 1000
              }
            );
            
            if (plan) newPlans.push(plan);
          }
        }
        
        // Check collision risks (including bird strike risk)
        if (this.predictor.predictedConflicts) {
          const vehicleConflicts = Array.from(this.predictor.predictedConflicts.values())
            .filter(conflict => 
              (conflict.vehicle1?.vehicleId === vehicleId || conflict.vehicle2?.vehicleId === vehicleId) &&
              conflict.severity === 'critical' &&
              conflict.timeOffset <= this.options.emergencyTriggers.collisionTimeThreshold
            );
          
          if (vehicleConflicts.length > 0 && !hasActivePlan('collision-risk')) {
            const plan = await this.createContingencyPlan(
              'collision-risk', 
              vehicle, 
              { conflicts: vehicleConflicts }
            );
            
            if (plan) newPlans.push(plan);
          }
        }
      }
      
      // Check for service disruptions
      const serviceDisruptions = await this.checkServiceDisruptions();
      if (serviceDisruptions.length > 0) {
        // Check if we already have an active service disruption plan
        const hasServiceDisruptionPlan = Array.from(this.activeContingencyPlans.values())
          .some(p => p.planType === 'service-disruption' && 
                     (p.status === 'active' || p.status === 'in-progress'));
        
        if (!hasServiceDisruptionPlan) {
          const plan = await this.createServiceDisruptionPlan(serviceDisruptions);
          if (plan) newPlans.push(plan);
        }
      }
      
      // Check for severe weather
      if (this.weatherRiskAssessor) {
        const weatherEmergencies = await this.weatherRiskAssessor.getSevereWeatherAlerts();
        
        if (weatherEmergencies.length > 0) {
          // Check if we already have an active weather emergency plan
          const hasWeatherEmergencyPlan = Array.from(this.activeContingencyPlans.values())
            .some(p => p.planType === 'weather-emergency' && 
                      (p.status === 'active' || p.status === 'in-progress'));
          
          if (!hasWeatherEmergencyPlan) {
            const plan = await this.createWeatherEmergencyPlan(weatherEmergencies);
            if (plan) newPlans.push(plan);
          }
        }
      }
      
    } catch (error) {
      console.error('Error checking for contingency triggers:', error);
    }
    
    return newPlans;
  }
  
  /**
   * Check for service disruptions
   * @returns {Promise<Array>} Service disruptions
   * @private
   */
  async checkServiceDisruptions() {
    const disruptions = [];
    
    if (!this.serviceStatusCollection) return disruptions;
    
    try {
      // Get service status
      const services = await this.serviceStatusCollection.find({}).toArray();
      
      const now = new Date();
      const staleThreshold = this.options.emergencyTriggers.serviceDegradationTimeThreshold * 1000;
      
      for (const service of services) {
        // Check if service is degraded or offline
        if (service.status !== 'online') {
          disruptions.push({
            serviceId: service.serviceId,
            serviceName: service.serviceName,
            status: service.status,
            lastUpdate: service.lastUpdate,
            disruptionType: 'status-degraded'
          });
          continue;
        }
        
        // Check if service is stale
        const lastUpdate = new Date(service.lastUpdate);
        const timeSinceUpdate = now - lastUpdate;
        
        if (timeSinceUpdate > staleThreshold) {
          disruptions.push({
            serviceId: service.serviceId,
            serviceName: service.serviceName,
            status: 'stale',
            lastUpdate: service.lastUpdate,
            timeSinceUpdate,
            disruptionType: 'stale-data'
          });
        }
      }
    } catch (error) {
      console.error('Error checking service disruptions:', error);
    }
    
    return disruptions;
  }
  
  /**
   * Create a contingency plan from a template
   * @param {string} templateId - Template ID
   * @param {Object} vehicle - Vehicle data
   * @param {Object} context - Additional context
   * @returns {Promise<Object|null>} Contingency plan or null
   * @private
   */
  async createContingencyPlan(templateId, vehicle, context = {}) {
    // Get template
    const template = this.contingencyTemplates.get(templateId);
    if (!template) {
      console.error(`Contingency template not found: ${templateId}`);
      return null;
    }
    
    // Check if vehicle type is applicable
    if (template.applicableVehicleTypes && 
        !template.applicableVehicleTypes.includes(vehicle.vehicleType)) {
      console.log(`Template ${templateId} not applicable to vehicle type ${vehicle.vehicleType}`);
      return null;
    }
    
    // Create plan ID
    const planId = `contingency-${vehicle.vehicleId}-${templateId}-${Date.now()}`;
    
    // Create plan
    const plan = {
      planId,
      templateId,
      planType: templateId,
      name: template.name,
      description: template.description,
      vehicleId: vehicle.vehicleId,
      vehicleType: vehicle.vehicleType,
      priority: template.priority,
      status: 'active',
      createdAt: new Date(),
      updatedAt: new Date(),
      expiresAt: new Date(Date.now() + 3600000), // 1 hour expiration by default
      context: {
        vehicleCallsign: vehicle.callSign,
        vehiclePosition: vehicle.state ? vehicle.state.position : null,
        ...context
      },
      actions: template.actions.map(action => ({
        ...action,
        status: 'pending',
        attempts: 0,
        lastAttempt: null,
        result: null
      })),
      logs: [
        {
          timestamp: new Date(),
          message: `Contingency plan created: ${template.name}`,
          type: 'info'
        }
      ]
    };
    
    // Record emergency event
    await this.recordEmergencyEvent({
      vehicleId: vehicle.vehicleId,
      eventType: templateId,
      severity: template.priority,
      details: context
    });
    
    return plan;
  }
  
  /**
   * Create a service disruption contingency plan
   * @param {Array} disruptions - Service disruptions
   * @returns {Promise<Object|null>} Contingency plan or null
   * @private
   */
  async createServiceDisruptionPlan(disruptions) {
    // Get template
    const template = this.contingencyTemplates.get('service-disruption');
    if (!template) {
      console.error('Service disruption template not found');
      return null;
    }
    
    // Create plan ID
    const planId = `contingency-service-disruption-${Date.now()}`;
    
    // Categorize disruptions
    const criticalDisruptions = disruptions.filter(d => 
      ['uss-connector', 'fims-connector', 'surveillance-system'].includes(d.serviceId)
    );
    
    const priority = criticalDisruptions.length > 0 ? 'critical' : 'high';
    
    // Create plan
    const plan = {
      planId,
      templateId: 'service-disruption',
      planType: 'service-disruption',
      name: template.name,
      description: template.description,
      vehicleId: null, // System-wide plan
      priority,
      status: 'active',
      createdAt: new Date(),
      updatedAt: new Date(),
      expiresAt: new Date(Date.now() + 7200000), // 2 hour expiration by default
      context: {
        disruptions,
        criticalServicesAffected: criticalDisruptions.length > 0,
        affectedServices: disruptions.map(d => d.serviceName).join(', ')
      },
      actions: template.actions.map(action => ({
        ...action,
        status: 'pending',
        attempts: 0,
        lastAttempt: null,
        result: null
      })),
      logs: [
        {
          timestamp: new Date(),
          message: `Service disruption contingency plan created for ${disruptions.length} services`,
          type: 'info'
        }
      ]
    };
    
    // Record emergency event
    await this.recordEmergencyEvent({
      vehicleId: null,
      eventType: 'service-disruption',
      severity: priority,
      details: {
        disruptions,
        criticalServicesAffected: criticalDisruptions.length > 0
      }
    });
    
    return plan;
  }
  
  /**
   * Create a weather emergency contingency plan
   * @param {Array} weatherAlerts - Weather alerts
   * @returns {Promise<Object|null>} Contingency plan or null
   * @private
   */
  async createWeatherEmergencyPlan(weatherAlerts) {
    // Get template
    const template = this.contingencyTemplates.get('weather-emergency');
    if (!template) {
      console.error('Weather emergency template not found');
      return null;
    }
    
    // Create plan ID
    const planId = `contingency-weather-emergency-${Date.now()}`;
    
    // Determine severity based on alerts
    const hasCritical = weatherAlerts.some(alert => alert.severity === 'critical');
    const priority = hasCritical ? 'critical' : 'high';
    
    // Create plan
    const plan = {
      planId,
      templateId: 'weather-emergency',
      planType: 'weather-emergency',
      name: template.name,
      description: template.description,
      vehicleId: null, // System-wide plan
      priority,
      status: 'active',
      createdAt: new Date(),
      updatedAt: new Date(),
      expiresAt: new Date(Date.now() + 7200000), // 2 hour expiration by default
      context: {
        weatherAlerts,
        affectedAreas: weatherAlerts.map(alert => alert.areaDescription || 'Unknown').join(', ')
      },
      actions: template.actions.map(action => ({
        ...action,
        status: 'pending',
        attempts: 0,
        lastAttempt: null,
        result: null
      })),
      logs: [
        {
          timestamp: new Date(),
          message: `Weather emergency contingency plan created for ${weatherAlerts.length} alerts`,
          type: 'info'
        }
      ]
    };
    
    // Record emergency event
    await this.recordEmergencyEvent({
      vehicleId: null,
      eventType: 'weather-emergency',
      severity: priority,
      details: {
        weatherAlerts
      }
    });
    
    return plan;
  }
  
  /**
   * Process actions for a contingency plan
   * @param {Object} plan - Contingency plan
   * @returns {Promise<void>}
   * @private
   */
  async processContingencyPlan(plan) {
    // Process each pending action in order
    let allCompleted = true;
    let hasFailed = false;
    
    for (const action of plan.actions) {
      // Skip actions that are already completed or failed
      if (action.status === 'completed') continue;
      if (action.status === 'failed') {
        hasFailed = true;
        continue;
      }
      
      // If previous action failed and this action depends on it, mark as skipped
      if (hasFailed && action.dependsOnPrevious) {
        action.status = 'skipped';
        action.result = {
          success: false,
          error: 'Previous dependent action failed'
        };
        continue;
      }
      
      // Process pending action
      if (action.status === 'pending' || action.status === 'in-progress') {
        allCompleted = false;
        
        // Update action status
        action.status = 'in-progress';
        action.lastAttempt = new Date();
        action.attempts++;
        
        // Execute action
        try {
          const actionResult = await this.executeContingencyAction(
            action, 
            plan
          );
          
          // Update action with result
          action.result = actionResult;
          action.status = actionResult.success ? 'completed' : 'failed';
          
          if (!actionResult.success) {
            hasFailed = true;
            plan.logs.push({
              timestamp: new Date(),
              message: `Action failed: ${action.type} - ${actionResult.error || 'Unknown error'}`,
              type: 'error'
            });
          } else {
            plan.logs.push({
              timestamp: new Date(),
              message: `Action completed: ${action.type}`,
              type: 'info'
            });
          }
        } catch (error) {
          // Handle action execution error
          action.status = 'failed';
          action.result = {
            success: false,
            error: error.message || 'Unknown error'
          };
          
          hasFailed = true;
          plan.logs.push({
            timestamp: new Date(),
            message: `Action error: ${action.type} - ${error.message || 'Unknown error'}`,
            type: 'error'
          });
        }
        
        // Update plan timestamp
        plan.updatedAt = new Date();
        
        // Only process one action at a time
        break;
      }
    }
    
    // Update plan status
    if (allCompleted) {
      plan.status = 'completed';
      plan.completedAt = new Date();
      plan.logs.push({
        timestamp: new Date(),
        message: `Contingency plan completed: ${plan.name}`,
        type: 'info'
      });
    } else if (hasFailed && plan.actions.every(a => 
      a.status === 'completed' || a.status === 'failed' || a.status === 'skipped'
    )) {
      plan.status = 'failed';
      plan.failedAt = new Date();
      plan.logs.push({
        timestamp: new Date(),
        message: `Contingency plan failed: ${plan.name}`,
        type: 'error'
      });
    }
    
    // Update plan in database
    await this.updatePlan(plan);
  }
  
  /**
   * Execute a contingency action
   * @param {Object} action - Action to execute
   * @param {Object} plan - Contingency plan
   * @returns {Promise<Object>} Action result
   * @private
   */
  async executeContingencyAction(action, plan) {
    // Default result structure
    const result = {
      success: false,
      timestamp: new Date(),
      details: {}
    };
    
    // Execute action based on type
    switch (action.type) {
      case 'notify-vehicle':
        return await this.executeNotifyVehicleAction(action, plan);
      
      case 'find-emergency-landing':
        return await this.executeFindEmergencyLandingAction(action, plan);
      
      case 'divert-to-landing-site':
        return await this.executeDivertToLandingSiteAction(action, plan);
      
      case 'notify-stakeholders':
        return await this.executeNotifyStakeholdersAction(action, plan);
      
      case 'activate-autonomous-mode':
        return await this.executeActivateAutonomousModeAction(action, plan);
      
      case 'store-last-known-trajectory':
        return await this.executeStoreLastKnownTrajectoryAction(action, plan);
      
      case 'monitor-last-known-path':
        return await this.executeMonitorLastKnownPathAction(action, plan);
      
      case 'increase-separation':
        return await this.executeIncreaseSeparationAction(action, plan);
      
      case 'reduce-operations-rate':
        return await this.executeReduceOperationsRateAction(action, plan);
      
      case 'notify-all-vehicles':
        return await this.executeNotifyAllVehiclesAction(action, plan);
      
      case 'activate-resilience-mode':
        return await this.executeActivateResilienceModeAction(action, plan);
      
      case 'execute-immediate-avoidance':
        return await this.executeImmediateAvoidanceAction(action, plan);
      
      case 'assess-post-maneuver-status':
        return await this.executeAssessPostManeuverStatusAction(action, plan);
      
      case 'assess-weather-impact':
        return await this.executeAssessWeatherImpactAction(action, plan);
      
      case 'calculate-weather-avoidance':
        return await this.executeCalculateWeatherAvoidanceAction(action, plan);
      
      case 'prepare-alternate-landing-sites':
        return await this.executePrepareAlternateLandingSitesAction(action, plan);
      
      default:
        result.error = `Unknown action type: ${action.type}`;
        return result;
    }
  }
  
  /**
   * Execute notify vehicle action
   * @param {Object} action - Action to execute
   * @param {Object} plan - Contingency plan
   * @returns {Promise<Object>} Action result
   * @private
   */
  async executeNotifyVehicleAction(action, plan) {
    const result = {
      success: false,
      timestamp: new Date(),
      details: {}
    };
    
    // Need vehicle ID
    if (!plan.vehicleId) {
      result.error = 'No vehicle ID specified';
      return result;
    }
    
    try {
      // Create notification in database
      if (this.db) {
        const notificationsCollection = this.db.collection('iamsNotifications');
        const notification = {
          notificationId: `notification-${plan.vehicleId}-${Date.now()}`,
          vehicleId: plan.vehicleId,
          type: 'contingency',
          contingencyPlanId: plan.planId,
          severity: action.parameters.priority || 'high',
          timestamp: new Date(),
          message: action.parameters.message,
          details: {
            contingencyType: plan.planType,
            planName: plan.name,
            actionRequired: true
          }
        };
        
        await notificationsCollection.insertOne(notification);
        result.details.notification = notification;
      }
      
      // If we have a direct communication channel, use it
      // (This would depend on implementation details)
      
      result.success = true;
      result.details.message = action.parameters.message;
      result.details.priority = action.parameters.priority;
    } catch (error) {
      result.error = `Failed to notify vehicle: ${error.message}`;
    }
    
    return result;
  }
  
  /**
   * Execute find emergency landing action
   * @param {Object} action - Action to execute
   * @param {Object} plan - Contingency plan
   * @returns {Promise<Object>} Action result
   * @private
   */
  async executeFindEmergencyLandingAction(action, plan) {
    const result = {
      success: false,
      timestamp: new Date(),
      details: {}
    };
    
    // Need vehicle ID and position
    if (!plan.vehicleId || !plan.context.vehiclePosition) {
      result.error = 'No vehicle ID or position specified';
      return result;
    }
    
    try {
      const searchRadius = action.parameters.searchRadius || 5000; // meters
      const prioritizeVertiports = action.parameters.prioritizeVertiports !== false;
      
      // Check if vertiport manager is available
      if (this.vertiportManager && prioritizeVertiports) {
        // Get nearby vertiports
        const nearbyVertiports = await this.findNearbyVertiports(
          plan.context.vehiclePosition,
          searchRadius
        );
        
        if (nearbyVertiports.length > 0) {
          // Find available landing zones
          const landingOptions = [];
          
          for (const vertiport of nearbyVertiports) {
            const isEmergency = plan.priority === 'critical';
            const estimatedArrivalTime = new Date(Date.now() + 
              Math.ceil(vertiport.distance / 20) * 1000); // Rough estimate: 20 m/s
            
            const availableZones = await this.vertiportManager.getAvailableLandingZones(
              vertiport.vertiportId,
              estimatedArrivalTime,
              isEmergency
            );
            
            if (availableZones.length > 0) {
              landingOptions.push({
                vertiport,
                availableZones,
                estimatedArrivalTime
              });
            }
          }
          
          if (landingOptions.length > 0) {
            // Sort options by distance
            landingOptions.sort((a, b) => a.vertiport.distance - b.vertiport.distance);
            
            // Set the best option in plan context
            plan.context.emergencyLandingOption = landingOptions[0];
            plan.context.allLandingOptions = landingOptions;
            
            result.success = true;
            result.details.landingOptions = landingOptions;
            return result;
          }
        }
      }
      
      // If no vertiport is available or vertiport manager is not available,
      // find suitable emergency landing sites (open areas, etc.)
      const emergencySites = await this.findEmergencyLandingSites(
        plan.context.vehiclePosition,
        searchRadius
      );
      
      if (emergencySites.length > 0) {
        // Sort by suitability
        emergencySites.sort((a, b) => b.suitabilityScore - a.suitabilityScore);
        
        // Set the best option in plan context
        plan.context.emergencyLandingSite = emergencySites[0];
        plan.context.allEmergencySites = emergencySites;
        
        result.success = true;
        result.details.emergencySites = emergencySites;
        return result;
      }
      
      // No suitable landing sites found
      result.error = 'No suitable emergency landing sites found';
    } catch (error) {
      result.error = `Failed to find emergency landing site: ${error.message}`;
    }
    
    return result;
  }
  
  /**
   * Find nearby vertiports
   * @param {Object} position - Current position
   * @param {number} radius - Search radius in meters
   * @returns {Promise<Array>} Nearby vertiports
   * @private
   */
  async findNearbyVertiports(position, radius) {
    if (!this.vertiportManager) {
      return [];
    }
    
    try {
      // Get all vertiports from vertiport manager
      const vertiports = Array.from(this.vertiportManager.vertiports.values())
        .filter(v => v.status !== 'closed');
      
      // Calculate distance to each vertiport
      const vertiportsWithDistance = vertiports.map(v => {
        const distance = this.calculateDistance(position, v.location);
        return {
          ...v,
          distance
        };
      });
      
      // Filter by distance
      const nearbyVertiports = vertiportsWithDistance.filter(v => v.distance <= radius);
      
      // Sort by distance
      nearbyVertiports.sort((a, b) => a.distance - b.distance);
      
      return nearbyVertiports;
    } catch (error) {
      console.error('Error finding nearby vertiports:', error);
      return [];
    }
  }
  
  /**
   * Calculate distance between two positions
   * @param {Object} pos1 - First position {lat, lng}
   * @param {Object} pos2 - Second position {lat, lng}
   * @returns {number} Distance in meters
   * @private
   */
  calculateDistance(pos1, pos2) {
    const R = 6371000; // Earth radius in meters
    const lat1 = pos1.lat * Math.PI / 180;
    const lat2 = pos2.lat * Math.PI / 180;
    const deltaLat = (pos2.lat - pos1.lat) * Math.PI / 180;
    const deltaLng = (pos2.lng - pos1.lng) * Math.PI / 180;
    
    const a = Math.sin(deltaLat/2) * Math.sin(deltaLat/2) +
              Math.cos(lat1) * Math.cos(lat2) *
              Math.sin(deltaLng/2) * Math.sin(deltaLng/2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
    
    return R * c;
  }
  
  /**
   * Find emergency landing sites
   * @param {Object} position - Current position
   * @param {number} radius - Search radius in meters
   * @returns {Promise<Array>} Emergency landing sites
   * @private
   */
  async findEmergencyLandingSites(position, radius) {
    // This would typically involve querying a database of pre-identified landing sites
    // or using a GIS service to identify suitable open areas
    // For this implementation, we'll return a simulated result
    
    const emergencySites = [];
    
    // Simulate finding some emergency landing sites
    // In a real implementation, this would query a database or service
    
    // Generate a few random points around the current position
    for (let i = 0; i < 3; i++) {
      // Random distance within radius
      const distance = Math.random() * radius;
      // Random bearing
      const bearing = Math.random() * 360;
      
      // Calculate position
      const site = this.calculateDestination(position, distance, bearing);
      
      // Add some simulated properties
      emergencySites.push({
        siteId: `emergency-site-${i}`,
        location: site,
        distance,
        suitabilityScore: 0.7 - (distance / radius * 0.5), // Higher score for closer sites
        siteType: i === 0 ? 'open-field' : i === 1 ? 'parking-lot' : 'road',
        estimatedSize: i === 0 ? 5000 : i === 1 ? 2000 : 1000, // square meters
        hazards: i === 2 ? ['traffic', 'obstacles'] : [] 
      });
    }
    
    return emergencySites;
  }
  
  /**
   * Calculate destination point given distance and bearing
   * @param {Object} position - Start position {lat, lng}
   * @param {number} distance - Distance in meters
   * @param {number} bearing - Bearing in degrees
   * @returns {Object} Destination position {lat, lng}
   * @private
   */
  calculateDestination(position, distance, bearing) {
    const R = 6371000; // Earth radius in meters
    const d = distance / R; // Angular distance
    const brng = bearing * Math.PI / 180; // Bearing in radians
    const lat1 = position.lat * Math.PI / 180; // Current lat in radians
    const lng1 = position.lng * Math.PI / 180; // Current lng in radians
    
    const lat2 = Math.asin(Math.sin(lat1) * Math.cos(d) + 
                           Math.cos(lat1) * Math.sin(d) * Math.cos(brng));
    
    const lng2 = lng1 + Math.atan2(Math.sin(brng) * Math.sin(d) * Math.cos(lat1),
                                  Math.cos(d) - Math.sin(lat1) * Math.sin(lat2));
    
    return {
      lat: lat2 * 180 / Math.PI,
      lng: lng2 * 180 / Math.PI
    };
  }
  
  /**
   * Execute divert to landing site action
   * @param {Object} action - Action to execute
   * @param {Object} plan - Contingency plan
   * @returns {Promise<Object>} Action result
   * @private
   */
  async executeDivertToLandingSiteAction(action, plan) {
    const result = {
      success: false,
      timestamp: new Date(),
      details: {}
    };
    
    // Need vehicle ID and landing option
    if (!plan.vehicleId) {
      result.error = 'No vehicle ID specified';
      return result;
    }
    
    if (!plan.context.emergencyLandingOption && !plan.context.emergencyLandingSite) {
      result.error = 'No landing site available';
      return result;
    }
    
    try {
      // Check if we have a vertiport landing option
      if (plan.context.emergencyLandingOption) {
        const landingOption = plan.context.emergencyLandingOption;
        const vertiport = landingOption.vertiport;
        const zone = landingOption.availableZones[0];
        
        // Use vertiport manager to reserve landing zone
        if (this.vertiportManager) {
          const reservationResult = await this.vertiportManager.reserveLandingZone({
            vertiportId: vertiport.vertiportId,
            zoneId: zone.zoneId,
            vehicleId: plan.vehicleId,
            scheduledTime: landingOption.estimatedArrivalTime,
            isEmergency: plan.priority === 'critical',
            priority: action.parameters.priority || plan.priority
          });
          
          if (reservationResult.success) {
            // Create diversion directive
            const diversionDirective = {
              directiveId: `directive-${plan.vehicleId}-${Date.now()}`,
              vehicleId: plan.vehicleId,
              type: 'emergency-diversion',
              contingencyPlanId: plan.planId,
              timestamp: new Date(),
              priority: plan.priority,
              parameters: {
                targetVertiport: {
                  vertiportId: vertiport.vertiportId,
                  name: vertiport.name,
                  location: vertiport.location
                },
                landingZone: {
                  zoneId: zone.zoneId,
                  name: zone.name
                },
                reservation: reservationResult.reservation,
                approachInstructions: reservationResult.landingZone ? 
                  `Approach ${vertiport.name} landing zone ${zone.name || zone.zoneId}` : 
                  'Follow standard approach procedures'
              }
            };
            
            // Store directive in database
            if (this.db) {
              const directivesCollection = this.db.collection('iamsDirectives');
              await directivesCollection.insertOne(diversionDirective);
            }
            
            result.success = true;
            result.details.diversionDirective = diversionDirective;
            result.details.reservationResult = reservationResult;
            
            // Update plan context
            plan.context.diversionDirective = diversionDirective;
            
            return result;
          } else {
            result.error = `Failed to reserve landing zone: ${reservationResult.error}`;
            result.details.reservationResult = reservationResult;
            
            // Check if we have alternatives
            if (plan.context.allLandingOptions && plan.context.allLandingOptions.length > 1) {
              // Try next best option
              plan.context.emergencyLandingOption = plan.context.allLandingOptions[1];
              plan.context.allLandingOptions = plan.context.allLandingOptions.slice(1);
              
              result.details.retryWithAlternative = true;
            }
            
            return result;
          }
        }
      }
      
      // If no vertiport option or vertiport manager not available,
      // use emergency landing site
      if (plan.context.emergencyLandingSite) {
        const site = plan.context.emergencyLandingSite;
        
        // Create emergency landing directive
        const emergencyDirective = {
          directiveId: `directive-${plan.vehicleId}-${Date.now()}`,
          vehicleId: plan.vehicleId,
          type: 'emergency-landing',
          contingencyPlanId: plan.planId,
          timestamp: new Date(),
          priority: 'critical',
          parameters: {
            landingSite: {
              siteId: site.siteId,
              location: site.location,
              siteType: site.siteType
            },
            hazards: site.hazards,
            approachInstructions: 'Perform emergency landing procedures',
            safetyNotes: site.hazards.length > 0 ? 
              `Caution: ${site.hazards.join(', ')}` : 
              'No known hazards'
          }
        };
        
        // Store directive in database
        if (this.db) {
          const directivesCollection = this.db.collection('iamsDirectives');
          await directivesCollection.insertOne(emergencyDirective);
        }
        
        result.success = true;
        result.details.emergencyDirective = emergencyDirective;
        
        // Update plan context
        plan.context.emergencyDirective = emergencyDirective;
        
        return result;
      }
      
      result.error = 'No suitable landing option available';
    } catch (error) {
      result.error = `Failed to divert to landing site: ${error.message}`;
    }
    
    return result;
  }
  
  /**
   * Execute notify stakeholders action
   * @param {Object} action - Action to execute
   * @param {Object} plan - Contingency plan
   * @returns {Promise<Object>} Action result
   * @private
   */
  async executeNotifyStakeholdersAction(action, plan) {
    const result = {
      success: false,
      timestamp: new Date(),
      details: {}
    };
    
    try {
      const notifyGroups = action.parameters.notifyGroups || ['operators'];
      
      // Create notifications for each stakeholder group
      const notifications = [];
      
      for (const group of notifyGroups) {
        // Build message based on plan type and group
        let message = `Contingency plan activated: ${plan.name}`;
        let details = {};
        
        if (plan.vehicleId) {
          message += ` for vehicle ${plan.context.vehicleCallsign || plan.vehicleId}`;
          details.vehicleId = plan.vehicleId;
          details.vehicleCallsign = plan.context.vehicleCallsign;
        }
        
        if (plan.planType === 'battery-emergency') {
          message += ` - Battery emergency (${plan.context.batteryLevel}%)`;
          details.batteryLevel = plan.context.batteryLevel;
        } else if (plan.planType === 'communication-loss') {
          message += ` - Communication loss (${Math.floor(plan.context.timeSinceContact)}s)`;
          details.timeSinceContact = plan.context.timeSinceContact;
        } else if (plan.planType === 'service-disruption') {
          message += ` - Service disruption (${plan.context.affectedServices})`;
          details.disruptions = plan.context.disruptions;
        } else if (plan.planType === 'collision-risk') {
          message += ` - Collision risk detected`;
          details.conflicts = plan.context.conflicts;
        } else if (plan.planType === 'weather-emergency') {
          message += ` - Weather emergency (${plan.context.affectedAreas})`;
          details.weatherAlerts = plan.context.weatherAlerts;
        }
        
        // Tailor notification based on stakeholder group
        const notification = {
          type: 'contingency-notification',
          group,
          priority: plan.priority,
          timestamp: new Date(),
          message,
          contingencyPlanId: plan.planId,
          details,
          requiresAction: group === 'operators' || group === 'emergency-services'
        };
        
        notifications.push(notification);
        
        // Store notification in database
        if (this.db) {
          const stakeholderNotificationsCollection = this.db.collection('iamsStakeholderNotifications');
          await stakeholderNotificationsCollection.insertOne(notification);
        }
      }
      
      // Handle special actions for specific groups
      if (notifyGroups.includes('emergency-services') && 
          (plan.priority === 'critical' || plan.planType === 'battery-emergency')) {
        // Log emergency service notification
        plan.logs.push({
          timestamp: new Date(),
          message: `Emergency services notified about ${plan.planType}`,
          type: 'info'
        });
      }
      
      result.success = true;
      result.details.notifications = notifications;
    } catch (error) {
      result.error = `Failed to notify stakeholders: ${error.message}`;
    }
    
    return result;
  }
  
  /**
   * Execute activate autonomous mode action
   * @param {Object} action - Action to execute
   * @param {Object} plan - Contingency plan
   * @returns {Promise<Object>} Action result
   * @private
   */
  async executeActivateAutonomousModeAction(action, plan) {
    const result = {
      success: false,
      timestamp: new Date(),
      details: {}
    };
    
    // Need vehicle ID
    if (!plan.vehicleId) {
      result.error = 'No vehicle ID specified';
      return result;
    }
    
    try {
      const mode = action.parameters.mode || 'lost-link';
      
      // Create directive for autonomous mode
      const directive = {
        directiveId: `directive-${plan.vehicleId}-${Date.now()}`,
        vehicleId: plan.vehicleId,
        type: 'activate-autonomous-mode',
        contingencyPlanId: plan.planId,
        timestamp: new Date(),
        priority: plan.priority,
        parameters: {
          mode,
          reason: plan.planType,
          autonomyLevel: mode === 'lost-link' ? 'full' : 'enhanced'
        }
      };
      
      // Store directive in database
      if (this.db) {
        const directivesCollection = this.db.collection('iamsDirectives');
        await directivesCollection.insertOne(directive);
      }
      
      // In a real implementation, we would also send this to the vehicle
      // through any available communication channels
      
      result.success = true;
      result.details.directive = directive;
      
      // Update plan context
      plan.context.autonomousMode = mode;
      plan.context.autonomousModeActivated = new Date();
    } catch (error) {
      result.error = `Failed to activate autonomous mode: ${error.message}`;
    }
    
    return result;
  }
  
  /**
   * Execute store last known trajectory action
   * @param {Object} action - Action to execute
   * @param {Object} plan - Contingency plan
   * @returns {Promise<Object>} Action result
   * @private
   */
  async executeStoreLastKnownTrajectoryAction(action, plan) {
    const result = {
      success: false,
      timestamp: new Date(),
      details: {}
    };
    
    // Need vehicle ID
    if (!plan.vehicleId) {
      result.error = 'No vehicle ID specified';
      return result;
    }
    
    try {
      // Get the last known trajectory from predictor
      let trajectory = null;
      
      if (this.predictor) {
        trajectory = this.predictor.getVehicleTrajectory(plan.vehicleId);
      }
      
      if (!trajectory) {
        result.error = 'No trajectory available for vehicle';
        return result;
      }
      
      // Store trajectory in database
      if (this.db) {
        const lostLinkTrajectoriesCollection = this.db.collection('iamsLostLinkTrajectories');
        
        const lostLinkTrajectory = {
          vehicleId: plan.vehicleId,
          contingencyPlanId: plan.planId,
          originalTrajectory: trajectory,
          timestamp: new Date(),
          lastKnownPosition: trajectory.points[0].position,
          lastKnownTime: trajectory.points[0].timestamp,
          extrapolatedPoints: trajectory.points.slice(1)
        };
        
        await lostLinkTrajectoriesCollection.insertOne(lostLinkTrajectory);
        
        result.success = true;
        result.details.trajectory = lostLinkTrajectory;
        
        // Update plan context
        plan.context.lostLinkTrajectory = {
          id: lostLinkTrajectory._id,
          pointCount: trajectory.points.length,
          lastKnownPosition: lostLinkTrajectory.lastKnownPosition,
          lastKnownTime: lostLinkTrajectory.lastKnownTime
        };
      } else {
        // If no database, just store in plan context
        plan.context.lostLinkTrajectory = {
          trajectory,
          lastKnownPosition: trajectory.points[0].position,
          lastKnownTime: trajectory.points[0].timestamp
        };
        
        result.success = true;
        result.details.trajectory = {
          pointCount: trajectory.points.length,
          lastKnownPosition: trajectory.points[0].position,
          lastKnownTime: trajectory.points[0].timestamp
        };
      }
    } catch (error) {
      result.error = `Failed to store last known trajectory: ${error.message}`;
    }
    
    return result;
  }
  
  /**
   * Store contingency plan in database
   * @param {Object} plan - Contingency plan
   * @returns {Promise<void>}
   * @private
   */
  async storePlan(plan) {
    if (!this.contingencyPlansCollection) return;
    
    try {
      await this.contingencyPlansCollection.insertOne(plan);
    } catch (error) {
      console.error('Error storing contingency plan:', error);
    }
  }
  
  /**
   * Update contingency plan in database
   * @param {Object} plan - Contingency plan
   * @returns {Promise<void>}
   * @private
   */
  async updatePlan(plan) {
    if (!this.contingencyPlansCollection) return;
    
    try {
      // Update plan excluding _id
      const { _id, ...planData } = plan;
      
      await this.contingencyPlansCollection.updateOne(
        { planId: plan.planId },
        { $set: planData }
      );
    } catch (error) {
      console.error('Error updating contingency plan:', error);
    }
  }
  
  /**
   * Update contingency plan status
   * @param {string} planId - Plan ID
   * @param {string} status - New status
   * @param {string} reason - Reason for status change
   * @returns {Promise<void>}
   * @private
   */
  async updatePlanStatus(planId, status, reason) {
    if (!this.contingencyPlansCollection) return;
    
    try {
      const now = new Date();
      
      await this.contingencyPlansCollection.updateOne(
        { planId },
        { 
          $set: { 
            status,
            updatedAt: now,
            ...(status === 'completed' ? { completedAt: now } : {}),
            ...(status === 'failed' ? { failedAt: now } : {}),
            ...(status === 'expired' ? { expiredAt: now } : {})
          },
          $push: {
            logs: {
              timestamp: now,
              message: `Status changed to ${status}: ${reason}`,
              type: status === 'failed' ? 'error' : 'info'
            }
          }
```
I'll continue implementing the IASMS prediction toolset by completing the remaining components needed for this system. Let's pick up where we left off with the contingency planning functionality.

```javascript
// Path: /IAMSTimeBasedFlowManager.js
// Written by Greg Deeds, Autonomy Association International, Inc.
// Copyright 2025 Autonomy Association International Inc., all rights reserved 
// Safeguard patent license from National Aeronautics and Space Administration (NASA)
// Copyright 2025 NASA, all rights reserved

/**
 * @fileoverview Time-Based Flow Management (TBFM) for IASMS
 * @module safeguard/iams-time-based-flow-manager
 */

const { Meteor } = require('meteor/meteor');
const turf = require('@turf/turf');
const { GeospatialUtils } = require('./GeospatialUtilityFunctions');
const { EventEmitter } = require('events');

/**
 * Class for time-based flow management in UAM operations
 * Handles sequencing, spacing, and scheduling of arrivals and departures
 */
class IAMSTimeBasedFlowManager extends EventEmitter {
  /**
   * Create a new IAMSTimeBasedFlowManager instance
   * @param {Object} options - Configuration options
   * @param {Object} options.db - MongoDB database connection
   * @param {Object} options.predictor - IAMS Predictor reference
   * @param {Object} options.vertiportManager - Vertiport manager reference
   * @param {number} options.rnpAccuracy - Required Navigation Performance accuracy in NM
   * @param {number} options.timeBuffer - Time buffer between operations in seconds
   * @param {number} options.nominalSpacing - Nominal spacing distance in meters
   * @param {number} options.schedulingHorizon - Scheduling horizon in minutes
   */
  constructor(options = {}) {
    super();
    
    this.options = {
      rnpAccuracy: options.rnpAccuracy || 0.05, // 0.05 NM (~93m)
      timeBuffer: options.timeBuffer || 60, // 1 minute buffer
      nominalSpacing: options.nominalSpacing || 300, // 300m nominal spacing
      schedulingHorizon: options.schedulingHorizon || 60, // 60 minutes
      updateFrequency: options.updateFrequency || 5000, // 5 seconds
      resilienceBuffer: options.resilienceBuffer || 1.5, // 50% buffer for resilience
      ...options
    };
    
    this.db = options.db;
    this.predictor = options.predictor;
    this.vertiportManager = options.vertiportManager;
    
    // MongoDB collections
    this.flowConfigCollection = this.db ? this.db.collection('iamsFlowConfig') : null;
    this.schedulesCollection = this.db ? this.db.collection('iamsSchedules') : null;
    this.arrivalSequenceCollection = this.db ? this.db.collection('iamsArrivalSequence') : null;
    this.departureSequenceCollection = this.db ? this.db.collection('iamsDepartureSequence') : null;
    
    // In-memory data structures
    this.flowConfigs = new Map(); // Airspace flow configurations
    this.vertiportCapacity = new Map(); // Vertiport capacity settings
    this.arrivalSequences = new Map(); // Arrival sequences by vertiport
    this.departureSequences = new Map(); // Departure sequences by vertiport
    this.flowConstraints = new Map(); // Active flow constraints
    
    // Operation metrics
    this.metrics = {
      scheduledArrivals: 0,
      scheduledDepartures: 0,
      activeFlowConstraints: 0,
      vertiportThroughput: new Map(),
      sequenceCompliance: new Map()
    };
    
    // Operational state
    this.isActive = false;
    this.degradedMode = false;
    this.updateInterval = null;
    this.resilienceLevel = 'normal'; // normal, enhanced, maximum
  }

  /**
   * Initialize the flow manager
   * @async
   * @returns {Promise<void>}
   */
  async initialize() {
    try {
      console.log('Initializing IAMS Time-Based Flow Manager');
      
      // Create indexes if needed
      if (this.flowConfigCollection) {
        await this.flowConfigCollection.createIndex({ configId: 1 }, { unique: true });
        await this.flowConfigCollection.createIndex({ vertiportId: 1 });
        await this.flowConfigCollection.createIndex({ status: 1 });
      }
      
      if (this.schedulesCollection) {
        await this.schedulesCollection.createIndex({ vehicleId: 1 });
        await this.schedulesCollection.createIndex({ vertiportId: 1 });
        await this.schedulesCollection.createIndex({ scheduledTime: 1 });
        await this.schedulesCollection.createIndex({ status: 1 });
      }
      
      if (this.arrivalSequenceCollection) {
        await this.arrivalSequenceCollection.createIndex({ vertiportId: 1 });
        await this.arrivalSequenceCollection.createIndex({ sequenceId: 1 }, { unique: true });
        await this.arrivalSequenceCollection.createIndex({ status: 1 });
      }
      
      if (this.departureSequenceCollection) {
        await this.departureSequenceCollection.createIndex({ vertiportId: 1 });
        await this.departureSequenceCollection.createIndex({ sequenceId: 1 }, { unique: true });
        await this.departureSequenceCollection.createIndex({ status: 1 });
      }
      
      // Load flow configurations
      await this.loadFlowConfigurations();
      
      // Load vertiport capacity settings
      await this.loadVertiportCapacity();
      
      // Load active sequences
      await this.loadActiveSequences();
      
      // Start update cycle
      this.startUpdateCycle();
      
      this.isActive = true;
      console.log('IAMS Time-Based Flow Manager initialized');
    } catch (error) {
      console.error('Failed to initialize IAMS Time-Based Flow Manager:', error);
      throw error;
    }
  }
  
  /**
   * Load flow configurations from database
   * @async
   * @private
   */
  async loadFlowConfigurations() {
    if (!this.flowConfigCollection) return;
    
    try {
      const configs = await this.flowConfigCollection.find({ status: 'active' }).toArray();
      
      this.flowConfigs.clear();
      for (const config of configs) {
        this.flowConfigs.set(config.configId, config);
      }
      
      console.log(`Loaded ${this.flowConfigs.size} active flow configurations`);
    } catch (error) {
      console.error('Error loading flow configurations:', error);
    }
  }
  
  /**
   * Load vertiport capacity settings
   * @async
   * @private
   */
  async loadVertiportCapacity() {
    if (!this.vertiportManager) return;
    
    try {
      // Get all vertiports from vertiport manager
      const vertiports = this.vertiportManager.vertiports || new Map();
      
      // Initialize capacity settings for each vertiport
      for (const [vertiportId, vertiport] of vertiports.entries()) {
        // Get capacity metrics from vertiport manager
        const capacityMetrics = await this.vertiportManager.getVertiportCapacityMetrics(vertiportId);
        
        if (capacityMetrics && capacityMetrics.success) {
          this.vertiportCapacity.set(vertiportId, {
            vertiportId,
            name: vertiport.name,
            landingsPerHour: capacityMetrics.capacity.landingsPerHour,
            takeoffsPerHour: capacityMetrics.capacity.takeoffsPerHour,
            combinedOperationsPerHour: capacityMetrics.capacity.combinedOperationsPerHour,
            currentUtilization: capacityMetrics.currentUtilization || {
              scheduledLandings: 0,
              scheduledTakeoffs: 0,
              totalScheduled: 0
            }
          });
        } else {
          // Default capacity if metrics not available
          this.vertiportCapacity.set(vertiportId, {
            vertiportId,
            name: vertiport.name,
            landingsPerHour: 10,
            takeoffsPerHour: 10,
            combinedOperationsPerHour: 15,
            currentUtilization: {
              scheduledLandings: 0,
              scheduledTakeoffs: 0,
              totalScheduled: 0
            }
          });
        }
      }
      
      console.log(`Loaded capacity settings for ${this.vertiportCapacity.size} vertiports`);
    } catch (error) {
      console.error('Error loading vertiport capacity settings:', error);
    }
  }
  
  /**
   * Load active sequences from database
   * @async
   * @private
   */
  async loadActiveSequences() {
    if (!this.arrivalSequenceCollection || !this.departureSequenceCollection) return;
    
    try {
      // Load active arrival sequences
      const arrivalSequences = await this.arrivalSequenceCollection.find({ 
        status: { $in: ['active', 'pending'] } 
      }).toArray();
      
      this.arrivalSequences.clear();
      for (const sequence of arrivalSequences) {
        this.arrivalSequences.set(sequence.sequenceId, sequence);
      }
      
      // Load active departure sequences
      const departureSequences = await this.departureSequenceCollection.find({ 
        status: { $in: ['active', 'pending'] } 
      }).toArray();
      
      this.departureSequences.clear();
      for (const sequence of departureSequences) {
        this.departureSequences.set(sequence.sequenceId, sequence);
      }
      
      console.log(`Loaded ${this.arrivalSequences.size} arrival sequences and ${this.departureSequences.size} departure sequences`);
    } catch (error) {
      console.error('Error loading active sequences:', error);
    }
  }
  
  /**
   * Start the update cycle
   * @private
   */
  startUpdateCycle() {
    if (this.updateInterval) {
      clearInterval(this.updateInterval);
    }
    
    this.updateInterval = setInterval(() => {
      this.updateFlowManagement().catch(err => {
        console.error('Error updating flow management:', err);
      });
    }, this.options.updateFrequency);
  }
  
  /**
   * Stop the update cycle
   */
  stopUpdateCycle() {
    if (this.updateInterval) {
      clearInterval(this.updateInterval);
      this.updateInterval = null;
    }
  }
  
  /**
   * Update flow management
   * @async
   * @private
   */
  async updateFlowManagement() {
    try {
      // Update each arrival sequence
      for (const [sequenceId, sequence] of this.arrivalSequences.entries()) {
        if (sequence.status === 'active') {
          await this.updateArrivalSequence(sequence);
        }
      }
      
      // Update each departure sequence
      for (const [sequenceId, sequence] of this.departureSequences.entries()) {
        if (sequence.status === 'active') {
          await this.updateDepartureSequence(sequence);
        }
      }
      
      // Update vertiport capacity utilization
      await this.updateVertiportUtilization();
      
      // Check for flow constraints
      await this.checkFlowConstraints();
      
      // Update metrics
      this.updateMetrics();
    } catch (error) {
      console.error('Error in flow management update cycle:', error);
    }
  }
  
  /**
   * Update arrival sequence
   * @param {Object} sequence - Arrival sequence
   * @returns {Promise<void>}
   * @private
   */
  async updateArrivalSequence(sequence) {
    // Get all vehicles in the sequence
    const vehicles = sequence.vehicles || [];
    
    // Check if sequence is still valid
    if (vehicles.length === 0) {
      // Mark sequence as completed if no vehicles
      sequence.status = 'completed';
      await this.updateSequenceStatus(sequence.sequenceId, 'arrival', 'completed');
      return;
    }
    
    // Check vehicle states and update sequence
    const now = new Date();
    const updatedVehicles = [];
    let sequenceUpdated = false;
    
    for (const vehicle of vehicles) {
      // Get current vehicle state from predictor
      let currentState = null;
      if (this.predictor && this.predictor.vehicles) {
        const vehicleData = this.predictor.vehicles.get(vehicle.vehicleId);
        if (vehicleData) {
          currentState = vehicleData.state;
        }
      }
      
      // If vehicle data available, update sequence
      if (currentState) {
        // Check if vehicle has landed
        if (vehicle.status === 'landing' && 
            currentState.altitude < 10 && 
            this.isNearLandingZone(currentState.position, vehicle.landingZoneId)) {
          // Vehicle has landed, update status
          vehicle.status = 'landed';
          vehicle.actualLandingTime = now;
          sequenceUpdated = true;
        }
        // Check if vehicle is approaching
        else if (vehicle.status === 'en-route' && 
                this.isNearVertiport(currentState.position, sequence.vertiportId)) {
          // Vehicle is approaching, update status
          vehicle.status = 'approaching';
          vehicle.estimatedArrivalTime = new Date(now.getTime() + 120000); // 2 minutes ETA
          sequenceUpdated = true;
        }
        // Update ETA based on current position and trajectory
        else if (vehicle.status === 'en-route' || vehicle.status === 'approaching') {
          // Get trajectory from predictor
          let trajectory = null;
          if (this.predictor && this.predictor.trajectories) {
            trajectory = this.predictor.trajectories.get(vehicle.vehicleId);
          }
          
          if (trajectory) {
            // Find estimated arrival time from trajectory
            const eta = this.estimateArrivalTime(trajectory, sequence.vertiportId);
            if (eta) {
              vehicle.estimatedArrivalTime = eta;
              sequenceUpdated = true;
            }
          }
        }
      }
      
      // Check if vehicle has timed out
      if (vehicle.status !== 'landed' && vehicle.status !== 'cancelled') {
        const scheduledTime = new Date(vehicle.scheduledTime);
        const timeSinceScheduled = now - scheduledTime;
        
        // If more than 30 minutes late, mark as missing
        if (timeSinceScheduled > 1800000) {
          vehicle.status = 'missing';
          sequenceUpdated = true;
        }
      }
      
      updatedVehicles.push(vehicle);
    }
    
    // Update sequence with updated vehicles
    if (sequenceUpdated) {
      sequence.vehicles = updatedVehicles;
      sequence.lastUpdated = now;
      
      // Save to database
      if (this.arrivalSequenceCollection) {
        await this.arrivalSequenceCollection.updateOne(
          { sequenceId: sequence.sequenceId },
          { $set: {
              vehicles: updatedVehicles,
              lastUpdated: now
            }
          }
        );
      }
    }
    
    // Check if sequence is completed (all vehicles landed or cancelled)
    const allComplete = updatedVehicles.every(v => 
      v.status === 'landed' || v.status === 'cancelled' || v.status === 'missing'
    );
    
    if (allComplete) {
      sequence.status = 'completed';
      sequence.completedAt = now;
      
      // Save to database
      await this.updateSequenceStatus(sequence.sequenceId, 'arrival', 'completed');
    }
  }
  
  /**
   * Update departure sequence
   * @param {Object} sequence - Departure sequence
   * @returns {Promise<void>}
   * @private
   */
  async updateDepartureSequence(sequence) {
    // Get all vehicles in the sequence
    const vehicles = sequence.vehicles || [];
    
    // Check if sequence is still valid
    if (vehicles.length === 0) {
      // Mark sequence as completed if no vehicles
      sequence.status = 'completed';
      await this.updateSequenceStatus(sequence.sequenceId, 'departure', 'completed');
      return;
    }
    
    // Check vehicle states and update sequence
    const now = new Date();
    const updatedVehicles = [];
    let sequenceUpdated = false;
    
    for (const vehicle of vehicles) {
      // Get current vehicle state from predictor
      let currentState = null;
      if (this.predictor && this.predictor.vehicles) {
        const vehicleData = this.predictor.vehicles.get(vehicle.vehicleId);
        if (vehicleData) {
          currentState = vehicleData.state;
        }
      }
      
      // If vehicle data available, update sequence
      if (currentState) {
        // Check if vehicle has departed
        if (vehicle.status === 'taking-off' && 
            currentState.altitude > 50 && 
            !this.isNearVertiport(currentState.position, sequence.vertiportId)) {
          // Vehicle has departed, update status
          vehicle.status = 'departed';
          vehicle.actualDepartureTime = now;
          sequenceUpdated = true;
        }
        // Check if vehicle is ready for takeoff
        else if (vehicle.status === 'ready' && 
                this.isNearLandingZone(currentState.position, vehicle.takeoffZoneId)) {
          // Vehicle is ready for takeoff, update status
          vehicle.status = 'taking-off';
          sequenceUpdated = true;
        }
      }
      
      // Check if vehicle has timed out
      if (vehicle.status !== 'departed' && vehicle.status !== 'cancelled') {
        const scheduledTime = new Date(vehicle.scheduledTime);
        const timeSinceScheduled = now - scheduledTime;
        
        // If more than 30 minutes late, mark as missed
        if (timeSinceScheduled > 1800000) {
          vehicle.status = 'missed';
          sequenceUpdated = true;
        }
      }
      
      updatedVehicles.push(vehicle);
    }
    
    // Update sequence with updated vehicles
    if (sequenceUpdated) {
      sequence.vehicles = updatedVehicles;
      sequence.lastUpdated = now;
      
      // Save to database
      if (this.departureSequenceCollection) {
        await this.departureSequenceCollection.updateOne(
          { sequenceId: sequence.sequenceId },
          { $set: {
              vehicles: updatedVehicles,
              lastUpdated: now
            }
          }
        );
      }
    }
    
    // Check if sequence is completed (all vehicles departed or cancelled)
    const allComplete = updatedVehicles.every(v => 
      v.status === 'departed' || v.status === 'cancelled' || v.status === 'missed'
    );
    
    if (allComplete) {
      sequence.status = 'completed';
      sequence.completedAt = now;
      
      // Save to database
      await this.updateSequenceStatus(sequence.sequenceId, 'departure', 'completed');
    }
  }
  
  /**
   * Update sequence status
   * @param {string} sequenceId - Sequence ID
   * @param {string} type - Sequence type ('arrival' or 'departure')
   * @param {string} status - New status
   * @returns {Promise<void>}
   * @private
   */
  async updateSequenceStatus(sequenceId, type, status) {
    const now = new Date();
    
    // Update in-memory sequence
    if (type === 'arrival') {
      const sequence = this.arrivalSequences.get(sequenceId);
      if (sequence) {
        sequence.status = status;
        sequence.lastUpdated = now;
        if (status === 'completed' || status === 'cancelled') {
          sequence.completedAt = now;
        }
      }
      
      // Update in database
      if (this.arrivalSequenceCollection) {
        await this.arrivalSequenceCollection.updateOne(
          { sequenceId },
          { $set: {
              status,
              lastUpdated: now,
              ...(status === 'completed' || status === 'cancelled' ? { completedAt: now } : {})
            }
          }
        );
      }
    } else if (type === 'departure') {
      const sequence = this.departureSequences.get(sequenceId);
      if (sequence) {
        sequence.status = status;
        sequence.lastUpdated = now;
        if (status === 'completed' || status === 'cancelled') {
          sequence.completedAt = now;
        }
      }
      
      // Update in database
      if (this.departureSequenceCollection) {
        await this.departureSequenceCollection.updateOne(
          { sequenceId },
          { $set: {
              status,
              lastUpdated: now,
              ...(status === 'completed' || status === 'cancelled' ? { completedAt: now } : {})
            }
          }
        );
      }
    }
  }
  
  /**
   * Update vertiport utilization
   * @returns {Promise<void>}
   * @private
   */
  async updateVertiportUtilization() {
    // Skip if no vertiport manager
    if (!this.vertiportManager) return;
    
    try {
      for (const [vertiportId, capacity] of this.vertiportCapacity.entries()) {
        // Get current schedule from vertiport manager
        const currentTime = new Date();
        const endTime = new Date(currentTime.getTime() + 3600000); // 1 hour ahead
        
        const schedule = await this.vertiportManager.getVertiportSchedule(
          vertiportId,
          currentTime,
          endTime
        );
        
        if (schedule && schedule.success) {
          // Count scheduled landings and takeoffs
          const scheduledLandings = schedule.operations.filter(op => 
            op.type === 'landing' && op.status === 'scheduled'
          ).length;
          
          const scheduledTakeoffs = schedule.operations.filter(op => 
            op.type === 'takeoff' && op.status === 'scheduled'
          ).length;
          
          // Update capacity utilization
          capacity.currentUtilization = {
            scheduledLandings,
            scheduledTakeoffs,
            totalScheduled: scheduledLandings + scheduledTakeoffs
          };
          
          // Update throughput metrics
          this.metrics.vertiportThroughput.set(vertiportId, {
            landingsPerHour: capacity.landingsPerHour,
            takeoffsPerHour: capacity.takeoffsPerHour,
            combinedOperationsPerHour: capacity.combinedOperationsPerHour,
            currentUtilization: capacity.currentUtilization
          });
        }
      }
    } catch (error) {
      console.error('Error updating vertiport utilization:', error);
    }
  }
  
  /**
   * Check for flow constraints
   * @returns {Promise<void>}
   * @private
   */
  async checkFlowConstraints() {
    try {
      // Check each vertiport for capacity constraints
      for (const [vertiportId, capacity] of this.vertiportCapacity.entries()) {
        const utilization = capacity.currentUtilization;
        
        // Check if approaching capacity limits
        if (utilization.scheduledLandings >= capacity.landingsPerHour * 0.8) {
          // Create or update landing constraint
          await this.createFlowConstraint(vertiportId, 'landing', 'capacity');
        } else {
          // Remove landing constraint if exists
          await this.removeFlowConstraint(vertiportId, 'landing', 'capacity');
        }
        
        if (utilization.scheduledTakeoffs >= capacity.takeoffsPerHour * 0.8) {
          // Create or update takeoff constraint
          await this.createFlowConstraint(vertiportId, 'takeoff', 'capacity');
        } else {
          // Remove takeoff constraint if exists
          await this.removeFlowConstraint(vertiportId, 'takeoff', 'capacity');
        }
      }
      
      // Check weather-related constraints (if weather data available)
      // This would typically integrate with a weather service
      
      // Update active constraints count
      this.metrics.activeFlowConstraints = this.flowConstraints.size;
    } catch (error) {
      console.error('Error checking flow constraints:', error);
    }
  }
  
  /**
   * Create a flow constraint
   * @param {string} vertiportId - Vertiport ID
   * @param {string} operationType - Operation type ('landing' or 'takeoff')
   * @param {string} constraintType - Constraint type ('capacity', 'weather', etc.)
   * @returns {Promise<Object>} Created constraint
   * @private
   */
  async createFlowConstraint(vertiportId, operationType, constraintType) {
    const constraintId = `${vertiportId}-${operationType}-${constraintType}`;
    const now = new Date();
    
    // Check if constraint already exists
    const existingConstraint = this.flowConstraints.get(constraintId);
    if (existingConstraint) {
      // Update existing constraint
      existingConstraint.lastUpdated = now;
      this.flowConstraints.set(constraintId, existingConstraint);
      return existingConstraint;
    }
    
    // Create new constraint
    const constraint = {
      constraintId,
      vertiportId,
      operationType,
      constraintType,
      status: 'active',
      createdAt: now,
      lastUpdated: now,
      expiresAt: new Date(now.getTime() + 3600000), // 1 hour by default
      details: {
        reason: `${operationType === 'landing' ? 'Landing' : 'Takeoff'} capacity approaching limit`,
        severity: 'medium'
      }
    };
    
    // Add constraint
    this.flowConstraints.set(constraintId, constraint);
    
    // Emit constraint event
    this.emit('constraint:created', constraint);
    
    // Log constraint creation
    console.log(`Created flow constraint: ${constraintId}`);
    
    return constraint;
  }
  
  /**
   * Remove a flow constraint
   * @param {string} vertiportId - Vertiport ID
   * @param {string} operationType - Operation type ('landing' or 'takeoff')
   * @param {string} constraintType - Constraint type ('capacity', 'weather', etc.)
   * @returns {Promise<boolean>} Success indicator
   * @private
   */
  async removeFlowConstraint(vertiportId, operationType, constraintType) {
    const constraintId = `${vertiportId}-${operationType}-${constraintType}`;
    
    // Check if constraint exists
    if (this.flowConstraints.has(constraintId)) {
      // Remove constraint
      this.flowConstraints.delete(constraintId);
      
      // Emit constraint event
      this.emit('constraint:removed', { constraintId });
      
      // Log constraint removal
      console.log(`Removed flow constraint: ${constraintId}`);
      
      return true;
    }
    
    return false;
  }
  
  /**
   * Update metrics
   * @private
   */
  updateMetrics() {
    // Count scheduled arrivals and departures
    this.metrics.scheduledArrivals = Array.from(this.arrivalSequences.values())
      .filter(seq => seq.status === 'active')
      .reduce((count, seq) => count + (seq.vehicles?.length || 0), 0);
    
    this.metrics.scheduledDepartures = Array.from(this.departureSequences.values())
      .filter(seq => seq.status === 'active')
      .reduce((count, seq) => count + (seq.vehicles?.length || 0), 0);
    
    // Calculate sequence compliance
    for (const [vertiportId, capacity] of this.vertiportCapacity.entries()) {
      // Get active arrival sequences for this vertiport
      const arrivalSequences = Array.from(this.arrivalSequences.values())
        .filter(seq => seq.vertiportId === vertiportId && seq.status === 'active');
      
      // Get active departure sequences for this vertiport
      const departureSequences = Array.from(this.departureSequences.values())
        .filter(seq => seq.vertiportId === vertiportId && seq.status === 'active');
      
      // Calculate compliance percentages
      let arrivalCompliance = 0;
      let departureCompliance = 0;
      
      if (arrivalSequences.length > 0) {
        // Count compliant arrivals (landed within 5 minutes of scheduled time)
        const compliantArrivals = arrivalSequences.reduce((count, seq) => {
          const compliantVehicles = (seq.vehicles || []).filter(v => {
            if (v.status === 'landed' && v.actualLandingTime && v.scheduledTime) {
              const scheduledTime = new Date(v.scheduledTime);
              const actualTime = new Date(v.actualLandingTime);
              const diffMinutes = Math.abs((actualTime - scheduledTime) / 60000);
              return diffMinutes <= 5; // Within 5 minutes
            }
            return false;
          });
          return count + compliantVehicles.length;
        }, 0);
        
        // Total landed vehicles
        const totalLanded = arrivalSequences.reduce((count, seq) => {
          return count + (seq.vehicles || []).filter(v => v.status === 'landed').length;
        }, 0);
        
        arrivalCompliance = totalLanded > 0 ? (compliantArrivals / totalLanded) * 100 : 100;
      }
      
      if (departureSequences.length > 0) {
        // Count compliant departures (departed within 5 minutes of scheduled time)
        const compliantDepartures = departureSequences.reduce((count, seq) => {
          const compliantVehicles = (seq.vehicles || []).filter(v => {
            if (v.status === 'departed' && v.actualDepartureTime && v.scheduledTime) {
              const scheduledTime = new Date(v.scheduledTime);
              const actualTime = new Date(v.actualDepartureTime);
              const diffMinutes = Math.abs((actualTime - scheduledTime) / 60000);
              return diffMinutes <= 5; // Within 5 minutes
            }
            return false;
          });
          return count + compliantVehicles.length;
        }, 0);
        
        // Total departed vehicles
        const totalDeparted = departureSequences.reduce((count, seq) => {
          return count + (seq.vehicles || []).filter(v => v.status === 'departed').length;
        }, 0);
        
        departureCompliance = totalDeparted > 0 ? (compliantDepartures / totalDeparted) * 100 : 100;
      }
      
      // Update compliance metrics
      this.metrics.sequenceCompliance.set(vertiportId, {
        arrivalCompliance,
        departureCompliance,
        overallCompliance: (arrivalCompliance + departureCompliance) / 2
      });
    }
  }
  
  /**
   * Check if position is near vertiport
   * @param {Object} position - Position to check
   * @param {string} vertiportId - Vertiport ID
   * @returns {boolean} Whether position is near vertiport
   * @private
   */
  isNearVertiport(position, vertiportId) {
    if (!this.vertiportManager) return false;
    
    // Get vertiport
    const vertiport = this.vertiportManager.vertiports.get(vertiportId);
    if (!vertiport) return false;
    
    // Calculate distance
    const distance = GeospatialUtils.distance(
      position,
      vertiport.location,
      'meters'
    );
    
    // Consider "near" if within 500m
    return distance <= 500;
  }
  
  /**
   * Check if position is near landing zone
   * @param {Object} position - Position to check
   * @param {string} zoneId - Landing zone ID
   * @returns {boolean} Whether position is near landing zone
   * @private
   */
  isNearLandingZone(position, zoneId) {
    if (!this.vertiportManager) return false;
    
    // Get landing zone
    const zone = this.vertiportManager.landingZones.get(zoneId);
    if (!zone) return false;
    
    // Calculate distance
    const distance = GeospatialUtils.distance(
      position,
      zone.location,
      'meters'
    );
    
    // Consider "near" if within 50m
    return distance <= 50;
  }
  
  /**
   * Estimate arrival time from trajectory
   * @param {Object} trajectory - Vehicle trajectory
   * @param {string} vertiportId - Vertiport ID
   * @returns {Date|null} Estimated arrival time or null
   * @private
   */
  estimateArrivalTime(trajectory, vertiportId) {
    if (!this.vertiportManager) return null;
    
    // Get vertiport
    const vertiport = this.vertiportManager.vertiports.get(vertiportId);
    if (!vertiport) return null;
    
    // Get trajectory points
    const points = trajectory.points || [];
    if (points.length === 0) return null;
    
    // Find the first point that is near the vertiport
    for (let i = 0; i < points.length; i++) {
      const point = points[i];
      
      // Calculate distance to vertiport
      const distance = GeospatialUtils.distance(
        point.position,
        vertiport.location,
        'meters'
      );
      
      // If within 500m, consider it arrival
      if (distance <= 500) {
        return point.timestamp;
      }
    }
    
    // If no point is near vertiport, return null
    return null;
  }
  
  /**
   * Register a landing
   * @param {Object} params - Landing parameters
   * @param {string} params.vehicleId - Vehicle ID
   * @param {string} params.vertiportId - Vertiport ID
   * @param {string} params.zoneId - Landing zone ID
   * @param {Date} params.scheduledTime - Scheduled landing time
   * @param {boolean} params.isEmergency - Whether this is an emergency landing
   * @param {string} params.priority - Priority level
   * @returns {Promise<Object>} Registration result
   */
  async registerLanding(params) {
    const { vehicleId, vertiportId, zoneId, scheduledTime, isEmergency, priority } = params;
    
    try {
      // Validate parameters
      if (!vehicleId || !vertiportId || !zoneId || !scheduledTime) {
        return {
          success: false,
          error: 'Missing required parameters'
        };
      }
      
      // Find active arrival sequence for this vertiport
      let sequence = Array.from(this.arrivalSequences.values())
        .find(seq => 
          seq.vertiportId === vertiportId && 
          seq.status === 'active' &&
          Math.abs(new Date(seq.scheduledTime) - scheduledTime) < 1800000 // Within 30 minutes
        );
      
      // Create new sequence if needed
      if (!sequence) {
        sequence = await this.createArrivalSequence(vertiportId, scheduledTime);
      }
      
      // Check if vehicle is already in sequence
      const existingVehicle = sequence.vehicles.find(v => v.vehicleId === vehicleId);
      if (existingVehicle) {
        // Update existing vehicle
        existingVehicle.landingZoneId = zoneId;
        existingVehicle.scheduledTime = scheduledTime;
        existingVehicle.isEmergency = isEmergency || false;
        existingVehicle.priority = priority || (isEmergency ? 'emergency' : 'normal');
        existingVehicle.lastUpdated = new Date();
      } else {
        // Add vehicle to sequence
        sequence.vehicles.push({
          vehicleId,
          landingZoneId: zoneId,
          scheduledTime,
          isEmergency: isEmergency || false,
          priority: priority || (isEmergency ? 'emergency' : 'normal'),
          status: 'en-route',
          createdAt: new Date(),
          lastUpdated: new Date()
        });
      }
      
      // Apply sequencing constraints (prioritize emergency landings)
      this.applySequencingConstraints(sequence);
      
      // Save updated sequence
      if (this.arrivalSequenceCollection) {
        await this.arrivalSequenceCollection.updateOne(
          { sequenceId: sequence.sequenceId },
          { $set: {
              vehicles: sequence.vehicles,
              lastUpdated: new Date()
            }
          }
        );
      }
      
      // Update metrics
      this.metrics.scheduledArrivals = Array.from(this.arrivalSequences.values())
        .filter(seq => seq.status === 'active')
        .reduce((count, seq) => count + (seq.vehicles?.length || 0), 0);
      
      return {
        success: true,
        sequenceId: sequence.sequenceId,
        position: sequence.vehicles.findIndex(v => v.vehicleId === vehicleId) + 1,
        scheduledTime,
        landingZoneId: zoneId
      };
    } catch (error) {
      console.error('Error registering landing:', error);
      return {
        success: false,
        error: error.message
      };
    }
  }
  
  /**
   * Create a new arrival sequence
   * @param {string} vertiportId - Vertiport ID
   * @param {Date} scheduledTime - Scheduled arrival time
   * @returns {Promise<Object>} Created sequence
   * @private
   */
  async createArrivalSequence(vertiportId, scheduledTime) {
    const sequenceId = `arrival-${vertiportId}-${Date.now()}`;
    const now = new Date();
    
    // Create sequence
    const sequence = {
      sequenceId,
      vertiportId,
      scheduledTime,
      status: 'active',
      createdAt: now,
      lastUpdated: now,
      vehicles: []
    };
    
    // Save to database
    if (this.arrivalSequenceCollection) {
      await this.arrivalSequenceCollection.insertOne(sequence);
    }
    
    // Add to in-memory cache
    this.arrivalSequences.set(sequenceId, sequence);
    
    return sequence;
  }
  
  /**
   * Apply sequencing constraints
   * @param {Object} sequence - Sequence to apply constraints to
   * @private
   */
  applySequencingConstraints(sequence) {
    // Sort vehicles by priority and scheduled time
    sequence.vehicles.sort((a, b) => {
      // Emergency landings have highest priority
      if (a.isEmergency && !b.isEmergency) return -1;
      if (!a.isEmergency && b.isEmergency) return 1;
      
      // Then by priority level
      const priorityOrder = { 'emergency': 0, 'high': 1, 'normal': 2, 'low': 3 };
      const aPriority = priorityOrder[a.priority] || 2;
      const bPriority = priorityOrder[b.priority] || 2;
      
      if (aPriority !== bPriority) return aPriority - bPriority;
      
      // Finally by scheduled time
      return new Date(a.scheduledTime) - new Date(b.scheduledTime);
    });
    
    // Apply minimum spacing between scheduled times
    const minSpacingMs = this.options.timeBuffer * 1000;
    
    for (let i = 1; i < sequence.vehicles.length; i++) {
      const prevVehicle = sequence.vehicles[i - 1];
      const currentVehicle = sequence.vehicles[i];
      
      // Skip if current vehicle is emergency and previous is not
      if (currentVehicle.isEmergency && !prevVehicle.isEmergency) continue;
      
      const prevScheduledTime = new Date(prevVehicle.scheduledTime);
      const currentScheduledTime = new Date(currentVehicle.scheduledTime);
      
      // If spacing is less than minimum, adjust current vehicle's time
      if (currentScheduledTime - prevScheduledTime < minSpacingMs) {
        const newScheduledTime = new Date(prevScheduledTime.getTime() + minSpacingMs);
        currentVehicle.scheduledTime = newScheduledTime;
      }
    }
  }
  
  /**
   * Register a takeoff
   * @param {Object} params - Takeoff parameters
   * @param {string} params.vehicleId - Vehicle ID
   * @param {string} params.vertiportId - Vertiport ID
   * @param {string} params.zoneId - Takeoff zone ID
   * @param {Date} params.scheduledTime - Scheduled takeoff time
   * @param {string} params.priority - Priority level
   * @returns {Promise<Object>} Registration result
   */
  async registerTakeoff(params) {
    const { vehicleId, vertiportId, zoneId, scheduledTime, priority } = params;
    
    try {
      // Validate parameters
      if (!vehicleId || !vertiportId || !zoneId || !scheduledTime) {
        return {
          success: false,
          error: 'Missing required parameters'
        };
      }
      
      // Find active departure sequence for this vertiport
      let sequence = Array.from(this.departureSequences.values())
        .find(seq => 
          seq.vertiportId === vertiportId && 
          seq.status === 'active' &&
          Math.abs(new Date(seq.scheduledTime) - scheduledTime) < 1800000 // Within 30 minutes
        );
      
      // Create new sequence if needed
      if (!sequence) {
        sequence = await this.createDepartureSequence(vertiportId, scheduledTime);
      }
      
      // Check if vehicle is already in sequence
      const existingVehicle = sequence.vehicles.find(v => v.vehicleId === vehicleId);
      if (existingVehicle) {
        // Update existing vehicle
        existingVehicle.takeoffZoneId = zoneId;
        existingVehicle.scheduledTime = scheduledTime;
        existingVehicle.priority = priority || 'normal';
        existingVehicle.lastUpdated = new Date();
      } else {
        // Add vehicle to sequence
        sequence.vehicles.push({
          vehicleId,
          takeoffZoneId: zoneId,
          scheduledTime,
          priority: priority || 'normal',
          status: 'ready',
          createdAt: new Date(),
          lastUpdated: new Date()
        });
      }
      
      // Apply sequencing constraints
      this.applyTakeoffSequencingConstraints(sequence);
      
      // Save updated sequence
      if (this.departureSequenceCollection) {
        await this.departureSequenceCollection.updateOne(
          { sequenceId: sequence.sequenceId },
          { $set: {
              vehicles: sequence.vehicles,
              lastUpdated: new Date()
            }
          }
        );
      }
      
      // Update metrics
      this.metrics.scheduledDepartures = Array.from(this.departureSequences.values())
        .filter(seq => seq.status === 'active')
        .reduce((count, seq) => count + (seq.vehicles?.length || 0), 0);
      
      return {
        success: true,
        sequenceId: sequence.sequenceId,
        position: sequence.vehicles.findIndex(v => v.vehicleId === vehicleId) + 1,
        scheduledTime,
        takeoffZoneId: zoneId
      };
    } catch (error) {
      console.error('Error registering takeoff:', error);
      return {
        success: false,
        error: error.message
      };
    }
  }
  
  /**
   * Create a new departure sequence
   * @param {string} vertiportId - Vertiport ID
   * @param {Date} scheduledTime - Scheduled departure time
   * @returns {Promise<Object>} Created sequence
   * @private
   */
  async createDepartureSequence(vertiportId, scheduledTime) {
    const sequenceId = `departure-${vertiportId}-${Date.now()}`;
    const now = new Date();
    
    // Create sequence
    const sequence = {
      sequenceId,
      vertiportId,
      scheduledTime,
      status: 'active',
      createdAt: now,
      lastUpdated: now,
      vehicles: []
    };
    
    // Save to database
    if (this.departureSequenceCollection) {
      await this.departureSequenceCollection.insertOne(sequence);
    }
    
    // Add to in-memory cache
    this.departureSequences.set(sequenceId, sequence);
    
    return sequence;
  }
  
  /**
   * Apply takeoff sequencing constraints
   * @param {Object} sequence - Sequence to apply constraints to
   * @private
   */
  applyTakeoffSequencingConstraints(sequence) {
    // Sort vehicles by priority and scheduled time
    sequence.vehicles.sort((a, b) => {
      // First by priority level
      const priorityOrder = { 'emergency': 0, 'high': 1, 'normal': 2, 'low': 3 };
      const aPriority = priorityOrder[a.priority] || 2;
      const bPriority = priorityOrder[b.priority] || 2;
      
      if (aPriority !== bPriority) return aPriority - bPriority;
      
      // Then by scheduled time
      return new Date(a.scheduledTime) - new Date(b.scheduledTime);
    });
    
    // Apply minimum spacing between scheduled times
    const minSpacingMs = this.options.timeBuffer * 1000;
    
    for (let i = 1; i < sequence.vehicles.length; i++) {
      const prevVehicle = sequence.vehicles[i - 1];
      const currentVehicle = sequence.vehicles[i];
      
      const prevScheduledTime = new Date(prevVehicle.scheduledTime);
      const currentScheduledTime = new Date(currentVehicle.scheduledTime);
      
      // If spacing is less than minimum, adjust current vehicle's time
      if (currentScheduledTime - prevScheduledTime < minSpacingMs) {
        const newScheduledTime = new Date(prevScheduledTime.getTime() + minSpacingMs);
        currentVehicle.scheduledTime = newScheduledTime;
      }
    }
  }
  
  /**
   * Update landing status
   * @param {Object} params - Update parameters
   * @param {string} params.vehicleId - Vehicle ID
   * @param {string} params.vertiportId - Vertiport ID
   * @param {string} params.status - New status
   * @returns {Promise<Object>} Update result
   */
  async updateLandingStatus(params) {
    const { vehicleId, vertiportId, status } = params;
    
    try {
      // Validate parameters
      if (!vehicleId || !status) {
        return {
          success: false,
          error: 'Missing required parameters'
        };
      }
      
      // Find sequence containing this vehicle
      let sequence = null;
      let vehicleIndex = -1;
      
      for (const seq of this.arrivalSequences.values()) {
        if (seq.status === 'active') {
          const index = seq.vehicles.findIndex(v => v.vehicleId === vehicleId);
          if (index !== -1) {
            sequence = seq;
            vehicleIndex = index;
            break;
          }
        }
      }
      
      if (!sequence || vehicleIndex === -1) {
        return {
          success: false,
          error: 'Vehicle not found in any active arrival sequence'
        };
      }
      
      // Update vehicle status
      const vehicle = sequence.vehicles[vehicleIndex];
      vehicle.status = status;
      vehicle.lastUpdated = new Date();
      
      // If landed, record actual landing time
      if (status === 'landed') {
        vehicle.actualLandingTime = new Date();
      }
      
      // Save updated sequence
      if (this.arrivalSequenceCollection) {
        await this.arrivalSequenceCollection.updateOne(
          { sequenceId: sequence.sequenceId },
          { $set: {
              vehicles: sequence.vehicles,
              lastUpdated: new Date()
            }
          }
        );
      }
      
      // Check if sequence is completed
      const allComplete = sequence.vehicles.every(v => 
        v.status === 'landed' || v.status === 'cancelled' || v.status === 'missing'
      );
      
      if (allComplete) {
        sequence.status = 'completed';
        sequence.completedAt = new Date();
        
        // Save to database
        await this.updateSequenceStatus(sequence.sequenceId, 'arrival', 'completed');
      }
      
      return {
        success: true,
        status,
        sequenceId: sequence.sequenceId
      };
    } catch (error) {
      console.error('Error updating landing status:', error);
      return {
        success: false,
        error: error.message
      };
    }
  }
  
  /**
   * Update takeoff status
   * @param {Object} params - Update parameters
   * @param {string} params.vehicleId - Vehicle ID
   * @param {string} params.vertiportId - Vertiport ID
   * @param {string} params.status - New status
   * @returns {Promise<Object>} Update result
   */
  async updateTakeoffStatus(params) {
    const { vehicleId, vertiportId, status } = params;
    
    try {
      // Validate parameters
      if (!vehicleId || !status) {
        return {
          success: false,
          error: 'Missing required parameters'
        };
      }
      
      // Find sequence containing this vehicle
      let sequence = null;
      let vehicleIndex = -1;
      
      for (const seq of this.departureSequences.values()) {
        if (seq.status === 'active') {
          const index = seq.vehicles.findIndex(v => v.vehicleId === vehicleId);
          if (index !== -1) {
            sequence = seq;
            vehicleIndex = index;
            break;
          }
        }
      }
      
      if (!sequence || vehicleIndex === -1) {
        return {
          success: false,
          error: 'Vehicle not found in any active departure sequence'
        };
      }
      
      // Update vehicle status
      const vehicle = sequence.vehicles[vehicleIndex];
      vehicle.status = status;
      vehicle.lastUpdated = new Date();
      
      // If departed, record actual departure time
      if (status === 'departed') {
        vehicle.actualDepartureTime = new Date();
      }
      
      // Save updated sequence
      if (this.departureSequenceCollection) {
        await this.departureSequenceCollection.updateOne(
          { sequenceId: sequence.sequenceId },
          { $set: {
              vehicles: sequence.vehicles,
              lastUpdated: new Date()
            }
          }
        );
      }
      
      // Check if sequence is completed
      const allComplete = sequence.vehicles.every(v => 
        v.status === 'departed' || v.status === 'cancelled' || v.status === 'missed'
      );
      
      if (allComplete) {
        sequence.status = 'completed';
        sequence.completedAt = new Date();
        
        // Save to database
        await this.updateSequenceStatus(sequence.sequenceId, 'departure', 'completed');
      }
      
      return {
        success: true,
        status,
        sequenceId: sequence.sequenceId
      };
    } catch (error) {
      console.error('Error updating takeoff status:', error);
      return {
        success: false,
        error: error.message
      };
    }
  }
  
  /**
   * Get flow constraints
   * @param {string} [vertiportId] - Optional vertiport ID filter
   * @returns {Array} Active flow constraints
   */
  getFlowConstraints(vertiportId) {
    let constraints = Array.from(this.flowConstraints.values());
    
    // Filter by vertiport if specified
    if (vertiportId) {
      constraints = constraints.filter(c => c.vertiportId === vertiportId);
    }
    
    return constraints;
  }
  
  /**
   * Get TBFM metrics
   * @returns {Object} TBFM metrics
   */
  getMetrics() {
    return {
      scheduledArrivals: this.metrics.scheduledArrivals,
      scheduledDepartures: this.metrics.scheduledDepartures,
      activeFlowConstraints: this.metrics.activeFlowConstraints,
      vertiportThroughput: Object.fromEntries(this.metrics.vertiportThroughput),
      sequenceCompliance: Object.fromEntries(this.metrics.sequenceCompliance),
      rnpAccuracy: this.options.rnpAccuracy,
      resilienceLevel: this.resilienceLevel
    };
  }
  
  /**
   * Set resilience level
   * @param {string} level - Resilience level ('normal', 'enhanced', 'maximum')
   * @returns {Object} Update result
   */
  setResilienceLevel(level) {
    // Validate level
    if (!['normal', 'enhanced', 'maximum'].includes(level)) {
      return {
        success: false,
        error: 'Invalid resilience level'
      };
    }
    
    const previousLevel = this.resilienceLevel;
    this.resilienceLevel = level;
    
    // Apply resilience settings
    switch (level) {
      case 'normal':
        this.options.timeBuffer = 60; // 1 minute
        this.options.resilienceBuffer = 1.5; // 50%
        break;
      
      case 'enhanced':
        this.options.timeBuffer = 90; // 1.5 minutes
        this.options.resilienceBuffer = 2.0; // 100%
        break;
      
      case 'maximum':
        this.options.timeBuffer = 120; // 2 minutes
        this.options.resilienceBuffer = 3.0; // 200%
        break;
    }
    
    // Emit resilience event
    this.emit('resilience:changed', { 
      previousLevel, 
      currentLevel: level,
      timeBuffer: this.options.timeBuffer,
      resilienceBuffer: this.options.resilienceBuffer
    });
    
    return {
      success: true,
      level,
      timeBuffer: this.options.timeBuffer,
      resilienceBuffer: this.options.resilienceBuffer
    };
  }
  
  /**
   * Shutdown the flow manager
   * @returns {Promise<boolean>} Success indicator
   */
  async shutdown() {
    try {
      console.log('Shutting down IAMS Time-Based Flow Manager');
      
      // Stop update cycle
      this.stopUpdateCycle();
      
      // Clear data structures
      this.flowConfigs.clear();
      this.vertiportCapacity.clear();
      this.arrivalSequences.clear();
      this.departureSequences.clear();
      this.flowConstraints.clear();
      
      this.isActive = false;
      console.log('IAMS Time-Based Flow Manager shutdown completed');
      return true;
    } catch (error) {
      console.error('Error shutting down IAMS Time-Based Flow Manager:', error);
      return false;
    }
  }
}

module.exports = { IAMSTimeBasedFlowManager };
```


```javascript
// Path: /IAMSWeatherRiskAssessor.js
// Written by Greg Deeds, Autonomy Association International, Inc.
// Copyright 2025 Autonomy Association International Inc., all rights reserved 
// Safeguard patent license from National Aeronautics and Space Administration (NASA)
// Copyright 2025 NASA, all rights reserved

/**
 * @fileoverview Weather risk assessment for IASMS
 * @module safeguard/iams-weather-risk-assessor
 */

const { Meteor } = require('meteor/meteor');
const turf = require('@turf/turf');
const { EventEmitter } = require('events');
const axios = require('axios');

/**
 * Class for assessing weather-related risks to UAM/UAS operations
 */
class IAMSWeatherRiskAssessor extends EventEmitter {
  /**
   * Create a new IAMSWeatherRiskAssessor instance
   * @param {Object} options - Configuration options
   * @param {Object} options.db - MongoDB database connection
   * @param {string} options.weatherApiKey - Weather API key
   * @param {string} options.weatherProvider - Weather data provider name
   * @param {number} options.updateFrequency - Update frequency in milliseconds
   * @param {Object} options.thresholds - Weather risk thresholds
   * @param {Object} options.operationalLimits - Operational weather limits
   */
  constructor(options = {}) {
    super();
    
    this.options = {
      weatherApiKey: options.weatherApiKey || process.env.WEATHER_API_KEY,
      weatherProvider: options.weatherProvider || 'nws', // National Weather Service
      updateFrequency: options.updateFrequency || 300000, // 5 minutes
      fetchRadius: options.fetchRadius || 50, // 50 km
      historicalDataEnabled: options.historicalDataEnabled !== undefined ? 
        options.historicalDataEnabled : true,
      thresholds: options.thresholds || {
        wind: {
          cautionSpeed: 15, // knots
          warningSpeed: 25, // knots
          criticalSpeed: 35, // knots
          cautionGust: 20, // knots
          warningGust: 30, // knots
          criticalGust: 40 // knots
        },
        visibility: {
          cautionVisibility: 5000, // meters
          warningVisibility: 3000, // meters
          criticalVisibility: 1000 // meters
        },
        precipitation: {
          cautionRate: 2.5, // mm/hr
          warningRate: 7.5, // mm/hr
          criticalRate: 12.5 // mm/hr
        },
        lightning: {
          cautionDistance: 50, // km
          warningDistance: 30, // km
          criticalDistance: 10 // km
        },
        temperature: {
          minOperational: -20, // °C
          maxOperational: 45 // °C
        }
      },
      operationalLimits: options.operationalLimits || {
        uamPassenger: {
          wind: 30, // knots
          gust: 35, // knots
          visibility: 2000, // meters
          precipitation: 10, // mm/hr
          minTemperature: -15, // °C
          maxTemperature: 40 // °C
        },
        uasDelivery: {
          wind: 25, // knots
          gust: 30, // knots
          visibility: 1500, // meters
          precipitation: 7.5, // mm/hr
          minTemperature: -10, // °C
          maxTemperature: 40 // °C
        },
        uasInspection: {
          wind: 20, // knots
          gust: 25, // knots
          visibility: 1000, // meters
          precipitation: 5, // mm/hr
          minTemperature: -5, // °C
          maxTemperature: 35 // °C
        }
      },
      ...options
    };
    
    this.db = options.db;
    this.weatherDataCollection = this.db ? this.db.collection('iamsWeatherData') : null;
    this.weatherAlertsCollection = this.db ? this.db.collection('iamsWeatherAlerts') : null;
    this.weatherHistoryCollection = this.db ? this.db.collection('iamsWeatherHistory') : null;
    
    // In-memory data structures
    this.currentWeatherData = new Map(); // By location ID
    this.forecastData = new Map(); // By location ID
    this.activeAlerts = new Map(); // By alert ID
    this.locationConfig = new Map(); // Monitored locations
    
    // Weather API client
    this.apiClient = null;
    
    // Operational state
    this.isActive = false;
    this.updateInterval = null;
    this.lastUpdate = null;
    this.degradedMode = false;
  }

  /**
   * Initialize the weather risk assessor
   * @async
   * @returns {Promise<void>}
   */
  async initialize() {
    try {
      console.log('Initializing IAMS Weather Risk Assessor');
      
      // Create indexes if needed
      if (this.weatherDataCollection) {
        await this.weatherDataCollection.createIndex({ "location.coordinates": "2dsphere" });
        await this.weatherDataCollection.createIndex({ locationId: 1 });
        await this.weatherDataCollection.createIndex({ timestamp: 1 });
      }
      
      if (this.weatherAlertsCollection) {
        await this.weatherAlertsCollection.createIndex({ alertId: 1 }, { unique: true });
        await this.weatherAlertsCollection.createIndex({ "area.coordinates": "2dsphere" });
        await this.weatherAlertsCollection.createIndex({ expires: 1 });
        await this.weatherAlertsCollection.createIndex({ severity: 1 });
      }
      
      if (this.weatherHistoryCollection) {
        await this.weatherHistoryCollection.createIndex({ locationId: 1 });
        await this.weatherHistoryCollection.createIndex({ timestamp: 1 });
        await this.weatherHistoryCollection.createIndex({ "location.coordinates": "2dsphere" });
      }
      
      // Initialize weather API client
      this.initializeApiClient();
      
      // Load location configurations
      await this.loadLocationConfigs();
      
      // Load active weather alerts
      await this.loadActiveAlerts();
      
      // Perform initial weather data fetch
      await this.fetchWeatherData();
      
      // Start update cycle
      this.startUpdateCycle();
      
      this.isActive = true;
      console.log('IAMS Weather Risk Assessor initialized');
    } catch (error) {
      console.error('Failed to initialize IAMS Weather Risk Assessor:', error);
      this.degradedMode = true;
      throw error;
    }
  }
  
  /**
   * Initialize weather API client
   * @private
   */
  initializeApiClient() {
    switch (this.options.weatherProvider) {
      case 'nws':
        this.apiClient = axios.create({
          baseURL: 'https://api.weather.gov',
          headers: {
            'User-Agent': '(IASMS Weather Risk Assessment, support@autonomyassociation.org)',
            'Accept': 'application/geo+json'
          },
          timeout: 10000
        });
        break;
        
      case 'openweathermap':
        this.apiClient = axios.create({
          baseURL: 'https://api.openweathermap.org/data/2.5',
          params: {
            appid: this.options.weatherApiKey,
            units: 'metric'
          },
          timeout: 10000
        });
        break;
        
      case 'weatherapi':
        this.apiClient = axios.create({
          baseURL: 'https://api.weatherapi.com/v1',
          params: {
            key: this.options.weatherApiKey
          },
          timeout: 10000
        });
        break;
        
      default:
        throw new Error(`Unsupported weather provider: ${this.options.weatherProvider}`);
    }
  }
  
  /**
   * Load location configurations
   * @async
   * @private
   */
  async loadLocationConfigs() {
    // This would typically load from database
    // For this implementation, we'll use some hardcoded locations
    
    this.locationConfig.set('downtown', {
      locationId: 'downtown',
      name: 'Downtown',
      location: {
        lat: 37.7749,
        lng: -122.4194
      },
      type: 'vertiport',
      priority: 'high'
    });
    
    this.locationConfig.set('airport', {
      locationId: 'airport',
      name: 'Airport',
      location: {
        lat: 37.6213,
        lng: -122.3790
      },
      type: 'vertiport',
      priority: 'high'
    });
    
    this.locationConfig.set('suburban', {
      locationId: 'suburban',
      name: 'Suburban Area',
      location: {
        lat: 37.3382,
        lng: -121.8863
      },
      type: 'service-area',
      priority: 'medium'
    });
    
    this.locationConfig.set('industrial', {
      locationId: 'industrial',
      name: 'Industrial Zone',
      location: {
        lat: 37.7374,
        lng: -122.2024
      },
      type: 'service-area',
      priority: 'medium'
    });
    
    console.log(`Loaded ${this.locationConfig.size} location configurations`);
  }
  
  /**
   * Load active weather alerts from database
   * @async
   * @private
   */
  async loadActiveAlerts() {
    if (!this.weatherAlertsCollection) return;
    
    try {
      const now = new Date();
      const alerts = await this.weatherAlertsCollection.find({
        expires: { $gt: now }
      }).toArray();
      
      this.activeAlerts.clear();
      for (const alert of alerts) {
        this.activeAlerts.set(alert.alertId, alert);
      }
      
      console.log(`Loaded ${this.activeAlerts.size} active weather alerts`);
    } catch (error) {
      console.error('Error loading active weather alerts:', error);
    }
  }
  
  /**
   * Start the weather update cycle
   * @private
   */
  startUpdateCycle() {
    if (this.updateInterval) {
      clearInterval(this.updateInterval);
    }
    
    this.updateInterval = setInterval(() => {
      this.updateWeatherData().catch(err => {
        console.error('Error updating weather data:', err);
      });
    }, this.options.updateFrequency);
  }
  
  /**
   * Stop the weather update cycle
   */
  stopUpdateCycle() {
    if (this.updateInterval) {
      clearInterval(this.updateInterval);
      this.updateInterval = null;
    }
  }
  
  /**
   * Update weather data
   * @async
   * @private
   */
  async updateWeatherData() {
    try {
      // Fetch latest weather data
      await this.fetchWeatherData();
      
      // Check for new weather alerts
      await this.fetchWeatherAlerts();
      
      // Process weather data and assess risks
      await this.assessWeatherRisks();
      
      // Archive historical data if enabled
      if (this.options.historicalDataEnabled) {
        await this.archiveHistoricalData();
      }
      
      // Update last update timestamp
      this.lastUpdate = new Date();
    } catch (error) {
      console.error('Error in weather update cycle:', error);
      this.degradedMode = true;
      
      // Emit degraded mode event
      this.emit('weather:degraded', {
        timestamp: new Date(),
        error: error.message
      });
    }
  }
  
  /**
   * Fetch weather data for all configured locations
   * @async
   * @private
   */
  async fetchWeatherData() {
    for (const [locationId, config] of this.locationConfig.entries()) {
      try {
        // Fetch current conditions
        const currentConditions = await this.fetchCurrentConditions(config.location);
        
        if (currentConditions) {
          // Store in memory
          this.currentWeatherData.set(locationId, {
            ...currentConditions,
            locationId,
            locationName: config.name
          });
          
          // Store in database
          if (this.weatherDataCollection) {
            await this.weatherDataCollection.updateOne(
              { locationId, dataType: 'current' },
              { $set: {
                  ...currentConditions,
                  locationId,
                  locationName: config.name,
                  dataType: 'current',
                  lastUpdated: new Date()
                }
              },
              { upsert: true }
            );
          }
        }
        
        // Fetch forecast
        const forecast = await this.fetchForecast(config.location);
        
        if (forecast) {
          // Store in memory
          this.forecastData.set(locationId, {
            ...forecast,
            locationId,
            locationName: config.name
          });
          
          // Store in database
          if (this.weatherDataCollection) {
            await this.weatherDataCollection.updateOne(
              { locationId, dataType: 'forecast' },
              { $set: {
                  ...forecast,
                  locationId,
                  locationName: config.name,
                  dataType: 'forecast',
                  lastUpdated: new Date()
                }
              },
              { upsert: true }
            );
          }
        }
      } catch (error) {
        console.error(`Error fetching weather data for ${config.name}:`, error);
      }
    }
  }
  
  /**
   * Fetch current weather conditions for a location
   * @param {Object} location - Location coordinates
   * @returns {Promise<Object|null>} Current conditions or null
   * @private
   */
  async fetchCurrentConditions(location) {
    try {
      let currentConditions = null;
      
      switch (this.options.weatherProvider) {
        case 'nws':
          // National Weather Service API
          // First, get the grid point for the location
          const pointResponse = await this.apiClient.get(`/points/${location.lat},${location.lng}`);
          const gridId = pointResponse.data.properties.gridId;
          const gridX = pointResponse.data.properties.gridX;
          const gridY = pointResponse.data.properties.gridY;
          
          // Then, get the current conditions
          const stationsResponse = await this.apiClient.get(`/gridpoints/${gridId}/${gridX},${gridY}/stations`);
          const stationId = stationsResponse.data.features[0].properties.stationIdentifier;
          
          const observationsResponse = await this.apiClient.get(`/stations/${stationId}/observations/latest`);
          const observation = observationsResponse.data.properties;
          
          currentConditions = {
            timestamp: new Date(observation.timestamp),
            location: {
              type: 'Point',
              coordinates: [location.lng, location.lat]
            },
            temperature: observation.temperature.value,
            humidity: observation.relativeHumidity.value,
            windSpeed: this.convertMpsToKnots(observation.windSpeed.value),
            windDirection: observation.windDirection.value,
            windGust: this.convertMpsToKnots(observation.windGust.value),
            visibility: observation.visibility.value,
            precipitation: observation.precipitationLastHour.value || 0,
            barometricPressure: observation.barometricPressure.value,
            description: observation.textDescription,
            dataSource: 'nws'
          };
          break;
          
        case 'openweathermap':
          // OpenWeatherMap API
          const owmResponse = await this.apiClient.get(`/weather`, {
            params: {
              lat: location.lat,
              lon: location.lng
            }
          });
          
          currentConditions = {
            timestamp: new Date(),
            location: {
              type: 'Point',
              coordinates: [location.lng, location.lat]
            },
            temperature: owmResponse.data.main.temp,
            humidity: owmResponse.data.main.humidity,
            windSpeed: this.convertMpsToKnots(owmResponse.data.wind.speed),
            windDirection: owmResponse.data.wind.deg,
            windGust: this.convertMpsToKnots(owmResponse.data.wind.gust || 0),
            visibility: owmResponse.data.visibility,
            precipitation: owmResponse.data.rain ? owmResponse.data.rain['1h'] || 0 : 0,
            barometricPressure: owmResponse.data.main.pressure,
            description: owmResponse.data.weather[0].description,
            dataSource: 'openweathermap'
          };
          break;
          
        case 'weatherapi':
          // WeatherAPI.com
          const wapiResponse = await this.apiClient.get(`/current.json`, {
            params: {
              q: `${location.lat},${location.lng}`
            }
          });
          
          const current = wapiResponse.data.current;
          
          currentConditions = {
            timestamp: new Date(current.last_updated_epoch * 1000),
            location: {
              type: 'Point',
              coordinates: [location.lng, location.lat]
            },
            temperature: current.temp_c,
            humidity: current.humidity,
            windSpeed: current.wind_kph / 1.852, // Convert km/h to knots
            windDirection: current.wind_degree,
            windGust: current.gust_kph / 1.852, // Convert km/h to knots
            visibility: current.vis_km * 1000, // Convert km to meters
            precipitation: current.precip_mm,
            barometricPressure: current.pressure_mb,
            description: current.condition.text,
            dataSource: 'weatherapi'
          };
          break;
      }
      
      return currentConditions;
    } catch (error) {
      console.error('Error fetching current conditions:', error);
      return null;
    }
  }
  
  /**
   * Fetch weather forecast for a location
   * @param {Object} location - Location coordinates
   * @returns {Promise<Object|null>} Forecast data or null
   * @private
   */
  async fetchForecast(location) {
    try {
      let forecast = null;
      
      switch (this.options.weatherProvider) {
        case 'nws':
          // National Weather Service API
          // First, get the grid point for the location
          const pointResponse = await this.apiClient.get(`/points/${location.lat},${location.lng}`);
          const forecastUrl = pointResponse.data.properties.forecast;
          
          // Then, get the forecast
          const forecastResponse = await this.apiClient.get(forecastUrl);
          const periods = forecastResponse.data.properties.periods;
          
          forecast = {
            timestamp: new Date(),
            location: {
              type: 'Point',
              coordinates: [location.lng, location.lat]
            },
            periods: periods.map(period => ({
              startTime: new Date(period.startTime),
              endTime: new Date(period.endTime),
              temperature: this.convertFahrenheitToCelsius(period.temperature),
              windSpeed: this.parseWindSpeed(period.windSpeed),
              windDirection: period.windDirection,
              description: period.shortForecast,
              precipitationProbability: period.probabilityOfPrecipitation?.value || 0
            })),
            dataSource: 'nws'
          };
          break;
          
        case 'openweathermap':
          // OpenWeatherMap API
          const owmResponse = await this.apiClient.get(`/forecast`, {
            params: {
              lat: location.lat,
              lon: location.lng
            }
          });
          
          forecast = {
            timestamp: new Date(),
            location: {
              type: 'Point',
              coordinates: [location.lng, location.lat]
            },
            periods: owmResponse.data.list.map(item => ({
              startTime: new Date(item.dt * 1000),
              endTime: new Date((item.dt + 3600 * 3) * 1000), // 3-hour periods
              temperature: item.main.temp,
              windSpeed: this.convertMpsToKnots(item.wind.speed),
              windDirection: item.wind.deg,
              description: item.weather[0].description,
              precipitationProbability: item.pop * 100,
              precipitation: item.rain ? item.rain['3h'] || 0 : 0
            })),
            dataSource: 'openweathermap'
          };
          break;
          
        case 'weatherapi':
          // WeatherAPI.com
          const wapiResponse = await this.apiClient.get(`/forecast.json`, {
            params: {
              q: `${location.lat},${location.lng}`,
              days: 3
            }
          });
          
          const forecastDays = wapiResponse.data.forecast.forecastday;
          
          // Flatten the hourly forecasts
          const periods = [];
          for (const day of forecastDays) {
            for (const hour of day.hour) {
              periods.push({
                startTime: new Date(hour.time_epoch * 1000),
                endTime: new Date(hour.time_epoch * 1000 + 3600000),
                temperature: hour.temp_c,
                windSpeed: hour.wind_kph / 1.852, // Convert km/h to knots
                windDirection: hour.wind_degree,
                description: hour.condition.text,
                precipitationProbability: hour.chance_of_rain,
                precipitation: hour.precip_mm
              });
            }
          }
          
          forecast = {
            timestamp: new Date(),
            location: {
              type: 'Point',
              coordinates: [location.lng, location.lat]
            },
            periods,
            dataSource: 'weatherapi'
          };
          break;
      }
      
      return forecast;
    } catch (error) {
      console.error('Error fetching forecast:', error);
      return null;
    }
  }
  
  /**
   * Fetch weather alerts
   * @async
   * @private
   */
  async fetchWeatherAlerts() {
    try {
      let alerts = [];
      
      switch (this.options.weatherProvider) {
        case 'nws':
          // National Weather Service API
          // Get alerts for each location
          for (const config of this.locationConfig.values()) {
            const pointResponse = await this.apiClient.get(`/points/${config.location.lat},${config.location.lng}`);
            const county = pointResponse.data.properties.county;
            
            // Get alerts for the county
            const alertsResponse = await this.apiClient.get(`/alerts/active/zone/${county}`);
            const features = alertsResponse.data.features || [];
            
            for (const feature of features) {
              const properties = feature.properties;
              
              alerts.push({
                alertId: properties.id,
                headline: properties.headline,
                description: properties.description,
                instruction: properties.instruction,
                severity: this.mapAlertSeverity(properties.severity),
                certainty: properties.certainty,
                urgency: properties.urgency,
                event: properties.event,
                onset: new Date(properties.onset),
                expires: new Date(properties.expires),
                area: feature.geometry,
                locations: [config.locationId],
                source: 'nws'
              });
            }
          }
          break;
          
        case 'openweathermap':
          // OpenWeatherMap doesn't have a dedicated alerts API in the free tier
          // We would need to use the One Call API with the paid tier
          break;
          
        case 'weatherapi':
          // WeatherAPI.com
          for (const config of this.locationConfig.values()) {
            const response = await this.apiClient.get(`/forecast.json`, {
              params: {
                q: `${config.location.lat},${config.location.lng}`,
                days: 1,
                alerts: 'yes'
              }
            });
            
            const wapiAlerts = response.data.alerts?.alert || [];
            
            for (const alert of wapiAlerts) {
              alerts.push({
                alertId: `weatherapi-${alert.headline}-${Date.now()}`,
                headline: alert.headline,
                description: alert.desc,
                instruction: alert.instruction,
                severity: this.mapAlertSeverity(alert.severity),
                event: alert.event,
                onset: new Date(alert.effective),
                expires: new Date(alert.expires),
                area: {
                  type: 'Point',
                  coordinates: [config.location.lng, config.location.lat]
                },
                locations: [config.locationId],
                source: 'weatherapi'
              });
            }
          }
          break;
      }
      
      // Process new alerts
      for (const alert of alerts) {
        // Skip if alert already exists
        if (this.activeAlerts.has(alert.alertId)) continue;
        
        // Add to active alerts
        this.activeAlerts.set(alert.alertId, alert);
        
        // Store in database
        if (this.weatherAlertsCollection) {
          await this.weatherAlertsCollection.insertOne({
            ...alert,
            created: new Date()
          });
        }
        
        // Emit alert event
        this.emit('weather:alert', alert);
      }
      
      // Clean up expired alerts
      const now = new Date();
      for (const [alertId, alert] of this.activeAlerts.entries()) {
        if (alert.expires < now) {
          // Remove from active alerts
          this.activeAlerts.delete(alertId);
          
          // Update in database
          if (this.weatherAlertsCollection) {
            await this.weatherAlertsCollection.updateOne(
              { alertId },
              { $set: { status: 'expired' } }
            );
          }
        }
      }
    } catch (error) {
      console.error('Error fetching weather alerts:', error);
    }
  }
  
  /**
   * Assess weather risks based on current conditions
   * @async
   * @private
   */
  async assessWeatherRisks() {
    try {
      // Process each location
      for (const [locationId, weather] of this.currentWeatherData.entries()) {
        // Skip if weather data is stale (older than 30 minutes)
        const now = new Date();
        if (now - new Date(weather.timestamp) > 1800000) continue;
        
        // Get location config
        const config = this.locationConfig.get(locationId);
        if (!config) continue;
        
        // Assess wind risk
        const windRisk = this.assessWindRisk(weather);
        
        // Assess visibility risk
        const visibilityRisk = this.assessVisibilityRisk(weather);
        
        // Assess precipitation risk
        const precipitationRisk = this.assessPrecipitationRisk(weather);
        
        // Assess temperature risk
        const temperatureRisk = this.assessTemperatureRisk(weather);
        
        // Assess lightning risk (if data available)
        const lightningRisk = this.assessLightningRisk(weather);
        
        // Get operational status
        const uamStatus = this.getOperationalStatus(weather, 'uamPassenger');
        const uasDeliveryStatus = this.getOperationalStatus(weather, 'uasDelivery');
        const uasInspectionStatus = this.getOperationalStatus(weather, 'uasInspection');
        
        // Combined risk assessment
        const risks = [windRisk, visibilityRisk, precipitationRisk, temperatureRisk, lightningRisk]
          .filter(risk => risk !== null);
        
        const maxRiskLevel = Math.max(...risks.map(risk => risk.level));
        
        // Create weather risk assessment
        const assessment = {
          locationId,
          locationName: config.name,
          timestamp: now,
          weather: {
            temperature: weather.temperature,
            windSpeed: weather.windSpeed,
            windDirection: weather.windDirection,
            windGust: weather.windGust,
            visibility: weather.visibility,
            precipitation: weather.precipitation,
            description: weather.description
          },
          risks: {
            wind: windRisk,
            visibility: visibilityRisk,
            precipitation: precipitationRisk,
            temperature: temperatureRisk,
            lightning: lightningRisk
          },
          operationalStatus: {
            uamPassenger: uamStatus,
            uasDelivery: uasDeliveryStatus,
            uasInspection: uasInspectionStatus
          },
          overallRiskLevel: maxRiskLevel,
          overallRiskCategory: this.getRiskCategory(maxRiskLevel)
        };
        
        // Store assessment in database
        if (this.weatherDataCollection) {
          await this.weatherDataCollection.updateOne(
            { locationId, dataType: 'risk-assessment' },
            { $set: assessment },
            { upsert: true }
          );
        }
        
        // Emit risk assessment event
        this.emit('weather:risk-assessment', assessment);
      }
    } catch (error) {
      console.error('Error assessing weather risks:', error);
    }
  }
  
  /**
   * Assess wind risk
   * @param {Object} weather - Current weather data
   * @returns {Object|null} Wind risk assessment or null
   * @private
   */
  assessWindRisk(weather) {
    if (weather.windSpeed === undefined) return null;
    
    const { wind } = this.options.thresholds;
    let level = 0;
    let category = 'none';
    let description = 'No significant wind';
    
    // Assess based on sustained wind speed
    if (weather.windSpeed >= wind.criticalSpeed) {
      level = 1.0;
      category = 'critical';
      description = `Critical wind conditions: ${weather.windSpeed.toFixed(1)} knots`;
    } else if (weather.windSpeed >= wind.warningSpeed) {
      level = 0.7;
      category = 'warning';
      description = `Strong winds: ${weather.windSpeed.toFixed(1)} knots`;
    } else if (weather.windSpeed >= wind.cautionSpeed) {
      level = 0.4;
      category = 'caution';
      description = `Moderate winds: ${weather.windSpeed.toFixed(1)} knots`;
    }
    
    // Check for gusts
    if (weather.windGust !== undefined && weather.windGust > 0) {
      if (weather.windGust >= wind.criticalGust) {
        level = Math.max(level, 1.0);
        category = 'critical';
        description = `Critical wind gusts: ${weather.windGust.toFixed(1)} knots`;
      } else if (weather.windGust >= wind.warningGust) {
        level = Math.max(level, 0.7);
        if (category !== 'critical') {
          category = 'warning';
          description = `Strong wind gusts: ${weather.windGust.toFixed(1)} knots`;
        }
      } else if (weather.windGust >= wind.cautionGust) {
        level = Math.max(level, 0.4);
        if (category !== 'critical' && category !== 'warning') {
          category = 'caution';
          description = `Moderate wind gusts: ${weather.windGust.toFixed(1)} knots`;
        }
      }
    }
    
    return {
      type: 'wind',
      level,
      category,
      description,
      data: {
        windSpeed: weather.windSpeed,
        windGust: weather.windGust,
        windDirection: weather.windDirection
      }
    };
  }
  
  /**
   * Assess visibility risk
   * @param {Object} weather - Current weather data
   * @returns {Object|null} Visibility risk assessment or null
   * @private
   */
  assessVisibilityRisk(weather) {
    if (weather.visibility === undefined) return null;
    
    const { visibility } = this.options.thresholds;
    let level = 0;
    let category = 'none';
    let description = 'Good visibility';
    
    if (weather.visibility <= visibility.criticalVisibility) {
      level = 1.0;
      category = 'critical';
      description = `Very low visibility: ${(weather.visibility / 1000).toFixed(1)} km`;
    } else if (weather.visibility <= visibility.warningVisibility) {
      level = 0.7;
      category = 'warning';
      description = `Low visibility: ${(weather.visibility / 1000).toFixed(1)} km`;
    } else if (weather.visibility <= visibility.cautionVisibility) {
      level = 0.4;
      category = 'caution';
      description = `Reduced visibility: ${(weather.visibility / 1000).toFixed(1)} km`;
    }
    
    return {
      type: 'visibility',
      level,
      category,
      description,
      data: {
        visibility: weather.visibility
      }
    };
  }
  
  /**
   * Assess precipitation risk
   * @param {Object} weather - Current weather data
   * @returns {Object|null} Precipitation risk assessment or null
   * @private
   */
  assessPrecipitationRisk(weather) {
    if (weather.precipitation === undefined) return null;
    
    const { precipitation } = this.options.thresholds;
    let level = 0;
    let category = 'none';
    let description = 'No precipitation';
    
    if (weather.precipitation >= precipitation.criticalRate) {
      level = 1.0;
      category = 'critical';
      description = `Heavy precipitation: ${weather.precipitation.toFixed(1)} mm/hr`;
    } else if (weather.precipitation >= precipitation.warningRate) {
      level = 0.7;
      category = 'warning';
      description = `Moderate precipitation: ${weather.precipitation.toFixed(1)} mm/hr`;
    } else if (weather.precipitation >= precipitation.cautionRate) {
      level = 0.4;
      category = 'caution';
      description = `Light precipitation: ${weather.precipitation.toFixed(1)} mm/hr`;
    }
    
    return {
      type: 'precipitation',
      level,
      category,
      description,
      data: {
        precipitation: weather.precipitation
      }
    };
  }
  
  /**
   * Assess temperature risk
   * @param {Object} weather - Current weather data
   * @returns {Object|null} Temperature risk assessment or null
   * @private
   */
  assessTemperatureRisk(weather) {
    if (weather.temperature === undefined) return null;
    
    const { temperature } = this.options.thresholds;
    let level = 0;
    let category = 'none';
    let description = 'Temperature within operational range';
    
    // Check if temperature is outside operational range
    if (weather.temperature < temperature.minOperational) {
      level = 0.7;
      category = 'warning';
      description = `Temperature below operational minimum: ${weather.temperature.toFixed(1)}°C`;
      
      // If significantly below minimum, escalate to critical
      if (weather.temperature < temperature.minOperational - 10) {
        level = 1.0;
        category = 'critical';
        description = `Temperature critically low: ${weather.temperature.toFixed(1)}°C`;
      }
    } else if (weather.temperature > temperature.maxOperational) {
      level = 0.7;
      category = 'warning';
      description = `Temperature above operational maximum: ${weather.temperature.toFixed(1)}°C`;
      
      // If significantly above maximum, escalate to critical
      if (weather.temperature > temperature.maxOperational + 10) {
        level = 1.0;
        category = 'critical';
        description = `Temperature critically high: ${weather.temperature.toFixed(1)}°C`;
      }
    }
    
    return {
      type: 'temperature',
      level,
      category,
      description,
      data: {
        temperature: weather.temperature
      }
    };
  }
  
  /**
   * Assess lightning risk
   * @param {Object} weather - Current weather data
   * @returns {Object|null} Lightning risk assessment or null
   * @private
   */
  assessLightningRisk(weather) {
    // Skip if no lightning data
    if (!weather.lightning) return null;
    
    const { lightning } = this.options.thresholds;
    let level = 0;
    let category = 'none';
    let description = 'No lightning activity';
    
    // If lightning data is available, assess based on distance
    if (weather.lightning.distance !== undefined) {
      if (weather.lightning.distance <= lightning.criticalDistance) {
        level = 1.0;
        category = 'critical';
        description = `Lightning very close: ${weather.lightning.distance.toFixed(1)} km`;
      } else if (weather.lightning.distance <= lightning.warningDistance) {
        level = 0.7;
        category = 'warning';
        description = `Lightning nearby: ${weather.lightning.distance.toFixed(1)} km`;
      } else if (weather.lightning.distance <= lightning.cautionDistance) {
        level = 0.4;
        category = 'caution';
        description = `Lightning in the area: ${weather.lightning.distance.toFixed(1)} km`;
      }
    }
    
    return {
      type: 'lightning',
      level,
      category,
      description,
      data: weather.lightning
    };
  }
  
  /**
   * Get operational status for a vehicle type
   * @param {Object} weather - Current weather data
   * @param {string} vehicleType - Vehicle type
   * @returns {Object} Operational status
   * @private
   */
  getOperationalStatus(weather, vehicleType) {
    const limits = this.options.operationalLimits[vehicleType];
    if (!limits) return { status: 'unknown' };
    
    let status = 'go';
    const restrictions = [];
    
    // Check wind
    if (weather.windSpeed !== undefined) {
      if (weather.windSpeed > limits.wind) {
        status = 'no-go';
        restrictions.push(`Wind speed exceeds limit (${weather.windSpeed.toFixed(1)} > ${limits.wind} knots)`);
      }
    }
    
    // Check gusts
    if (weather.windGust !== undefined) {
      if (weather.windGust > limits.gust) {
        status = 'no-go';
        restrictions.push(`Wind gusts exceed limit (${weather.windGust.toFixed(1)} > ${limits.gust} knots)`);
      }
    }
    
    // Check visibility
    if (weather.visibility !== undefined) {
      if (weather.visibility < limits.visibility) {
        status = 'no-go';
        restrictions.push(`Visibility below limit (${(weather.visibility / 1000).toFixed(1)} < ${(limits.visibility / 1000).toFixed(1)} km)`);
      }
    }
    
    // Check precipitation
    if (weather.precipitation !== undefined) {
      if (weather.precipitation > limits.precipitation) {
        status = 'no-go';
        restrictions.push(`Precipitation exceeds limit (${weather.precipitation.toFixed(1)} > ${limits.precipitation} mm/hr)`);
      }
    }
    
    // Check temperature
    if (weather.temperature !== undefined) {
      if (weather.temperature < limits.minTemperature) {
        status = 'no-go';
        restrictions.push(`Temperature below limit (${weather.temperature.toFixed(1)} < ${limits.minTemperature}°C)`);
      } else if (weather.temperature > limits.maxTemperature) {
        status = 'no-go';
        restrictions.push(`Temperature above limit (${weather.temperature.toFixed(1)} > ${limits.maxTemperature}°C)`);
      }
    }
    
    return {
      status,
      restrictions,
      vehicleType
    };
  }
  
  /**
   * Archive historical weather data
   * @async
   * @private
   */
  async archiveHistoricalData() {
    if (!this.weatherHistoryCollection) return;
    
    try {
      // Save current weather data to history
      for (const [locationId, weather] of this.currentWeatherData.entries()) {
        await this.weatherHistoryCollection.insertOne({
          ...weather,
          archivedAt: new Date()
        });
      }
    } catch (error) {
      console.error('Error archiving historical weather data:', error);
    }
  }
  
  /**
   * Get severe weather alerts
   * @param {Object} [filters] - Optional filters
   * @returns {Promise<Array>} Severe weather alerts
   */
  async getSevereWeatherAlerts(filters = {}) {
    try {
      // Get active alerts
      let alerts = Array.from(this.activeAlerts.values());
      
      // Filter by severity if specified
      if (filters.minSeverity) {
        const severityLevels = { 'critical': 3, 'warning': 2, 'caution': 1, 'none': 0 };
        const minLevel = severityLevels[filters.minSeverity] || 0;
        alerts = alerts.filter(alert => {
          const alertLevel = severityLevels[alert.severity] || 0;
          return alertLevel >= minLevel;
        });
      }
      
      // Filter by location if specified
      if (filters.locationId) {
        alerts = alerts.filter(alert => 
          alert.locations.includes(filters.locationId)
        );
      }
      
      // Sort by severity (most severe first)
      alerts.sort((a, b) => {
        const severityOrder = { 'critical': 0, 'warning': 1, 'caution': 2, 'none': 3 };
        return severityOrder[a.severity] - severityOrder[b.severity];
      });
      
      return alerts;
    } catch (error) {
      console.error('Error getting severe weather alerts:', error);
      return [];
    }
  }
  
  /**
   * Get current weather data for a location
   * @param {string} locationId - Location ID
   * @returns {Object|null} Current weather data or null
   */
  getCurrentWeather(locationId) {
    return this.currentWeatherData.get(locationId) || null;
  }
  
  /**
   * Get weather forecast for a location
   * @param {string} locationId - Location ID
   * @returns {Object|null} Weather forecast or null
   */
  getWeatherForecast(locationId) {
    return this.forecastData.get(locationId) || null;
  }
  
  /**
   * Get weather risk assessment for a location
   * @param {string} locationId - Location ID
   * @returns {Promise<Object|null>} Risk assessment or null
   */
  async getWeatherRiskAssessment(locationId) {
    if (!this.weatherDataCollection) return null;
    
    try {
      const assessment = await this.weatherDataCollection.findOne({
        locationId,
        dataType: 'risk-assessment'
      });
      
      return assessment || null;
    } catch (error) {
      console.error('Error getting weather risk assessment:', error);
      return null;
    }
  }
  
  /**
   * Get all monitored locations
   * @returns {Array} Location configurations
   */
  getMonitoredLocations() {
    return Array.from(this.locationConfig.values());
  }
  
  /**
   * Check if weather conditions are acceptable for a given operation
   * @param {Object} params - Parameters
   * @param {string} params.locationId - Location ID
   * @param {string} params.vehicleType - Vehicle type
   * @param {string} params.operationType - Operation type (e.g., 'takeoff', 'landing', 'transit')
   * @returns {Promise<Object>} Weather check result
   */
  async checkWeatherConditions(params) {
    const { locationId, vehicleType, operationType } = params;
    
    try {
      // Get current weather
      const weather = this.currentWeatherData.get(locationId);
      if (!weather) {
        return {
          acceptable: false,
          status: 'unknown',
          reason: 'Weather data not available',
          timestamp: new Date()
        };
      }
      
      // Get operational status
      const status = this.getOperationalStatus(weather, vehicleType);
      
      // Check if acceptable
      const acceptable = status.status === 'go';
      
      // Get weather risk assessment
      let riskLevel = 'unknown';
      const assessment = await this.getWeatherRiskAssessment(locationId);
      if (assessment) {
        riskLevel = assessment.overallRiskCategory;
      }
      
      return {
        acceptable,
        status: status.status,
        restrictions: status.restrictions,
        riskLevel,
        weather: {
          temperature: weather.temperature,
          windSpeed: weather.windSpeed,
          windGust: weather.windGust,
          visibility: weather.visibility,
          precipitation: weather.precipitation,
          description: weather.description
        },
        timestamp: new Date(),
        dataSource: weather.dataSource,
        dataAge: new Date() - new Date(weather.timestamp)
      };
    } catch (error) {
      console.error('Error checking weather conditions:', error);
      return {
        acceptable: false,
        status: 'error',
        reason: `Error checking weather: ${error.message}`,
        timestamp: new Date()
      };
    }
  }
  
  /**
   * Shutdown the weather risk assessor
   * @returns {Promise<boolean>} Success indicator
   */
  async shutdown() {
    try {
      console.log('Shutting down IAMS Weather Risk Assessor');
      
      // Stop update cycle
      this.stopUpdateCycle();
      
      // Clear data structures
      this.currentWeatherData.clear();
      this.forecastData.clear();
      this.activeAlerts.clear();
      
      this.isActive = false;
      console.log('IAMS Weather Risk Assessor shutdown completed');
      return true;
    } catch (error) {
      console.error('Error shutting down IAMS Weather Risk Assessor:', error);
      return false;
    }
  }
  
  /**
   * Map alert severity to standardized category
   * @param {string} severity - Original severity
   * @returns {string} Standardized severity category
   * @private
   */
  mapAlertSeverity(severity) {
    severity = severity.toLowerCase();
    
    if (['extreme', 'severe'].includes(severity)) {
      return 'critical';
    } else if (['moderate'].includes(severity)) {
      return 'warning';
    } else if (['minor'].includes(severity)) {
      return 'caution';
    } else {
      return 'none';
    }
  }
  
  /**
   * Get risk category from numeric level
   * @param {number} level - Risk level (0-1)
   * @returns {string} Risk category
   * @private
   */
  getRiskCategory(level) {
    if (level >= 0.8) return 'critical';
    if (level >= 0.5) return 'warning';
    if (level >= 0.2) return 'caution';
    return 'none';
  }
  
  /**
   * Convert meters per second to knots
   * @param {number} mps - Speed in meters per second
   * @returns {number} Speed in knots
   * @private
   */
  convertMpsToKnots(mps) {
    if (mps === undefined || mps === null) return 0;
    return mps * 1.94384; // 1 m/s = 1.94384 knots
  }
  
  /**
   * Convert Fahrenheit to Celsius
   * @param {number} fahrenheit - Temperature in Fahrenheit
   * @returns {number} Temperature in Celsius
   * @private
   */
  convertFahrenheitToCelsius(fahrenheit) {
    return (fahrenheit - 32) * 5 / 9;
  }
  
  /**
   * Parse wind speed string (e.g., "10 to 15 mph")
   * @param {string} windSpeed - Wind speed string
   * @returns {number} Wind speed in knots
   * @private
   */
  parseWindSpeed(windSpeed) {
    // Extract numbers from string
    const matches = windSpeed.match(/\d+/g);
    if (!matches || matches.length === 0) return 0;
    
    // Use the higher number if range
    const speed = Math.max(...matches.map(m => parseInt(m, 10)));
    
    // Convert based on units
    if (windSpeed.toLowerCase().includes('mph')) {
      return speed * 0.868976; // mph to knots
    } else if (windSpeed.toLowerCase().includes('km/h') || windSpeed.toLowerCase().includes('kph')) {
      return speed * 0.539957; // km/h to knots
    } else if (windSpeed.toLowerCase().includes('m/s')) {
      return speed * 1.94384; // m/s to knots
    } else {
      return speed; // Assume already in knots
    }
  }
}

module.exports = { IAMSWeatherRiskAssessor };
```


```javascript
// Path: /IAMSCollisionRiskPredictor.js
// Written by Greg Deeds, Autonomy Association International, Inc.
// Copyright 2025 Autonomy Association International Inc., all rights reserved 
// Safeguard patent license from National Aeronautics and Space Administration (NASA)
// Copyright 2025 NASA, all rights reserved

/**
 * @fileoverview Collision risk prediction for IASMS including bird strike risks
 * @module safeguard/iams-collision-risk-predictor
 */

const { Meteor } = require('meteor/meteor');
const turf = require('@turf/turf');
const { GeospatialUtils } = require('./GeospatialUtilityFunctions');
const { EventEmitter } = require('events');

/**
 * Class for predicting collision risks, including bird strikes,
 * and generating mitigation strategies for UAM/UAS operations
 */
class IAMSCollisionRiskPredictor extends EventEmitter {
  /**
   * Create a new IAMSCollisionRiskPredictor instance
   * @param {Object} options - Configuration options
   * @param {Object} options.db - MongoDB database connection
   * @param {Object} options.predictor - IAMS Predictor reference
   * @param {Object} options.weatherRiskAssessor - Weather risk assessor reference
   * @param {number} options.updateFrequency - Update frequency in milliseconds
   * @param {Object} options.birdActivity - Bird activity configuration
   * @param {Object} options.collisionThresholds - Collision risk thresholds
   */
  constructor(options = {}) {
    super();
    
    this.options = {
      updateFrequency: options.updateFrequency || 5000, // 5 seconds
      predictionHorizon: options.predictionHorizon || 300, // 5 minutes
      horizontalWarningDistance: options.horizontalWarningDistance || 500, // 500 meters
      verticalWarningDistance: options.verticalWarningDistance || 100, // 100 meters
      birdActivity: options.birdActivity || {
        migrationSeasons: [
          { start: '03-01', end: '05-31' }, // Spring migration
          { start: '08-15', end: '11-15' }  // Fall migration
        ],
        dailyPatterns: [
          { start: '05:00', end: '10:00', activityLevel: 'high' },    // Morning
          { start: '10:00', end: '16:00', activityLevel: 'medium' },  // Mid-day
          { start: '16:00', end: '20:00', activityLevel: 'high' },    // Evening
          { start: '20:00', end: '05:00', activityLevel: 'low' }      // Night
        ],
        weatherFactors: {
          windEffect: true,
          visibilityEffect: true,
          temperatureEffect: true
        }
      },
      collisionThresholds: options.collisionThresholds || {
        timeToCollision: {
          critical: 30, // seconds
          warning: 60,  // seconds
          caution: 120  // seconds
        },
        probabilityThresholds: {
          critical: 0.7,
          warning: 0.4,
          caution: 0.2
        }
      },
      ...options
    };
    
    this.db = options.db;
    this.predictor = options.predictor;
    this.weatherRiskAssessor = options.weatherRiskAssessor;
    
    // Collections
    this.collisionRisksCollection = this.db ? this.db.collection('iamsCollisionRisks') : null;
    this.birdStrikeRisksCollection = this.db ? this.db.collection('iamsBirdStrikeRisks') : null;
    this.avianActivityCollection = this.db ? this.db.collection('iamsAvianActivity') : null;
    this.avoidanceManeuversCollection = this.db ? this.db.collection('iamsAvoidanceManeuvers') : null;
    
    // In-memory data structures
    this.activeCollisionRisks = new Map();
    this.activeBirdStrikeRisks = new Map();
    this.historicalBirdStrikes = new Map();
    this.avianActivityZones = new Map();
    
    // Bird species database
    this.birdSpeciesData = new Map();
    
    // Update cycle
    this.updateInterval = null;
    this.isProcessing = false;
  }

  /**
   * Initialize the collision risk predictor
   * @async
   * @returns {Promise<void>}
   */
  async initialize() {
    try {
      console.log('Initializing IAMS Collision Risk Predictor');
      
      // Create indexes if needed
      if (this.collisionRisksCollection) {
        await this.collisionRisksCollection.createIndex({ riskId: 1 }, { unique: true });
        await this.collisionRisksCollection.createIndex({ vehicleId: 1 });
        await this.collisionRisksCollection.createIndex({ timestamp: 1 });
        await this.collisionRisksCollection.createIndex({ riskLevel: 1 });
        await this.collisionRisksCollection.createIndex({ "location.coordinates": "2dsphere" });
      }
      
      if (this.birdStrikeRisksCollection) {
        await this.birdStrikeRisksCollection.createIndex({ riskId: 1 }, { unique: true });
        await this.birdStrikeRisksCollection.createIndex({ vehicleId: 1 });
        await this.birdStrikeRisksCollection.createIndex({ timestamp: 1 });
        await this.birdStrikeRisksCollection.createIndex({ riskLevel: 1 });
        await this.birdStrikeRisksCollection.createIndex({ "location.coordinates": "2dsphere" });
      }
      
      if (this.avianActivityCollection) {
        await this.avianActivityCollection.createIndex({ zoneId: 1 }, { unique: true });
        await this.avianActivityCollection.createIndex({ "area.coordinates": "2dsphere" });
        await this.avianActivityCollection.createIndex({ activityLevel: 1 });
      }
      
      if (this.avoidanceManeuversCollection) {
        await this.avoidanceManeuversCollection.createIndex({ maneuverId: 1 }, { unique: true });
        await this.avoidanceManeuversCollection.createIndex({ vehicleId: 1 });
        await this.avoidanceManeuversCollection.createIndex({ timestamp: 1 });
        await this.avoidanceManeuversCollection.createIndex({ riskId: 1 });
      }
      
      // Load avian activity zones
      await this.loadAvianActivityZones();
      
      // Load bird species data
      await this.loadBirdSpeciesData();
      
      // Load historical bird strike data
      await this.loadHistoricalBirdStrikes();
      
      // Start update cycle
      this.startUpdateCycle();
      
      console.log('IAMS Collision Risk Predictor initialized');
    } catch (error) {
      console.error('Failed to initialize IAMS Collision Risk Predictor:', error);
      throw error;
    }
  }
  
  /**
   * Load avian activity zones from database
   * @async
   * @private
   */
  async loadAvianActivityZones() {
    if (!this.avianActivityCollection) return;
    
    try {
      const zones = await this.avianActivityCollection.find({}).toArray();
      
      this.avianActivityZones.clear();
      for (const zone of zones) {
        this.avianActivityZones.set(zone.zoneId, zone);
      }
      
      console.log(`Loaded ${this.avianActivityZones.size} avian activity zones`);
      
      // If no zones are found, create some default zones
      if (this.avianActivityZones.size === 0) {
        await this.createDefaultAvianActivityZones();
      }
    } catch (error) {
      console.error('Error loading avian activity zones:', error);
    }
  }
  
  /**
   * Create default avian activity zones
   * @async
   * @private
   */
  async createDefaultAvianActivityZones() {
    if (!this.avianActivityCollection) return;
    
    try {
      // Example default zones
      const defaultZones = [
        {
          zoneId: 'riverfront',
          name: 'Riverfront Area',
          description: 'River and surrounding wetlands with high bird activity',
          area: {
            type: 'Polygon',
            coordinates: [[
              [-122.4194, 37.7749], // San Francisco coordinates as example
              [-122.4294, 37.7849],
              [-122.4094, 37.7849],
              [-122.4094, 37.7649],
              [-122.4294, 37.7649],
              [-122.4194, 37.7749]
            ]]
          },
          activityLevel: 'high',
          primarySpecies: ['gulls', 'waterfowl', 'shorebirds'],
          seasonality: {
            spring: 'high',
            summer: 'medium',
            fall: 'high',
            winter: 'medium'
          },
          createdAt: new Date()
        },
        {
          zoneId: 'urban-park',
          name: 'Urban Park',
          description: 'Large urban park with diverse bird population',
          area: {
            type: 'Polygon',
            coordinates: [[
              [-122.4594, 37.7749],
              [-122.4694, 37.7849],
              [-122.4494, 37.7849],
              [-122.4494, 37.7649],
              [-122.4694, 37.7649],
              [-122.4594, 37.7749]
            ]]
          },
          activityLevel: 'medium',
          primarySpecies: ['pigeons', 'songbirds', 'raptors'],
          seasonality: {
            spring: 'high',
            summer: 'high',
            fall: 'medium',
            winter: 'low'
          },
          createdAt: new Date()
        },
        {
          zoneId: 'airport-vicinity',
          name: 'Airport Vicinity',
          description: 'Areas around the airport with bird strike concerns',
          area: {
            type: 'Polygon',
            coordinates: [[
              [-122.3790, 37.6213],
              [-122.3890, 37.6313],
              [-122.3690, 37.6313],
              [-122.3690, 37.6113],
              [-122.3890, 37.6113],
              [-122.3790, 37.6213]
            ]]
          },
          activityLevel: 'high',
          primarySpecies: ['gulls', 'raptors', 'waterfowl'],
          seasonality: {
            spring: 'high',
            summer: 'medium',
            fall: 'high',
            winter: 'medium'
          },
          createdAt: new Date()
        }
      ];
      
      // Insert default zones
      for (const zone of defaultZones) {
        await this.avianActivityCollection.insertOne(zone);
        this.avianActivityZones.set(zone.zoneId, zone);
      }
      
      console.log(`Created ${defaultZones.length} default avian activity zones`);
    } catch (error) {
      console.error('Error creating default avian activity zones:', error);
    }
  }
  
  /**
   * Load bird species data
   * @async
   * @private
   */
  async loadBirdSpeciesData() {
    // In a real implementation, this would load from a database
    // For this implementation, we'll use hardcoded data
    
    this.birdSpeciesData.set('gulls', {
      name: 'Gulls',
      typicalWeight: 1.0, // kg
      typicalWingspan: 1.4, // meters
      flockBehavior: 'moderate',
      flightAltitude: {
        min: 10,
        max: 500,
        typical: 100
      },
      collisionRisk: 'high',
      commonLocations: ['coastal', 'urban', 'landfills', 'waterways']
    });
    
    this.birdSpeciesData.set('pigeons', {
      name: 'Pigeons',
      typicalWeight: 0.3, // kg
      typicalWingspan: 0.7, // meters
      flockBehavior: 'strong',
      flightAltitude: {
        min: 5,
        max: 300,
        typical: 50
      },
      collisionRisk: 'medium',
      commonLocations: ['urban', 'buildings', 'parks']
    });
    
    this.birdSpeciesData.set('raptors', {
      name: 'Raptors',
      typicalWeight: 1.5, // kg
      typicalWingspan: 1.8, // meters
      flockBehavior: 'solitary',
      flightAltitude: {
        min: 50,
        max: 1000,
        typical: 300
      },
      collisionRisk: 'high',
      commonLocations: ['urban', 'rural', 'mountains', 'forests']
    });
    
    this.birdSpeciesData.set('waterfowl', {
      name: 'Waterfowl',
      typicalWeight: 2.5, // kg
      typicalWingspan: 1.5, // meters
      flockBehavior: 'strong',
      flightAltitude: {
        min: 10,
        max: 1000,
        typical: 150
      },
      collisionRisk: 'high',
      commonLocations: ['wetlands', 'lakes', 'rivers', 'coastal']
    });
    
    this.birdSpeciesData.set('songbirds', {
      name: 'Songbirds',
      typicalWeight: 0.05, // kg
      typicalWingspan: 0.25, // meters
      flockBehavior: 'moderate',
      flightAltitude: {
        min: 5,
        max: 200,
        typical: 30
      },
      collisionRisk: 'low',
      commonLocations: ['urban', 'forests', 'parks', 'rural']
    });
    
    this.birdSpeciesData.set('shorebirds', {
      name: 'Shorebirds',
      typicalWeight: 0.3, // kg
      typicalWingspan: 0.6, // meters
      flockBehavior: 'strong',
      flightAltitude: {
        min: 5,
        max: 500,
        typical: 50
      },
      collisionRisk: 'medium',
      commonLocations: ['coastal', 'wetlands', 'marshes']
    });
    
    console.log(`Loaded data for ${this.birdSpeciesData.size} bird species`);
  }
  
  /**
   * Load historical bird strike data
   * @async
   * @private
   */
  async loadHistoricalBirdStrikes() {
    if (!this.birdStrikeRisksCollection) return;
    
    try {
      // Get historical confirmed bird strikes
      const strikes = await this.birdStrikeRisksCollection.find({
        confirmed: true,
        timestamp: { $gt: new Date(Date.now() - 31536000000) } // Last year
      }).toArray();
      
      this.historicalBirdStrikes.clear();
      for (const strike of strikes) {
        this.historicalBirdStrikes.set(strike.riskId, strike);
      }
      
      console.log(`Loaded ${this.historicalBirdStrikes.size} historical bird strikes`);
    } catch (error) {
      console.error('Error loading historical bird strikes:', error);
    }
  }
  
  /**
   * Start the update cycle
   * @private
   */
  startUpdateCycle() {
    if (this.updateInterval) {
      clearInterval(this.updateInterval);
    }
    
    this.updateInterval = setInterval(() => {
      this.updateCollisionRisks().catch(err => {
        console.error('Error updating collision risks:', err);
      });
    }, this.options.updateFrequency);
  }
  
  /**
   * Stop the update cycle
   */
  stopUpdateCycle() {
    if (this.updateInterval) {
      clearInterval(this.updateInterval);
      this.updateInterval = null;
    }
  }
  
  /**
   * Update collision risks
   * @async
   * @private
   */
  async updateCollisionRisks() {
    if (this.isProcessing) return;
    
    this.isProcessing = true;
    try {
      // Check if predictor is available
      if (!this.predictor) {
        console.warn('Predictor not available, skipping collision risk update');
        return;
      }
      
      // 1. Assess vehicle-to-vehicle collision risks
      await this.assessVehicleCollisionRisks();
      
      // 2. Assess bird strike risks
      await this.assessBirdStrikeRisks();
      
      // 3. Generate avoidance maneuvers
      await this.generateAvoidanceManeuvers();
      
      // 4. Clean up expired risks
      await this.cleanupExpiredRisks();
    } catch (error) {
      console.error('Error in collision risk update cycle:', error);
    } finally {
      this.isProcessing = false;
    }
  }
  
  /**
   * Assess vehicle-to-vehicle collision risks
   * @async
   * @private
   */
  async assessVehicleCollisionRisks() {
    try {
      // Get active vehicles and trajectories from predictor
      const vehicles = this.predictor.vehicles || new Map();
      const trajectories = this.predictor.trajectories || new Map();
      
      // Skip if no vehicles or trajectories
      if (vehicles.size === 0 || trajectories.size === 0) return;
      
      // Get predicted conflicts from predictor
      const predictedConflicts = this.predictor.predictedConflicts || new Map();
      
      // Process each conflict
      for (const [conflictId, conflict] of predictedConflicts.entries()) {
        // Skip if not a vehicle-vehicle conflict
        if (!conflict.vehicle1 || !conflict.vehicle2) continue;
        
        // Calculate time to collision
        const timeToCollision = conflict.timeOffset; // seconds
        
        // Calculate risk level based on time to collision
        let riskLevel = 0;
        let riskCategory = 'none';
        
        const { timeToCollision: ttcThresholds } = this.options.collisionThresholds;
        
        if (timeToCollision <= ttcThresholds.critical) {
          riskLevel = 1.0;
          riskCategory = 'critical';
        } else if (timeToCollision <= ttcThresholds.warning) {
          riskLevel = 0.7;
          riskCategory = 'warning';
        } else if (timeToCollision <= ttcThresholds.caution) {
          riskLevel = 0.4;
          riskCategory = 'caution';
        } else {
          riskLevel = 0.1;
          riskCategory = 'low';
        }
        
        // Create collision risk for each vehicle
        await this.createCollisionRisk(
          conflict.vehicle1.vehicleId,
          conflict.vehicle2.vehicleId,
          conflict,
          riskLevel,
          riskCategory,
          timeToCollision
        );
        
        await this.createCollisionRisk(
          conflict.vehicle2.vehicleId,
          conflict.vehicle1.vehicleId,
          conflict,
          riskLevel,
          riskCategory,
          timeToCollision
        );
      }
    } catch (error) {
      console.error('Error assessing vehicle collision risks:', error);
    }
  }
  
  /**
   * Create a collision risk record
   * @param {string} vehicleId - Vehicle ID
   * @param {string} otherVehicleId - Other vehicle ID
   * @param {Object} conflict - Conflict data
   * @param {number} riskLevel - Risk level (0-1)
   * @param {string} riskCategory - Risk category
   * @param {number} timeToCollision - Time to collision in seconds
   * @returns {Promise<Object|null>} Created risk or null
   * @private
   */
  async createCollisionRisk(vehicleId, otherVehicleId, conflict, riskLevel, riskCategory, timeToCollision) {
    try {
      const now = new Date();
      const riskId = `collision-${vehicleId}-${otherVehicleId}-${now.getTime()}`;
      
      // Get vehicle position
      let vehiclePosition = null;
      let otherVehiclePosition = null;
      
      if (conflict.vehicle1.vehicleId === vehicleId) {
        vehiclePosition = conflict.vehicle1.position;
        otherVehiclePosition = conflict.vehicle2.position;
      } else {
        vehiclePosition = conflict.vehicle2.position;
        otherVehiclePosition = conflict.vehicle1.position;
      }
      
      // Create risk object
      const risk = {
        riskId,
        vehicleId,
        otherVehicleId,
        riskType: 'vehicle-collision',
        riskLevel,
        riskCategory,
        timeToCollision,
        timestamp: now,
        expiresAt: new Date(now.getTime() + timeToCollision * 1000),
        location: {
          type: 'Point',
          coordinates: [vehiclePosition.lng, vehiclePosition.lat]
        },
        predictedCollisionLocation: {
          type: 'Point',
          coordinates: [
            (vehiclePosition.lng + otherVehiclePosition.lng) / 2,
            (vehiclePosition.lat + otherVehiclePosition.lat) / 2
          ]
        },
        horizontalDistance: conflict.horizontalDistance,
        verticalDistance: conflict.verticalDistance,
        requiredHorizontalSeparation: conflict.requiredHorizontalSeparation,
        requiredVerticalSeparation: conflict.requiredVerticalSeparation,
        conflict: {
          conflictId: conflict.conflictId,
          predictedTime: conflict.predictedTime
        },
        hasAvoidanceManeuver: false,
        mitigationStatus: 'pending'
      };
      
      // Store in active risks
      this.activeCollisionRisks.set(riskId, risk);
      
      // Store in database
      if (this.collisionRisksCollection) {
        await this.collisionRisksCollection.insertOne(risk);
      }
      
      // Emit risk event
      this.emit('collision-risk:created', risk);
      
      return risk;
    } catch (error) {
      console.error('Error creating collision risk:', error);
      return null;
    }
  }
  
  /**
   * Assess bird strike risks
   * @async
   * @private
   */
  async assessBirdStrikeRisks() {
    try {
      // Get active vehicles and trajectories from predictor
      const vehicles = this.predictor.vehicles || new Map();
      const trajectories = this.predictor.trajectories || new Map();
      
      // Skip if no vehicles or trajectories
      if (vehicles.size === 0 || trajectories.size === 0) return;
      
      // Get current date and time for seasonal and daily patterns
      const now = new Date();
      const currentMonth = now.getMonth() + 1; // 1-12
      const currentDay = now.getDate(); // 1-31
      const currentHour = now.getHours(); // 0-23
      const currentMinute = now.getMinutes(); // 0-59
      
      // Check if in migration season
      const inMigrationSeason = this.isInMigrationSeason(currentMonth, currentDay);
      
      // Get current activity level based on time of day
      const currentActivityLevel = this.getCurrentBirdActivityLevel(currentHour, currentMinute);
      
      // Get weather conditions if available
      let weatherConditions = null;
      if (this.weatherRiskAssessor) {
        // Use downtown location as a default
        weatherConditions = this.weatherRiskAssessor.getCurrentWeather('downtown');
      }
      
      // Process each vehicle
      for (const [vehicleId, vehicle] of vehicles.entries()) {
        // Skip if no position
        if (!vehicle.state || !vehicle.state.position) continue;
        
        // Get trajectory
        const trajectory = trajectories.get(vehicleId);
        if (!trajectory) continue;
        
        // Get current position
        const position = vehicle.state.position;
        
        // Check if in avian activity zone
        const activeZones = this.findAvianActivityZones(position);
        
        // Skip if no active zones and not in migration season
        if (activeZones.length === 0 && !inMigrationSeason) continue;
        
        // Calculate base risk level
        let baseRiskLevel = 0;
        
        // Factor 1: Seasonal migration
        if (inMigrationSeason) {
          baseRiskLevel += 0.3;
        }
        
        // Factor 2: Daily activity pattern
        switch (currentActivityLevel) {
          case 'high':
            baseRiskLevel += 0.3;
            break;
          case 'medium':
            baseRiskLevel += 0.2;
            break;
          case 'low':
            baseRiskLevel += 0.1;
            break;
        }
        
        // Factor 3: Avian activity zones
        if (activeZones.length > 0) {
          // Find highest activity level
          const highestActivityZone = activeZones.reduce((highest, zone) => {
            const activityLevels = { 'high': 0.4, 'medium': 0.2, 'low': 0.1 };
            const zoneLevel = activityLevels[zone.activityLevel] || 0;
            const highestLevel = activityLevels[highest.activityLevel] || 0;
            
            return zoneLevel > highestLevel ? zone : highest;
          }, { activityLevel: 'none' });
          
          // Add to base risk
          switch (highestActivityZone.activityLevel) {
            case 'high':
              baseRiskLevel += 0.4;
              break;
            case 'medium':
              baseRiskLevel += 0.2;
              break;
            case 'low':
              baseRiskLevel += 0.1;
              break;
          }
        }
        
        // Factor 4: Flight altitude
        const altitude = position.altitude || 0;
        if (altitude < 500) {
          // Higher risk at lower altitudes (< 500m)
          baseRiskLevel += 0.3 * (1 - (altitude / 500));
        }
        
        // Factor 5: Weather conditions
        if (weatherConditions) {
          // Poor visibility increases risk
          if (weatherConditions.visibility < 5000) {
            baseRiskLevel += 0.2 * (1 - (weatherConditions.visibility / 5000));
          }
          
          // Strong winds affect bird flight patterns
          if (weatherConditions.windSpeed > 15) { // knots
            baseRiskLevel += 0.1;
          }
          
          // Migration more likely in certain temperature ranges
          const temp = weatherConditions.temperature;
          if (temp > 10 && temp < 25) {
            baseRiskLevel += 0.1;
          }
        }
        
        // Cap risk level at 1.0
        baseRiskLevel = Math.min(baseRiskLevel, 1.0);
        
        // Determine risk category
        let riskCategory = 'low';
        if (baseRiskLevel >= 0.7) {
          riskCategory = 'critical';
        } else if (baseRiskLevel >= 0.4) {
          riskCategory = 'warning';
        } else if (baseRiskLevel >= 0.2) {
          riskCategory = 'caution';
        }
        
        // Create bird strike risk if significant
        if (baseRiskLevel >= 0.2) {
          await this.createBirdStrikeRisk(
            vehicleId,
            vehicle,
            activeZones,
            baseRiskLevel,
            riskCategory,
            weatherConditions
          );
        }
      }
    } catch (error) {
      console.error('Error assessing bird strike risks:', error);
    }
  }
  
  /**
   * Create a bird strike risk record
   * @param {string} vehicleId - Vehicle ID
   * @param {Object} vehicle - Vehicle data
   * @param {Array} activeZones - Active avian zones
   * @param {number} riskLevel - Risk level (0-1)
   * @param {string} riskCategory - Risk category
   * @param {Object} weatherConditions - Weather conditions
   * @returns {Promise<Object|null>} Created risk or null
   * @private
   */
  async createBirdStrikeRisk(vehicleId, vehicle, activeZones, riskLevel, riskCategory, weatherConditions) {
    try {
      const now = new Date();
      const riskId = `bird-strike-${vehicleId}-${now.getTime()}`;
      
      // Get position
      const position = vehicle.state.position;
      
      // Extract bird species information from zones
      const relevantSpecies = new Set();
      for (const zone of activeZones) {
        if (zone.primarySpecies) {
          zone.primarySpecies.forEach(species => relevantSpecies.add(species));
        }
      }
      
      // Get species data
      const speciesData = Array.from(relevantSpecies)
        .map(species => this.birdSpeciesData.get(species))
        .filter(data => data !== undefined);
      
      // Create risk object
      const risk = {
        riskId,
        vehicleId,
        riskType: 'bird-strike',
        riskLevel,
        riskCategory,
        timestamp: now,
        expiresAt: new Date(now.getTime() + 600000), // 10 minutes
        location: {
          type: 'Point',
          coordinates: [position.lng, position.lat]
        },
        altitude: position.altitude,
        zones: activeZones.map(zone => ({
          zoneId: zone.zoneId,
          name: zone.name,
          activityLevel: zone.activityLevel
        })),
        species: speciesData.map(species => ({
          name: species.name,
          typicalWeight: species.typicalWeight,
          typicalWingspan: species.typicalWingspan,
          flockBehavior: species.flockBehavior,
          collisionRisk: species.collisionRisk
        })),
        weather: weatherConditions ? {
          temperature: weatherConditions.temperature,
          windSpeed: weatherConditions.windSpeed,
          windDirection: weatherConditions.windDirection,
          visibility: weatherConditions.visibility
        } : null,
        confirmed: false,
        hasAvoidanceManeuver: false,
        mitigationStatus: 'pending'
      };
      
      // Store in active risks
      this.activeBirdStrikeRisks.set(riskId, risk);
      
      // Store in database
      if (this.birdStrikeRisksCollection) {
        await this.birdStrikeRisksCollection.insertOne(risk);
      }
      
      // Emit risk event
      this.emit('bird-strike-risk:created', risk);
      
      return risk;
    } catch (error) {
      console.error('Error creating bird strike risk:', error);
      return null;
    }
  }
  
  /**
   * Generate avoidance maneuvers for active risks
   * @async
   * @private
   */
  async generateAvoidanceManeuvers() {
    try {
      // Process vehicle collision risks
      for (const [riskId, risk] of this.activeCollisionRisks.entries()) {
        // Skip if already has avoidance maneuver
        if (risk.hasAvoidanceManeuver) continue;
        
        // Skip if not high enough risk
        if (risk.riskLevel < 0.4) continue;
        
        // Generate avoidance maneuver
        const maneuver = await this.generateCollisionAvoidanceManeuver(risk);
        
        if (maneuver) {
          // Update risk
          risk.hasAvoidanceManeuver = true;
          risk.mitigationStatus = 'mitigated';
          
          // Update in database
          if (this.collisionRisksCollection) {
            await this.collisionRisksCollection.updateOne(
              { riskId: risk.riskId },
              { $set: {
                  hasAvoidanceManeuver: true,
                  mitigationStatus: 'mitigated'
                }
              }
            );
          }
        }
      }
      
      // Process bird strike risks
      for (const [riskId, risk] of this.activeBirdStrikeRisks.entries()) {
        // Skip if already has avoidance maneuver
        if (risk.hasAvoidanceManeuver) continue;
        
        // Skip if not high enough risk
        if (risk.riskLevel < 0.4) continue;
        
        // Generate avoidance maneuver
        const maneuver = await this.generateBirdStrikeAvoidanceManeuver(risk);
        
        if (maneuver) {
          // Update risk
          risk.hasAvoidanceManeuver = true;
          risk.mitigationStatus = 'mitigated';
          
          // Update in database
          if (this.birdStrikeRisksCollection) {
            await this.birdStrikeRisksCollection.updateOne(
              { riskId: risk.riskId },
              { $set: {
                  hasAvoidanceManeuver: true,
                  mitigationStatus: 'mitigated'
                }
              }
            );
          }
        }
      }
    } catch (error) {
      console.error('Error generating avoidance maneuvers:', error);
    }
  }
  
  /**
   * Generate collision avoidance maneuver
   * @param {Object} risk - Collision risk
   * @returns {Promise<Object|null>} Avoidance maneuver or null
   * @private
   */
  async generateCollisionAvoidanceManeuver(risk) {
    try {
      const now = new Date();
      const maneuverId = `avoidance-${risk.vehicleId}-${now.getTime()}`;
      
      // Get vehicles
      const vehicle = this.predictor.vehicles.get(risk.vehicleId);
      const otherVehicle = this.predictor.vehicles.get(risk.otherVehicleId);
      
      if (!vehicle || !otherVehicle) return null;
      
      // Get trajectories
      const trajectory = this.predictor.trajectories.get(risk.vehicleId);
      const otherTrajectory = this.predictor.trajectories.get(risk.otherVehicleId);
      
      if (!trajectory || !otherTrajectory) return null;
      
      // Get current positions and velocities
      const position = vehicle.state.position;
      const otherPosition = otherVehicle.state.position;
      
      // Determine who should give way
      // In a real implementation, this would use right-of-way rules
      // For simplicity, we'll use a simple rule:
      // 1. Emergency vehicles have right of way
      // 2. Otherwise, vehicle with lower ID gives way
      
      const shouldGiveWay = 
        (vehicle.priority !== 'emergency' && otherVehicle.priority === 'emergency') ||
        (vehicle.priority !== 'emergency' && vehicle.vehicleId > otherVehicle.vehicleId);
      
      if (!shouldGiveWay) {
        // This vehicle has right of way, no maneuver needed
        return null;
      }
      
      // Calculate maneuver based on risk severity
      let maneuverType = 'adjust-heading';
      let verticalChange = 0;
      let headingChange = 90; // Default 90 degree turn
      let speedChange = 0;
      
      if (risk.riskCategory === 'critical') {
        // Critical risk: Immediate evasive maneuver
        maneuverType = 'immediate-evasion';
        
        // Determine if vertical or horizontal evasion is better
        if (risk.horizontalDistance / risk.requiredHorizontalSeparation <
            risk.verticalDistance / risk.requiredVerticalSeparation) {
          // Vertical separation is better
          verticalChange = position.altitude > otherPosition.altitude ? 30 : -30;
          headingChange = 0;
        } else {
          // Horizontal separation is better
          headingChange = 90;
          verticalChange = 0;
        }
        
        // Slow down
        speedChange = -2; // m/s
      } else if (risk.riskCategory === 'warning') {
        // Warning risk: Adjust course
        maneuverType = 'course-adjustment';
        headingChange = 45;
        speedChange = -1; // m/s
      } else {
        // Caution risk: Minor adjustment
        maneuverType = 'minor-adjustment';
        headingChange = 30;
        speedChange = 0;
      }
      
      // Calculate new heading
      const currentHeading = vehicle.state.heading || 0;
      const bearingToOther = GeospatialUtils.bearing(position, otherPosition);
      
      // Turn away from other vehicle (perpendicular to bearing)
      const turnDirection = ((bearingToOther - currentHeading + 360) % 360) > 180 ? -1 : 1;
      const newHeading = (currentHeading + turnDirection * headingChange + 360) % 360;
      
      // Create maneuver
      const maneuver = {
        maneuverId,
        vehicleId: risk.vehicleId,
        riskId: risk.riskId,
        maneuverType,
        timestamp: now,
        expiryTime: new Date(now.getTime() + risk.timeToCollision * 1000 + 60000), // TTC + 1 minute
        parameters: {
          newHeading,
          headingChange: turnDirection * headingChange,
          verticalChange,
          speedChange,
          duration: Math.min(risk.timeToCollision * 2, 60) // Seconds, max 60 seconds
        },
        status: 'pending',
        priority: risk.riskCategory === 'critical' ? 'emergency' : 
                 risk.riskCategory === 'warning' ? 'high' : 'normal'
      };
      
      // Store in database
      if (this.avoidanceManeuversCollection) {
        await this.avoidanceManeuversCollection.insertOne(maneuver);
      }
      
      // Emit maneuver event
      this.emit('avoidance-maneuver:created', maneuver);
      
      return maneuver;
    } catch (error) {
      console.error('Error generating collision avoidance maneuver:', error);
      return null;
    }
  }
  
  /**
   * Generate bird strike avoidance maneuver
   * @param {Object} risk - Bird strike risk
   * @returns {Promise<Object|null>} Avoidance maneuver or null
   * @private
   */
  async generateBirdStrikeAvoidanceManeuver(risk) {
    try {
      const now = new Date();
      const maneuverId = `bird-avoidance-${risk.vehicleId}-${now.getTime()}`;
      
      // Get vehicle
      const vehicle = this.predictor.vehicles.get(risk.vehicleId);
      if (!vehicle) return null;
      
      // Get trajectory
      const trajectory = this.predictor.trajectories.get(risk.vehicleId);
      if (!trajectory) return null;
      
      // Get current position
      const position = vehicle.state.position;
      
      // Determine maneuver type based on risk level
      let maneuverType = 'altitude-adjustment';
      let verticalChange = 0;
      let headingChange = 0;
      let speedChange = 0;
      
      if (risk.riskCategory === 'critical') {
        // Critical risk: Change altitude and speed
        maneuverType = 'altitude-and-speed';
        verticalChange = 50; // 50m up (birds typically fly lower)
        speedChange = -2; // Slow down
      } else if (risk.riskCategory === 'warning') {
        // Warning risk: Change altitude
        maneuverType = 'altitude-adjustment';
        verticalChange = 30; // 30m up
      } else {
        // Caution risk: Minor adjustment
        maneuverType = 'minor-adjustment';
        verticalChange = 20; // 20m up
      }
      
      // Check if we should adjust altitude up or down based on species data
      if (risk.species && risk.species.length > 0) {
        // Get highest typical flight altitude of species
        const highestAltitude = Math.max(...risk.species
          .map(s => this.birdSpeciesData.get(s.name))
          .filter(s => s !== undefined)
          .map(s => s.flightAltitude.typical));
        
        // If we're below the typical flight altitude, go up
        // If we're above it, go up more (birds rarely fly very high)
        verticalChange = Math.abs(verticalChange);
      }
      
      // Create maneuver
      const maneuver = {
        maneuverId,
        vehicleId: risk.vehicleId,
        riskId: risk.riskId,
        maneuverType,
        timestamp: now,
        expiryTime: new Date(now.getTime() + 300000), // 5 minutes
        parameters: {
          verticalChange,
          headingChange,
          speedChange,
          duration: 120 // 2 minutes
        },
        status: 'pending',
        priority: risk.riskCategory === 'critical' ? 'high' : 
                 risk.riskCategory === 'warning' ? 'normal' : 'low'
      };
      
      // Store in database
      if (this.avoidanceManeuversCollection) {
        await this.avoidanceManeuversCollection.insertOne(maneuver);
      }
      
      // Emit maneuver event
      this.emit('avoidance-maneuver:created', maneuver);
      
      return maneuver;
    } catch (error) {
      console.error('Error generating bird strike avoidance maneuver:', error);
      return null;
    }
  }
  
  /**
   * Clean up expired risks
   * @async
   * @private
   */
  async cleanupExpiredRisks() {
    try {
      const now = new Date();
      
      // Clean up collision risks
      for (const [riskId, risk] of this.activeCollisionRisks.entries()) {
        if (risk.expiresAt && risk.expiresAt < now) {
          // Remove from active risks
          this.activeCollisionRisks.delete(riskId);
          
          // Update in database
          if (this.collisionRisksCollection) {
            await this.collisionRisksCollection.updateOne(
              { riskId },
              { $set: { status: 'expired' } }
            );
          }
        }
      }
      
      // Clean up bird strike risks
      for (const [riskId, risk] of this.activeBirdStrikeRisks.entries()) {
        if (risk.expiresAt && risk.expiresAt < now) {
          // Remove from active risks
          this.activeBirdStrikeRisks.delete(riskId);
          
          // Update in database
          if (this.birdStrikeRisksCollection) {
            await this.birdStrikeRisksCollection.updateOne(
              { riskId },
              { $set: { status: 'expired' } }
            );
          }
        }
      }
    } catch (error) {
      console.error('Error cleaning up expired risks:', error);
    }
  }
  
  /**
   * Check if current date is in migration season
   * @param {number} month - Current month (1-12)
   * @param {number} day - Current day (1-31)
   * @returns {boolean} Whether in migration season
   * @private
   */
  isInMigrationSeason(month, day) {
    const { migrationSeasons } = this.options.birdActivity;
    
    // Format current date as MM-DD
    const currentDate = `${month.toString().padStart(2, '0')}-${day.toString().padStart(2, '0')}`;
    
    // Check if in any migration season
    return migrationSeasons.some(season => {
      // Parse dates
      const [startMonth, startDay] = season.start.split('-').map(Number);
      const [endMonth, endDay] = season.end.split('-').map(Number);
      
      // Create date objects for easier comparison
      const start = new Date(2000, startMonth - 1, startDay);
      const end = new Date(2000, endMonth - 1, endDay);
      const current = new Date(2000, month - 1, day);
      
      // Handle seasons that span the new year
      if (endMonth < startMonth) {
        // Season spans new year (e.g., Nov-Mar)
        return current >= start || current <= end;
      } else {
        // Regular season (e.g., Mar-Jun)
        return current >= start && current <= end;
      }
    });
  }
  
  /**
   * Get current bird activity level based on time of day
   * @param {number} hour - Current hour (0-23)
   * @param {number} minute - Current minute (0-59)
   * @returns {string} Activity level ('high', 'medium', 'low')
   * @private
   */
  getCurrentBirdActivityLevel(hour, minute) {
    const { dailyPatterns } = this.options.birdActivity;
    
    // Format current time as HH:MM
    const currentTime = `${hour.toString().padStart(2, '0')}:${minute.toString().padStart(2, '0')}`;
    
    // Find matching pattern
    for (const pattern of dailyPatterns) {
      // Parse times
      const [startHour, startMinute] = pattern.start.split(':').map(Number);
      const [endHour, endMinute] = pattern.end.split(':').map(Number);
      
      // Create date objects for easier comparison
      const start = new Date(2000, 0, 1, startHour, startMinute);
      const end = new Date(2000, 0, 1, endHour, endMinute);
      const current = new Date(2000, 0, 1, hour, minute);
      
      // Handle patterns that span midnight
      if (endHour < startHour || (endHour === startHour && endMinute < startMinute)) {
        // Pattern spans midnight (e.g., 22:00-05:00)
        if (current >= start || current <= end) {
          return pattern.activityLevel;
        }
      } else {
        // Regular pattern (e.g., 05:00-10:00)
        if (current >= start && current <= end) {
          return pattern.activityLevel;
        }
      }
    }
    
    // Default if no pattern matches
    return 'low';
  }
  
  /**
   * Find avian activity zones at a given position
   * @param {Object} position - Position to check
   * @returns {Array} Matching avian activity zones
   * @private
   */
  findAvianActivityZones(position) {
    const matchingZones = [];
    
    for (const zone of this.avianActivityZones.values()) {
      // Skip if no area defined
      if (!zone.area) continue;
      
      // Check if position is in zone
      const point = turf.point([position.lng, position.lat]);
      let isInZone = false;
      
      if (zone.area.type === 'Polygon') {
        const polygon = turf.polygon(zone.area.coordinates);
        isInZone = turf.booleanPointInPolygon(point, polygon);
      } else if (zone.area.type === 'MultiPolygon') {
        const multiPolygon = turf.multiPolygon(zone.area.coordinates);
        isInZone = turf.booleanPointInPolygon(point, multiPolygon);
      } else if (zone.area.type === 'Circle') {
        // For circles, calculate distance and compare to radius
        const center = turf.point([zone.area.center.lng, zone.area.center.lat]);
        const distance = turf.distance(point, center, { units: 'meters' });
        isInZone = distance <= zone.area.radius;
      }
      
      if (isInZone) {
        matchingZones.push(zone);
      }
    }
    
    return matchingZones;
  }
  
  /**
   * Get all active collision risks
   * @returns {Array} Active collision risks
   */
  getActiveCollisionRisks() {
    return Array.from(this.activeCollisionRisks.values());
  }
  
  /**
   * Get all active bird strike risks
   * @returns {Array} Active bird strike risks
   */
  getActiveBirdStrikeRisks() {
    return Array.from(this.activeBirdStrikeRisks.values());
  }
  
  /**
   * Get collision risks for a specific vehicle
   * @param {string} vehicleId - Vehicle ID
   * @returns {Array} Collision risks for the vehicle
   */
  getVehicleCollisionRisks(vehicleId) {
    return Array.from(this.activeCollisionRisks.values())
      .filter(risk => risk.vehicleId === vehicleId);
  }
  
  /**
   * Get bird strike risks for a specific vehicle
   * @param {string} vehicleId - Vehicle ID
   * @returns {Array} Bird strike risks for the vehicle
   */
  getVehicleBirdStrikeRisks(vehicleId) {
    return Array.from(this.activeBirdStrikeRisks.values())
      .filter(risk => risk.vehicleId === vehicleId);
  }
  
  /**
   * Get avoidance maneuvers for a specific vehicle
   * @param {string} vehicleId - Vehicle ID
   * @returns {Promise<Array>} Avoidance maneuvers for the vehicle
   */
  async getVehicleAvoidanceManeuvers(vehicleId) {
    if (!this.avoidanceManeuversCollection) return [];
    
    try {
      const maneuvers = await this.avoidanceManeuversCollection.find({
        vehicleId,
        status: { $in: ['pending', 'in-progress'] }
      }).toArray();
      
      return maneuvers;
    } catch (error) {
      console.error(`Error getting avoidance maneuvers for vehicle ${vehicleId}:`, error);
      return [];
    }
  }
  
  /**
   * Get avian activity zones
   * @returns {Array} Avian activity zones
   */
  getAvianActivityZones() {
    return Array.from(this.avianActivityZones.values());
  }
  
  /**
   * Report a bird strike
   * @param {Object} params - Report parameters
   * @param {string} params.vehicleId - Vehicle ID
   * @param {Object} params.location - Strike location
   * @param {string} params.species - Bird species if known
   * @param {string} params.severity - Strike severity
   * @param {string} params.description - Strike description
   * @returns {Promise<Object>} Report result
   */
  async reportBirdStrike(params) {
    try {
      const { vehicleId, location, species, severity, description } = params;
      
      // Create bird strike report
      const reportId = `bird-strike-report-${vehicleId}-${Date.now()}`;
      const now = new Date();
      
      // Get vehicle if available
      const vehicle = this.predictor?.vehicles?.get(vehicleId);
      
      const report = {
        reportId,
        vehicleId,
        timestamp: now,
        location: location || (vehicle?.state?.position ? {
          type: 'Point',
          coordinates: [vehicle.state.position.lng, vehicle.state.position.lat]
        } : null),
        altitude: vehicle?.state?.position?.altitude,
        species: species || 'unknown',
        severity: severity || 'unknown',
        description: description || '',
        confirmed: true,
        damage: params.damage || 'unknown',
        impactZone: params.impactZone || 'unknown'
      };
      
      // Store in database
      if (this.birdStrikeRisksCollection) {
        await this.birdStrikeRisksCollection.insertOne(report);
      }
      
      // Add to historical strikes
      this.historicalBirdStrikes.set(reportId, report);
      
      // Emit event
      this.emit('bird-strike:reported', report);
      
      return {
        success: true,
        reportId,
        message: 'Bird strike report submitted successfully'
      };
    } catch (error) {
      console.error('Error reporting bird strike:', error);
      return {
        success: false,
        error: error.message
      };
    }
  }
  
  /**
   * Update an avoidance maneuver status
   * @param {string} maneuverId - Maneuver ID
   * @param {string} status - New status
   * @returns {Promise<Object>} Update result
   */
  async updateManeuverStatus(maneuverId, status) {
    if (!this.avoidanceManeuversCollection) {
      return {
        success: false,
        error: 'Database not available'
      };
    }
    
    try {
      // Update in database
      const result = await this.avoidanceManeuversCollection.updateOne(
        { maneuverId },
        { $set: {
            status,
            updatedAt: new Date()
          }
        }
      );
      
      if (result.modifiedCount === 0) {
        return {
          success: false,
          error: 'Maneuver not found'
        };
      }
      
      // Emit event
      this.emit('avoidance-maneuver:updated', {
        maneuverId,
        status
      });
      
      return {
        success: true,
        maneuverId,
        status
      };
    } catch (error) {
      console.error(`Error updating maneuver status for ${maneuverId}:`, error);
      return {
        success: false,
        error: error.message
      };
    }
  }
  
  /**
   * Shutdown the collision risk predictor
   * @returns {Promise<boolean>} Success indicator
   */
  async shutdown() {
    try {
      console.log('Shutting down IAMS Collision Risk Predictor');
      
      // Stop update cycle
      this.stopUpdateCycle();
      
      // Clear data structures
      this.activeCollisionRisks.clear();
      this.activeBirdStrikeRisks.clear();
      
      console.log('IAMS Collision Risk Predictor shutdown completed');
      return true;
    } catch (error) {
      console.error('Error shutting down IAMS Collision Risk Predictor:', error);
      return false;
    }
  }
}

module.exports = { IAMSCollisionRiskPredictor };
```


```javascript
// Path: /IAMSIntegrationAPI.js
// Written by Greg Deeds, Autonomy Association International, Inc.
// Copyright 2025 Autonomy Association International Inc., all rights reserved 
// Safeguard patent license from National Aeronautics and Space Administration (NASA)
// Copyright 2025 NASA, all rights reserved

/**
 * @fileoverview Integration API for IASMS with external systems
 * @module safeguard/iams-integration-api
 */

const express = require('express');
const cors = require('cors');
const jwt = require('jsonwebtoken');
const { EventEmitter } = require('events');
const axios = require('axios');
const WebSocket = require('ws');

/**
 * Class for integration with external systems like USS and SDSPs
 */
class IAMSIntegrationAPI extends EventEmitter {
  /**
   * Create a new IAMSIntegrationAPI instance
   * @param {Object} options - Configuration options
   * @param {Object} options.db - MongoDB database connection
   * @param {Object} options.predictor - IAMS Predictor reference
   * @param {Object} options.vertiportManager - Vertiport manager reference
   * @param {Object} options.timeBasedFlowManager - Time-based flow manager reference
   * @param {Object} options.weatherRiskAssessor - Weather risk assessor reference
   * @param {number} options.port - API port
   * @param {string} options.jwtSecret - JWT secret for authentication
   * @param {Object} options.externalSystems - External systems configuration
   */
  constructor(options = {}) {
    super();
    
    this.options = {
      port: options.port || process.env.IAMS_API_PORT || 3002,
      jwtSecret: options.jwtSecret || process.env.IAMS_JWT_SECRET || 'iasms-secret-key',
      apiBasePath: options.apiBasePath || '/api/v1',
      websocketPath: options.websocketPath || '/ws',
      rateLimits: options.rateLimits || {
        standardRequests: 100, // per minute
        dataRequests: 300,     // per minute
        emergencyRequests: 500 // per minute
      },
      externalSystems: options.externalSystems || {
        uss: [],
        sdsp: [],
        atm: []
      },
      ...options
    };
    
    this.db = options.db;
    this.predictor = options.predictor;
    this.vertiportManager = options.vertiportManager;
    this.timeBasedFlowManager = options.timeBasedFlowManager;
    this.weatherRiskAssessor = options.weatherRiskAssessor;
    
    // Express app
    this.app = null;
    this.server = null;
    this.wsServer = null;
    
    // Client connections
    this.clients = new Map(); // WebSocket clients
    this.tokenCache = new Map(); // JWT token cache
    
    // External system connections
    this.externalConnections = new Map();
    
    // Data subscriptions
    this.subscriptions = new Map();
    
    // API request metrics
    this.apiMetrics = {
      totalRequests: 0,
      requestsByEndpoint: new Map(),
      requestsByClient: new Map(),
      rateLimitViolations: 0,
      lastResetTime: Date.now()
    };
  }

  /**
   * Initialize the integration API
   * @async
   * @returns {Promise<void>}
   */
  async initialize() {
    try {
      console.log('Initializing IAMS Integration API');
      
      // Create Express app
      this.app = express();
      this.configureMiddleware();
      this.setupRoutes();
      
      // Create HTTP server
      this.server = this.app.listen(this.options.port, () => {
        console.log(`IAMS Integration API listening on port ${this.options.port}`);
      });
      
      // Set up WebSocket server
      this.setupWebSocketServer();
      
      // Connect to external systems
      await this.connectToExternalSystems();
      
      console.log('IAMS Integration API initialized');
    } catch (error) {
      console.error('Failed to initialize IAMS Integration API:', error);
      throw error;
    }
  }
  
  /**
   * Configure Express middleware
   * @private
   */
  configureMiddleware() {
    // Parse JSON bodies
    this.app.use(express.json());
    
    // Enable CORS
    this.app.use(cors());
    
    // Request logging
    this.app.use((req, res, next) => {
      const start = Date.now();
      
      // Log request
      const requestId = `req-${Date.now()}-${Math.random().toString(36).substr(2, 9)}`;
      console.log(`[${new Date().toISOString()}] ${req.method} ${req.path} (${requestId})`);
      
      // Update metrics
      this.apiMetrics.totalRequests++;
      
      const endpoint = `${req.method} ${req.path}`;
      this.apiMetrics.requestsByEndpoint.set(
        endpoint,
        (this.apiMetrics.requestsByEndpoint.get(endpoint) || 0) + 1
      );
      
      // Client ID from token
      const clientId = this.getClientIdFromToken(req.headers.authorization);
      if (clientId) {
        this.apiMetrics.requestsByClient.set(
          clientId,
          (this.apiMetrics.requestsByClient.get(clientId) || 0) + 1
        );
      }
      
      // Log response
      res.on('finish', () => {
        const duration = Date.now() - start;
        console.log(`[${new Date().toISOString()}] ${req.method} ${req.path} (${requestId}) - ${res.statusCode} (${duration}ms)`);
      });
      
      next();
    });
    
    // Rate limiting
    this.app.use(this.rateLimit.bind(this));
    
    // Authentication for protected routes
    this.app.use(`${this.options.apiBasePath}/protected`, this.authenticateJWT.bind(this));
  }
  
  /**
   * Rate limiting middleware
   * @param {Object} req - Express request
   * @param {Object} res - Express response
   * @param {Function} next - Next middleware
   * @private
   */
  rateLimit(req, res, next) {
    // Get client ID from token
    const clientId = this.getClientIdFromToken(req.headers.authorization);
    
    if (!clientId) {
      // Allow unauthenticated requests for public routes
      if (req.path.startsWith(`${this.options.apiBasePath}/public`)) {
        return next();
      }
      
      // Require authentication for other routes
      return res.status(401).json({
        success: false,
        error: 'Authentication required'
      });
    }
    
    // Get client rate limits
    const clientLimits = this.getClientRateLimits(clientId);
    
    // Check if client has exceeded rate limits
    const clientRequests = this.apiMetrics.requestsByClient.get(clientId) || 0;
    
    if (clientRequests > clientLimits) {
      this.apiMetrics.rateLimitViolations++;
      
      return res.status(429).json({
        success: false,
        error: 'Rate limit exceeded',
        limit: clientLimits,
        reset: Math.ceil((this.apiMetrics.lastResetTime + 60000 - Date.now()) / 1000)
      });
    }
    
    next();
  }
  
  /**
   * Get client rate limits
   * @param {string} clientId - Client ID
   * @returns {number} Rate limit
   * @private
   */
  getClientRateLimits(clientId) {
    // Check if client has special rate limits
    if (clientId.startsWith('emergency-')) {
      return this.options.rateLimits.emergencyRequests;
    } else if (clientId.startsWith('data-')) {
      return this.options.rateLimits.dataRequests;
    } else {
      return this.options.rateLimits.standardRequests;
    }
  }
  
  /**
   * Get client ID from JWT token
   * @param {string} authHeader - Authorization header
   * @returns {string|null} Client ID or null
   * @private
   */
  getClientIdFromToken(authHeader) {
    if (!authHeader) return null;
    
    // Extract token
    const parts = authHeader.split(' ');
    if (parts.length !== 2 || parts[0] !== 'Bearer') return null;
    
    const token = parts[1];
    
    // Check cache
    if (this.tokenCache.has(token)) {
      const cached = this.tokenCache.get(token);
      
      // Check if token is expired
      if (cached.exp > Date.now() / 1000) {
        return cached.clientId;
      } else {
        this.tokenCache.delete(token);
      }
    }
    
    try {
      // Verify token
      const decoded = jwt.verify(token, this.options.jwtSecret);
      
      // Cache token
      this.tokenCache.set(token, {
        clientId: decoded.clientId,
        exp: decoded.exp
      });
      
      return decoded.clientId;
    } catch (error) {
      return null;
    }
  }
  
  /**
   * JWT authentication middleware
   * @param {Object} req - Express request
   * @param {Object} res - Express response
   * @param {Function} next - Next middleware
   * @private
   */
  authenticateJWT(req, res, next) {
    const authHeader = req.headers.authorization;
    
    if (!authHeader) {
      return res.status(401).json({
        success: false,
        error: 'Authentication required'
      });
    }
    
    // Extract token
    const parts = authHeader.split(' ');
    if (parts.length !== 2 || parts[0] !== 'Bearer') {
      return res.status(401).json({
        success: false,
        error: 'Invalid authentication format'
      });
    }
    
    const token = parts[1];
    
    try {
      // Verify token
      const decoded = jwt.verify(token, this.options.jwtSecret);
      
      // Add user info to request
      req.user = decoded;
      
      next();
    } catch (error) {
      return res.status(401).json({
        success: false,
        error: 'Invalid token'
      });
    }
  }
  
  /**
   * Set up API routes
   * @private
   */
  setupRoutes() {
    const router = express.Router();
    
    // Public routes
    router.get('/public/health', (req, res) => {
      res.json({
        success: true,
        status: 'ok',
        timestamp: new Date().toISOString()
      });
    });
    
    router.post('/public/auth/login', (req, res) => {
      const { clientId, clientSecret } = req.body;
      
      // Authenticate client (in a real implementation, this would verify against a database)
      if (!clientId || !clientSecret) {
        return res.status(400).json({
          success: false,
          error: 'Missing clientId or clientSecret'
        });
      }
      
      // Generate token
      const token = jwt.sign(
        {
          clientId,
          role: clientId.startsWith('emergency-') ? 'emergency' : 'standard'
        },
        this.options.jwtSecret,
        {
          expiresIn: '1h'
        }
      );
      
      res.json({
        success: true,
        token,
        expiresIn: 3600 // 1 hour
      });
    });
    
    // Protected routes
    
    // System status
    router.get('/protected/status', (req, res) => {
      const status = {
        success: true,
        system: {
          status: 'operational',
          components: {
            predictor: this.predictor ? 'online' : 'offline',
            vertiportManager: this.vertiportManager ? 'online' : 'offline',
            timeBasedFlowManager: this.timeBasedFlowManager ? 'online' : 'offline',
            weatherRiskAssessor: this.weatherRiskAssessor ? 'online' : 'offline'
          }
        },
        externalSystems: {
          uss: this.getExternalSystemStatus('uss'),
          sdsp: this.getExternalSystemStatus('sdsp'),
          atm: this.getExternalSystemStatus('atm')
        },
        metrics: {
          activeVehicles: this.predictor?.vehicles?.size || 0,
          activeFlowConstraints: this.timeBasedFlowManager?.metrics?.activeFlowConstraints || 0,
          apiRequests: this.apiMetrics.totalRequests
        },
        timestamp: new Date().toISOString()
      };
      
      res.json(status);
    });
    
    // Vehicle data
    router.get('/protected/vehicles', (req, res) => {
      if (!this.predictor) {
        return res.status(503).json({
          success: false,
          error: 'Predictor service unavailable'
        });
      }
      
      const vehicles = Array.from(this.predictor.vehicles.values()).map(vehicle => ({
        vehicleId: vehicle.vehicleId,
        vehicleType: vehicle.vehicleType,
        callSign: vehicle.callSign,
        status: vehicle.status,
        position: vehicle.state?.position,
        altitude: vehicle.state?.altitude,
        heading: vehicle.state?.heading,
        speed: vehicle.state?.speed,
        lastUpdated: vehicle.updatedAt
      }));
      
      res.json({
        success: true,
        count: vehicles.length,
        vehicles
      });
    });
    
    router.get('/protected/vehicles/:vehicleId', (req, res) => {
      if (!this.predictor) {
        return res.status(503).json({
          success: false,
          error: 'Predictor service unavailable'
        });
      }
      
      const { vehicleId } = req.params;
      const vehicle = this.predictor.vehicles.get(vehicleId);
      
      if (!vehicle) {
        return res.status(404).json({
          success: false,
          error: 'Vehicle not found'
        });
      }
      
      res.json({
        success: true,
        vehicle: {
          vehicleId: vehicle.vehicleId,
          vehicleType: vehicle.vehicleType,
          callSign: vehicle.callSign,
          status: vehicle.status,
          position: vehicle.state?.position,
          altitude: vehicle.state?.altitude,
          heading: vehicle.state?.heading,
          speed: vehicle.state?.speed,
          batteryRemaining: vehicle.state?.batteryRemaining,
          estimatedFlightTimeRemaining: vehicle.state?.estimatedFlightTimeRemaining,
          lastUpdated: vehicle.updatedAt
        }
      });
    });
    
    router.get('/protected/vehicles/:vehicleId/trajectory', (req, res) => {
      if (!this.predictor) {
        return res.status(503).json({
          success: false,
          error: 'Predictor service unavailable'
        });
      }
      
      const { vehicleId } = req.params;
      const trajectory = this.predictor.getVehicleTrajectory(vehicleId);
      
      if (!trajectory) {
        return res.status(404).json({
          success: false,
          error: 'Trajectory not found'
        });
      }
      
      res.json({
        success: true,
        trajectory
      });
    });
    
    // Conflicts and risks
    router.get('/protected/conflicts', (req, res) => {
      if (!this.predictor) {
        return res.status(503).json({
          success: false,
          error: 'Predictor service unavailable'
        });
      }
      
      const conflicts = Array.from(this.predictor.predictedConflicts.values()).map(conflict => ({
        conflictId: conflict.conflictId,
        vehicle1Id: conflict.vehicle1?.vehicleId,
        vehicle2Id: conflict.vehicle2?.vehicleId,
        severity: conflict.severity,
        timeOffset: conflict.timeOffset,
        predictedTime: conflict.predictedTime,
        horizontalDistance: conflict.horizontalDistance,
        verticalDistance: conflict.verticalDistance
      }));
      
      res.json({
        success: true,
        count: conflicts.length,
        conflicts
      });
    });
    
    // Vertiport data
    router.get('/protected/vertiports', (req, res) => {
      if (!this.vertiportManager) {
        return res.status(503).json({
          success: false,
          error: 'Vertiport manager service unavailable'
        });
      }
      
      const vertiports = Array.from(this.vertiportManager.vertiports.values()).map(vertiport => ({
        vertiportId: vertiport.vertiportId,
        name: vertiport.name,
        status: vertiport.status,
        location: vertiport.location
      }));
      
      res.json({
        success: true,
        count: vertiports.length,
        vertiports
      });
    });
    
    router.get('/protected/vertiports/:vertiportId/schedule', async (req, res) => {
      if (!this.vertiportManager) {
        return res.status(503).json({
          success: false,
          error: 'Vertiport manager service unavailable'
        });
      }
      
      const { vertiportId } = req.params;
      const { startTime, endTime } = req.query;
      
      try {
        const schedule = await this.vertiportManager.getVertiportSchedule(
          vertiportId,
          startTime ? new Date(startTime) : undefined,
          endTime ? new Date(endTime) : undefined
        );
        
        if (!schedule.success) {
          return res.status(404).json({
            success: false,
            error: schedule.error || 'Failed to get vertiport schedule'
          });
        }
        
        res.json({
          success: true,
          schedule
        });
      } catch (error) {
        res.status(500).json({
          success: false,
          error: error.message
        });
      }
    });
    
    // Flow management
    router.get('/protected/flow-constraints', (req, res) => {
      if (!this.timeBasedFlowManager) {
        return res.status(503).json({
          success: false,
          error: 'Time-based flow manager service unavailable'
        });
      }
      
      const constraints = this.timeBasedFlowManager.getFlowConstraints();
      
      res.json({
        success: true,
        count: constraints.length,
        constraints
      });
    });
    
    router.get('/protected/flow-metrics', (req, res) => {
      if (!this.timeBasedFlowManager) {
        return res.status(503).json({
          success: false,
          error: 'Time-based flow manager service unavailable'
        });
      }
      
      const metrics = this.timeBasedFlowManager.getMetrics();
      
      res.json({
        success: true,
        metrics
      });
    });
    
    // Weather data
    router.get('/protected/weather/:locationId', (req, res) => {
      if (!this.weatherRiskAssessor) {
        return res.status(503).json({
          success: false,
          error: 'Weather risk assessor service unavailable'
        });
      }
      
      const { locationId } = req.params;
      const weather = this.weatherRiskAssessor.getCurrentWeather(locationId);
      
      if (!weather) {
        return res.status(404).json({
          success: false,
          error: 'Weather data not found for location'
        });
      }
      
      res.json({
        success: true,
        weather
      });
    });
    
    router.get('/protected/weather-alerts', async (req, res) => {
      if (!this.weatherRiskAssessor) {
        return res.status(503).json({
          success: false,
          error: 'Weather risk assessor service unavailable'
        });
      }
      
      try {
        const alerts = await this.weatherRiskAssessor.getSevereWeatherAlerts();
        
        res.json({
          success: true,
          count: alerts.length,
          alerts
        });
      } catch (error) {
        res.status(500).json({
          success: false,
          error: error.message
        });
      }
    });
    
    // Data subscriptions
    router.post('/protected/subscriptions', (req, res) => {
      const { clientId } = req.user;
      const { topic, format, updateFrequency } = req.body;
      
      if (!topic) {
        return res.status(400).json({
          success: false,
          error: 'Missing topic'
        });
      }
      
      // Check if topic is valid
      const validTopics = [
        'vehicles', 'trajectories', 'conflicts', 'vertiports', 
        'flow-constraints', 'weather', 'alerts'
      ];
      
      if (!validTopics.includes(topic)) {
        return res.status(400).json({
          success: false,
          error: `Invalid topic. Valid topics are: ${validTopics.join(', ')}`
        });
      }
      
      // Create subscription
      const subscriptionId = `sub-${clientId}-${topic}-${Date.now()}`;
      
      const subscription = {
        subscriptionId,
        clientId,
        topic,
        format: format || 'json',
        updateFrequency: updateFrequency || 1000, // 1 second
        createdAt: new Date(),
        lastUpdate: null,
        status: 'active'
      };
      
      // Store subscription
      this.subscriptions.set(subscriptionId, subscription);
      
      res.json({
        success: true,
        subscription
      });
    });
    
    router.delete('/protected/subscriptions/:subscriptionId', (req, res) => {
      const { clientId } = req.user;
      const { subscriptionId } = req.params;
      
      // Check if subscription exists
      if (!this.subscriptions.has(subscriptionId)) {
        return res.status(404).json({
          success: false,
          error: 'Subscription not found'
        });
      }
      
      // Check if subscription belongs to client
      const subscription = this.subscriptions.get(subscriptionId);
      if (subscription.clientId !== clientId) {
        return res.status(403).json({
          success: false,
          error: 'Unauthorized to delete this subscription'
        });
      }
      
      // Delete subscription
      this.subscriptions.delete(subscriptionId);
      
      res.json({
        success: true,
        message: 'Subscription deleted'
      });
    });
    
    // Mount router
    this.app.use(this.options.apiBasePath, router);
  }
  
  /**
   * Set up WebSocket server
   * @private
   */
  setupWebSocketServer() {
    this.wsServer = new WebSocket.Server({
      server: this.server,
      path: this.options.websocketPath
    });
    
    this.wsServer.on('connection', (ws, req) => {
      // Generate client ID
      const clientId = `ws-${Date.now()}-${Math.random().toString(36).substr(2, 9)}`;
      
      // Store client
      this.clients.set(clientId, {
        ws,
        subscriptions: new Set(),
        connectedAt: new Date(),
        lastActivity: new Date(),
        authenticated: false,
        userId: null
      });
      
      console.log(`WebSocket client connected: ${clientId}`);
      
      // Welcome message
      ws.send(JSON.stringify({
        type: 'welcome',
        clientId,
        timestamp: new Date().toISOString()
      }));
      
      // Handle messages
      ws.on('message', (message) => {
        try {
          const data = JSON.parse(message);
          this.handleWebSocketMessage(clientId, data);
        } catch (error) {
          console.error(`Error handling WebSocket message from ${clientId}:`, error);
          
          ws.send(JSON.stringify({
            type: 'error',
            error: 'Invalid message format',
            timestamp: new Date().toISOString()
          }));
        }
      });
      
      // Handle close
      ws.on('close', () => {
        console.log(`WebSocket client disconnected: ${clientId}`);
        
        // Remove client
        this.clients.delete(clientId);
      });
    });
    
    // Start subscription updates
    this.startSubscriptionUpdates();
  }
  
  /**
   * Handle WebSocket message
   * @param {string} clientId - Client ID
   * @param {Object} message - Message data
   * @private
   */
  handleWebSocketMessage(clientId, message) {
    const client = this.clients.get(clientId);
    if (!client) return;
    
    // Update last activity
    client.lastActivity = new Date();
    
    // Handle message
    switch (message.type) {
      case 'auth':
        this.handleAuthMessage(clientId, message);
        break;
        
      case 'subscribe':
        this.handleSubscribeMessage(clientId, message);
        break;
        
      case 'unsubscribe':
        this.handleUnsubscribeMessage(clientId, message);
        break;
        
      case 'ping':
        this.handlePingMessage(clientId, message);
        break;
        
      default:
        client.ws.send(JSON.stringify({
          type: 'error',
          error: `Unknown message type: ${message.type}`,
          timestamp: new Date().toISOString()
        }));
    }
  }
  
  /**
   * Handle authentication message
   * @param {string} clientId - Client ID
   * @param {Object} message - Message data
   * @private
   */
  handleAuthMessage(clientId, message) {
    const client = this.clients.get(clientId);
    if (!client) return;
    
    const { token } = message;
    
    if (!token) {
      client.ws.send(JSON.stringify({
        type: 'auth_error',
        error: 'Missing token',
        timestamp: new Date().toISOString()
      }));
      return;
    }
    
    try {
      // Verify token
      const decoded = jwt.verify(token, this.options.jwtSecret);
      
      // Update client
      client.authenticated = true;
      client.userId = decoded.clientId;
      
      client.ws.send(JSON.stringify({
        type: 'auth_success',
        userId: decoded.clientId,
        timestamp: new Date().toISOString()
      }));
    } catch (error) {
      client.ws.send(JSON.stringify({
        type: 'auth_error',
        error: 'Invalid token',
        timestamp: new Date().toISOString()
      }));
    }
  }
  
  /**
   * Handle subscribe message
   * @param {string} clientId - Client ID
   * @param {Object} message - Message data
   * @private
   */
  handleSubscribeMessage(clientId, message) {
    const client = this.clients.get(clientId);
    if (!client) return;
    
    // Check if authenticated
    if (!client.authenticated) {
      client.ws.send(JSON.stringify({
        type: 'error',
        error: 'Authentication required',
        timestamp: new Date().toISOString()
      }));
      return;
    }
    
    const { topic, filter } = message;
    
    if (!topic) {
      client.ws.send(JSON.stringify({
        type: 'error',
        error: 'Missing topic',
        timestamp: new Date().toISOString()
      }));
      return;
    }
    
    // Check if topic is valid
    const validTopics = [
      'vehicles', 'trajectories', 'conflicts', 'vertiports', 
      'flow-constraints', 'weather', 'alerts'
    ];
    
    if (!validTopics.includes(topic)) {
      client.ws.send(JSON.stringify({
        type: 'error',
        error: `Invalid topic. Valid topics are: ${validTopics.join(', ')}`,
        timestamp: new Date().toISOString()
      }));
      return;
    }
    
    // Create subscription
    const subscriptionId = `sub-${clientId}-${topic}-${Date.now()}`;
    
    const subscription = {
      subscriptionId,
      clientId,
      userId: client.userId,
      topic,
      filter: filter || {},
      createdAt: new Date(),
      lastUpdate: null
    };
    
    // Store subscription
    this.subscriptions.set(subscriptionId, subscription);
    
    // Add to client subscriptions
    client.subscriptions.add(subscriptionId);
    
    client.ws.send(JSON.stringify({
      type: 'subscribe_success',
      subscriptionId,
      topic,
      timestamp: new Date().toISOString()
    }));
  }
  
  /**
   * Handle unsubscribe message
   * @param {string} clientId - Client ID
   * @param {Object} message - Message data
   * @private
   */
  handleUnsubscribeMessage(clientId, message) {
    const client = this.clients.get(clientId);
    if (!client) return;
    
    const { subscriptionId } = message;
    
    if (!subscriptionId) {
      client.ws.send(JSON.stringify({
        type: 'error',
        error: 'Missing subscriptionId',
        timestamp: new Date().toISOString()
      }));
      return;
    }
    
    // Check if subscription exists
    if (!this.subscriptions.has(subscriptionId)) {
      client.ws.send(JSON.stringify({
        type: 'error',
        error: 'Subscription not found',
        timestamp: new Date().toISOString()
      }));
      return;
    }
    
    // Check if subscription belongs to client
    const subscription = this.subscriptions.get(subscriptionId);
    if (subscription.clientId !== clientId) {
      client.ws.send(JSON.stringify({
        type: 'error',
        error: 'Unauthorized to unsubscribe from this subscription',
        timestamp: new Date().toISOString()
      }));
      return;
    }
    
    // Delete subscription
    this.subscriptions.delete(subscriptionId);
    
    // Remove from client subscriptions
    client.subscriptions.delete(subscriptionId);
    
    client.ws.send(JSON.stringify({
      type: 'unsubscribe_success',
      subscriptionId,
      timestamp: new Date().toISOString()
    }));
  }
  
  /**
   * Handle ping message
   * @param {string} clientId - Client ID
   * @param {Object} message - Message data
   * @private
   */
  handlePingMessage(clientId, message) {
    const client = this.clients.get(clientId);
    if (!client) return;
    
    client.ws.send(JSON.stringify({
      type: 'pong',
      timestamp: new Date().toISOString()
    }));
  }
  
  /**
   * Start subscription updates
   * @private
   */
  startSubscriptionUpdates() {
    // Update vehicle subscriptions
    setInterval(() => {
      this.updateVehicleSubscriptions();
    }, 1000);
    
    // Update trajectory subscriptions
    setInterval(() => {
      this.updateTrajectorySubscriptions();
    }, 2000);
    
    // Update conflict subscriptions
    setInterval(() => {
      this.updateConflictSubscriptions();
    }, 2000);
    
    // Update vertiport subscriptions
    setInterval(() => {
      this.updateVertiportSubscriptions();
    }, 5000);
    
    // Update flow constraint subscriptions
    setInterval(() => {
      this.updateFlowConstraintSubscriptions();
    }, 5000);
    
    // Update weather subscriptions
    setInterval(() => {
      this.updateWeatherSubscriptions();
    }, 10000);
    
    // Update alert subscriptions
    setInterval(() => {
      this.updateAlertSubscriptions();
    }, 2000);
  }
  
  /**
   * Update vehicle subscriptions
   * @private
   */
  updateVehicleSubscriptions() {
    if (!this.predictor) return;
    
    // Get active subscriptions for vehicles
    const vehicleSubscriptions = Array.from(this.subscriptions.values())
      .filter(sub => sub.topic === 'vehicles');
    
    if (vehicleSubscriptions.length === 0) return;
    
    // Get all vehicles
    const vehicles = Array.from(this.predictor.vehicles.values()).map(vehicle => ({
      vehicleId: vehicle.vehicleId,
      vehicleType: vehicle.vehicleType,
      callSign: vehicle.callSign,
      status: vehicle.status,
      position: vehicle.state?.position,
      altitude: vehicle.state?.altitude,
      heading: vehicle.state?.heading,
      speed: vehicle.state?.speed,
      lastUpdated: vehicle.updatedAt
    }));
    
    // Send to each subscriber
    for (const subscription of vehicleSubscriptions) {
      const client = this.clients.get(subscription.clientId);
      if (!client || !client.ws) continue;
      
      // Apply filter if any
      let filteredVehicles = vehicles;
      if (subscription.filter) {
        if (subscription.filter.vehicleId) {
          filteredVehicles = filteredVehicles.filter(v => 
            v.vehicleId === subscription.filter.vehicleId
          );
        }
        
        if (subscription.filter.vehicleType) {
          filteredVehicles = filteredVehicles.filter(v => 
            v.vehicleType === subscription.filter.vehicleType
          );
        }
        
        if (subscription.filter.status) {
          filteredVehicles = filteredVehicles.filter(v => 
            v.status === subscription.filter.status
          );
        }
      }
      
      // Send update
      client.ws.send(JSON.stringify({
        type: 'subscription_update',
        subscriptionId: subscription.subscriptionId,
        topic: 'vehicles',
        data: filteredVehicles,
        count: filteredVehicles.length,
        timestamp: new Date().toISOString()
      }));
      
      // Update last update time
      subscription.lastUpdate = new Date();
    }
  }
  
  /**
   * Update trajectory subscriptions
   * @private
   */
  updateTrajectorySubscriptions() {
    if (!this.predictor) return;
    
    // Get active subscriptions for trajectories
    const trajectorySubscriptions = Array.from(this.subscriptions.values())
      .filter(sub => sub.topic === 'trajectories');
    
    if (trajectorySubscriptions.length === 0) return;
    
    // Get all trajectories
    const trajectories = Array.from(this.predictor.trajectories.entries()).map(([vehicleId, trajectory]) => ({
      vehicleId,
      generatedAt: trajectory.generatedAt,
      predictionMethod: trajectory.predictionMethod,
      points: trajectory.points.map(p => ({
        timeOffset: p.timeOffset,
        position: p.position,
        uncertainty: p.uncertainty
      }))
    }));
    
    // Send to each subscriber
    for (const subscription of trajectorySubscriptions) {
      const client = this.clients.get(subscription.clientId);
      if (!client || !client.ws) continue;
      
      // Apply filter if any
      let filteredTrajectories = trajectories;
      if (subscription.filter && subscription.filter.vehicleId) {
        filteredTrajectories = filteredTrajectories.filter(t => 
          t.vehicleId === subscription.filter.vehicleId
        );
      }
      
      // Send update
      client.ws.send(JSON.stringify({
        type: 'subscription_update',
        subscriptionId: subscription.subscriptionId,
        topic: 'trajectories',
        data: filteredTrajectories,
        count: filteredTrajectories.length,
        timestamp: new Date().toISOString()
      }));
      
      // Update last update time
      subscription.lastUpdate = new Date();
    }
  }
  
  /**
   * Update conflict subscriptions
   * @private
   */
  updateConflictSubscriptions() {
    if (!this.predictor) return;
    
    // Get active subscriptions for conflicts
    const conflictSubscriptions = Array.from(this.subscriptions.values())
      .filter(sub => sub.topic === 'conflicts');
    
    if (conflictSubscriptions.length === 0) return;
    
    // Get all conflicts
    const conflicts = Array.from(this.predictor.predictedConflicts.values()).map(conflict => ({
      conflictId: conflict.conflictId,
      vehicle1Id: conflict.vehicle1?.vehicleId,
      vehicle2Id: conflict.vehicle2?.vehicleId,
      severity: conflict.severity,
      timeOffset: conflict.timeOffset,
      predictedTime: conflict.predictedTime,
      horizontalDistance: conflict.horizontalDistance,
      verticalDistance: conflict.verticalDistance
    }));
    
    // Send to each subscriber
    for (const subscription of conflictSubscriptions) {
      const client = this.clients.get(subscription.clientId);
      if (!client || !client.ws) continue;
      
      // Apply filter if any
      let filteredConflicts = conflicts;
      if (subscription.filter) {
        if (subscription.filter.vehicleId) {
          filteredConflicts = filteredConflicts.filter(c => 
            c.vehicle1Id === subscription.filter.vehicleId || 
            c.vehicle2Id === subscription.filter.vehicleId
          );
        }
        
        if (subscription.filter.severity) {
          filteredConflicts = filteredConflicts.filter(c => 
            c.severity === subscription.filter.severity
          );
        }
        
        if (subscription.filter.timeWindow) {
          filteredConflicts = filteredConflicts.filter(c => 
            c.timeOffset <= subscription.filter.timeWindow
          );
        }
      }
      
      // Send update
      client.ws.send(JSON.stringify({
        type: 'subscription_update',
        subscriptionId: subscription.subscriptionId,
        topic: 'conflicts',
        data: filteredConflicts,
        count:
```
