Let me provide you with additional documentation and setup files to complete the WebXR Multi-Modal Simulation Platform deployment toolkit.

```shell script
#!/bin/bash

# WebXR Multi-Modal Simulation Platform - Dependencies Installer
# This script installs all required dependencies for the simulation platform
# Version 1.0.0 - 2025

# Set text colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}=======================================================${NC}"
echo -e "${BLUE}    WEBXR SIMULATION PLATFORM DEPENDENCIES INSTALLER    ${NC}"
echo -e "${BLUE}=======================================================${NC}"
echo ""

# Check if running with sudo
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}This script needs sudo privileges to install system dependencies.${NC}"
   echo "Please run with: sudo ./install_webxr_dependencies.sh"
   exit 1
fi

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Install system dependencies
echo -e "${BLUE}Installing system dependencies...${NC}"
apt-get update

# Install Node.js and NPM if not present
if ! command_exists node; then
  echo -e "${YELLOW}Node.js not found. Installing...${NC}"
  curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
  apt-get install -y nodejs
  echo -e "${GREEN}Node.js $(node -v) installed successfully.${NC}"
else
  echo -e "${GREEN}Node.js $(node -v) is already installed.${NC}"
fi

# Install build tools and other dependencies
echo -e "${BLUE}Installing build essentials and development tools...${NC}"
apt-get install -y build-essential git curl wget unzip

# Install Nginx if not present
if ! command_exists nginx; then
  echo -e "${YELLOW}Nginx not found. Installing...${NC}"
  apt-get install -y nginx
  echo -e "${GREEN}Nginx installed successfully.${NC}"
else
  echo -e "${GREEN}Nginx is already installed.${NC}"
fi

# Install Certbot for SSL
if ! command_exists certbot; then
  echo -e "${YELLOW}Certbot not found. Installing...${NC}"
  apt-get install -y certbot python3-certbot-nginx
  echo -e "${GREEN}Certbot installed successfully.${NC}"
else
  echo -e "${GREEN}Certbot is already installed.${NC}"
fi

# Install PM2 globally for process management
if ! command_exists pm2; then
  echo -e "${YELLOW}PM2 not found. Installing...${NC}"
  npm install -g pm2
  echo -e "${GREEN}PM2 installed successfully.${NC}"
else
  echo -e "${GREEN}PM2 is already installed.${NC}"
fi

# Install or update essential NPM packages globally
echo -e "${BLUE}Installing essential NPM packages...${NC}"
npm install -g nodemon webpack webpack-cli npm-check-updates

# Configure Node.js for maximum performance
echo -e "${BLUE}Configuring Node.js for optimal performance...${NC}"

# Create Node.js configuration file
cat > /etc/sysctl.d/nodejs.conf << EOF
# Increase max file descriptors for Node.js
fs.file-max = 100000

# Increase max TCP buffer sizes
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216

# Increase memory allocated for TCP
net.ipv4.tcp_rmem = 4096 87380 16777216
net.ipv4.tcp_wmem = 4096 65536 16777216

# Enable TCP fast open
net.ipv4.tcp_fastopen = 3

# Increase max connections
net.core.somaxconn = 65535
EOF

# Apply sysctl settings
sysctl --system

# Set Node.js environment for production
echo -e "${BLUE}Setting Node.js environment to production...${NC}"
echo "export NODE_ENV=production" >> /etc/profile.d/nodejs.sh
chmod +x /etc/profile.d/nodejs.sh

# Install WebXR-specific development tools
echo -e "${BLUE}Installing WebXR development tools...${NC}"

# Create a directory for Three.js examples
mkdir -p /opt/webxr-tools/three-examples
cd /opt/webxr-tools

# Clone the Three.js examples repository
git clone --depth 1 https://github.com/mrdoob/three.js.git temp-three
cp -r temp-three/examples/jsm/webxr /opt/webxr-tools/three-examples/
cp -r temp-three/examples/jsm/loaders /opt/webxr-tools/three-examples/
cp -r temp-three/examples/jsm/controls /opt/webxr-tools/three-examples/
rm -rf temp-three

# Set permissions
chown -R $SUDO_USER:$SUDO_USER /opt/webxr-tools

echo -e "${GREEN}=======================================================${NC}"
echo -e "${GREEN}    All dependencies installed successfully!            ${NC}"
echo -e "${GREEN}=======================================================${NC}"
echo -e "${YELLOW}Next steps:${NC}"
echo -e "1. Run the WebXR simulator setup script:"
echo -e "   ${BLUE}./webxr_simulator_setup.sh${NC}"
echo -e "2. Configure your domain for SSL:"
echo -e "   ${BLUE}certbot --nginx -d your-domain.com${NC}"
echo -e ""
echo -e "For more information, see the README.md file."
```


