# IASMS Simulation & WebXR Integration Documentation

<div class="container-fluid mt-5">
  <div class="row">
    <div class="col-md-3">
      <!-- Table of Contents -->
      <div class="sticky-top pt-3">
        <div class="card">
          <div class="card-header bg-primary text-white">
            <h4>Contents</h4>
          </div>
          <div class="card-body">
            <nav id="toc" class="nav flex-column">
              <a class="nav-link" href="#introduction">Introduction</a>
              <a class="nav-link" href="#architecture">System Architecture</a>
              <a class="nav-link" href="#setup">Setup & Installation</a>
              <a class="nav-link" href="#threejs">Three.js Integration</a>
              <a class="nav-link" href="#webxr">WebXR Implementation</a>
              <a class="nav-link" href="#mobile">Mobile Support</a>
              <a class="nav-link" href="#meteor">Meteor Integration</a>
              <a class="nav-link" href="#react">React Components</a>
              <a class="nav-link" href="#server">Server Configuration</a>
              <a class="nav-link" href="#api">API Reference</a>
              <a class="nav-link" href="#troubleshooting">Troubleshooting</a>
              <a class="nav-link" href="#resources">Additional Resources</a>
            </nav>
          </div>
        </div>
      </div>
    </div>

    <div class="col-md-9">
      <!-- Main content -->
      <div class="card mb-4">
        <div class="card-header bg-primary text-white">
          <h2 id="introduction">IASMS Simulation & WebXR Integration</h2>
        </div>
        <div class="card-body">
          <p class="lead">
            Welcome to the IASMS Simulation & WebXR Integration documentation. This guide provides comprehensive information about the 3D visualization and simulation components integrated with the Integrated Airspace Safety Management System (IASMS).
          </p>
          
          <div class="alert alert-info">
            <strong>Version:</strong> 1.0.0<br>
            <strong>Last Updated:</strong> September 16, 2025<br>
            <strong>Copyright:</strong> Autonomy Association International Inc. & NASA, all rights reserved
          </div>
          
          <h3>Overview</h3>
          <p>
            The IASMS Simulation module provides interactive 3D visualization and simulation capabilities for airspace monitoring, training, and risk assessment. It integrates with the core IASMS system and extends its functionality with:
          </p>
          
          <ul>
            <li>Real-time 3D visualization of aerial vehicles and hazards</li>
            <li>Immersive training scenarios in VR/AR environments</li>
            <li>Cross-platform support (desktop, mobile, VR headsets)</li>
            <li>Advanced user interaction through WebXR technology</li>
            <li>Seamless integration with existing IASMS data and workflows</li>
          </ul>
          
          <p>
            This documentation covers all aspects of the integration, from setup and installation to advanced topics like WebXR development and performance optimization.
          </p>
        </div>
      </div>

      <div class="card mb-4">
        <div class="card-header bg-primary text-white">
          <h2 id="architecture">System Architecture</h2>
        </div>
        <div class="card-body">
          <h3>Component Overview</h3>
          <p>
            The IASMS Simulation integration is built on a modular architecture that connects to the existing IASMS system while providing new visualization and simulation capabilities.
          </p>
          
          <div class="text-center mb-4">
            <img src="images/iasms-architecture-diagram.png" alt="IASMS Architecture Diagram" class="img-fluid border rounded" style="max-width: 800px;">
            <p class="text-muted mt-2">Simplified architecture diagram of the IASMS Simulation integration</p>
          </div>
          
          <h4>Core Components</h4>
          <table class="table table-bordered">
            <thead class="thead-light">
              <tr>
                <th>Component</th>
                <th>Description</th>
                <th>Files</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>Simulation Module</td>
                <td>Main server-side module that integrates with IASMS core services</td>
                <td><code>/server/iasms/IasmsSimulationTrainingModule.js</code></td>
              </tr>
              <tr>
                <td>Integration Layer</td>
                <td>Initializes and connects the simulation module to IASMS system</td>
                <td><code>/server/iasms/IasmsSimulationIntegration.js</code></td>
              </tr>
              <tr>
                <td>Client Integration</td>
                <td>Client-side wrapper for simulation data and commands</td>
                <td><code>/client/iasms/SimulationIntegrationClient.js</code></td>
              </tr>
              <tr>
                <td>3D Visualization</td>
                <td>Three.js based 3D visualization components</td>
                <td><code>/client/iasms/components/AerialTrafficVisualization.jsx</code></td>
              </tr>
              <tr>
                <td>Dashboard</td>
                <td>User interface for simulation monitoring and control</td>
                <td><code>/client/iasms/components/IAMSVisualizationDashboard.jsx</code></td>
              </tr>
              <tr>
                <td>Training Module</td>
                <td>Scenario-based training functionality</td>
                <td><code>/client/iasms/components/SimulationTrainingModule.jsx</code></td>
              </tr>
              <tr>
                <td>WebXR Support</td>
                <td>VR/AR experience integration</td>
                <td><code>/client/simulator-3-webXR-Meta-react/*</code></td>
              </tr>
            </tbody>
          </table>
          
          <h4>Data Flow</h4>
          <p>
            The system follows these main data flows:
          </p>
          <ol>
            <li>
              <strong>IASMS to Simulation</strong>: Core IASMS modules emit events when vehicle states, hazards, or risks change. The simulation module listens for these events and converts them to 3D entities.
            </li>
            <li>
              <strong>Simulation to Clients</strong>: Entity updates are streamed to connected clients via WebSockets (Meteor's streamer system).
            </li>
            <li>
              <strong>User Interaction</strong>: User actions in the 3D environment are processed and can trigger actions in the IASMS system.
            </li>
            <li>
              <strong>Training Scenarios</strong>: Pre-defined or dynamically generated scenarios provide simulated environments for training.
            </li>
          </ol>
          
          <h4>Integration Points</h4>
          <p>
            The simulation system integrates with the IASMS core at these key points:
          </p>
          <ul>
            <li>Event listeners for vehicle state updates, hazards, and risks</li>
            <li>Shared database collections for persistent data</li>
            <li>API endpoints for external system integration</li>
            <li>User authentication and permission system</li>
            <li>UI integration in the main IASMS application</li>
          </ul>
        </div>
      </div>

      <div class="card mb-4">
        <div class="card-header bg-primary text-white">
          <h2 id="setup">Setup & Installation</h2>
        </div>
        <div class="card-body">
          <h3>Prerequisites</h3>
          <p>
            Before installing the IASMS Simulation module, ensure your system meets these requirements:
          </p>
          
          <table class="table table-bordered">
            <thead class="thead-light">
              <tr>
                <th>Requirement</th>
                <th>Details</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>Node.js</td>
                <td>v16.0.0 or higher</td>
              </tr>
              <tr>
                <td>Meteor</td>
                <td>v2.5.0 or higher</td>
              </tr>
              <tr>
                <td>MongoDB</td>
                <td>v4.4.0 or higher</td>
              </tr>
              <tr>
                <td>Graphics Support</td>
                <td>Hardware with WebGL 2.0 support</td>
              </tr>
              <tr>
                <td>Web Browser</td>
                <td>Latest Chrome, Firefox, Safari, or Edge</td>
              </tr>
              <tr>
                <td>For VR/AR</td>
                <td>Browser with WebXR support</td>
              </tr>
            </tbody>
          </table>
          
          <h3>Installation</h3>
          <p>
            The IASMS Simulation module is part of the main IASMS system. Follow these steps to install and configure it:
          </p>
          
          <div class="code-block">
            <pre><code># Clone the repository
git clone https://github.com/autonomy-association/iasms.git
cd iasms

# Install dependencies
meteor npm install

# Run the setup script for Three.js libraries
bash scripts/ThreeJSWebXRSetupScript.sh

# Create the required directory structure
mkdir -p private/iasms-assets/models
mkdir -p private/draco

# Download initial 3D models
bash scripts/DownloadInitialModels.sh</code></pre>
</div>

          <h3>Automated Setup Script</h3>
          <p>
            The <code>ThreeJSWebXRSetupScript.sh</code> script automates the setup of Three.js and WebXR libraries. It performs the following tasks:
          </p>
          
          <ul>
            <li>Downloads the latest Three.js library</li>
            <li>Extracts necessary WebXR modules</li>
            <li>Sets up the Draco compression decoder</li>
            <li>Creates a WebXR capability detector script</li>
            <li>Generates an import bundle for easy access</li>
          </ul>
          
          <p>
            To run the script with a custom destination directory:
          </p>
          
          <div class="code-block">
            <pre><code>bash scripts/ThreeJSWebXRSetupScript.sh /custom/path/to/three</code></pre>
          </div>
          
          <h3>Configuration</h3>
          <p>
            After installation, configure the simulation module in <code>/server/config/iasms-simulation-config.js</code>. Key configuration options include:
          </p>
          
          <ul>
            <li><strong>Synchronization settings</strong>: Control how often data is synced between IASMS and simulation</li>
            <li><strong>Performance settings</strong>: Configure entity limits and cleanup intervals</li>
            <li><strong>Model settings</strong>: Set paths for 3D models and compression options</li>
            <li><strong>Physics settings</strong>: Adjust simulation physics parameters</li>
            <li><strong>Environment settings</strong>: Configure visual environment properties</li>
            <li><strong>Feature flags</strong>: Enable or disable specific features</li>
            <li><strong>Security settings</strong>: Configure access control and rate limiting</li>
          </ul>
          
          <div class="alert alert-warning">
            <strong>Note:</strong> After changing configuration, restart the server for changes to take effect.
          </div>
        </div>
      </div>

      <div class="card mb-4">
        <div class="card-header bg-primary text-white">
          <h2 id="threejs">Three.js Integration</h2>
        </div>
        <div class="card-body">
          <h3>Overview</h3>
          <p>
            The IASMS Simulation module uses Three.js as its 3D rendering engine. This section covers how Three.js is integrated and how to work with it.
          </p>
          
          <h4>Core Integration</h4>
          <p>
            Three.js is integrated in a modular way that allows for efficient loading and rendering:
          </p>
          
          <ul>
            <li>ES modules are used for importing Three.js components</li>
            <li>Draco compression is supported for model loading</li>
            <li>The renderer is configured for optimal performance on various devices</li>
            <li>Animation loops are properly managed in React components</li>
          </ul>
          
          <h4>Key Components</h4>
          <p>
            The main Three.js components used in the system include:
          </p>
          
          <table class="table table-bordered">
            <thead class="thead-light">
              <tr>
                <th>Component</th>
                <th>Usage</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td><code>Scene</code></td>
                <td>Main container for all 3D objects</td>
              </tr>
              <tr>
                <td><code>PerspectiveCamera</code></td>
                <td>Provides user viewpoint with perspective projection</td>
              </tr>
              <tr>
                <td><code>WebGLRenderer</code></td>
                <td>Renders the scene using WebGL</td>
              </tr>
              <tr>
                <td><code>GLTFLoader</code></td>
                <td>Loads 3D models in GLTF/GLB format</td>
              </tr>
              <tr>
                <td><code>OrbitControls</code></td>
                <td>Provides camera controls for desktop users</td>
              </tr>
              <tr>
                <td><code>Group</code></td>
                <td>Organizes related objects (e.g., vehicle components)</td>
              </tr>
              <tr>
                <td><code>Mesh</code></td>
                <td>Basic 3D objects with geometry and material</td>
              </tr>
              <tr>
                <td><code>Raycaster</code></td>
                <td>Enables selection and interaction with 3D objects</td>
              </tr>
            </tbody>
          </table>
          
          <h3>Vehicle Models</h3>
          <p>
            The system includes procedural models for various vehicle types:
          </p>
          
          <div class="row">
            <div class="col-md-4">
              <div class="card mb-3">
                <div class="card-header">Drone Model</div>
                <div class="card-body text-center">
                  <img src="images/drone-model.png" alt="Drone Model" class="img-fluid" style="max-height: 150px;">
                  <p class="mt-2">Quadcopter with animated rotors</p>
                </div>
              </div>
            </div>
            <div class="col-md-4">
              <div class="card mb-3">
                <div class="card-header">eVTOL Model</div>
                <div class="card-body text-center">
                  <img src="images/evtol-model.png" alt="eVTOL Model" class="img-fluid" style="max-height: 150px;">
                  <p class="mt-2">Electric vertical takeoff & landing vehicle</p>
                </div>
              </div>
            </div>
            <div class="col-md-4">
              <div class="card mb-3">
                <div class="card-header">Aircraft Model</div>
                <div class="card-body text-center">
                  <img src="images/aircraft-model.png" alt="Aircraft Model" class="img-fluid" style="max-height: 150px;">
                  <p class="mt-2">Fixed-wing aircraft with engines</p>
                </div>
              </div>
            </div>
          </div>
          
          <p>
            These models are created procedurally in code, but you can replace them with custom GLTF/GLB models by adding them to the <code>private/iasms-assets/models</code> directory and updating the model paths in the configuration.
          </p>
          
          <h3>Scene Management</h3>
          <p>
            The simulation uses a layered approach to scene management:
          </p>
          
          <ul>
            <li><code>trafficLayer</code>: Contains all vehicle models</li>
            <li><code>hazardsLayer</code>: Contains all hazard visualizations</li>
            <li><code>terrainsLayer</code>: Contains ground and environment elements</li>
          </ul>
          
          <p>
            This layered approach allows for:
          </p>
          
          <ul>
            <li>Efficient updates (only changing what's needed)</li>
            <li>Easy show/hide functionality for different layers</li>
            <li>Batch processing of similar objects</li>
            <li>Simplified selection and interaction logic</li>
          </ul>
          
          <h3>Custom Extensions</h3>
          <p>
            The simulation extends Three.js with custom functionality:
          </p>
          
          <div class="code-block">
            <pre><code>// Example: Extended Object3D for vehicle entities
class VehicleEntity extends THREE.Object3D {
constructor(vehicleData) {
super();
this.vehicleId = vehicleData.id;
this.vehicleType = vehicleData.type;
this.lastUpdate = new Date();
this.status = vehicleData.status || 'ACTIVE';
this.buildModel(vehicleData);
}

// Build the appropriate 3D model
buildModel(data) {
// Implementation details...
}

// Update position, rotation, etc.
updateFromData(data) {
// Implementation details...
}

// Apply animation (e.g., rotor spin)
animate(deltaTime) {
// Implementation details...
}
}</code></pre>
</div>

          <h3>Performance Optimization</h3>
          <p>
            The Three.js integration includes several performance optimizations:
          </p>
          
          <ul>
            <li><strong>Instanced meshes</strong> for repeated objects (traffic cones, trees, etc.)</li>
            <li><strong>Level of detail (LOD)</strong> for complex models at different distances</li>
            <li><strong>Frustum culling</strong> to avoid rendering objects outside the view</li>
            <li><strong>Texture atlasing</strong> to reduce draw calls</li>
            <li><strong>Draco compression</strong> for efficient model loading</li>
            <li><strong>Object pooling</strong> to reduce garbage collection</li>
          </ul>
          
          <div class="alert alert-info">
            <strong>Tip:</strong> Use the built-in performance monitor by pressing <kbd>P</kbd> while in the 3D view.
          </div>
        </div>
      </div>

      <div class="card mb-4">
        <div class="card-header bg-primary text-white">
          <h2 id="webxr">WebXR Implementation</h2>
        </div>
        <div class="card-body">
          <h3>WebXR Overview</h3>
          <p>
            The IASMS Simulation module leverages WebXR to provide immersive experiences on VR and AR devices. This section covers the WebXR implementation details.
          </p>
          
          <h4>Supported Platforms</h4>
          <table class="table table-bordered">
            <thead class="thead-light">
              <tr>
                <th>Platform</th>
                <th>Mode</th>
                <th>Requirements</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>Meta Quest 2/3/Pro</td>
                <td>VR</td>
                <td>Meta Browser or Chrome</td>
              </tr>
              <tr>
                <td>HTC Vive/Valve Index</td>
                <td>VR</td>
                <td>SteamVR + Chrome/Firefox</td>
              </tr>
              <tr>
                <td>Windows Mixed Reality</td>
                <td>VR</td>
                <td>Edge browser</td>
              </tr>
              <tr>
                <td>iOS Devices</td>
                <td>AR</td>
                <td>Safari, iOS 13+</td>
              </tr>
              <tr>
                <td>Android Devices</td>
                <td>AR</td>
                <td>ARCore compatible + Chrome</td>
              </tr>
              <tr>
                <td>Magic Leap 2</td>
                <td>AR</td>
                <td>Magic Leap Browser</td>
              </tr>
            </tbody>
          </table>
          
          <h3>WebXR Features</h3>
          <p>
            The implementation supports the following WebXR features:
          </p>
          
          <div class="row">
            <div class="col-md-6">
              <h4>VR Features</h4>
              <ul class="list-group mb-3">
                <li class="list-group-item">6DoF tracking (head and hands)</li>
                <li class="list-group-item">Controller input with haptic feedback</li>
                <li class="list-group-item">Hand tracking (on supported devices)</li>
                <li class="list-group-item">Teleportation movement</li>
                <li class="list-group-item">Virtual UI panels</li>
                <li class="list-group-item">Eye tracking (Quest Pro, others)</li>
                <li class="list-group-item">Multiplayer presence</li>
              </ul>
            </div>
            <div class="col-md-6">
              <h4>AR Features</h4>
              <ul class="list-group mb-3">
                <li class="list-group-item">Surface detection and anchoring</li>
                <li class="list-group-item">Image tracking for markers</li>
                <li class="list-group-item">World scale adjustment</li>
                <li class="list-group-item">Lighting estimation</li>
                <li class="list-group-item">Depth sensing (on supported devices)</li>
                <li class="list-group-item">Persistent anchors</li>
                <li class="list-group-item">User interface integration</li>
              </ul>
            </div>
          </div>
          
          <h3>Implementation Details</h3>
          <p>
            The WebXR implementation follows these key patterns:
          </p>
          
          <h4>Session Initialization</h4>
          <div class="code-block">
            <pre><code>// Example: Initialize WebXR session
async function initWebXR() {
// Check for WebXR support
if (!navigator.xr) {
console.error('WebXR not supported');
return false;
}

// Check for immersive-vr session support
const vrSupported = await navigator.xr.isSessionSupported('immersive-vr');
const arSupported = await navigator.xr.isSessionSupported('immersive-ar');

if (!vrSupported && !arSupported) {
console.error('Neither VR nor AR is supported');
return false;
}

// Create session initialization settings
const sessionInit = {
optionalFeatures: [
'hand-tracking',
'local-floor',
'hit-test',
'dom-overlay'
]
};

if (arSupported) {
sessionInit.domOverlay = { root: document.getElementById('ar-overlay') };
}

// Request session
try {
const mode = vrSupported ? 'immersive-vr' : 'immersive-ar';
const session = await navigator.xr.requestSession(mode, sessionInit);

    // Configure renderer
    renderer.xr.enabled = true;
    renderer.xr.setReferenceSpaceType('local-floor');
    renderer.xr.setSession(session);
    
    // Set up controllers
    setupControllers(session);
    
    // Add session end event listener
    session.addEventListener('end', onSessionEnded);
    
    return true;
} catch (error) {
console.error('Error starting WebXR session:', error);
return false;
}
}</code></pre>
</div>

          <h4>Controller Setup</h4>
          <div class="code-block">
            <pre><code>// Example: Set up VR controllers
function setupControllers(session) {
// Function to set up controller
function setupController(inputSource, index) {
// Create controller object
const controller = renderer.xr.getController(index);
scene.add(controller);

    // Load controller model
    const controllerModelFactory = new XRControllerModelFactory();
    const controllerGrip = renderer.xr.getControllerGrip(index);
    const model = controllerModelFactory.createControllerModel(controllerGrip);
    controllerGrip.add(model);
    scene.add(controllerGrip);
    
    // Add event listeners
    controller.addEventListener('selectstart', onSelectStart);
    controller.addEventListener('selectend', onSelectEnd);
    
    // Store inputSource for haptics
    controller.userData.inputSource = inputSource;
    
    return controller;
}

// Listen for connected input sources
session.addEventListener('inputsourceschange', (event) => {
// Handle added input sources
event.added.forEach((inputSource, i) => {
if (inputSource.targetRayMode === 'tracked-pointer') {
const index = controllers.length;
const controller = setupController(inputSource, index);
controllers.push(controller);
}
});

    // Handle removed input sources
    event.removed.forEach((inputSource) => {
      const index = controllers.findIndex(c => 
        c.userData.inputSource === inputSource);
      if (index !== -1) {
        const controller = controllers[index];
        scene.remove(controller);
        controllers.splice(index, 1);
      }
    });
});
}</code></pre>
</div>

          <h3>Hand Tracking</h3>
          <p>
            The simulation supports hand tracking on devices like Meta Quest:
          </p>
          
          <div class="code-block">
            <pre><code>// Example: Set up hand tracking
function setupHandTracking(session) {
// Create hand objects
const handModelFactory = new XRHandModelFactory();

// Left hand
const leftHand = renderer.xr.getHand(0);
leftHand.add(handModelFactory.createHandModel(leftHand, 'mesh'));
scene.add(leftHand);

// Right hand
const rightHand = renderer.xr.getHand(1);
rightHand.add(handModelFactory.createHandModel(rightHand, 'mesh'));
scene.add(rightHand);

// Set up pinch gesture detection
const pinchGestureDetector = new PinchGestureDetector();
leftHand.userData.gestures = { pinch: new PinchState() };
rightHand.userData.gestures = { pinch: new PinchState() };

// Update gesture state each frame
function updateHandGestures() {
pinchGestureDetector.update(leftHand);
pinchGestureDetector.update(rightHand);
}

return { leftHand, rightHand, updateHandGestures };
}</code></pre>
</div>

          <h3>Eye Tracking</h3>
          <p>
            The system supports eye tracking for gaze-based interaction on compatible devices like the Meta Quest Pro:
          </p>
          
          <div class="code-block">
            <pre><code>// Example: Using EyeTrackingSystem
import { EyeTrackingSystem } from './EyeTrackingSystem';

// Initialize eye tracking
const eyeTracking = new EyeTrackingSystem(xrSession, camera);
await eyeTracking.initialize();

// In animation loop
function onXRFrame(time, frame) {
// Update eye tracking
const gazeData = eyeTracking.update(frame);

if (gazeData && gazeData.looking) {
// Use gaze direction for interaction
raycaster.set(gazeData.origin, gazeData.direction);
const intersects = raycaster.intersectObjects(interactiveObjects);

    if (intersects.length > 0) {
      const gazedObject = intersects[0].object;
      // Handle gaze interaction...
    }
}
}</code></pre>
</div>

          <h3>Haptic Feedback</h3>
          <p>
            The system provides haptic feedback for controller interactions:
          </p>
          
          <div class="code-block">
            <pre><code>// Example: Haptic feedback function
function triggerHapticFeedback(controller, intensity = 1.0, duration = 100) {
const inputSource = controller.userData.inputSource;

if (inputSource && inputSource.gamepad) {
const gamepad = inputSource.gamepad;

    if (gamepad.hapticActuators && gamepad.hapticActuators.length > 0) {
      // Use standard haptic API
      gamepad.hapticActuators[0].pulse(intensity, duration);
    } else if ('vibrate' in gamepad) {
      // Fallback for older API
      gamepad.vibrate(duration);
    }
}
}</code></pre>
</div>

          <h3>Meta Quest Optimizations</h3>
          <p>
            The system includes specific optimizations for Meta Quest headsets:
          </p>
          
          <ul>
            <li><strong>Foveated Rendering</strong>: Uses less detail in peripheral vision to improve performance</li>
            <li><strong>Dynamic Resolution Scaling</strong>: Adjusts render resolution based on GPU load</li>
            <li><strong>Hand Tracking Optimizations</strong>: Efficient hand pose processing</li>
            <li><strong>Scene Complexity Management</strong>: Reduces detail based on device capability</li>
          </ul>
          
          <div class="alert alert-info">
            <strong>Note:</strong> For detailed Meta Quest setup and optimization, see the <a href="#meta-quest">Meta Quest section</a> below.
          </div>
          
          <h3 id="meta-quest">Meta Quest Setup</h3>
          <p>
            To optimize the experience on Meta Quest devices:
          </p>
          
          <ol>
            <li>
              <strong>Enable Developer Mode</strong> on your Quest headset through the Meta/Oculus app.
            </li>
            <li>
              <strong>Use a local development server</strong> with HTTPS or enable insecure localhost in Chrome flags:
              <ul>
                <li>In the Meta Browser, go to <code>chrome://flags</code></li>
                <li>Enable "Insecure origins treated as secure"</li>
                <li>Add your development server URL</li>
                <li>Restart the browser</li>
              </ul>
            </li>
            <li>
              <strong>Set up WebXR debugging</strong> with the Meta Quest Developer Hub.
            </li>
            <li>
              <strong>Configure performance settings</strong> in the simulation configuration.
            </li>
          </ol>
          
          <div class="alert alert-warning">
            <strong>Warning:</strong> Insecure origins should only be used for development. Production deployments should always use HTTPS.
          </div>
        </div>
      </div>

      <div class="card mb-4">
        <div class="card-header bg-primary text-white">
          <h2 id="mobile">Mobile Support</h2>
        </div>
        <div class="card-body">
          <h3>Mobile Browsers</h3>
          <p>
            The IASMS Simulation module supports mobile devices through responsive design and optimization:
          </p>
          
          <h4>Supported Mobile Platforms</h4>
          <table class="table table-bordered">
            <thead class="thead-light">
              <tr>
                <th>Platform</th>
                <th>Browser</th>
                <th>Features</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>iOS (iPhone/iPad)</td>
                <td>Safari</td>
                <td>3D Visualization, AR (iOS 13+)</td>
              </tr>
              <tr>
                <td>Android</td>
                <td>Chrome</td>
                <td>3D Visualization, AR (with ARCore)</td>
              </tr>
              <tr>
                <td>iPadOS</td>
                <td>Safari</td>
                <td>3D Visualization, AR, Apple Pencil support</td>
              </tr>
            </tbody>
          </table>
          
          <h3>Mobile Optimizations</h3>
          <p>
            The following optimizations are applied for mobile devices:
          </p>
          
          <ul>
            <li><strong>Automatic Device Detection</strong>: Adapts rendering quality based on device capability</li>
            <li><strong>Touch Controls</strong>: Custom touch interface for navigation and interaction</li>
            <li><strong>Reduced Polygon Counts</strong>: Simplified models for mobile GPUs</li>
            <li><strong>Texture Compression</strong>: Uses WebP or compressed textures when available</li>
            <li><strong>Deferred Loading</strong>: Loads detailed models only when needed</li>
            <li><strong>Battery Awareness</strong>: Reduces quality when battery is low</li>
          </ul>
          
          <h3>Mobile Touch Controls</h3>
          <p>
            The mobile interface includes touch-optimized controls:
          </p>
          
          <div class="row mb-4">
            <div class="col-md-6">
              <div class="card">
                <div class="card-header">Navigation Gestures</div>
                <div class="card-body">
                  <ul>
                    <li><strong>One-finger drag</strong>: Rotate camera</li>
                    <li><strong>Two-finger pinch</strong>: Zoom in/out</li>
                    <li><strong>Two-finger drag</strong>: Pan camera</li>
                    <li><strong>Double tap</strong>: Reset view</li>
                    <li><strong>Tap</strong>: Select object</li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="col-md-6">
              <div class="card">
                <div class="card-header">UI Adaptations</div>
                <div class="card-body">
                  <ul>
                    <li><strong>Larger touch targets</strong> for buttons and controls</li>
                    <li><strong>Collapsible panels</strong> to maximize viewing area</li>
                    <li><strong>Bottom-oriented menus</strong> for easier thumb access</li>
                    <li><strong>Reduced information density</strong> for readability</li>
                    <li><strong>Progressive disclosure</strong> of complex controls</li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
          
          <h3>Mobile AR Support</h3>
          <p>
            For devices that support WebXR AR mode, the system provides additional features:
          </p>
          
          <div class="code-block">
            <pre><code>// Example: AR session initialization for mobile
async function initMobileAR() {
// Check for AR support
if (!navigator.xr || !await navigator.xr.isSessionSupported('immersive-ar')) {
return false;
}

// Configure AR session
const sessionInit = {
requiredFeatures: ['hit-test'],
optionalFeatures: ['dom-overlay', 'light-estimation'],
};

// Add DOM overlay for UI
sessionInit.domOverlay = { root: document.getElementById('ar-overlay') };

try {
// Request AR session
const session = await navigator.xr.requestSession('immersive-ar', sessionInit);

    // Configure renderer
    renderer.xr.enabled = true;
    renderer.xr.setReferenceSpaceType('local');
    renderer.xr.setSession(session);
    
    // Set up hit testing for surface detection
    session.requestReferenceSpace('viewer').then((viewerSpace) => {
      session.requestHitTestSource({ space: viewerSpace }).then((source) => {
        hitTestSource = source;
      });
    });
    
    // Handle AR session frames
    session.addEventListener('end', onARSessionEnded);
    
    return true;
} catch (error) {
console.error('Error starting AR session:', error);
return false;
}
}</code></pre>
</div>

          <h3>Progressive Web App</h3>
          <p>
            The IASMS Simulation is also available as a Progressive Web App (PWA) for mobile devices:
          </p>
          
          <ul>
            <li><strong>Offline Support</strong>: Basic functionality works without internet</li>
            <li><strong>Home Screen Installation</strong>: Can be added to device home screen</li>
            <li><strong>Push Notifications</strong>: Alerts for critical events (with permission)</li>
            <li><strong>Responsive Design</strong>: Adapts to different screen sizes</li>
            <li><strong>Fast Loading</strong>: Uses service workers for caching</li>
          </ul>
          
          <p>
            To install as a PWA:
          </p>
          
          <ol>
            <li>Open the IASMS application in a supported mobile browser</li>
            <li>For iOS: Tap the Share button, then "Add to Home Screen"</li>
            <li>For Android: Tap the menu button, then "Install App" or "Add to Home Screen"</li>
          </ol>
          
          <div class="alert alert-info">
            <strong>Note:</strong> For best performance in AR mode, use the device in a well-lit environment with distinct visual features.
          </div>
        </div>
      </div>

      <div class="card mb-4">
        <div class="card-header bg-primary text-white">
          <h2 id="meteor">Meteor Integration</h2>
        </div>
        <div class="card-body">
          <h3>Meteor Framework Integration</h3>
          <p>
            The IASMS Simulation module integrates with the Meteor framework for real-time data synchronization and user management.
          </p>
          
          <h4>Publications and Subscriptions</h4>
          <p>
            Data is provided to clients through Meteor publications:
          </p>
          
          <div class="code-block">
            <pre><code>// Server: Publications (in IasmsSimulationPublications.js)
Meteor.publish('iasms.activeSimulationSessions', function() {
// Only publish sessions for authenticated users
if (!this.userId) {
return this.ready();
}

// Get user's role
const user = Meteor.users.findOne(this.userId);
const isAdmin = user && user.roles &&
(user.roles.includes('admin') || user.roles.includes('trainer'));

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

// Client: Subscription
const { sessions, loading } = useTracker(() => {
const handle = Meteor.subscribe('iasms.activeSimulationSessions');

return {
sessions: IasmsSimulationSessions.find(
{ status: { $in: ['ACTIVE', 'PAUSED'] } },
{ sort: { startTime: -1 } }
).fetch(),
loading: !handle.ready()
};
}, []);</code></pre>
</div>

          <h4>Meteor Methods</h4>
          <p>
            The system uses Meteor methods for server-side operations:
          </p>
          
          <div class="code-block">
            <pre><code>// Server: Methods (in IasmsSimulationMethods.js)
Meteor.methods({
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
      throw new Meteor.Error('service-unavailable', 
        'Simulation module is not available');
    }
    
    return simulationModule.createSimulationSession({
      userId: this.userId,
      ...options
    });
}
});

// Client: Method call
Meteor.call('iasms.createSimulationSession', {
name: 'New Training Session',
scenarioId: selectedScenario._id,
syncWithRealWorld: true
}, (error, sessionId) => {
if (error) {
console.error('Error creating session:', error);
setError(error.reason || 'Failed to create session');
} else {
setActiveSession(sessionId);
setActiveTab('simulation');
}
});</code></pre>
</div>

          <h4>Real-time Updates with Streamer</h4>
          <p>
            For high-frequency updates (like entity positions), the system uses Meteor's streamer package instead of standard publications:
          </p>
          
          <div class="code-block">
            <pre><code>// Server: Create streamer
import { Streamer } from 'meteor/rocketchat:streamer';
const simulationStreamer = new Streamer('iasms-simulation');

// Server: Publish updates
simulationStreamer.emit(`session_${sessionId}`, {
type: 'entity_updates',
sessionId,
timestamp: new Date(),
updates
});

// Client: Subscribe to updates
const streamer = new Streamer('iasms-simulation');
streamer.on(`session_${sessionId}`, this._handleSessionUpdate.bind(this));</code></pre>
</div>

          <h3>MongoDB Integration</h3>
          <p>
            The simulation data is stored in MongoDB collections:
          </p>
          
          <table class="table table-bordered">
            <thead class="thead-light">
              <tr>
                <th>Collection</th>
                <th>Purpose</th>
                <th>Key Fields</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td><code>IasmsSimulationScenarios</code></td>
                <td>Stores training scenarios</td>
                <td>name, category, difficulty, entities, events</td>
              </tr>
              <tr>
                <td><code>IasmsSimulationSessions</code></td>
                <td>Tracks active simulation sessions</td>
                <td>userId, scenarioId, status, startTime, entities</td>
              </tr>
              <tr>
                <td><code>IasmsTrainingRecords</code></td>
                <td>Stores training completion records</td>
                <td>userId, sessionId, completionDate, score, passed</td>
              </tr>
              <tr>
                <td><code>IasmsTelemetry</code></td>
                <td>Records detailed simulation data</td>
                <td>sessionId, timestamp, entityId, position, rotation</td>
              </tr>
              <tr>
                <td><code>IasmsLogs</code></td>
                <td>Stores simulation-specific logs</td>
                <td>timestamp, level, module, message, data</td>
              </tr>
              <tr>
                <td><code>IasmsUserSettings</code></td>
                <td>Stores user preferences for simulation</td>
                <td>userId, visualization, notifications, preferences</td>
              </tr>
            </tbody>
          </table>
          
          <h3>Authentication and Authorization</h3>
          <p>
            The simulation uses Meteor's built-in authentication system with role-based access control:
          </p>
          
          <div class="code-block">
            <pre><code>// Role definitions
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

// Permission check function
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
};</code></pre>
</div>

          <h3>WebApp Integration</h3>
          <p>
            The system uses Meteor's WebApp package to serve static assets and API endpoints:
          </p>
          
          <div class="code-block">
            <pre><code>// Set up route for serving 3D models and textures
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
});</code></pre>
</div>
</div>
</div>

      <div class="card mb-4">
        <div class="card-header bg-primary text-white">
          <h2 id="react">React Components</h2>
        </div>
        <div class="card-body">
          <h3>React Integration Overview</h3>
          <p>
            The IASMS Simulation module uses React for its user interface components. This section covers the key React components and their interactions.
          </p>
          
          <h4>Component Hierarchy</h4>
          <p>
            The main components are organized as follows:
          </p>
          
          <pre class="mb-4">
IAMSIntegratedSimulation
├── IAMSVisualizationDashboard
│   └── AerialTrafficVisualization
└── SimulationTrainingModule
└── Simulation3DViewer
</pre>

          <h3>Key Components</h3>
          
          <div class="accordion" id="componentsAccordion">
            <div class="card">
              <div class="card-header" id="headingOne">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                    IAMSIntegratedSimulation
                  </button>
                </h2>
              </div>
              <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#componentsAccordion">
                <div class="card-body">
                  <p>
                    The main container component that manages mode selection between the visualization dashboard and training module.
                  </p>
                  <ul>
                    <li><strong>File:</strong> <code>/client/iasms/components/IAMSIntegratedSimulation.jsx</code></li>
                    <li><strong>State:</strong> activeMode, isInitialized, error</li>
                    <li><strong>Props:</strong> None</li>
                    <li><strong>Description:</strong> This component initializes the simulation integration client and provides a switcher between visualization and training modes.</li>
                  </ul>
                </div>
              </div>
            </div>
            
            <div class="card">
              <div class="card-header" id="headingTwo">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                    IAMSVisualizationDashboard
                  </button>
                </h2>
              </div>
              <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#componentsAccordion">
                <div class="card-body">
                  <p>
                    Provides a dashboard for real-time visualization of aerial traffic and hazards.
                  </p>
                  <ul>
                    <li><strong>File:</strong> <code>/client/iasms/components/IAMSVisualizationDashboard.jsx</code></li>
                    <li><strong>State:</strong> activeTab, selectedVehicleId, selectedVehicle, selectedHazardId, selectedHazard, activeSession, showSidebar</li>
                    <li><strong>Props:</strong> None</li>
                    <li><strong>Description:</strong> Dashboard component that integrates 3D visualization with detailed information panels for vehicles and hazards.</li>
                  </ul>
                </div>
              </div>
            </div>
            
            <div class="card">
              <div class="card-header" id="headingThree">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                    AerialTrafficVisualization
                  </button>
                </h2>
              </div>
              <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#componentsAccordion">
                <div class="card-body">
                  <p>
                    Three.js-based 3D visualization component for aerial vehicles.
                  </p>
                  <ul>
                    <li><strong>File:</strong> <code>/client/iasms/components/AerialTrafficVisualization.jsx</code></li>
                    <li><strong>State:</strong> isInitialized, isLoading, error, entities</li>
                    <li><strong>Props:</strong> sessionId, width, height, onVehicleSelected, selectedVehicleId</li>
                    <li><strong>Description:</strong> This component creates and manages the Three.js scene for visualizing aerial traffic and hazards.</li>
                  </ul>
                  <p>
                    <strong>Key functionality:</strong>
                  </p>
                  <ul>
                    <li>Initializes Three.js scene, camera, and renderer</li>
                    <li>Creates and updates vehicle models</li>
                    <li>Visualizes hazards and risks</li>
                    <li>Handles user interaction (selection, camera controls)</li>
                    <li>Processes entity updates from the simulation</li>
                  </ul>
                </div>
              </div>
            </div>
            
            <div class="card">
              <div class="card-header" id="headingFour">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
                    SimulationTrainingModule
                  </button>
                </h2>
              </div>
              <div id="collapseFour" class="collapse" aria-labelledby="headingFour" data-parent="#componentsAccordion">
                <div class="card-body">
                  <p>
                    Provides training scenarios and simulation sessions.
                  </p>
                  <ul>
                    <li><strong>File:</strong> <code>/client/iasms/components/SimulationTrainingModule.jsx</code></li>
                    <li><strong>State:</strong> activeTab, selectedScenario, activeSession, loading, error</li>
                    <li><strong>Props:</strong> onClose</li>
                    <li><strong>Description:</strong> This component allows users to select and run training scenarios or join existing simulation sessions.</li>
                  </ul>
                </div>
              </div>
            </div>
            
            <div class="card">
              <div class="card-header" id="headingFive">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseFive" aria-expanded="false" aria-controls="collapseFive">
                    Simulation3DViewer
                  </button>
                </h2>
              </div>
              <div id="collapseFive" class="collapse" aria-labelledby="headingFive" data-parent="#componentsAccordion">
                <div class="card-body">
                  <p>
                    Three.js-based 3D viewer for simulation sessions.
                  </p>
                  <ul>
                    <li><strong>File:</strong> <code>/client/iasms/components/Simulation3DViewer.jsx</code></li>
                    <li><strong>State:</strong> isInitialized, entities, session, status</li>
                    <li><strong>Props:</strong> sessionId, width, height</li>
                    <li><strong>Description:</strong> This component renders the 3D view for training scenarios and integrates with the AerialModalityManager.</li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
          
          <h3>React Hooks Usage</h3>
          <p>
            The components make extensive use of React hooks:
          </p>
          
          <div class="code-block">
            <pre><code>// Example: Component with hooks
const AerialTrafficVisualization = ({
sessionId,
width = '100%',
height = '500px',
onVehicleSelected,
selectedVehicleId
}) => {
// Refs for Three.js objects
const containerRef = useRef(null);
const rendererRef = useRef(null);
const sceneRef = useRef(null);
const cameraRef = useRef(null);

// Component state
const [isInitialized, setIsInitialized] = useState(false);
const [isLoading, setIsLoading] = useState(true);
const [error, setError] = useState(null);
const [entities, setEntities] = useState({});

// Initialize Three.js scene
useEffect(() => {
if (!containerRef.current) return;

    // Scene initialization code...
    
    return () => {
      // Cleanup code...
    };
}, []);

// Connect to session when ready and sessionId changes
useEffect(() => {
if (!isInitialized || !sessionId) return;

    let entityUpdateId = -1;
    
    const connectToSession = async () => {
      // Session connection code...
    };
    
    connectToSession();
    
    return () => {
      // Cleanup code...
    };
}, [isInitialized, sessionId]);

// Meteor data integration using useTracker
const { vehicles, loading } = useTracker(() => {
const handle = Meteor.subscribe('iasms.activeVehicles');

    return {
      vehicles: IasmsVehicleStates.find().fetch(),
      loading: !handle.ready()
    };
}, []);

// JSX rendering...
};</code></pre>
</div>

          <h3>Reactive Data with useTracker</h3>
          <p>
            The components use Meteor's <code>useTracker</code> hook to access reactive data sources:
          </p>
          
          <div class="code-block">
            <pre><code>// Example: useTracker for reactive data
const { sessions, sessionsLoading } = useTracker(() => {
const handle = Meteor.subscribe('iasms.activeSimulationSessions');

return {
sessions: IasmsSimulationSessions.find(
{ status: { $in: ['ACTIVE', 'PAUSED'] } },
{ sort: { startTime: -1 } }
).fetch(),
sessionsLoading: !handle.ready()
};
}, []);</code></pre>
</div>

          <h3>Component Communication</h3>
          <p>
            Components communicate through props, context, and events:
          </p>
          
          <table class="table table-bordered">
            <thead class="thead-light">
              <tr>
                <th>Method</th>
                <th>Usage</th>
                <th>Example</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>Props</td>
                <td>Direct parent-to-child communication</td>
                <td><code>onVehicleSelected</code>, <code>selectedVehicleId</code></td>
              </tr>
              <tr>
                <td>Callback Props</td>
                <td>Child-to-parent communication</td>
                <td><code>onVehicleSelected={handleVehicleSelected}</code></td>
              </tr>
              <tr>
                <td>Streamer Events</td>
                <td>Server-to-client real-time updates</td>
                <td><code>streamer.on(channel, callback)</code></td>
              </tr>
              <tr>
                <td>Integration Client</td>
                <td>Shared state and methods</td>
                <td><code>SimulationIntegration.addEntity()</code></td>
              </tr>
            </tbody>
          </table>
          
          <h3>React Performance Optimizations</h3>
          <p>
            The React components include several performance optimizations:
          </p>
          
          <ul>
            <li><strong>Component Memoization</strong>: Using <code>React.memo</code> for complex components</li>
            <li><strong>useCallback</strong>: For stable callback references</li>
            <li><strong>useMemo</strong>: For expensive calculations</li>
            <li><strong>Virtualization</strong>: For long lists of entities</li>
            <li><strong>Optimized Rendering Cycles</strong>: Avoiding unnecessary re-renders</li>
            <li><strong>Code Splitting</strong>: For loading components on demand</li>
          </ul>
          
          <div class="code-block">
            <pre><code>// Example: Memoized component with optimized callbacks
const VehicleItem = React.memo(({ vehicle, isSelected, onSelect }) => {
return (
<div
className={`vehicle-item ${isSelected ? 'selected' : ''}`}
onClick={() => onSelect(vehicle.vehicleId)}
>
<div className="vehicle-icon">{getVehicleIcon(vehicle.type)}</div>
<div className="vehicle-info">
<div className="vehicle-name">{vehicle.callsign || vehicle.vehicleId}</div>
<div className="vehicle-type">{vehicle.type}</div>
</div>
</div>
);
});

// In parent component
const handleVehicleSelect = useCallback((vehicleId) => {
setSelectedVehicleId(vehicleId);
}, []);</code></pre>
</div>
</div>
</div>

      <div class="card mb-4">
        <div class="card-header bg-primary text-white">
          <h2 id="server">Server Configuration</h2>
        </div>
        <div class="card-body">
          <h3>Server Components</h3>
          <p>
            The server-side implementation includes several key components:
          </p>
          
          <table class="table table-bordered">
            <thead class="thead-light">
              <tr>
                <th>Component</th>
                <th>File</th>
                <th>Purpose</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>Simulation Module</td>
                <td><code>/server/iasms/IasmsSimulationTrainingModule.js</code></td>
                <td>Core simulation functionality</td>
              </tr>
              <tr>
                <td>Integration Layer</td>
                <td><code>/server/iasms/IasmsSimulationIntegration.js</code></td>
                <td>Connects simulation to IASMS</td>
              </tr>
              <tr>
                <td>Publications</td>
                <td><code>/server/IasmsSimulationPublications.js</code></td>
                <td>Data subscriptions for clients</td>
              </tr>
              <tr>
                <td>Methods</td>
                <td><code>/server/IasmsSimulationMethods.js</code></td>
                <td>RPC endpoints for clients</td>
              </tr>
              <tr>
                <td>Static Assets</td>
                <td><code>/server/IasmsStaticAssets.js</code></td>
                <td>Serves 3D models and textures</td>
              </tr>
              <tr>
                <td>API Endpoints</td>
                <td><code>/server/IasmsAPIEndpoints.js</code></td>
                <td>REST API for external systems</td>
              </tr>
              <tr>
                <td>Roles & Permissions</td>
                <td><code>/server/utils/IasmsSimulationRoles.js</code></td>
                <td>Access control management</td>
              </tr>
              <tr>
                <td>Logger</td>
                <td><code>/server/utils/IasmsSimulationLogger.js</code></td>
                <td>Logging functionality</td>
              </tr>
              <tr>
                <td>Configuration</td>
                <td><code>/server/config/iasms-simulation-config.js</code></td>
                <td>System configuration</td>
              </tr>
              <tr>
                <td>Data Cleanup</td>
                <td><code>/server/utils/IasmsSimulationCleanup.js</code></td>
                <td>Database maintenance</td>
              </tr>
              <tr>
                <td>Collections</td>
                <td><code>/server/IasmsSimulationCollections.js</code></td>
                <td>MongoDB collection definitions</td>
              </tr>
            </tbody>
          </table>
          
          <h3>Configuration Options</h3>
          <p>
            The simulation system is configured through <code>/server/config/iasms-simulation-config.js</code>:
          </p>
          
          <div class="code-block">
            <pre><code>export const IasmsSimulationConfig = {
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
};</code></pre>
</div>

          <h3>Database Indexes</h3>
          <p>
            The system creates appropriate indexes for performance optimization:
          </p>
          
          <div class="code-block">
            <pre><code>// Create indexes if running on server
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
    
    // Simulation sessions indexes
    IasmsSimulationSessions._ensureIndex({ userId: 1 });
    IasmsSimulationSessions._ensureIndex({ status: 1 });
    IasmsSimulationSessions._ensureIndex({ startTime: -1 });
    
    // Scenarios indexes
    IasmsSimulationScenarios._ensureIndex({ name: 1 });
    IasmsSimulationScenarios._ensureIndex({ category: 1 });
    
    // Training records indexes
    IasmsTrainingRecords._ensureIndex({ userId: 1 });
    IasmsTrainingRecords._ensureIndex({ sessionId: 1 });
    IasmsTrainingRecords._ensureIndex({ completionDate: -1 });
});
}</code></pre>
</div>

          <h3>Logging System</h3>
          <p>
            The system includes a dedicated logging facility:
          </p>
          
          <div class="code-block">
            <pre><code>// Example usage of the logger
import logger from './utils/IasmsSimulationLogger';

// In your code
logger.info('Initializing simulation module');
logger.debug('Processing entity update', { entityId, type: 'vehicle', position });
logger.warn('Performance degradation detected', { fps: currentFps, entityCount });
logger.error('Failed to connect to external service', { service: 'weather-api', error });</code></pre>
</div>

          <h3>Server Initialization</h3>
          <p>
            The server initializes the simulation components at startup:
          </p>
          
          <div class="code-block">
            <pre><code>Meteor.startup(() => {
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
});</code></pre>
</div>

          <h3>Data Cleanup</h3>
          <p>
            The system automatically cleans up old data to prevent database growth:
          </p>
          
          <div class="code-block">
            <pre><code>// Example: Telemetry cleanup
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
}</code></pre>
</div>
</div>
</div>

      <div class="card mb-4">
        <div class="card-header bg-primary text-white">
          <h2 id="api">API Reference</h2>
        </div>
        <div class="card-body">
          <h3>REST API Endpoints</h3>
          <p>
            The system provides REST API endpoints for external integration:
          </p>
          
          <table class="table table-bordered">
            <thead class="thead-light">
              <tr>
                <th>Endpoint</th>
                <th>Method</th>
                <th>Description</th>
                <th>Auth Required</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td><code>/api/iasms/health</code></td>
                <td>GET</td>
                <td>Health check endpoint</td>
                <td>No</td>
              </tr>
              <tr>
                <td><code>/api/iasms/vehicles</code></td>
                <td>GET</td>
                <td>Get active vehicles</td>
                <td>Yes</td>
              </tr>
              <tr>
                <td><code>/api/iasms/hazards</code></td>
                <td>GET</td>
                <td>Get active hazards</td>
                <td>Yes</td>
              </tr>
              <tr>
                <td><code>/api/iasms/simulations</code></td>
                <td>GET</td>
                <td>Get active simulation sessions</td>
                <td>Yes</td>
              </tr>
              <tr>
                <td><code>/api/iasms/simulations</code></td>
                <td>POST</td>
                <td>Create simulation session</td>
                <td>Yes</td>
              </tr>
              <tr>
                <td><code>/api/iasms/simulations/:sessionId/entities</code></td>
                <td>POST</td>
                <td>Add entity to simulation</td>
                <td>Yes</td>
              </tr>
            </tbody>
          </table>
          
          <h4>Authentication</h4>
          <p>
            The API supports two authentication methods:
          </p>
          
          <ol>
            <li>
              <strong>API Key</strong>: Include the API key in the <code>X-API-Key</code> header:
              <div class="code-block">
                <pre><code>X-API-Key: api_key_value</code></pre>
              </div>
            </li>
            <li>
              <strong>JWT Token</strong>: Include the JWT token in the <code>Authorization</code> header:
              <div class="code-block">
                <pre><code>Authorization: Bearer jwt_token_value</code></pre>
              </div>
            </li>
          </ol>
          
          <h4>Example Requests</h4>
          
          <div class="card mb-3">
            <div class="card-header">Get Active Vehicles</div>
            <div class="card-body">
              <div class="code-block">
                <pre><code>curl -X GET \
https://iasms.example.com/api/iasms/vehicles \
-H 'X-API-Key: your_api_key'</code></pre>
</div>

              <p>Response:</p>
              
              <div class="code-block">
                <pre><code>{
"vehicles": [
{
"_id": "abc123",
"vehicleId": "drone-001",
"vehicleType": "drone",
"position": {
"type": "Point",
"coordinates": [-74.0060, 40.7128, 100]
},
"altitude": 100,
"heading": 45,
"speed": 10,
"timestamp": "2025-09-16T12:34:56.789Z"
},
// More vehicles...
],
"count": 10,
"timestamp": "2025-09-16T12:35:00.000Z"
}</code></pre>
</div>
</div>
</div>

          <div class="card mb-3">
            <div class="card-header">Create Simulation Session</div>
            <div class="card-body">
              <div class="code-block">
                <pre><code>curl -X POST \
https://iasms.example.com/api/iasms/simulations \
-H 'X-API-Key: your_api_key' \
-H 'Content-Type: application/json' \
-d '{
"name": "API-created Simulation",
"description": "Created via API for external integration",
"syncWithRealWorld": true,
"settings": {
"timeScale": 1.0,
"weatherConditions": "CLEAR"
}
}'</code></pre>
</div>

              <p>Response:</p>
              
              <div class="code-block">
                <pre><code>{
"sessionId": "session123",
"message": "Simulation session created successfully",
"timestamp": "2025-09-16T12:35:00.000Z"
}</code></pre>
</div>
</div>
</div>

          <h3>Meteor Methods</h3>
          <p>
            For client applications, Meteor methods are available:
          </p>
          
          <table class="table table-bordered">
            <thead class="thead-light">
              <tr>
                <th>Method</th>
                <th>Parameters</th>
                <th>Returns</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td><code>iasms.createSimulationSession</code></td>
                <td><code>{ scenarioId, name, description, syncWithRealWorld, entities, settings, metadata }</code></td>
                <td>Session ID (string)</td>
              </tr>
              <tr>
                <td><code>iasms.updateSimulationSession</code></td>
                <td><code>sessionId, { name, description, status, syncWithRealWorld, settings, metadata }</code></td>
                <td>Success (boolean)</td>
              </tr>
              <tr>
                <td><code>iasms.endSimulationSession</code></td>
                <td><code>sessionId, results</code></td>
                <td>Success (boolean)</td>
              </tr>
              <tr>
                <td><code>iasms.addEntityToSimulation</code></td>
                <td><code>sessionId, entity</code></td>
                <td>Entity ID (string)</td>
              </tr>
              <tr>
                <td><code>iasms.updateEntity</code></td>
                <td><code>sessionId, entityId, updates</code></td>
                <td>Success (boolean)</td>
              </tr>
              <tr>
                <td><code>iasms.removeEntity</code></td>
                <td><code>sessionId, entityId</code></td>
                <td>Success (boolean)</td>
              </tr>
              <tr>
                <td><code>iasms.getVehicleState</code></td>
                <td><code>vehicleId</code></td>
                <td>Vehicle state object</td>
              </tr>
              <tr>
                <td><code>iasms.getHazard</code></td>
                <td><code>hazardId</code></td>
                <td>Hazard object</td>
              </tr>
              <tr>
                <td><code>iasms.getVehicleRisks</code></td>
                <td><code>vehicleId</code></td>
                <td>Array of risk objects</td>
              </tr>
              <tr>
                <td><code>iasms.getSystemStats</code></td>
                <td>None</td>
                <td>System statistics object</td>
              </tr>
              <tr>
                <td><code>iasms.updateUserSettings</code></td>
                <td><code>settings</code></td>
                <td>Success (boolean)</td>
              </tr>
            </tbody>
          </table>
          
          <h3>WebSocket Events</h3>
          <p>
            Real-time updates are provided through WebSocket events:
          </p>
          
          <table class="table table-bordered">
            <thead class="thead-light">
              <tr>
                <th>Channel</th>
                <th>Event Type</th>
                <th>Data</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td><code>session_[sessionId]</code></td>
                <td><code>entity_updates</code></td>
                <td>Array of entity updates</td>
              </tr>
              <tr>
                <td><code>session_[sessionId]</code></td>
                <td><code>session_status</code></td>
                <td>Session status update</td>
              </tr>
              <tr>
                <td><code>session_[sessionId]</code></td>
                <td><code>session_end</code></td>
                <td>Session end event with results</td>
              </tr>
              <tr>
                <td><code>session_[sessionId]</code></td>
                <td><code>notification</code></td>
                <td>Notification message</td>
              </tr>
            </tbody>
          </table>
          
          <h4>Entity Update Types</h4>
          <p>
            Entity updates can be of various types:
          </p>
          
          <ul>
            <li><code>vehicle_create</code>: New vehicle added</li>
            <li><code>vehicle_update</code>: Vehicle properties updated</li>
            <li><code>hazard_create</code>: New hazard added</li>
            <li><code>hazard_update</code>: Hazard properties updated</li>
            <li><code>risk_update</code>: Risk assessment updated</li>
            <li><code>lostlink_update</code>: Lost link status updated</li>
            <li><code>contingency_update</code>: Contingency plan activated</li>
            <li><code>vertiport_emergency_update</code>: Vertiport emergency status updated</li>
            <li><code>entity_remove</code>: Entity removed from simulation</li>
          </ul>
        </div>
      </div>

      <div class="card mb-4">
        <div class="card-header bg-primary text-white">
          <h2 id="troubleshooting">Troubleshooting</h2>
        </div>
        <div class="card-body">
          <h3>Common Issues and Solutions</h3>
          
          <div class="accordion" id="troubleshootingAccordion">
            <div class="card">
              <div class="card-header" id="heading1">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapse1" aria-expanded="true" aria-controls="collapse1">
                    WebGL Not Available
                  </button>
                </h2>
              </div>
              <div id="collapse1" class="collapse show" aria-labelledby="heading1" data-parent="#troubleshootingAccordion">
                <div class="card-body">
                  <p><strong>Symptoms:</strong> 3D visualization doesn't appear, console shows WebGL errors.</p>
                  
                  <p><strong>Possible Causes:</strong></p>
                  <ul>
                    <li>Graphics drivers are outdated</li>
                    <li>Browser doesn't support WebGL 2.0</li>
                    <li>Hardware acceleration is disabled</li>
                    <li>GPU is blacklisted by the browser</li>
                  </ul>
                  
                  <p><strong>Solutions:</strong></p>
                  <ol>
                    <li>Update graphics drivers to the latest version</li>
                    <li>Use a modern browser (latest Chrome, Firefox, Edge, or Safari)</li>
                    <li>Enable hardware acceleration in browser settings</li>
                    <li>Check if WebGL is enabled:
                      <ul>
                        <li>Chrome: chrome://gpu</li>
                        <li>Firefox: about:support</li>
                        <li>Edge: edge://gpu</li>
                      </ul>
                    </li>
                    <li>Try using a different device with better graphics support</li>
                  </ol>
                </div>
              </div>
            </div>
            
            <div class="card">
              <div class="card-header" id="heading2">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapse2" aria-expanded="false" aria-controls="collapse2">
                    WebXR Not Available
                  </button>
                </h2>
              </div>
              <div id="collapse2" class="collapse" aria-labelledby="heading2" data-parent="#troubleshootingAccordion">
                <div class="card-body">
                  <p><strong>Symptoms:</strong> VR/AR buttons don't appear, or clicking them does nothing.</p>
                  
                  <p><strong>Possible Causes:</strong></p>
                  <ul>
                    <li>Browser doesn't support WebXR</li>
                    <li>No compatible VR/AR hardware connected</li>
                    <li>WebXR is disabled in browser settings</li>
                    <li>Running on HTTP instead of HTTPS (WebXR requires secure context)</li>
                  </ul>
                  
                  <p><strong>Solutions:</strong></p>
                  <ol>
                    <li>Use a WebXR-compatible browser:
                      <ul>
                        <li>Chrome 79+ (desktop and Android)</li>
                        <li>Edge 79+ (based on Chromium)</li>
                        <li>Firefox with WebXR flag enabled</li>
                        <li>Meta Browser (Quest devices)</li>
                      </ul>
                    </li>
                    <li>For VR: Connect a supported headset and ensure it's properly set up</li>
                    <li>For AR: Use a compatible mobile device (ARCore for Android, ARKit for iOS)</li>
                    <li>Ensure you're using HTTPS (required for WebXR)</li>
                    <li>For development, you can use:
                      <ul>
                        <li>Chrome's WebXR Emulator extension</li>
                        <li>Meta Quest Developer Hub</li>
                        <li>https://localhost or enable flags for insecure localhost</li>
                      </ul>
                    </li>
                  </ol>
                </div>
              </div>
            </div>
            
            <div class="card">
              <div class="card-header" id="heading3">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapse3" aria-expanded="false" aria-controls="collapse3">
                    Performance Issues
                  </button>
                </h2>
              </div>
              <div id="collapse3" class="collapse" aria-labelledby="heading3" data-parent="#troubleshootingAccordion">
                <div class="card-body">
                  <p><strong>Symptoms:</strong> Low frame rate, stuttering, or freezing during simulation.</p>
                  
                  <p><strong>Possible Causes:</strong></p>
                  <ul>
                    <li>Too many entities in the scene</li>
                    <li>High-poly models with no LOD</li>
                    <li>Uncompressed textures</li>
                    <li>Memory leaks</li>
                    <li>Insufficient GPU power</li>
                    <li>Network synchronization overhead</li>
                  </ul>
                  
                  <p><strong>Solutions:</strong></p>
                  <ol>
                    <li>Check system performance monitor (press P in the 3D view)</li>
                    <li>Reduce entity count in the configuration</li>
                    <li>Enable performance optimization options:
                      <ul>
                        <li>Lower render quality in settings</li>
                        <li>Disable effects like shadows or ambient occlusion</li>
                        <li>Reduce view distance</li>
                        <li>Enable frustum culling</li>
                      </ul>
                    </li>
                    <li>Check for memory leaks:
                      <ul>
                        <li>Properly dispose of Three.js objects</li>
                        <li>Monitor memory usage in browser dev tools</li>
                        <li>Clear object references when components unmount</li>
                      </ul>
                    </li>
                    <li>Optimize network usage:
                      <ul>
                        <li>Reduce update frequency</li>
                        <li>Filter updates to relevant entities only</li>
                        <li>Use delta compression for updates</li>
                      </ul>
                    </li>
                  </ol>
                </div>
              </div>
            </div>
            
            <div class="card">
              <div class="card-header" id="heading4">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapse4" aria-expanded="false" aria-controls="collapse4">
                    Meteor Integration Issues
                  </button>
                </h2>
              </div>
              <div id="collapse4" class="collapse" aria-labelledby="heading4" data-parent="#troubleshootingAccordion">
                <div class="card-body">
                  <p><strong>Symptoms:</strong> Data not updating, subscriptions not working, or method calls failing.</p>
                  
                  <p><strong>Possible Causes:</strong></p>
                  <ul>
                    <li>Publication/subscription mismatch</li>
                    <li>Missing MongoDB indexes</li>
                    <li>Missing permissions</li>
                    <li>Connection issues</li>
                    <li>Subscription timing issues</li>
                  </ul>
                  
                  <p><strong>Solutions:</strong></p>
                  <ol>
                    <li>Check publication definitions on the server</li>
                    <li>Verify subscription setup on the client</li>
                    <li>Use <code>useTracker</code> correctly:
                      <div class="code-block">
                        <pre><code>const { data, isLoading } = useTracker(() => {
const handle = Meteor.subscribe('publication.name');
return {
data: Collection.find().fetch(),
isLoading: !handle.ready()
};
}, []);</code></pre>
</div>
</li>
<li>Check MongoDB indexes:
<div class="code-block">
<pre><code>// From MongoDB shell or Meteor server console
db.collection.getIndexes()</code></pre>
</div>
</li>
<li>Verify user permissions:
<div class="code-block">
<pre><code>Roles.userIsInRole(userId, 'simulation-viewer')</code></pre>
</div>
</li>
<li>Check DDP connection status:
<div class="code-block">
<pre><code>Meteor.status()</code></pre>
</div>
</li>
</ol>
</div>
</div>
</div>

            <div class="card">
              <div class="card-header" id="heading5">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapse5" aria-expanded="false" aria-controls="collapse5">
                    React Component Issues
                  </button>
                </h2>
              </div>
              <div id="collapse5" class="collapse" aria-labelledby="heading5" data-parent="#troubleshootingAccordion">
                <div class="card-body">
                  <p><strong>Symptoms:</strong> Components not rendering correctly, state updates not reflected, or unmounted component warnings.</p>
                  
                  <p><strong>Possible Causes:</strong></p>
                  <ul>
                    <li>Improper cleanup in useEffect</li>
                    <li>Missing dependencies in useEffect</li>
                    <li>State updates on unmounted components</li>
                    <li>Incorrect prop handling</li>
                    <li>Memory leaks</li>
                  </ul>
                  
                  <p><strong>Solutions:</strong></p>
                  <ol>
                    <li>Properly clean up resources in useEffect:
                      <div class="code-block">
                        <pre><code>useEffect(() => {
// Setup code...

// Cleanup function
return () => {
// Dispose Three.js objects
// Remove event listeners
// Cancel animations
// Clear timers
};
}, [dependencies]);</code></pre>
</div>
</li>
<li>Include all dependencies in useEffect dependency array</li>
<li>Use a mounted ref to prevent state updates after unmount:
<div class="code-block">
<pre><code>const isMounted = useRef(true);

useEffect(() => {
return () => {
isMounted.current = false;
};
}, []);

const fetchData = async () => {
const data = await api.getData();
if (isMounted.current) {
setState(data);
}
};</code></pre>
</div>
</li>
<li>Use React DevTools to inspect component hierarchy and props</li>
<li>Use memoization for expensive calculations or renders:
<div class="code-block">
<pre><code>const memoizedValue = useMemo(() => computeExpensiveValue(a, b), [a, b]);
const memoizedCallback = useCallback(() => { doSomething(a, b); }, [a, b]);</code></pre>
</div>
</li>
</ol>
</div>
</div>
</div>

            <div class="card">
              <div class="card-header" id="heading6">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapse6" aria-expanded="false" aria-controls="collapse6">
                    Mobile Device Issues
                  </button>
                </h2>
              </div>
              <div id="collapse6" class="collapse" aria-labelledby="heading6" data-parent="#troubleshootingAccordion">
                <div class="card-body">
                  <p><strong>Symptoms:</strong> Poor performance on mobile, touch controls not working, or AR not functioning.</p>
                  
                  <p><strong>Possible Causes:</strong></p>
                  <ul>
                    <li>Device not powerful enough for full 3D</li>
                    <li>Touch event handling issues</li>
                    <li>AR compatibility problems</li>
                    <li>WebXR permissions denied</li>
                    <li>Safari-specific WebGL limitations</li>
                  </ul>
                  
                  <p><strong>Solutions:</strong></p>
                  <ol>
                    <li>Enable mobile optimizations in config:
                      <div class="code-block">
                        <pre><code>// In iasms-simulation-config.js
mobileOptimizations: {
enabled: true,
reducePolygons: true,
simplifyPhysics: true,
disableShadows: true,
lowResTextures: true,
reduceDrawDistance: true
}</code></pre>
</div>
</li>
<li>Fix touch handling:
<ul>
<li>Use TouchEvent instead of MouseEvent</li>
<li>Handle multi-touch correctly</li>
<li>Add proper touch feedback</li>
</ul>
</li>
<li>For AR:
<ul>
<li>Check device compatibility (ARCore/ARKit)</li>
<li>Ensure camera permissions are granted</li>
<li>Use well-lit environment for tracking</li>
<li>Handle orientation changes properly</li>
</ul>
</li>
<li>For iOS Safari:
<ul>
<li>Handle iOS-specific WebGL limitations</li>
<li>Optimize for iOS memory constraints</li>
<li>Test on actual iOS devices</li>
</ul>
</li>
</ol>
</div>
</div>
</div>
</div>

          <h3>Diagnostic Tools</h3>
          <p>
            Use these tools to diagnose issues:
          </p>
          
          <ul>
            <li><strong>Built-in Performance Monitor</strong>: Press <kbd>P</kbd> in the 3D view to show/hide the performance statistics</li>
            <li><strong>Browser DevTools</strong>: Use the Performance, Memory, and Network tabs to analyze issues</li>
            <li><strong>Three.js Inspector</strong>: Chrome extension for inspecting Three.js scenes</li>
            <li><strong>WebXR Emulator</strong>: Test WebXR without actual hardware</li>
            <li><strong>Meteor Shell</strong>: Run <code>meteor shell</code> to interact with the server directly</li>
            <li><strong>MongoDB Compass</strong>: Inspect the database directly</li>
            <li><strong>Log Viewer</strong>: Check <code>/admin/logs</code> in the application for server logs</li>
          </ul>
          
          <h3>Reporting Issues</h3>
          <p>
            When reporting issues, include:
          </p>
          
          <ol>
            <li><strong>Exact Error Messages</strong>: Copy from browser console or server logs</li>
            <li><strong>Browser and OS Information</strong>: Browser version, OS, device type</li>
            <li><strong>Steps to Reproduce</strong>: Detailed steps to recreate the issue</li>
            <li><strong>Component Versions</strong>: IASMS version, Three.js version, etc.</li>
            <li><strong>Screenshots or Videos</strong>: Visual evidence of the issue</li>
            <li><strong>Performance Metrics</strong>: FPS, memory usage, network stats</li>
          </ol>
          
          <p>
            Submit issues to the project repository or contact the development team directly.
          </p>
        </div>
      </div>

      <div class="card mb-4">
        <div class="card-header bg-primary text-white">
          <h2 id="resources">Additional Resources</h2>
        </div>
        <div class="card-body">
          <h3>Documentation</h3>
          <ul>
            <li><a href="https://threejs.org/docs/" target="_blank">Three.js Documentation</a></li>
            <li><a href="https://immersiveweb.dev/" target="_blank">WebXR Developer Guide</a></li>
            <li><a href="https://docs.meteor.com/" target="_blank">Meteor Documentation</a></li>
            <li><a href="https://reactjs.org/docs/getting-started.html" target="_blank">React Documentation</a></li>
            <li><a href="https://developer.mozilla.org/en-US/docs/Web/API/WebXR_Device_API" target="_blank">MDN WebXR API Reference</a></li>
          </ul>
          
          <h3>Sample Code</h3>
          <p>
            Explore these examples for reference:
          </p>
          
          <div class="card-deck">
            <div class="card">
              <div class="card-header">Basic Vehicle Visualization</div>
              <div class="card-body">
                <p>Shows how to create and animate a simple vehicle model.</p>
                <a href="/docs/examples/basic-vehicle.html" class="btn btn-primary">View Example</a>
              </div>
            </div>
            <div class="card">
              <div class="card-header">WebXR Integration</div>
              <div class="card-body">
                <p>Demonstrates basic WebXR setup for VR and AR.</p>
                <a href="/docs/examples/webxr-integration.html" class="btn btn-primary">View Example</a>
              </div>
            </div>
            <div class="card">
              <div class="card-header">Real-time Data Sync</div>
              <div class="card-body">
                <p>Shows how to sync data between IASMS and Three.js.</p>
                <a href="/docs/examples/realtime-sync.html" class="btn btn-primary">View Example</a>
              </div>
            </div>
          </div>
          
          <h3>Tools and Utilities</h3>
          <table class="table table-bordered mt-4">
            <thead class="thead-light">
              <tr>
                <th>Tool</th>
                <th>Purpose</th>
                <th>Link</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>WebXR Emulator</td>
                <td>Test WebXR without hardware</td>
                <td><a href="https://github.com/MozillaReality/WebXR-emulator-extension" target="_blank">GitHub Repo</a></td>
              </tr>
              <tr>
                <td>Three.js Editor</td>
                <td>Visual editor for Three.js scenes</td>
                <td><a href="https://threejs.org/editor/" target="_blank">Online Editor</a></td>
              </tr>
              <tr>
                <td>React Developer Tools</td>
                <td>Debug React components</td>
                <td><a href="https://reactjs.org/blog/2019/08/15/new-react-devtools.html" target="_blank">Installation Guide</a></td>
              </tr>
              <tr>
                <td>Meta Quest Developer Hub</td>
                <td>Development for Meta Quest</td>
                <td><a href="https://developer.oculus.com/documentation/tools/tools-device-setup-os/" target="_blank">Documentation</a></td>
              </tr>
              <tr>
                <td>Blender</td>
                <td>Create 3D models</td>
                <td><a href="https://www.blender.org/" target="_blank">Website</a></td>
              </tr>
            </tbody>
          </table>
          
          <h3>Community and Support</h3>
          <ul>
            <li><strong>Slack Channel:</strong> #iasms-simulation</li>
            <li><strong>Issue Tracker:</strong> <a href="https://github.com/autonomy-association/iasms/issues" target="_blank">GitHub Issues</a></li>
            <li><strong>Email Support:</strong> <a href="mailto:support@autonomy-association.org">support@autonomy-association.org</a></li>
            <li><strong>Regular Office Hours:</strong> Every Wednesday, 10:00-11:00 AM ET</li>
          </ul>
          
          <h3>Training Materials</h3>
          <ul>
            <li><a href="/docs/training/getting-started.html">Getting Started with IASMS Simulation</a></li>
            <li><a href="/docs/training/webxr-development.html">WebXR Development for IASMS</a></li>
            <li><a href="/docs/training/custom-models.html">Creating Custom 3D Models</a></li>
            <li><a href="/docs/training/performance-optimization.html">Performance Optimization Guide</a></li>
            <li><a href="/docs/training/mobile-development.html">Mobile Development Best Practices</a></li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
  // Add smooth scrolling to anchor links
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
      e.preventDefault();
      
      document.querySelector(this.getAttribute('href')).scrollIntoView({
        behavior: 'smooth'
      });
    });
  });
  
  // Highlight active section in TOC
  window.addEventListener('scroll', function() {
    const sections = document.querySelectorAll('h2[id]');
    let currentSectionId = null;
    
    sections.forEach(section => {
      const sectionTop = section.offsetTop;
      const sectionHeight = section.offsetHeight;
      if (window.pageYOffset >= sectionTop - 100 && 
          window.pageYOffset < sectionTop + sectionHeight - 100) {
        currentSectionId = section.getAttribute('id');
      }
    });
    
    document.querySelectorAll('#toc a').forEach(link => {
      link.classList.remove('active');
      if (link.getAttribute('href') === `#${currentSectionId}`) {
        link.classList.add('active');
      }
    });
  });
  
  // Handle deep linking
  window.onload = function() {
    // Check for hash in URL
    if (window.location.hash) {
      const hash = window.location.hash;
      
      // Open accordion items if needed
      if (hash.startsWith('#collapse')) {
        $(hash).collapse('show');
      }
      
      // Scroll to element after a short delay to allow page to render
      setTimeout(() => {
        const element = document.querySelector(hash);
        if (element) {
          element.scrollIntoView();
        }
      }, 300);
    }
  };
</script>

<style>
  body {
    padding-top: 20px;
    padding-bottom: 40px;
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen-Sans, Ubuntu, Cantarell, "Helvetica Neue", sans-serif;
  }
  
  .sticky-top {
    top: 20px;
  }
  
  .card-header {
    font-weight: 500;
  }
  
  .nav-link {
    padding: .3rem 1rem;
  }
  
  .nav-link.active {
    background-color: #e9ecef;
    border-radius: 4px;
    font-weight: 500;
  }
  
  .card-header.bg-primary {
    background-color: #3498db !important;
  }
  
  h2, h3, h4 {
    margin-top: 1.5rem;
    margin-bottom: 1rem;
  }
  
  .code-block {
    background-color: #f8f9fa;
    border-radius: 4px;
    padding: 1px;
  }
  
  .code-block pre {
    margin: 0;
    padding: 1rem;
    overflow-x: auto;
  }
  
  .code-block code {
    font-family: SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace;
    font-size: 0.875em;
    color: #212529;
  }
  
  table {
    font-size: 0.9rem;
  }
  
  .alert {
    margin-top: 1rem;
    margin-bottom: 1rem;
  }
  
  .lead {
    font-size: 1.1rem;
    font-weight: 300;
  }
  
  kbd {
    background-color: #212529;
    color: #fff;
    padding: 2px 5px;
    border-radius: 3px;
    font-size: 0.9em;
  }
  
  /* Print styles */
  @media print {
    .sticky-top {
      position: static;
    }
    
    a[href]:after {
      content: " (" attr(href) ")";
    }
    
    .card {
      break-inside: avoid;
    }
    
    .collapse {
      display: block !important;
      height: auto !important;
    }
  }
