I'll create a comprehensive Bootstrap 4 HTML page for the 3D simulation documentation with proper bookmarks and linking.Let me create an HTML webpage using Bootstrap 4 that documents the 3D simulation integration with the IASMS system. I'll base it on the template from the docs directory and include all the information with proper bookmarking and deep linking.

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>3D Simulation Integration with IASMS System</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="css/styles.css">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.1/css/all.css">
  <style>
    /* Custom styles */
    .section-nav {
      position: sticky;
      top: 2rem;
    }
    .section-nav .nav-link {
      padding: .2rem 0;
      color: #666;
      transition: all 0.2s;
    }
    .section-nav .nav-link:hover {
      color: #007bff;
    }
    .section-nav .nav-link.active {
      color: #007bff;
      font-weight: bold;
    }
    .section-nav .nav .nav {
      margin-left: 1rem;
    }
    pre {
      background-color: #f8f9fa;
      padding: 1rem;
      border-radius: .25rem;
    }
    .sticky-top {
      top: 2rem;
    }
    table {
      width: 100%;
      margin-bottom: 1rem;
    }
    h1, h2, h3, h4, h5, h6 {
      scroll-margin-top: 70px;
    }
    .device-compatibility-table th {
      vertical-align: middle;
    }
    .highlight {
      background-color: #fff8e1;
      padding: 15px;
      border-left: 4px solid #ffc107;
      margin-bottom: 20px;
    }
  </style>
</head>
<body data-spy="scroll" data-target="#toc">
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
      <a class="navbar-brand" href="index.html">
        IASMS Documentation
      </a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item">
            <a class="nav-link" href="index.html">Home</a>
          </li>
          <li class="nav-item active">
            <a class="nav-link" href="3d-simulation.html">3D Simulation</a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown">
              Components
            </a>
            <div class="dropdown-menu">
              <a class="dropdown-item" href="core-system.html">Core System</a>
              <a class="dropdown-item" href="modalities.html">Modalities</a>
              <a class="dropdown-item" href="ar-vr-features.html">AR/VR Features</a>
              <div class="dropdown-divider"></div>
              <a class="dropdown-item" href="components/index.html">All Components</a>
            </div>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <div class="jumbotron bg-primary text-white">
    <div class="container">
      <div class="row align-items-center">
        <div class="col-md-8">
          <h1 class="display-4">3D Simulation with IASMS</h1>
          <p class="lead">Immersive WebXR-powered environments for multi-modal simulations</p>
          <a href="#setup-and-installation" class="btn btn-light btn-lg">Get Started</a>
          <a href="#resources" class="btn btn-outline-light btn-lg">Resources</a>
        </div>
        <div class="col-md-4 text-center">
          <i class="fas fa-vr-cardboard fa-6x"></i>
        </div>
      </div>
    </div>
  </div>

  <div class="container my-5">
    <div class="row">
      <div class="col-md-3 mb-5">
        <nav id="toc" class="section-nav sticky-top">
          <ul class="nav flex-column">
            <li class="nav-item">
              <a class="nav-link" href="#overview">Overview</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#system-architecture">System Architecture</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#setup-and-installation">Setup & Installation</a>
              <ul class="nav flex-column">
                <li class="nav-item">
                  <a class="nav-link" href="#prerequisites">Prerequisites</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="#installation-scripts">Installation Scripts</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="#environment-configuration">Environment Configuration</a>
                </li>
              </ul>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#threejs-integration">Three.js Integration</a>
              <ul class="nav flex-column">
                <li class="nav-item">
                  <a class="nav-link" href="#scene-setup">Scene Setup</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="#rendering-pipeline">Rendering Pipeline</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="#performance-optimization">Performance Optimization</a>
                </li>
              </ul>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#webxr-implementation">WebXR Implementation</a>
              <ul class="nav flex-column">
                <li class="nav-item">
                  <a class="nav-link" href="#device-compatibility">Device Compatibility</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="#feature-detection">Feature Detection</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="#session-management">Session Management</a>
                </li>
              </ul>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#arvr-features">AR/VR Features</a>
              <ul class="nav flex-column">
                <li class="nav-item">
                  <a class="nav-link" href="#immersive-mode">Immersive Mode</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="#controller-input">Controller Input</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="#hand-tracking">Hand Tracking</a>
                </li>
              </ul>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#meta-quest-integration">Meta Quest Integration</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#haptic-feedback">Haptic Feedback</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#spatial-audio">Spatial Audio</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#mobile-support">Mobile Support</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#meteor-integration">Meteor Integration</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#react-integration">React Integration</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#multi-modal-simulation">Multi-Modal Simulation</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#troubleshooting">Troubleshooting</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#resources">Resources</a>
            </li>
          </ul>
        </nav>
      </div>
      <div class="col-md-9">
        <section id="overview">
          <h2>Overview</h2>
          <p>The IASMS (Integrated Aerial Simulation Management System) 3D simulation integration provides an immersive WebXR-powered environment for visualizing and interacting with multi-modal simulations across various domains including aerial, marine, space, land, subsurface, pedestrian, and robotic systems.</p>
          <p>This integration leverages Three.js, WebXR, and React to create a seamless experience across desktop, mobile, and VR/AR headsets, with special optimizations for Meta Quest devices. The system supports advanced features such as hand tracking, eye tracking, haptic feedback, and spatial audio.</p>

          <div class="row mt-4">
            <div class="col-md-4 mb-4">
              <div class="card h-100">
                <div class="card-body text-center">
                  <i class="fas fa-cube fa-3x text-primary mb-3"></i>
                  <h4 class="card-title">Three.js Rendering</h4>
                  <p class="card-text">High-performance 3D rendering with advanced post-processing effects</p>
                </div>
              </div>
            </div>
            <div class="col-md-4 mb-4">
              <div class="card h-100">
                <div class="card-body text-center">
                  <i class="fas fa-vr-cardboard fa-3x text-primary mb-3"></i>
                  <h4 class="card-title">WebXR Support</h4>
                  <p class="card-text">Immersive VR and AR experiences with feature detection</p>
                </div>
              </div>
            </div>
            <div class="col-md-4 mb-4">
              <div class="card h-100">
                <div class="card-body text-center">
                  <i class="fas fa-hands fa-3x text-primary mb-3"></i>
                  <h4 class="card-title">Natural Interaction</h4>
                  <p class="card-text">Hand tracking, gesture recognition, and haptic feedback</p>
                </div>
              </div>
            </div>
          </div>
        </section>

        <hr class="my-5">

        <section id="system-architecture">
          <h2>System Architecture</h2>
          <p>The 3D simulation integration with IASMS follows a modular architecture:</p>
          
          <pre><code>IASMS Core System
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
    └── MongoDB Collections</code></pre>
          
          <p>The architecture enables:</p>
          <ul>
            <li>Seamless communication between the IASMS core system and 3D simulation</li>
            <li>Independent management of different modalities (aerial, marine, etc.)</li>
            <li>Flexible feature support based on device capabilities</li>
            <li>Real-time data synchronization between server and clients</li>
          </ul>
        </section>

        <hr class="my-5">

        <section id="setup-and-installation">
          <h2>Setup and Installation</h2>
          
          <section id="prerequisites">
            <h3>Prerequisites</h3>
            <p>Before setting up the 3D simulation integration, ensure your system meets the following requirements:</p>
            <ul>
              <li>Node.js (v14+)</li>
              <li>Meteor (v2.5+)</li>
              <li>MongoDB (v4.4+)</li>
              <li>Modern web browser with WebGL and WebXR support</li>
              <li>For development: Meta Quest device or mobile device with AR capabilities (optional)</li>
            </ul>
          </section>
          
          <section id="installation-scripts">
            <h3>Installation Scripts</h3>
            <p>Use the provided setup scripts to configure your development environment:</p>
            
            <pre><code class="language-bash"># WebXR and Three.js setup script