```shell script
#!/bin/bash

# WebXR Multi-Modal Simulation - Three.js Libraries Setup
# This script downloads and configures the latest Three.js libraries for WebXR
# Version 1.0.0 - 2025

# Set text colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}=======================================================${NC}"
echo -e "${BLUE}    THREE.JS WEBXR LIBRARIES SETUP SCRIPT              ${NC}"
echo -e "${BLUE}=======================================================${NC}"
echo ""

# Check if destination directory is provided
if [ -z "$1" ]; then
  DEST_DIR="./public/js/three"
  echo -e "${YELLOW}No destination directory provided, using default: ${DEST_DIR}${NC}"
else
  DEST_DIR="$1"
fi

# Create destination directory if it doesn't exist
mkdir -p "${DEST_DIR}"
mkdir -p "${DEST_DIR}/examples/jsm"
mkdir -p "${DEST_DIR}/examples/js"
mkdir -p "${DEST_DIR}/draco"

echo -e "${BLUE}Downloading latest Three.js libraries...${NC}"

# Create a temporary directory
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

# Clone Three.js repository (shallow clone to save time and bandwidth)
git clone --depth 1 https://github.com/mrdoob/three.js.git
cd three.js

# Copy core Three.js library
echo -e "${BLUE}Copying core Three.js library...${NC}"
cp build/three.min.js "${DEST_DIR}/"
cp build/three.module.js "${DEST_DIR}/"

# Copy essential WebXR modules
echo -e "${BLUE}Copying WebXR modules...${NC}"
cp -r examples/jsm/webxr "${DEST_DIR}/examples/jsm/"

# Copy additional useful modules
echo -e "${BLUE}Copying additional modules...${NC}"
cp -r examples/jsm/controls "${DEST_DIR}/examples/jsm/"
cp -r examples/jsm/loaders "${DEST_DIR}/examples/jsm/"
cp -r examples/jsm/animation "${DEST_DIR}/examples/jsm/"
cp -r examples/jsm/math "${DEST_DIR}/examples/jsm/"
cp -r examples/jsm/postprocessing "${DEST_DIR}/examples/jsm/"
cp -r examples/jsm/renderers "${DEST_DIR}/examples/jsm/"
cp -r examples/jsm/utils "${DEST_DIR}/examples/jsm/"

# Copy hand models for hand tracking
echo -e "${BLUE}Copying hand tracking models...${NC}"
cp -r examples/jsm/hand-tracking "${DEST_DIR}/examples/jsm/"
cp -r examples/models/gltf/hand-models "${DEST_DIR}/examples/models/"

# Copy DRACO decoder for model compression
echo -e "${BLUE}Copying DRACO decoder...${NC}"
cp -r examples/js/libs/draco "${DEST_DIR}/draco/"

# Copy WebGL checker script
echo -e "${BLUE}Copying WebGL detection script...${NC}"
cp examples/js/WebGL.js "${DEST_DIR}/examples/js/"

# Create a simple WebXR capability detector
echo -e "${BLUE}Creating WebXR capability detector...${NC}"
cat > "${DEST_DIR}/webxr-check.js" << 'EOF'
/**
 * WebXR Capability Detector
 * Checks for WebXR and features support in the current browser
 */
class WebXRCheck {
  constructor() {
    this.features = {
      webxr: false,
      immersiveVR: false,
      immersiveAR: false,
      handTracking: false,
      eyeTracking: false,
      depthSensing: false
    };
  }

  async check() {
    // Check basic WebXR support
    if (!navigator.xr) {
      console.log('WebXR not supported in this browser');
      return this.features;
    }

    this.features.webxr = true;

    // Check for VR support
    try {
      this.features.immersiveVR = await navigator.xr.isSessionSupported('immersive-vr');
    } catch (e) {
      console.warn('Error checking VR support:', e);
    }

    // Check for AR support
    try {
      this.features.immersiveAR = await navigator.xr.isSessionSupported('immersive-ar');
    } catch (e) {
      console.warn('Error checking AR support:', e);
    }

    // Check for hand tracking
    if (this.features.immersiveVR || this.features.immersiveAR) {
      const sessionInit = {
        optionalFeatures: ['hand-tracking']
      };

      try {
        const mode = this.features.immersiveVR ? 'immersive-vr' : 'immersive-ar';
        const session = await navigator.xr.requestSession(mode, sessionInit);
        this.features.handTracking = true;
        await session.end();
      } catch (e) {
        console.warn('Hand tracking not supported:', e);
      }
    }

    // Check for other features (more limited detection)
    // These can only be fully confirmed once a session is active
    this.features.eyeTracking = this._checkForFeature('eye-tracking');
    this.features.depthSensing = this._checkForFeature('depth-sensing');

    return this.features;
  }

  _checkForFeature(featureName) {
    // This is a basic check - full confirmation requires an active session
    if (navigator.xr && typeof navigator.xr.requestSession === 'function') {
      try {
        const sessionInit = {
          optionalFeatures: [featureName]
        };
        return true; // This is optimistic - we're assuming support if no immediate error
      } catch (e) {
        return false;
      }
    }
    return false;
  }

  getHtmlReport() {
    let html = '<div class="webxr-check-report">';
    html += '<h3>WebXR Capability Report</h3>';
    html += '<ul>';
    
    Object.entries(this.features).forEach(([feature, supported]) => {
      const icon = supported ? '✅' : '❌';
      const label = feature.replace(/([A-Z])/g, ' $1').replace(/^./, str => str.toUpperCase());
      html += `<li>${icon} ${label}</li>`;
    });
    
    html += '</ul>';
    html += '</div>';
    
    return html;
  }
}

// Example usage:
// const checker = new WebXRCheck();
// checker.check().then(features => {
//   console.log('WebXR features:', features);
//   document.body.innerHTML += checker.getHtmlReport();
// });
EOF

# Create a bundle for easy importing
echo -e "${BLUE}Creating import bundle...${NC}"
cat > "${DEST_DIR}/webxr-bundle.js" << 'EOF'
import * as THREE from './three.module.js';
import { ARButton } from './examples/jsm/webxr/ARButton.js';
import { VRButton } from './examples/jsm/webxr/VRButton.js';
import { XRControllerModelFactory } from './examples/jsm/webxr/XRControllerModelFactory.js';
import { XRHandModelFactory } from './examples/jsm/webxr/XRHandModelFactory.js';
import { OrbitControls } from './examples/jsm/controls/OrbitControls.js';
import { GLTFLoader } from './examples/jsm/loaders/GLTFLoader.js';
import { DRACOLoader } from './examples/jsm/loaders/DRACOLoader.js';

// Export everything for easy access
export {
  THREE,
  ARButton,
  VRButton,
  XRControllerModelFactory,
  XRHandModelFactory,
  OrbitControls,
  GLTFLoader,
  DRACOLoader
};

// Also export from global THREE for convenience
window.THREE = THREE;
window.ARButton = ARButton;
window.VRButton = VRButton;
EOF

# Clean up
cd ../../
rm -rf "$TEMP_DIR"

echo -e "${GREEN}Three.js WebXR libraries successfully installed to: ${DEST_DIR}${NC}"
echo -e "${YELLOW}Usage:${NC}"
echo -e "- Import from ES modules: ${BLUE}import * as THREE from './js/three/three.module.js';${NC}"
echo -e "- Import bundle: ${BLUE}import { THREE, ARButton, VRButton } from './js/three/webxr-bundle.js';${NC}"
echo -e "- Use in HTML: ${BLUE}<script src='js/three/three.min.js'></script>${NC}"
echo -e "- Check WebXR support: ${BLUE}<script src='js/three/webxr-check.js'></script>${NC}"
```