</style>
# Advanced Topics in IASMS Simulation & WebXR Integration

<div class="container-fluid mt-5">
  <div class="row">
    <div class="col-md-3">
      <!-- Table of Contents -->
      <div class="sticky-top pt-3">
        <div class="card">
          <div class="card-header bg-primary text-white">
            <h4>Advanced Topics</h4>
          </div>
          <div class="card-body">
            <nav id="advanced-toc" class="nav flex-column">
              <a class="nav-link" href="#contingency-management">Contingency Management</a>
              <a class="nav-link" href="#custom-models">Custom 3D Models</a>
              <a class="nav-link" href="#optimization-techniques">Advanced Optimization</a>
              <a class="nav-link" href="#webxr-tracking">WebXR Tracking Features</a>
              <a class="nav-link" href="#multiuser">Multi-User Collaboration</a>
              <a class="nav-link" href="#enterprise-integration">Enterprise Integration</a>
              <a class="nav-link" href="#testing">Testing & Quality Assurance</a>
              <a class="nav-link" href="#deployment">Deployment Strategies</a>
            </nav>
          </div>
        </div>
      </div>
    </div>

    <div class="col-md-9">
      <!-- Main content -->
      <div class="card mb-4">
        <div class="card-header bg-primary text-white">
          <h2 id="contingency-management">Contingency Management</h2>
        </div>
        <div class="card-body">
          <h3>Overview</h3>
          <p>
            The IASMS Simulation system includes comprehensive contingency management for aerial vehicles, allowing for realistic simulation of emergency scenarios and response training.
          </p>
          
          <h4>Contingency Types</h4>
          <p>
            The system supports various contingency types:
          </p>
          
          <table class="table table-bordered">
            <thead class="thead-light">
              <tr>
                <th>Contingency Type</th>
                <th>Description</th>
                <th>Default Action</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>Lost Link</td>
                <td>Loss of communication with the vehicle</td>
                <td>Return to Home</td>
              </tr>
              <tr>
                <td>Low Battery</td>
                <td>Critical battery level detected</td>
                <td>Land at Nearest Safe Location</td>
              </tr>
              <tr>
                <td>Weather Emergency</td>
                <td>Dangerous weather conditions</td>
                <td>Return to Launch</td>
              </tr>
              <tr>
                <td>Geofence Breach</td>
                <td>Vehicle exits permitted area</td>
                <td>Return to Geofence Boundary</td>
              </tr>
              <tr>
                <td>Hardware Failure</td>
                <td>Critical component failure</td>
                <td>Controlled Descent</td>
              </tr>
              <tr>
                <td>Collision Risk</td>
                <td>Imminent collision detected</td>
                <td>Evasive Maneuver</td>
              </tr>
            </tbody>
          </table>
          
          <h3>Lost Link Contingency</h3>
          <p>
            The Lost Link contingency is one of the most critical scenarios in aerial operations. The system implements a sophisticated lost link management system that includes:
          </p>
          
          <ul>
            <li><strong>Detection</strong>: Monitoring vehicle heartbeats to detect communication loss</li>
            <li><strong>Assessment</strong>: Evaluating the severity and context of the lost link event</li>
            <li><strong>Response</strong>: Executing appropriate contingency plans</li>
            <li><strong>Prediction</strong>: Forecasting vehicle behavior during lost link</li>
            <li><strong>Recovery</strong>: Handling communication restoration</li>
          </ul>
          
          <h4>Contingency Plan Registration</h4>
          <p>
            Vehicles can register contingency plans that specify their behavior during lost link events:
          </p>
          
          <div class="code-block">
            <pre><code>// Example: Register a contingency plan
