I'll continue enhancing the AR/VR Simulation Training Module with more advanced features to make it even more immersive and effective.

## 5. Mission Planning and Scenario Builder Interface

Let's add a visual mission planning interface that allows instructors to create custom scenarios:

```textmate
/**
 * /client/iasms/components/MissionPlannerComponent.jsx
 * 
 * Visual Mission Planner for IASMS Simulation Training
 * Allows instructors to create and modify training scenarios visually
 * 
 * Copyright 2025 Autonomy Association International Inc., all rights reserved 
 * Safeguard patent license from National Aeronautics and Space Administration (NASA)
 * Copyright 2025 NASA, all rights reserved
 */

import React, { useState, useEffect, useRef } from 'react';
import { Meteor } from 'meteor/meteor';
import { useTracker } from 'meteor/react-meteor-data';
import * as THREE from 'three';
import { MapControls } from 'three/examples/jsm/controls/MapControls';
import { FontLoader } from 'three/examples/jsm/loaders/FontLoader';
import { TextGeometry } from 'three/examples/jsm/geometries/TextGeometry';

/**
 * Mission Planner component for visual scenario creation
 */
const MissionPlannerComponent = ({
  onScenarioSave = () => {},
  editingScenario = null
}) => {
  // DOM refs
  const containerRef = useRef(null);
  const menuRef = useRef(null);
  
  // Three.js refs
  const sceneRef = useRef(null);
  const cameraRef = useRef(null);
  const rendererRef = useRef(null);
  const controlsRef = useRef(null);
  const raycastRef = useRef(new THREE.Raycaster());
  const mouseRef = useRef(new THREE.Vector2());
  const fontRef = useRef(null);
  
  // Scenario editing state
  const [scenarioName, setScenarioName] = useState(editingScenario?.name || 'New Training Scenario');
  const [scenarioDescription, setScenarioDescription] = useState(
    editingScenario?.description || 'Custom training scenario'
  );
  const [difficulty, setDifficulty] = useState(editingScenario?.difficulty || 'medium');
  const [duration, setDuration] = useState(editingScenario?.duration || 45);
  const [environmentType, setEnvironmentType] = useState(
    editingScenario?.environment?.type || 'urban'
  );
  
  // Scenario elements
  const [waypoints, setWaypoints] = useState(editingScenario?.waypoints || []);
  const [vertiports, setVertiports] = useState(editingScenario?.environment?.vertiports || []);
  const [noFlyZones, setNoFlyZones] = useState(editingScenario?.noFlyZones || []);
  const [weatherEvents, setWeatherEvents] = useState(editingScenario?.events?.filter(
    e => e.type.includes('WEATHER')
  ) || []);
  const [emergencyEvents, setEmergencyEvents] = useState(editingScenario?.events?.filter(
    e => e.type.includes('EMERGENCY') || e.type.includes('FAILURE')
  ) || []);
  
  // UI state
  const [activeMode, setActiveMode] = useState('select');
  const [selectedObject, setSelectedObject] = useState(null);
  const [isDrawing, setIsDrawing] = useState(false);
  const [drawingPoints, setDrawingPoints] = useState([]);
  const [showHelp, setShowHelp] = useState(false);
  const [undoStack, setUndoStack] = useState([]);
  const [redoStack, setRedoStack] = useState([]);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [modalContent, setModalContent] = useState(null);
  
  // Constants
  const GRID_SIZE = 1000;
  const GRID_DIVISIONS = 20;
  
  /**
   * Initialize Three.js scene on component mount
   */
  useEffect(() => {
    if (!containerRef.current) return;
    
    // Create scene
    const scene = new THREE.Scene();
    scene.background = new THREE.Color(0xf0f0f0);
    sceneRef.current = scene;
    
    // Create camera
    const camera = new THREE.PerspectiveCamera(
      60,
      containerRef.current.clientWidth / containerRef.current.clientHeight,
      1,
      5000
    );
    camera.position.set(0, 500, 0);
    camera.lookAt(0, 0, 0);
    cameraRef.current = camera;
    
    // Create renderer
    const renderer = new THREE.WebGLRenderer({ antialias: true });
    renderer.setPixelRatio(window.devicePixelRatio);
    renderer.setSize(containerRef.current.clientWidth, containerRef.current.clientHeight);
    renderer.shadowMap.enabled = true;
    containerRef.current.appendChild(renderer.domElement);
    rendererRef.current = renderer;
    
    // Create controls
    const controls = new MapControls(camera, renderer.domElement);
    controls.enableDamping = true;
    controls.dampingFactor = 0.1;
    controls.screenSpacePanning = false;
    controls.minDistance = 100;
    controls.maxDistance = 1000;
    controls.maxPolarAngle = Math.PI / 2.5;
    controlsRef.current = controls;
    
    // Add lights
    addLighting(scene);
    
    // Add grid
    addGrid(scene);
    
    // Add coordinate axes
    addCoordinateAxes(scene);
    
    // Add compass
    addCompass(scene);
    
    // Load font for text
    const fontLoader = new FontLoader();
    fontLoader.load('/fonts/helvetiker_regular.typeface.json', (font) => {
      fontRef.current = font;
    });
    
    // Render loop
    const animate = () => {
      requestAnimationFrame(animate);
      
      // Update controls
      controls.update();
      
      // Render scene
      renderer.render(scene, camera);
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
    
    // Add event listeners for interaction
    if (renderer.domElement) {
      renderer.domElement.addEventListener('mousedown', handleMouseDown);
      renderer.domElement.addEventListener('mousemove', handleMouseMove);
      renderer.domElement.addEventListener('mouseup', handleMouseUp);
      renderer.domElement.addEventListener('contextmenu', handleContextMenu);
    }
    
    // If editing existing scenario, load elements
    if (editingScenario) {
      loadScenarioElements();
    }
    
    // Cleanup on unmount
    return () => {
      window.removeEventListener('resize', handleResize);
      
      if (renderer.domElement) {
        renderer.domElement.removeEventListener('mousedown', handleMouseDown);
        renderer.domElement.removeEventListener('mousemove', handleMouseMove);
        renderer.domElement.removeEventListener('mouseup', handleMouseUp);
        renderer.domElement.removeEventListener('contextmenu', handleContextMenu);
      }
      
      if (containerRef.current && renderer.domElement) {
        containerRef.current.removeChild(renderer.domElement);
      }
      
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
      
      renderer.dispose();
    };
  }, []);
  
  /**
   * Add lighting to the scene
   */
  const addLighting = (scene) => {
    // Ambient light
    const ambientLight = new THREE.AmbientLight(0xffffff, 0.6);
    scene.add(ambientLight);
    
    // Directional light
    const directionalLight = new THREE.DirectionalLight(0xffffff, 0.8);
    directionalLight.position.set(1, 1, 1).normalize();
    directionalLight.castShadow = true;
    directionalLight.shadow.mapSize.width = 2048;
    directionalLight.shadow.mapSize.height = 2048;
    directionalLight.shadow.camera.near = 0.5;
    directionalLight.shadow.camera.far = 500;
    directionalLight.shadow.camera.left = -250;
    directionalLight.shadow.camera.right = 250;
    directionalLight.shadow.camera.top = 250;
    directionalLight.shadow.camera.bottom = -250;
    scene.add(directionalLight);
  };
  
  /**
   * Add grid to the scene
   */
  const addGrid = (scene) => {
    // Main grid
    const grid = new THREE.GridHelper(GRID_SIZE, GRID_DIVISIONS, 0x888888, 0x888888);
    grid.material.opacity = 0.5;
    grid.material.transparent = true;
    scene.add(grid);
    
    // Create a ground plane
    const groundGeometry = new THREE.PlaneGeometry(GRID_SIZE, GRID_SIZE);
    const groundMaterial = new THREE.MeshBasicMaterial({
      color: 0xffffff,
      side: THREE.DoubleSide,
      transparent: true,
      opacity: 0.3
    });
    const ground = new THREE.Mesh(groundGeometry, groundMaterial);
    ground.rotation.x = Math.PI / 2;
    ground.position.y = -0.1;
    scene.add(ground);
  };
  
  /**
   * Add coordinate axes to the scene
   */
  const addCoordinateAxes = (scene) => {
    // Create axis lines
    const axisLength = GRID_SIZE / 2;
    
    // X axis (red)
    const xAxis = new THREE.Line(
      new THREE.BufferGeometry().setFromPoints([
        new THREE.Vector3(0, 0, 0),
        new THREE.Vector3(axisLength, 0, 0)
      ]),
      new THREE.LineBasicMaterial({ color: 0xff0000, linewidth: 2 })
    );
    scene.add(xAxis);
    
    // Y axis (green)
    const yAxis = new THREE.Line(
      new THREE.BufferGeometry().setFromPoints([
        new THREE.Vector3(0, 0, 0),
        new THREE.Vector3(0, axisLength, 0)
      ]),
      new THREE.LineBasicMaterial({ color: 0x00ff00, linewidth: 2 })
    );
    scene.add(yAxis);
    
    // Z axis (blue)
    const zAxis = new THREE.Line(
      new THREE.BufferGeometry().setFromPoints([
        new THREE.Vector3(0, 0, 0),
        new THREE.Vector3(0, 0, axisLength)
      ]),
      new THREE.LineBasicMaterial({ color: 0x0000ff, linewidth: 2 })
    );
    scene.add(zAxis);
    
    // Add labels if font is loaded
    if (fontRef.current) {
      addAxisLabels(scene, axisLength);
    }
  };
  
  /**
   * Add axis labels
   */
  const addAxisLabels = (scene, axisLength) => {
    const font = fontRef.current;
    if (!font) return;
    
    const createLabel = (text, position, color) => {
      const textGeometry = new TextGeometry(text, {
        font: font,
        size: 20,
        height: 2
      });
      const textMaterial = new THREE.MeshBasicMaterial({ color });
      const textMesh = new THREE.Mesh(textGeometry, textMaterial);
      textMesh.position.copy(position);
      scene.add(textMesh);
    };
    
    // Add X, Y, Z labels
    createLabel('X', new THREE.Vector3(axisLength + 10, 0, 0), 0xff0000);
    createLabel('Y', new THREE.Vector3(0, axisLength + 10, 0), 0x00ff00);
    createLabel('Z', new THREE.Vector3(0, 0, axisLength + 10), 0x0000ff);
  };
  
  /**
   * Add compass to the scene
   */
  const addCompass = (scene) => {
    // Create compass container
    const compass = new THREE.Group();
    compass.position.set(GRID_SIZE / 2 - 50, 10, GRID_SIZE / 2 - 50);
    
    // Create compass circle
    const circleGeometry = new THREE.CircleGeometry(30, 32);
    const circleMaterial = new THREE.MeshBasicMaterial({
      color: 0xffffff,
      side: THREE.DoubleSide,
      transparent: true,
      opacity: 0.7
    });
    const circle = new THREE.Mesh(circleGeometry, circleMaterial);
    circle.rotation.x = -Math.PI / 2;
    compass.add(circle);
    
    // Create compass directions
    const directions = [
      { letter: 'N', angle: 0, color: 0xff0000 },
      { letter: 'E', angle: Math.PI / 2, color: 0x000000 },
      { letter: 'S', angle: Math.PI, color: 0x000000 },
      { letter: 'W', angle: -Math.PI / 2, color: 0x000000 }
    ];
    
    directions.forEach(dir => {
      // Direction line
      const lineLength = dir.letter === 'N' ? 25 : 20;
      const lineGeometry = new THREE.BufferGeometry().setFromPoints([
        new THREE.Vector3(0, 0, 0),
        new THREE.Vector3(
          Math.sin(dir.angle) * lineLength,
          0,
          Math.cos(dir.angle) * lineLength
        )
      ]);
      const lineMaterial = new THREE.LineBasicMaterial({ color: dir.color, linewidth: 2 });
      const line = new THREE.Line(lineGeometry, lineMaterial);
      compass.add(line);
      
      // Label
      if (fontRef.current) {
        const textGeometry = new TextGeometry(dir.letter, {
          font: fontRef.current,
          size: 10,
          height: 1
        });
        const textMaterial = new THREE.MeshBasicMaterial({ color: dir.color });
        const textMesh = new THREE.Mesh(textGeometry, textMaterial);
        
        // Position label
        const labelDistance = lineLength + 10;
        textMesh.position.set(
          Math.sin(dir.angle) * labelDistance,
          0,
          Math.cos(dir.angle) * labelDistance
        );
        
        // Rotate label to face up
        textMesh.rotation.x = -Math.PI / 2;
        
        // Center text
        if (fontRef.current) {
          textGeometry.computeBoundingBox();
          const textWidth = textGeometry.boundingBox.max.x - textGeometry.boundingBox.min.x;
          const textHeight = textGeometry.boundingBox.max.y - textGeometry.boundingBox.min.y;
          textMesh.position.x -= textWidth / 2;
          textMesh.position.z -= textHeight / 2;
        }
        
        compass.add(textMesh);
      }
    });
    
    scene.add(compass);
  };
  
  /**
   * Load existing scenario elements
   */
  const loadScenarioElements = () => {
    if (!sceneRef.current || !editingScenario) return;
    
    // Load vertiports
    if (editingScenario.environment?.vertiports) {
      editingScenario.environment.vertiports.forEach(vertiport => {
        createVertiportMesh(vertiport);
      });
    }
    
    // Load waypoints
    if (editingScenario.waypoints) {
      editingScenario.waypoints.forEach(waypoint => {
        createWaypointMesh(waypoint);
      });
    }
    
    // Load no-fly zones
    if (editingScenario.noFlyZones) {
      editingScenario.noFlyZones.forEach(zone => {
        createNoFlyZoneMesh(zone);
      });
    }
    
    // Load weather events
    if (editingScenario.events) {
      editingScenario.events
        .filter(e => e.type.includes('WEATHER'))
        .forEach(event => {
          createWeatherEventMesh(event);
        });
    }
    
    // Load emergency events
    if (editingScenario.events) {
      editingScenario.events
        .filter(e => e.type.includes('EMERGENCY') || e.type.includes('FAILURE'))
        .forEach(event => {
          createEmergencyEventMesh(event);
        });
    }
  };
  
  /**
   * Create a vertiport mesh
   */
  const createVertiportMesh = (vertiport) => {
    if (!sceneRef.current) return;
    
    // Create group for vertiport
    const group = new THREE.Group();
    group.position.set(vertiport.position.x, 0, vertiport.position.z);
    group.userData = {
      type: 'vertiport',
      data: vertiport,
      id: vertiport.id
    };
    
    // Create vertiport pad
    const padGeometry = new THREE.CylinderGeometry(30, 30, 5, 32);
    const padMaterial = new THREE.MeshStandardMaterial({
      color: 0x333333,
      roughness: 0.8,
      metalness: 0.2
    });
    const pad = new THREE.Mesh(padGeometry, padMaterial);
    pad.position.y = 2.5;
    pad.receiveShadow = true;
    group.add(pad);
    
    // Create H marking
    const hGeometry = new THREE.PlaneGeometry(40, 40);
    const hMaterial = new THREE.MeshBasicMaterial({
      color: 0xffffff,
      side: THREE.DoubleSide
    });
    const hMarking = new THREE.Mesh(hGeometry, hMaterial);
    hMarking.rotation.x = -Math.PI / 2;
    hMarking.position.y = 5.1;
    
    // Create H marking texture
    const canvas = document.createElement('canvas');
    canvas.width = 256;
    canvas.height = 256;
    const ctx = canvas.getContext('2d');
    
    ctx.fillStyle = '#000000';
    ctx.fillRect(0, 0, 256, 256);
    
    ctx.fillStyle = '#ffffff';
    ctx.fillRect(50, 50, 50, 156); // Left vertical bar
    ctx.fillRect(156, 50, 50, 156); // Right vertical bar
    ctx.fillRect(50, 103, 156, 50); // Horizontal bar
    
    const texture = new THREE.CanvasTexture(canvas);
    hMaterial.map = texture;
    
    group.add(hMarking);
    
    // Add label if font is loaded
    if (fontRef.current) {
      const textGeometry = new TextGeometry(vertiport.name, {
        font: fontRef.current,
        size: 10,
        height: 1
      });
      
      const textMaterial = new THREE.MeshBasicMaterial({ color: 0x000000 });
      const textMesh = new THREE.Mesh(textGeometry, textMaterial);
      
      // Center text
      textGeometry.computeBoundingBox();
      const textWidth = textGeometry.boundingBox.max.x - textGeometry.boundingBox.min.x;
      textMesh.position.set(-textWidth / 2, 15, 0);
      
      group.add(textMesh);
    }
    
    // Add to scene
    sceneRef.current.add(group);
    
    return group;
  };
  
  /**
   * Create a waypoint mesh
   */
  const createWaypointMesh = (waypoint) => {
    if (!sceneRef.current) return;
    
    // Create group for waypoint
    const group = new THREE.Group();
    group.position.set(waypoint.coordinates[0], 0, waypoint.coordinates[1]);
    group.userData = {
      type: 'waypoint',
      data: waypoint,
      id: waypoint.id
    };
    
    // Create waypoint marker
    const markerGeometry = new THREE.SphereGeometry(10, 16, 16);
    const markerMaterial = new THREE.MeshStandardMaterial({
      color: 0x0088ff,
      roughness: 0.5,
      metalness: 0.5
    });
    const marker = new THREE.Mesh(markerGeometry, markerMaterial);
    marker.position.y = 10;
    marker.castShadow = true;
    group.add(marker);
    
    // Create altitude line
    const altitude = waypoint.altitude || 100;
    const lineGeometry = new THREE.BufferGeometry().setFromPoints([
      new THREE.Vector3(0, 0, 0),
      new THREE.Vector3(0, altitude, 0)
    ]);
    const lineMaterial = new THREE.LineBasicMaterial({ color: 0x0088ff });
    const line = new THREE.Line(lineGeometry, lineMaterial);
    group.add(line);
    
    // Add altitude marker
    const altMarkerGeometry = new THREE.SphereGeometry(5, 16, 16);
    const altMarkerMaterial = new THREE.MeshStandardMaterial({
      color: 0x0088ff,
      roughness: 0.5,
      metalness: 0.5
    });
    const altMarker = new THREE.Mesh(altMarkerGeometry, altMarkerMaterial);
    altMarker.position.y = altitude;
    group.add(altMarker);
    
    // Add label if font is loaded
    if (fontRef.current) {
      const textGeometry = new TextGeometry(waypoint.name, {
        font: fontRef.current,
        size: 8,
        height: 1
      });
      
      const textMaterial = new THREE.MeshBasicMaterial({ color: 0x000000 });
      const textMesh = new THREE.Mesh(textGeometry, textMaterial);
      
      // Center text
      textGeometry.computeBoundingBox();
      const textWidth = textGeometry.boundingBox.max.x - textGeometry.boundingBox.min.x;
      textMesh.position.set(-textWidth / 2, 25, 0);
      
      group.add(textMesh);
      
      // Add altitude text
      const altTextGeometry = new TextGeometry(`${altitude}m`, {
        font: fontRef.current,
        size: 6,
        height: 1
      });
      
      const altTextMaterial = new THREE.MeshBasicMaterial({ color: 0x0088ff });
      const altTextMesh = new THREE.Mesh(altTextGeometry, altTextMaterial);
      
      // Position altitude text
      altTextGeometry.computeBoundingBox();
      const altTextWidth = altTextGeometry.boundingBox.max.x - altTextGeometry.boundingBox.min.x;
      altTextMesh.position.set(-altTextWidth / 2, altitude + 10, 0);
      
      group.add(altTextMesh);
    }
    
    // Add to scene
    sceneRef.current.add(group);
    
    return group;
  };
  
  /**
   * Create a no-fly zone mesh
   */
  const createNoFlyZoneMesh = (zone) => {
    if (!sceneRef.current) return;
    
    // Create group for zone
    const group = new THREE.Group();
    group.userData = {
      type: 'noFlyZone',
      data: zone,
      id: zone.id
    };
    
    // Create zone shape
    const shape = new THREE.Shape();
    
    // Add points to shape
    if (zone.coordinates && zone.coordinates.length > 2) {
      shape.moveTo(zone.coordinates[0][0], zone.coordinates[0][1]);
      
      for (let i = 1; i < zone.coordinates.length; i++) {
        shape.lineTo(zone.coordinates[i][0], zone.coordinates[i][1]);
      }
      
      shape.lineTo(zone.coordinates[0][0], zone.coordinates[0][1]);
    } else {
      // Default to square if no coordinates
      shape.moveTo(-50, -50);
      shape.lineTo(50, -50);
      shape.lineTo(50, 50);
      shape.lineTo(-50, 50);
      shape.lineTo(-50, -50);
    }
    
    // Create extruded geometry
    const extrudeSettings = {
      depth: zone.maxAltitude || 200,
      bevelEnabled: false
    };
    
    const geometry = new THREE.ExtrudeGeometry(shape, extrudeSettings);
    
    // Create material
    const material = new THREE.MeshStandardMaterial({
      color: 0xff0000,
      transparent: true,
      opacity: 0.3,
      side: THREE.DoubleSide
    });
    
    // Create mesh
    const mesh = new THREE.Mesh(geometry, material);
    mesh.rotation.x = -Math.PI / 2;
    group.add(mesh);
    
    // Create outline
    const points = [];
    
    if (zone.coordinates && zone.coordinates.length > 2) {
      // Add outline points
      for (let i = 0; i < zone.coordinates.length; i++) {
        points.push(new THREE.Vector3(zone.coordinates[i][0], 0, zone.coordinates[i][1]));
      }
      
      // Close the loop
      points.push(new THREE.Vector3(zone.coordinates[0][0], 0, zone.coordinates[0][1]));
    } else {
      // Default square outline
      points.push(new THREE.Vector3(-50, 0, -50));
      points.push(new THREE.Vector3(50, 0, -50));
      points.push(new THREE.Vector3(50, 0, 50));
      points.push(new THREE.Vector3(-50, 0, 50));
      points.push(new THREE.Vector3(-50, 0, -50));
    }
    
    const lineGeometry = new THREE.BufferGeometry().setFromPoints(points);
    const lineMaterial = new THREE.LineBasicMaterial({ color: 0xff0000, linewidth: 2 });
    const line = new THREE.Line(lineGeometry, lineMaterial);
    group.add(line);
    
    // Add altitude markers
    const minAltitude = zone.minAltitude || 0;
    const maxAltitude = zone.maxAltitude || 200;
    
    // Create vertical lines at corners
    if (zone.coordinates && zone.coordinates.length > 2) {
      for (let i = 0; i < zone.coordinates.length; i++) {
        const vertLineGeometry = new THREE.BufferGeometry().setFromPoints([
          new THREE.Vector3(zone.coordinates[i][0], 0, zone.coordinates[i][1]),
          new THREE.Vector3(zone.coordinates[i][0], maxAltitude, zone.coordinates[i][1])
        ]);
        const vertLine = new THREE.Line(vertLineGeometry, lineMaterial);
        group.add(vertLine);
      }
    }
    
    // Add label if font is loaded
    if (fontRef.current) {
      // Calculate center point
      let centerX = 0;
      let centerZ = 0;
      
      if (zone.coordinates && zone.coordinates.length > 0) {
        for (const coord of zone.coordinates) {
          centerX += coord[0];
          centerZ += coord[1];
        }
        centerX /= zone.coordinates.length;
        centerZ /= zone.coordinates.length;
      }
      
      const textGeometry = new TextGeometry(zone.name || 'No-Fly Zone', {
        font: fontRef.current,
        size: 10,
        height: 1
      });
      
      const textMaterial = new THREE.MeshBasicMaterial({ color: 0xff0000 });
      const textMesh = new THREE.Mesh(textGeometry, textMaterial);
      
      // Center text
      textGeometry.computeBoundingBox();
      const textWidth = textGeometry.boundingBox.max.x - textGeometry.boundingBox.min.x;
      textMesh.position.set(centerX - textWidth / 2, maxAltitude + 10, centerZ);
      
      group.add(textMesh);
      
      // Add altitude range text
      const altTextGeometry = new TextGeometry(`${minAltitude}m - ${maxAltitude}m`, {
        font: fontRef.current,
        size: 8,
        height: 1
      });
      
      const altTextMaterial = new THREE.MeshBasicMaterial({ color: 0xff0000 });
      const altTextMesh = new THREE.Mesh(altTextGeometry, altTextMaterial);
      
      // Position altitude text
      altTextGeometry.computeBoundingBox();
      const altTextWidth = altTextGeometry.boundingBox.max.x - altTextGeometry.boundingBox.min.x;
      altTextMesh.position.set(centerX - altTextWidth / 2, maxAltitude + 25, centerZ);
      
      group.add(altTextMesh);
    }
    
    // Add to scene
    sceneRef.current.add(group);
    
    return group;
  };
  
  /**
   * Create a weather event mesh
   */
  const createWeatherEventMesh = (event) => {
    if (!sceneRef.current) return;
    
    // Create group for event
    const group = new THREE.Group();
    group.userData = {
      type: 'weatherEvent',
      data: event,
      id: event.id
    };
    
    // Set position from event data
    if (event.data && event.data.area && event.data.area.coordinates) {
      group.position.set(
        event.data.area.coordinates[0],
        0,
        event.data.area.coordinates[1]
      );
    }
    
    // Determine weather type and color
    let color;
    let icon;
    
    switch (event.type) {
      case 'WEATHER_THUNDERSTORM':
        color = 0xff0000;
        icon = '⚡';
        break;
      case 'WEATHER_RAIN':
        color = 0x0066ff;
        icon = '🌧️';
        break;
      case 'WEATHER_SNOW':
        color = 0xaaaaff;
        icon = '❄️';
        break;
      case 'WEATHER_WIND':
      case 'WEATHER_SEVERE_WIND':
        color = 0xffaa00;
        icon = '💨';
        break;
      case 'WEATHER_FOG':
        color = 0xaaaaaa;
        icon = '🌫️';
        break;
      default:
        color = 0xffff00;
        icon = '⚠️';
    }
    
    // Create event visualization
    const radius = event.data?.radius || 100;
    
    // Create cylinder for affected area
    const cylinderGeometry = new THREE.CylinderGeometry(radius, radius, 200, 32, 1, true);
    const cylinderMaterial = new THREE.MeshStandardMaterial({
      color,
      transparent: true,
      opacity: 0.3,
      side: THREE.DoubleSide
    });
    const cylinder = new THREE.Mesh(cylinderGeometry, cylinderMaterial);
    cylinder.position.y = 100;
    group.add(cylinder);
    
    // Create circle for ground indicator
    const circleGeometry = new THREE.CircleGeometry(radius, 32);
    const circleMaterial = new THREE.MeshBasicMaterial({
      color,
      transparent: true,
      opacity: 0.3,
      side: THREE.DoubleSide
    });
    const circle = new THREE.Mesh(circleGeometry, circleMaterial);
    circle.rotation.x = -Math.PI / 2;
    circle.position.y = 0.1;
    group.add(circle);
    
    // Add outline
    const outlineGeometry = new THREE.RingGeometry(radius - 0.5, radius + 0.5, 64);
    const outlineMaterial = new THREE.MeshBasicMaterial({
      color,
      side: THREE.DoubleSide
    });
    const outline = new THREE.Mesh(outlineGeometry, outlineMaterial);
    outline.rotation.x = -Math.PI / 2;
    outline.position.y = 0.2;
    group.add(outline);
    
    // Add label if font is loaded
    if (fontRef.current) {
      const eventName = event.data?.alertType || event.type.replace('WEATHER_', '');
      const textGeometry = new TextGeometry(eventName, {
        font: fontRef.current,
        size: 15,
        height: 1
      });
      
      const textMaterial = new THREE.MeshBasicMaterial({ color });
      const textMesh = new THREE.Mesh(textGeometry, textMaterial);
      
      // Center text
      textGeometry.computeBoundingBox();
      const textWidth = textGeometry.boundingBox.max.x - textGeometry.boundingBox.min.x;
      textMesh.position.set(-textWidth / 2, 220, 0);
      
      group.add(textMesh);
      
      // Add time text
      let timeText;
      if (event.data?.startTime && event.data?.endTime) {
        timeText = `Time: ${event.time || 0}min - ${event.time + 15}min`;
      } else {
        timeText = `Time: ${event.time || 0}min`;
      }
      
      const timeGeometry = new TextGeometry(timeText, {
        font: fontRef.current,
        size: 10,
        height: 1
      });
      
      const timeMaterial = new THREE.MeshBasicMaterial({ color });
      const timeMesh = new THREE.Mesh(timeGeometry, timeMaterial);
      
      // Position time text
      timeGeometry.computeBoundingBox();
      const timeWidth = timeGeometry.boundingBox.max.x - timeGeometry.boundingBox.min.x;
      timeMesh.position.set(-timeWidth / 2, 240, 0);
      
      group.add(timeMesh);
    }
    
    // Add to scene
    sceneRef.current.add(group);
    
    return group;
  };
  
  /**
   * Create an emergency event mesh
   */
  const createEmergencyEventMesh = (event) => {
    if (!sceneRef.current) return;
    
    // Create group for event
    const group = new THREE.Group();
    group.userData = {
      type: 'emergencyEvent',
      data: event,
      id: event.id
    };
    
    // Set position from event data
    if (event.data && event.data.location && event.data.location.coordinates) {
      group.position.set(
        event.data.location.coordinates[0],
        0,
        event.data.location.coordinates[1]
      );
    } else {
      // Random position if not specified
      group.position.set(
        (Math.random() - 0.5) * GRID_SIZE * 0.8,
        0,
        (Math.random() - 0.5) * GRID_SIZE * 0.8
      );
    }
    
    // Determine emergency type and color
    let color;
    let icon;
    
    switch (event.type) {
      case 'VEHICLE_EMERGENCY':
        color = 0xff3300;
        icon = '🚨';
        break;
      case 'SYSTEM_FAILURE':
        color = 0xcc0000;
        icon = '⚠️';
        break;
      case 'VERTIPORT_EMERGENCY':
        color = 0xff6600;
        icon = '🚨';
        break;
      case 'MULTIPLE_LOST_LINKS':
        color = 0xff00ff;
        icon = '📡';
        break;
      default:
        color = 0xff0000;
        icon = '⚠️';
    }
    
    // Create emergency visualization
    const radius = 15;
    
    // Create pulsing sphere
    const sphereGeometry = new THREE.SphereGeometry(radius, 16, 16);
    const sphereMaterial = new THREE.MeshStandardMaterial({
      color,
      transparent: true,
      opacity: 0.7,
      emissive: color,
      emissiveIntensity: 0.5
    });
    const sphere = new THREE.Mesh(sphereGeometry, sphereMaterial);
    sphere.position.y = radius;
    
    // Add animation data for pulsing
    sphere.userData.animation = {
      type: 'pulse',
      time: 0,
      speed: 1 + Math.random(),
      baseScale: 1,
      pulseScale: 0.2
    };
    
    group.add(sphere);
    
    // Create warning icon (exclamation mark)
    const warningGeometry = new THREE.CylinderGeometry(2, 2, 20, 8);
    const warningMaterial = new THREE.MeshStandardMaterial({
      color: 0xffffff,
      emissive: 0xffffff,
      emissiveIntensity: 0.5
    });
    const warning = new THREE.Mesh(warningGeometry, warningMaterial);
    warning.position.y = radius + 15;
    group.add(warning);
    
    const dotGeometry = new THREE.SphereGeometry(2, 8, 8);
    const dot = new THREE.Mesh(dotGeometry, warningMaterial);
    dot.position.y = radius + 30;
    group.add(dot);
    
    // Add label if font is loaded
    if (fontRef.current) {
      let eventName;
      
      if (event.type === 'VEHICLE_EMERGENCY') {
        eventName = event.data?.emergencyType || 'Vehicle Emergency';
      } else if (event.type === 'SYSTEM_FAILURE') {
        eventName = event.data?.systemType || 'System Failure';
      } else {
        eventName = event.type.replace('_', ' ');
      }
      
      const textGeometry = new TextGeometry(eventName, {
        font: fontRef.current,
        size: 10,
        height: 1
      });
      
      const textMaterial = new THREE.MeshBasicMaterial({ color });
      const textMesh = new THREE.Mesh(textGeometry, textMaterial);
      
      // Center text
      textGeometry.computeBoundingBox();
      const textWidth = textGeometry.boundingBox.max.x - textGeometry.boundingBox.min.x;
      textMesh.position.set(-textWidth / 2, radius + 40, 0);
      
      group.add(textMesh);
      
      // Add time text
      const timeText = `Time: ${event.time || 0}min`;
      
      const timeGeometry = new TextGeometry(timeText, {
        font: fontRef.current,
        size: 8,
        height: 1
      });
      
      const timeMaterial = new THREE.MeshBasicMaterial({ color });
      const timeMesh = new THREE.Mesh(timeGeometry, timeMaterial);
      
      // Position time text
      timeGeometry.computeBoundingBox();
      const timeWidth = timeGeometry.boundingBox.max.x - timeGeometry.boundingBox.min.x;
      timeMesh.position.set(-timeWidth / 2, radius + 55, 0);
      
      group.add(timeMesh);
      
      // Add severity text if available
      if (event.data && event.data.severity !== undefined) {
        const severity = parseFloat(event.data.severity);
        let severityText;
        
        if (severity >= 0.8) {
          severityText = 'Severity: Critical';
        } else if (severity >= 0.6) {
          severityText = 'Severity: High';
        } else if (severity >= 0.4) {
          severityText = 'Severity: Medium';
        } else {
          severityText = 'Severity: Low';
        }
        
        const sevGeometry = new TextGeometry(severityText, {
          font: fontRef.current,
          size: 8,
          height: 1
        });
        
        const sevMaterial = new THREE.MeshBasicMaterial({ color });
        const sevMesh = new THREE.Mesh(sevGeometry, sevMaterial);
        
        // Position severity text
        sevGeometry.computeBoundingBox();
        const sevWidth = sevGeometry.boundingBox.max.x - sevGeometry.boundingBox.min.x;
        sevMesh.position.set(-sevWidth / 2, radius + 70, 0);
        
        group.add(sevMesh);
      }
    }
    
    // Add to scene
    sceneRef.current.add(group);
    
    return group;
  };
  
  /**
   * Handle mouse down event
   */
  const handleMouseDown = (event) => {
    if (!containerRef.current || !sceneRef.current || !cameraRef.current) return;
    
    // Prevent default behavior
    event.preventDefault();
    
    // Get mouse position
    const rect = containerRef.current.getBoundingClientRect();
    mouseRef.current.x = ((event.clientX - rect.left) / containerRef.current.clientWidth) * 2 - 1;
    mouseRef.current.y = -((event.clientY - rect.top) / containerRef.current.clientHeight) * 2 + 1;
    
    // Left mouse button
    if (event.button === 0) {
      if (activeMode === 'draw') {
        // Start drawing
        setIsDrawing(true);
        
        // Raycast to get world position
        raycastRef.current.setFromCamera(mouseRef.current, cameraRef.current);
        const intersects = raycastRef.current.intersectObjects(sceneRef.current.children, true);
        
        // Find ground plane intersection
        const groundIntersect = intersects.find(intersect => {
          return intersect.object.type === 'Mesh' && 
                 intersect.object.geometry.type === 'PlaneGeometry';
        });
        
        if (groundIntersect) {
          const point = [
            groundIntersect.point.x,
            groundIntersect.point.z
          ];
          
          setDrawingPoints([point]);
        }
      } else if (activeMode === 'select') {
        // Select object
        raycastRef.current.setFromCamera(mouseRef.current, cameraRef.current);
        const intersects = raycastRef.current.intersectObjects(sceneRef.current.children, true);
        
        let selected = null;
        
        // Find the first object with userData
        for (const intersect of intersects) {
          let object = intersect.object;
          
          // Traverse up to find parent with userData
          while (object && (!object.userData || !object.userData.type)) {
            object = object.parent;
          }
          
          if (object && object.userData && object.userData.type) {
            selected = object;
            break;
          }
        }
        
        setSelectedObject(selected);
      } else if (activeMode === 'place') {
        // Place new object
        raycastRef.current.setFromCamera(mouseRef.current, cameraRef.current);
        const intersects = raycastRef.current.intersectObjects(sceneRef.current.children, true);
        
        // Find ground plane intersection
        const groundIntersect = intersects.find(intersect => {
          return intersect.object.type === 'Mesh' && 
                 intersect.object.geometry.type === 'PlaneGeometry';
        });
        
        if (groundIntersect) {
          const position = groundIntersect.point;
          
          // Create different object types based on mode
          if (activeMode === 'placeVertiport') {
            createNewVertiport(position);
          } else if (activeMode === 'placeWaypoint') {
            createNewWaypoint(position);
          } else if (activeMode === 'placeWeather') {
            createNewWeatherEvent(position);
          } else if (activeMode === 'placeEmergency') {
            createNewEmergencyEvent(position);
          }
        }
      }
    }
  };
  
  /**
   * Handle mouse move event
   */
  const handleMouseMove = (event) => {
    if (!containerRef.current || !sceneRef.current || !cameraRef.current) return;
    
    // Get mouse position
    const rect = containerRef.current.getBoundingClientRect();
    mouseRef.current.x = ((event.clientX - rect.left) / containerRef.current.clientWidth) * 2 - 1;
    mouseRef.current.y = -((event.clientY - rect.top) / containerRef.current.clientHeight) * 2 + 1;
    
    // If drawing, add points
    if (isDrawing && activeMode === 'draw') {
      // Raycast to get world position
      raycastRef.current.setFromCamera(mouseRef.current, cameraRef.current);
      const intersects = raycastRef.current.intersectObjects(sceneRef.current.children, true);
      
      // Find ground plane intersection
      const groundIntersect = intersects.find(intersect => {
        return intersect.object.type === 'Mesh' && 
               intersect.object.geometry.type === 'PlaneGeometry';
      });
      
      if (groundIntersect) {
        const point = [
          groundIntersect.point.x,
          groundIntersect.point.z
        ];
        
        // Only add point if it's different enough from the last one
        const lastPoint = drawingPoints[drawingPoints.length - 1];
        if (lastPoint) {
          const dx = point[0] - lastPoint[0];
          const dy = point[1] - lastPoint[1];
          const distance = Math.sqrt(dx * dx + dy * dy);
          
          if (distance > 10) {
            setDrawingPoints([...drawingPoints, point]);
          }
        }
      }
    }
  };
  
  /**
   * Handle mouse up event
   */
  const handleMouseUp = (event) => {
    // Left mouse button
    if (event.button === 0) {
      if (isDrawing && activeMode === 'draw') {
        // Finish drawing
        setIsDrawing(false);
        
        // If we have enough points, create no-fly zone
        if (drawingPoints.length >= 3) {
          createNewNoFlyZone(drawingPoints);
        }
        
        // Reset drawing points
        setDrawingPoints([]);
      }
    }
  };
  
  /**
   * Handle context menu (right click)
   */
  const handleContextMenu = (event) => {
    event.preventDefault();
    
    // Show context menu
    if (selectedObject) {
      // Position menu at mouse position
      if (menuRef.current) {
        menuRef.current.style.display = 'block';
        menuRef.current.style.left = `${event.clientX}px`;
        menuRef.current.style.top = `${event.clientY}px`;
      }
    }
  };
  
  /**
   * Create a new vertiport
   */
  const createNewVertiport = (position) => {
    // Generate ID
    const id = `vp-${vertiports.length + 1}`;
    
    // Create vertiport data
    const newVertiport = {
      id,
      name: `Vertiport ${vertiports.length + 1}`,
      position: {
        x: position.x,
        z: position.z
      }
    };
    
    // Add to vertiports array
    setVertiports([...vertiports, newVertiport]);
    
    // Create mesh
    createVertiportMesh(newVertiport);
    
    // Save state for undo
    addToUndoStack();
  };
  
  /**
   * Create a new waypoint
   */
  const createNewWaypoint = (position) => {
    // Generate ID
    const id = `wp-${waypoints.length + 1}`;
    
    // Create waypoint data
    const newWaypoint = {
      id,
      name: `Waypoint ${waypoints.length + 1}`,
      coordinates: [position.x, position.z],
      altitude: 100
    };
    
    // Add to waypoints array
    setWaypoints([...waypoints, newWaypoint]);
    
    // Create mesh
    createWaypointMesh(newWaypoint);
    
    // Save state for undo
    addToUndoStack();
  };
  
  /**
   * Create a new no-fly zone
   */
  const createNewNoFlyZone = (points) => {
    // Generate ID
    const id = `nfz-${noFlyZones.length + 1}`;
    
    // Create no-fly zone data
    const newNoFlyZone = {
      id,
      name: `No-Fly Zone ${noFlyZones.length + 1}`,
      coordinates: points,
      minAltitude: 0,
      maxAltitude: 200
    };
    
    // Add to no-fly zones array
    setNoFlyZones([...noFlyZones, newNoFlyZone]);
    
    // Create mesh
    createNoFlyZoneMesh(newNoFlyZone);
    
    // Save state for undo
    addToUndoStack();
  };
  
  /**
   * Create a new weather event
   */
  const createNewWeatherEvent = (position) => {
    // Open modal to configure weather event
    setModalContent(
      <div className="weather-event-modal">
        <h3>Create Weather Event</h3>
        
        <div className="form-group">
          <label>Weather Type</label>
          <select id="weatherType" className="form-control">
            <option value="WEATHER_THUNDERSTORM">Thunderstorm</option>
            <option value="WEATHER_RAIN">Rain</option>
            <option value="WEATHER_SNOW">Snow</option>
            <option value="WEATHER_WIND">Strong Wind</option>
            <option value="WEATHER_FOG">Fog</option>
          </select>
        </div>
        
        <div className="form-group">
          <label>Radius (meters)</label>
          <input type="number" id="weatherRadius" className="form-control" defaultValue="200" min="50" max="500" />
        </div>
        
        <div className="form-group">
          <label>Severity</label>
          <select id="weatherSeverity" className="form-control">
            <option value="HIGH">High</option>
            <option value="MEDIUM">Medium</option>
            <option value="LOW">Low</option>
          </select>
        </div>
        
        <div className="form-group">
          <label>Start Time (minutes into scenario)</label>
          <input type="number" id="weatherStartTime" className="form-control" defaultValue="10" min="0" />
        </div>
        
        <div className="form-group">
          <label>Duration (minutes)</label>
          <input type="number" id="weatherDuration" className="form-control" defaultValue="15" min="1" />
        </div>
        
        <div className="button-row">
          <button 
            className="btn btn-secondary" 
            onClick={() => setIsModalOpen(false)}
          >
            Cancel
          </button>
          <button 
            className="btn btn-primary" 
            onClick={() => {
              // Get values from form
              const weatherType = document.getElementById('weatherType').value;
              const radius = parseInt(document.getElementById('weatherRadius').value);
              const severity = document.getElementById('weatherSeverity').value;
              const startTime = parseInt(document.getElementById('weatherStartTime').value);
              const duration = parseInt(document.getElementById('weatherDuration').value);
              
              // Create weather event
              const id = `weather-${weatherEvents.length + 1}`;
              
              // Create weather event data
              const newWeatherEvent = {
                id,
                type: weatherType,
                time: startTime,
                data: {
                  alertType: weatherType.replace('WEATHER_', ''),
                  severity,
                  area: {
                    type: 'Point',
                    coordinates: [position.x, position.z]
                  },
                  radius,
                  startTime: `+${startTime}m`,
                  endTime: `+${startTime + duration}m`
                }
              };
              
              // Add to weather events array
              setWeatherEvents([...weatherEvents, newWeatherEvent]);
              
              // Create mesh
              createWeatherEventMesh(newWeatherEvent);
              
              // Save state for undo
              addToUndoStack();
              
              // Close modal
              setIsModalOpen(false);
            }}
          >
            Create Weather Event
          </button>
        </div>
      </div>
    );
    
    setIsModalOpen(true);
  };
  
  /**
   * Create a new emergency event
   */
  const createNewEmergencyEvent = (position) => {
    // Open modal to configure emergency event
    setModalContent(
      <div className="emergency-event-modal">
        <h3>Create Emergency Event</h3>
        
        <div className="form-group">
          <label>Emergency Type</label>
          <select id="emergencyType" className="form-control">
            <option value="VEHICLE_EMERGENCY">Vehicle Emergency</option>
            <option value="SYSTEM_FAILURE">System Failure</option>
            <option value="MULTIPLE_LOST_LINKS">Multiple Lost Links</option>
            <option value="VERTIPORT_EMERGENCY">Vertiport Emergency</option>
          </select>
        </div>
        
        <div className="form-group emergency-subtype-container">
          <label>Emergency Subtype</label>
          <select id="emergencySubtype" className="form-control">
            <option value="MECHANICAL_FAILURE">Mechanical Failure</option>
            <option value="BATTERY_CRITICAL">Battery Critical</option>
            <option value="LOST_LINK">Lost Link</option>
            <option value="NAVIGATION_ERROR">Navigation Error</option>
          </select>
        </div>
        
        <div className="form-group">
          <label>Severity (0.0 - 1.0)</label>
          <input type="number" id="emergencySeverity" className="form-control" defaultValue="0.8" min="0.1" max="1.0" step="0.1" />
        </div>
        
        <div className="form-group">
          <label>Time (minutes into scenario)</label>
          <input type="number" id="emergencyTime" className="form-control" defaultValue="15" min="0" />
        </div>
        
        <div className="button-row">
          <button 
            className="btn btn-secondary" 
            onClick={() => setIsModalOpen(false)}
          >
            Cancel
          </button>
          <button 
            className="btn btn-primary" 
            onClick={() => {
              // Get values from form
              const emergencyType = document.getElementById('emergencyType').value;
              const emergencySubtype = document.getElementById('emergencySubtype').value;
              const severity = parseFloat(document.getElementById('emergencySeverity').value);
              const time = parseInt(document.getElementById('emergencyTime').value);
              
              // Create emergency event
              const id = `emergency-${emergencyEvents.length + 1}`;
              
              // Create emergency event data
              const newEmergencyEvent = {
                id,
                type: emergencyType,
                time,
                data: {
                  emergencyType: emergencySubtype,
                  severity,
                  location: {
                    type: 'Point',
                    coordinates: [position.x, position.z]
                  }
                }
              };
              
              // Add to emergency events array
              setEmergencyEvents([...emergencyEvents, newEmergencyEvent]);
              
              // Create mesh
              createEmergencyEventMesh(newEmergencyEvent);
              
              // Save state for undo
              addToUndoStack();
              
              // Close modal
              setIsModalOpen(false);
            }}
          >
            Create Emergency Event
          </button>
        </div>
      </div>
    );
    
    setIsModalOpen(true);
  };
  
  /**
   * Delete selected object
   */
  const deleteSelectedObject = () => {
    if (!selectedObject || !sceneRef.current) return;
    
    const type = selectedObject.userData.type;
    const id = selectedObject.userData.id;
    
    // Remove from scene
    sceneRef.current.remove(selectedObject);
    
    // Remove from corresponding array
    switch (type) {
      case 'vertiport':
        setVertiports(vertiports.filter(v => v.id !== id));
        break;
      case 'waypoint':
        setWaypoints(waypoints.filter(w => w.id !== id));
        break;
      case 'noFlyZone':
        setNoFlyZones(noFlyZones.filter(z => z.id !== id));
        break;
      case 'weatherEvent':
        setWeatherEvents(weatherEvents.filter(e => e.id !== id));
        break;
      case 'emergencyEvent':
        setEmergencyEvents(emergencyEvents.filter(e => e.id !== id));
        break;
    }
    
    // Clear selection
    setSelectedObject(null);
    
    // Save state for undo
    addToUndoStack();
  };
  
  /**
   * Edit selected object
   */
  const editSelectedObject = () => {
    if (!selectedObject) return;
    
    const type = selectedObject.userData.type;
    const data = selectedObject.userData.data;
    
    // Create different edit forms based on type
    switch (type) {
      case 'vertiport':
        editVertiport(data);
        break;
      case 'waypoint':
        editWaypoint(data);
        break;
      case 'noFlyZone':
        editNoFlyZone(data);
        break;
      case 'weatherEvent':
        editWeatherEvent(data);
        break;
      case 'emergencyEvent':
        editEmergencyEvent(data);
        break;
    }
  };
  
  /**
   * Edit vertiport
   */
  const editVertiport = (vertiport) => {
    setModalContent(
      <div className="vertiport-edit-modal">
        <h3>Edit Vertiport</h3>
        
        <div className="form-group">
          <label>Name</label>
          <input 
            type="text" 
            id="vertiportName" 
            className="form-control" 
            defaultValue={vertiport.name}
          />
        </div>
        
        <div className="form-group">
          <label>Position X</label>
          <input 
            type="number" 
            id="vertiportX" 
            className="form-control" 
            defaultValue={vertiport.position.x}
          />
        </div>
        
        <div className="form-group">
          <label>Position Z</label>
          <input 
            type="number" 
            id="vertiportZ" 
            className="form-control" 
            defaultValue={vertiport.position.z}
          />
        </div>
        
        <div className="button-row">
          <button 
            className="btn btn-secondary" 
            onClick={() => setIsModalOpen(false)}
          >
            Cancel
          </button>
          <button 
            className="btn btn-primary" 
            onClick={() => {
              // Get values from form
              const name = document.getElementById('vertiportName').value;
              const x = parseFloat(document.getElementById('vertiportX').value);
              const z = parseFloat(document.getElementById('vertiportZ').value);
              
              // Update vertiport data
              const updatedVertiport = {
                ...vertiport,
                name,
                position: {
                  x,
                  z
                }
              };
              
              // Update vertiports array
              setVertiports(vertiports.map(v => 
                v.id === vertiport.id ? updatedVertiport : v
              ));
              
              // Update selected object
              if (selectedObject) {
                selectedObject.userData.data = updatedVertiport;
                selectedObject.position.set(x, 0, z);
                
                // Update label if it exists
                const textMesh = selectedObject.children.find(
                  child => child.type === 'Mesh' && child.geometry.type === 'TextGeometry'
                );
                
                if (textMesh && fontRef.current) {
                  // Remove old text mesh
                  selectedObject.remove(textMesh);
                  
                  // Create new text mesh
                  const textGeometry = new TextGeometry(name, {
                    font: fontRef.current,
                    size: 10,
                    height: 1
                  });
                  
                  const textMaterial = new THREE.MeshBasicMaterial({ color: 0x000000 });
                  const newTextMesh = new THREE.Mesh(textGeometry, textMaterial);
                  
                  // Center text
                  textGeometry.computeBoundingBox();
                  const textWidth = textGeometry.boundingBox.max.x - textGeometry.boundingBox.min.x;
                  newTextMesh.position.set(-textWidth / 2, 15, 0);
                  
                  selectedObject.add(newTextMesh);
                }
              }
              
              // Save state for undo
              addToUndoStack();
              
              // Close modal
              setIsModalOpen(false);
            }}
          >
            Save Changes
          </button>
        </div>
      </div>
    );
    
    setIsModalOpen(true);
  };
  
  /**
   * Edit waypoint
   */
  const editWaypoint = (waypoint) => {
    setModalContent(
      <div className="waypoint-edit-modal">
        <h3>Edit Waypoint</h3>
        
        <div className="form-group">
          <label>Name</label>
          <input 
            type="text" 
            id="waypointName" 
            className="form-control" 
            defaultValue={waypoint.name}
          />
        </div>
        
        <div className="form-group">
          <label>Position X</label>
          <input 
            type="number" 
            id="waypointX" 
            className="form-control" 
            defaultValue={waypoint.coordinates[0]}
          />
        </div>
        
        <div className="form-group">
          <label>Position Z</label>
          <input 
            type="number" 
            id="waypointZ" 
            className="form-control" 
            defaultValue={waypoint.coordinates[1]}
          />
        </div>
        
        <div className="form-group">
          <label>Altitude (meters)</label>
          <input 
            type="number" 
            id="waypointAltitude" 
            className="form-control" 
            defaultValue={waypoint.altitude || 100}
            min="0"
            max="500"
          />
        </div>
        
        <div className="button-row">
          <button 
            className="btn btn-secondary" 
            onClick={() => setIsModalOpen(false)}
          >
            Cancel
          </button>
          <button 
            className="btn btn-primary" 
            onClick={() => {
              // Get values from form
              const name = document.getElementById('waypointName').value;
              const x = parseFloat(document.getElementById('waypointX').value);
              const z = parseFloat(document.getElementById('waypointZ').value);
              const altitude = parseFloat(document.getElementById('waypointAltitude').value);
              
              // Update waypoint data
              const updatedWaypoint = {
                ...waypoint,
                name,
                coordinates: [x, z],
                altitude
              };
              
              // Update waypoints array
              setWaypoints(waypoints.map(w => 
                w.id === waypoint.id ? updatedWaypoint : w
              ));
              
              // Update selected object
              if (selectedObject && sceneRef.current) {
                // Remove old waypoint
                sceneRef.current.remove(selectedObject);
                
                // Create new waypoint with updated data
                createWaypointMesh(updatedWaypoint);
                
                // Clear selection
                setSelectedObject(null);
              }
              
              // Save state for undo
              addToUndoStack();
              
              // Close modal
              setIsModalOpen(false);
            }}
          >
            Save Changes
          </button>
        </div>
      </div>
    );
    
    setIsModalOpen(true);
  };
  
  /**
   * Edit no-fly zone
   */
  const editNoFlyZone = (zone) => {
    setModalContent(
      <div className="no-fly-zone-edit-modal">
        <h3>Edit No-Fly Zone</h3>
        
        <div className="form-group">
          <label>Name</label>
          <input 
            type="text" 
            id="zoneName" 
            className="form-control" 
            defaultValue={zone.name}
          />
        </div>
        
        <div className="form-group">
          <label>Minimum Altitude (meters)</label>
          <input 
            type="number" 
            id="zoneMinAltitude" 
            className="form-control" 
            defaultValue={zone.minAltitude || 0}
            min="0"
            max={zone.maxAltitude || 200}
          />
        </div>
        
        <div className="form-group">
          <label>Maximum Altitude (meters)</label>
          <input 
            type="number" 
            id="zoneMaxAltitude" 
            className="form-control" 
            defaultValue={zone.maxAltitude || 200}
            min={zone.minAltitude || 0}
          />
        </div>
        
        <p className="note">Note: To edit the shape, delete this zone and draw a new one.</p>
        
        <div className="button-row">
          <button 
            className="btn btn-secondary" 
            onClick={() => setIsModalOpen(false)}
          >
            Cancel
          </button>
          <button 
            className="btn btn-primary" 
            onClick={() => {
              // Get values from form
              const name = document.getElementById('zoneName').value;
              const minAltitude = parseFloat(document.getElementById('zoneMinAltitude').value);
              const maxAltitude = parseFloat(document.getElementById('zoneMaxAltitude').value);
              
              // Update zone data
              const updatedZone = {
                ...zone,
                name,
                minAltitude,
                maxAltitude
              };
              
              // Update no-fly zones array
              setNoFlyZones(noFlyZones.map(z => 
                z.id === zone.id ? updatedZone : z
              ));
              
              // Update selected object
              if (selectedObject && sceneRef.current) {
                // Remove old zone
                sceneRef.current.remove(selectedObject);
                
                // Create new zone with updated data
                createNoFlyZoneMesh(updatedZone);
                
                // Clear selection
                setSelectedObject(null);
              }
              
              // Save state for undo
              addToUndoStack();
              
              // Close modal
              setIsModalOpen(false);
            }}
          >
            Save Changes
          </button>
        </div>
      </div>
    );
    
    setIsModalOpen(true);
  };
  
  /**
   * Edit weather event
   */
  const editWeatherEvent = (event) => {
    setModalContent(
      <div className="weather-event-edit-modal">
        <h3>Edit Weather Event</h3>
        
        <div className="form-group">
          <label>Weather Type</label>
          <select 
            id="weatherType" 
            className="form-control" 
            defaultValue={event.type}
          >
            <option value="WEATHER_THUNDERSTORM">Thunderstorm</option>
            <option value="WEATHER_RAIN">Rain</option>
            <option value="WEATHER_SNOW">Snow</option>
            <option value="WEATHER_WIND">Strong Wind</option>
            <option value="WEATHER_FOG">Fog</option>
          </select>
        </div>
        
        <div className="form-group">
          <label>Radius (meters)</label>
          <input 
            type="number" 
            id="weatherRadius" 
            className="form-control" 
            defaultValue={event.data?.radius || 200}
            min="50"
            max="500"
          />
        </div>
        
        <div className="form-group">
          <label>Severity</label>
          <select 
            id="weatherSeverity" 
            className="form-control" 
            defaultValue={event.data?.severity || 'HIGH'}
          >
            <option value="HIGH">High</option>
            <option value="MEDIUM">Medium</option>
            <option value="LOW">Low</option>
          </select>
        </div>
        
        <div className="form-group">
          <label>Start Time (minutes into scenario)</label>
          <input 
            type="number" 
            id="weatherStartTime" 
            className="form-control" 
            defaultValue={event.time || 10}
            min="0"
          />
        </div>
        
        <div className="form-group">
          <label>Duration (minutes)</label>
          <input 
            type="number" 
            id="weatherDuration" 
            className="form-control" 
            defaultValue={15}
            min="1"
          />
        </div>
        
        <div className="form-group">
          <label>Position X</label>
          <input 
            type="number" 
            id="weatherX" 
            className="form-control" 
            defaultValue={event.data?.area?.coordinates?.[0] || 0}
          />
        </div>
        
        <div className="form-group">
          <label>Position Z</label>
          <input 
            type="number" 
            id="weatherZ" 
            className="form-control" 
            defaultValue={event.data?.area?.coordinates?.[1] || 0}
          />
        </div>
        
        <div className="button-row">
          <button 
            className="btn btn-secondary" 
            onClick={() => setIsModalOpen(false)}
          >
            Cancel
          </button>
          <button 
            className="btn btn-primary" 
            onClick={() => {
              // Get values from form
              const type = document.getElementById('weatherType').value;
              const radius = parseInt(document.getElementById('weatherRadius').value);
              const severity = document.getElementById('weatherSeverity').value;
              const time = parseInt(document.getElementById('weatherStartTime').value);
              const duration = parseInt(document.getElementById('weatherDuration').value);
              const x = parseFloat(document.getElementById('weatherX').value);
              const z = parseFloat(document.getElementById('weatherZ').value);
              
              // Update weather event data
              const updatedEvent = {
                ...event,
                type,
                time,
                data: {
                  ...event.data,
                  alertType: type.replace('WEATHER_', ''),
                  severity,
                  radius,
                  area: {
                    type: 'Point',
                    coordinates: [x, z]
                  },
                  startTime: `+${time}m`,
                  endTime: `+${time + duration}m`
                }
              };
              
              // Update weather events array
              setWeatherEvents(weatherEvents.map(e => 
                e.id === event.id ? updatedEvent : e
              ));
              
              // Update selected object
              if (selectedObject && sceneRef.current) {
                // Remove old event
                sceneRef.current.remove(selectedObject);
                
                // Create new event with updated data
                createWeatherEventMesh(updatedEvent);
                
                // Clear selection
                setSelectedObject(null);
              }
              
              // Save state for undo
              addToUndoStack();
              
              // Close modal
              setIsModalOpen(false);
            }}
          >
            Save Changes
          </button>
        </div>
      </div>
    );
    
    setIsModalOpen(true);
  };
  
  /**
   * Edit emergency event
   */
  const editEmergencyEvent = (event) => {
    setModalContent(
      <div className="emergency-event-edit-modal">
        <h3>Edit Emergency Event</h3>
        
        <div className="form-group">
          <label>Emergency Type</label>
          <select 
            id="emergencyType" 
            className="form-control" 
            defaultValue={event.type}
          >
            <option value="VEHICLE_EMERGENCY">Vehicle Emergency</option>
            <option value="SYSTEM_FAILURE">System Failure</option>
            <option value="MULTIPLE_LOST_LINKS">Multiple Lost Links</option>
            <option value="VERTIPORT_EMERGENCY">Vertiport Emergency</option>
          </select>
        </div>
        
        <div className="form-group emergency-subtype-container">
          <label>Emergency Subtype</label>
          <select 
            id="emergencySubtype" 
            className="form-control" 
            defaultValue={event.data?.emergencyType || 'MECHANICAL_FAILURE'}
          >
            <option value="MECHANICAL_FAILURE">Mechanical Failure</option>
            <option value="BATTERY_CRITICAL">Battery Critical</option>
            <option value="LOST_LINK">Lost Link</option>
            <option value="NAVIGATION_ERROR">Navigation Error</option>
          </select>
        </div>
        
        <div className="form-group">
          <label>Severity (0.0 - 1.0)</label>
          <input 
            type="number" 
            id="emergencySeverity" 
            className="form-control" 
            defaultValue={event.data?.severity || 0.8}
            min="0.1"
            max="1.0"
            step="0.1"
          />
        </div>
        
        <div className="form-group">
          <label>Time (minutes into scenario)</label>
          <input 
            type="number" 
            id="emergencyTime" 
            className="form-control" 
            defaultValue={event.time || 15}
            min="0"
          />
        </div>
        
        <div className="form-group">
          <label>Position X</label>
          <input 
            type="number" 
            id="emergencyX" 
            className="form-control" 
            defaultValue={event.data?.location?.coordinates?.[0] || 0}
          />
        </div>
        
        <div className="form-group">
          <label>Position Z</label>
          <input 
            type="number" 
            id="emergencyZ" 
            className="form-control" 
            defaultValue={event.data?.location?.coordinates?.[1] || 0}
          />
        </div>
        
        <div className="button-row">
          <button 
            className="btn btn-secondary" 
            onClick={() => setIsModalOpen(false)}
          >
            Cancel
          </button>
          <button 
            className="btn btn-primary" 
            onClick={() => {
              // Get values from form
              const type = document.getElementById('emergencyType').value;
              const subtype = document.getElementById('emergencySubtype').value;
              const severity = parseFloat(document.getElementById('emergencySeverity').value);
              const time = parseInt(document.getElementById('emergencyTime').value);
              const x = parseFloat(document.getElementById('emergencyX').value);
              const z = parseFloat(document.getElementById('emergencyZ').value);
              
              // Update emergency event data
              const updatedEvent = {
                ...event,
                type,
                time,
                data: {
                  ...event.data,
                  emergencyType: subtype,
                  severity,
                  location: {
                    type: 'Point',
                    coordinates: [x, z]
                  }
                }
              };
              
              // Update emergency events array
              setEmergencyEvents(emergencyEvents.map(e => 
                e.id === event.id ? updatedEvent : e
              ));
              
              // Update selected object
              if (selectedObject && sceneRef.current) {
                // Remove old event
                sceneRef.current.remove(selectedObject);
                
                // Create new event with updated data
                createEmergencyEventMesh(updatedEvent);
                
                // Clear selection
                setSelectedObject(null);
              }
              
              // Save state for undo
              addToUndoStack();
              
              // Close modal
              setIsModalOpen(false);
            }}
          >
            Save Changes
          </button>
        </div>
      </div>
    );
    
    setIsModalOpen(true);
  };
  
  /**
   * Add current state to undo stack
   */
  const addToUndoStack = () => {
    const currentState = {
      vertiports: [...vertiports],
      waypoints: [...waypoints],
      noFlyZones: [...noFlyZones],
      weatherEvents: [...weatherEvents],
      emergencyEvents: [...emergencyEvents]
    };
    
    setUndoStack([...undoStack, currentState]);
    
    // Clear redo stack when a new action is performed
    setRedoStack([]);
  };
  
  /**
   * Undo last action
   */
  const handleUndo = () => {
    if (undoStack.length === 0) return;
    
    // Get the last state from undo stack
    const lastState = undoStack[undoStack.length - 1];
    
    // Add current state to redo stack
    const currentState = {
      vertiports: [...vertiports],
      waypoints: [...waypoints],
      noFlyZones: [...noFlyZones],
      weatherEvents: [...weatherEvents],
      emergencyEvents: [...emergencyEvents]
    };
    
    setRedoStack([...redoStack, currentState]);
    
    // Remove last state from undo stack
    setUndoStack(undoStack.slice(0, -1));
    
    // Restore last state
    setVertiports(lastState.vertiports);
    setWaypoints(lastState.waypoints);
    setNoFlyZones(lastState.noFlyZones);
    setWeatherEvents(lastState.weatherEvents);
    setEmergencyEvents(lastState.emergencyEvents);
    
    // Clear selection
    setSelectedObject(null);
    
    // Recreate all meshes
    if (sceneRef.current) {
      // Remove all meshes except for grid and axes
      const objectsToRemove = [];
      
      sceneRef.current.traverse(object => {
        if (object.userData && object.userData.type) {
          objectsToRemove.push(object);
        }
      });
      
      objectsToRemove.forEach(object => {
        sceneRef.current.remove(object);
      });
      
      // Recreate all meshes
      lastState.vertiports.forEach(vertiport => {
        createVertiportMesh(vertiport);
      });
      
      lastState.waypoints.forEach(waypoint => {
        createWaypointMesh(waypoint);
      });
      
      lastState.noFlyZones.forEach(zone => {
        createNoFlyZoneMesh(zone);
      });
      
      lastState.weatherEvents.forEach(event => {
        createWeatherEventMesh(event);
      });
      
      lastState.emergencyEvents.forEach(event => {
        createEmergencyEventMesh(event);
      });
    }
  };
  
  /**
   * Redo last undone action
   */
  const handleRedo = () => {
    if (redoStack.length === 0) return;
    
    // Get the last state from redo stack
    const lastState = redoStack[redoStack.length - 1];
    
    // Add current state to undo stack
    const currentState = {
      vertiports: [...vertiports],
      waypoints: [...waypoints],
      noFlyZones: [...noFlyZones],
      weatherEvents: [...weatherEvents],
      emergencyEvents: [...emergencyEvents]
    };
    
    setUndoStack([...undoStack, currentState]);
    
    // Remove last state from redo stack
    setRedoStack(redoStack.slice(0, -1));
    
    // Restore last state
    setVertiports(lastState.vertiports);
    setWaypoints(lastState.waypoints);
    setNoFlyZones(lastState.noFlyZones);
    setWeatherEvents(lastState.weatherEvents);
    setEmergencyEvents(lastState.emergencyEvents);
    
    // Clear selection
    setSelectedObject(null);
    
    // Recreate all meshes
    if (sceneRef.current) {
      // Remove all meshes except for grid and axes
      const objectsToRemove = [];
      
      sceneRef.current.traverse(object => {
        if (object.userData && object.userData.type) {
          objectsToRemove.push(object);
        }
      });
      
      objectsToRemove.forEach(object => {
        sceneRef.current.remove(object);
      });
      
      // Recreate all meshes
      lastState.vertiports.forEach(vertiport => {
        createVertiportMesh(vertiport);
      });
      
      lastState.waypoints.forEach(waypoint => {
        createWaypointMesh(waypoint);
      });
      
      lastState.noFlyZones.forEach(zone => {
        createNoFlyZoneMesh(zone);
      });
      
      lastState.weatherEvents.forEach(event => {
        createWeatherEventMesh(event);
      });
      
      lastState.emergencyEvents.forEach(event => {
        createEmergencyEventMesh(event);
      });
    }
  };
  
  /**
   * Save scenario
   */
  const handleSaveScenario = () => {
    // Open save dialog
    setModalContent(
      <div className="save-scenario-modal">
        <h3>Save Training Scenario</h3>
        
        <div className="form-group">
          <label>Scenario Name</label>
          <input 
            type="text" 
            id="scenarioName" 
            className="form-control" 
            value={scenarioName}
            onChange={(e) => setScenarioName(e.target.value)}
          />
        </div>
        
        <div className="form-group">
          <label>Description</label>
          <textarea 
            id="scenarioDescription" 
            className="form-control" 
            value={scenarioDescription}
            onChange={(e) => setScenarioDescription(e.target.value)}
            rows="3"
          />
        </div>
        
        <div className="form-group">
          <label>Difficulty</label>
          <select 
            id="scenarioDifficulty" 
            className="form-control"
            value={difficulty}
            onChange={(e) => setDifficulty(e.target.value)}
          >
            <option value="easy">Easy</option>
            <option value="medium">Medium</option>
            <option value="hard">Hard</option>
            <option value="expert">Expert</option>
          </select>
        </div>
        
        <div className="form-group">
          <label>Duration (minutes)</label>
          <input 
            type="number" 
            id="scenarioDuration" 
            className="form-control" 
            value={duration}
            onChange={(e) => setDuration(parseInt(e.target.value))}
            min="15"
            max="120"
          />
        </div>
        
        <div className="form-group">
          <label>Environment Type</label>
          <select 
            id="environmentType" 
            className="form-control"
            value={environmentType}
            onChange={(e) => setEnvironmentType(e.target.value)}
          >
            <option value="urban">Urban</option>
            <option value="rural">Rural</option>
            <option value="mixed">Mixed</option>
          </select>
        </div>
        
        <div className="button-row">
          <button 
            className="btn btn-secondary" 
            onClick={() => setIsModalOpen(false)}
          >
            Cancel
          </button>
          <button 
            className="btn btn-primary" 
            onClick={() => {
              // Create scenario object
              const scenario = {
                name: scenarioName,
                description: scenarioDescription,
                difficulty,
                duration,
                environment: {
                  type: environmentType,
                  vertiports
                },
                waypoints,
                noFlyZones,
                events: [
                  ...weatherEvents,
                  ...emergencyEvents
                ],
                id: editingScenario?.id || `scenario-${Date.now()}`
              };
              
              // Call save callback
              onScenarioSave(scenario);
              
              // Close modal
              setIsModalOpen(false);
            }}
          >
            Save Scenario
          </button>
        </div>
      </div>
    );
    
    setIsModalOpen(true);
  };
  
  /**
   * Get object type icon
   */
  const getObjectTypeIcon = (type) => {
    switch (type) {
      case 'vertiport':
        return '🅟';
      case 'waypoint':
        return '📍';
      case 'noFlyZone':
        return '🚫';
      case 'weatherEvent':
        return '⛈️';
      case 'emergencyEvent':
        return '🚨';
      default:
        return '❓';
    }
  };
  
  return (
    <div className="mission-planner">
      {/* Toolbar */}
      <div className="toolbar">
        <div className="tool-group">
          <button 
            className={`tool-button ${activeMode === 'select' ? 'active' : ''}`}
            onClick={() => setActiveMode('select')}
            title="Select Mode"
          >
            <i className="fa fa-mouse-pointer"></i>
          </button>
          <button 
            className={`tool-button ${activeMode === 'draw' ? 'active' : ''}`}
            onClick={() => setActiveMode('draw')}
            title="Draw No-Fly Zone"
          >
            <i className="fa fa-draw-polygon"></i>
          </button>
        </div>
        
        <div className="tool-group">
          <button 
            className={`tool-button ${activeMode === 'placeVertiport' ? 'active' : ''}`}
            onClick={() => setActiveMode('placeVertiport')}
            title="Place Vertiport"
          >
            <i className="fa fa-heliport"></i> P
          </button>
          <button 
            className={`tool-button ${activeMode === 'placeWaypoint' ? 'active' : ''}`}
            onClick={() => setActiveMode('placeWaypoint')}
            title="Place Waypoint"
          >
            <i className="fa fa-map-marker"></i>
          </button>
          <button 
            className={`tool-button ${activeMode === 'placeWeather' ? 'active' : ''}`}
            onClick={() => setActiveMode('placeWeather')}
            title="Place Weather Event"
          >
            <i className="fa fa-cloud-bolt"></i>
          </button>
          <button 
            className={`tool-button ${activeMode === 'placeEmergency' ? 'active' : ''}`}
            onClick={() => setActiveMode('placeEmergency')}
            title="Place Emergency Event"
          >
            <i className="fa fa-triangle-exclamation"></i>
          </button>
        </div>
        
        <div className="tool-group">
          <button 
            className="tool-button"
            onClick={handleUndo}
            disabled={undoStack.length === 0}
            title="Undo"
          >
            <i className="fa fa-undo"></i>
          </button>
          <button 
            className="tool-button"
            onClick={handleRedo}
            disabled={redoStack.length === 0}
            title="Redo"
          >
            <i className="fa fa-redo"></i>
          </button>
        </div>
        
        <div className="spacer"></div>
        
        <div className="tool-group">
          <button 
            className="tool-button help-button"
            onClick={() => setShowHelp(!showHelp)}
            title="Help"
          >
            <i className="fa fa-question-circle"></i>
          </button>
          <button 
            className="tool-button save-button"
            onClick={handleSaveScenario}
            title="Save Scenario"
          >
            <i className="fa fa-save"></i> Save
          </button>
        </div>
      </div>
      
      {/* 3D View Container */}
      <div ref={containerRef} className="scene-container"></div>
      
      {/* Property Panel */}
      <div className="property-panel">
        <div className="panel-header">
          <h3>Scenario Elements</h3>
        </div>
        
        <div className="panel-content">
          {selectedObject ? (
            <div className="object-properties">
              <div className="property-header">
                <span className="object-icon">{getObjectTypeIcon(selectedObject.userData.type)}</span>
                <h4>{selectedObject.userData.data.name || selectedObject.userData.type}</h4>
              </div>
              
              <div className="property-buttons">
                <button 
                  className="property-button edit-button"
                  onClick={editSelectedObject}
                >
                  <i className="fa fa-edit"></i> Edit
                </button>
                <button 
                  className="property-button delete-button"
                  onClick={deleteSelectedObject}
                >
                  <i className="fa fa-trash"></i> Delete
                </button>
              </div>
              
              <div className="property-list">
                {selectedObject.userData.type === 'vertiport' && (
                  <>
                    <div className="property-item">
                      <span className="property-label">Position:</span>
                      <span className="property-value">
                        X: {selectedObject.userData.data.position.x.toFixed(1)}, 
                        Z: {selectedObject.userData.data.position.z.toFixed(1)}
                      </span>
                    </div>
                  </>
                )}
                
                {selectedObject.userData.type === 'waypoint' && (
                  <>
                    <div className="property-item">
                      <span className="property-label">Position:</span>
                      <span className="property-value">
                        X: {selectedObject.userData.data.coordinates[0].toFixed(1)}, 
                        Z: {selectedObject.userData.data.coordinates[1].toFixed(1)}
                      </span>
                    </div>
                    <div className="property-item">
                      <span className="property-label">Altitude:</span>
                      <span className="property-value">
                        {selectedObject.userData.data.altitude || 100} m
                      </span>
                    </div>
                  </>
                )}
                
                {selectedObject.userData.type === 'noFlyZone' && (
                  <>
                    <div className="property-item">
                      <span className="property-label">Altitude Range:</span>
                      <span className="property-value">
                        {selectedObject.userData.data.minAltitude || 0} - 
                        {selectedObject.userData.data.maxAltitude || 200} m
                      </span>
                    </div>
                    <div className="property-item">
                      <span className="property-label">Vertices:</span>
                      <span className="property-value">
                        {selectedObject.userData.data.coordinates?.length || 0}
                      </span>
                    </div>
                  </>
                )}
                
                {selectedObject.userData.type === 'weatherEvent' && (
                  <>
                    <div className="property-item">
                      <span className="property-label">Type:</span>
                      <span className="property-value">
                        {selectedObject.userData.data.type?.replace('WEATHER_', '') || 'Unknown'}
                      </span>
                    </div>
                    <div className="property-item">
                      <span className="property-label">Severity:</span>
                      <span className="property-value">
                        {selectedObject.userData.data.data?.severity || 'HIGH'}
                      </span>
                    </div>
                    <div className="property-item">
                      <span className="property-label">Radius:</span>
                      <span className="property-value">
                        {selectedObject.userData.data.data?.radius || 200} m
                      </span>
                    </div>
                    <div className="property-item">
                      <span className="property-label">Time:</span>
                      <span className="property-value">
                        {selectedObject.userData.data.time || 0} min
                      </span>
                    </div>
                  </>
                )}
                
                {selectedObject.userData.type === 'emergencyEvent' && (
                  <>
                    <div className="property-item">
                      <span className="property-label">Type:</span>
                      <span className="property-value">
                        {selectedObject.userData.data.data?.emergencyType || 'Unknown'}
                      </span>
                    </div>
                    <div className="property-item">
                      <span className="property-label">Severity:</span>
                      <span className="property-value">
                        {selectedObject.userData.data.data?.severity?.toFixed(1) || '0.8'}
                      </span>
                    </div>
                    <div className="property-item">
                      <span className="property-label">Time:</span>
                      <span className="property-value">
                        {selectedObject.userData.data.time || 0} min
                      </span>
                    </div>
                  </>
                )}
              </div>
            </div>
          ) : (
            <div className="element-lists">
              <div className="element-list">
                <h5>Vertiports ({vertiports.length})</h5>
                <ul>
                  {vertiports.map(vertiport => (
                    <li key={vertiport.id} onClick={() => {
                      // Find and select the corresponding object
                      if (sceneRef.current) {
                        const object = sceneRef.current.children.find(
                          obj => obj.userData && obj.userData.type === 'vertiport' && obj.userData.id === vertiport.id
                        );
                        
                        if (object) {
                          setSelectedObject(object);
                        }
                      }
                    }}>
                      {vertiport.name}
                    </li>
                  ))}
                </ul>
              </div>
              
              <div className="element-list">
                <h5>Waypoints ({waypoints.length})</h5>
                <ul>
                  {waypoints.map(waypoint => (
                    <li key={waypoint.id} onClick={() => {
                      // Find and select the corresponding object
                      if (sceneRef.current) {
                        const object = sceneRef.current.children.find(
                          obj => obj.userData && obj.userData.type === 'waypoint' && obj.userData.id === waypoint.id
                        );
                        
                        if (object) {
                          setSelectedObject(object);
                        }
                      }
                    }}>
                      {waypoint.name}
                    </li>
                  ))}
                </ul>
              </div>
              
              <div className="element-list">
                <h5>No-Fly Zones ({noFlyZones.length})</h5>
                <ul>
                  {noFlyZones.map(zone => (
                    <li key={zone.id} onClick={() => {
                      // Find and select the corresponding object
                      if (sceneRef.current) {
                        const object = sceneRef.current.children.find(
                          obj => obj.userData && obj.userData.type === 'noFlyZone' && obj.userData.id === zone.id
                        );
                        
                        if (object) {
                          setSelectedObject(object);
                        }
                      }
                    }}>
                      {zone.name}
                    </li>
                  ))}
                </ul>
              </div>
              
              <div className="element-list">
                <h5>Events ({weatherEvents.length + emergencyEvents.length})</h5>
                <ul>
                  {[...weatherEvents, ...emergencyEvents]
                    .sort((a, b) => (a.time || 0) - (b.time || 0))
                    .map(event => (
                      <li key={event.id} onClick={() => {
                        // Find and select the corresponding object
                        if (sceneRef.current) {
                          const object = sceneRef.current.children.find(
                            obj => obj.userData && 
                                 (obj.userData.type === 'weatherEvent' || obj.userData.type === 'emergencyEvent') && 
                                 obj.userData.id === event.id
                          );
                          
                          if (object) {
                            setSelectedObject(object);
                          }
                        }
                      }}>
                        {event.time || 0}min: {event.type.replace('WEATHER_', '')}
                      </li>
                    ))}
                </ul>
              </div>
            </div>
          )}
        </div>
      </div>
      
      {/* Context Menu */}
      <div ref={menuRef} className="context-menu" style={{ display: 'none' }}>
        <ul>
          <li onClick={() => {
            editSelectedObject();
            menuRef.current.style.display = 'none';
          }}>
            <i className="fa fa-edit"></i> Edit
          </li>
          <li onClick={() => {
            deleteSelectedObject();
            menuRef.current.style.display = 'none';
          }}>
            <i className="fa fa-trash"></i> Delete
          </li>
          <li onClick={() => {
            menuRef.current.style.display = 'none';
          }}>
            <i className="fa fa-times"></i> Cancel
          </li>
        </ul>
      </div>
      
      {/* Help Panel */}
      {showHelp && (
        <div className="help-panel">
          <div className="help-header">
            <h3>Mission Planner Help</h3>
            <button className="close-button" onClick={() => setShowHelp(false)}>×</button>
          </div>
          
          <div className="help-content">
            <h4>Basic Controls</h4>
            <ul>
              <li><strong>Rotate view:</strong> Left-click + drag</li>
              <li><strong>Pan view:</strong> Right-click + drag</li>
              <li><strong>Zoom:</strong> Scroll wheel</li>
            </ul>
            
            <h4>Tools</h4>
            <ul>
              <li><strong>Select:</strong> Click on objects to select them</li>
              <li><strong>Draw No-Fly Zone:</strong> Click and drag to define polygon vertices</li>
              <li><strong>Place Vertiport/Waypoint/Weather/Emergency:</strong> Click to place at cursor location</li>
            </ul>
            
            <h4>Editing</h4>
            <ul>
              <li><strong>Edit object:</strong> Select an object and click Edit, or right-click and select Edit</li>
              <li><strong>Delete object:</strong> Select an object and press Delete, or right-click and select Delete</li>
              <li><strong>Undo/Redo:</strong> Use the toolbar buttons to undo or redo actions</li>
            </ul>
            
            <h4>Keyboard Shortcuts</h4>
            <ul>
              <li><strong>Delete:</strong> Delete selected object</li>
              <li><strong>Ctrl+Z:</strong> Undo</li>
              <li><strong>Ctrl+Y:</strong> Redo</li>
              <li><strong>Esc:</strong> Cancel current operation</li>
            </ul>
          </div>
        </div>
      )}
      
      {/* Modal Dialog */}
      {isModalOpen && (
        <div className="modal-overlay">
          <div className="modal-container">
            <div className="modal-content">
              {modalContent}
            </div>
          </div>
        </div>
      )}
      
      <style jsx>{`
        .mission-planner {
          position: relative;
          width: 100%;
          height: 100%;
          display: flex;
          flex-direction: column;
          overflow: hidden;
          font-family: Arial, sans-serif;
        }
        
        .toolbar {
          display: flex;
          background-color: #2c3e50;
          padding: 10px;
          z-index: 10;
        }
        
        .tool-group {
          display: flex;
          margin-right: 20px;
        }
        
        .tool-button {
          width: 40px;
          height: 40px;
          border: none;
          background-color: #34495e;
          color: white;
          margin-right: 5px;
          border-radius: 4px;
          cursor: pointer;
          display: flex;
          justify-content: center;
          align-items: center;
          font-size: 16px;
        }
        
        .tool-button:hover {
          background-color: #3d5a76;
        }
        
        .tool-button.active {
          background-color: #2980b9;
        }
        
        .tool-button:disabled {
          opacity: 0.5;
          cursor: not-allowed;
        }
        
        .help-button {
          background-color: #8e44ad;
        }
        
        .save-button {
          background-color: #27ae60;
          width: auto;
          padding: 0 15px;
        }
        
        .spacer {
          flex: 1;
        }
        
        .scene-container {
          flex: 1;
          position: relative;
          overflow: hidden;
        }
        
        .property-panel {
          position: absolute;
          top: 60px;
          right: 10px;
          width: 300px;
          background-color: rgba(255, 255, 255, 0.9);
          border-radius: 5px;
          box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
          z-index: 5;
        }
        
        .panel-header {
          background-color: #2c3e50;
          color: white;
          padding: 10px;
          border-top-left-radius: 5px;
          border-top-right-radius: 5px;
        }
        
        .panel-header h3 {
          margin: 0;
          font-size: 16px;
        }
        
        .panel-content {
          padding: 10px;
          max-height: 600px;
          overflow-y: auto;
        }
        
        .object-properties {
          display: flex;
          flex-direction: column;
        }
        
        .property-header {
          display: flex;
          align-items: center;
          margin-bottom: 10px;
        }
        
        .object-icon {
          font-size: 24px;
          margin-right: 10px;
        }
        
        .property-header h4 {
          margin: 0;
          font-size: 16px;
        }
        
        .property-buttons {
          display: flex;
          margin-bottom: 15px;
        }
        
        .property-button {
          flex: 1;
          padding: 8px;
          border: none;
          border-radius: 4px;
          cursor: pointer;
          display: flex;
          justify-content: center;
          align-items: center;
          font-size: 14px;
          margin-right: 5px;
        }
        
        .edit-button {
          background-color: #3498db;
          color: white;
        }
        
        .delete-button {
          background-color: #e74c3c;
          color: white;
        }
        
        .property-list {
          display: flex;
          flex-direction: column;
        }
        
        .property-item {
          display: flex;
          margin-bottom: 5px;
        }
        
        .property-label {
          font-weight: bold;
          width: 100px;
        }
        
        .element-lists {
          display: flex;
          flex-direction: column;
        }
        
        .element-list {
          margin-bottom: 15px;
        }
        
        .element-list h5 {
          margin: 0 0 5px 0;
          font-size: 14px;
          border-bottom: 1px solid #ddd;
          padding-bottom: 5px;
        }
        
        .element-list ul {
          list-style: none;
          padding: 0;
          margin: 0;
          max-height: 120px;
          overflow-y: auto;
        }
        
        .element-list li {
          padding: 5px;
          cursor: pointer;
          border-radius: 3px;
        }
        
        .element-list li:hover {
          background-color: #f0f0f0;
        }
        
        .context-menu {
          position: absolute;
          background-color: white;
          border-radius: 4px;
          box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
          z-index: 100;
        }
        
        .context-menu ul {
          list-style: none;
          padding: 0;
          margin: 0;
        }
        
        .context-menu li {
          padding: 8px 15px;
          cursor: pointer;
        }
        
        .context-menu li:hover {
          background-color: #f0f0f0;
        }
        
        .help-panel {
          position: absolute;
          top: 50%;
          left: 50%;
          transform: translate(-50%, -50%);
          width: 500px;
          background-color: white;
          border-radius: 5px;
          box-shadow: 0 2px 20px rgba(0, 0, 0, 0.3);
          z-index: 20;
        }
        
        .help-header {
          display: flex;
          justify-content: space-between;
          align-items: center;
          background-color: #2c3e50;
          color: white;
          padding: 10px 15px;
          border-top-left-radius: 5px;
          border-top-right-radius: 5px;
        }
        
        .help-header h3 {
          margin: 0;
          font-size: 18px;
        }
        
        .close-button {
          background: none;
          border: none;
          color: white;
          font-size: 24px;
          cursor: pointer;
        }
        
        .help-content {
          padding: 15px;
          max-height: 500px;
          overflow-y: auto;
        }
        
        .help-content h4 {
          margin: 0 0 10px 0;
          font-size: 16px;
          border-bottom: 1px solid #ddd;
          padding-bottom: 5px;
        }
        
        .help-content ul {
          padding-left: 20px;
          margin-bottom: 15px;
        }
        
        .modal-overlay {
          position: fixed;
          top: 0;
          left: 0;
          right: 0;
          bottom: 0;
          background-color: rgba(0, 0, 0, 0.5);
          display: flex;
          justify-content: center;
          align-items: center;
          z-index: 1000;
        }
        
        .modal-container {
          background-color: white;
          border-radius: 5px;
          box-shadow: 0 2px 20px rgba(0, 0, 0, 0.3);
          width: 500px;
          max-width: 90%;
          max-height: 90%;
          overflow-y: auto;
        }
        
        .modal-content {
          padding: 20px;
        }
        
        .modal-content h3 {
          margin-top: 0;
          font-size: 18px;
          margin-bottom: 15px;
        }
        
        .form-group {
          margin-bottom: 15px;
        }
        
        .form-group label {
          display: block;
          margin-bottom: 5px;
          font-weight: bold;
        }
        
        .form-control {
          width: 100%;
          padding: 8px;
          border: 1px solid #ddd;
          border-radius: 4px;
          font-size: 14px;
        }
        
        textarea.form-control {
          resize: vertical;
          min-height: 80px;
        }
        
        .button-row {
          display: flex;
          justify-content: flex-end;
          margin-top: 20px;
        }
        
        .btn {
          padding: 8px 15px;
          border: none;
          border-radius: 4px;
          cursor: pointer;
          font-size: 14px;
          margin-left: 10px;
        }
        
        .btn-primary {
          background-color: #3498db;
          color: white;
        }
        
        .btn-secondary {
          background-color: #95a5a6;
          color: white;
        }
        
        .note {
          font-style: italic;
          color: #777;
          margin-bottom: 10px;
        }
      `}</style>
    </div>
  );
};

export default MissionPlannerComponent;
```


