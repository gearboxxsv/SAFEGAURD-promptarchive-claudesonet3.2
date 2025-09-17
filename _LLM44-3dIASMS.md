I'll create a comprehensive documentation webpage for integrating 3D simulation with the IASMS system, focusing on AR/VR features, WebXR, and Three.js integration.

# Integrating 3D Simulation with IASMS System

## Table of Contents
- [Overview](#overview)
- [System Architecture](#system-architecture)
- [Setup and Installation](#setup-and-installation)
    - [Prerequisites](#prerequisites)
    - [Installation Scripts](#installation-scripts)
    - [Environment Configuration](#environment-configuration)
- [Three.js Integration](#threejs-integration)
    - [Scene Setup](#scene-setup)
    - [Rendering Pipeline](#rendering-pipeline)
    - [Performance Optimization](#performance-optimization)
- [WebXR Implementation](#webxr-implementation)
    - [Device Compatibility](#device-compatibility)
    - [Feature Detection](#feature-detection)
    - [Session Management](#session-management)
- [AR/VR Features](#arvr-features)
    - [Immersive Mode](#immersive-mode)
    - [Controller Input](#controller-input)
    - [Hand Tracking](#hand-tracking)
- [Meta Quest Integration](#meta-quest-integration)
    - [Device Setup](#device-setup)
    - [Controller Mapping](#controller-mapping)
    - [Performance Considerations](#performance-considerations)
- [Haptic Feedback](#haptic-feedback)
    - [Controller Vibration](#controller-vibration)
    - [Pattern Creation](#pattern-creation)
    - [Intensity Mapping](#intensity-mapping)
- [Spatial Audio](#spatial-audio)
    - [Audio Implementation](#audio-implementation)
    - [3D Sound Positioning](#3d-sound-positioning)
    - [Ambient Sound Management](#ambient-sound-management)
- [Mobile Support](#mobile-support)
    - [Responsive Design](#responsive-design)
    - [Touch Controls](#touch-controls)
    - [Device Orientation](#device-orientation)
- [Meteor Integration](#meteor-integration)
    - [Publication/Subscription Model](#publicationsubscription-model)
    - [Real-time Updates](#real-time-updates)
    - [Data Flow](#data-flow)
- [React Integration](#react-integration)
    - [Component Structure](#component-structure)
    - [State Management](#state-management)
    - [Lifecycle Management](#lifecycle-management)
- [Multi-Modal Simulation](#multi-modal-simulation)
    - [Modality Switching](#modality-switching)
    - [Cross-Modality Interaction](#cross-modality-interaction)
- [Troubleshooting](#troubleshooting)
    - [Common Issues](#common-issues)
    - [Performance Problems](#performance-problems)
    - [WebXR Compatibility](#webxr-compatibility)
- [Resources](#resources)
    - [Documentation](#documentation)
    - [Libraries](#libraries)
    - [Tools](#tools)

## Overview {#overview}

The IASMS (Integrated Aerial Simulation Management System) 3D simulation integration provides an immersive WebXR-powered environment for visualizing and interacting with multi-modal simulations across various domains including aerial, marine, space, land, subsurface, pedestrian, and robotic systems.

This integration leverages Three.js, WebXR, and React to create a seamless experience across desktop, mobile, and VR/AR headsets, with special optimizations for Meta Quest devices. The system supports advanced features such as hand tracking, eye tracking, haptic feedback, and spatial audio.

## System Architecture {#system-architecture}

The 3D simulation integration with IASMS follows a modular architecture:

```
IASMS Core System
├── Client
│   ├── IASMS Components
│   ├── 3D Simulation (Three.js + WebXR)
│   │   ├── Modality Managers
│   │   │   ├── Aerial
│   │   │   ├── Marine
│   │   │   ├── Space
│   │   │   ├── Land
│   │   │   ├── Subsurface
│   │   │   ├── Pedestrian
│   │   │   └── Robot
│   │   ├── Feature Systems
│   │   │   ├── Physics
│   │   │   ├── Spatial Audio
│   │   │   ├── Haptic Feedback
│   │   │   ├── Hand Tracking
│   │   │   ├── Eye Tracking
│   │   │   └── Neural Interface Simulation
│   │   └── UI Components
│   └── React Application
└── Server
    ├── IASMS Core Services
    ├── Simulation Integration Services
    └── MongoDB Collections
```


The architecture enables:
- Seamless communication between the IASMS core system and 3D simulation
- Independent management of different modalities (aerial, marine, etc.)
- Flexible feature support based on device capabilities
- Real-time data synchronization between server and clients

## Setup and Installation {#setup-and-installation}

### Prerequisites {#prerequisites}

Before setting up the 3D simulation integration, ensure your system meets the following requirements:

- Node.js (v14+)
- Meteor (v2.5+)
- MongoDB (v4.4+)
- Modern web browser with WebGL and WebXR support
- For development: Meta Quest device or mobile device with AR capabilities (optional)

### Installation Scripts {#installation-scripts}

Use the provided setup scripts to configure your development environment:

```shell script
# WebXR and Three.js setup script
bash ThreeJSWebXRSetupScript.sh

# WebXR Simulation setup script
bash WebXRSimulationSetupScript.sh
```


These scripts install required dependencies and configure the development environment with optimal settings for WebXR development.

### Environment Configuration {#environment-configuration}

Create a `.env` file in your project root with the following configuration:

```
# WebXR Configuration
ENABLE_WEBXR=true
WEBXR_REQUIRED_FEATURES=local-floor,bounded-floor,hand-tracking
WEBXR_OPTIONAL_FEATURES=eye-tracking,dom-overlay,anchors,foveation

# Three.js Configuration
THREEJS_SHADOW_MAP=true
THREEJS_PIXEL_RATIO=1
THREEJS_POWER_PREFERENCE=high-performance

# Performance Settings
MAX_ANIMATION_MIXERS=50
ENABLE_FOVEATED_RENDERING=true
PHYSICS_SIMULATION_RATE=60
```


## Three.js Integration {#threejs-integration}

### Scene Setup {#scene-setup}

The 3D simulation uses Three.js for rendering. The core scene setup is handled in `CrossModalityARVRSceneSetup.js`:

```javascript
// Initialize scene
const scene = new THREE.Scene();
scene.background = new THREE.Color(0x87ceeb);
sceneRef.current = scene;

// Initialize camera
const camera = new THREE.PerspectiveCamera(
  75, 
  window.innerWidth / window.innerHeight,
  0.1,
  10000
);
camera.position.set(0, 100, 200);
cameraRef.current = camera;

// Initialize renderer with WebXR support
const renderer = new THREE.WebGLRenderer({ 
  antialias: true,
  alpha: true
});
renderer.setPixelRatio(window.devicePixelRatio);
renderer.setSize(window.innerWidth, window.innerHeight);
renderer.shadowMap.enabled = true;
renderer.xr.enabled = true;
```


For advanced settings, refer to the `MultiModalImmersiveSimulation.js` which includes post-processing effects and enhanced rendering configuration.

### Rendering Pipeline {#rendering-pipeline}

The simulation uses an advanced rendering pipeline with post-processing effects:

```javascript
// Set up post-processing with EffectComposer
const composer = new EffectComposer(renderer);
const renderPass = new RenderPass(scene, camera);
composer.addPass(renderPass);

// Bloom effect for glowing elements
const bloomPass = new UnrealBloomPass(
  new THREE.Vector2(window.innerWidth, window.innerHeight),
  0.5, // Bloom strength
  0.2, // Bloom radius
  0.1  // Bloom threshold
);
composer.addPass(bloomPass);

// Outline pass for interactive highlighting
const outlinePass = new OutlinePass(
  new THREE.Vector2(window.innerWidth, window.innerHeight),
  scene,
  camera
);
outlinePass.visibleEdgeColor.set(0x00ffff);
outlinePass.hiddenEdgeColor.set(0x00aaff);
outlinePass.edgeStrength = 5;
outlinePass.edgeGlow = 0.5;
outlinePass.edgeThickness = 2;
composer.addPass(outlinePass);
```


### Performance Optimization {#performance-optimization}

Several performance optimizations are implemented:

1. **Level of Detail (LOD)**
    - Dynamic mesh simplification based on distance
    - Reduced polygon count for distant objects

2. **Frustum Culling**
    - Only rendering objects within the camera view
    - Efficient scene management

3. **Foveated Rendering**
    - When supported by the device (e.g., Meta Quest)
    - Concentrates rendering quality in the center of vision

4. **Instanced Rendering**
    - For repeated objects like crowd simulations
    - Significantly reduces draw calls

Example code for implementing instanced rendering:

```javascript
// Create an instanced mesh for multiple objects
const geometry = new THREE.BoxGeometry(1, 1, 1);
const material = new THREE.MeshStandardMaterial({ color: 0x00ff00 });
const instancedMesh = new THREE.InstancedMesh(geometry, material, 1000);

// Set position and rotation for each instance
for (let i = 0; i < 1000; i++) {
  const position = new THREE.Vector3(
    Math.random() * 100 - 50,
    Math.random() * 100 - 50,
    Math.random() * 100 - 50
  );
  const quaternion = new THREE.Quaternion();
  quaternion.setFromEuler(new THREE.Euler(
    Math.random() * Math.PI,
    Math.random() * Math.PI,
    Math.random() * Math.PI
  ));
  const scale = new THREE.Vector3(1, 1, 1);
  
  const matrix = new THREE.Matrix4();
  matrix.compose(position, quaternion, scale);
  
  instancedMesh.setMatrixAt(i, matrix);
}

scene.add(instancedMesh);
```


## WebXR Implementation {#webxr-implementation}

### Device Compatibility {#device-compatibility}

The WebXR implementation includes comprehensive feature detection to ensure compatibility across devices:

```typescript
// XR Feature Detector
export class XRFeatureDetector {
  public async detectFeatures(): Promise<any> {
    const features = {
      webXRSupported: false,
      immersiveVR: false,
      immersiveAR: false,
      handTracking: false,
      eyeTracking: false,
      // ... additional features
    };
    
    // Check if WebXR is supported
    if (typeof navigator.xr === 'undefined') {
      console.log('WebXR not supported in this browser');
      return features;
    }
    
    features.webXRSupported = true;
    
    // Check if VR is supported
    try {
      features.immersiveVR = await navigator.xr.isSessionSupported('immersive-vr');
    } catch (e) {
      console.warn('Error checking VR support:', e);
    }
    
    // Check if AR is supported
    try {
      features.immersiveAR = await navigator.xr.isSessionSupported('immersive-ar');
    } catch (e) {
      console.warn('Error checking AR support:', e);
    }
    
    // Additional feature checking...
    
    return features;
  }
  
  // Additional methods...
}
```


### Feature Detection {#feature-detection}

The feature detection system checks for:

- Basic WebXR support
- VR and AR mode support
- Hand tracking capabilities
- Eye tracking capabilities
- Spatial anchors
- Plane detection
- Mesh detection
- Image tracking
- Depth sensing
- Foveated rendering
- Light estimation
- Passthrough capabilities
- Neural interface simulation
- Spatial audio support
- DOM overlay capabilities

### Session Management {#session-management}

Session management handles the initialization and cleanup of WebXR sessions:

```javascript
// Custom VR button with enhanced styling and session management
const createCustomVRButton = (renderer) => {
  const button = document.createElement('button');
  button.classList.add('vr-button');
  // Style setup...
  
  button.addEventListener('click', () => {
    if (renderer.xr.isPresenting) {
      renderer.xr.getSession().end();
    } else {
      // Request VR session with required features
      const sessionInit = {
        optionalFeatures: [
          'local-floor',
          'bounded-floor',
          'hand-tracking',
          'layers',
          'dom-overlay'
        ]
      };
      
      // Add DOM overlay if supported
      if (document.getElementById('vr-overlay')) {
        sessionInit.domOverlay = { root: document.getElementById('vr-overlay') };
      }
      
      navigator.xr.requestSession('immersive-vr', sessionInit)
        .then(session => {
          renderer.xr.setSession(session);
          button.textContent = 'EXIT VR';
        })
        .catch(error => {
          console.error('Failed to enter VR mode:', error);
        });
    }
  });
  
  return button;
};
```


## AR/VR Features {#arvr-features}

### Immersive Mode {#immersive-mode}

The system supports both VR and AR immersive modes with environment-specific optimizations:

```javascript
// For VR mode
renderer.xr.addEventListener('sessionstart', () => {
  // Configure scene for VR
  scene.background = new THREE.Color(0x000000);
  scene.fog = new THREE.FogExp2(0x000000, 0.00025);
  
  // Disable orbit controls when in XR mode
  controls.enabled = false;
  
  // Initialize VR-specific features
  initializeVRFeatures();
});

// For AR mode
renderer.xr.addEventListener('sessionstart', () => {
  if (renderer.xr.getSession().mode === 'immersive-ar') {
    // Configure scene for AR
    scene.background = null; // Transparent background for camera feed
    scene.fog = null; // No fog in AR
    
    // Initialize AR-specific features
    initializeARFeatures();
    
    // Set up hit testing for placement
    renderer.xr.getSession().requestReferenceSpace('local-floor')
      .then(refSpace => {
        renderer.xr.getSession().requestHitTestSource({ space: refSpace })
          .then(hitTestSource => {
            hitTestSourceRef.current = hitTestSource;
          });
      });
  }
});
```


### Controller Input {#controller-input}

The system provides comprehensive controller input handling:

```javascript
// Setup controller event listeners
const setupEnhancedVRControllers = (renderer, scene) => {
  const controllerModelFactory = new XRControllerModelFactory();
  
  // Setup controller 1
  const controller1 = renderer.xr.getController(0);
  controller1.addEventListener('selectstart', onControllerSelectStart);
  controller1.addEventListener('selectend', onControllerSelectEnd);
  controller1.addEventListener('squeezestart', onControllerSqueezeStart);
  controller1.addEventListener('squeezeend', onControllerSqueezeEnd);
  controller1.addEventListener('connected', (event) => {
    controller1.gamepad = event.data.gamepad;
    controller1.userData.controllerType = 'primary';
  });
  controller1.addEventListener('disconnected', () => {
    controller1.gamepad = null;
  });
  scene.add(controller1);
  
  // Similar setup for controller 2...
  
  // Add controller grip models
  const controllerGrip1 = renderer.xr.getControllerGrip(0);
  controllerGrip1.add(controllerModelFactory.createControllerModel(controllerGrip1));
  scene.add(controllerGrip1);
  
  // Create controller ray visualizers...
  
  // Setup controller polling for continuous inputs
  const controllerTick = () => {
    // Process gamepad inputs from both controllers
    [controller1, controller2].forEach(controller => {
      if (controller.gamepad) {
        // Check thumbstick for locomotion or rotation
        const thumbstickX = controller.gamepad.axes[2];
        const thumbstickY = controller.gamepad.axes[3];
        
        if (Math.abs(thumbstickX) > 0.2 || Math.abs(thumbstickY) > 0.2) {
          // Handle thumbstick input...
        }
        
        // Check other buttons...
      }
    });
    
    requestAnimationFrame(controllerTick);
  };
  
  controllerTick();
};
```


### Hand Tracking {#hand-tracking}

The system supports hand tracking for controller-free interaction:

```javascript
// Initialize hand tracking if supported
if (features.handTracking) {
  const handModelFactory = new XRHandModelFactory();
  
  // Set up hand models for left and right hands
  for (let i = 0; i < 2; i++) {
    const hand = rendererRef.current.xr.getHand(i);
    
    // Add visualization for the hand
    const model = handModelFactory.createHandModel(hand, 'mesh');
    hand.add(model);
    
    sceneRef.current.add(hand);
    xrHandModelsRef.current.push(hand);
  }
  
  // Initialize gesture recognition system
  const gestureSystem = new GestureRecognitionSystem(
    xrHandModelsRef.current,
    sceneRef.current
  );
  gestureSystem.initialize();
  gestureSystemRef.current = gestureSystem;
}
```


The gesture recognition system detects common hand gestures:

```javascript
// Handle detected hand gestures
const handleGestureDetection = (gestures) => {
  gestures.forEach(gesture => {
    switch (gesture.type) {
      case 'pinch':
        // Handle pinch gesture for object selection or UI interaction
        handlePinchGesture(gesture);
        break;
      
      case 'grab':
        // Handle grab gesture for object manipulation
        handleGrabGesture(gesture);
        break;
      
      case 'swipe':
        // Handle swipe gesture for navigation or menu interaction
        handleSwipeGesture(gesture);
        break;
      
      case 'wave':
        // Handle wave gesture for modality switching
        handleWaveGesture(gesture);
        break;
      
      case 'thumbsUp':
        // Handle thumbs up gesture for confirmation
        handleThumbsUpGesture(gesture);
        break;
    }
  });
};
```


## Meta Quest Integration {#meta-quest-integration}

### Device Setup {#device-setup}

For optimal performance on Meta Quest devices:

1. **Enable Developer Mode** on your Quest device through the Oculus app
2. **Connect via USB** and enable USB debugging
3. **Configure Browser** with WebXR capabilities (Chrome or Oculus Browser)
4. **Enable Hand Tracking** in the Quest settings for controller-free operation

### Controller Mapping {#controller-mapping}

Meta Quest controllers are mapped as follows:

```javascript
// Meta Quest controller mapping
const QUEST_CONTROLLER_MAPPING = {
  // Buttons
  'A': 0,           // Right controller A button
  'B': 1,           // Right controller B button
  'X': 0,           // Left controller X button
  'Y': 1,           // Left controller Y button
  'TRIGGER': 2,     // Index finger trigger
  'GRIP': 3,        // Middle finger grip button
  'MENU': 4,        // Menu button (usually left controller)
  'THUMBSTICK': 5,  // Thumbstick press
  
  // Axes
  'THUMBSTICK_X': 2, // Thumbstick X axis
  'THUMBSTICK_Y': 3  // Thumbstick Y axis
};

// Example of using the mapping
function processControllerInput(controller) {
  if (!controller.gamepad) return;
  
  // Check if trigger is pressed
  const triggerPressed = controller.gamepad.buttons[QUEST_CONTROLLER_MAPPING.TRIGGER].pressed;
  
  // Get thumbstick values
  const thumbX = controller.gamepad.axes[QUEST_CONTROLLER_MAPPING.THUMBSTICK_X];
  const thumbY = controller.gamepad.axes[QUEST_CONTROLLER_MAPPING.THUMBSTICK_Y];
  
  // Process input...
}
```


### Performance Considerations {#performance-considerations}

For optimal performance on Quest devices:

1. **Use Foveated Rendering** when available:
```javascript
// Enable foveated rendering for better performance
if (features.foveatedRendering && renderer.xr.isPresenting) {
  renderer.xr.setFoveation(0.7); // Level of foveation (0 to 1)
}
```


2. **Optimize Polygon Count** for complex scenes:
```javascript
// Create LOD (Level of Detail) for complex objects
const createLODObject = (modelPath) => {
  const lod = new THREE.LOD();
  
  // High detail for close viewing
  const highDetailLoader = new GLTFLoader();
  highDetailLoader.load(modelPath + '_high.glb', (gltf) => {
    lod.addLevel(gltf.scene, 0);
  });
  
  // Medium detail for medium distance
  const medDetailLoader = new GLTFLoader();
  medDetailLoader.load(modelPath + '_medium.glb', (gltf) => {
    lod.addLevel(gltf.scene, 10);
  });
  
  // Low detail for far distance
  const lowDetailLoader = new GLTFLoader();
  lowDetailLoader.load(modelPath + '_low.glb', (gltf) => {
    lod.addLevel(gltf.scene, 50);
  });
  
  return lod;
}
```


3. **Implement Occlusion Culling** to avoid rendering hidden objects:
```javascript
// Simple occlusion culling with raycasting
const performOcclusionCulling = (camera, objects) => {
  const raycaster = new THREE.Raycaster();
  const cameraPosition = camera.position;
  
  objects.forEach(object => {
    // Direction from camera to object
    const direction = new THREE.Vector3()
      .subVectors(object.position, cameraPosition)
      .normalize();
    
    // Set up raycaster
    raycaster.set(cameraPosition, direction);
    
    // Find intersections
    const intersects = raycaster.intersectObjects(scene.children, true);
    
    // If first intersection is not our object, it's occluded
    if (intersects.length > 0 && intersects[0].object !== object) {
      object.visible = false;
    } else {
      object.visible = true;
    }
  });
}
```


## Haptic Feedback {#haptic-feedback}

### Controller Vibration {#controller-vibration}

The haptic feedback system provides tactile responses to user interactions:

```typescript
/**
 * Play a haptic feedback effect on a specific hand (or both hands if not specified)
 */
public playHapticPulse(options: {
  duration: number,
  intensity: number,
  dataType?: string,
  hand?: string,
  pattern?: string
}): void {
  // Extract options
  const { 
    duration, 
    intensity,
    dataType = 'vibration',
    hand = 'both',
    pattern
  } = options;
  
  // Select which actuators to use based on hand
  let actuators: GamepadHapticActuator[] = [];
  
  if (hand === 'left' && this.hapticActuators.length > 0) {
    actuators = [this.hapticActuators[0]];
  } else if (hand === 'right' && this.hapticActuators.length > 1) {
    actuators = [this.hapticActuators[1]];
  } else {
    actuators = this.hapticActuators;
  }
  
  // If no actuators, exit
  if (actuators.length === 0) return;
  
  // Check if we're using a preset pattern
  if (pattern && this.presetPatterns.has(pattern)) {
    const patternData = this.presetPatterns.get(pattern);
    
    if (Array.isArray(patternData)) {
      // Sequential pattern
      this.playSequentialPattern(actuators, patternData, dataType);
    } else if (typeof patternData === 'function') {
      // Function-based pattern
      this.playFunctionPattern(actuators, patternData, duration, dataType);
    } else {
      // Single pulse with preset values
      actuators.forEach(actuator => {
        actuator.pulse(patternData.intensity, patternData.duration, dataType);
      });
    }
  } else {
    // Simple pulse with provided values
    actuators.forEach(actuator => {
      actuator.pulse(intensity, duration, dataType);
    });
  }
}
```


### Pattern Creation {#pattern-creation}

The system supports complex haptic patterns for different interactions:

```typescript
// Initialize preset haptic patterns
private initializePresetPatterns(): void {
  // Simple pulse
  this.presetPatterns.set('pulse', {
    duration: 100,
    intensity: 0.5
  });
  
  // Double pulse
  this.presetPatterns.set('doublePulse', [
    { duration: 50, intensity: 0.7 },
    { duration: 50, intensity: 0 },
    { duration: 50, intensity: 0.7 }
  ]);
  
  // Success feedback
  this.presetPatterns.set('success', [
    { duration: 50, intensity: 0.3 },
    { duration: 50, intensity: 0 },
    { duration: 100, intensity: 0.7 }
  ]);
  
  // Error feedback
  this.presetPatterns.set('error', [
    { duration: 100, intensity: 0.8 },
    { duration: 50, intensity: 0 },
    { duration: 50, intensity: 0.8 }
  ]);
  
  // Warning feedback
  this.presetPatterns.set('warning', [
    { duration: 50, intensity: 0.5 },
    { duration: 50, intensity: 0 },
    { duration: 50, intensity: 0.5 },
    { duration: 50, intensity: 0 },
    { duration: 50, intensity: 0.5 }
  ]);
  
  // Heartbeat
  this.presetPatterns.set('heartbeat', [
    { duration: 50, intensity: 0.5 },
    { duration: 50, intensity: 0 },
    { duration: 50, intensity: 0.8 },
    { duration: 300, intensity: 0 }
  ]);
  
  // Smooth ramp
  this.presetPatterns.set('ramp', (t) => {
    // t goes from 0 to 1 over the duration
    return Math.sin(t * Math.PI) * 0.7;
  });
}
```


### Intensity Mapping {#intensity-mapping}

Different interactions are mapped to appropriate haptic intensities:

| Interaction | Pattern | Intensity | Duration | Description |
|-------------|---------|-----------|----------|-------------|
| Selection   | `pulse` | 0.5 | 100ms | Standard feedback for selecting items |
| Confirmation | `success` | 0.7 | 200ms | Positive action completion |
| Error | `error` | 0.8 | 200ms | Error or invalid action |
| Warning | `warning` | 0.5 | 250ms | Warning or caution feedback |
| Collision | `pulse` | 0.9 | 80ms | Object collision feedback |
| Menu Open | `doublePulse` | 0.4 | 150ms | Menu opening feedback |
| Grab Start | `pulse` | 0.7 | 100ms | Object grab initiation |
| Grab Release | `pulse` | 0.3 | 50ms | Object release |
| Modality Change | `success` | 0.6 | 200ms | Switching between modalities |

## Spatial Audio {#spatial-audio}

### Audio Implementation {#audio-implementation}

The spatial audio system creates immersive audio experiences:

```typescript
/**
 * Play a sound at a specific position
 */
public playSound(
  soundName: string,
  position: THREE.Vector3,
  options: {
    volume?: number,
    loop?: boolean,
    refDistance?: number,
    rolloffFactor?: number,
    detune?: number
  } = {}
): THREE.PositionalAudio | null {
  if (!this.initialized) {
    console.warn('Spatial audio system not initialized');
    return null;
  }
  
  // Set default options
  const {
    volume = 1.0,
    loop = false,
    refDistance = 1,
    rolloffFactor = 1,
    detune = 0
  } = options;
  
  // Get the sound buffer
  const buffer = this.soundBuffers.get(soundName);
  if (!buffer) {
    console.warn(`Sound not found: ${soundName}`);
    return null;
  }
  
  // Create a positional audio source
  const sound = new THREE.PositionalAudio(this.listener);
  sound.setBuffer(buffer);
  sound.setVolume(volume);
  sound.setLoop(loop);
  sound.setRefDistance(refDistance);
  sound.setRolloffFactor(rolloffFactor);
  
  // Apply detune if specified
  if (detune !== 0) {
    sound.detune.value = detune;
  }
  
  // Create a dummy object to position the sound
  const soundObject = new THREE.Object3D();
  soundObject.position.copy(position);
  soundObject.add(sound);
  this.scene.add(soundObject);
  
  // Store sound for tracking
  this.sounds.set(`${soundName}_${Date.now()}`, sound);
  
  // Play the sound
  sound.play();
  
  // If not looping, remove after playing
  if (!loop) {
    const duration = buffer.duration * 1000; // ms
    setTimeout(() => {
      // Cleanup...
    }, duration + 100);
  }
  
  return sound;
}
```


### 3D Sound Positioning {#3d-sound-positioning}

The system positions sounds in 3D space for realistic audio cues:

```javascript
// Example of positioning a sound at an object's location
function playSoundAtObject(object, soundName) {
  if (spatialAudioSystem && object) {
    // Get world position of the object
    const worldPosition = new THREE.Vector3();
    object.getWorldPosition(worldPosition);
    
    // Play sound at that position
    spatialAudioSystem.playSound(soundName, worldPosition, {
      volume: 0.8,
      refDistance: 5,    // Distance at which the volume reduction starts
      rolloffFactor: 1.5 // How quickly the sound attenuates with distance
    });
  }
}

// Example of creating a moving sound source
function createMovingSoundSource(path, soundName) {
  // Create a dummy object to hold the sound
  const soundObject = new THREE.Object3D();
  scene.add(soundObject);
  
  // Create the positional audio
  const sound = spatialAudioSystem.playSound(soundName, soundObject.position, {
    loop: true,
    volume: 0.6
  });
  
  // Animate the sound along a path
  const points = path.map(p => new THREE.Vector3(p.x, p.y, p.z));
  const curve = new THREE.CatmullRomCurve3(points);
  
  let progress = 0;
  
  function updateSound() {
    // Update position along curve
    progress += 0.001;
    if (progress > 1) progress = 0;
    
    const position = curve.getPointAt(progress);
    soundObject.position.copy(position);
    
    requestAnimationFrame(updateSound);
  }
  
  updateSound();
  
  return { sound, soundObject };
}
```


### Ambient Sound Management {#ambient-sound-management}

The system manages ambient sounds for different environments:

```typescript
/**
 * Play ambient sound for a specific modality
 */
public playModalityAmbience(modality: string): void {
  // Stop all current ambient sounds
  for (const [name, sound] of this.ambientSounds.entries()) {
    if (name.startsWith('ambient_')) {
      sound.stop();
      this.ambientSounds.delete(name);
    }
  }
  
  // Play appropriate ambient sound for the modality
  let ambientSound: string;
  
  switch (modality) {
    case 'aerial':
      ambientSound = 'ambient_air';
      break;
    case 'marine':
      ambientSound = 'ambient_sea';
      break;
    case 'space':
      ambientSound = 'ambient_space';
      break;
    case 'subsurface':
      ambientSound = 'ambient_subsurface';
      break;
    case 'pedestrian':
    case 'land':
    case 'robot':
      ambientSound = 'ambient_city';
      break;
    default:
      ambientSound = 'ambient_air';
  }
  
  this.playAmbientSound(ambientSound, { volume: 0.3 });
}
```


## Mobile Support {#mobile-support}

### Responsive Design {#responsive-design}

The system adapts to different screen sizes and device capabilities:

```javascript
// Handle window resize for mobile and desktop
const handleResize = () => {
  const width = window.innerWidth;
  const height = window.innerHeight;
  
  // Update camera aspect ratio
  camera.aspect = width / height;
  camera.updateProjectionMatrix();
  
  // Update renderer size
  renderer.setSize(width, height);
  composer.setSize(width, height);
  
  // Adjust UI elements based on screen size
  if (width < 768) {
    // Mobile UI adjustments
    uiControls.style.scale = 0.8;
    uiControls.style.position = 'bottom';
  } else {
    // Desktop UI adjustments
    uiControls.style.scale = 1.0;
    uiControls.style.position = 'top-right';
  }
};

// Listen for orientation changes on mobile
window.addEventListener('orientationchange', () => {
  setTimeout(handleResize, 200); // Delay to allow orientation to complete
});

window.addEventListener('resize', handleResize);
```


### Touch Controls {#touch-controls}

The system provides touch controls for mobile devices:

```javascript
// Setup touch controls for mobile devices
const setupTouchControls = (container, camera, scene) => {
  let touchStartX, touchStartY;
  let touchPrevX, touchPrevY;
  let isRotating = false;
  let isPanning = false;
  
  // Single touch for rotation
  container.addEventListener('touchstart', (event) => {
    if (event.touches.length === 1) {
      isRotating = true;
      touchStartX = touchPrevX = event.touches[0].clientX;
      touchStartY = touchPrevY = event.touches[0].clientY;
    } else if (event.touches.length === 2) {
      // Two fingers for panning
      isPanning = true;
      const touch1 = event.touches[0];
      const touch2 = event.touches[1];
      touchStartX = touchPrevX = (touch1.clientX + touch2.clientX) / 2;
      touchStartY = touchPrevY = (touch1.clientY + touch2.clientY) / 2;
    }
  });
  
  container.addEventListener('touchmove', (event) => {
    event.preventDefault();
    
    if (isRotating && event.touches.length === 1) {
      const touchX = event.touches[0].clientX;
      const touchY = event.touches[0].clientY;
      
      const deltaX = touchX - touchPrevX;
      const deltaY = touchY - touchPrevY;
      
      // Rotate camera based on touch movement
      camera.rotation.y -= deltaX * 0.01;
      camera.rotation.x -= deltaY * 0.01;
      
      touchPrevX = touchX;
      touchPrevY = touchY;
    } else if (isPanning && event.touches.length === 2) {
      const touch1 = event.touches[0];
      const touch2 = event.touches[1];
      const touchX = (touch1.clientX + touch2.clientX) / 2;
      const touchY = (touch1.clientY + touch2.clientY) / 2;
      
      const deltaX = touchX - touchPrevX;
      const deltaY = touchY - touchPrevY;
      
      // Calculate pan direction in world space
      const direction = new THREE.Vector3();
      camera.getWorldDirection(direction);
      const right = new THREE.Vector3().crossVectors(direction, camera.up);
      
      // Pan camera
      camera.position.add(right.multiplyScalar(-deltaX * 0.1));
      camera.position.add(camera.up.clone().multiplyScalar(deltaY * 0.1));
      
      touchPrevX = touchX;
      touchPrevY = touchY;
    }
  });
  
  container.addEventListener('touchend', () => {
    isRotating = false;
    isPanning = false;
  });
  
  // Double tap for selection
  let lastTap = 0;
  container.addEventListener('touchend', (event) => {
    const currentTime = new Date().getTime();
    const tapLength = currentTime - lastTap;
    
    if (tapLength < 300 && tapLength > 0) {
      // Double tap detected - perform selection
      const touch = event.changedTouches[0];
      const raycaster = new THREE.Raycaster();
      
      // Convert touch position to normalized device coordinates
      const rect = container.getBoundingClientRect();
      const x = ((touch.clientX - rect.left) / container.clientWidth) * 2 - 1;
      const y = -((touch.clientY - rect.top) / container.clientHeight) * 2 + 1;
      
      raycaster.setFromCamera(new THREE.Vector2(x, y), camera);
      const intersects = raycaster.intersectObjects(scene.children, true);
      
      if (intersects.length > 0) {
        // Handle selection of object
        handleObjectInteraction(intersects[0].object, 'select');
      }
    }
    
    lastTap = currentTime;
  });
};
```


### Device Orientation {#device-orientation}

For mobile AR, the system uses device orientation for camera control:

```javascript
// Setup device orientation controls for mobile AR
const setupDeviceOrientationControls = (camera) => {
  const deviceOrientationControls = new DeviceOrientationControls(camera);
  
  // Check if device orientation is available
  if (window.DeviceOrientationEvent && typeof window.DeviceOrientationEvent.requestPermission === 'function') {
    // iOS 13+ requires permission
    const requestPermission = () => {
      window.DeviceOrientationEvent.requestPermission()
        .then(response => {
          if (response === 'granted') {
            deviceOrientationControls.enabled = true;
            window.addEventListener('orientationchange', () => {
              deviceOrientationControls.update();
            });
          }
        })
        .catch(console.error);
    };
    
    // Create permission button
    const permissionButton = document.createElement('button');
    permissionButton.style.cssText = `
      position: fixed;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      padding: 12px 24px;
      background: #4CAF50;
      color: white;
      border: none;
      border-radius: 4px;
      font-size: 16px;
      z-index: 9999;
    `;
    permissionButton.textContent = 'Enable Device Motion';
    permissionButton.addEventListener('click', requestPermission);
    document.body.appendChild(permissionButton);
  } else {
    // Non-iOS or older iOS
    deviceOrientationControls.enabled = true;
  }
  
  // Update controls on each frame
  const updateOrientation = () => {
    if (deviceOrientationControls.enabled) {
      deviceOrientationControls.update();
    }
    requestAnimationFrame(updateOrientation);
  };
  
  updateOrientation();
  
  return deviceOrientationControls;
};
```


## Meteor Integration {#meteor-integration}

### Publication/Subscription Model {#publicationsubscription-model}

The simulation integrates with Meteor's pub/sub model:

```javascript
// Track simulation data from Meteor collections
const { scenario, entities, events, isScenarioLoading } = useTracker(() => {
  const scenarioSub = Meteor.subscribe('iasms.simulationScenario', scenarioId);
  const entitiesSub = Meteor.subscribe('iasms.simulationEntities', scenarioId);
  const eventsSub = Meteor.subscribe('iasms.simulationEvents', scenarioId);
  
  const isLoading = !scenarioSub.ready() || !entitiesSub.ready() || !eventsSub.ready();
  
  const scenario = IASMSSimulationCollection.findOne({ _id: scenarioId, type: 'scenario' });
  const entities = IASMSSimulationCollection.find({ 
    scenarioId: scenarioId,
    type: { $in: ['vehicle', 'ship', 'satellite', 'pedestrian', 'robot', 'infrastructure'] }
  }).fetch();
  const events = IASMSSimulationCollection.find({ 
    scenarioId: scenarioId,
    type: 'event'
  }).fetch();
  
  return {
    scenario,
    entities,
    events,
    isScenarioLoading: isLoading
  };
}, [scenarioId]);
```


### Real-time Updates {#real-time-updates}

The system reacts to real-time data changes:

```javascript
// Server-side publications
if (Meteor.isServer) {
  Meteor.publish('iasms.simulationScenario', function(scenarioId) {
    check(scenarioId, String);
    return IASMSSimulationCollection.find({
      _id: scenarioId,
      type: 'scenario'
    });
  });
  
  Meteor.publish('iasms.simulationEntities', function(scenarioId) {
    check(scenarioId, String);
    return IASMSSimulationCollection.find({
      scenarioId: scenarioId,
      type: { $in: ['vehicle', 'ship', 'satellite', 'pedestrian', 'robot', 'infrastructure'] }
    });
  });
  
  Meteor.publish('iasms.simulationEvents', function(scenarioId) {
    check(scenarioId, String);
    return IASMSSimulationCollection.find({
      scenarioId: scenarioId,
      type: 'event'
    });
  });
}

// Client-side reactive updates
if (Meteor.isClient) {
  // React to entity changes
  useEffect(() => {
    if (!sceneRef.current) return;
    
    // Create or update 3D objects based on entities
    entities.forEach(entity => {
      let object3D = sceneRef.current.getObjectByName(`entity_${entity._id}`);
      
      if (!object3D) {
        // Create new 3D object
        object3D = createEntityObject(entity);
        object3D.name = `entity_${entity._id}`;
        sceneRef.current.add(object3D);
      } else {
        // Update existing 3D object
        updateEntityObject(object3D, entity);
      }
    });
    
    // Remove objects for entities that no longer exist
    const currentEntityIds = new Set(entities.map(e => e._id));
    
    sceneRef.current.traverse((object) => {
      if (object.name && object.name.startsWith('entity_')) {
        const entityId = object.name.replace('entity_', '');
        if (!currentEntityIds.has(entityId)) {
          sceneRef.current.remove(object);
        }
      }
    });
  }, [entities]);
  
  // Similar reactive updates for events
}
```


### Data Flow {#data-flow}

Data flows between the server and 3D simulation:

1. **Server to Client:**
    - Entity updates (position, status, attributes)
    - Event triggers (collisions, waypoints, alerts)
    - Scenario configuration changes

2. **Client to Server:**
    - User interactions (object creation, modification)
    - Simulation control commands (start, pause, reset)
    - Collaborative actions (shared view, annotations)

```javascript
// Example of sending user interactions to the server
const handleObjectModification = (object, newPosition, newRotation) => {
  // Find the entity ID from the object name
  const entityId = object.name.replace('entity_', '');
  
  // Send update to the server
  Meteor.call('iasms.simulation.updateEntityPosition', {
    entityId,
    position: {
      x: newPosition.x,
      y: newPosition.y,
      z: newPosition.z
    },
    rotation: {
      x: newRotation.x,
      y: newRotation.y,
      z: newRotation.z
    }
  }, (error) => {
    if (error) {
      console.error('Error updating entity:', error);
    }
  });
};
```


## React Integration {#react-integration}

### Component Structure {#component-structure}

The 3D simulation is integrated within React components:

```javascript
// Main simulation component
const MultiModalImmersiveSimulation = () => {
  // Refs for core systems
  const containerRef = useRef(null);
  const sceneRef = useRef(null);
  const cameraRef = useRef(null);
  const rendererRef = useRef(null);
  
  // State management
  const [isLoading, setIsLoading] = useState(true);
  const [currentModality, setCurrentModality] = useState('aerial');
  
  // Initialize Three.js scene
  useEffect(() => {
    if (!containerRef.current) return;
    
    // Initialize scene, camera, renderer...
    
    // Clean up on unmount
    return () => {
      // Cleanup...
    };
  }, []);
  
  // Render the component
  return (
    <div className="immersive-simulation">
      {isLoading ? (
        <div className="loading-container">
          <div className="loading-spinner"></div>
          <div className="loading-text">Initializing Immersive Environment</div>
        </div>
      ) : (
        <div className="simulation-container" ref={containerRef}>
          {/* UI elements */}
        </div>
      )}
    </div>
  );
};
```


### State Management {#state-management}

React state management is used for UI controls while Three.js manages the 3D scene state:

```javascript
// State for UI controls
const [currentModality, setCurrentModality] = useState('aerial');
const [timeScale, setTimeScale] = useState(1);
const [environmentSettings, setEnvironmentSettings] = useState({
  weather: 'clear',
  timeOfDay: 'day',
  season: 'summer'
});
const [uiVisible, setUiVisible] = useState(true);

// Toggle UI visibility
const toggleUI = () => {
  setUiVisible(!uiVisible);
};

// Handle modality change
const handleModalityChange = (modality) => {
  setCurrentModality(modality);
  
  // Update 3D scene for the new modality
  if (currentModalityManager) {
    currentModalityManager.deactivate();
  }
  
  const newManager = getModalityManager(modality);
  if (newManager) {
    newManager.activate();
    setCurrentModalityManager(newManager);
  }
  
  // Play sound effect for modality change
  if (spatialAudioRef.current) {
    spatialAudioRef.current.playSound('modality_change', cameraRef.current.position);
  }
};

// Update UI based on state
return (
  <div className="simulation-controls" style={{ display: uiVisible ? 'block' : 'none' }}>
    <div className="modality-selector">
      <div className="modality-title">Current Modality: {currentModality.toUpperCase()}</div>
      <div className="modality-buttons">
        <button 
          className={`modality-btn ${currentModality === 'aerial' ? 'active' : ''}`} 
          onClick={() => handleModalityChange('aerial')}
        >
          Aerial
        </button>
        {/* Other modality buttons */}
      </div>
    </div>
    
    {/* Time controls */}
    <div className="time-controls">
      <button className="time-btn" onClick={() => adjustTimeScale(0.5)}>
        <i className="icon icon-slow"></i>
      </button>
      {/* Other time control buttons */}
      <div className="time-scale">
        <span className="time-label">Speed: </span>
        <span className="time-value">{timeScale}x</span>
      </div>
    </div>
    
    {/* Toggle UI button */}
    <button className="ui-toggle" onClick={toggleUI}>
      <i className="icon icon-ui"></i>
    </button>
  </div>
);
```


### Lifecycle Management {#lifecycle-management}

React lifecycle hooks manage the 3D scene initialization and cleanup:

```javascript
// Initialize on component mount
useEffect(() => {
  if (!containerRef.current) return;
  
  // Initialize Three.js scene, camera, renderer...
  
  // Start animation loop
  const animate = () => {
    // Update physics, animations, etc.
    renderer.render(scene, camera);
    requestAnimationFrame(animate);
  };
  
  animate();
  
  // Clean up on unmount
  return () => {
    // Stop animation loop
    cancelAnimationFrame(animationFrameId);
    
    // Dispose of Three.js resources
    scene.traverse((object) => {
      if (object.geometry) object.geometry.dispose();
      if (object.material) {
        if (Array.isArray(object.material)) {
          object.material.forEach(material => material.dispose());
        } else {
          object.material.dispose();
        }
      }
    });
    
    // Remove renderer from DOM
    containerRef.current.removeChild(renderer.domElement);
    
    // Dispose of renderer
    renderer.dispose();
  };
}, []);

// React to prop changes
useEffect(() => {
  if (scenarioId && !isScenarioLoading) {
    // Load scenario data into the 3D scene
    loadScenarioData(scenario, entities, events);
  }
}, [scenarioId, isScenarioLoading, scenario, entities, events]);
```


## Multi-Modal Simulation {#multi-modal-simulation}

### Modality Switching {#modality-switching}

The system supports seamless switching between different simulation modalities:

```javascript
// Switch to a specific modality
const switchToModality = (modality) => {
  if (!sceneRef.current) return;
  
  // Deactivate all modality managers
  [
    aerialManagerRef.current,
    marineManagerRef.current,
    spaceManagerRef.current,
    landManagerRef.current,
    subsurfaceManagerRef.current,
    pedestrianManagerRef.current,
    robotManagerRef.current
  ].forEach(manager => {
    if (manager) manager.deactivate();
  });
  
  // Activate the selected modality
  switch (modality) {
    case 'aerial':
      if (aerialManagerRef.current) {
        aerialManagerRef.current.activate();
        // Set appropriate camera position for aerial view
        cameraRef.current.position.set(0, 500, 500);
        cameraRef.current.lookAt(0, 0, 0);
      }
      break;
    case 'marine':
      if (marineManagerRef.current) {
        marineManagerRef.current.activate();
        // Set appropriate camera position for marine view
        cameraRef.current.position.set(0, 50, 200);
        cameraRef.current.lookAt(0, 0, 0);
      }
      break;
    // Handle other modalities...
    case 'multimodal':
      // Activate all modality managers in multi-view mode
      [
        aerialManagerRef.current,
        marineManagerRef.current,
        spaceManagerRef.current,
        landManagerRef.current,
        subsurfaceManagerRef.current,
        pedestrianManagerRef.current,
        robotManagerRef.current
      ].forEach(manager => {
        if (manager) manager.activateMultiView();
      });
      // Set appropriate camera position for overview
      cameraRef.current.position.set(0, 1000, 1000);
      cameraRef.current.lookAt(0, 0, 0);
      break;
  }
  
  // Update ambient sound for the modality
  if (spatialAudioRef.current) {
    spatialAudioRef.current.playModalityAmbience(modality);
  }
  
  // Update UI
  setCurrentModality(modality);
};
```


### Cross-Modality Interaction {#cross-modality-interaction}

The system supports interactions across different modalities:

```javascript
// Create cross-modality portal
const createModalityPortal = (sourceModality, targetModality, position) => {
  // Create portal mesh
  const portalGeometry = new THREE.TorusGeometry(5, 0.5, 16, 100);
  const portalMaterial = new THREE.MeshStandardMaterial({
    color: getModalityColor(targetModality),
    emissive: getModalityColor(targetModality),
    emissiveIntensity: 0.5,
    side: THREE.DoubleSide
  });
  
  const portal = new THREE.Mesh(portalGeometry, portalMaterial);
  portal.position.copy(position);
  portal.userData = {
    type: 'portal',
    sourceModality,
    targetModality,
    interactive: true
  };
  
  // Add glow effect
  const glowMaterial = new THREE.ShaderMaterial({
    uniforms: {
      'c': { value: 0.5 },
      'p': { value: 4.0 },
      glowColor: { value: new THREE.Color(getModalityColor(targetModality)) },
      viewVector: { value: new THREE.Vector3() }
    },
    vertexShader: `
      uniform vec3 viewVector;
      uniform float c;
      uniform float p;
      varying float intensity;
      void main() {
        vec3 vNormal = normalize(normal);
        vec3 vNormel = normalize(viewVector);
        intensity = pow(c - dot(vNormal, vNormel), p);
        gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
      }
    `,
    fragmentShader: `
      uniform vec3 glowColor;
      varying float intensity;
      void main() {
        vec3 glow = glowColor * intensity;
        gl_FragColor = vec4(glow, 1.0);
      }
    `,
    side: THREE.BackSide,
    blending: THREE.AdditiveBlending,
    transparent: true
  });
  
  const glowMesh = new THREE.Mesh(
    new THREE.TorusGeometry(5.2, 0.8, 16, 100),
    glowMaterial
  );
  glowMesh.position.copy(position);
  
  // Add portal interaction
  portal.userData.onInteract = () => {
    // Transition to target modality
    switchToModality(targetModality);
    
    // Play portal transition sound
    if (spatialAudioRef.current) {
      spatialAudioRef.current.playSound('modality_change', portal.position, {
        volume: 1.0,
        detune: 200
      });
    }
    
    // Add visual effect for transition
    const flashMaterial = new THREE.MeshBasicMaterial({
      color: getModalityColor(targetModality),
      transparent: true,
      opacity: 0.8
    });
    
    const flashGeometry = new THREE.SphereGeometry(10, 32, 32);
    const flash = new THREE.Mesh(flashGeometry, flashMaterial);
    flash.position.copy(portal.position);
    sceneRef.current.add(flash);
    
    // Animate flash effect
    const startTime = Date.now();
    const flashDuration = 1000; // ms
    
    const animateFlash = () => {
      const elapsed = Date.now() - startTime;
      const t = elapsed / flashDuration;
      
      if (t < 1) {
        flash.scale.set(1 + t * 5, 1 + t * 5, 1 + t * 5);
        flashMaterial.opacity = 0.8 * (1 - t);
        
        requestAnimationFrame(animateFlash);
      } else {
        sceneRef.current.remove(flash);
      }
    };
    
    animateFlash();
  };
  
  // Add to scene
  sceneRef.current.add(portal);
  sceneRef.current.add(glowMesh);
  
  // Animate portal rotation
  const animate = () => {
    portal.rotation.z += 0.005;
    glowMesh.rotation.z += 0.005;
    
    // Update glow effect based on camera position
    const viewVector = new THREE.Vector3().subVectors(
      cameraRef.current.position,
      glowMesh.position
    );
    glowMaterial.uniforms.viewVector.value = viewVector;
    
    requestAnimationFrame(animate);
  };
  
  animate();
  
  return { portal, glowMesh };
};

// Get color for modality
const getModalityColor = (modality) => {
  switch (modality) {
    case 'aerial': return 0x00bfff; // Deep sky blue
    case 'marine': return 0x0077be; // Ocean blue
    case 'space': return 0x9370db; // Medium purple
    case 'land': return 0x228b22; // Forest green
    case 'subsurface': return 0x8b4513; // Saddle brown
    case 'pedestrian': return 0xf4a460; // Sandy brown
    case 'robot': return 0xff4500; // Orange red
    case 'multimodal': return 0xffffff; // White
    default: return 0x00bfff;
  }
};
```


## Troubleshooting {#troubleshooting}

### Common Issues {#common-issues}

#### WebXR Session Initialization Failed

**Problem:** Unable to start WebXR session, error in console: "Failed to create WebXR session"

**Solutions:**
1. Ensure your browser supports WebXR (Chrome 79+, Edge 79+, Firefox with flag)
2. For VR, make sure a compatible headset is connected
3. For AR, ensure your device supports ARCore (Android) or ARKit (iOS)
4. Check the requested features are supported by your device
5. Try with fewer optional features:

```javascript
// Minimal WebXR session request
navigator.xr.requestSession('immersive-vr', {
  optionalFeatures: [] // Start with no optional features
}).then(session => {
  // Session created successfully
}).catch(error => {
  console.error('Failed to create WebXR session:', error);
});
```


#### Performance Issues in VR

**Problem:** Low framerate, stuttering in VR mode

**Solutions:**
1. Reduce scene complexity:
```javascript
// Reduce draw calls
scene.traverse((object) => {
  if (object.isMesh && object.material) {
    // Merge nearby objects with same material
    // or use instanced meshes
  }
});
```


2. Enable foveated rendering if available:
```javascript
if (features.foveatedRendering) {
  renderer.xr.setFoveation(0.9); // Higher value = more aggressive foveation
}
```


3. Optimize lighting by using baked lightmaps instead of real-time lights:
```javascript
// Replace expensive shadows with baked lighting
directionalLight.castShadow = false; // Disable real-time shadows

// Use lightmap texture
const lightMapTexture = new THREE.TextureLoader().load('lightmap.jpg');
material.lightMap = lightMapTexture;
material.lightMapIntensity = 1.0;
```


#### AR Tracking Issues

**Problem:** AR objects drifting or not staying in place

**Solutions:**
1. Use anchors when available:
```javascript
// Create anchor at hit test location
xrSession.requestHitTest(origin, direction)
  .then(results => {
    if (results.length) {
      const hitPose = results[0].getPose(xrReferenceSpace);
      
      // Create anchor
      xrSession.createAnchor(hitPose, xrReferenceSpace)
        .then(anchor => {
          // Attach object to anchor
          const anchorObject = new THREE.Object3D();
          anchorObject.matrix.fromArray(anchor.modelMatrix);
          anchorObject.matrix.decompose(
            anchorObject.position, 
            anchorObject.quaternion, 
            anchorObject.scale
          );
          
          // Add 3D model as child of anchor
          anchorObject.add(yourModel);
          scene.add(anchorObject);
        });
    }
  });
```


2. Improve plane detection by providing visual feedback:
```javascript
// Visualize detected planes
const createPlaneIndicator = (plane) => {
  const geometry = new THREE.PlaneGeometry(1, 1);
  const material = new THREE.MeshBasicMaterial({
    color: 0x00aaff,
    transparent: true,
    opacity: 0.5,
    side: THREE.DoubleSide
  });
  
  const mesh = new THREE.Mesh(geometry, material);
  
  // Update mesh to match plane size and position
  const updatePlaneGeometry = () => {
    if (plane.lastChangedTime > mesh.userData.lastUpdateTime) {
      const planeMatrix = new THREE.Matrix4();
      planeMatrix.fromArray(plane.transform.matrix);
      
      mesh.matrix.copy(planeMatrix);
      mesh.matrix.decompose(mesh.position, mesh.quaternion, mesh.scale);
      
      // Update dimensions
      mesh.scale.x = plane.width;
      mesh.scale.y = plane.height;
      
      mesh.userData.lastUpdateTime = plane.lastChangedTime;
    }
  };
  
  mesh.userData = {
    plane: plane,
    lastUpdateTime: plane.lastChangedTime,
    update: updatePlaneGeometry
  };
  
  return mesh;
};
```


### WebXR Compatibility {#webxr-compatibility}

For ensuring maximum compatibility across devices:

#### Browser Support

| Browser | VR Support | AR Support | Notes |
|---------|------------|------------|-------|
| Chrome 79+ | ✅ | ✅ | Best support for all features |
| Edge 79+ | ✅ | ✅ | Based on Chromium, similar to Chrome |
| Firefox | ✅ | ❌ | VR only, requires flag for WebXR |
| Oculus Browser | ✅ | ❌ | Optimized for Oculus headsets |
| Safari | ❌ | ❌ | No WebXR support, uses WebXR Polyfill |
| Samsung Internet | ✅ | ✅ | Good support on Galaxy devices |

#### Device Compatibility

| Device Category | Examples | Support Level | Notes |
|-----------------|----------|--------------|-------|
| VR Headsets | Meta Quest, Valve Index, HTC Vive | High | Full WebXR support |
| AR Phones | Pixel, Samsung Galaxy S20+ | High | ARCore compatible devices |
| iOS Devices | iPhone, iPad | Medium | Requires WebXR Polyfill |
| Desktop | Windows, Mac, Linux | Low-Medium | Requires VR headset for immersion |

#### Fallbacks

Implement graceful fallbacks for devices without WebXR support:

```javascript
// Check for WebXR support with fallbacks
const initializeXR = async () => {
  // Check for native WebXR
  if (navigator.xr) {
    try {
      const vrSupported = await navigator.xr.isSessionSupported('immersive-vr');
      const arSupported = await navigator.xr.isSessionSupported('immersive-ar');
      
      if (vrSupported || arSupported) {
        // WebXR supported, initialize normally
        initializeWebXR();
        return;
      }
    } catch (e) {
      console.warn('Error checking WebXR support:', e);
    }
  }
  
  // If we get here, WebXR is not supported natively
  // Try loading the WebXR Polyfill
  try {
    await loadScript('https://cdn.jsdelivr.net/npm/webxr-polyfill@latest/build/webxr-polyfill.min.js');
    window.polyfill = new WebXRPolyfill();
    
    // Try again with polyfill
    if (navigator.xr) {
      const vrSupported = await navigator.xr.isSessionSupported('immersive-vr');
      const arSupported = await navigator.xr.isSessionSupported('immersive-ar');
      
      if (vrSupported || arSupported) {
        // WebXR supported via polyfill
        initializeWebXR();
        return;
      }
    }
  } catch (e) {
    console.warn('Error loading WebXR polyfill:', e);
  }
  
  // If still not supported, fall back to non-immersive mode
  initializeNonImmersiveMode();
};

// Helper to load script dynamically
const loadScript = (src) => {
  return new Promise((resolve, reject) => {
    const script = document.createElement('script');
    script.src = src;
    script.onload = resolve;
    script.onerror = reject;
    document.head.appendChild(script);
  });
};
```


## Resources {#resources}

### Documentation {#documentation}

- [Three.js Documentation](https://threejs.org/docs/)
- [WebXR Device API Documentation](https://developer.mozilla.org/en-US/docs/Web/API/WebXR_Device_API)
- [Meta Quest Developer Documentation](https://developer.oculus.com/documentation/)
- [Meteor Documentation](https://docs.meteor.com/)
- [React Documentation](https://reactjs.org/docs/getting-started.html)

### Libraries {#libraries}

- [Three.js](https://threejs.org/) - 3D rendering library
- [WebXR Polyfill](https://github.com/immersive-web/webxr-polyfill) - Fallback for browsers without native WebXR
- [Socket.io](https://socket.io/) - Real-time communication
- [React Three Fiber](https://github.com/pmndrs/react-three-fiber) - React renderer for Three.js
- [Cannon.js](https://schteppe.github.io/cannon.js/) - Physics engine
- [GSAP](https://greensock.com/gsap/) - Animation library

### Tools {#tools}

- [WebXR Emulator Extension](https://github.com/MozillaReality/WebXR-emulator-extension) - Test WebXR without a physical device
- [Lighthouse](https://developers.google.com/web/tools/lighthouse) - Performance testing
- [Chrome DevTools](https://developers.google.com/web/tools/chrome-devtools) - Performance profiling
- [Spector.js](https://spector.babylonjs.com/) - WebGL debugging
- [Three.js Editor](https://threejs.org/editor/) - Visual scene editor
- [Blender](https://www.blender.org/) - 3D modeling software

## Conclusion

The integration of 3D simulation with the IASMS system provides a powerful, immersive environment for training, visualization, and interaction across multiple modalities. By leveraging WebXR, Three.js, and modern web technologies, the system delivers a seamless experience across desktop, mobile, and VR/AR headsets.

The modular architecture ensures easy extension and maintenance, while the comprehensive feature detection system enables the best possible experience on each device. Advanced features such as hand tracking, haptic feedback, and spatial audio create a deeply immersive environment that enhances training effectiveness and user engagement.

For developers looking to extend or customize the system, this documentation provides a comprehensive reference of the implementation details, best practices, and troubleshooting guidance. The included code examples demonstrate how to implement key features and integrate with the broader IASMS ecosystem.