Meteor.call('iasms.registerContingencyPlan', {
vehicleId: 'drone-001',
operationId: 'mission-123',
contingencyType: 'LOST_LINK',
primaryAction: 'RETURN_TO_HOME',
backupAction: 'LAND_IMMEDIATELY',
homeLocation: {
type: 'Point',
coordinates: [-74.0060, 40.7128]
},
waypoints: [
{
type: 'Point',
coordinates: [-74.0050, 40.7120]
},
{
type: 'Point',
coordinates: [-74.0040, 40.7110]
}
],
metadata: {
maxAltitude: 120,
returnSpeed: 5
}
});</code></pre>
</div>

          <h4>Path Prediction</h4>
          <p>
            When a lost link occurs, the system can predict the vehicle's behavior based on its contingency plan:
          </p>
          
          <div class="code-block">
            <pre><code>// Example: Lost link path prediction
const lostLinkPrediction = await Meteor.callAsync('iasms.generateLostLinkPrediction', {
vehicleId: 'drone-001',
lastLocation: {
type: 'Point',
coordinates: [-74.0055, 40.7125]
},
lastVelocity: {
speed: 8,
heading: 45
},
lastAltitude: 100,
lastHeading: 45,
lastTime: new Date()
});</code></pre>
</div>

          <p>
            The prediction includes the expected path, duration, and landing location:
          </p>
          
          <div class="code-block">
            <pre><code>// Example prediction result
{
vehicleId: 'drone-001',
timestamp: '2025-09-16T14:30:00.000Z',
lastLocation: {
type: 'Point',
coordinates: [-74.0055, 40.7125]
},
lastTime: '2025-09-16T14:29:45.000Z',
contingencyAction: 'RETURN_TO_HOME',
prediction: {
type: 'RETURN_TO_HOME',
path: {
type: 'LineString',
coordinates: [
[-74.0055, 40.7125],
[-74.0057, 40.7126],
// ... more points
[-74.0060, 40.7128]
]
},
estimatedDistance: 350,
estimatedDuration: 70,
startTime: '2025-09-16T14:29:45.000Z',
completionTime: '2025-09-16T14:30:55.000Z',
landingLocation: {
type: 'Point',
coordinates: [-74.0060, 40.7128]
}
},
metadata: {
contingencyPlanId: 'plan-456',
predictedCompletionTime: '2025-09-16T14:30:55.000Z'
}
}</code></pre>
</div>

          <h4>Visualization</h4>
          <p>
            The 3D visualization system displays lost link events and contingency paths:
          </p>
          
          <div class="row">
            <div class="col-md-6">
              <div class="card mb-3">
                <div class="card-header">Lost Link Indicator</div>
                <div class="card-body text-center">
                  <img src="images/lostlink-indicator.png" alt="Lost Link Indicator" class="img-fluid" style="max-height: 200px;">
                  <p class="mt-2">Pulsing red indicator shows the last known position</p>
                </div>
              </div>
            </div>
            <div class="col-md-6">
              <div class="card mb-3">
                <div class="card-header">Contingency Path</div>
                <div class="card-body text-center">
                  <img src="images/contingency-path.png" alt="Contingency Path" class="img-fluid" style="max-height: 200px;">
                  <p class="mt-2">Projected path shown as dashed line</p>
                </div>
              </div>
            </div>
          </div>
          
          <h3>Custom Contingency Implementations</h3>
          <p>
            Developers can extend the contingency system with custom behaviors:
          </p>
          
          <div class="code-block">
            <pre><code>// Example: Adding a custom contingency predictor