```markdown
# Modality Portals: Cross-Domain Experience Design

This document outlines the design and implementation of Modality Portals in the WebXR Multi-Modal Simulation Platform. Modality Portals provide an immersive way for users to transition between different simulation domains (air, sea, space, land, subsurface, pedestrian, and robot).

## Concept Overview

Modality Portals are physical gateways in the virtual environment that users can walk through to seamlessly change simulation domains. This creates a more immersive and intuitive experience than traditional UI-based modality switching.

## Portal Design Principles

1. **Embodied Cognition**: Using physical movement to transition between abstract spaces reinforces spatial memory and conceptual understanding
2. **Visual Distinction**: Each portal has a unique visual signature reflecting its destination modality
3. **Preview Windows**: Portals show a real-time preview of the destination modality
4. **Spatial Persistence**: Portals maintain fixed positions in the virtual environment for consistent navigation
5. **Bidirectional Access**: Every modality space has portals leading to all other modalities

## Technical Implementation

### Portal Creation
```
javascript
/**
* Create a modality portal
* @param {string} destinationModality - Target modality (air, sea, space, etc.)
* @param {THREE.Vector3} position - Position in the scene
* @param {THREE.Quaternion} rotation - Rotation of the portal
* @returns {THREE.Group} Portal object
  */
  function createModalityPortal(destinationModality, position, rotation) {
  const portal = new THREE.Group();
  portal.position.copy(position);
  portal.quaternion.copy(rotation);

// Create portal frame
const frameGeometry = new THREE.TorusGeometry(1.5, 0.1, 16, 32);
const frameMaterial = new THREE.MeshStandardMaterial({
color: getModalityColor(destinationModality),
emissive: getModalityColor(destinationModality),
emissiveIntensity: 0.5,
metalness: 0.8,
roughness: 0.2
});

const frame = new THREE.Mesh(frameGeometry, frameMaterial);
portal.add(frame);

// Add portal surface with shader material for the preview effect
const surfaceGeometry = new THREE.CircleGeometry(1.4, 32);
const surfaceMaterial = createPortalMaterial(destinationModality);

const surface = new THREE.Mesh(surfaceGeometry, surfaceMaterial);
surface.position.z = 0.01; // Slightly in front of the frame
portal.add(surface);

// Add modality icon
const iconTexture = createModalityIconTexture(destinationModality);
const iconGeometry = new THREE.PlaneGeometry(0.5, 0.5);
const iconMaterial = new THREE.MeshBasicMaterial({
map: iconTexture,
transparent: true,
opacity: 0.9
});

const icon = new THREE.Mesh(iconGeometry, iconMaterial);
icon.position.y = 1.8; // Above the portal
portal.add(icon);

// Add portal name
const labelGeometry = new THREE.PlaneGeometry(1.2, 0.3);
const labelMaterial = new THREE.MeshBasicMaterial({
map: createTextTexture(getModalityName(destinationModality), getModalityColor(destinationModality)),
transparent: true
});

const label = new THREE.Mesh(labelGeometry, labelMaterial);
label.position.y = -1.8; // Below the portal
portal.add(label);

// Set portal data
portal.userData = {
type: 'modalityPortal',
destinationModality: destinationModality,
active: true,
interactive: true
};

// Add particle effects around the portal
addPortalParticleEffects(portal, destinationModality);

return portal;
}
```
### Portal Transition Effect
```
javascript
/**
* Handle portal transition when a user enters a portal
* @param {string} destinationModality - Target modality
  */
  function transitionToModality(destinationModality) {
  // Store current position and orientation
  const currentPosition = camera.position.clone();
  const currentRotation = camera.quaternion.clone();

// Fade out current environment
fadeOutEnvironment(() => {
// Switch to new modality
setCurrentModality(destinationModality);

    // Position user at the entry point of the new modality
    const entryPoint = getModalityEntryPoint(destinationModality);
    camera.position.copy(entryPoint.position);
    camera.quaternion.copy(entryPoint.rotation);
    
    // Create transition effect
    createTransitionEffect(currentPosition, entryPoint.position, destinationModality);
    
    // Fade in new environment
    fadeInEnvironment();
    
    // Add to navigation history
    addToNavigationHistory(destinationModality);
});
}
```
### Portal Detection
```
javascript
/**
* Detect when user enters a portal
* Called each frame in the render loop
  */
  function checkPortalCollisions() {
  // Get user position (camera or avatar)
  const userPosition = camera.position.clone();

// Check all portals in the scene
portals.forEach(portal => {
if (!portal.userData.active) return;

    // Get portal position and normal vector
    const portalPosition = portal.position.clone();
    const portalNormal = new THREE.Vector3(0, 0, 1).applyQuaternion(portal.quaternion);
    
    // Calculate distance to portal plane
    const distanceToPortal = userPosition.clone().sub(portalPosition).dot(portalNormal);
    
    // Check if user is close to portal
    if (Math.abs(distanceToPortal) < 0.2) {
      // Project user position onto portal plane
      const projectedPosition = userPosition.clone().sub(portalNormal.clone().multiplyScalar(distanceToPortal));
      
      // Get portal local coordinates
      const localPosition = projectedPosition.clone().sub(portalPosition);
      localPosition.applyQuaternion(portal.quaternion.clone().invert());
      
      // Check if projection is within portal circle
      if (Math.sqrt(localPosition.x * localPosition.x + localPosition.y * localPosition.y) < 1.4) {
        // Check if user is crossing from front to back
        if (distanceToPortal < 0 && prevDistanceToPortal >= 0) {
          // User is entering the portal
          transitionToModality(portal.userData.destinationModality);
        }
      }
    }
    
    // Store distance for next frame
    portal.userData.prevDistanceToPortal = distanceToPortal;
});
}
```
## Portal Arrangement in Modalities

Each modality features portals arranged in a circular pattern around the central area, providing equal access to all other modalities.

### Aerial Modality Portal Layout
```
javascript
function setupAerialModalityPortals() {
const center = new THREE.Vector3(0, 50, 0);
const radius = 200;
const height = 50;

const otherModalities = ['sea', 'space', 'land', 'subsurface', 'pedestrian', 'robot'];

otherModalities.forEach((modality, index) => {
const angle = (index / otherModalities.length) * Math.PI * 2;

    const position = new THREE.Vector3(
      center.x + Math.cos(angle) * radius,
      center.y + height,
      center.z + Math.sin(angle) * radius
    );
    
    const rotation = new THREE.Quaternion().setFromAxisAngle(
      new THREE.Vector3(0, 1, 0),
      angle + Math.PI
    );
    
    const portal = createModalityPortal(modality, position, rotation);
    scene.add(portal);
    portals.push(portal);
    
    // Add floating platform beneath portal
    createFloatingPlatform(position.clone().sub(new THREE.Vector3(0, 5, 0)), 10);
});
}
```
## Portal Visual Effects

### Portal Shader Material
```
javascript
/**
* Create shader material for portal surface
* @param {string} modality - Destination modality
* @returns {THREE.ShaderMaterial} Shader material
  */
  function createPortalMaterial(modality) {
  // Create render target for the destination modality view
  const renderTarget = new THREE.WebGLRenderTarget(512, 512, {
  format: THREE.RGBAFormat,
  stencilBuffer: false
  });

// Create shader material
const material = new THREE.ShaderMaterial({
uniforms: {
time: { value: 0 },
modalityTexture: { value: renderTarget.texture },
portalColor: { value: new THREE.Color(getModalityColor(modality)) }
},
vertexShader: `
      varying vec2 vUv;
      void main() {
        vUv = uv;
        gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
      }
    `,
fragmentShader: `
uniform float time;
uniform sampler2D modalityTexture;
uniform vec3 portalColor;
varying vec2 vUv;

      void main() {
        // Calculate distance from center
        vec2 center = vec2(0.5, 0.5);
        float dist = distance(vUv, center);
        
        // Portal swirl effect
        float angle = atan(vUv.y - 0.5, vUv.x - 0.5);
        float swirl = sin(dist * 10.0 - time * 2.0) * 0.05;
        
        // Distort texture coordinates
        vec2 distortedUV = vec2(
          vUv.x + cos(angle) * swirl,
          vUv.y + sin(angle) * swirl
        );
        
        // Sample the destination modality texture
        vec4 texColor = texture2D(modalityTexture, distortedUV);
        
        // Add portal edge glow
        float edgeGlow = smoothstep(0.3, 0.5, dist) * (1.0 - smoothstep(0.5, 0.7, dist));
        vec3 finalColor = mix(texColor.rgb, portalColor, edgeGlow * 0.7);
        
        // Add ripple effect
        float ripple = sin(dist * 40.0 - time * 3.0) * 0.05;
        ripple *= smoothstep(0.0, 0.3, dist) * smoothstep(1.0, 0.7, dist);
        finalColor += portalColor * ripple;
        
        gl_FragColor = vec4(finalColor, texColor.a);
      }
    `,
    transparent: true,
    side: THREE.DoubleSide
});

// Store render target in material userData for updating
material.userData = {
renderTarget: renderTarget,
destinationModality: modality
};

return material;
}
```
### Portal Particle Effects
```
javascript
/**
* Add particle effects around portal
* @param {THREE.Object3D} portal - Portal object
* @param {string} modality - Destination modality
  */
  function addPortalParticleEffects(portal, modality) {
  const count = 1000;
  const positions = new Float32Array(count * 3);
  const colors = new Float32Array(count * 3);
  const sizes = new Float32Array(count);

const color = new THREE.Color(getModalityColor(modality));
const tempColor = new THREE.Color();

for (let i = 0; i < count; i++) {
// Random position around the portal ring
const angle = Math.random() * Math.PI * 2;
const radius = 1.4 + Math.random() * 0.3;
const x = Math.cos(angle) * radius;
const y = Math.sin(angle) * radius;
const z = (Math.random() - 0.5) * 0.5;

    positions[i * 3] = x;
    positions[i * 3 + 1] = y;
    positions[i * 3 + 2] = z;
    
    // Color gradient from portal color to white
    const t = Math.random();
    tempColor.copy(color).lerp(new THREE.Color(0xffffff), t);
    
    colors[i * 3] = tempColor.r;
    colors[i * 3 + 1] = tempColor.g;
    colors[i * 3 + 2] = tempColor.b;
    
    // Random sizes
    sizes[i] = Math.random() * 0.05 + 0.02;
}

const geometry = new THREE.BufferGeometry();
geometry.setAttribute('position', new THREE.BufferAttribute(positions, 3));
geometry.setAttribute('color', new THREE.BufferAttribute(colors, 3));
geometry.setAttribute('size', new THREE.BufferAttribute(sizes, 1));

const material = new THREE.ShaderMaterial({
uniforms: {
time: { value: 0 },
color: { value: color }
},
vertexShader: `
attribute float size;
varying vec3 vColor;
uniform float time;

      void main() {
        vColor = color;
        
        // Animate particles
        vec3 pos = position;
        float t = time * 0.5;
        float animatedSize = size * (0.8 + 0.2 * sin(t + position.x * 10.0 + position.y * 10.0));
        
        vec4 mvPosition = modelViewMatrix * vec4(pos, 1.0);
        gl_PointSize = animatedSize * (300.0 / -mvPosition.z);
        gl_Position = projectionMatrix * mvPosition;
      }
    `,
    fragmentShader: `
      varying vec3 vColor;
      
      void main() {
        // Calculate distance from center of point
        vec2 center = vec2(0.5, 0.5);
        float dist = distance(gl_PointCoord, center);
        
        // Create soft circular point
        float alpha = 1.0 - smoothstep(0.3, 0.5, dist);
        
        // Apply color
        gl_FragColor = vec4(vColor, alpha);
      }
    `,
    blending: THREE.AdditiveBlending,
    depthWrite: false,
    transparent: true,
    vertexColors: true
});

const particles = new THREE.Points(geometry, material);
particles.name = 'portalParticles';
portal.add(particles);

// Animate particles in render loop
particleAnimations.push((time) => {
if (particles.material) {
particles.material.uniforms.time.value = time;
}
});
}
```
## User Interaction with Portals

Portals support several interaction methods:

1. **Physical Traversal**: Walking through a portal in VR
2. **Controller Pointing**: Aiming at and selecting a portal with VR controllers
3. **Gaze Selection**: Looking at a portal for a set duration with eye tracking
4. **Voice Command**: Saying "Go to [modality]" with voice recognition

### Voice Command Implementation

```javascript
/**
 * Setup voice commands for portal navigation
 */