## 6. Neural Network-based Contingency Predictor for Enhanced Emergency Responses

Let's create a sophisticated neural network-based system to predict optimal contingency responses in emergency situations:

```textmate
/**
 * /client/iasms/components/ContingencyPredictorComponent.jsx
 * 
 * Neural Network-based Contingency Predictor for Enhanced Emergency Responses
 * Provides real-time prediction of optimal emergency responses in simulation
 * 
 * Copyright 2025 Autonomy Association International Inc., all rights reserved 
 * Safeguard patent license from National Aeronautics and Space Administration (NASA)
 * Copyright 2025 NASA, all rights reserved
 */

import React, { useState, useEffect, useRef } from 'react';
import { Meteor } from 'meteor/meteor';
import { useTracker } from 'meteor/react-meteor-data';
import * as tf from '@tensorflow/tfjs';
import Chart from 'chart.js/auto';
import * as turf from '@turf/turf';

/**
 * Contingency Predictor Component for emergency response simulation
 */
const ContingencyPredictorComponent = ({
  simulationId,
  emergencyData = null,
  onPredictionComplete = () => {},
  showAdvancedOptions = false
}) => {
  // Neural network model refs
  const modelRef = useRef(null);
  const modelLoadingRef = useRef(false);
  
  // Chart refs
  const predictionChartRef = useRef(null);
  const confidenceChartRef = useRef(null);
  
  // State for prediction data
  const [isModelLoaded, setIsModelLoaded] = useState(false);
  const [isPredicting, setIsPredicting] = useState(false);
  const [prediction, setPrediction] = useState(null);
  const [predictionHistory, setPredictionHistory] = useState([]);
  const [confidenceLevel, setConfidenceLevel] = useState(0);
  const [emergencyType, setEmergencyType] = useState(emergencyData?.type || 'UNKNOWN');
  const [emergencySeverity, setEmergencySeverity] = useState(emergencyData?.severity || 0.5);
  const [emergencyLocation, setEmergencyLocation] = useState(emergencyData?.location || null);
  
  // State for risk assessment
  const [riskAssessment, setRiskAssessment] = useState({
    overallRisk: 0,
    timeToImpact: 0,
    affectedArea: 0,
    potentialCasualties: 0
  });
  
  // Additional simulation state
  const [simulationState, setSimulationState] = useState({
    weatherConditions: 'normal',
    trafficDensity: 'medium',
    timeOfDay: 'day'
  });
  
  // Advanced options
  const [selectedModel, setSelectedModel] = useState('standard');
  const [predictionThreshold, setPredictionThreshold] = useState(0.7);
  const [useCachedData, setUseCachedData] = useState(true);
  
  // Available models
  const availableModels = [
    { id: 'standard', name: 'Standard Model', description: 'Balanced accuracy and speed' },
    { id: 'highAccuracy', name: 'High Accuracy Model', description: 'Highest accuracy, slower predictions' },
    { id: 'fastResponse', name: 'Fast Response Model', description: 'Optimized for speed, lower accuracy' },
    { id: 'experimental', name: 'Experimental Model', description: 'Using latest neural architecture' }
  ];
  
  // Contingency response options
  const contingencyOptions = [
    { id: 'land_immediately', name: 'Land Immediately', description: 'Emergency landing at nearest safe location' },
    { id: 'return_to_launch', name: 'Return to Launch', description: 'Return to takeoff location' },
    { id: 'continue_mission', name: 'Continue Mission', description: 'Proceed with mission if safe' },
    { id: 'hold_position', name: 'Hold Position', description: 'Maintain current position and altitude' },
    { id: 'emergency_descent', name: 'Emergency Descent', description: 'Controlled rapid descent to safe altitude' },
    { id: 'divert_to_alternate', name: 'Divert to Alternate', description: 'Proceed to pre-designated alternate landing site' }
  ];
  
  /**
   * Track simulation data from Meteor collections
   */
  const { simulation, vehicles, vertiports, weather, isLoading } = useTracker(() => {
    if (!simulationId) return { isLoading: false };
    
    const simSub = Meteor.subscribe('iasms.simulationScenario', simulationId);
    const vehiclesSub = Meteor.subscribe('iasms.simulationVehicles', simulationId);
    const hazardsSub = Meteor.subscribe('iasms.simulationHazards', simulationId);
    
    const isLoading = !simSub.ready() || !vehiclesSub.ready() || !hazardsSub.ready();
    
    // Get simulation data
    const simulation = Meteor.call('iasms.simulation.getScenario', simulationId);
    
    // Get vehicles
    const vehicles = Meteor.call('iasms.simulation.getVehicles', simulationId);
    
    // Get vertiports
    const vertiports = Meteor.call('iasms.simulation.getVertiports', simulationId);
    
    // Get weather
    const weather = Meteor.call('iasms.simulation.getWeather', simulationId);
    
    return {
      simulation,
      vehicles,
      vertiports,
      weather,
      isLoading
    };
  }, [simulationId]);
  
  /**
   * Load TensorFlow model when component mounts
   */
  useEffect(() => {
    if (!modelLoadingRef.current && !modelRef.current) {
      loadModel();
    }
    
    // Initialize charts
    initCharts();
    
    // Cleanup function
    return () => {
      if (predictionChartRef.current) {
        predictionChartRef.current.destroy();
      }
      
      if (confidenceChartRef.current) {
        confidenceChartRef.current.destroy();
      }
    };
  }, []);
  
  /**
   * Update emergency data when props change
   */
  useEffect(() => {
    if (emergencyData) {
      setEmergencyType(emergencyData.type || 'UNKNOWN');
      setEmergencySeverity(emergencyData.severity || 0.5);
      setEmergencyLocation(emergencyData.location || null);
      
      // Auto-predict if model is loaded
      if (isModelLoaded) {
        runPrediction();
      }
    }
  }, [emergencyData, isModelLoaded]);
  
  /**
   * Load the appropriate TensorFlow.js model
   */
  const loadModel = async () => {
    try {
      modelLoadingRef.current = true;
      
      console.log('Loading TensorFlow.js model...');
      
      // Determine model URL based on selected model
      let modelUrl;
      
      switch (selectedModel) {
        case 'highAccuracy':
          modelUrl = '/models/contingency_predictor_high_accuracy/model.json';
          break;
        case 'fastResponse':
          modelUrl = '/models/contingency_predictor_fast_response/model.json';
          break;
        case 'experimental':
          modelUrl = '/models/contingency_predictor_experimental/model.json';
          break;
        default:
          modelUrl = '/models/contingency_predictor_standard/model.json';
      }
      
      // Load the model
      const model = await tf.loadLayersModel(modelUrl);
      
      // Warm up the model with a sample prediction
      const dummyInput = tf.ones([1, 10]);
      model.predict(dummyInput);
      dummyInput.dispose();
      
      // Store the model
      modelRef.current = model;
      setIsModelLoaded(true);
      
      console.log('TensorFlow.js model loaded successfully');
    } catch (error) {
      console.error('Failed to load TensorFlow.js model:', error);
      
      // Fallback to basic model
      try {
        const fallbackModel = await tf.loadLayersModel('/models/contingency_predictor_fallback/model.json');
        modelRef.current = fallbackModel;
        setIsModelLoaded(true);
        console.log('Fallback model loaded successfully');
      } catch (fallbackError) {
        console.error('Failed to load fallback model:', fallbackError);
      }
    } finally {
      modelLoadingRef.current = false;
    }
  };
  
  /**
   * Initialize charts for visualization
   */
  const initCharts = () => {
    // Create prediction chart
    const predictionCtx = document.getElementById('predictionChart');
    
    if (predictionCtx) {
      predictionChartRef.current = new Chart(predictionCtx, {
        type: 'bar',
        data: {
          labels: contingencyOptions.map(option => option.name),
          datasets: [{
            label: 'Predicted Effectiveness',
            data: Array(contingencyOptions.length).fill(0),
            backgroundColor: 'rgba(54, 162, 235, 0.7)',
            borderColor: 'rgba(54, 162, 235, 1)',
            borderWidth: 1
          }]
        },
        options: {
          indexAxis: 'y',
          scales: {
            x: {
              beginAtZero: true,
              max: 1
            }
          },
          plugins: {
            legend: {
              display: false
            },
            tooltip: {
              callbacks: {
                label: function(context) {
                  return `Effectiveness: ${Math.round(context.raw * 100)}%`;
                }
              }
            }
          }
        }
      });
    }
    
    // Create confidence chart
    const confidenceCtx = document.getElementById('confidenceChart');
    
    if (confidenceCtx) {
      confidenceChartRef.current = new Chart(confidenceCtx, {
        type: 'doughnut',
        data: {
          labels: ['Confidence', 'Uncertainty'],
          datasets: [{
            data: [0, 100],
            backgroundColor: [
              'rgba(75, 192, 192, 0.7)',
              'rgba(201, 203, 207, 0.7)'
            ],
            borderColor: [
              'rgba(75, 192, 192, 1)',
              'rgba(201, 203, 207, 1)'
            ],
            borderWidth: 1
          }]
        },
        options: {
          cutout: '70%',
          plugins: {
            legend: {
              display: false
            },
            tooltip: {
              callbacks: {
                label: function(context) {
                  return context.label === 'Confidence' ? 
                    `Confidence: ${Math.round(context.raw)}%` : 
                    `Uncertainty: ${Math.round(context.raw)}%`;
                }
              }
            }
          }
        }
      });
    }
  };
  
  /**
   * Run the prediction with current data
   */
  const runPrediction = async () => {
    if (!isModelLoaded || !modelRef.current) {
      console.warn('Model not loaded yet');
      return;
    }
    
    setIsPredicting(true);
    
    try {
      // Prepare input data
      const inputData = prepareInputData();
      
      // Run prediction with TensorFlow.js
      const inputTensor = tf.tensor2d([inputData]);
      const predictionTensor = modelRef.current.predict(inputTensor);
      
      // Get prediction results
      const predictionArray = await predictionTensor.data();
      
      // Get highest prediction
      const maxIndex = predictionArray.indexOf(Math.max(...predictionArray));
      const bestResponse = contingencyOptions[maxIndex];
      
      // Calculate confidence level
      const confidence = predictionArray[maxIndex];
      
      // Set prediction and confidence
      setPrediction(bestResponse);
      setConfidenceLevel(confidence);
      
      // Add to prediction history
      setPredictionHistory(prev => [...prev, {
        timestamp: new Date(),
        response: bestResponse,
        confidence,
        emergencyType
      }]);
      
      // Update charts
      updateCharts(Array.from(predictionArray), confidence);
      
      // Run risk assessment
      calculateRiskAssessment(bestResponse, confidence);
      
      // Notify parent component
      onPredictionComplete({
        prediction: bestResponse,
        confidence,
        alternativeResponses: contingencyOptions
          .map((option, index) => ({
            ...option,
            effectiveness: predictionArray[index]
          }))
          .sort((a, b) => b.effectiveness - a.effectiveness)
      });
      
      // Clean up tensors
      inputTensor.dispose();
      predictionTensor.dispose();
    } catch (error) {
      console.error('Prediction error:', error);
    } finally {
      setIsPredicting(false);
    }
  };
  
  /**
   * Prepare input data for the model
   */
  const prepareInputData = () => {
    // Emergency type encoding
    const emergencyTypeEncoding = {
      'VEHICLE_EMERGENCY': [1, 0, 0, 0],
      'MECHANICAL_FAILURE': [1, 0, 0, 0],
      'BATTERY_CRITICAL': [0, 1, 0, 0],
      'LOST_LINK': [0, 0, 1, 0],
      'NAVIGATION_ERROR': [0, 0, 0, 1],
      'UNKNOWN': [0.25, 0.25, 0.25, 0.25]
    };
    
    // Get encoding for current emergency type
    const typeEncoding = emergencyTypeEncoding[emergencyType] || emergencyTypeEncoding['UNKNOWN'];
    
    // Weather conditions encoding
    const weatherEncoding = {
      'normal': 0,
      'rain': 0.25,
      'snow': 0.5,
      'fog': 0.75,
      'storm': 1
    };
    
    // Traffic density encoding
    const trafficEncoding = {
      'low': 0,
      'medium': 0.5,
      'high': 1
    };
    
    // Time of day encoding
    const timeEncoding = {
      'day': 0,
      'dawn': 0.33,
      'dusk': 0.66,
      'night': 1
    };
    
    // Combine all inputs
    return [
      ...typeEncoding,
      emergencySeverity,
      weatherEncoding[simulationState.weatherConditions] || 0,
      trafficEncoding[simulationState.trafficDensity] || 0.5,
      timeEncoding[simulationState.timeOfDay] || 0,
      // Additional features can be added here
      predictionThreshold
    ];
  };
  
  /**
   * Update visualization charts
   */
  const updateCharts = (predictionArray, confidence) => {
    // Update prediction chart
    if (predictionChartRef.current) {
      predictionChartRef.current.data.datasets[0].data = predictionArray;
      predictionChartRef.current.update();
    }
    
    // Update confidence chart
    if (confidenceChartRef.current) {
      const confidencePercent = Math.round(confidence * 100);
      confidenceChartRef.current.data.datasets[0].data = [
        confidencePercent,
        100 - confidencePercent
      ];
      confidenceChartRef.current.update();
    }
  };
  
  /**
   * Calculate risk assessment based on prediction
   */
  const calculateRiskAssessment = (prediction, confidence) => {
    // Base risk level from emergency severity
    let overallRisk = emergencySeverity;
    
    // Adjust risk based on response effectiveness
    overallRisk *= (1 - (confidence * 0.5));
    
    // Calculate time to impact
    const timeToImpact = calculateTimeToImpact(prediction);
    
    // Calculate affected area
    const affectedArea = calculateAffectedArea();
    
    // Estimate potential casualties (simplified model)
    const potentialCasualties = calculatePotentialCasualties(affectedArea, overallRisk);
    
    // Update risk assessment
    setRiskAssessment({
      overallRisk,
      timeToImpact,
      affectedArea,
      potentialCasualties
    });
  };
  
  /**
   * Calculate estimated time to impact
   */
  const calculateTimeToImpact = (prediction) => {
    // Default time (in seconds)
    let timeToImpact = 300;
    
    // Adjust based on emergency type and response
    switch (emergencyType) {
      case 'MECHANICAL_FAILURE':
        timeToImpact = 120;
        break;
      case 'BATTERY_CRITICAL':
        timeToImpact = 180;
        break;
      case 'LOST_LINK':
        timeToImpact = 240;
        break;
      case 'NAVIGATION_ERROR':
        timeToImpact = 300;
        break;
    }
    
    // Adjust based on recommended response
    switch (prediction.id) {
      case 'land_immediately':
        timeToImpact *= 0.7; // Less time available
        break;
      case 'emergency_descent':
        timeToImpact *= 0.8;
        break;
      case 'hold_position':
        timeToImpact *= 1.2; // More time available
        break;
      case 'divert_to_alternate':
        timeToImpact *= 1.1;
        break;
    }
    
    // Adjust based on severity
    timeToImpact *= (1 - (emergencySeverity * 0.5));
    
    return Math.round(timeToImpact);
  };
  
  /**
   * Calculate affected area based on emergency location and type
   */
  const calculateAffectedArea = () => {
    // Default radius (in meters)
    let radius = 100;
    
    // Adjust based on emergency type
    switch (emergencyType) {
      case 'MECHANICAL_FAILURE':
        radius = 150;
        break;
      case 'BATTERY_CRITICAL':
        radius = 100;
        break;
      case 'LOST_LINK':
        radius = 200;
        break;
      case 'NAVIGATION_ERROR':
        radius = 250;
        break;
    }
    
    // Adjust based on severity
    radius *= (0.5 + emergencySeverity);
    
    // Calculate area
    return Math.PI * radius * radius;
  };
  
  /**
   * Calculate potential casualties
   */
  const calculatePotentialCasualties = (area, risk) => {
    // Simplified model based on area and risk
    const baseValue = (area / 10000) * risk;
    
    // Adjust based on environment (urban vs rural)
    const urbanFactor = simulationState.environmentType === 'urban' ? 10 : 1;
    
    // Adjust based on time of day (more people during day)
    const timeFactor = simulationState.timeOfDay === 'day' ? 2 : 1;
    
    return Math.round(baseValue * urbanFactor * timeFactor);
  };
  
  /**
   * Generate a contingency plan based on prediction
   */
  const generateContingencyPlan = () => {
    if (!prediction) return null;
    
    // Get the base plan
    let plan;
    
    switch (prediction.id) {
      case 'land_immediately':
        plan = generateLandImmediatelyPlan();
        break;
      case 'return_to_launch':
        plan = generateReturnToLaunchPlan();
        break;
      case 'continue_mission':
        plan = generateContinueMissionPlan();
        break;
      case 'hold_position':
        plan = generateHoldPositionPlan();
        break;
      case 'emergency_descent':
        plan = generateEmergencyDescentPlan();
        break;
      case 'divert_to_alternate':
        plan = generateDivertToAlternatePlan();
        break;
      default:
        plan = generateLandImmediatelyPlan(); // Default to safest option
    }
    
    return plan;
  };
  
  /**
   * Generate "Land Immediately" contingency plan
   */
  const generateLandImmediatelyPlan = () => {
    return {
      title: 'Land Immediately',
      steps: [
        'Identify nearest safe landing area',
        'Descend to safe altitude',
        'Execute emergency landing procedures',
        'Notify authorities of landing location'
      ],
      waypoints: findNearestLandingLocations(),
      estimatedTime: Math.round(riskAssessment.timeToImpact * 0.8),
      riskLevel: 'High',
      priority: 'Critical'
    };
  };
  
  /**
   * Generate "Return to Launch" contingency plan
   */
  const generateReturnToLaunchPlan = () => {
    return {
      title: 'Return to Launch',
      steps: [
        'Calculate return path to launch site',
        'Maintain safe altitude',
        'Execute normal landing procedures at launch site',
        'Notify operators of return'
      ],
      waypoints: calculateReturnPath(),
      estimatedTime: Math.round(riskAssessment.timeToImpact * 1.2),
      riskLevel: 'Medium',
      priority: 'High'
    };
  };
  
  /**
   * Generate "Continue Mission" contingency plan
   */
  const generateContinueMissionPlan = () => {
    return {
      title: 'Continue Mission',
      steps: [
        'Monitor emergency condition',
        'Proceed with mission at reduced capacity',
        'Prepare for potential escalation',
        'Complete mission if condition remains stable'
      ],
      waypoints: getCurrentMissionWaypoints(),
      estimatedTime: Math.round(riskAssessment.timeToImpact * 1.5),
      riskLevel: 'Low to Medium',
      priority: 'Medium'
    };
  };
  
  /**
   * Generate "Hold Position" contingency plan
   */
  const generateHoldPositionPlan = () => {
    return {
      title: 'Hold Position',
      steps: [
        'Maintain current altitude',
        'Enter hover or loiter mode',
        'Wait for further instructions or resolution',
        'Conserve battery power'
      ],
      waypoints: [getCurrentPosition()],
      estimatedTime: Math.round(riskAssessment.timeToImpact),
      riskLevel: 'Medium',
      priority: 'Medium'
    };
  };
  
  /**
   * Generate "Emergency Descent" contingency plan
   */
  const generateEmergencyDescentPlan = () => {
    return {
      title: 'Emergency Descent',
      steps: [
        'Identify safe area below',
        'Initiate controlled rapid descent',
        'Maintain minimum control airspeed',
        'Level off at safe altitude'
      ],
      waypoints: generateDescentPath(),
      estimatedTime: Math.round(riskAssessment.timeToImpact * 0.6),
      riskLevel: 'High',
      priority: 'Critical'
    };
  };
  
  /**
   * Generate "Divert to Alternate" contingency plan
   */
  const generateDivertToAlternatePlan = () => {
    return {
      title: 'Divert to Alternate',
      steps: [
        'Identify nearest alternate landing site',
        'Calculate diversion path',
        'Notify alternate site of incoming emergency',
        'Execute landing at alternate site'
      ],
      waypoints: findAlternateLandingSites(),
      estimatedTime: Math.round(riskAssessment.timeToImpact * 1.1),
      riskLevel: 'Medium',
      priority: 'High'
    };
  };
  
  /**
   * Find nearest landing locations
   */
  const findNearestLandingLocations = () => {
    // Get current position
    const currentPos = getCurrentPosition();
    
    if (!currentPos || !vertiports) {
      return [];
    }
    
    // Calculate distances to all vertiports
    const landingSites = vertiports.map(vertiport => {
      const position = {
        x: vertiport.position.x,
        y: 0,
        z: vertiport.position.z
      };
      
      const distance = calculateDistance(currentPos, position);
      
      return {
        id: vertiport.id,
        name: vertiport.name,
        position,
        distance
      };
    });
    
    // Sort by distance
    landingSites.sort((a, b) => a.distance - b.distance);
    
    // Return top 3 nearest sites
    return landingSites.slice(0, 3);
  };
  
  /**
   * Calculate return path to launch site
   */
  const calculateReturnPath = () => {
    // Get current position
    const currentPos = getCurrentPosition();
    
    // Simplified launch position (in real implementation, this would be retrieved from data)
    const launchPos = {
      x: 0,
      y: 100,
      z: 0
    };
    
    // Generate a simple path with a few waypoints
    return [
      currentPos,
      {
        x: (currentPos.x + launchPos.x) / 2,
        y: Math.max(currentPos.y, launchPos.y) + 20, // Slightly higher altitude for safety
        z: (currentPos.z + launchPos.z) / 2
      },
      {
        x: launchPos.x,
        y: launchPos.y + 20, // Approach altitude
        z: launchPos.z
      },
      launchPos
    ];
  };
  
  /**
   * Get current mission waypoints
   */
  const getCurrentMissionWaypoints = () => {
    // Simplified mission waypoints (in real implementation, these would be retrieved from data)
    return [
      getCurrentPosition(),
      {
        x: 100,
        y: 120,
        z: 100
      },
      {
        x: 200,
        y: 150,
        z: 200
      },
      {
        x: 300,
        y: 100,
        z: 300
      }
    ];
  };
  
  /**
   * Generate descent path
   */
  const generateDescentPath = () => {
    // Get current position
    const currentPos = getCurrentPosition();
    
    if (!currentPos) {
      return [];
    }
    
    // Generate a descent path
    return [
      currentPos,
      {
        x: currentPos.x,
        y: currentPos.y * 0.7, // 70% of current altitude
        z: currentPos.z
      },
      {
        x: currentPos.x,
        y: currentPos.y * 0.4, // 40% of current altitude
        z: currentPos.z
      },
      {
        x: currentPos.x,
        y: currentPos.y * 0.1, // 10% of current altitude
        z: currentPos.z
      }
    ];
  };
  
  /**
   * Find alternate landing sites
   */
  const findAlternateLandingSites = () => {
    // This would be similar to findNearestLandingLocations, but excluding the primary site
    // and considering other factors like facilities, weather conditions, etc.
    
    // Get current position
    const currentPos = getCurrentPosition();
    
    if (!currentPos || !vertiports || vertiports.length <= 1) {
      return [];
    }
    
    // Calculate distances to all vertiports
    const landingSites = vertiports.map(vertiport => {
      const position = {
        x: vertiport.position.x,
        y: 0,
        z: vertiport.position.z
      };
      
      const distance = calculateDistance(currentPos, position);
      
      // Calculate a score based on distance and other factors
      let score = 1 / (distance + 1); // Higher score for closer sites
      
      // Add some randomness to simulate other factors
      score *= (0.8 + Math.random() * 0.4);
      
      return {
        id: vertiport.id,
        name: vertiport.name,
        position,
        distance,
        score
      };
    });
    
    // Sort by score (higher is better)
    landingSites.sort((a, b) => b.score - a.score);
    
    // Skip the first one (assumed to be the primary site) and return the next 3
    return landingSites.slice(1, 4);
  };
  
  /**
   * Get current position (either from emergency data or simulated)
   */
  const getCurrentPosition = () => {
    if (emergencyLocation && emergencyLocation.coordinates) {
      return {
        x: emergencyLocation.coordinates[0],
        y: 100, // Default altitude if not provided
        z: emergencyLocation.coordinates[1]
      };
    }
    
    // Simulated position if no real data available
    return {
      x: 50,
      y: 100,
      z: 50
    };
  };
  
  /**
   * Calculate distance between two points
   */
  const calculateDistance = (point1, point2) => {
    const dx = point2.x - point1.x;
    const dy = point2.y - point1.y;
    const dz = point2.z - point1.z;
    
    return Math.sqrt(dx * dx + dy * dy + dz * dz);
  };
  
  /**
   * Change selected model
   */
  const handleModelChange = (modelId) => {
    setSelectedModel(modelId);
    
    // Reload the model
    modelRef.current = null;
    setIsModelLoaded(false);
    loadModel();
  };
  
  // Generate the contingency plan
  const contingencyPlan = prediction ? generateContingencyPlan() : null;
  
  return (
    <div className="contingency-predictor">
      <div className="predictor-header">
        <h2>
          Neural Contingency Predictor
          {isModelLoaded && (
            <span className="model-status">
              <span className="status-dot active"></span>
              Model Active
            </span>
          )}
          {!isModelLoaded && (
            <span className="model-status">
              <span className="status-dot"></span>
              Loading Model...
            </span>
          )}
        </h2>
      </div>
      
      <div className="predictor-content">
        <div className="predictor-main">
          <div className="emergency-details">
            <h3>Emergency Details</h3>
            
            <div className="details-grid">
              <div className="detail-item">
                <div className="detail-label">Type:</div>
                <div className="detail-value">{emergencyType.replace(/_/g, ' ')}</div>
              </div>
              
              <div className="detail-item">
                <div className="detail-label">Severity:</div>
                <div className="detail-value">
                  <div className="severity-meter">
                    <div 
                      className="severity-fill" 
                      style={{ width: `${emergencySeverity * 100}%` }}
                    ></div>
                  </div>
                  <span className="severity-value">{(emergencySeverity * 100).toFixed(0)}%</span>
                </div>
              </div>
              
              <div className="detail-item">
                <div className="detail-label">Location:</div>
                <div className="detail-value">
                  {emergencyLocation ? (
                    `${emergencyLocation.coordinates[0].toFixed(1)}, ${emergencyLocation.coordinates[1].toFixed(1)}`
                  ) : (
                    'Unknown'
                  )}
                </div>
              </div>
              
              <div className="detail-item">
                <div className="detail-label">Weather:</div>
                <div className="detail-value">
                  <select 
                    value={simulationState.weatherConditions}
                    onChange={(e) => setSimulationState({
                      ...simulationState,
                      weatherConditions: e.target.value
                    })}
                  >
                    <option value="normal">Normal</option>
                    <option value="rain">Rain</option>
                    <option value="snow">Snow</option>
                    <option value="fog">Fog</option>
                    <option value="storm">Storm</option>
                  </select>
                </div>
              </div>
              
              <div className="detail-item">
                <div className="detail-label">Traffic:</div>
                <div className="detail-value">
                  <select 
                    value={simulationState.trafficDensity}
                    onChange={(e) => setSimulationState({
                      ...simulationState,
                      trafficDensity: e.target.value
                    })}
                  >
                    <option value="low">Low</option>
                    <option value="medium">Medium</option>
                    <option value="high">High</option>
                  </select>
                </div>
              </div>
              
              <div className="detail-item">
                <div className="detail-label">Time:</div>
                <div className="detail-value">
                  <select 
                    value={simulationState.timeOfDay}
                    onChange={(e) => setSimulationState({
                      ...simulationState,
                      timeOfDay: e.target.value
                    })}
                  >
                    <option value="day">Day</option>
                    <option value="dawn">Dawn</option>
                    <option value="dusk">Dusk</option>
                    <option value="night">Night</option>
                  </select>
                </div>
              </div>
            </div>
            
            <div className="action-buttons">
              <button 
                className="predict-button" 
                onClick={runPrediction}
                disabled={!isModelLoaded || isPredicting}
              >
                {isPredicting ? 'Predicting...' : 'Run Prediction'}
              </button>
            </div>
          </div>
          
          <div className="prediction-results">
            <h3>Prediction Results</h3>
            
            {prediction ? (
              <div className="results-container">
                <div className="recommended-action">
                  <div className="action-header">
                    <h4>Recommended Action</h4>
                    <div className="confidence-tag">
                      {confidenceLevel >= 0.8 ? (
                        <span className="high">High Confidence</span>
                      ) : confidenceLevel >= 0.6 ? (
                        <span className="medium">Medium Confidence</span>
                      ) : (
                        <span className="low">Low Confidence</span>
                      )}
                    </div>
                  </div>
                  
                  <div className="action-name">{prediction.name}</div>
                  <div className="action-description">{prediction.description}</div>
                </div>
                
                <div className="visualization-container">
                  <div className="chart-container">
                    <h4>Effectiveness by Response</h4>
                    <canvas id="predictionChart" height="200"></canvas>
                  </div>
                  
                  <div className="confidence-container">
                    <h4>Prediction Confidence</h4>
                    <div className="confidence-display">
                      <canvas id="confidenceChart" width="150" height="150"></canvas>
                      <div className="confidence-value">
                        {Math.round(confidenceLevel * 100)}%
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            ) : (
              <div className="no-prediction">
                <p>No prediction available. Click "Run Prediction" to analyze this emergency.</p>
              </div>
            )}
          </div>
        </div>
        
        {contingencyPlan && (
          <div className="contingency-plan">
            <h3>Contingency Plan: {contingencyPlan.title}</h3>
            
            <div className="plan-details">
              <div className="plan-section">
                <h4>Action Steps</h4>
                <ol className="steps-list">
                  {contingencyPlan.steps.map((step, index) => (
                    <li key={index}>{step}</li>
                  ))}
                </ol>
              </div>
              
              <div className="plan-section">
                <h4>Risk Assessment</h4>
                <div className="risk-metrics">
                  <div className="risk-metric">
                    <div className="metric-label">Overall Risk:</div>
                    <div className="metric-value">
                      <div className="risk-meter">
                        <div 
                          className="risk-fill" 
                          style={{ 
                            width: `${riskAssessment.overallRisk * 100}%`,
                            backgroundColor: riskAssessment.overallRisk > 0.7 ? '#dc3545' : 
                                             riskAssessment.overallRisk > 0.4 ? '#ffc107' : '#28a745'
                          }}
                        ></div>
                      </div>
                      <span className="risk-value">
                        {riskAssessment.overallRisk < 0.4 ? 'Low' : 
                         riskAssessment.overallRisk < 0.7 ? 'Medium' : 'High'}
                      </span>
                    </div>
                  </div>
                  
                  <div className="risk-metric">
                    <div className="metric-label">Time to Impact:</div>
                    <div className="metric-value">{Math.floor(riskAssessment.timeToImpact / 60)}:{(riskAssessment.timeToImpact % 60).toString().padStart(2, '0')}</div>
                  </div>
                  
                  <div className="risk-metric">
                    <div className="metric-label">Affected Area:</div>
                    <div className="metric-value">{Math.round(riskAssessment.affectedArea)} m²</div>
                  </div>
                  
                  <div className="risk-metric">
                    <div className="metric-label">Est. Exposure:</div>
                    <div className="metric-value">{riskAssessment.potentialCasualties} people</div>
                  </div>
                </div>
              </div>
              
              <div className="plan-section">
                <h4>Waypoints</h4>
                <div className="waypoints-list">
                  {contingencyPlan.waypoints && contingencyPlan.waypoints.length > 0 ? (
                    <table className="waypoints-table">
                      <thead>
                        <tr>
                          <th>#</th>
                          <th>X</th>
                          <th>Y</th>
                          <th>Z</th>
                          {contingencyPlan.waypoints[0].name && <th>Name</th>}
                          {contingencyPlan.waypoints[0].distance && <th>Distance</th>}
                        </tr>
                      </thead>
                      <tbody>
                        {contingencyPlan.waypoints.map((waypoint, index) => (
                          <tr key={index}>
                            <td>{index + 1}</td>
                            <td>{waypoint.x?.toFixed(1) || waypoint.position?.x.toFixed(1)}</td>
                            <td>{waypoint.y?.toFixed(1) || waypoint.position?.y.toFixed(1) || '0.0'}</td>
                            <td>{waypoint.z?.toFixed(1) || waypoint.position?.z.toFixed(1)}</td>
                            {waypoint.name && <td>{waypoint.name}</td>}
                            {waypoint.distance && <td>{waypoint.distance.toFixed(1)} m</td>}
                          </tr>
                        ))}
                      </tbody>
                    </table>
                  ) : (
                    <p>No waypoints available for this plan.</p>
                  )}
                </div>
              </div>
            </div>
            
            <div className="plan-actions">
              <button className="plan-action-button primary">
                <i className="icon-execute"></i> Execute Plan
              </button>
              <button className="plan-action-button secondary">
                <i className="icon-modify"></i> Modify Plan
              </button>
              <button className="plan-action-button tertiary">
                <i className="icon-download"></i> Save Plan
              </button>
            </div>
          </div>
        )}
        
        {showAdvancedOptions && (
          <div className="advanced-options">
            <h3>Advanced Options</h3>
            
            <div className="options-grid">
              <div className="option-group">
                <h4>Model Selection</h4>
                <div className="model-options">
                  {availableModels.map(model => (
                    <div 
                      key={model.id} 
                      className={`model-option ${selectedModel === model.id ? 'selected' : ''}`}
                      onClick={() => handleModelChange(model.id)}
                    >
                      <div className="model-name">{model.name}</div>
                      <div className="model-description">{model.description}</div>
                    </div>
                  ))}
                </div>
              </div>
              
              <div className="option-group">
                <h4>Prediction Settings</h4>
                <div className="prediction-settings">
                  <div className="setting-item">
                    <label>Confidence Threshold:</label>
                    <input 
                      type="range" 
                      min="0.5" 
                      max="0.9" 
                      step="0.05" 
                      value={predictionThreshold}
                      onChange={(e) => setPredictionThreshold(parseFloat(e.target.value))}
                    />
                    <span className="threshold-value">{predictionThreshold.toFixed(2)}</span>
                  </div>
                  
                  <div className="setting-item">
                    <label>Use Cached Data:</label>
                    <input 
                      type="checkbox" 
                      checked={useCachedData}
                      onChange={(e) => setUseCachedData(e.target.checked)}
                    />
                  </div>
                </div>
              </div>
              
              <div className="option-group full-width">
                <h4>Prediction History</h4>
                <div className="prediction-history">
                  {predictionHistory.length > 0 ? (
                    <table className="history-table">
                      <thead>
                        <tr>
                          <th>Time</th>
                          <th>Emergency</th>
                          <th>Response</th>
                          <th>Confidence</th>
                        </tr>
                      </thead>
                      <tbody>
                        {predictionHistory.map((entry, index) => (
                          <tr key={index}>
                            <td>{entry.timestamp.toLocaleTimeString()}</td>
                            <td>{entry.emergencyType.replace(/_/g, ' ')}</td>
                            <td>{entry.response.name}</td>
                            <td>{Math.round(entry.confidence * 100)}%</td>
                          </tr>
                        ))}
                      </tbody>
                    </table>
                  ) : (
                    <p>No prediction history available.</p>
                  )}
                </div>
              </div>
            </div>
          </div>
        )}
      </div>
      
      <style jsx>{`
        .contingency-predictor {
          font-family: 'Roboto', Arial, sans-serif;
          background-color: #f8f9fa;
          border-radius: 8px;
          box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
          overflow: hidden;
          display: flex;
          flex-direction: column;
          height: 100%;
        }
        
        .predictor-header {
          background-color: #343a40;
          padding: 15px 20px;
          color: white;
        }
        
        .predictor-header h2 {
          margin: 0;
          font-size: 1.4rem;
          display: flex;
          align-items: center;
          justify-content: space-between;
        }
        
        .model-status {
          font-size: 0.9rem;
          font-weight: normal;
          display: flex;
          align-items: center;
        }
        
        .status-dot {
          width: 10px;
          height: 10px;
          border-radius: 50%;
          background-color: #6c757d;
          margin-right: 8px;
        }
        
        .status-dot.active {
          background-color: #28a745;
          box-shadow: 0 0 5px #28a745;
        }
        
        .predictor-content {
          flex: 1;
          padding: 20px;
          overflow-y: auto;
        }
        
        .predictor-main {
          display: flex;
          margin-bottom: 20px;
          gap: 20px;
        }
        
        .emergency-details {
          flex: 1;
          background-color: white;
          border-radius: 6px;
          box-shadow: 0 1px 5px rgba(0, 0, 0, 0.05);
          padding: 15px;
        }
        
        .emergency-details h3 {
          margin-top: 0;
          margin-bottom: 15px;
          font-size: 1.2rem;
          color: #343a40;
          border-bottom: 1px solid #e9ecef;
          padding-bottom: 10px;
        }
        
        .details-grid {
          display: grid;
          grid-template-columns: 1fr 1fr;
          gap: 15px;
        }
        
        .detail-item {
          display: flex;
          align-items: center;
        }
        
        .detail-label {
          font-weight: bold;
          width: 80px;
          color: #495057;
        }
        
        .detail-value {
          flex: 1;
        }
        
        .detail-value select {
          width: 100%;
          padding: 5px;
          border: 1px solid #ced4da;
          border-radius: 4px;
          background-color: white;
        }
        
        .severity-meter {
          width: 100%;
          height: 10px;
          background-color: #e9ecef;
          border-radius: 5px;
          overflow: hidden;
          margin-right: 10px;
          flex: 1;
        }
        
        .severity-fill {
          height: 100%;
          background-color: #dc3545;
          border-radius: 5px;
        }
        
        .severity-value {
          font-weight: bold;
          margin-left: 10px;
        }
        
        .action-buttons {
          margin-top: 20px;
          display: flex;
          justify-content: center;
        }
        
        .predict-button {
          background-color: #007bff;
          color: white;
          border: none;
          border-radius: 4px;
          padding: 10px 20px;
          font-size: 1rem;
          cursor: pointer;
          transition: background-color 0.2s;
        }
        
        .predict-button:hover {
          background-color: #0069d9;
        }
        
        .predict-button:disabled {
          background-color: #6c757d;
          cursor: not-allowed;
        }
        
        .prediction-results {
          flex: 2;
          background-color: white;
          border-radius: 6px;
          box-shadow: 0 1px 5px rgba(0, 0, 0, 0.05);
          padding: 15px;
        }
        
        .prediction-results h3 {
          margin-top: 0;
          margin-bottom: 15px;
          font-size: 1.2rem;
          color: #343a40;
          border-bottom: 1px solid #e9ecef;
          padding-bottom: 10px;
        }
        
        .results-container {
          display: flex;
          flex-direction: column;
          gap: 20px;
        }
        
        .recommended-action {
          background-color: #f8f9fa;
          border-radius: 6px;
          padding: 15px;
          border-left: 4px solid #28a745;
        }
        
        .action-header {
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin-bottom: 10px;
        }
        
        .action-header h4 {
          margin: 0;
          font-size: 1.1rem;
          color: #343a40;
        }
        
        .confidence-tag span {
          padding: 4px 8px;
          border-radius: 4px;
          font-size: 0.8rem;
          font-weight: bold;
        }
        
        .confidence-tag .high {
          background-color: #d4edda;
          color: #155724;
        }
        
        .confidence-tag .medium {
          background-color: #fff3cd;
          color: #856404;
        }
        
        .confidence-tag .low {
          background-color: #f8d7da;
          color: #721c24;
        }
        
        .action-name {
          font-size: 1.3rem;
          font-weight: bold;
          margin-bottom: 5px;
          color: #212529;
        }
        
        .action-description {
          color: #6c757d;
        }
        
        .visualization-container {
          display: flex;
          gap: 20px;
        }
        
        .chart-container {
          flex: 2;
        }
        
        .confidence-container {
          flex: 1;
          display: flex;
          flex-direction: column;
          align-items: center;
        }
        
        .chart-container h4, .confidence-container h4 {
          margin-top: 0;
          margin-bottom: 15px;
          font-size: 1rem;
          color: #495057;
          text-align: center;
        }
        
        .confidence-display {
          position: relative;
          width: 150px;
          height: 150px;
        }
        
        .confidence-value {
          position: absolute;
          top: 50%;
          left: 50%;
          transform: translate(-50%, -50%);
          font-size: 1.5rem;
          font-weight: bold;
          color: #343a40;
        }
        
        .no-prediction {
          display: flex;
          justify-content: center;
          align-items: center;
          height: 200px;
          color: #6c757d;
          text-align: center;
          font-style: italic;
        }
        
        .contingency-plan {
          background-color: white;
          border-radius: 6px;
          box-shadow: 0 1px 5px rgba(0, 0, 0, 0.05);
          padding: 15px;
          margin-bottom: 20px;
        }
        
        .contingency-plan h3 {
          margin-top: 0;
          margin-bottom: 15px;
          font-size: 1.2rem;
          color: #343a40;
          border-bottom: 1px solid #e9ecef;
          padding-bottom: 10px;
        }
        
        .plan-details {
          display: grid;
          grid-template-columns: 1fr 1fr;
          gap: 20px;
        }
        
        .plan-section {
          margin-bottom: 20px;
        }
        
        .plan-section.full-width {
          grid-column: 1 / span 2;
        }
        
        .plan-section h4 {
          margin-top: 0;
          margin-bottom: 10px;
          font-size: 1rem;
          color: #495057;
        }
        
        .steps-list {
          margin: 0;
          padding-left: 20px;
        }
        
        .steps-list li {
          margin-bottom: 8px;
          color: #495057;
        }
        
        .risk-metrics {
          display: flex;
          flex-direction: column;
          gap: 10px;
        }
        
        .risk-metric {
          display: flex;
          align-items: center;
          margin-bottom: 5px;
        }
        
        .metric-label {
          width: 120px;
          font-weight: bold;
          color: #495057;
        }
        
        .metric-value {
          flex: 1;
          display: flex;
          align-items: center;
        }
        
        .risk-meter {
          width: 100px;
          height: 8px;
          background-color: #e9ecef;
          border-radius: 4px;
          overflow: hidden;
          margin-right: 10px;
        }
        
        .risk-fill {
          height: 100%;
          background-color: #28a745;
          border-radius: 4px;
        }
        
        .risk-value {
          font-weight: bold;
          width: 60px;
        }
        
        .waypoints-list {
          max-height: 200px;
          overflow-y: auto;
          border: 1px solid #e9ecef;
          border-radius: 4px;
        }
        
        .waypoints-table {
          width: 100%;
          border-collapse: collapse;
        }
        
        .waypoints-table th, .waypoints-table td {
          padding: 8px;
          text-align: left;
          border-bottom: 1px solid #e9ecef;
        }
        
        .waypoints-table th {
          background-color: #f8f9fa;
          font-weight: bold;
          color: #495057;
        }
        
        .plan-actions {
          display: flex;
          justify-content: center;
          gap: 15px;
          margin-top: 20px;
        }
        
        .plan-action-button {
          padding: 8px 15px;
          border-radius: 4px;
          border: none;
          font-weight: bold;
          cursor: pointer;
          display: flex;
          align-items: center;
          gap: 5px;
        }
        
        .plan-action-button.primary {
          background-color: #28a745;
          color: white;
        }
        
        .plan-action-button.secondary {
          background-color: #6c757d;
          color: white;
        }
        
        .plan-action-button.tertiary {
          background-color: #f8f9fa;
          color: #212529;
          border: 1px solid #ced4da;
        }
        
        .advanced-options {
          background-color: white;
          border-radius: 6px;
          box-shadow: 0 1px 5px rgba(0, 0, 0, 0.05);
          padding: 15px;
        }
        
        .advanced-options h3 {
          margin-top: 0;
          margin-bottom: 15px;
          font-size: 1.2rem;
          color: #343a40;
          border-bottom: 1px solid #e9ecef;
          padding-bottom: 10px;
        }
        
        .options-grid {
          display: grid;
          grid-template-columns: 1fr 1fr;
          gap: 20px;
        }
        
        .option-group {
          margin-bottom: 20px;
        }
        
        .option-group.full-width {
          grid-column: 1 / span 2;
        }
        
        .option-group h4 {
          margin-top: 0;
          margin-bottom: 10px;
          font-size: 1rem;
          color: #495057;
        }
        
        .model-options {
          display: grid;
          grid-template-columns: 1fr 1fr;
          gap: 10px;
        }
        
        .model-option {
          border: 1px solid #ced4da;
          border-radius: 4px;
          padding: 10px;
          cursor: pointer;
          transition: all 0.2s;
        }
        
        .model-option:hover {
          border-color: #adb5bd;
          background-color: #f8f9fa;
        }
        
        .model-option.selected {
          border-color: #007bff;
          background-color: #e7f5ff;
          box-shadow: 0 0 0 1px #007bff;
        }
        
        .model-name {
          font-weight: bold;
          margin-bottom: 5px;
          color: #343a40;
        }
        
        .model-description {
          font-size: 0.8rem;
          color: #6c757d;
        }
        
        .prediction-settings {
          display: flex;
          flex-direction: column;
          gap: 15px;
        }
        
        .setting-item {
          display: flex;
          align-items: center;
          gap: 10px;
        }
        
        .setting-item label {
          width: 150px;
          font-weight: bold;
          color: #495057;
        }
        
        .setting-item input[type="range"] {
          flex: 1;
        }
        
        .threshold-value {
          width: 40px;
          text-align: right;
        }
        
        .prediction-history {
          max-height: 200px;
          overflow-y: auto;
          border: 1px solid #e9ecef;
          border-radius: 4px;
        }
        
        .history-table {
          width: 100%;
          border-collapse: collapse;
        }
        
        .history-table th, .history-table td {
          padding: 8px;
          text-align: left;
          border-bottom: 1px solid #e9ecef;
        }
        
        .history-table th {
          background-color: #f8f9fa;
          font-weight: bold;
          color: #495057;
        }
      `}</style>
    </div>
  );
};

export default ContingencyPredictorComponent;
```