class CustomContingencyPredictor {
constructor() {
this.name = 'CUSTOM_PATTERN';
}

// Predict the path based on custom logic
predict(params, contingencyPlan) {
const { lastLocation, lastVelocity, lastAltitude, lastHeading, lastTime } = params;

    // Custom path generation logic
    const path = this._generateCustomPath(
      lastLocation.coordinates,
      contingencyPlan.customParameters
    );
    
    // Calculate distance, duration, etc.
    const distance = this._calculatePathLength(path);
    const speed = lastVelocity?.speed || 10;
    const duration = distance / speed;
    
    return {
      type: this.name,
      path: {
        type: 'LineString',
        coordinates: path
      },
      estimatedDistance: distance,
      estimatedDuration: duration,
      startTime: lastTime,
      completionTime: new Date(lastTime.getTime() + (duration * 1000)),
      landingLocation: {
        type: 'Point',
        coordinates: path[path.length - 1]
      }
    };
}

// Custom path generation
_generateCustomPath(startCoordinates, parameters) {
// Implementation details...
}

// Calculate the total path length
_calculatePathLength(path) {
// Implementation details...
}
}

// Register the custom predictor
IasmsLostLinkModule.registerContingencyPredictor(new CustomContingencyPredictor());</code></pre>
</div>

          <h3>Training Scenarios</h3>
          <p>
            The system includes pre-defined training scenarios for contingency management:
          </p>
          
          <table class="table table-bordered">
            <thead class="thead-light">
              <tr>
                <th>Scenario</th>
                <th>Description</th>
                <th>Learning Objectives</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>Basic Lost Link</td>
                <td>Simple lost link event with clear return path</td>
                <td>Understanding basic contingency procedures</td>
              </tr>
              <tr>
                <td>Complex Terrain</td>
                <td>Lost link over challenging terrain with obstacles</td>
                <td>Route planning with terrain considerations</td>
              </tr>
              <tr>
                <td>Urban Contingency</td>
                <td>Lost link in dense urban environment</td>
                <td>Managing contingencies in complex airspace</td>
              </tr>
              <tr>
                <td>Multi-Vehicle Scenario</td>
                <td>Multiple vehicles with simultaneous contingencies</td>
                <td>Coordinating responses across a fleet</td>
              </tr>
              <tr>
                <td>Weather Complication</td>
                <td>Lost link during adverse weather</td>
                <td>Contingency management with environmental factors</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

      <div class="card mb-4">
        <div class="card-header bg-primary text-white">
          <h2 id="custom-models">Custom 3D Models</h2>
        </div>
        <div class="card-body">
          <h3>Overview</h3>
          <p>
            While the IASMS Simulation system includes procedurally generated models, you can enhance the visual fidelity by using custom 3D models.
          </p>
          
          <h4>Supported Formats</h4>
          <table class="table table-bordered">
            <thead class="thead-light">
              <tr>
                <th>Format</th>
                <th>Recommended Use</th>
                <th>Features</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>glTF/GLB (.gltf, .glb)</td>
                <td>Primary format</td>
                <td>PBR materials, animations, skinning, morph targets</td>
              </tr>
              <tr>
                <td>OBJ (.obj)</td>
                <td>Simple static models</td>
                <td>Basic geometry and materials</td>
              </tr>
              <tr>
                <td>FBX (.fbx)</td>
                <td>Animation transfer</td>
                <td>Complex animations, bone structures</td>
              </tr>
              <tr>
                <td>DRACO (.drc)</td>
                <td>Compressed models</td>
                <td>Smaller file size, faster loading</td>
              </tr>
            </tbody>
          </table>
          
          <div class="alert alert-info">
            <strong>Recommendation:</strong> Use glTF/GLB format with DRACO compression for the best balance of quality, features, and performance.
          </div>
          
          <h3>Model Requirements</h3>
          <p>
            For optimal performance and compatibility, follow these guidelines when creating custom models:
          </p>
          
          <ul>
            <li><strong>Polygon Count</strong>: Keep under 50,000 triangles for complex vehicles, under 10,000 for simple ones</li>
            <li><strong>Textures</strong>: Use 2K textures (2048×2048) or smaller, with power-of-two dimensions</li>
            <li><strong>Materials</strong>: Use PBR (Physically-Based Rendering) materials when possible</li>
            <li><strong>UV Mapping</strong>: Create clean, non-overlapping UV maps</li>
            <li><strong>Origin</strong>: Set the model origin at the center bottom of the model</li>
            <li><strong>Scale</strong>: Model in real-world scale (1 unit = 1 meter)</li>
            <li><strong>Forward Direction</strong>: Align model to face the negative Z-axis</li>
            <li><strong>Up Direction</strong>: Y-axis should be up</li>
          </ul>
          
          <h3>Adding Custom Models</h3>
          <p>
            To add custom models to the simulation:
          </p>
          
          <ol>
            <li>
              <strong>Prepare the model</strong> in a 3D modeling application (Blender, Maya, 3ds Max, etc.)
            </li>
            <li>
              <strong>Export as glTF/GLB</strong> with these settings:
              <ul>
                <li>Include: Meshes, Materials, Textures, Animations</li>
                <li>Enable DRACO compression if available</li>
                <li>Set animation sampling to 30fps</li>
                <li>Embed textures in the GLB file</li>
              </ul>
            </li>
            <li>
              <strong>Place the model file</strong> in the <code>private/iasms-assets/models</code> directory
            </li>
            <li>
              <strong>Register the model</strong> in the system:
              <div class="code-block">
                <pre><code>// Example: Register a custom model
simulationModule.registerSimulationModel({
type: 'custom-drone',
category: 'aerial',
name: 'Advanced Quadcopter',
modelPath: '/assets/models/advanced-quadcopter.glb',
scale: 1.0,
physics: {
mass: 2.2,
maxSpeed: 20, // m/s
maxAcceleration: 6, // m/s²
rotationSpeed: 2.5, // rad/s
maxAltitude: 150 // meters
},
animations: {
idle: 'Idle',
flying: 'Flying',
takeoff: 'TakeOff',
landing: 'Landing'
},
propellers: [
{ bone: 'PropellerFR', axis: 'y' },
{ bone: 'PropellerFL', axis: 'y' },
{ bone: 'PropellerBR', axis: 'y' },
{ bone: 'PropellerBL', axis: 'y' }
],
sensors: ['camera', 'gps', 'imu'],
defaultPose: {
position: { x: 0, y: 0, z: 0 },
rotation: { x: 0, y: 0, z: 0 }
}
});</code></pre>
</div>
</li>
<li>
<strong>Use the model</strong> in simulation entities:
<div class="code-block">
<pre><code>// Example: Create entity with custom model
simulationModule.addEntityToSimulation(sessionId, {
type: 'vehicle',
vehicleType: 'custom-drone',
vehicleCategory: 'aerial',
position: { x: 100, y: 50, z: -200 },
rotation: { x: 0, y: 0.7853981, z: 0 }, // 45 degrees in radians
metadata: {
callsign: 'ADVANCED-1',
status: 'ACTIVE'
}
});</code></pre>
</div>
</li>
</ol>

          <h3>Model Organization</h3>
          <p>
            Organize your custom models with a consistent folder structure:
          </p>
          
          <div class="code-block">
            <pre><code>private/iasms-assets/
├── models/
│   ├── aerial/
│   │   ├── drones/
│   │   │   ├── basic-quadcopter.glb
│   │   │   ├── advanced-quadcopter.glb
│   │   │   └── hexacopter.glb
│   │   ├── evtol/
│   │   │   ├── passenger-evtol.glb
│   │   │   └── cargo-evtol.glb
│   │   └── aircraft/
│   │       ├── cessna.glb
│   │       └── helicopter.glb
│   ├── ground/
│   │   ├── cars/
│   │   └── trucks/
│   ├── maritime/
│   │   ├── boats/
│   │   └── ships/
│   └── environment/
│       ├── buildings/
│       ├── infrastructure/
│       └── terrain/
└── textures/
├── common/
├── aerial/
└── environment/</code></pre>
</div>

          <h3>Model Animations</h3>
          <p>
            The system supports model animations for more realistic behavior:
          </p>
          
          <table class="table table-bordered">
            <thead class="thead-light">
              <tr>
                <th>Animation Type</th>
                <th>Description</th>
                <th>Implementation</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>Propeller Rotation</td>
                <td>Spinning propellers on aerial vehicles</td>
                <td>Bone animation or procedural rotation</td>
              </tr>
              <tr>
                <td>Landing Gear</td>
                <td>Retractable landing gear</td>
                <td>Keyframe animation with trigger events</td>
              </tr>
              <tr>
                <td>Flight Controls</td>
                <td>Moving control surfaces (ailerons, rudder, etc.)</td>
                <td>Bone animations triggered by flight dynamics</td>
              </tr>
              <tr>
                <td>Door Operations</td>
                <td>Opening/closing doors or hatches</td>
                <td>State-based keyframe animations</td>
              </tr>
              <tr>
                <td>Status Lights</td>
                <td>Navigation lights, status indicators</td>
                <td>Material emission animation</td>
              </tr>
            </tbody>
          </table>
          
          <div class="alert alert-warning">
            <strong>Note:</strong> For models with animations, the animation names in the model file must match the animation names in the model registration.
          </div>
          
          <h3>Level of Detail (LOD)</h3>
          <p>
            For better performance, you can provide multiple detail levels for the same model:
          </p>
          
          <div class="code-block">
            <pre><code>// Example: Register a model with LOD
simulationModule.registerSimulationModel({
type: 'high-detail-drone',
category: 'aerial',
name: 'High Detail Drone',
lod: [
{
distance: 0,
modelPath: '/assets/models/drone-high.glb',
scale: 1.0
},
{
distance: 100,
modelPath: '/assets/models/drone-medium.glb',
scale: 1.0
},
{
distance: 500,
modelPath: '/assets/models/drone-low.glb',
scale: 1.0
}
],
physics: {
mass: 1.5,
maxSpeed: 15,
maxAcceleration: 5,
rotationSpeed: 2,
maxAltitude: 120
},
sensors: ['camera', 'gps', 'imu'],
defaultPose: {
position: { x: 0, y: 0, z: 0 },
rotation: { x: 0, y: 0, z: 0 }
}
});</code></pre>
</div>

          <h3>Model Conversion Tools</h3>
          <p>
            These tools can help with model conversion and optimization:
          </p>
          
          <ul>
            <li><strong><a href="https://github.com/KhronosGroup/glTF-Blender-IO" target="_blank">glTF-Blender-IO</a></strong>: Blender addon for glTF/GLB export</li>
            <li><strong><a href="https://github.com/KhronosGroup/glTF-Validator" target="_blank">glTF-Validator</a></strong>: Validates glTF/GLB files for standards compliance</li>
            <li><strong><a href="https://github.com/google/draco" target="_blank">Draco Encoder/Decoder</a></strong>: Tools for model compression</li>
            <li><strong><a href="https://github.com/zeux/meshoptimizer" target="_blank">meshoptimizer</a></strong>: Mesh optimization library</li>
            <li><strong><a href="https://gltf.report/" target="_blank">glTF Report</a></strong>: Online tool for analyzing glTF files</li>
          </ul>
        </div>
      </div>

      <div class="card mb-4">
        <div class="card-header bg-primary text-white">
          <h2 id="optimization-techniques">Advanced Optimization</h2>
        </div>
        <div class="card-body">
          <h3>Performance Optimization Techniques</h3>
          <p>
            The IASMS Simulation system includes several advanced optimization techniques to ensure smooth performance, even with complex scenes and many entities.
          </p>
          
          <h4>Rendering Optimizations</h4>
          <table class="table table-bordered">
            <thead class="thead-light">
              <tr>
                <th>Technique</th>
                <th>Description</th>
                <th>Implementation</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>Frustum Culling</td>
                <td>Skip rendering objects outside the camera view</td>
                <td>Automatic in Three.js, enhanced with custom bounding volumes</td>
              </tr>
              <tr>
                <td>Occlusion Culling</td>
                <td>Skip rendering objects hidden behind others</td>
                <td>Custom implementation using depth testing and object hierarchy</td>
              </tr>
              <tr>
                <td>Level of Detail (LOD)</td>
                <td>Use simpler models at greater distances</td>
                <td><code>THREE.LOD</code> with multiple detail levels</td>
              </tr>
              <tr>
                <td>Instancing</td>
                <td>Render many similar objects efficiently</td>
                <td><code>THREE.InstancedMesh</code> for repeated objects</td>
              </tr>
              <tr>
                <td>Texture Atlasing</td>
                <td>Combine multiple textures into one</td>
                <td>Custom UV mapping with shared texture atlases</td>
              </tr>
              <tr>
                <td>Shader Optimization</td>
                <td>Simplify shaders for better performance</td>
                <td>Custom material variants with performance presets</td>
              </tr>
            </tbody>
          </table>
          
          <h4>Memory Management</h4>
          <p>
            Efficient memory management is crucial for long-running simulations:
          </p>
          
          <div class="code-block">
            <pre><code>// Example: Dispose of Three.js resources