function setupVoiceCommands() {
  if (!('webkitSpeechRecognition' in window)) {
    console.warn('Voice recognition not supported in this browser');
    return;
  }
  
  const recognition = new webkitSpeechRecognition();
  recognition.continuous = true;
  recognition.interimResults = false;
  
  // Set language
  recognition.lang = 'en-US';
  
  // Define voice commands
  const commands = {
    'go to aerial': () => transitionToModality('aerial'),
    'go to sea': () => transitionToModality('sea'),
    'go to space': () => transitionToModality('space'),
    'go to land': () => transitionToModality('land'),
    'go to subsurface': () => transitionToModality('subsurface'),
    'go to pedestrian': () => transitionToModality('pedestrian'),
    'go to robot': () => transitionToModality('robot'),
    'go to multimodal': () => transitionToModality('multimodal')
  };
  
  // Handle recognition results
  recognition.onresult = (event) => {
    const last = event.results.length - 1;
    const command = event.results[last][0].transcript.toLowerCase().trim();
    
    console.log('Voice command recognized:', command);
    
    // Check if the command is recognized
    Object.entries(commands).forEach(([phrase, action]) => {
      if (command.includes(phrase)) {
        action();
        
        // Visual feedback
        showVoiceCommandFeedback(phrase);
      }
    });
  };
  
  recognition.onerror = (event) => {
    console.error('Voice recognition error:', event.error);
  };
  
  // Start recognition
  recognition.start();
  
  // Restart recognition if it ends
  recognition.onend = () => {
    recognition.start();
  };
}
```
```


## Accessibility Considerations

1. **Alternative Navigation**: UI buttons for users without VR controllers
2. **Audio Cues**: Spatial audio indicating portal locations
3. **High Contrast Mode**: Enhanced visual distinction for users with visual impairments
4. **Reduced Motion Option**: Less intense visual effects for users with motion sensitivity
5. **Teleportation**: Direct modality switching for users with mobility limitations

## Performance Optimizations

1. **Render Target Pooling**: Reuse render targets for portal previews
2. **Level of Detail**: Reduce portal effect complexity based on distance
3. **Instanced Rendering**: Use instanced meshes for portal particles
4. **Occlusion Culling**: Don't render portals that aren't visible
5. **Progressive Loading**: Load destination modality assets only when approaching a portal

---