bash ThreeJSWebXRSetupScript.sh

# WebXR Simulation setup script
bash WebXRSimulationSetupScript.sh</code></pre>
            
            <p>These scripts install required dependencies and configure the development environment with optimal settings for WebXR development.</p>
          </section>
          
          <section id="environment-configuration">
            <h3>Environment Configuration</h3>
            <p>Create a <code>.env</code> file in your project root with the following configuration:</p>
            
            <pre><code># WebXR Configuration
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
PHYSICS_SIMULATION_RATE=60</code></pre>
          </section>
        </section>

        <hr class="my-5">

        <section id="threejs-integration">
          <h2>Three.js Integration</h2>
          
          <section id="scene-setup">
            <h3>Scene Setup</h3>
            <p>The 3D simulation uses Three.js for rendering. The core scene setup is handled in <code>CrossModalityARVRSceneSetup.js</code>:</p>
            
            <pre><code class="language-javascript">// Initialize scene
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
renderer.xr.enabled = true;</code></pre>
            
            <p>For advanced settings, refer to the <code>MultiModalImmersiveSimulation.js</code> which includes post-processing effects and enhanced rendering configuration.</p>
          </section>
          
          <section id="rendering-pipeline">
            <h3>Rendering Pipeline</h3>
            <p>The simulation uses an advanced rendering pipeline with post-processing effects:</p>
            
            <pre><code class="language-javascript">// Set up post-processing with EffectComposer
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
composer.addPass(outlinePass);</code></pre>
          </section>
          
          <section id="performance-optimization">
            <h3>Performance Optimization</h3>
            <p>Several performance optimizations are implemented:</p>
            
            <div class="row">
              <div class="col-md-6">
                <div class="card mb-4">
                  <div class="card-header">
                    <h5 class="mb-0">Level of Detail (LOD)</h5>
                  </div>
                  <div class="card-body">
                    <p>Dynamic mesh simplification based on distance with reduced polygon count for distant objects.</p>
                  </div>
                </div>
              </div>
              <div class="col-md-6">
                <div class="card mb-4">
                  <div class="card-header">
                    <h5 class="mb-0">Frustum Culling</h5>
                  </div>
                  <div class="card-body">
                    <p>Only rendering objects within the camera view for efficient scene management.</p>
                  </div>
                </div>
              </div>
              <div class="col-md-6">
                <div class="card mb-4">
                  <div class="card-header">
                    <h5 class="mb-0">Foveated Rendering</h5>
                  </div>
                  <div class="card-body">
                    <p>When supported by the device (e.g., Meta Quest), concentrates rendering quality in the center of vision.</p>
                  </div>
                </div>
              </div>
              <div class="col-md-6">
                <div class="card mb-4">
                  <div class="card-header">
                    <h5 class="mb-0">Instanced Rendering</h5>
                  </div>
                  <div class="card-body">
                    <p>For repeated objects like crowd simulations, significantly reduces draw calls.</p>
                  </div>
                </div>
              </div>
            </div>

            <p>Example code for implementing instanced rendering:</p>
            
            <pre><code class="language-javascript">// Create an instanced mesh for multiple objects
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