function disposeEntity(entity) {
// Dispose of geometry
if (entity.geometry) {
entity.geometry.dispose();
}

// Dispose of material(s)
if (entity.material) {
if (Array.isArray(entity.material)) {
entity.material.forEach(material => {
disposeMaterial(material);
});
} else {
disposeMaterial(entity.material);
}
}

// Dispose of textures in material
function disposeMaterial(material) {
// Dispose of texture maps
for (const prop in material) {
if (material[prop] && material[prop].isTexture) {
material[prop].dispose();
}
}

    // Dispose of material itself
    material.dispose();
}

// Remove from parent
if (entity.parent) {
entity.parent.remove(entity);
}

// Process children recursively
while (entity.children.length > 0) {
disposeEntity(entity.children[0]);
}
}</code></pre>
</div>

          <h4>Object Pooling</h4>
          <p>
            Object pooling reduces garbage collection by reusing objects:
          </p>
          
          <div class="code-block">
            <pre><code>// Example: Object pool for vehicle entities
class VehicleEntityPool {
constructor(initialSize = 20) {
this.pool = [];
this.active = new Map();

    // Initialize pool with inactive entities
    for (let i = 0; i < initialSize; i++) {
      this.pool.push(this._createEntity());
    }
}

// Create a new entity for the pool
_createEntity() {
const entity = new THREE.Group();
entity.userData.pooled = true;
entity.visible = false;
return entity;
}

// Get an entity from the pool
acquire(id, type) {
let entity;

    // Get from pool or create new
    if (this.pool.length > 0) {
      entity = this.pool.pop();
    } else {
      entity = this._createEntity();
    }
    
    // Configure entity
    entity.name = id;
    entity.userData.type = type;
    entity.userData.acquired = Date.now();
    entity.visible = true;
    
    // Add to active map
    this.active.set(id, entity);
    
    return entity;
}

// Return an entity to the pool
release(id) {
const entity = this.active.get(id);

    if (entity) {
      // Reset entity state
      entity.position.set(0, 0, 0);
      entity.rotation.set(0, 0, 0);
      entity.scale.set(1, 1, 1);
      entity.visible = false;
      
      // Remove children while preserving pool structure
      while (entity.children.length > 0) {
        const child = entity.children[0];
        if (child.userData.pooled) {
          // Keep pooled structure
          child.visible = false;
        } else {
          // Remove non-pooled children
          entity.remove(child);
        }
      }
      
      // Clean up userData but keep pooled flag
      const wasPooled = entity.userData.pooled;
      entity.userData = { pooled: wasPooled };
      
      // Return to pool and remove from active map
      this.pool.push(entity);
      this.active.delete(id);
    }
}

// Get an active entity by ID
get(id) {
return this.active.get(id);
}

// Check if an entity is active
isActive(id) {
return this.active.has(id);
}

// Get pool statistics
getStats() {
return {
poolSize: this.pool.length,
activeCount: this.active.size,
totalEntities: this.pool.length + this.active.size
};
}
}</code></pre>
</div>

          <h4>Entity Throttling</h4>
          <p>
            When the entity count gets too high, apply throttling techniques:
          </p>
          
          <div class="code-block">
            <pre><code>// Example: Entity update throttling
class EntityThrottler {
constructor(maxUpdatesPerFrame = 50) {
this.maxUpdatesPerFrame = maxUpdatesPerFrame;
this.updateQueue = [];
this.frameCount = 0;
}

// Add entity to update queue
queueUpdate(entity, updateData) {
this.updateQueue.push({ entity, updateData });
}

// Process updates for this frame
processUpdates() {
this.frameCount++;

    // Sort updates by priority
    this.updateQueue.sort((a, b) => {
      // Prioritize updates based on criteria:
      // 1. Entity visibility (visible first)
      // 2. Distance to camera (closer first)
      // 3. Update type (creation before updates)
      
      // Implementation details...
      return priorityA - priorityB;
    });
    
    // Process only the allowed number of updates this frame
    const updatesThisFrame = Math.min(this.maxUpdatesPerFrame, this.updateQueue.length);
    
    for (let i = 0; i < updatesThisFrame; i++) {
      const { entity, updateData } = this.updateQueue[i];
      this._applyUpdate(entity, updateData);
    }
    
    // Remove processed updates
    this.updateQueue.splice(0, updatesThisFrame);
    
    // Log throttling metrics
    if (this.updateQueue.length > 0) {
      console.log(`Throttled ${this.updateQueue.length} updates to next frame`);
    }
}

// Apply an update to an entity
_applyUpdate(entity, updateData) {
// Implementation details...
}
}</code></pre>
</div>

          <h4>Worker Threads</h4>
          <p>
            Offload heavy computation to worker threads:
          </p>
          
          <div class="code-block">
            <pre><code>// Example: Using web workers for physics calculations
// Main thread code
class PhysicsManager {
constructor() {
this.worker = new Worker('/js/physics-worker.js');
this.pendingUpdates = new Map();
this.nextUpdateId = 1;

    // Set up message handler
    this.worker.onmessage = (event) => {
      const { updateId, results } = event.data;
      
      // Get callback for this update
      const callback = this.pendingUpdates.get(updateId);
      if (callback) {
        callback(results);
        this.pendingUpdates.delete(updateId);
      }
    };
}

// Send physics calculation to worker
calculatePhysics(entities, deltaTime) {
return new Promise((resolve) => {
const updateId = this.nextUpdateId++;

      // Store callback
      this.pendingUpdates.set(updateId, resolve);
      
      // Send data to worker
      this.worker.postMessage({
        updateId,
        entities: this._serializeEntities(entities),
        deltaTime
      });
    });
}

// Serialize entities for transfer to worker
_serializeEntities(entities) {
// Simplify entities to transfer only necessary data
return entities.map(entity => ({
id: entity.id,
position: {
x: entity.position.x,
y: entity.position.y,
z: entity.position.z
},
velocity: entity.velocity ? {
x: entity.velocity.x,
y: entity.velocity.y,
z: entity.velocity.z
} : null,
mass: entity.mass,
forces: entity.forces,
collider: entity.collider
}));
}
}

// Worker thread code (physics-worker.js)
self.onmessage = function(event) {
const { updateId, entities, deltaTime } = event.data;

// Perform physics calculations
const results = calculatePhysics(entities, deltaTime);

// Send results back to main thread
self.postMessage({
updateId,
results
});
};

function calculatePhysics(entities, deltaTime) {
// Physics simulation logic...
return updatedEntities;
}</code></pre>
</div>

          <h4>WebGL Context Monitoring</h4>
          <p>
            Monitor WebGL context health to prevent crashes:
          </p>
          
          <div class="code-block">
            <pre><code>// Example: WebGL context monitoring
class WebGLMonitor {
constructor(renderer) {
this.renderer = renderer;
this.gl = renderer.getContext();
this.isContextLost = false;
this.maxTextureSize = this.gl.getParameter(this.gl.MAX_TEXTURE_SIZE);
this.maxViewportDims = this.gl.getParameter(this.gl.MAX_VIEWPORT_DIMS);
this.extensionsUsed = {};

    // Monitor for context loss
    this.renderer.domElement.addEventListener('webglcontextlost', (event) => {
      event.preventDefault();
      this.isContextLost = true;
      this.onContextLost();
    }, false);
    
    // Monitor for context restoration
    this.renderer.domElement.addEventListener('webglcontextrestored', () => {
      this.isContextLost = false;
      this.onContextRestored();
    }, false);
    
    // Start monitoring
    this.startMonitoring();
}

// Get information about WebGL capabilities
getCapabilities() {
return {
maxTextureSize: this.maxTextureSize,
maxViewportDims: this.maxViewportDims,
maxFragmentUniformVectors: this.gl.getParameter(this.gl.MAX_FRAGMENT_UNIFORM_VECTORS),
maxVertexUniformVectors: this.gl.getParameter(this.gl.MAX_VERTEX_UNIFORM_VECTORS),
maxVaryingVectors: this.gl.getParameter(this.gl.MAX_VARYING_VECTORS),
floatTexturesSupported: !!this.gl.getExtension('OES_texture_float'),
instancedArraysSupported: !!this.gl.getExtension('ANGLE_instanced_arrays'),
anisotropicSupported: !!this.gl.getExtension('EXT_texture_filter_anisotropic')
};
}

// Track when an extension is used
trackExtensionUsage(extensionName) {
this.extensionsUsed[extensionName] = true;
}

// Start monitoring WebGL context
startMonitoring() {
this.monitorInterval = setInterval(() => {
this.checkResourceUsage();
}, 5000); // Check every 5 seconds
}

// Check WebGL resource usage
checkResourceUsage() {
if (this.isContextLost) return;

    try {
      const memoryInfo = (this.gl as any).getExtension('WEBGL_debug_renderer_info');
      
      if (memoryInfo) {
        const vendor = this.gl.getParameter(memoryInfo.UNMASKED_VENDOR_WEBGL);
        const renderer = this.gl.getParameter(memoryInfo.UNMASKED_RENDERER_WEBGL);
        
        console.log(`WebGL Vendor: ${vendor}, Renderer: ${renderer}`);
      }
      
      // Check for memory leaks by tracking object counts
      // This is approximate since WebGL doesn't expose direct memory metrics
      const textureCount = (this.renderer as any).info.memory.textures;
      const geometryCount = (this.renderer as any).info.memory.geometries;
      
      console.log(`WebGL Resources - Textures: ${textureCount}, Geometries: ${geometryCount}`);
      
      // Alert if resource usage is excessive
      if (textureCount > 1000 || geometryCount > 1000) {
        console.warn('WebGL resource usage is high, consider cleanup');
      }
    } catch (error) {
      console.error('Error monitoring WebGL context:', error);
    }
}

// Handle context loss
onContextLost() {
console.warn('WebGL context lost - attempting to recover');

    // Notify application to pause rendering and interactions
    if (typeof window.onWebGLContextLost === 'function') {
      window.onWebGLContextLost();
    }
}

// Handle context restoration
onContextRestored() {
console.log('WebGL context restored');

    // Reinitialize renderer resources
    this.renderer.resetState();
    
    // Notify application to resume
    if (typeof window.onWebGLContextRestored === 'function') {
      window.onWebGLContextRestored();
    }
}

// Stop monitoring
stopMonitoring() {
if (this.monitorInterval) {
clearInterval(this.monitorInterval);
}
}
}

// Usage example
const webglMonitor = new WebGLMonitor(renderer);</code></pre>
</div>

          <h3>Adaptive Quality</h3>
          <p>
            The system can dynamically adjust quality based on performance:
          </p>
          
          <div class="code-block">
            <pre><code>// Example: Adaptive quality manager
class AdaptiveQualityManager {
constructor(renderer, scene, camera) {
this.renderer = renderer;
this.scene = scene;
this.camera = camera;

    this.fpsTarget = 60;
    this.fpsMin = 30;
    this.fpsHistory = [];
    this.historySize = 30; // 30 frames history
    this.currentQualityLevel = 'high'; // 'ultra', 'high', 'medium', 'low'
    
    this.qualityLevels = {
      ultra: {
        pixelRatio: window.devicePixelRatio,
        shadows: true,
        shadowMapSize: 2048,
        postprocessing: true,
        maxParticles: 10000,
        drawDistance: 5000,
        antialiasing: true
      },
      high: {
        pixelRatio: Math.min(window.devicePixelRatio, 1.5),
        shadows: true,
        shadowMapSize: 1024,
        postprocessing: true,
        maxParticles: 5000,
        drawDistance: 3000,
        antialiasing: true
      },
      medium: {
        pixelRatio: 1.0,
        shadows: true,
        shadowMapSize: 512,
        postprocessing: false,
        maxParticles: 2000,
        drawDistance: 2000,
        antialiasing: false
      },
      low: {
        pixelRatio: 0.75,
        shadows: false,
        shadowMapSize: 256,
        postprocessing: false,
        maxParticles: 500,
        drawDistance: 1000,
        antialiasing: false
      }
    };
    
    // Apply initial quality settings
    this.applyQualitySettings(this.currentQualityLevel);
}

// Update performance tracking
update() {
// Calculate FPS
const now = performance.now();
const lastUpdateTime = this.lastUpdateTime || now;
const deltaTime = now - lastUpdateTime;
this.lastUpdateTime = now;

    const fps = 1000 / deltaTime;
    
    // Add to history
    this.fpsHistory.push(fps);
    if (this.fpsHistory.length > this.historySize) {
      this.fpsHistory.shift();
    }
    
    // Calculate average FPS
    const avgFps = this.fpsHistory.reduce((sum, fps) => sum + fps, 0) / 
                  this.fpsHistory.length;
    
    // Adjust quality if needed
    this.adjustQuality(avgFps);
}

// Adjust quality based on performance
adjustQuality(currentFps) {
if (this.fpsHistory.length < this.historySize) {
// Wait until we have enough history
return;
}

    // Determine if we need to change quality
    let newQuality = this.currentQualityLevel;
    
    if (currentFps < this.fpsMin) {
      // Performance is poor, decrease quality
      newQuality = this.getNextLowerQuality(this.currentQualityLevel);
    } else if (currentFps > this.fpsTarget * 1.2 && 
              this.currentQualityLevel !== 'ultra') {
      // Performance is excellent, consider increasing quality
      newQuality = this.getNextHigherQuality(this.currentQualityLevel);
    }
    
    // Apply new quality if changed
    if (newQuality !== this.currentQualityLevel) {
      console.log(`Adjusting quality: ${this.currentQualityLevel} -> ${newQuality} (FPS: ${currentFps.toFixed(1)})`);
      this.applyQualitySettings(newQuality);
      this.currentQualityLevel = newQuality;
      
      // Clear history after changing quality
      this.fpsHistory = [];
    }
}

// Get the next lower quality level
getNextLowerQuality(current) {
const levels = Object.keys(this.qualityLevels);
const currentIndex = levels.indexOf(current);

    if (currentIndex < levels.length - 1) {
      return levels[currentIndex + 1];
    }
    
    return current;
}

// Get the next higher quality level
getNextHigherQuality(current) {
const levels = Object.keys(this.qualityLevels);
const currentIndex = levels.indexOf(current);

    if (currentIndex > 0) {
      return levels[currentIndex - 1];
    }
    
    return current;
}

// Apply quality settings
applyQualitySettings(level) {
const settings = this.qualityLevels[level];

    // Apply renderer settings
    this.renderer.setPixelRatio(settings.pixelRatio);
    this.renderer.shadowMap.enabled = settings.shadows;
    
    if (settings.shadows) {
      this.renderer.shadowMap.type = THREE.PCFSoftShadowMap;
      
      // Update shadow map size for all lights
      this.scene.traverse(object => {
        if (object.isLight && object.shadow) {
          object.shadow.mapSize.width = settings.shadowMapSize;
          object.shadow.mapSize.height = settings.shadowMapSize;
          object.shadow.map = null; // Force shadow map recreation
        }
      });
    }
    
    // Apply camera settings
    this.camera.far = settings.drawDistance;
    this.camera.updateProjectionMatrix();
    
    // Apply antialiasing if renderer supports it
    if (this.renderer.capabilities.isWebGL2) {
      this.renderer.antialias = settings.antialiasing;
    }
    
    // Enable/disable postprocessing
    if (this.composer) {
      this.composer.enabled = settings.postprocessing;
    }
    
    // Apply particle limits
    window.maxParticles = settings.maxParticles;
    
    // Emit quality change event
    this.dispatchEvent({ type: 'quality-changed', level });
}
}</code></pre>
</div>
</div>
</div>

      <div class="card mb-4">
        <div class="card-header bg-primary text-white">
          <h2 id="webxr-tracking">WebXR Tracking Features</h2>
        </div>
        <div class="card-body">
          <h3>Advanced WebXR Tracking</h3>
          <p>
            The IASMS Simulation system leverages advanced WebXR tracking capabilities for enhanced immersion and interaction in both VR and AR modes.
          </p>
          
          <h4>Supported Tracking Features</h4>
          <table class="table table-bordered">
            <thead class="thead-light">
              <tr>
                <th>Feature</th>
                <th>Description</th>
                <th>Supported Devices</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>Hand Tracking</td>
                <td>Track user's hands without controllers</td>
                <td>Meta Quest 2/3/Pro, Magic Leap 2, HoloLens 2</td>
              </tr>
              <tr>
                <td>Eye Tracking</td>
                <td>Track eye gaze for selection and interaction</td>
                <td>Meta Quest Pro, HTC Vive Pro Eye, Pico 4 Enterprise</td>
              </tr>
              <tr>
                <td>Spatial Anchors</td>
                <td>Persist virtual objects in real-world locations</td>
                <td>Most AR devices, Meta Quest with passthrough</td>
              </tr>
              <tr>
                <td>Plane Detection</td>
                <td>Detect and use real-world surfaces</td>
                <td>AR devices, ARCore/ARKit compatible phones</td>
              </tr>
              <tr>
                <td>Depth Sensing</td>
                <td>Understand real-world 3D structure</td>
                <td>iPhone Pro (LiDAR), Android depth-enabled devices</td>
              </tr>
              <tr>
                <td>Image Tracking</td>
                <td>Detect and track specific images</td>
                <td>Most AR devices and AR-capable phones</td>
              </tr>
            </tbody>
          </table>
          
          <h3>Hand Tracking</h3>
          <p>
            Hand tracking enables natural interaction with the simulation:
          </p>
          
          <div class="code-block">
            <pre><code>// Example: Hand tracking setup and gesture detection