## 7. Full Integration with Existing IASMS System

Now, let's create a new main module that integrates all of our enhanced components and connects them to the existing IASMS system:

```textmate
/**
 * /client/iasms/components/SimulationTrainingContainer.jsx
 * 
 * Primary container for IASMS AR/VR Simulation Training
 * Integrates all simulation components and manages coordination between them
 * 
 * Copyright 2025 Autonomy Association International Inc., all rights reserved 
 * Safeguard patent license from National Aeronautics and Space Administration (NASA)
 * Copyright 2025 NASA, all rights reserved
 */

import React, { useState, useEffect, useRef } from 'react';
import { Meteor } from 'meteor/meteor';
import { useTracker } from 'meteor/react-meteor-data';
import { useNavigate, useParams, Link } from 'react-router-dom';

// Import simulation components
import SimulationTrainingModule from './SimulationTrainingModule';
import VRGestureController from './VRGestureController';
import MissionPlannerComponent from './MissionPlannerComponent';
import TerrainVisualizationComponent from './TerrainVisualizationComponent';
import ContingencyPredictorComponent from './ContingencyPredictorComponent';

// Import helper components
import LoadingIndicator from '../shared/LoadingIndicator';
import ErrorBoundary from '../shared/ErrorBoundary';

/**
 * Main container for IASMS AR/VR Simulation Training
 * Coordinates all simulation components and manages data flow between them
 */
const SimulationTrainingContainer = () => {
  const navigate = useNavigate();
  const { scenarioId } = useParams();
  
  // Refs for components
  const simulationRef = useRef(null);
  const terrainRef = useRef(null);
  
  // State for AR/VR mode
  const [isVRMode, setIsVRMode] = useState(false);
  const [isARMode, setIsARMode] = useState(false);
  const [immersiveMode, setImmersiveMode] = useState('desktop'); // 'desktop', 'ar', 'vr'
  
  // State for simulation
  const [simulationRunning, setSimulationRunning] = useState(false);
  const [simulationTime, setSimulationTime] = useState(0);
  const [simulationSpeed, setSimulationSpeed] = useState(1);
  const [emergencyActive, setEmergencyActive] = useState(false);
  const [emergencyData, setEmergencyData] = useState(null);
  const [simulationScore, setSimulationScore] = useState(0);
  
  // State for UI
  const [activeTab, setActiveTab] = useState('simulation');
  const [showSidebar, setShowSidebar] = useState(true);
  const [showMissionPanel, setShowMissionPanel] = useState(false);
  const [selectedVehicle, setSelectedVehicle] = useState(null);
  const [showTerrain, setShowTerrain] = useState(false);
  const [showPredictor, setShowPredictor] = useState(false);
  const [showCollabPanel, setShowCollabPanel] = useState(false);
  const [emergencyResponse, setEmergencyResponse] = useState(null);
  
  // Get session info
  const [sessionType, setSessionType] = useState('solo'); // 'solo', 'collaborative'
  const [userRole, setUserRole] = useState('instructor');
  const [collaborativeSessionId, setCollaborativeSessionId] = useState(null);
  
  /**
   * Track scenario data from collections
   */
  const { scenario, isLoading, error, isCollaborative, collaborators } = useTracker(() => {
    const scenarioSub = Meteor.subscribe('iasms.simulationScenario', scenarioId);
    const isLoading = !scenarioSub.ready();
    
    let scenario, error, isCollaborative, collaborators;
    
    try {
      scenario = isLoading ? null : Meteor.call('iasms.simulation.getScenario', scenarioId);
      
      // Check if this is a collaborative session
      const collabSessionSub = Meteor.subscribe('iasms.collaborative.sessionDetails', scenarioId);
      
      if (collabSessionSub.ready()) {
        const collabSession = Meteor.call('iasms.collaborative.getSession', scenarioId);
        
        if (collabSession) {
          isCollaborative = true;
          collaborators = collabSession.participants;
          
          // Set session type and role
          setSessionType('collaborative');
          setCollaborativeSessionId(scenarioId);
          
          // Find current user's role
          const currentUser = Meteor.userId();
          const participant = collaborators.find(p => p.userId === currentUser);
          if (participant) {
            setUserRole(participant.role);
          }
        }
      }
    } catch (err) {
      console.error('Error loading simulation data:', err);
      error = err.message;
    }
    
    return { scenario, isLoading, error, isCollaborative, collaborators };
  }, [scenarioId]);
  
  /**
   * Handle simulation initialization
   */
  useEffect(() => {
    if (!isLoading && scenario) {
      console.log('Initializing simulation for scenario:', scenario.name);
      
      // If in collaborative mode, initialize collaborative features
      if (sessionType === 'collaborative') {
        initializeCollaborativeSession();
      }
    }
    
    // Cleanup on unmount
    return () => {
      if (simulationRunning) {
        Meteor.call('iasms.simulation.pause', scenarioId);
      }
    };
  }, [isLoading, scenario, sessionType]);
  
  /**
   * Initialize collaborative session
   */
  const initializeCollaborativeSession = () => {
    // Subscribe to collaborative session events
    Meteor.subscribe('iasms.collaborative.sessionEvents', collaborativeSessionId);
    
    // Handle collaborative session state changes
    Meteor.autorun(() => {
      const session = Meteor.call('iasms.collaborative.getSessionState', collaborativeSessionId);
      
      if (session) {
        setSimulationRunning(session.status === 'running');
        setSimulationTime(session.simulationTime);
        setSimulationSpeed(session.speed);
        
        // Handle role-specific UI updates
        updateUIForRole(userRole);
      }
    });
    
    // Show collaboration panel
    setShowCollabPanel(true);
  };
  
  /**
   * Update UI based on user role
   */
  const updateUIForRole = (role) => {
    switch (role) {
      case 'instructor':
        // Instructors see everything
        setShowMissionPanel(true);
        setShowTerrain(true);
        setShowPredictor(true);
        break;
      case 'airspace_manager':
        setShowMissionPanel(true);
        setShowTerrain(true);
        setShowPredictor(true);
        break;
      case 'emergency_coordinator':
        setShowMissionPanel(false);
        setShowTerrain(true);
        setShowPredictor(true);
        break;
      case 'vertiport_operator':
        setShowMissionPanel(false);
        setShowTerrain(true);
        setShowPredictor(false);
        break;
      case 'tactical_controller':
        setShowMissionPanel(false);
        setShowTerrain(false);
        setShowPredictor(false);
        break;
      case 'observer':
        setShowMissionPanel(false);
        setShowTerrain(true);
        setShowPredictor(false);
        break;
      default:
        // Default view
        setShowMissionPanel(false);
        setShowTerrain(true);
        setShowPredictor(false);
    }
  };
  
  /**
   * Start simulation
   */
  const startSimulation = () => {
    Meteor.call('iasms.simulation.play', scenarioId, (error) => {
      if (error) {
        console.error('Error starting simulation:', error);
      } else {
        setSimulationRunning(true);
        
        // If in collaborative mode, notify others
        if (sessionType === 'collaborative') {
          Meteor.call('iasms.collaborative.notifyStateChange', collaborativeSessionId, {
            status: 'running',
            changedBy: Meteor.userId()
          });
        }
      }
    });
  };
  
  /**
   * Pause simulation
   */
  const pauseSimulation = () => {
    Meteor.call('iasms.simulation.pause', scenarioId, (error) => {
      if (error) {
        console.error('Error pausing simulation:', error);
      } else {
        setSimulationRunning(false);
        
        // If in collaborative mode, notify others
        if (sessionType === 'collaborative') {
          Meteor.call('iasms.collaborative.notifyStateChange', collaborativeSessionId, {
            status: 'paused',
            changedBy: Meteor.userId()
          });
        }
      }
    });
  };
  
  /**
   * Change simulation speed
   */
  const changeSimulationSpeed = (speed) => {
    Meteor.call('iasms.simulation.setSpeed', scenarioId, speed, (error) => {
      if (error) {
        console.error('Error changing simulation speed:', error);
      } else {
        setSimulationSpeed(speed);
        
        // If in collaborative mode, notify others
        if (sessionType === 'collaborative') {
          Meteor.call('iasms.collaborative.notifyStateChange', collaborativeSessionId, {
            speed,
            changedBy: Meteor.userId()
          });
        }
      }
    });
  };
  
  /**
   * End simulation
   */
  const endSimulation = () => {
    if (confirm('Are you sure you want to end this simulation?')) {
      Meteor.call('iasms.simulation.end', scenarioId, (error, result) => {
        if (error) {
          console.error('Error ending simulation:', error);
        } else {
          // Navigate to results page
          navigate(`/iasms/simulation/results/${scenarioId}`);
          
          // If in collaborative mode, notify others
          if (sessionType === 'collaborative') {
            Meteor.call('iasms.collaborative.notifyStateChange', collaborativeSessionId, {
              status: 'completed',
              changedBy: Meteor.userId()
            });
          }
        }
      });
    }
  };
  
  /**
   * Inject emergency event
   */
  const injectEmergency = (type, severity, location) => {
    Meteor.call('iasms.simulation.injectEvent', scenarioId, {
      type,
      severity,
      location
    }, (error, eventId) => {
      if (error) {
        console.error('Error injecting emergency:', error);
      } else {
        console.log('Emergency injected:', eventId);
        
        // Update emergency state
        setEmergencyActive(true);
        setEmergencyData({
          id: eventId,
          type,
          severity,
          location,
          time: new Date()
        });
        
        // Show predictor if emergency is active
        setShowPredictor(true);
        
        // If in collaborative mode, notify others
        if (sessionType === 'collaborative') {
          Meteor.call('iasms.collaborative.notifyEvent', collaborativeSessionId, {
            eventType: 'emergency',
            eventId,
            data: {
              type,
              severity,
              location
            },
            createdBy: Meteor.userId()
          });
        }
      }
    });
  };
  
  /**
   * Handle emergency prediction result
   */
  const handlePredictionComplete = (result) => {
    console.log('Prediction result:', result);
    setEmergencyResponse(result);
    
    // If in collaborative mode, share the prediction
    if (sessionType === 'collaborative') {
      Meteor.call('iasms.collaborative.sharePrediction', collaborativeSessionId, {
        emergencyId: emergencyData.id,
        prediction: result,
        sharedBy: Meteor.userId()
      });
    }
  };
  
  /**
   * Handle gesture detected in VR
   */
  const handleGestureDetected = (gestureData) => {
    console.log('Gesture detected:', gestureData);
    
    // Process different gestures
    switch (gestureData.gesture) {
      case 'point':
        // Point gesture could select an object
        if (simulationRef.current) {
          simulationRef.current.selectAtPosition(gestureData.position);
        }
        break;
      case 'grab':
        // Grab gesture could start dragging an object
        break;
      case 'pinch':
        // Pinch gesture could zoom the view
        break;
      case 'open':
        // Open hand gesture could release an object or cancel an action
        break;
      case 'thumbsUp':
        // Thumbs up could confirm an action
        break;
      case 'victory':
        // Victory gesture could trigger a specific command
        break;
      case 'swipeLeft':
      case 'swipeRight':
      case 'swipeUp':
      case 'swipeDown':
        // Swipe gestures could navigate UI
        break;
    }
    
    // If in collaborative mode, share gesture for awareness
    if (sessionType === 'collaborative') {
      Meteor.call('iasms.collaborative.shareGesture', collaborativeSessionId, {
        gesture: gestureData.gesture,
        position: gestureData.position,
        userId: Meteor.userId()
      });
    }
  };
  
  /**
   * Handle terrain interaction
   */
  const handleTerrainInteraction = (interaction) => {
    console.log('Terrain interaction:', interaction);
    
    if (interaction.type === 'click') {
      // Click on terrain could place an object or set a waypoint
      if (showMissionPanel) {
        // Add waypoint if in mission planning mode
      }
    } else if (interaction.type === 'hoverFeature') {
      // Hovering over a feature
      if (interaction.feature.type === 'vertiport') {
        // Show vertiport info
      } else if (interaction.feature.type === 'noFlyZone') {
        // Show no-fly zone info
      }
    }
  };
  
  /**
   * Handle scenario creation or update
   */
  const handleScenarioSave = (scenario) => {
    Meteor.call('iasms.simulation.saveScenario', scenario, (error, result) => {
      if (error) {
        console.error('Error saving scenario:', error);
      } else {
        console.log('Scenario saved:', result);
        
        // Navigate to scenario list
        navigate('/iasms/simulation/scenarios');
      }
    });
  };
  
  /**
   * Toggle VR mode
   */
  const toggleVRMode = () => {
```
ERROR