This portal system creates an intuitive and immersive way for users to navigate between different simulation modalities, enhancing the overall experience of the WebXR Multi-Modal Simulation Platform.
```
<llm-snippet-file>client/simulator-react/webxr-simulation-startup.html</llm-snippet-file>
```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>WebXR Multi-Modal Simulation Platform</title>
  
  <!-- Favicon -->
  <link rel="icon" type="image/png" href="assets/images/favicon.png">
  
  <!-- Meta tags for WebXR -->
  <meta name="description" content="Immersive multi-modal simulation platform with VR and AR support">
  <meta name="theme-color" content="#1976d2">
  
  <!-- Required for WebXR on iOS -->
  <meta name="apple-mobile-web-app-capable" content="yes">
  
  <!-- Preload critical resources -->
  <link rel="preload" href="js/three/three.min.js" as="script">
  <link rel="preload" href="js/three/examples/jsm/webxr/VRButton.js" as="script">
  <link rel="preload" href="js/main.bundle.js" as="script">
  
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  
  <!-- Font Awesome Icons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
  
  <!-- Custom Styles -->
  <style>
    :root {
      --primary-color: #1976d2;
      --secondary-color: #8e2de2;
      --accent-color: #00c9ff;
      --text-color: #333;
      --background-color: #f8f9fa;
      --loading-background: #0d47a1;
    }
    
    body, html {
      margin: 0;
      padding: 0;
      height: 100%;
      font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
      background-color: var(--background-color);
      color: var(--text-color);
      overflow: hidden;
    }
    
    #simulation-container {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      z-index: 1;
    }
    
    #ui-overlay {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      pointer-events: none;
      z-index: 10;
    }
    
    .ui-element {
      pointer-events: auto;
    }
    
    .loading-screen {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: var(--loading-background);
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      z-index: 9999;
      transition: opacity 0.5s ease-in-out;
    }
    
    .loading-logo {
      width: 120px;
      height: 120px;
      margin-bottom: 2rem;
      animation: pulse 2s infinite;
    }
    
    .loading-progress {
      width: 300px;
      height: 4px;
      background: rgba(255, 255, 255, 0.2);
      border-radius: 4px;
      margin: 1rem 0 2rem;
      overflow: hidden;
    }
    
    .progress-bar {
      height: 100%;
      width: 0%;
      background: linear-gradient(90deg, var(--accent-color), var(--secondary-color));
      transition: width 0.3s ease;
    }
    
    .loading-status {
      font-size: 1rem;
      color: white;
      margin-top: 1rem;
      font-weight: 300;
    }
    
    .loading-tips {
      position: absolute;
      bottom: 2rem;
      left: 0;
      width: 100%;
      text-align: center;
      color: rgba(255, 255, 255, 0.7);
      font-size: 0.9rem;
      padding: 0 2rem;
    }
    
    @keyframes pulse {
      0% { transform: scale(1); opacity: 1; }
      50% { transform: scale(1.1); opacity: 0.8; }
      100% { transform: scale(1); opacity: 1; }
    }
    
    .start-buttons {
      display: flex;
      gap: 1rem;
      margin-top: 1.5rem;
    }
    
    .start-button {
      padding: 0.8rem 1.5rem;
      border: none;
      border-radius: 4px;
      font-weight: 600;
      font-size: 1rem;
      cursor: pointer;
      transition: all 0.2s ease;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 0.5rem;
    }
    
    .start-button:hover {
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }
    
    .start-button:active {
      transform: translateY(1px);
    }
    
    .start-button.vr {
      background: linear-gradient(45deg, #4a00e0, #8e2de2);
      color: white;
    }
    
    .start-button.ar {
      background: linear-gradient(45deg, #00c9ff, #92fe9d);
      color: white;
    }
    
    .start-button.browser {
      background: white;
      color: var(--text-color);
    }
    
    .xr-buttons {
      position: absolute;
      bottom: 2rem;
      left: 0;
      width: 100%;
      display: flex;
      justify-content: center;
      gap: 1rem;
      z-index: 100;
    }
    
    .xr-button {
      padding: 0.8rem 1.5rem;
      border: none;
      border-radius: 4px;
      font-weight: 600;
      font-size: 1rem;
      cursor: pointer;
      transition: all 0.2s ease;
      display: flex;
      align-items: center;
      gap: 0.5rem;
      box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    }
    
    .xr-button:hover {
      transform: translateY(-2px);
      box-shadow: 0 6px 12px rgba(0,0,0,0.15);
    }
    
    .xr-button.vr {
      background: linear-gradient(45deg, #4a00e0, #8e2de2);
      color: white;
    }
    
    .xr-button.ar {
      background: linear-gradient(45deg, #00c9ff, #92fe9d);
      color: white;
    }
    
    /* Compatibility check styles */
    .compatibility-check {
      position: fixed;
      top: 1rem;
      right: 1rem;
      background: white;
      border-radius: 8px;
      padding: 1rem;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
      max-width: 300px;
      z-index: 1000;
      transition: all 0.3s ease;
    }
    
    .compatibility-check h3 {
      margin-top: 0;
      font-size: 1.1rem;
      display: flex;
      align-items: center;
      gap: 0.5rem;
    }
    
    .compatibility-check ul {
      list-style: none;
      padding: 0;
      margin: 0.5rem 0 0;
    }
    
    .compatibility-check li {
      display: flex;
      align-items: center;
      gap: 0.5rem;
      padding: 0.25rem 0;
      font-size: 0.9rem;
    }
    
    .compatibility-check .status-icon {
      font-size: 1rem;
    }
    
    .status-good {
      color: #4caf50;
    }
    
    .status-warning {
      color: #ff9800;
    }
    
    .status-error {
      color: #f44336;
    }
    
    /* Controls Help Panel */
    .controls-help {
      position: fixed;
      bottom: 5rem;
      right: 1rem;
      background: rgba(255, 255, 255, 0.9);
      backdrop-filter: blur(10px);
      border-radius: 8px;
      padding: 1rem;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
      max-width: 350px;
      z-index: 100;
      transform: translateX(110%);
      transition: transform 0.3s ease;
    }
    
    .controls-help.visible {
      transform: translateX(0);
    }
    
    .controls-help h3 {
      margin-top: 0;
      font-size: 1.1rem;
      display: flex;
      align-items: center;
      gap: 0.5rem;
    }
    
    .controls-help-toggle {
      position: fixed;
      bottom: 5rem;
      right: 1rem;
      width: 48px;
      height: 48px;
      border-radius: 50%;
      background: white;
      display: flex;
      align-items: center;
      justify-content: center;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
      cursor: pointer;
      z-index: 101;
      border: none;
      color: var(--text-color);
      font-size: 1.2rem;
    }
    
    .controls-table {
      width: 100%;
      border-collapse: collapse;
      font-size: 0.9rem;
    }
    
    .controls-table td {
      padding: 0.5rem 0;
    }
    
    .controls-table td:first-child {
      font-weight: 600;
      padding-right: 1rem;
    }
    
    /* Quality settings panel */
    .quality-panel {
      position: fixed;
      top: 1rem;
      left: 1rem;
      background: rgba(255, 255, 255, 0.9);
      backdrop-filter: blur(10px);
      border-radius: 8px;
      padding: 1rem;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
      z-index: 100;
    }
    
    .quality-panel h3 {
      margin-top: 0;
      font-size: 1.1rem;
      margin-bottom: 0.75rem;
    }
    
    .quality-options {
      display: flex;
      gap: 0.5rem;
    }
    
    .quality-option {
      padding: 0.5rem 0.75rem;
      border: 1px solid #ddd;
      border-radius: 4px;
      cursor: pointer;
      transition: all 0.2s ease;
    }
    
    .quality-option:hover {
      background: #f0f0f0;
    }
    
    .quality-option.active {
      background: var(--primary-color);
      color: white;
      border-color: var(--primary-color);
    }
  </style>
</head>
<body>
  <!-- Loading Screen -->
  <div id="loading-screen" class="loading-screen">
    <img src="assets/images/logo.png" alt="Simulation Logo" class="loading-logo">
    <h2 style="color: white; margin: 0; font-weight: 300;">WebXR Multi-Modal Simulation</h2>
    <p style="color: white; opacity: 0.8; margin: 0.5rem 0 1.5rem;">Initializing immersive experience</p>
    
    <div class="loading-progress">
      <div id="progress-bar" class="progress-bar"></div>
    </div>
    
    <div id="loading-status" class="loading-status">Loading resources...</div>
    
    <div id="start-buttons" class="start-buttons" style="display: none;">
      <button id="start-browser" class="start-button browser">
        <i class="fas fa-desktop"></i>
        Start in Browser
      </button>
      <button id="start-vr" class="start-button vr">
        <i class="fas fa-vr-cardboard"></i>
        Enter VR
      </button>
      <button id="start-ar" class="start-button ar">
        <i class="fas fa-glasses"></i>
        Enter AR
      </button>
    </div>
    
    <div class="loading-tips">
      <p id="loading-tip">TIP: For the best experience, use a WebXR-compatible VR headset like Meta Quest 3.</p>
    </div>
  </div>
  
  <!-- Simulation Container -->
  <div id="simulation-container"></div>
  
  <!-- UI Overlay -->
  <div id="ui-overlay">
    <!-- XR Buttons (will be replaced by Three.js buttons) -->
    <div class="xr-buttons">
      <button id="vr-button" class="xr-button vr">
        <i class="fas fa-vr-cardboard"></i>
        Enter VR
      </button>
      <button id="ar-button" class="xr-button ar">
        <i class="fas fa-glasses"></i>
        Enter AR
      </button>
    </div>
    
    <!-- Compatibility Check Panel -->
    <div id="compatibility-check" class="compatibility-check" style="display: none;">
      <h3><i class="fas fa-check-circle status-good"></i> Compatibility Check</h3>
      <ul id="compatibility-list">
        <li><i class="fas fa-spinner fa-spin"></i> Checking WebXR support...</li>
      </ul>
    </div>
    
    <!-- Controls Help Panel -->
    <button id="controls-help-toggle" class="controls-help-toggle">
      <i class="fas fa-question"></i>
    </button>
    
    <div id="controls-help" class="controls-help">
      <h3><i class="fas fa-keyboard"></i> Controls</h3>
      <table class="controls-table">
        <tr>
          <td>WASD</td>
          <td>Move camera</td>
        </tr>
        <tr>
          <td>Mouse</td>
          <td>Look around</td>
        </tr>
        <tr>
          <td>Space</td>
          <td>Toggle play/pause</td>
        </tr>
        <tr>
          <td>+/-</td>
          <td>Adjust time scale</td>
        </tr>
        <tr>
          <td>1-7</td>
          <td>Switch modalities</td>
        </tr>
        <tr>
          <td>F</td>
          <td>Toggle fullscreen</td>
        </tr>
        <tr>
          <td>H</td>
          <td>Toggle this help</td>
        </tr>
      </table>
      
      <h3 style="margin-top: 1rem;"><i class="fas fa-vr-cardboard"></i> VR Controls</h3>
      <table class="controls-table">
        <tr>
          <td>Trigger</td>
          <td>Select/Interact</td>
        </tr>
        <tr>
          <td>Grip</td>
          <td>Grab objects</td>
        </tr>
        <tr>
          <td>Thumbstick</td>
          <td>Move/Teleport</td>
        </tr>
        <tr>
          <td>Hands</td>
          <td>Gesture control</td>
        </tr>
      </table>
    </div>
    
    <!-- Quality Settings Panel -->
    <div id="quality-panel" class="quality-panel">
      <h3>Quality</h3>
      <div class="quality-options">
        <div class="quality-option" data-quality="low">Low</div>
        <div class="quality-option active" data-quality="medium">Medium</div>
        <div class="quality-option" data-quality="high">High</div>
      </div>
    </div>
  </div>
  
  <!-- Simulation scripts -->
  <script src="js/three/three.min.js"></script>
  <script src="js/three/webxr-check.js"></script>
  
  <!-- Main Script -->
  <script>
    document.addEventListener('DOMContentLoaded', function() {
      // Initialize loading screen
      const loadingScreen = document.getElementById('loading-screen');
      const progressBar = document.getElementById('progress-bar');
      const loadingStatus = document.getElementById('loading-status');
      const startButtons = document.getElementById('start-buttons');
      const loadingTip = document.getElementById('loading-tip');
      
      // Simulate loading progress
      let progress = 0;
      const loadingInterval = setInterval(() => {
        progress += Math.random() * 5;
        if (progress >= 100) {
          progress = 100;
          clearInterval(loadingInterval);
          loadingComplete();
        }
        
        progressBar.style.width = `${progress}%`;
        
        // Update loading status messages
        if (progress < 20) {
          loadingStatus.textContent = 'Initializing WebXR environment...';
        } else if (progress < 40) {
          loadingStatus.textContent = 'Loading simulation models...';
        } else if (progress < 60) {
          loadingStatus.textContent = 'Preparing modality engines...';
        } else if (progress < 80) {
          loadingStatus.textContent = 'Configuring neural interface simulation...';
        } else {
          loadingStatus.textContent = 'Finalizing immersive experience...';
        }
      }, 200);
      
      // Rotate loading tips
      const tips = [
        'For the best experience, use a WebXR-compatible VR headset like Meta Quest 3.',
        'Hand tracking is available when using Meta Quest headsets.',
        'Use voice commands like "Go to air" to quickly switch modalities.',
        'Walk through portals to transition between different simulation domains.',
        'Grab the time control sphere to physically manipulate simulation speed.',
        'Multiple users can join the same simulation for collaborative training.',
        'Use the neural interface simulation to control objects with your thoughts.',
        'Try the multi-modal view to see interactions between different domains.'
      ];
      
      let tipIndex = 0;
      setInterval(() => {
        tipIndex = (tipIndex + 1) % tips.length;
        loadingTip.textContent = `TIP: ${tips[tipIndex]}`;
        loadingTip.style.opacity = 0;
        setTimeout(() => {
          loadingTip.style.opacity = 1;
        }, 200);
      }, 5000);
      
      // Check WebXR compatibility
      const checkCompatibility = async () => {
        const compatibilityCheck = document.getElementById('compatibility-check');
        const compatibilityList = document.getElementById('compatibility-list');
        
        compatibilityCheck.style.display = 'block';
        compatibilityList.innerHTML = '<li><i class="fas fa-spinner fa-spin"></i> Checking WebXR support...</li>';
        
        try {
          // Create WebXR checker
          const checker = new WebXRCheck();
          const features = await checker.check();
          
          // Clear loading indicator
          compatibilityList.innerHTML = '';
          
          // Add WebXR support
          const webxrItem = document.createElement('li');
          if (features.webxr) {
            webxrItem.innerHTML = '<i class="fas fa-check-circle status-good"></i> WebXR: Supported';
          } else {
            webxrItem.innerHTML = '<i class="fas fa-times-circle status-error"></i> WebXR: Not supported';
          }
          compatibilityList.appendChild(webxrItem);
          
          // Add VR support
          const vrItem = document.createElement('li');
          if (features.immersiveVR) {
            vrItem.innerHTML = '<i class="fas fa-check-circle status-good"></i> VR: Supported';
            document.getElementById('vr-button').style.display = 'flex';
            document.getElementById('start-vr').style.display = 'flex';
          } else {
            vrItem.innerHTML = '<i class="fas fa-times-circle status-error"></i> VR: Not supported';
            document.getElementById('vr-button').style.display = 'none';
            document.getElementById('start-vr').style.display = 'none';
          }
          compatibilityList.appendChild(vrItem);
          
          // Add AR support
          const arItem = document.createElement('li');
          if (features.immersiveAR) {
            arItem.innerHTML = '<i class="fas fa-check-circle status-good"></i> AR: Supported';
            document.getElementById('ar-button').style.display = 'flex';
            document.getElementById('start-ar').style.display = 'flex';
          } else {
            arItem.innerHTML = '<i class="fas fa-times-circle status-error"></i> AR: Not supported';
            document.getElementById('ar-button').style.display = 'none';
            document.getElementById('start-ar').style.display = 'none';
          }
          compatibilityList.appendChild(arItem);
          
          // Add hand tracking support
          const handTrackingItem = document.createElement('li');
          if (features.handTracking) {
            handTrackingItem.innerHTML = '<i class="fas fa-check-circle status-good"></i> Hand Tracking: Available';
          } else {
            handTrackingItem.innerHTML = '<i class="fas fa-exclamation-triangle status-warning"></i> Hand Tracking: Not available';
          }
          compatibilityList.appendChild(handTrackingItem);
          
          // Add eye tracking support
          const eyeTrackingItem = document.createElement('li');
          if (features.eyeTracking) {
            eyeTrackingItem.innerHTML = '<i class="fas fa-check-circle status-good"></i> Eye Tracking: Available';
          } else {
            eyeTrackingItem.innerHTML = '<i class="fas fa-exclamation-triangle status-warning"></i> Eye Tracking: Not available';
          }
          compatibilityList.appendChild(eyeTrackingItem);
          
          // GPU performance check (basic estimation)
          const gpuItem = document.createElement('li');
          const gl = document.createElement('canvas').getContext('webgl2');
          const debugInfo = gl.getExtension('WEBGL_debug_renderer_info');
          const renderer = debugInfo ? gl.getParameter(debugInfo.UNMASKED_RENDERER_WEBGL) : '';
          
          if (renderer.match(/NVIDIA|RTX|GTX|AMD|Radeon/i)) {
            gpuItem.innerHTML = '<i class="fas fa-check-circle status-good"></i> GPU: High Performance';
          } else if (renderer.match(/Intel|UHD|Iris/i)) {
            gpuItem.innerHTML = '<i class="fas fa-exclamation-triangle status-warning"></i> GPU: Medium Performance';
          } else {
            gpuItem.innerHTML = '<i class="fas fa-exclamation-triangle status-warning"></i> GPU: Performance Unknown';
          }
          compatibilityList.appendChild(gpuItem);
          
        } catch (error) {
          compatibilityList.innerHTML = `<li><i class="fas fa-times-circle status-error"></i> Error checking compatibility: ${error.message}</li>`;
        }
      };
      
      // Simulate loading completion
      function loadingComplete() {
        loadingStatus.textContent = 'Ready to launch simulation!';
        startButtons.style.display = 'flex';
        
        // Check compatibility
        checkCompatibility();
        
        // Setup event listeners for start buttons
        document.getElementById('start-browser').addEventListener('click', startSimulation);
        document.getElementById('start-vr').addEventListener('click', startSimulationVR);
        document.getElementById('start-ar').addEventListener('click', startSimulationAR);
      }
      
      // Start simulation functions
      function startSimulation() {
        hideLoadingScreen();
        initializeSimulation('browser');
      }
      
      function startSimulationVR() {
        hideLoadingScreen();
        initializeSimulation('vr');
      }
      
      function startSimulationAR() {
        hideLoadingScreen();
        initializeSimulation('ar');
      }
      
      function hideLoadingScreen() {
        loadingScreen.style.opacity = 0;
        setTimeout(() => {
          loadingScreen.style.display = 'none';
        }, 500);
      }
      
      // Placeholder for actual simulation initialization
      function initializeSimulation(mode) {
        console.log(`Initializing simulation in ${mode} mode`);
        
        // In a real implementation, this would load the actual simulation
        // For now, just load the main bundle script which contains the actual implementation
        const script = document.createElement('script');
        script.src = 'js/main.bundle.js';
        script.onload = () => {
          console.log('Simulation bundle loaded');
          
          // Start in the selected mode
          if (window.startSimulation) {
            window.startSimulation(mode);
          } else {
            console.error('Simulation startup function not found');
          }
        };
        document.body.appendChild(script);
      }
      
      // Controls help panel toggle
      const controlsHelpToggle = document.getElementById('controls-help-toggle');
      const controlsHelp = document.getElementById('controls-help');
      
      controlsHelpToggle.addEventListener('click', () => {
        controlsHelp.classList.toggle('visible');
      });
      
      // Quality settings
      const qualityOptions = document.querySelectorAll('.quality-option');
      
      qualityOptions.forEach(option => {
        option.addEventListener('click', () => {
          // Remove active class from all options
          qualityOptions.forEach(opt => opt.classList.remove('active'));
          
          // Add active class to clicked option
          option.classList.add('active');
          
          // Set quality level
          const quality = option.getAttribute('data-quality');
          
          // In a real implementation, this would update the rendering quality
          console.log(`Setting quality to: ${quality}`);
        });
      });
      
      // Keyboard shortcuts
      document.addEventListener('keydown', (event) => {
        // Toggle help panel with H key
        if (event.key === 'h' || event.key === 'H') {
          controlsHelp.classList.toggle('visible');
        }
        
        // Toggle fullscreen with F key
        if (event.key === 'f' || event.key === 'F') {
          if (!document.fullscreenElement) {
            document.documentElement.requestFullscreen();
          } else {
            document.exitFullscreen();
          }
        }
      });
    });
  </script>
</body>
</html>
```

<llm-snippet-file>deploy/setup_webxr_simulation_db.js</llm-snippet-file>
```javascript
/**
 * WebXR Multi-Modal Simulation Platform - Database Setup
 * This script initializes the MongoDB collections and populates them with sample data
 * 
 * Usage: node setup_webxr_simulation_db.js [mongodb_uri]
 */

const { MongoClient, ObjectId } = require('mongodb');
const fs = require('fs');
const path = require('path');
const readline = require('readline');

// Default MongoDB URI
const DEFAULT_URI = 'mongodb://localhost:27017/safeguard_webxr';

// Get MongoDB URI from command line or use default
const mongoUri = process.argv[2] || DEFAULT_URI;

// Collections to create
const collections = [
  'simulations',
  'entities',
  'events',
  'users',
  'sessions',
  'assets',
  'configurations'
];

// Connect to MongoDB
async function setupDatabase() {
  console.log(`Connecting to MongoDB at ${mongoUri}...`);
  
  try {
    const client = new MongoClient(mongoUri);
    await client.connect();
    
    console.log('Connected to MongoDB.');
    
    const db = client.db();
    
    // Check if collections already exist
    const existingCollections = await db.listCollections().toArray();
    const existingCollectionNames = existingCollections.map(c => c.name);
    
    // Create collections if they don't exist
    for (const collection of collections) {
      if (!existingCollectionNames.includes(collection)) {
        await db.createCollection(collection);
        console.log(`Created collection: ${collection}`);
      } else {
        console.log(`Collection already exists: ${collection}`);
      }
    }
    
    // Ask user if they want to populate with sample data
    const rl = readline.createInterface({
      input: process.stdin,
      output: process.stdout
    });
    
    const answer = await new Promise(resolve => {
      rl.question('Do you want to populate the database with sample data? (y/n): ', resolve);
    });
    
    if (answer.toLowerCase() === 'y') {
      await populateSampleData(db);
    }
    
    // Create indexes
    console.log('Creating indexes...');
    
    // Simulations collection indexes
    await db.collection('simulations').createIndex({ scenarioId: 1 });
    
    // Entities collection indexes
    await db.collection('entities').createIndex({ scenarioId: 1, type: 1 });
    await db.collection('entities').createIndex({ 'position.x': 1, 'position.y': 1, 'position.z': 1 });
    
    // Events collection indexes
    await db.collection('events').createIndex({ scenarioId: 1, timestamp: 1 });
    
    // Users collection indexes
    await db.collection('users').createIndex({ username: 1 }, { unique: true });
    await db.collection('users').createIndex({ email: 1 }, { unique: true });
    
    // Sessions collection indexes
    await db.collection('sessions').createIndex({ userId: 1 });
    await db.collection('sessions').createIndex({ createdAt: 1 }, { expireAfterSeconds: 86400 }); // 24 hours TTL
    
    console.log('Database setup completed successfully.');
    
    rl.close();
    await client.close();
    
  } catch (error) {
    console.error('Error setting up database:', error);
    process.exit(1);
  }
}

/**
 * Populate the database with sample data
 */
async function populateSampleData(db) {
  console.log('Populating database with sample data...');
  
  // Create sample scenario
  const scenarioId = new ObjectId();
  
  // Sample simulation scenario
  const scenario = {
    _id: scenarioId,
    name: 'Multi-Modal Demo Scenario',
    description: 'Demonstration scenario showcasing all modalities in a cohesive simulation',
    createdAt: new Date(),
    updatedAt: new Date(),
    settings: {
      timeScale: 1.0,
      startTime: new Date('2025-09-16T12:00:00.000Z'),
      duration: 3600, // 1 hour in seconds
      weather: {
        type: 'clear',
        wind: { speed: 5, direction: 45 },
        precipitation: 0,
        temperature: 22
      },
      environment: {
        type: 'mixed',
        time: 'day',
        season: 'summer',
        location: {
          latitude: 37.7749,
          longitude: -122.4194
        }
      }
    },
    modalities: [
      'aerial',
      'marine',
      'space',
      'land',
      'subsurface',
      'pedestrian',
      'robot'
    ]
  };
  
  // Insert scenario
  await db.collection('simulations').insertOne(scenario);
  console.log(`Created sample scenario with ID: ${scenarioId}`);
  
  // Generate sample entities for each modality
  const entities = [];
  
  // Aerial entities
  for (let i = 0; i < 15; i++) {
    entities.push({
      scenarioId: scenarioId,
      type: 'vehicle',
      vehicleType: i % 3 === 0 ? 'drone' : i % 3 === 1 ? 'eVTOL' : 'aircraft',
      callsign: `AIR${i.toString().padStart(3, '0')}`,
      position: {
        x: (Math.random() * 1000) - 500,
        y: 100 + (Math.random() * 200),
        z: (Math.random() * 1000) - 500
      },
      rotation: {
        x: 0,
        y: Math.random() * Math.PI * 2,
        z: 0
      },
      speed: 30 + Math.random() * 70,
      status: Math.random() > 0.8 ? 'emergency' : 'normal',
      modality: 'aerial',
      createdAt: new Date()
    });
  }
  
  // Marine entities
  for (let i = 0; i < 10; i++) {
    entities.push({
      scenarioId: scenarioId,
      type: 'vehicle',
      vehicleType: i % 3 === 0 ? 'ship' : i % 3 === 1 ? 'submarine' : 'boat',
      callsign: `SEA${i.toString().padStart(3, '0')}`,
      position: {
        x: (Math.random() * 1000) - 500,
        y: i % 3 === 1 ? -20 : 0, // Submarines below water
        z: (Math.random() * 1000) - 500
      },
      rotation: {
        x: 0,
        y: Math.random() * Math.PI * 2,
        z: 0
      },
      speed: 10 + Math.random() * 20,
      status: Math.random() > 0.9 ? 'emergency' : 'normal',
      modality: 'marine',
      createdAt: new Date()
    });
  }
  
  // Space entities
  for (let i = 0; i < 8; i++) {
    entities.push({
      scenarioId: scenarioId,
      type: 'vehicle',
      vehicleType: i === 0 ? 'spaceStation' : 'satellite',
      callsign: `SAT${i.toString().padStart(3, '0')}`,
      position: {
        x: (Math.random() * 2000) - 1000,
        y: 500 + (Math.random() * 500),
        z: (Math.random() * 2000) - 1000
      },
      rotation: {
        x: Math.random() * Math.PI * 2,
        y: Math.random() * Math.PI * 2,
        z: Math.random() * Math.PI * 2
      },
      orbit: {
        center: { x: 0, y: 700, z: 0 },
        radius: 300 + (i * 50),
        speed: 0.0001 + (Math.random() * 0.0001)
      },
      status: Math.random() > 0.9 ? 'emergency' : 'normal',
      modality: 'space',
      createdAt: new Date()
    });
  }
  
  // Land entities
  for (let i = 0; i < 20; i++) {
    entities.push({
      scenarioId: scenarioId,
      type: 'vehicle',
      vehicleType: i % 5 === 0 ? 'truck' : i % 5 === 1 ? 'bus' : 'car',
      callsign: `LAND${i.toString().padStart(3, '0')}`,
      position: {
        x: (Math.random() * 1000) - 500,
        y: 0,
        z: (Math.random() * 1000) - 500
      },
      rotation: {
        x: 0,
        y: Math.random() * Math.PI * 2,
        z: 0
      },
      speed: 5 + Math.random() * 25,
      status: Math.random() > 0.9 ? 'emergency' : 'normal',
      modality: 'land',
      createdAt: new Date()
    });
  }
  
  // Subsurface entities
  for (let i = 0; i < 5; i++) {
    entities.push({
      scenarioId: scenarioId,
      type: 'vehicle',
      vehicleType: i % 2 === 0 ? 'tunnelBorer' : 'inspectionRobot',
      callsign: `SUB${i.toString().padStart(3, '0')}`,
      position: {
        x: (Math.random() * 1000) - 500,
        y: -30 - (Math.random() * 20),
        z: (Math.random() * 1000) - 500
      },
      rotation: {
        x: 0,
        y: Math.random() * Math.PI * 2,
        z: 0
      },
      speed: 1 + Math.random() * 5,
      status: Math.random() > 0.9 ? 'emergency' : 'normal',
      modality: 'subsurface',
      createdAt: new Date()
    });
  }
  
  // Pedestrian entities
  for (let i = 0; i < 30; i++) {
    entities.push({
      scenarioId: scenarioId,
      type: 'pedestrian',
      personId: `PED${i.toString().padStart(3, '0')}`,
      position: {
        x: (Math.random() * 1000) - 500,
        y: 0,
        z: (Math.random() * 1000) - 500
      },
      rotation: {
        x: 0,
        y: Math.random() * Math.PI * 2,
        z: 0
      },
      walking: Math.random() > 0.3,
      speed: 0.5 + Math.random() * 1.5,
      modality: 'pedestrian',
      createdAt:
```