class HandTrackingManager {
constructor(renderer, scene) {
this.renderer = renderer;
this.scene = scene;
this.hands = {
left: null,
right: null
};
this.handModels = {
left: null,
right: null
};

    // Gesture state
    this.gestures = {
      pinch: {
        left: { active: false, startTime: 0, position: new THREE.Vector3() },
        right: { active: false, startTime: 0, position: new THREE.Vector3() }
      },
      grab: {
        left: { active: false, startTime: 0, object: null },
        right: { active: false, startTime: 0, object: null }
      },
      point: {
        left: { active: false, startTime: 0, direction: new THREE.Vector3() },
        right: { active: false, startTime: 0, direction: new THREE.Vector3() }
      }
    };
    
    // Joint name mapping for easy access
    this.jointMap = {
      thumb: ['thumb-metacarpal', 'thumb-phalanx-proximal', 'thumb-phalanx-distal', 'thumb-tip'],
      index: ['index-finger-metacarpal', 'index-finger-phalanx-proximal', 'index-finger-phalanx-intermediate', 'index-finger-phalanx-distal', 'index-finger-tip'],
      middle: ['middle-finger-metacarpal', 'middle-finger-phalanx-proximal', 'middle-finger-phalanx-intermediate', 'middle-finger-phalanx-distal', 'middle-finger-tip'],
      ring: ['ring-finger-metacarpal', 'ring-finger-phalanx-proximal', 'ring-finger-phalanx-intermediate', 'ring-finger-phalanx-distal', 'ring-finger-tip'],
      pinky: ['pinky-finger-metacarpal', 'pinky-finger-phalanx-proximal', 'pinky-finger-phalanx-intermediate', 'pinky-finger-phalanx-distal', 'pinky-finger-tip'],
      wrist: ['wrist']
    };
}

// Initialize hand tracking
initialize(xrSession) {
if (!xrSession) return false;

    const handModelFactory = new XRHandModelFactory();
    
    // Set up left hand
    this.hands.left = this.renderer.xr.getHand(0);
    this.handModels.left = handModelFactory.createHandModel(this.hands.left, 'mesh');
    this.hands.left.add(this.handModels.left);
    this.scene.add(this.hands.left);
    
    // Set up right hand
    this.hands.right = this.renderer.xr.getHand(1);
    this.handModels.right = handModelFactory.createHandModel(this.hands.right, 'mesh');
    this.hands.right.add(this.handModels.right);
    this.scene.add(this.hands.right);
    
    console.log('Hand tracking initialized');
    return true;
}

// Update hand tracking and detect gestures
update() {
this.updateHand('left');
this.updateHand('right');

    // Detect gestures
    this.detectPinchGesture('left');
    this.detectPinchGesture('right');
    this.detectGrabGesture('left');
    this.detectGrabGesture('right');
    this.detectPointGesture('left');
    this.detectPointGesture('right');
}

// Update hand state
updateHand(handedness) {
const hand = this.hands[handedness];

    if (!hand) return;
    
    // Check if hand is being tracked
    const joints = {};
    let isTracking = false;
    
    // Gather joint information
    for (const fingerName in this.jointMap) {
      joints[fingerName] = [];
      
      for (const jointName of this.jointMap[fingerName]) {
        const joint = hand.joints[jointName];
        
        if (joint && joint.visible) {
          isTracking = true;
          joints[fingerName].push({
            name: jointName,
            position: joint.position.clone(),
            quaternion: joint.quaternion.clone(),
            radius: joint.radius || 0.005
          });
        }
      }
    }
    
    // Store hand data
    hand.userData.joints = joints;
    hand.userData.isTracking = isTracking;
}

// Detect pinch gesture (thumb tip touching index tip)
detectPinchGesture(handedness) {
const hand = this.hands[handedness];
const gestureState = this.gestures.pinch[handedness];

    if (!hand || !hand.userData.isTracking) {
      // Reset state if hand not tracked
      if (gestureState.active) {
        gestureState.active = false;
        this.dispatchGestureEvent('pinchend', handedness);
      }
      return;
    }
    
    // Get thumb and index tips
    const thumbTip = hand.userData.joints.thumb[3]?.position;
    const indexTip = hand.userData.joints.index[4]?.position;
    
    if (!thumbTip || !indexTip) return;
    
    // Calculate distance between tips
    const distance = thumbTip.distanceTo(indexTip);
    
    // Pinch threshold (in meters)
    const pinchThreshold = 0.03;
    
    // Check if pinch is active
    if (distance < pinchThreshold) {
      if (!gestureState.active) {
        // Pinch started
        gestureState.active = true;
        gestureState.startTime = Date.now();
        gestureState.position.copy(
          new THREE.Vector3().addVectors(thumbTip, indexTip).multiplyScalar(0.5)
        );
        this.dispatchGestureEvent('pinchstart', handedness, {
          position: gestureState.position.clone()
        });
      } else {
        // Pinch continuing
        const newPosition = new THREE.Vector3()
          .addVectors(thumbTip, indexTip).multiplyScalar(0.5);
        
        this.dispatchGestureEvent('pinchmove', handedness, {
          position: newPosition.clone(),
          delta: new THREE.Vector3().subVectors(newPosition, gestureState.position)
        });
        
        gestureState.position.copy(newPosition);
      }
    } else if (gestureState.active) {
      // Pinch ended
      gestureState.active = false;
      this.dispatchGestureEvent('pinchend', handedness, {
        duration: Date.now() - gestureState.startTime
      });
    }
}

// Detect grab gesture (all fingers curled)
detectGrabGesture(handedness) {
const hand = this.hands[handedness];
const gestureState = this.gestures.grab[handedness];

    if (!hand || !hand.userData.isTracking) {
      // Reset state if hand not tracked
      if (gestureState.active) {
        gestureState.active = false;
        this.dispatchGestureEvent('grabend', handedness);
      }
      return;
    }
    
    // Get finger tip and middle joint positions
    const fingersCurled = this._areFingersCurled(hand);
    
    if (fingersCurled) {
      if (!gestureState.active) {
        // Grab started
        gestureState.active = true;
        gestureState.startTime = Date.now();
        
        // Check for intersecting objects
        const palmPosition = hand.joints['wrist'].position.clone();
        const grabbedObject = this._findGrabbableObject(palmPosition);
        gestureState.object = grabbedObject;
        
        this.dispatchGestureEvent('grabstart', handedness, {
          position: palmPosition,
          object: grabbedObject
        });
      } else {
        // Grab continuing - update grabbed object position if present
        if (gestureState.object) {
          const palmPosition = hand.joints['wrist'].position.clone();
          const palmOrientation = hand.joints['wrist'].quaternion.clone();
          
          this.dispatchGestureEvent('grabmove', handedness, {
            position: palmPosition,
            orientation: palmOrientation,
            object: gestureState.object
          });
        }
      }
    } else if (gestureState.active) {
      // Grab ended
      gestureState.active = false;
      
      this.dispatchGestureEvent('grabend', handedness, {
        duration: Date.now() - gestureState.startTime,
        object: gestureState.object
      });
      
      gestureState.object = null;
    }
}

// Check if fingers are curled (for grab gesture)
_areFingersCurled(hand) {
const joints = hand.userData.joints;
const fingers = ['index', 'middle', 'ring', 'pinky'];

    // Consider fingers curled if at least 3 of 4 fingers are curled
    let curledCount = 0;
    
    for (const fingerName of fingers) {
      const finger = joints[fingerName];
      
      if (finger.length >= 4) {
        // Calculate curl by comparing tip-to-knuckle distance vs finger length
        const tipPos = finger[finger.length - 1].position;
        const knucklePos = finger[1].position;
        const tipToKnuckle = tipPos.distanceTo(knucklePos);
        
        // Calculate approximate finger length (sum of segments)
        let fingerLength = 0;
        for (let i = 1; i < finger.length - 1; i++) {
          fingerLength += finger[i].position.distanceTo(finger[i+1].position);
        }
        
        // If tip is close to knuckle relative to finger length, finger is curled
        if (tipToKnuckle < fingerLength * 0.6) {
          curledCount++;
        }
      }
    }
    
    return curledCount >= 3;
}

// Find grabbable object near position
_findGrabbableObject(position, radius = 0.1) {
// Use raycaster or sphere intersection to find objects
// Implementation details...
return closestObject || null;
}

// Detect point gesture (index extended, others curled)
detectPointGesture(handedness) {
const hand = this.hands[handedness];
const gestureState = this.gestures.point[handedness];

    if (!hand || !hand.userData.isTracking) {
      // Reset state if hand not tracked
      if (gestureState.active) {
        gestureState.active = false;
        this.dispatchGestureEvent('pointend', handedness);
      }
      return;
    }
    
    // Check if index is extended and other fingers are curled
    const isPointing = this._isPointGesture(hand);
    
    if (isPointing) {
      // Get index finger direction
      const indexTip = hand.userData.joints.index[4]?.position;
      const indexKnuckle = hand.userData.joints.index[1]?.position;
      
      if (indexTip && indexKnuckle) {
        const direction = new THREE.Vector3()
          .subVectors(indexTip, indexKnuckle).normalize();
        
        if (!gestureState.active) {
          // Point started
          gestureState.active = true;
          gestureState.startTime = Date.now();
          gestureState.direction.copy(direction);
          
          this.dispatchGestureEvent('pointstart', handedness, {
            origin: indexKnuckle.clone(),
            direction: direction.clone()
          });
        } else {
          // Point continuing
          this.dispatchGestureEvent('pointmove', handedness, {
            origin: indexKnuckle.clone(),
            direction: direction.clone(),
            deltaDirection: new THREE.Vector3().subVectors(direction, gestureState.direction)
          });
          
          gestureState.direction.copy(direction);
        }
      }
    } else if (gestureState.active) {
      // Point ended
      gestureState.active = false;
      
      this.dispatchGestureEvent('pointend', handedness, {
        duration: Date.now() - gestureState.startTime
      });
    }
}

// Check if hand is making a pointing gesture
_isPointGesture(hand) {
const joints = hand.userData.joints;

    // Index should be extended
    const indexExtended = this._isFingerExtended(joints.index);
    
    // Other fingers should be curled
    const middleCurled = !this._isFingerExtended(joints.middle);
    const ringCurled = !this._isFingerExtended(joints.ring);
    const pinkyCurled = !this._isFingerExtended(joints.pinky);
    
    // Thumb state is not considered for pointing
    
    return indexExtended && middleCurled && ringCurled && pinkyCurled;
}

// Check if a finger is extended
_isFingerExtended(finger) {
if (finger.length < 4) return false;

    // Calculate extension by comparing tip-to-knuckle distance vs finger length
    const tipPos = finger[finger.length - 1].position;
    const knucklePos = finger[1].position;
    const tipToKnuckle = tipPos.distanceTo(knucklePos);
    
    // Calculate approximate finger length (sum of segments)
    let fingerLength = 0;
    for (let i = 1; i < finger.length - 1; i++) {
      fingerLength += finger[i].position.distanceTo(finger[i+1].position);
    }
    
    // If tip is far from knuckle relative to finger length, finger is extended
    return tipToKnuckle > fingerLength * 0.7;
}

// Dispatch gesture event
dispatchGestureEvent(type, handedness, data = {}) {
const event = {
type,
handedness,
hand: this.hands[handedness],
...data,
timestamp: Date.now()
};

    // Dispatch to event listeners
    if (typeof this.onGesture === 'function') {
      this.onGesture(event);
    }
    
    // Dispatch specific event
    if (typeof this[`on${type}`] === 'function') {
      this[`on${type}`](event);
    }
}
}</code></pre>
</div>

          <h3>Eye Tracking</h3>
          <p>
            Eye tracking enables gaze-based interaction and foveated rendering:
          </p>
          
          <div class="code-block">
            <pre><code>// Example: Eye tracking for gaze-based interaction
class GazeInteractionManager {
constructor(scene, camera, eyeTracking) {
this.scene = scene;
this.camera = camera;
this.eyeTracking = eyeTracking;
this.raycaster = new THREE.Raycaster();

    // Gaze state
    this.gazeTarget = null;
    this.lastGazeTarget = null;
    this.gazeDuration = 0;
    this.gazeStartTime = 0;
    this.isDwelling = false;
    this.dwellThreshold = 1000; // 1 second for selection
    
    // Visual feedback
    this.gazeIndicator = this._createGazeIndicator();
    this.scene.add(this.gazeIndicator);
    
    // Interactable objects
    this.interactables = [];
}

// Create visual indicator for gaze
_createGazeIndicator() {
const geometry = new THREE.RingGeometry(0.01, 0.02, 32);
const material = new THREE.MeshBasicMaterial({
color: 0x00ffff,
opacity: 0.5,
transparent: true,
side: THREE.DoubleSide,
depthTest: false
});

    const indicator = new THREE.Mesh(geometry, material);
    indicator.visible = false;
    
    return indicator;
}

// Register an object as interactable with gaze
registerInteractable(object, options = {}) {
object.userData.gazeInteractable = true;
object.userData.gazeOptions = {
dwellThreshold: options.dwellThreshold || this.dwellThreshold,
onGazeEnter: options.onGazeEnter,
onGazeExit: options.onGazeExit,
onGazeDwell: options.onGazeDwell
};

    this.interactables.push(object);
}

// Unregister an object
unregisterInteractable(object) {
const index = this.interactables.indexOf(object);
if (index !== -1) {
this.interactables.splice(index, 1);
}

    object.userData.gazeInteractable = false;
    delete object.userData.gazeOptions;
}

// Update gaze interaction
update(deltaTime) {
// Get eye tracking data
const gazeData = this.eyeTracking.update();

    if (!gazeData || !gazeData.looking) {
      // No gaze data available or user not looking
      this._clearGaze();
      return;
    }
    
    // Set raycaster from gaze direction
    this.raycaster.set(gazeData.origin, gazeData.direction);
    
    // Find intersections with interactable objects
    const intersects = this.raycaster.intersectObjects(this.interactables, true);
    
    if (intersects.length > 0) {
      // Find the first interactable object or parent
      let gazeTarget = null;
      let targetIntersection = null;
      
      for (const intersection of intersects) {
        let object = intersection.object;
        
        // Walk up the parent chain to find interactable
        while (object && !object.userData.gazeInteractable) {
          object = object.parent;
        }
        
        if (object && object.userData.gazeInteractable) {
          gazeTarget = object;
          targetIntersection = intersection;
          break;
        }
      }
      
      if (gazeTarget) {
        // Update gaze indicator
        this.gazeIndicator.visible = true;
        this.gazeIndicator.position.copy(targetIntersection.point);
        
        // Orient indicator to face normal
        if (targetIntersection.face) {
          this.gazeIndicator.lookAt(
            targetIntersection.point.clone().add(targetIntersection.face.normal)
          );
        } else {
          this.gazeIndicator.lookAt(this.camera.position);
        }
        
        // Handle gaze target change
        if (this.gazeTarget !== gazeTarget) {
          // Exit previous target
          if (this.gazeTarget && this.gazeTarget.userData.gazeOptions.onGazeExit) {
            this.gazeTarget.userData.gazeOptions.onGazeExit({
              object: this.gazeTarget,
              duration: this.gazeDuration
            });
          }
          
          // Enter new target
          this.gazeTarget = gazeTarget;
          this.gazeStartTime = Date.now();
          this.gazeDuration = 0;
          this.isDwelling = false;
          
          if (gazeTarget.userData.gazeOptions.onGazeEnter) {
            gazeTarget.userData.gazeOptions.onGazeEnter({
              object: gazeTarget,
              point: targetIntersection.point.clone()
            });
          }
        } else {
          // Continue gazing at same target
          this.gazeDuration = Date.now() - this.gazeStartTime;
          
          // Check for dwell selection
          const dwellThreshold = gazeTarget.userData.gazeOptions.dwellThreshold || 
                               this.dwellThreshold;
          
          if (!this.isDwelling && this.gazeDuration >= dwellThreshold) {
            this.isDwelling = true;
            
            // Trigger dwell callback
            if (gazeTarget.userData.gazeOptions.onGazeDwell) {
              gazeTarget.userData.gazeOptions.onGazeDwell({
                object: gazeTarget,
                duration: this.gazeDuration,
                point: targetIntersection.point.clone()
              });
            }
            
            // Visual feedback for selection
            this._showSelectionFeedback(targetIntersection.point);
          }
          
          // Update gaze indicator size based on dwell progress
          if (!this.isDwelling) {
            const progress = Math.min(this.gazeDuration / dwellThreshold, 1.0);
            this.gazeIndicator.scale.set(
              1.0 + progress * 0.5,
              1.0 + progress * 0.5,
              1.0
            );
            
            // Update indicator color
            this.gazeIndicator.material.color.setHSL(
              0.55 - progress * 0.5, // Color shifts from cyan to blue
              1.0,
              0.5
            );
          }
        }
      } else {
        this._clearGaze();
      }
    } else {
      this._clearGaze();
    }
    
    // Store last gaze target
    this.lastGazeTarget = this.gazeTarget;
}

// Clear current gaze state
_clearGaze() {
// Exit current target if exists
if (this.gazeTarget && this.gazeTarget.userData.gazeOptions.onGazeExit) {
this.gazeTarget.userData.gazeOptions.onGazeExit({
object: this.gazeTarget,
duration: this.gazeDuration
});
}

    // Reset state
    this.gazeTarget = null;
    this.gazeDuration = 0;
    this.isDwelling = false;
    
    // Hide indicator
    this.gazeIndicator.visible = false;
}

// Show visual feedback for selection
_showSelectionFeedback(position) {
// Create a ripple effect at selection point
const geometry = new THREE.RingGeometry(0.02, 0.04, 32);
const material = new THREE.MeshBasicMaterial({
color: 0x00ffff,
opacity: 1.0,
transparent: true,
side: THREE.DoubleSide,
depthTest: false
});

    const ripple = new THREE.Mesh(geometry, material);
    ripple.position.copy(position);
    ripple.lookAt(this.camera.position);
    this.scene.add(ripple);
    
    // Animate and remove
    const startTime = Date.now();
    const duration = 500; // ms
    
    const animateRipple = () => {
      const elapsed = Date.now() - startTime;
      const progress = Math.min(elapsed / duration, 1.0);
      
      ripple.scale.set(1.0 + progress * 2, 1.0 + progress * 2, 1.0);
      material.opacity = 1.0 - progress;
      
      if (progress < 1.0) {
        requestAnimationFrame(animateRipple);
      } else {
        this.scene.remove(ripple);
        ripple.geometry.dispose();
        ripple.material.dispose();
      }
    };
    
    animateRipple();
}

// Enable foveated rendering based on gaze
setupFoveatedRendering(renderer) {
if (!renderer || !renderer.xr.enabled) return;

    // Check if foveated rendering is supported
    if (!renderer.capabilities.isWebGL2) {
      console.warn('Foveated rendering requires WebGL 2');
      return;
    }
    
    // Set up foveated rendering parameters
    const updateFoveation = () => {
      // Get eye tracking data
      const gazeData = this.eyeTracking.update();
      
      if (!gazeData || !gazeData.looking) {
        // Default foveation when not looking
        renderer.xr.setFoveation(0.5);
        return;
      }
      
      // Calculate gaze point in normalized device coordinates
      const gazeTarget = new THREE.Vector3();
      gazeTarget.addVectors(
        gazeData.origin,
        gazeData.direction.clone().multiplyScalar(10)
      );
      
      gazeTarget.project(this.camera);
      
      // Apply foveation based on gaze position
      // Implementation depends on the specific WebXR runtime
      // For Meta Quest, this is handled automatically if eye tracking is enabled
      if (renderer.xr.setFoveation) {
        renderer.xr.setFoveation(0.8);
      }
    };
    
    // Update foveation each frame
    renderer.xr.addEventListener('sessionstart', () => {
      const session = renderer.xr.getSession();
      
      if (session) {
        session.requestAnimationFrame(function foveationLoop(time, frame) {
          updateFoveation();
          session.requestAnimationFrame(foveationLoop);
        });
      }
    });
}
}</code></pre>
</div>

          <h3>Spatial Anchors</h3>
          <p>
            Spatial anchors allow virtual objects to persist in real-world locations:
          </p>
          
          <div class="code-block">
            <pre><code>// Example: Spatial anchor implementation
class SpatialAnchorManager {
constructor(renderer) {
this.renderer = renderer;
this.anchors = new Map();
this.persistentAnchors = new Map();
this.isSupported = false;
this.session = null;
}

// Initialize spatial anchors
async initialize(xrSession) {
if (!xrSession) return false;

    this.session = xrSession;
    
    // Check for spatial anchor support
    this.isSupported = xrSession.supportedFeatures && 
                      xrSession.supportedFeatures.includes('anchors');
    
    if (!this.isSupported) {
      console.warn('Spatial anchors not supported in this session');
      return false;
    }
    
    console.log('Spatial anchors supported');
    
    // Load persistent anchors if available
    await this._loadPersistentAnchors();
    
    return true;
}

// Create a new anchor at the specified pose
async createAnchor(pose, object, options = {}) {
if (!this.isSupported || !this.session) {
return null;
}

    try {
      // Create XR anchor
      const xrAnchor = await this.session.requestReferenceSpace('local')
                            .then(refSpace => this.session.createAnchor(pose, refSpace));
      
      // Generate ID
      const anchorId = options.id || `anchor-${Date.now()}-${Math.floor(Math.random() * 1000)}`;
      
      // Create anchor wrapper
      const anchor = {
        id: anchorId,
        xrAnchor,
        object: object || null,
        persistent: options.persistent || false,
        metadata: options.metadata || {},
        createdAt: Date.now()
      };
      
      // Store anchor
      this.anchors.set(anchorId, anchor);
      
      // If persistent, save to storage
      if (anchor.persistent) {
        this.persistentAnchors.set(anchorId, {
          id: anchorId,
          metadata: anchor.metadata,
          createdAt: anchor.createdAt
        });
        
        this._savePersistentAnchors();
      }
      
      console.log(`Created anchor: ${anchorId}`);
      
      return anchorId;
    } catch (error) {
      console.error('Error creating anchor:', error);
      return null;
    }
}

// Attach an object to an existing anchor
attachObjectToAnchor(anchorId, object) {
const anchor = this.anchors.get(anchorId);

    if (!anchor) {
      console.warn(`Anchor ${anchorId} not found`);
      return false;
    }
    
    anchor.object = object;
    return true;
}

// Remove an anchor
async removeAnchor(anchorId) {
const anchor = this.anchors.get(anchorId);

    if (!anchor) {
      console.warn(`Anchor ${anchorId} not found`);
      return false;
    }
    
    // Remove from maps
    this.anchors.delete(anchorId);
    
    if (anchor.persistent) {
      this.persistentAnchors.delete(anchorId);
      this._savePersistentAnchors();
    }
    
    // Remove object from scene if attached
    if (anchor.object && anchor.object.parent) {
      anchor.object.parent.remove(anchor.object);
    }
    
    return true;
}

// Update anchored objects based on anchor poses
update(frame, referenceSpace) {
if (!this.isSupported || !frame) return;

    // Get anchors from frame
    const xrAnchors = frame.trackedAnchors;
    
    if (!xrAnchors) return;
    
    // Update each anchor
    for (const [anchorId, anchor] of this.anchors.entries()) {
      // Skip if no object attached
      if (!anchor.object) continue;
      
      // Get pose for this anchor
      const anchorPose = frame.getPose(anchor.xrAnchor.anchorSpace, referenceSpace);
      
      if (anchorPose) {
        // Update object position and orientation
        anchor.object.matrix.fromArray(anchorPose.transform.matrix);
        anchor.object.matrix.decompose(
          anchor.object.position,
          anchor.object.quaternion,
          anchor.object.scale
        );
      }
    }
}

// Save persistent anchors to local storage
_savePersistentAnchors() {
if (typeof localStorage === 'undefined') return;

    try {
      const data = JSON.stringify(Array.from(this.persistentAnchors.values()));
      localStorage.setItem('iasms-spatial-anchors', data);
    } catch (error) {
      console.error('Error saving persistent anchors:', error);
    }
}

// Load persistent anchors from local storage
async _loadPersistentAnchors() {
if (typeof localStorage === 'undefined') return;

    try {
      const data = localStorage.getItem('iasms-spatial-anchors');
      
      if (!data) return;
      
      const anchors = JSON.parse(data);
      
      // Process each saved anchor
      for (const anchor of anchors) {
        this.persistentAnchors.set(anchor.id, anchor);
      }
      
      console.log(`Loaded ${this.persistentAnchors.size} persistent anchors`);
    } catch (error) {
      console.error('Error loading persistent anchors:', error);
    }
}

// Get all anchors
getAnchors() {
return Array.from(this.anchors.values());
}

// Get a specific anchor
getAnchor(anchorId) {
return this.anchors.get(anchorId);
}
}</code></pre>
</div>

          <h3>Plane Detection</h3>
          <p>
            Plane detection allows virtual content to interact with real-world surfaces:
          </p>
          
          <div class="code-block">
            <pre><code>// Example: Plane detection for AR