scene.add(instancedMesh);</code></pre>
          </section>
        </section>

        <hr class="my-5">

        <section id="webxr-implementation">
          <h2>WebXR Implementation</h2>
          
          <section id="device-compatibility">
            <h3>Device Compatibility</h3>
            <p>The WebXR implementation includes comprehensive feature detection to ensure compatibility across devices:</p>
            
            <pre><code class="language-typescript">// XR Feature Detector
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
}</code></pre>
          </section>
          
          <section id="feature-detection">
            <h3>Feature Detection</h3>
            <p>The feature detection system checks for:</p>
            <div class="row">
              <div class="col-md-4">
                <ul>
                  <li>Basic WebXR support</li>
                  <li>VR and AR mode support</li>
                  <li>Hand tracking capabilities</li>
                  <li>Eye tracking capabilities</li>
                  <li>Spatial anchors</li>
                </ul>
              </div>
              <div class="col-md-4">
                <ul>
                  <li>Plane detection</li>
                  <li>Mesh detection</li>
                  <li>Image tracking</li>
                  <li>Depth sensing</li>
                  <li>Foveated rendering</li>
                </ul>
              </div>
              <div class="col-md-4">
                <ul>
                  <li>Light estimation</li>
                  <li>Passthrough capabilities</li>
                  <li>Neural interface simulation</li>
                  <li>Spatial audio support</li>
                  <li>DOM overlay capabilities</li>
                </ul>
              </div>
            </div>
          </section>
          
          <section id="session-management">
            <h3>Session Management</h3>
            <p>Session management handles the initialization and cleanup of WebXR sessions:</p>
            
            <pre><code class="language-javascript">// Custom VR button with enhanced styling and session management
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
};</code></pre>
          </section>
        </section>

        <hr class="my-5">

        <section id="arvr-features">
          <h2>AR/VR Features</h2>
          
          <section id="immersive-mode">
            <h3>Immersive Mode</h3>
            <p>The system supports both VR and AR immersive modes with environment-specific optimizations:</p>
            
            <pre><code class="language-javascript">// For VR mode
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
});</code></pre>
          </section>
          
          <section id="controller-input">
            <h3>Controller Input</h3>
            <p>The system provides comprehensive controller input handling:</p>
            
            <pre><code class="language-javascript">// Setup controller event listeners
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
};</code></pre>
          </section>
          
          <section id="hand-tracking">
            <h3>Hand Tracking</h3>
            <p>The system supports hand tracking for controller-free interaction:</p>
            
            <pre><code class="language-javascript">// Initialize hand tracking if supported
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
}</code></pre>
            
            <p>The gesture recognition system detects common hand gestures:</p>
            
            <pre><code class="language-javascript">// Handle detected hand gestures
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
};</code></pre>
          </section>
        </section>

        <hr class="my-5">

        <section id="meta-quest-integration">
          <h2>Meta Quest Integration</h2>
          
          <h3>Device Setup</h3>
          <p>For optimal performance on Meta Quest devices:</p>
          <ol>
            <li><strong>Enable Developer Mode</strong> on your Quest device through the Oculus app</li>
            <li><strong>Connect via USB</strong> and enable USB debugging</li>
            <li><strong>Configure Browser</strong> with WebXR capabilities (Chrome or Oculus Browser)</li>
            <li><strong>Enable Hand Tracking</strong> in the Quest settings for controller-free operation</li>
          </ol>
          
          <h3>Controller Mapping</h3>
          <p>Meta Quest controllers are mapped as follows:</p>
          
          <pre><code class="language-javascript">// Meta Quest controller mapping
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
};</code></pre>
          
          <h3>Performance Considerations</h3>
          <p>For optimal performance on Quest devices:</p>
          
          <div class="card mb-4">
            <div class="card-header">
              <h5 class="mb-0">Foveated Rendering</h5>
            </div>
            <div class="card-body">
              <pre><code class="language-javascript">// Enable foveated rendering for better performance