class PlaneDetectionManager {
constructor(renderer, scene) {
this.renderer = renderer;
this.scene = scene;
this.planes = new Map();
this.planeGroup = new THREE.Group();
this.scene.add(this.planeGroup);

    // Visual settings
    this.visualizePlanes = true;
    this.planeColors = {
      horizontal: 0x3399ff,
      vertical: 0x99ff33,
      other: 0xff9933
    };
    
    // Plane materials
    this.planeMaterials = {
      horizontal: new THREE.MeshBasicMaterial({
        color: this.planeColors.horizontal,
        transparent: true,
        opacity: 0.3,
        side: THREE.DoubleSide
      }),
      vertical: new THREE.MeshBasicMaterial({
        color: this.planeColors.vertical,
        transparent: true,
        opacity: 0.3,
        side: THREE.DoubleSide
      }),
      other: new THREE.MeshBasicMaterial({
        color: this.planeColors.other,
        transparent: true,
        opacity: 0.3,
        side: THREE.DoubleSide
      })
    };
}

// Initialize plane detection
async initialize(xrSession) {
if (!xrSession) return false;

    // Check for plane detection support
    const isSupported = xrSession.supportedFeatures && 
                      (xrSession.supportedFeatures.includes('plane-detection') ||
                       xrSession.supportedFeatures.includes('hit-test'));
    
    if (!isSupported) {
      console.warn('Plane detection not supported in this session');
      return false;
    }
    
    // Request plane detection
    try {
      await xrSession.updateWorldTrackingState({
        planeDetectionState: { enabled: true }
      });
      
      console.log('Plane detection initialized');
      return true;
    } catch (error) {
      console.error('Error initializing plane detection:', error);
      return false;
    }
}

// Set plane visualization
setPlaneVisualization(enabled) {
this.visualizePlanes = enabled;
this.planeGroup.visible = enabled;
}

// Update planes based on frame data
update(frame, referenceSpace) {
if (!frame || !referenceSpace) return;

    // Get detected planes
    const detectedPlanes = frame.detectedPlanes;
    
    if (!detectedPlanes) return;
    
    // Track which planes are still present
    const currentPlaneIds = new Set();
    
    // Update existing planes and add new ones
    for (const xrPlane of detectedPlanes) {
      const planeId = xrPlane.lastChangedTime.toString();
      currentPlaneIds.add(planeId);
      
      // Get pose for this plane
      const planePose = frame.getPose(xrPlane.planeSpace, referenceSpace);
      
      if (!planePose) continue;
      
      // Determine plane type
      const orientation = this._getPlaneOrientation(planePose);
      
      if (this.planes.has(planeId)) {
        // Update existing plane
        this._updatePlane(planeId, xrPlane, planePose, orientation);
      } else {
        // Create new plane
        this._createPlane(planeId, xrPlane, planePose, orientation);
      }
    }
    
    // Remove planes that are no longer detected
    for (const planeId of this.planes.keys()) {
      if (!currentPlaneIds.has(planeId)) {
        this._removePlane(planeId);
      }
    }
}

// Create a new plane visualization
_createPlane(planeId, xrPlane, planePose, orientation) {
// Get plane geometry
const geometry = this._createPlaneGeometry(xrPlane);

    // Create mesh with appropriate material
    const material = this.planeMaterials[orientation].clone();
    const mesh = new THREE.Mesh(geometry, material);
    
    // Set transform
    mesh.matrix.fromArray(planePose.transform.matrix);
    mesh.matrix.decompose(mesh.position, mesh.quaternion, mesh.scale);
    
    // Store plane data
    this.planes.set(planeId, {
      id: planeId,
      xrPlane,
      mesh,
      orientation,
      lastUpdated: Date.now()
    });
    
    // Add to scene
    this.planeGroup.add(mesh);
    
    // Set visibility based on setting
    mesh.visible = this.visualizePlanes;
}

// Update an existing plane
_updatePlane(planeId, xrPlane, planePose, orientation) {
const plane = this.planes.get(planeId);

    // Check if plane exists
    if (!plane) return;
    
    // Update geometry if plane has changed
    if (plane.xrPlane.lastChangedTime !== xrPlane.lastChangedTime) {
      plane.mesh.geometry.dispose();
      plane.mesh.geometry = this._createPlaneGeometry(xrPlane);
      plane.xrPlane = xrPlane;
    }
    
    // Update material if orientation has changed
    if (plane.orientation !== orientation) {
      plane.mesh.material.dispose();
      plane.mesh.material = this.planeMaterials[orientation].clone();
      plane.orientation = orientation;
    }
    
    // Update transform
    plane.mesh.matrix.fromArray(planePose.transform.matrix);
    plane.mesh.matrix.decompose(
      plane.mesh.position,
      plane.mesh.quaternion,
      plane.mesh.scale
    );
    
    // Update timestamp
    plane.lastUpdated = Date.now();
}

// Remove a plane
_removePlane(planeId) {
const plane = this.planes.get(planeId);

    if (!plane) return;
    
    // Remove from scene
    this.planeGroup.remove(plane.mesh);
    
    // Dispose resources
    plane.mesh.geometry.dispose();
    plane.mesh.material.dispose();
    
    // Remove from map
    this.planes.delete(planeId);
}

// Create geometry for a plane
_createPlaneGeometry(xrPlane) {
// Get plane polygon
const polygon = xrPlane.polygon;

    if (!polygon || polygon.length < 3) {
      // Fallback to simple square if no polygon
      return new THREE.PlaneGeometry(1, 1);
    }
    
    // Create shape from polygon
    const shape = new THREE.Shape();
    shape.moveTo(polygon[0].x, polygon[0].z);
    
    for (let i = 1; i < polygon.length; i++) {
      shape.lineTo(polygon[i].x, polygon[i].z);
    }
    
    shape.closePath();
    
    // Create geometry from shape
    return new THREE.ShapeGeometry(shape);
}

// Determine plane orientation
_getPlaneOrientation(planePose) {
// Extract up vector from pose
const up = new THREE.Vector3(0, 1, 0);
up.applyQuaternion(new THREE.Quaternion(
planePose.transform.orientation.x,
planePose.transform.orientation.y,
planePose.transform.orientation.z,
planePose.transform.orientation.w
));

    // Determine orientation by comparing to world up vector
    const dot = up.dot(new THREE.Vector3(0, 1, 0));
    
    if (Math.abs(dot) > 0.95) {
      return 'horizontal';
    } else if (Math.abs(dot) < 0.1) {
      return 'vertical';
    } else {
      return 'other';
    }
}

// Find the closest plane to a point
findClosestPlane(point, maxDistance = 1.0) {
let closestPlane = null;
let minDistance = maxDistance;

    for (const plane of this.planes.values()) {
      // Skip non-horizontal planes if requested
      if (arguments.length > 2 && arguments[2] === 'horizontal' && 
          plane.orientation !== 'horizontal') {
        continue;
      }
      
      // Calculate distance to plane
      const planeNormal = new THREE.Vector3(0, 1, 0);
      planeNormal.applyQuaternion(plane.mesh.quaternion);
      
      const distance = Math.abs(
        planeNormal.dot(
          new THREE.Vector3().subVectors(point, plane.mesh.position)
        )
      );
      
      if (distance < minDistance) {
        minDistance = distance;
        closestPlane = plane;
      }
    }
    
    return closestPlane;
}

// Project a point onto the closest plane
projectPointOnPlane(point, planeType = 'any') {
// Find closest plane
const plane = this.findClosestPlane(point, 10.0, planeType);

    if (!plane) {
      return null;
    }
    
    // Create a THREE.js plane object
    const planeNormal = new THREE.Vector3(0, 1, 0);
    planeNormal.applyQuaternion(plane.mesh.quaternion);
    
    const threePlane = new THREE.Plane().setFromNormalAndCoplanarPoint(
      planeNormal,
      plane.mesh.position
    );
    
    // Project point onto plane
    const projected = new THREE.Vector3();
    threePlane.projectPoint(point, projected);
    
    return {
      point: projected,
      plane: plane
    };
}

// Get all planes
getPlanes() {
return Array.from(this.planes.values());
}

// Get planes by orientation
getPlanesByOrientation(orientation) {
return Array.from(this.planes.values())
.filter(plane => plane.orientation === orientation);
}
}</code></pre>
</div>
</div>
</div>

      <div class="card mb-4">
        <div class="card-header bg-primary text-white">
          <h2 id="multiuser">Multi-User Collaboration</h2>
        </div>
        <div class="card-body">
          <h3>Overview</h3>
          <p>
            The IASMS Simulation system supports multi-user collaboration, allowing multiple users to interact with the same simulation in real-time, whether on desktop, mobile, or VR/AR devices.
          </p>
          
          <h4>Collaboration Features</h4>
          <ul>
            <li><strong>Shared Simulation State</strong>: All users see the same simulation entities and events</li>
            <li><strong>Real-time Updates</strong>: Changes by one user are immediately visible to others</li>
            <li><strong>User Presence</strong>: Avatars represent users in the shared space</li>
            <li><strong>Voice Communication</strong>: Built-in voice chat for team coordination</li>
            <li><strong>Collaborative Tools</strong>: Shared annotations, measurements, and analysis tools</li>
            <li><strong>Role-Based Access</strong>: Different user permissions for different roles</li>
          </ul>
          
          <h3>Implementation</h3>
          <p>
            The collaboration system is built on Meteor's real-time capabilities, with additional optimizations for high-frequency data:
          </p>
          
          <div class="code-block">
            <pre><code>// Example: Multi-user collaboration system
class MultiUserCollaborationManager {
constructor(simulationSession) {
this.session = simulationSession;
this.localUser = {
id: Meteor.userId() || 'anonymous',
name: Meteor.user()?.profile?.name || 'Anonymous User',
color: this._getRandomColor(),
role: Meteor.user()?.roles?.[0] || 'viewer',
avatar: null,
position: new THREE.Vector3(),
rotation: new THREE.Quaternion(),
presence: 'active',
deviceType: this._detectDeviceType()
};

    this.users = new Map();
    this.users.set(this.localUser.id, this.localUser);
    
    this.streamer = new Streamer('iasms-collaboration');
    this.voiceChat = null;
    this.userAvatars = new Map();
    this.annotations = new Map();
    
    // Local user update interval
    this.updateInterval = null;
    this.lastUpdateTime = 0;
    this.updateThrottleMs = 100; // 10 updates per second
}

// Initialize collaboration
async initialize(scene, camera) {
// Set up local user avatar
this.localUser.avatar = this._createUserAvatar(this.localUser);

    // Add local user to scene (only visible to others)
    scene.add(this.localUser.avatar);
    
    // Set up streamer subscription
    this.streamer.on(`session_${this.session.id}_user`, this._handleUserUpdate.bind(this));
    this.streamer.on(`session_${this.session.id}_annotation`, this._handleAnnotationUpdate.bind(this));
    
    // Announce presence
    this._broadcastUserUpdate({
      type: 'join',
      user: this.localUser
    });
    
    // Set up update interval
    this.updateInterval = setInterval(() => {
      this._sendPositionUpdate(camera);
    }, this.updateThrottleMs);
    
    // Set up voice chat if supported
    this.voiceChat = await this._initializeVoiceChat();
    
    // Set up cleanup on window close
    window.addEventListener('beforeunload', () => {
      this._broadcastUserUpdate({
        type: 'leave',
        userId: this.localUser.id
      });
    });
    
    return true;
}

// Send local user position update
_sendPositionUpdate(camera) {
const now = Date.now();

    // Skip if throttled
    if (now - this.lastUpdateTime < this.updateThrottleMs) {
      return;
    }
    
    this.lastUpdateTime = now;
    
    // Update local user position and rotation from camera
    this.localUser.position.copy(camera.position);
    this.localUser.rotation.copy(camera.quaternion);
    
    // Send update
    this._broadcastUserUpdate({
      type: 'position',
      userId: this.localUser.id,
      position: {
        x: camera.position.x,
        y: camera.position.y,
        z: camera.position.z
      },
      rotation: {
        x: camera.quaternion.x,
        y: camera.quaternion.y,
        z: camera.quaternion.z,
        w: camera.quaternion.w
      }
    });
}

// Broadcast user update
_broadcastUserUpdate(update) {
this.streamer.emit(`session_${this.session.id}_user`, update);
}

// Handle user update from streamer
_handleUserUpdate(update) {
// Skip updates from ourselves
if (update.userId === this.localUser.id) {
return;
}

    switch (update.type) {
      case 'join':
        this._handleUserJoin(update.user);
        break;
        
      case 'leave':
        this._handleUserLeave(update.userId);
        break;
        
      case 'position':
        this._handleUserPosition(update);
        break;
        
      case 'presence':
        this._handleUserPresence(update);
        break;
    }
}

// Handle user join
_handleUserJoin(user) {
console.log(`User joined: ${user.name} (${user.id})`);

    // Create user avatar
    const avatar = this._createUserAvatar(user);
    
    // Add to maps
    this.users.set(user.id, user);
    this.userAvatars.set(user.id, avatar);
    
    // Add to scene
    this.scene.add(avatar);
    
    // Notify local handlers
    this.dispatchEvent({
      type: 'user-joined',
      user
    });
}

// Handle user leave
_handleUserLeave(userId) {
console.log(`User left: ${userId}`);

    // Get user
    const user = this.users.get(userId);
    
    if (!user) return;
    
    // Remove avatar
    const avatar = this.userAvatars.get(userId);
    
    if (avatar && avatar.parent) {
      avatar.parent.remove(avatar);
    }
    
    // Remove from maps
    this.users.delete(userId);
    this.userAvatars.delete(userId);
    
    // Notify local handlers
    this.dispatchEvent({
      type: 'user-left',
      userId,
      user
    });
}

// Handle user position update
_handleUserPosition(update) {
// Get avatar
const avatar = this.userAvatars.get(update.userId);

    if (!avatar) return;
    
    // Update position
    avatar.position.set(
      update.position.x,
      update.position.y,
      update.position.z
    );
    
    // Update rotation
    avatar.quaternion.set(
      update.rotation.x,
      update.rotation.y,
      update.rotation.z,
      update.rotation.w
    );
    
    // Update user data
    const user = this.users.get(update.userId);
    
    if (user) {
      user.position = new THREE.Vector3(
        update.position.x,
        update.position.y,
        update.position.z
      );
      
      user.rotation = new THREE.Quaternion(
        update.rotation.x,
        update.rotation.y,
        update.rotation.z,
        update.rotation.w
      );
    }
}

// Handle user presence update
_handleUserPresence(update) {
// Get user
const user = this.users.get(update.userId);

    if (!user) return;
    
    // Update presence
    user.presence = update.presence;
    
    // Update avatar
    const avatar = this.userAvatars.get(update.userId);
    
    if (avatar) {
      // Update avatar visibility or appearance based on presence
      switch (update.presence) {
        case 'active':
          avatar.visible = true;
          break;
          
        case 'away':
          avatar.visible = true;
          // Make avatar semi-transparent
          avatar.traverse(obj => {
            if (obj.material) {
              obj.material.opacity = 0.5;
              obj.material.transparent = true;
            }
          });
          break;
          
        case 'inactive':
          avatar.visible = false;
          break;
      }
    }
    
    // Notify local handlers
    this.dispatchEvent({
      type: 'user-presence-changed',
      userId: update.userId,
      presence: update.presence
    });
}

// Create user avatar
_createUserAvatar(user) {
const avatar = new THREE.Group();
avatar.name = `user-${user.id}`;

    // Create avatar based on device type
    switch (user.deviceType) {
      case 'desktop':
        this._createDesktopAvatar(avatar, user);
        break;
        
      case 'mobile':
        this._createMobileAvatar(avatar, user);
        break;
        
      case 'vr':
        this._createVRAvatar(avatar, user);
        break;
        
      case 'ar':
        this._createARAvatar(avatar, user);
        break;
        
      default:
        this._createDefaultAvatar(avatar, user);
    }
    
    // Add name label
    const nameLabel = this._createNameLabel(user.name, user.color);
    nameLabel.position.y = 0.5;
    avatar.add(nameLabel);
    
    return avatar;
}

// Create desktop user avatar
_createDesktopAvatar(avatar, user) {
// Create a simple avatar for desktop users
const geometry = new THREE.ConeGeometry(0.1, 0.3, 4);
geometry.rotateX(Math.PI / 2);

    const material = new THREE.MeshBasicMaterial({
      color: user.color,
      wireframe: true
    });
    
    const cone = new THREE.Mesh(geometry, material);
    avatar.add(cone);
    
    // Add view frustum visualization
    const frustum = new THREE.Group();
    
    const frustumGeometry = new THREE.BufferGeometry();
    const vertices = new Float32Array([
      0, 0, 0,   0.2, 0.15, -0.3,
      0, 0, 0,   -0.2, 0.15, -0.3,
      0, 0, 0,   0.2, -0.15, -0.3,
      0, 0, 0,   -0.2, -0.15, -0.3,
      0.2, 0.15, -0.3,   -0.2, 0.15, -0.3,
      -0.2, 0.15, -0.3,   -0.2, -0.15, -0.3,
      -0.2, -0.15, -0.3,   0.2, -0.15, -0.3,
      0.2, -0.15, -0.3,   0.2, 0.15, -0.3
    ]);
    
    frustumGeometry.setAttribute('position', new THREE.BufferAttribute(vertices, 3));
    
    const lines = new THREE.LineSegments(
      frustumGeometry,
      new THREE.LineBasicMaterial({ color: user.color })
    );
    
    frustum.add(lines);
    avatar.add(frustum);
    
    return avatar;
}

// Create VR user avatar
_createVRAvatar(avatar, user) {
// Create a VR headset representation
const headset = new THREE.Group();

    // Main body
    const bodyGeometry = new THREE.BoxGeometry(0.2, 0.1, 0.1);
    const bodyMaterial = new THREE.MeshBasicMaterial({
      color: user.color
    });
    const body = new THREE.Mesh(bodyGeometry, bodyMaterial);
    headset.add(body);
    
    // Controllers
    const controllerGeometry = new THREE.CylinderGeometry(0.01, 0.01, 0.1, 8);
    const controllerMaterial = new THREE.MeshBasicMaterial({
      color: user.color
    });
    
    const leftController = new THREE.Mesh(controllerGeometry, controllerMaterial);
    leftController.position.set(-0.2, -0.1, -0.1);
    leftController.rotation.set(Math.PI/2, 0, 0);
    avatar.add(leftController);
    
    const rightController = new THREE.Mesh(controllerGeometry, controllerMaterial);
    rightController.position.set(0.2, -0.1, -0.1);
    rightController.rotation.set(Math.PI/2, 0, 0);
    avatar.add(rightController);
    
    avatar.add(headset);
    
    return avatar;
}

// Other avatar creation methods...

// Create name label
_createNameLabel(name, color) {
// Create canvas for text
const canvas = document.createElement('canvas');
canvas.width = 256;
canvas.height = 64;

    const ctx = canvas.getContext('2d');
    ctx.fillStyle = '#000000';
    ctx.fillRect(0, 0, canvas.width, canvas.height);
    
    ctx.font = '24px Arial';
    ctx.fillStyle = color;
    ctx.textAlign = 'center';
    ctx.textBaseline = 'middle';
    ctx.fillText(name, canvas.width / 2, canvas.height / 2);
    
    // Create sprite
    const texture = new THREE.CanvasTexture(canvas);
    const material = new THREE.SpriteMaterial({
      map: texture,
      transparent: true
    });
    
    const sprite = new THREE.Sprite(material);
    sprite.scale.set(0.5, 0.125, 1);
    
    // Make sprite always face camera
    sprite.userData.alwaysFaceCamera = true;
    
    return sprite;
}

// Initialize voice chat
async _initializeVoiceChat() {
try {
// Check if WebRTC is supported
if (!navigator.mediaDevices || !navigator.mediaDevices.getUserMedia) {
console.warn('WebRTC not supported - voice chat disabled');
return null;
}

      // Create voice chat manager
      const voiceChat = new VoiceChatManager(this.session.id);
      await voiceChat.initialize();
      
      return voiceChat;
    } catch (error) {
      console.error('Failed to initialize voice chat:', error);
      return null;
    }
}

// Create annotation
createAnnotation(position, text, options = {}) {
const annotationId = options.id || `annotation-${Date.now()}-${Math.floor(Math.random() * 1000)}`;

    // Create annotation data
    const annotation = {
      id: annotationId,
      text,
      position: {
        x: position.x,
        y: position.y,
        z: position.z
      },
      color: options.color || this.localUser.color,
      userId: this.localUser.id,
      userName: this.localUser.name,
      timestamp: Date.now(),
      visible: true
    };
    
    // Add to local map
    this.annotations.set(annotationId, annotation);
    
    // Create visual representation
    const visual = this._createAnnotationVisual(annotation);
    
    // Add to scene
    this.scene.add(visual);
    
    // Broadcast
    this.streamer.emit(`session_${this.session.id}_annotation`, {
      type: 'create',
      annotation
    });
    
    return annotationId;
}

// Update annotation
updateAnnotation(annotationId, updates) {
// Get annotation
const annotation = this.annotations.get(annotationId);

    if (!annotation) {
      console.warn(`Annotation ${annotationId} not found`);
      return false;
    }
    
    // Check if user is allowed to update
    if (annotation.userId !== this.localUser.id && 
        !this._hasEditPermission(this.localUser)) {
      console.warn('You do not have permission to update this annotation');
      return false;
    }
    
    // Apply updates
    Object.assign(annotation, updates);
    annotation.lastUpdated = Date.now();
    
    // Update visual
    const visual = this.scene.getObjectByName(`annotation-${annotationId}`);
    
    if (visual) {
      // Update position
      if (updates.position) {
        visual.position.set(
          updates.position.x,
          updates.position.y,
          updates.position.z
        );
      }
      
      // Update text
      if (updates.text) {
        const textSprite = visual.getObjectByName('text');
        
        if (textSprite) {
          textSprite.material.map.dispose();
          textSprite.material.map = this._createTextTexture(
            updates.text,
            updates.color || annotation.color
          );
          textSprite.material.needsUpdate = true;
        }
      }
      
      // Update visibility
      if (updates.visible !== undefined) {
        visual.visible = updates.visible;
      }
    }
    
    // Broadcast
    this.streamer.emit(`session_${this.session.id}_annotation`, {
      type: 'update',
      annotationId,
      updates
    });
    
    return true;
}

// Delete annotation
deleteAnnotation(annotationId) {
// Get annotation
const annotation = this.annotations.get(annotationId);

    if (!annotation) {
      console.warn(`Annotation ${annotationId} not found`);
      return false;
    }
    
    // Check if user is allowed to delete
    if (annotation.userId !== this.localUser.id && 
        !this._hasEditPermission(this.localUser)) {
      console.warn('You do not have permission to delete this annotation');
      return false;
    }
    
    // Remove visual
    const visual = this.scene.getObjectByName(`annotation-${annotationId}`);
    
    if (visual) {
      this.scene.remove(visual);
      
      // Dispose resources
      visual.traverse(obj => {
        if (obj.geometry) {
          obj.geometry.dispose();
        }
        
        if (obj.material) {
          if (obj.material.map) {
            obj.material.map.dispose();
          }
          
          obj.material.dispose();
        }
      });
    }
    
    // Remove from map
    this.annotations.delete(annotationId);
    
    // Broadcast
    this.streamer.emit(`session_${this.session.id}_annotation`, {
      type: 'delete',
      annotationId
    });
    
    return true;
}

// Handle annotation updates
_handleAnnotationUpdate(update) {
switch (update.type) {
case 'create':
this._handleAnnotationCreate(update.annotation);
break;

      case 'update':
        this._handleAnnotationUpdate(update.annotationId, update.updates);
        break;
        
      case 'delete':
        this._handleAnnotationDelete(update.annotationId);
        break;
    }
}

// Other implementation details...

// Clean up resources
cleanup() {
// Clear interval
if (this.updateInterval) {
clearInterval(this.updateInterval);
}

    // Announce departure
    this._broadcastUserUpdate({
      type: 'leave',
      userId: this.localUser.id
    });
    
    // Clean up voice chat
    if (this.voiceChat) {
      this.voiceChat.cleanup();
    }
    
    // Clean up avatars
    for (const avatar of this.userAvatars.values()) {
      if (avatar.parent) {
        avatar.parent.remove(avatar);
      }
    }
    
    // Unsubscribe from streamer
    this.streamer.removeAllListeners(`session_${this.session.id}_user`);
    this.streamer.removeAllListeners(`session_${this.session.id}_annotation`);
}
}</code></pre>
</div>

          <h3>Voice Chat Implementation</h3>
          <p>
            The multi-user experience includes voice chat for team communication:
          </p>
          
          <div class="code-block">
            <pre><code>// Example: Voice chat implementation
class VoiceChatManager {
constructor(sessionId) {
this.sessionId = sessionId;
this.localStream = null;
this.peerConnections = new Map();
this.audioContext = null;
this.analyser = null;
this.audioProcessor = null;
this.isMuted = false;
this.roomName = `iasms-voice-${sessionId}`;
this.userId = Meteor.userId() || 'anonymous';
this.signaling = null;
}

// Initialize voice chat
async initialize() {
try {
// Set up audio context
this.audioContext = new (window.AudioContext || window.webkitAudioContext)();

      // Set up media stream
      this.localStream = await navigator.mediaDevices.getUserMedia({
        audio: {
          echoCancellation: true,
          noiseSuppression: true,
          autoGainControl: true
        },
        video: false
      });
      
      // Set up audio processing
      const source = this.audioContext.createMediaStreamSource(this.localStream);
      this.analyser = this.audioContext.createAnalyser();
      this.analyser.fftSize = 256;
      source.connect(this.analyser);
      
      // Set up signaling
      this._setupSignaling();
      
      // Join room
      this._joinRoom();
      
      return true;
    } catch (error) {
      console.error('Failed to initialize voice chat:', error);
      return false;
    }
}

// Set up signaling
_setupSignaling() {
// Use Meteor's DDP for signaling
this.signaling = new Streamer('iasms-voice-signaling');

    // Handle signaling messages
    this.signaling.on(this.roomName, this._handleSignalingMessage.bind(this));
}

// Join voice chat room
_joinRoom() {
console.log(`Joining voice chat room: ${this.roomName}`);

    // Announce presence
    this._sendSignalingMessage({
      type: 'join',
      userId: this.userId,
      roomName: this.roomName
    });
}

// Send signaling message
_sendSignalingMessage(message) {
this.signaling.emit(this.roomName, {
...message,
from: this.userId,
timestamp: Date.now()
});
}

// Handle signaling message
_handleSignalingMessage(message) {
// Skip messages from ourselves
if (message.from === this.userId) {
return;
}

    switch (message.type) {
      case 'join':
        this._handlePeerJoin(message.from);
        break;
        
      case 'offer':
        this._handleOffer(message.from, message.offer);
        break;
        
      case 'answer':
        this._handleAnswer(message.from, message.answer);
        break;
        
      case 'ice-candidate':
        this._handleIceCandidate(message.from, message.candidate);
        break;
        
      case 'leave':
        this._handlePeerLeave(message.from);
        break;
    }
}

// Handle peer join
_handlePeerJoin(peerId) {
console.log(`Peer joined: ${peerId}`);

    // Create peer connection
    const peerConnection = this._createPeerConnection(peerId);
    
    // Add local stream
    this.localStream.getTracks().forEach(track => {
      peerConnection.addTrack(track, this.localStream);
    });
    
    // Create and send offer
    peerConnection.createOffer()
      .then(offer => peerConnection.setLocalDescription(offer))
      .then(() => {
        this._sendSignalingMessage({
          type: 'offer',
          to: peerId,
          offer: peerConnection.localDescription
        });
      })
      .catch(error => {
        console.error('Error creating offer:', error);
      });
}

// Create peer connection
_createPeerConnection(peerId) {
// Check if connection already exists
if (this.peerConnections.has(peerId)) {
return this.peerConnections.get(peerId);
}

    console.log(`Creating peer connection to: ${peerId}`);
    
    // ICE servers configuration
    const configuration = {
      iceServers: [
        { urls: 'stun:stun.l.google.com:19302' },
        { urls: 'stun:stun1.l.google.com:19302' }
      ]
    };
    
    // Create connection
    const peerConnection = new RTCPeerConnection(configuration);
    
    // Handle ICE candidates
    peerConnection.onicecandidate = event => {
      if (event.candidate) {
        this._sendSignalingMessage({
          type: 'ice-candidate',
          to: peerId,
          candidate: event.candidate
        });
      }
    };
    
    // Handle connection state changes
    peerConnection.onconnectionstatechange = () => {
      console.log(`Connection state change: ${peerConnection.connectionState}`);
      
      if (peerConnection.connectionState === 'disconnected' ||
          peerConnection.connectionState === 'failed') {
        this._removePeerConnection(peerId);
      }
    };
    
    // Handle incoming tracks
    peerConnection.ontrack = event => {
      console.log(`Received remote track from: ${peerId}`);
      this._handleRemoteTrack(peerId, event.streams[0]);
    };
    
    // Store connection
    this.peerConnections.set(peerId, peerConnection);
    
    return peerConnection;
}

// Handle remote audio track
_handleRemoteTrack(peerId, stream) {
// Create audio element
const audioElement = document.createElement('audio');
audioElement.id = `voice-${peerId}`;
audioElement.srcObject = stream;
audioElement.autoplay = true;

    // Add to DOM (hidden)
    audioElement.style.display = 'none';
    document.body.appendChild(audioElement);
    
    // Connect to audio context for spatial audio (if needed)
    this._setupSpatialAudio(peerId, stream);
}

// Set up spatial audio
_setupSpatialAudio(peerId, stream) {
// Create spatial audio processing
const audioContext = this.audioContext;
const source = audioContext.createMediaStreamSource(stream);
const panner = audioContext.createPanner();

    panner.panningModel = 'HRTF';
    panner.distanceModel = 'inverse';
    panner.refDistance = 1;
    panner.maxDistance = 10000;
    panner.rolloffFactor = 1;
    
    source.connect(panner);
    panner.connect(audioContext.destination);
    
    // Store panner for position updates
    this.peerConnections.get(peerId).panner = panner;
}

// Update peer audio position
updatePeerPosition(peerId, position, orientation) {
const connection = this.peerConnections.get(peerId);

    if (!connection || !connection.panner) return;
    
    // Update panner position
    connection.panner.positionX.value = position.x;
    connection.panner.positionY.value = position.y;
    connection.panner.positionZ.value = position.z;
    
    // Update orientation if provided
    if (orientation) {
      // Calculate forward vector
      const forward = new THREE.Vector3(0, 0, -1);
      forward.applyQuaternion(new THREE.Quaternion(
        orientation.x,
        orientation.y,
        orientation.z,
        orientation.w
      ));
      
      connection.panner.orientationX.value = forward.x;
      connection.panner.orientationY.value = forward.y;
      connection.panner.orientationZ.value = forward.z;
    }
}

// Handle offer
_handleOffer(peerId, offer) {
console.log(`Received offer from: ${peerId}`);

    // Create peer connection
    const peerConnection = this._createPeerConnection(peerId);
    
    // Add local stream
    this.localStream.getTracks().forEach(track => {
      peerConnection.addTrack(track, this.localStream);
    });
    
    // Set remote description
    peerConnection.setRemoteDescription(new RTCSessionDescription(offer))
      .then(() => peerConnection.createAnswer())
      .then(answer => peerConnection.setLocalDescription(answer))
      .then(() => {
        this._sendSignalingMessage({
          type: 'answer',
          to: peerId,
          answer: peerConnection.localDescription
        });
      })
      .catch(error => {
        console.error('Error handling offer:', error);
      });
}

// Handle answer
_handleAnswer(peerId, answer) {
console.log(`Received answer from: ${peerId}`);

    const peerConnection = this.peerConnections.get(peerId);
    
    if (!peerConnection) {
      console.warn(`No connection found for peer: ${peerId}`);
      return;
    }
    
    peerConnection.setRemoteDescription(new RTCSessionDescription(answer))
      .catch(error => {
        console.error('Error setting remote description:', error);
      });
}

// Handle ICE candidate
_handleIceCandidate(peerId, candidate) {
const peerConnection = this.peerConnections.get(peerId);

    if (!peerConnection) {
      console.warn(`No connection found for peer: ${peerId}`);
      return;
    }
    
    peerConnection.addIceCandidate(new RTCIceCandidate(candidate))
      .catch(error => {
        console.error('Error adding ICE candidate:', error);
      });
}

// Handle peer leave
_handlePeerLeave(peerId) {
console.log(`Peer left: ${peerId}`);
this._removePeerConnection(peerId);
}

// Remove peer connection
_removePeerConnection(peerId) {
const peerConnection = this.peerConnections.get(peerId);

    if (!peerConnection) return;
    
    // Close connection
    peerConnection.close();
    
    // Remove from map
    this.peerConnections.delete(peerId);
    
    // Remove audio element
    const audioElement = document.getElementById(`voice-${peerId}`);
    if (audioElement) {
      audioElement.srcObject = null;
      audioElement.remove();
    }
}

// Toggle mute
toggleMute() {
this.isMuted = !this.isMuted;

    this.localStream.getAudioTracks().forEach(track => {
      track.enabled = !this.isMuted;
    });
    
    return this.isMuted;
}

// Get mute status
isMuted() {
return this.isMuted;
}

// Get audio level
getAudioLevel() {
if (!this.analyser) return 0;

    const dataArray = new Uint8Array(this.analyser.frequencyBinCount);
    this.analyser.getByteFrequencyData(dataArray);
    
    // Calculate average level
    let sum = 0;
    for (const value of dataArray) {
      sum += value;
    }
    
    return sum / dataArray.length / 255;
}

// Leave voice chat
leave() {
console.log(`Leaving voice chat room: ${this.roomName}`);

    // Announce departure
    this._sendSignalingMessage({
      type: 'leave',
      roomName: this.roomName
    });
    
    // Close all connections
    for (const peerId of this.peerConnections.keys()) {
      this._removePeerConnection(peerId);
    }
}

// Clean up resources
cleanup() {
// Leave room
this.leave();

    // Stop local stream
    if (this.localStream) {
      this.localStream.getTracks().forEach(track => track.stop());
    }
    
    // Unsubscribe from signaling
    if (this.signaling) {
      this.signaling.removeAllListeners(this.roomName);
    }
    
    // Close audio context
    if (this.audioContext) {
      this.audioContext.close();
    }
}
}</code></pre>
</div>
</div>
</div>

      <div class="card mb-4">
        <div class="card-header bg-primary text-white">
          <h2 id="enterprise-integration">Enterprise Integration</h2>
        </div>
        <div class="card-body">
          <h3>Overview</h3>
          <p>
            The IASMS Simulation system can be integrated with enterprise systems through various integration points:
          </p>
          
          <h4>Integration Options</h4>
          <table class="table table-bordered">
            <thead class="thead-light">
              <tr>
                <th>Integration Type</th>
                <th>Description</th>
                <th>Implementation</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>REST API</td>
                <td>RESTful API endpoints for data exchange</td>
                <td>Express.js routes with JWT authentication</td>
              </tr>
              <tr>
                <td>WebSocket</td>
                <td>Real-time data streaming</td>
                <td>Socket.io or native WebSockets</td>
              </tr>
              <tr>
                <td>Message Queue</td>
                <td>Asynchronous message processing</td>
                <td>RabbitMQ, Kafka, or Redis</td>
              </tr>
              <tr>
                <td>Database Connectors</td>
                <td>Direct database integration</td>
                <td>MongoDB, PostgreSQL, or Oracle connectors</td>
              </tr>
              <tr>
                <td>Single Sign-On</td>
                <td>Authentication integration</td>
                <td>SAML, OAuth 2.0, or OpenID Connect</td>
              </tr>
              <tr>
                <td>File Exchange</td>
                <td>Import/export of simulation data</td>
                <td>CSV, JSON, or custom formats</td>
              </tr>
            </tbody>
          </table>
          
          <h3>REST API</h3>
          <p>
            The system provides a comprehensive REST API for integration:
          </p>
          
          <div class="accordion" id="apiAccordion">
            <div class="card">
              <div class="card-header" id="headingAuth">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapseAuth" aria-expanded="true" aria-controls="collapseAuth">
                    Authentication
                  </button>
                </h2>
              </div>
              <div id="collapseAuth" class="collapse show" aria-labelledby="headingAuth" data-parent="#apiAccordion">
                <div class="card-body">
                  <p>The API supports two authentication methods:</p>
                  
                  <h5>API Key Authentication</h5>
                  <div class="code-block">
                    <pre><code>// Request with API key
fetch('https://iasms.example.com/api/iasms/vehicles', {
headers: {
'X-API-Key': 'your-api-key-here'
}
})</code></pre>
</div>

                  <h5>JWT Authentication</h5>
                  <div class="code-block">
                    <pre><code>// Request with JWT token
fetch('https://iasms.example.com/api/iasms/vehicles', {
headers: {
'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...'
}
})</code></pre>
</div>
</div>
</div>
</div>

            <div class="card">
              <div class="card-header" id="headingVehicles">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseVehicles" aria-expanded="false" aria-controls="collapseVehicles">
                    Vehicle Management
                  </button>
                </h2>
              </div>
              <div id="collapseVehicles" class="collapse" aria-labelledby="headingVehicles" data-parent="#apiAccordion">
                <div class="card-body">
                  <h5>Get Active Vehicles</h5>
                  <p><code>GET /api/iasms/vehicles</code></p>
                  
                  <h5>Get Vehicle Details</h5>
                  <p><code>GET /api/iasms/vehicles/:vehicleId</code></p>
                  
                  <h5>Update Vehicle State</h5>
                  <p><code>POST /api/iasms/vehicles/:vehicleId/state</code></p>
                  <div class="code-block">
                    <pre><code>// Example request body
{
"position": {
"type": "Point",
"coordinates": [-74.0060, 40.7128, 100]
},
"altitude": 100,
"heading": 45,
"speed": 10,
"status": "ACTIVE"
}</code></pre>
</div>
</div>
</div>
</div>

            <div class="card">
              <div class="card-header" id="headingHazards">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseHazards" aria-expanded="false" aria-controls="collapseHazards">
                    Hazard Management
                  </button>
                </h2>
              </div>
              <div id="collapseHazards" class="collapse" aria-labelledby="headingHazards" data-parent="#apiAccordion">
                <div class="card-body">
                  <h5>Get Active Hazards</h5>
                  <p><code>GET /api/iasms/hazards</code></p>
                  
                  <h5>Get Hazard Details</h5>
                  <p><code>GET /api/iasms/hazards/:hazardId</code></p>
                  
                  <h5>Create Hazard</h5>
                  <p><code>POST /api/iasms/hazards</code></p>
                  <div class="code-block">
                    <pre><code>// Example request body
{
"hazardType": "WEATHER_THUNDERSTORM",
"location": {
"type": "Point",
"coordinates": [-74.0060, 40.7128]
},
"altitude": 500,
"radius": 2000,
"severity": 0.8,
"expiryTime": "2025-09-16T15:30:00.000Z",
"metadata": {
"windSpeed": 25,
"precipitation": "heavy"
}
}</code></pre>
</div>
</div>
</div>
</div>

            <div class="card">
              <div class="card-header" id="headingSimulations">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseSimulations" aria-expanded="false" aria-controls="collapseSimulations">
                    Simulation Management
                  </button>
                </h2>
              </div>
              <div id="collapseSimulations" class="collapse" aria-labelledby="headingSimulations" data-parent="#apiAccordion">
                <div class="card-body">
                  <h5>Get Active Sessions</h5>
                  <p><code>GET /api/iasms/simulations</code></p>
                  
                  <h5>Create Simulation Session</h5>
                  <p><code>POST /api/iasms/simulations</code></p>
                  <div class="code-block">
                    <pre><code>// Example request body
{
"name": "API-created Simulation",
"description": "Created via API for external integration",
"syncWithRealWorld": true,
"settings": {
"timeScale": 1.0,
"weatherConditions": "CLEAR"
}
}</code></pre>
</div>

                  <h5>Add Entity to Simulation</h5>
                  <p><code>POST /api/iasms/simulations/:sessionId/entities</code></p>
                  <div class="code-block">
                    <pre><code>// Example request body
{
"type": "vehicle",
"vehicleType": "drone",
"vehicleCategory": "aerial",
"position": {
"x": 100,
"y": 50,
"z": -200
},
"rotation": {
"x": 0,
"y": 0.7853981,
"z": 0
},
"metadata": {
"callsign": "DRONE-1",
"status": "ACTIVE"
}
}</code></pre>
</div>
</div>
</div>
</div>
</div>

          <h3>Enterprise SSO Integration</h3>
          <p>
            The system can be integrated with enterprise SSO systems:
          </p>
          
          <div class="code-block">
            <pre><code>// Example: SAML SSO configuration
import { Accounts } from 'meteor/accounts-base';
import { SAML } from 'meteor/saml';

const settings = Meteor.settings.saml || {};

// Configure SAML service
Accounts.saml.settings = {
provider: settings.provider || 'default',
entryPoint: settings.entryPoint || 'https://sso.example.com/saml2/idp/SSOService.php',
issuer: settings.issuer || 'https://iasms.example.com',
cert: settings.cert || 'MIIDpDCCAoygAwIBAgIGAX...',
idpSLORedirectURL: settings.idpSLORedirectURL || 'https://sso.example.com/saml2/idp/SingleLogoutService.php',
privateKey: settings.privateKey || '-----BEGIN PRIVATE KEY-----\nMIIE...',
privateKeyPassword: settings.privateKeyPassword || '',
attributeMap: settings.attributeMap || {
email: 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress',
firstName: 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname',
lastName: 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname',
roles: 'http://schemas.microsoft.com/ws/2008/06/identity/claims/role'
},
logoutBehavior: settings.logoutBehavior || 'TERMINATE'
};

// Handle SAML response
Accounts.registerLoginHandler('saml', function(loginRequest) {
if (!loginRequest.saml) return undefined;

const samlResponse = loginRequest.saml;

// Process SAML attributes
const userInfo = {
email: samlResponse[Accounts.saml.settings.attributeMap.email],
firstName: samlResponse[Accounts.saml.settings.attributeMap.firstName],
lastName: samlResponse[Accounts.saml.settings.attributeMap.lastName],
samlRoles: samlResponse[Accounts.saml.settings.attributeMap.roles]
};

// Map SAML roles to application roles
const roleMapping = {
'IASMS_ADMIN': 'admin',
'IASMS_TRAINER': 'trainer',
'IASMS_TRAINEE': 'trainee',
'IASMS_VIEWER': 'viewer'
};

// Convert SAML roles to application roles
const roles = Array.isArray(userInfo.samlRoles) ?
userInfo.samlRoles : [userInfo.samlRoles];

const mappedRoles = roles
.filter(role => roleMapping[role])
.map(role => roleMapping[role]);

// Find or create user
let userId;
const user = Meteor.users.findOne({ 'emails.address': userInfo.email });

if (user) {
userId = user._id;

    // Update user info
    Meteor.users.update(userId, {
      $set: {
        'profile.firstName': userInfo.firstName,
        'profile.lastName': userInfo.lastName,
        'profile.fullName': `${userInfo.firstName} ${userInfo.lastName}`,
        'services.saml.sessionIndex': samlResponse.sessionIndex,
        'services.saml.nameID': samlResponse.nameID,
        'roles': mappedRoles
      }
    });
} else {
// Create new user
userId = Accounts.createUser({
email: userInfo.email,
profile: {
firstName: userInfo.firstName,
lastName: userInfo.lastName,
fullName: `${userInfo.firstName} ${userInfo.lastName}`
}
});

    // Set SAML session data
    Meteor.users.update(userId, {
      $set: {
        'services.saml.sessionIndex': samlResponse.sessionIndex,
        'services.saml.nameID': samlResponse.nameID,
        'roles': mappedRoles
      }
    });
    
    // Set email verification
    Meteor.users.update(userId, {
      $set: { 'emails.0.verified': true }
    });
}

return { userId };
});</code></pre>
</div>

          <h3>Message Queue Integration</h3>
          <p>
            For asynchronous processing, the system can integrate with message queues:
          </p>
          
          <div class="code-block">
            <pre><code>// Example: RabbitMQ integration
import amqp from 'amqplib';

export class MessageQueueService {
constructor(options = {}) {
this.options = {
url: options.url || process.env.RABBITMQ_URL || 'amqp://localhost',
exchange: options.exchange || 'iasms',
queues: {
vehicleUpdates: 'iasms.vehicle-updates',
hazards: 'iasms.hazards',
simulation: 'iasms.simulation'
},
...options
};

    this.connection = null;
    this.channel = null;
    this.isConnected = false;
    this.consumers = new Map();
}

// Connect to RabbitMQ
async connect() {
try {
this.connection = await amqp.connect(this.options.url);

      this.connection.on('error', (err) => {
        console.error('RabbitMQ connection error:', err);
        this.isConnected = false;
        
        // Try to reconnect after a delay
        setTimeout(() => this.connect(), 5000);
      });
      
      this.connection.on('close', () => {
        console.log('RabbitMQ connection closed');
        this.isConnected = false;
        
        // Try to reconnect after a delay
        setTimeout(() => this.connect(), 5000);
      });
      
      // Create channel
      this.channel = await this.connection.createChannel();
      
      // Create exchange
      await this.channel.assertExchange(this.options.exchange, 'topic', {
        durable: true
      });
      
      // Create queues
      for (const [name, queueName] of Object.entries(this.options.queues)) {
        await this.channel.assertQueue(queueName, {
          durable: true
        });
      }
      
      this.isConnected = true;
      console.log('Connected to RabbitMQ');
      
      // Restart consumers if any
      for (const [queue, callback] of this.consumers.entries()) {
        this.consume(queue, callback);
      }
      
      return true;
    } catch (error) {
      console.error('Failed to connect to RabbitMQ:', error);
      
      // Try to reconnect after a delay
      setTimeout(() => this.connect(), 5000);
      
      return false;
    }
}

// Publish message to exchange
async publish(routingKey, message) {
if (!this.isConnected) {
await this.connect();
}

    try {
      const buffer = Buffer.from(JSON.stringify(message));
      
      return this.channel.publish(
        this.options.exchange,
        routingKey,
        buffer,
        {
          persistent: true,
          contentType: 'application/json'
        }
      );
    } catch (error) {
      console.error(`Error publishing message to ${routingKey}:`, error);
      throw error;
    }
}

// Consume messages from queue
async consume(queueName, callback) {
if (!this.isConnected) {
await this.connect();
}

    try {
      // Store consumer for reconnection
      this.consumers.set(queueName, callback);
      
      // Bind queue to exchange with routing key
      await this.channel.bindQueue(
        queueName,
        this.options.exchange,
        queueName.replace('iasms.', '')
      );
      
      // Start consuming
      return this.channel.consume(queueName, (msg) => {
        if (!msg) return;
        
        try {
          const content = JSON.parse(msg.content.toString());
          
          // Process message
          callback(content, msg);
          
          // Acknowledge message
          this.channel.ack(msg);
        } catch (error) {
          console.error(`Error processing message from ${queueName}:`, error);
          
          // Reject message and requeue
          this.channel.nack(msg, false, true);
        }
      });
    } catch (error) {
      console.error(`Error consuming messages from ${queueName}:`, error);
      throw error;
    }
}

// Close connection
async close() {
if (this.channel) {
await this.channel.close();
}

    if (this.connection) {
      await this.connection.close();
    }
    
    this.isConnected = false;
    this.consumers.clear();
    
    console.log('RabbitMQ connection closed');
}
}

// Usage example
const messageQueue = new MessageQueueService();

// Connect to RabbitMQ
messageQueue.connect();

// Publish vehicle update
messageQueue.publish('vehicle-updates', {
vehicleId: 'drone-001',
position: {
type: 'Point',
coordinates: [-74.0060, 40.7128, 100]
},
timestamp: new Date()
});

// Consume hazard messages
messageQueue.consume('iasms.hazards', (hazard) => {
console.log('Received hazard:', hazard);

// Process hazard
simulationModule.addEntityToSimulation(sessionId, {
type: 'hazard',
hazardType: hazard.hazardType,
position: {
x: hazard.location.coordinates[0],
y: hazard.altitude || 100,
z: hazard.location.coordinates[1]
},
radius: hazard.radius,
severity: hazard.severity,
metadata: hazard.metadata
});
});</code></pre>
</div>
</div>
</div>

      <div class="card mb-4">
        <div class="card-header bg-primary text-white">
          <h2 id="testing">Testing & Quality Assurance</h2>
        </div>
        <div class="card-body">
          <h3>Testing Strategy</h3>
          <p>
            The IASMS Simulation system includes a comprehensive testing strategy to ensure quality and reliability:
          </p>
          
          <h4>Testing Levels</h4>
          <table class="table table-bordered">
            <thead class="thead-light">
              <tr>
                <th>Level</th>
                <th>Description</th>
                <th>Tools</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>Unit Testing</td>
                <td>Testing individual components and functions</td>
                <td>Jest, Mocha, Chai</td>
              </tr>
              <tr>
                <td>Integration Testing</td>
                <td>Testing interactions between components</td>
                <td>Jest, Meteor Test Runner</td>
              </tr>
              <tr>
                <td>End-to-End Testing</td>
                <td>Testing complete workflows</td>
                <td>Cypress, TestCafe</td>
              </tr>
              <tr>
                <td>Performance Testing</td>
                <td>Testing system performance under load</td>
                <td>k6, Artillery</td>
              </tr>
              <tr>
                <td>WebXR Testing</td>
                <td>Testing VR/AR functionality</td>
                <td>WebXR Emulator, Manual Testing</td>
              </tr>
            </tbody>
          </table>
          
          <h3>Unit Testing</h3>
          <p>
            Unit tests focus on testing individual components and functions:
          </p>
          
          <div class="code-block">
            <pre><code>// Example: Unit test for AerialModalityManager
import { AerialModalityManager } from '../AerialVehicleManager';
import * as THREE from 'three';

describe('AerialModalityManager', () => {
let manager;
let mockScene;
let mockPhysicsSystem;

beforeEach(() => {
// Create mocks
mockScene = {
add: jest.fn(),
remove: jest.fn(),
traverse: jest.fn()
};

    mockPhysicsSystem = {
      addVehicle: jest.fn(),
      removeVehicle: jest.fn()
    };
    
    // Create manager
    manager = new AerialModalityManager(mockScene, mockPhysicsSystem);
});

afterEach(() => {
jest.resetAllMocks();
});

test('initialize should set up the manager', () => {
// Act
manager.initialize();

    // Assert
    expect(manager).toBeDefined();
});

test('createVehicle should add a vehicle to the scene', () => {
// Arrange
const vehic