if (features.foveatedRendering && renderer.xr.isPresenting) {
  renderer.xr.setFoveation(0.7); // Level of foveation (0 to 1)
}</code></pre>
            </div>
          </div>
          
          <div class="card mb-4">
            <div class="card-header">
              <h5 class="mb-0">Level of Detail (LOD)</h5>
            </div>
            <div class="card-body">
              <pre><code class="language-javascript">// Create LOD (Level of Detail) for complex objects
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
}</code></pre>
            </div>
          </div>
        </section>

        <hr class="my-5">

        <section id="haptic-feedback">
          <h2>Haptic Feedback</h2>
          
          <p>The haptic feedback system provides tactile responses to user interactions:</p>
          
          <pre><code class="language-typescript">/**
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
}</code></pre>
          
          <h3>Preset Patterns</h3>
          <p>The system supports complex haptic patterns for different interactions:</p>
          
          <pre><code class="language-typescript">// Initialize preset haptic patterns
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
}</code></pre>
          
          <h3>Interaction Mapping</h3>
          <p>Different interactions are mapped to appropriate haptic intensities:</p>
          
          <div class="table-responsive">
            <table class="table table-striped">
              <thead>
                <tr>
                  <th>Interaction</th>
                  <th>Pattern</th>
                  <th>Intensity</th>
                  <th>Duration</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>Selection</td>
                  <td><code>pulse</code></td>
                  <td>0.5</td>
                  <td>100ms</td>
                  <td>Standard feedback for selecting items</td>
                </tr>
                <tr>
                  <td>Confirmation</td>
                  <td><code>success</code></td>
                  <td>0.7</td>
                  <td>200ms</td>
                  <td>Positive action completion</td>
                </tr>
                <tr>
                  <td>Error</td>
                  <td><code>error</code></td>
                  <td>0.8</td>
                  <td>200ms</td>
                  <td>Error or invalid action</td>
                </tr>
                <tr>
                  <td>Warning</td>
                  <td><code>warning</code></td>
                  <td>0.5</td>
                  <td>250ms</td>
                  <td>Warning or caution feedback</td>
                </tr>
                <tr>
                  <td>Collision</td>
                  <td><code>pulse</code></td>
                  <td>0.9</td>
                  <td>80ms</td>
                  <td>Object collision feedback</td>
                </tr>
                <tr>
                  <td>Menu Open</td>
                  <td><code>doublePulse</code></td>
                  <td>0.4</td>
                  <td>150ms</td>
                  <td>Menu opening feedback</td>
                </tr>
                <tr>
                  <td>Grab Start</td>
                  <td><code>pulse</code></td>
                  <td>0.7</td>
                  <td>100ms</td>
                  <td>Object grab initiation</td>
                </tr>
                <tr>
                  <td>Grab Release</td>
                  <td><code>pulse</code></td>
                  <td>0.3</td>
                  <td>50ms</td>
                  <td>Object release</td>
                </tr>
                <tr>
                  <td>Modality Change</td>
                  <td><code>success</code></td>
                  <td>0.6</td>
                  <td>200ms</td>
                  <td>Switching between modalities</td>
                </tr>
              </tbody>
            </table>
          </div>
        </section>

        <hr class="my-5">

        <section id="spatial-audio">
          <h2>Spatial Audio</h2>
          
          <p>The spatial audio system creates immersive audio experiences:</p>
          
          <pre><code class="language-typescript">/**
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
  
  // Create a dummy object to position the sound
  const soundObject = new THREE.Object3D();
  soundObject.position.copy(position);
  soundObject.add(sound);
  this.scene.add(soundObject);
  
  // Store sound for tracking
  this.sounds.set(`${soundName}_${Date.now()}`, sound);
  
  // Play the sound
  sound.play();
  
  return sound;
}</code></pre>
          
          <h3>Ambient Sound Management</h3>
          <p>The system manages ambient sounds for different environments:</p>
          
          <pre><code class="language-typescript">/**
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
}</code></pre>
        </section>

        <hr class="my-5">

        <section id="mobile-support">
          <h2>Mobile Support</h2>
          
          <div class="row">
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-header">
                  <h3 class="mb-0">Responsive Design</h3>
                </div>
                <div class="card-body">
                  <p>The system adapts to different screen sizes and device capabilities:</p>
                  <pre><code class="language-javascript">// Handle window resize for mobile and desktop
const handleResize = () => {
  const width = window.innerWidth;
  const height = window.innerHeight;
  
  // Update camera aspect ratio
  camera.aspect = width / height;
  camera.updateProjectionMatrix();
  
  // Update renderer size
  renderer.setSize(width, height);
  
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
};</code></pre>
                </div>
              </div>
            </div>
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-header">
                  <h3 class="mb-0">Touch Controls</h3>
                </div>
                <div class="card-body">
                  <p>The system provides touch controls for mobile devices:</p>
                  <pre><code class="language-javascript">// Setup touch controls
container.addEventListener('touchstart', (event) => {
  if (event.touches.length === 1) {
    // Single touch for rotation
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
});</code></pre>
                </div>
              </div>
            </div>
          </div>
          
          <div class="highlight">
            <h4><i class="fas fa-mobile-alt mr-2"></i> Mobile AR Features</h4>
            <p>For mobile AR, the system includes features for:</p>
            <ul>
              <li>Device orientation control for camera movement</li>
              <li>Touch-based object placement and interaction</li>
              <li>Performance optimizations for mobile GPUs</li>
              <li>Responsive UI that adapts to different screen sizes</li>
              <li>Support for both landscape and portrait orientations</li>
            </ul>
          </div>
        </section>

        <hr class="my-5">

        <section id="meteor-integration">
          <h2>Meteor Integration</h2>
          
          <h3>Publication/Subscription Model</h3>
          <p>The simulation integrates with Meteor's pub/sub model:</p>
          
          <pre><code class="language-javascript">// Track simulation data from Meteor collections
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
}, [scenarioId]);</code></pre>
          
          <h3>Data Flow</h3>
          <p>Data flows between the server and 3D simulation:</p>
          
          <div class="row">
            <div class="col-md-6">
              <div class="card mb-4">
                <div class="card-header">
                  <h4 class="mb-0">Server to Client</h4>
                </div>
                <div class="card-body">
                  <ul>
                    <li>Entity updates (position, status, attributes)</li>
                    <li>Event triggers (collisions, waypoints, alerts)</li>
                    <li>Scenario configuration changes</li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="col-md-6">
              <div class="card mb-4">
                <div class="card-header">
                  <h4 class="mb-0">Client to Server</h4>
                </div>
                <div class="card-body">
                  <ul>
                    <li>User interactions (object creation, modification)</li>
                    <li>Simulation control commands (start, pause, reset)</li>
                    <li>Collaborative actions (shared view, annotations)</li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </section>

        <hr class="my-5">

        <section id="react-integration">
          <h2>React Integration</h2>
          
          <h3>Component Structure</h3>
          <p>The 3D simulation is integrated within React components:</p>
          
          <pre><code class="language-javascript">// Main simulation component
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
};</code></pre>
          
          <h3>Lifecycle Management</h3>
          <p>React lifecycle hooks manage the 3D scene initialization and cleanup:</p>
          
          <pre><code class="language-javascript">// Initialize on component mount
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
}, []);</code></pre>
        </section>

        <hr class="my-5">

        <section id="multi-modal-simulation">
          <h2>Multi-Modal Simulation</h2>
          
          <h3>Modality Switching</h3>
          <p>The system supports seamless switching between different simulation modalities:</p>
          
          <pre><code class="language-javascript">// Switch to a specific modality
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
};</code></pre>
          
          <div class="row mt-4">
            <div class="col-md-12">
              <div class="card mb-4">
                <div class="card-header">
                  <h4 class="mb-0">Available Modalities</h4>
                </div>
                <div class="card-body">
                  <div class="row">
                    <div class="col-md-4 mb-3">
                      <div class="card h-100">
                        <div class="card-body">
                          <h5 class="card-title">Aerial</h5>
                          <p class="card-text">eVTOL, drones, aircraft, and aerial traffic management</p>
                        </div>
                      </div>
                    </div>
                    <div class="col-md-4 mb-3">
                      <div class="card h-100">
                        <div class="card-body">
                          <h5 class="card-title">Marine</h5>
                          <p class="card-text">Ships, submarines, and ocean environment simulation</p>
                        </div>
                      </div>
                    </div>
                    <div class="col-md-4 mb-3">
                      <div class="card h-100">
                        <div class="card-body">
                          <h5 class="card-title">Space</h5>
                          <p class="card-text">Satellites, space stations, and orbital mechanics</p>
                        </div>
                      </div>
                    </div>
                    <div class="col-md-4 mb-3">
                      <div class="card h-100">
                        <div class="card-body">
                          <h5 class="card-title">Land</h5>
                          <p class="card-text">Ground vehicles, traffic simulation, and terrain</p>
                        </div>
                      </div>
                    </div>
                    <div class="col-md-4 mb-3">
                      <div class="card h-100">
                        <div class="card-body">
                          <h5 class="card-title">Subsurface</h5>
                          <p class="card-text">Underground infrastructure, tunnels, and mining</p>
                        </div>
                      </div>
                    </div>
                    <div class="col-md-4 mb-3">
                      <div class="card h-100">
                        <div class="card-body">
                          <h5 class="card-title">Pedestrian</h5>
                          <p class="card-text">People, crowds, and pedestrian behavior simulation</p>
                        </div>
                      </div>
                    </div>
                    <div class="col-md-4 mb-3">
                      <div class="card h-100">
                        <div class="card-body">
                          <h5 class="card-title">Robot</h5>
                          <p class="card-text">Street robots, delivery drones, and maintenance</p>
                        </div>
                      </div>
                    </div>
                    <div class="col-md-4 mb-3">
                      <div class="card h-100">
                        <div class="card-body">
                          <h5 class="card-title">Multi-Modal</h5>
                          <p class="card-text">Combined view of all modalities with cross-system interactions</p>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>

        <hr class="my-5">

        <section id="troubleshooting">
          <h2>Troubleshooting</h2>
          
          <div class="accordion" id="troubleshootingAccordion">
            <div class="card">
              <div class="card-header" id="headingOne">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapseOne">
                    WebXR Session Initialization Failed
                  </button>
                </h2>
              </div>
              <div id="collapseOne" class="collapse" data-parent="#troubleshootingAccordion">
                <div class="card-body">
                  <p><strong>Problem:</strong> Unable to start WebXR session, error in console: "Failed to create WebXR session"</p>
                  <p><strong>Solutions:</strong></p>
                  <ol>
                    <li>Ensure your browser supports WebXR (Chrome 79+, Edge 79+, Firefox with flag)</li>
                    <li>For VR, make sure a compatible headset is connected</li>
                    <li>For AR, ensure your device supports ARCore (Android) or ARKit (iOS)</li>
                    <li>Check the requested features are supported by your device</li>
                    <li>Try with fewer optional features:</li>
                  </ol>
                  <pre><code class="language-javascript">// Minimal WebXR session request
navigator.xr.requestSession('immersive-vr', {
  optionalFeatures: [] // Start with no optional features
}).then(session => {
  // Session created successfully
}).catch(error => {
  console.error('Failed to create WebXR session:', error);
});</code></pre>
                </div>
              </div>
            </div>
            <div class="card">
              <div class="card-header" id="headingTwo">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo">
                    Performance Issues in VR
                  </button>
                </h2>
              </div>
              <div id="collapseTwo" class="collapse" data-parent="#troubleshootingAccordion">
                <div class="card-body">
                  <p><strong>Problem:</strong> Low framerate, stuttering in VR mode</p>
                  <p><strong>Solutions:</strong></p>
                  <ol>
                    <li>Reduce scene complexity</li>
                    <li>Enable foveated rendering if available</li>
                    <li>Optimize lighting by using baked lightmaps instead of real-time lights</li>
                    <li>Use instanced meshes for repeated objects</li>
                    <li>Implement frustum culling and occlusion culling</li>
                    <li>Reduce shader complexity</li>
                    <li>Lower texture resolutions</li>
                  </ol>
                </div>
              </div>
            </div>
            <div class="card">
              <div class="card-header" id="headingThree">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseThree">
                    AR Tracking Issues
                  </button>
                </h2>
              </div>
              <div id="collapseThree" class="collapse" data-parent="#troubleshootingAccordion">
                <div class="card-body">
                  <p><strong>Problem:</strong> AR objects drifting or not staying in place</p>
                  <p><strong>Solutions:</strong></p>
                  <ol>
                    <li>Use anchors when available</li>
                    <li>Improve plane detection by providing visual feedback</li>
                    <li>Ensure well-lit environment with sufficient visual features</li>
                    <li>Avoid reflective or transparent surfaces</li>
                    <li>Implement hit testing for more accurate placement</li>
                  </ol>
                </div>
              </div>
            </div>
            <div class="card">
              <div class="card-header" id="headingFour">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseFour">
                    Hand Tracking Not Working
                  </button>
                </h2>
              </div>
              <div id="collapseFour" class="collapse" data-parent="#troubleshootingAccordion">
                <div class="card-body">
                  <p><strong>Problem:</strong> Hand tracking not working or inconsistent</p>
                  <p><strong>Solutions:</strong></p>
                  <ol>
                    <li>Ensure hand tracking is enabled in device settings (Meta Quest)</li>
                    <li>Check that hand tracking is requested in WebXR session</li>
                    <li>Ensure sufficient lighting in the room</li>
                    <li>Keep hands within the field of view of the headset cameras</li>
                    <li>Avoid fast hand movements during tracking</li>
                    <li>Ensure hands are not overlapping or too close together</li>
                  </ol>
                </div>
              </div>
            </div>
          </div>
          
          <h3 class="mt-5">WebXR Compatibility</h3>
          <p>For ensuring maximum compatibility across devices:</p>
          
          <div class="row">
            <div class="col-md-6">
              <h4>Browser Support</h4>
              <div class="table-responsive">
                <table class="table table-bordered">
                  <thead class="thead-light">
                    <tr>
                      <th>Browser</th>
                      <th>VR Support</th>
                      <th>AR Support</th>
                      <th>Notes</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td>Chrome 79+</td>
                      <td><i class="fas fa-check text-success"></i></td>
                      <td><i class="fas fa-check text-success"></i></td>
                      <td>Best support for all features</td>
                    </tr>
                    <tr>
                      <td>Edge 79+</td>
                      <td><i class="fas fa-check text-success"></i></td>
                      <td><i class="fas fa-check text-success"></i></td>
                      <td>Based on Chromium, similar to Chrome</td>
                    </tr>
                    <tr>
                      <td>Firefox</td>
                      <td><i class="fas fa-check text-success"></i></td>
                      <td><i class="fas fa-times text-danger"></i></td>
                      <td>VR only, requires flag for WebXR</td>
                    </tr>
                    <tr>
                      <td>Oculus Browser</td>
                      <td><i class="fas fa-check text-success"></i></td>
                      <td><i class="fas fa-times text-danger"></i></td>
                      <td>Optimized for Oculus headsets</td>
                    </tr>
                    <tr>
                      <td>Safari</td>
                      <td><i class="fas fa-times text-danger"></i></td>
                      <td><i class="fas fa-times text-danger"></i></td>
                      <td>No WebXR support, uses WebXR Polyfill</td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
            <div class="col-md-6">
              <h4>Device Compatibility</h4>
              <div class="table-responsive device-compatibility-table">
                <table class="table table-bordered">
                  <thead class="thead-light">
                    <tr>
                      <th>Device Category</th>
                      <th>Examples</th>
                      <th>Support Level</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td>VR Headsets</td>
                      <td>Meta Quest, Valve Index, HTC Vive</td>
                      <td><span class="badge badge-success">High</span></td>
                    </tr>
                    <tr>
                      <td>AR Phones</td>
                      <td>Pixel, Samsung Galaxy S20+</td>
                      <td><span class="badge badge-success">High</span></td>
                    </tr>
                    <tr>
                      <td>iOS Devices</td>
                      <td>iPhone, iPad</td>
                      <td><span class="badge badge-warning">Medium</span></td>
                    </tr>
                    <tr>
                      <td>Desktop</td>
                      <td>Windows, Mac, Linux</td>
                      <td><span class="badge badge-warning">Medium</span></td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </section>

        <hr class="my-5">

        <section id="resources">
          <h2>Resources</h2>
          
          <div class="row">
            <div class="col-md-4">
              <div class="card mb-4">
                <div class="card-header">
                  <h3 class="mb-0">Documentation</h3>
                </div>
                <div class="card-body">
                  <ul class="list-unstyled">
                    <li><i class="fas fa-book text-primary mr-2"></i> <a href="https://threejs.org/docs/" target="_blank">Three.js Documentation</a></li>
                    <li><i class="fas fa-book text-primary mr-2"></i> <a href="https://developer.mozilla.org/en-US/docs/Web/API/WebXR_Device_API" target="_blank">WebXR Device API Documentation</a></li>
                    <li><i class="fas fa-book text-primary mr-2"></i> <a href="https://developer.oculus.com/documentation/" target="_blank">Meta Quest Developer Documentation</a></li>
                    <li><i class="fas fa-book text-primary mr-2"></i> <a href="https://docs.meteor.com/" target="_blank">Meteor Documentation</a></li>
                    <li><i class="fas fa-book text-primary mr-2"></i> <a href="https://reactjs.org/docs/getting-started.html" target="_blank">React Documentation</a></li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="col-md-4">
              <div class="card mb-4">
                <div class="card-header">
                  <h3 class="mb-0">Libraries</h3>
                </div>
                <div class="card-body">
                  <ul class="list-unstyled">
                    <li><i class="fas fa-code text-primary mr-2"></i> <a href="https://threejs.org/" target="_blank">Three.js</a> - 3D rendering library</li>
                    <li><i class="fas fa-code text-primary mr-2"></i> <a href="https://github.com/immersive-web/webxr-polyfill" target="_blank">WebXR Polyfill</a> - Fallback for browsers without native WebXR</li>
                    <li><i class="fas fa-code text-primary mr-2"></i> <a href="https://socket.io/" target="_blank">Socket.io</a> - Real-time communication</li>
                    <li><i class="fas fa-code text-primary mr-2"></i> <a href="https://github.com/pmndrs/react-three-fiber" target="_blank">React Three Fiber</a> - React renderer for Three.js</li>
                    <li><i class="fas fa-code text-primary mr-2"></i> <a href="https://schteppe.github.io/cannon.js/" target="_blank">Cannon.js</a> - Physics engine</li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="col-md-4">
              <div class="card mb-4">
                <div class="card-header">
                  <h3 class="mb-0">Tools</h3>
                </div>
                <div class="card-body">
                  <ul class="list-unstyled">
                    <li><i class="fas fa-tools text-primary mr-2"></i> <a href="https://github.com/MozillaReality/WebXR-emulator-extension" target="_blank">WebXR Emulator Extension</a> - Test WebXR without a physical device</li>
                    <li><i class="fas fa-tools text-primary mr-2"></i> <a href="https://developers.google.com/web/tools/lighthouse" target="_blank">Lighthouse</a> - Performance testing</li>
                    <li><i class="fas fa-tools text-primary mr-2"></i> <a href="https://developers.google.com/web/tools/chrome-devtools" target="_blank">Chrome DevTools</a> - Performance profiling</li>
                    <li><i class="fas fa-tools text-primary mr-2"></i> <a href="https://spector.babylonjs.com/" target="_blank">Spector.js</a> - WebGL debugging</li>
                    <li><i class="fas fa-tools text-primary mr-2"></i> <a href="https://threejs.org/editor/" target="_blank">Three.js Editor</a> - Visual scene editor</li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
          
          <div class="card mt-4">
            <div class="card-body">
              <h3 class="card-title">Setup Scripts and Configuration Files</h3>
              <p>The following scripts and configuration files are provided to help with the setup and configuration of the 3D simulation environment:</p>
              
              <div class="row">
                <div class="col-md-6">
                  <h4>Setup Scripts</h4>
                  <ul>
                    <li><code>ThreeJSWebXRSetupScript.sh</code> - Installs and configures Three.js and WebXR dependencies</li>
                    <li><code>WebXRSimulationSetupScript.sh</code> - Configures the WebXR simulation environment</li>
                  </ul>
                </div>
                <div class="col-md-6">
                  <h4>Configuration Files</h4>
                  <ul>
                    <li><code>AerialTrafficSimulationConfig.json</code> - Configuration for aerial traffic simulation</li>
                    <li><code>ServerConfigurationAndWebXRSettings.env</code> - Server and WebXR environment settings</li>
                    <li><code>PerformanceSettingsConfig.md</code> - Documentation for performance configuration options</li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </section>
      </div>
    </div>
  </div>

  <footer class="bg-dark text-white py-4 mt-5">
    <div class="container">
      <div class="row">
        <div class="col-md-6">
          <p>&copy; 2025 Autonomy Association International, all rights reserved</p>
        </div>
        <div class="col-md-6 text-md-right">
          <p>IASMS 3D Simulation Documentation</p>
        </div>
      </div>
    </div>
  </footer>

  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <script>
    $(function () {
      // Enable scrollspy for table of contents
      $('body').scrollspy({ target: '#toc' });
      
      // Smooth scrolling for anchor links
      $('a[href^="#"]').on('click', function(event) {
        if (this.hash !== '') {
          event.preventDefault();
          const hash = this.hash;
          $('html, body').animate({
            scrollTop: $(hash).offset().top - 60
          }, 800);
        }
      });
      
      // Highlight active section in TOC
      $(window).on('activate.bs.scrollspy', function () {
        const activeItem = $('#toc .nav-link.active').last();
        if (activeItem.length) {
          // Ensure active item is visible in scroll
          const tocContainer = $('#toc');
          const activeItemOffset = activeItem.offset().top;
          const tocContainerOffset = tocContainer.offset().top;
          const activeItemRelativeOffset = activeItemOffset - tocContainerOffset;
          
          if (activeItemRelativeOffset < 0 || activeItemRelativeOffset > tocContainer.height()) {
            tocContainer.animate({
              scrollTop: tocContainer.scrollTop() + activeItemRelativeOffset - 100
            }, 200);
          }
        }
      });
    });
  </script>
</body>
</html>
```


This comprehensive HTML page provides complete documentation of the 3D simulation integration with the IASMS system. The page follows the Bootstrap 4 template from the docs directory and includes:

1. A responsive navigation and table of contents with bookmarks for deep linking
2. Detailed sections for every aspect of the integration from setup to troubleshooting
3. Code examples with proper syntax highlighting
4. Tables for compatibility information and other structured data
5. Interactive elements like collapsible troubleshooting sections
6. Resource links to external documentation and tools
7. Visual elements including cards and icons to improve readability

The page is designed to be a complete reference for developers working with the 3D simulation, covering WebXR implementation, Three.js integration, AR/VR features, Meta Quest support, haptic feedback, spatial audio, and other key components.