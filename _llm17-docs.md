I'll continue creating documentation for more of the JavaScript files. Let me create documentation for a protocol file and a service file next.

### 4. Protocol Documentation: `/docs/protocols/AgentProtocol.html`

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- protocols/AgentProtocol.html -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agent Protocol - Robot Swarm Documentation</title>
    
    <!-- Bootstrap 4 CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    
    <!-- Custom CSS -->
    <style>
        body {
            padding-top: 56px;
            position: relative;
        }
        .sidebar {
            position: sticky;
            top: 4rem;
            height: calc(100vh - 4rem);
            overflow-y: auto;
        }
        .main-content {
            margin-bottom: 100px;
        }
        h1, h2, h3, h4, h5, h6 {
            margin-top: 1.5rem;
            margin-bottom: 1rem;
        }
        code {
            color: #e83e8c;
            background-color: #f8f9fa;
            padding: 0.2rem 0.4rem;
            border-radius: 0.25rem;
        }
        pre {
            background-color: #f8f9fa;
            padding: 1rem;
            border-radius: 0.3rem;
            margin-bottom: 1rem;
        }
        .method-heading {
            background-color: #f8f9fa;
            padding: 0.5rem;
            border-left: 4px solid #007bff;
            margin-top: 2rem;
        }
        .toc {
            position: sticky;
            top: 4rem;
        }
        .highlight {
            background-color: #fff3cd;
            transition: background-color 1s ease;
        }
        #content pre code {
            display: block;
            overflow-x: auto;
            color: #333;
            background: #f8f9fa;
        }
        .param-table {
            margin-bottom: 1.5rem;
        }
        .param-name {
            font-weight: bold;
            color: #0056b3;
        }
    </style>
</head>
<body data-spy="scroll" data-target="#toc">
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
        <div class="container">
            <a class="navbar-brand" href="../index.html">Safeguard Documentation</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="../index.html">Home</a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" href="../protocols/index.html">Protocols</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="../predictors/index.html">Predictors</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="../core/index.html">Core Systems</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Page Content -->
    <div class="container mt-4">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3">
                <div class="sidebar">
                    <div class="list-group">
                        <a href="../index.html" class="list-group-item list-group-item-action">Home</a>
                        <div class="list-group-item list-group-item-secondary">Protocols</div>
                        <a href="AgentProtocol.html" class="list-group-item list-group-item-action active ml-3">AgentProtocol</a>
                        <a href="AgentToAgentCommunicationProtocol.html" class="list-group-item list-group-item-action ml-3">AgentToAgentCommunicationProtocol</a>
                        <a href="MessageCommunicationProtocol.html" class="list-group-item list-group-item-action ml-3">MessageCommunicationProtocol</a>
                        <a href="ModelContextProtocol.html" class="list-group-item list-group-item-action ml-3">ModelContextProtocol</a>
                        <div class="list-group-item list-group-item-secondary">Related</div>
                        <a href="../core/SafeguardBase.html" class="list-group-item list-group-item-action ml-3">SafeguardBase</a>
                        <a href="../services/TrajectoryPlanningService.html" class="list-group-item list-group-item-action ml-3">TrajectoryPlanningService</a>
                    </div>
                </div>
            </div>
            
            <!-- Main Content -->
            <div class="col-md-7 main-content" id="content">
                <div class="alert alert-secondary">
                    <strong>File:</strong> AgentProtocol.js
                </div>
                
                <h1 id="agent-protocol">Agent Protocol</h1>
                
                <h2 id="overview">Overview</h2>
                
                <p>The AgentProtocol module defines a standardized interface for agents within the Safeguard system. It establishes the core capabilities, lifecycle, and communication patterns that all agent implementations must adhere to, enabling consistent agent management across different domains.</p>
                
                <div class="alert alert-info">
                    <strong>Purpose:</strong> This protocol provides a common foundation for defining and managing agents (vehicles, robots, drones, etc.) within the Safeguard ecosystem, regardless of their specific implementation or domain.
                </div>
                
                <h2 id="class-agentprotocol">Class: AgentProtocol</h2>
                
                <h3 id="constructor">Constructor</h3>
                
                <pre><code class="javascript">const protocol = new AgentProtocol(options);</code></pre>
                
                <h4>Options</h4>
                
                <table class="table table-striped param-table">
                    <thead>
                        <tr>
                            <th>Parameter</th>
                            <th>Type</th>
                            <th>Default</th>
                            <th>Description</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="param-name">version</td>
                            <td>String</td>
                            <td>'1.0'</td>
                            <td>Protocol version</td>
                        </tr>
                        <tr>
                            <td class="param-name">agentType</td>
                            <td>String</td>
                            <td>'generic'</td>
                            <td>Type of agent (e.g., 'drone', 'robot', 'vehicle', 'satellite')</td>
                        </tr>
                        <tr>
                            <td class="param-name">domain</td>
                            <td>String</td>
                            <td>'generic'</td>
                            <td>Domain in which the agent operates (e.g., 'air', 'land', 'sea', 'space')</td>
                        </tr>
                        <tr>
                            <td class="param-name">capabilities</td>
                            <td>Array</td>
                            <td>[]</td>
                            <td>Array of capability strings that the agent supports</td>
                        </tr>
                        <tr>
                            <td class="param-name">schema</td>
                            <td>Object</td>
                            <td>null</td>
                            <td>Custom schema for validating agent properties</td>
                        </tr>
                    </tbody>
                </table>
                
                <h3 id="methods">Methods</h3>
                
                <div class="method-heading" id="method-registerAgent">
                    <h4>registerAgent(agent)</h4>
                </div>
                
                <p>Registers a new agent with the protocol, validating its structure and capabilities.</p>
                
                <pre><code class="javascript">const result = await protocol.registerAgent({
  agentId: 'drone-123',
  agentType: 'drone',
  capabilities: ['fly', 'hover', 'capture-image'],
  properties: {
    model: 'Quadcopter X500',
    maxSpeed: 15,
    maxAltitude: 120
  }
});</code></pre>
                
                <h5>Parameters</h5>
                
                <table class="table table-striped param-table">
                    <thead>
                        <tr>
                            <th>Parameter</th>
                            <th>Type</th>
                            <th>Description</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="param-name">agent</td>
                            <td>Object</td>
                            <td>Agent definition object with ID, type, capabilities, and properties</td>
                        </tr>
                    </tbody>
                </table>
                
                <h5>Returns</h5>
                
                <ul class="list-group mb-4">
                    <li class="list-group-item">
                        <strong>Promise:</strong> Resolves with registration result object
                    </li>
                </ul>
                
                <div class="method-heading" id="method-validateAgent">
                    <h4>validateAgent(agent)</h4>
                </div>
                
                <p>Validates an agent definition against the protocol schema.</p>
                
                <pre><code class="javascript">const isValid = protocol.validateAgent(agentDefinition);</code></pre>
                
                <h5>Parameters</h5>
                
                <table class="table table-striped param-table">
                    <thead>
                        <tr>
                            <th>Parameter</th>
                            <th>Type</th>
                            <th>Description</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="param-name">agent</td>
                            <td>Object</td>
                            <td>Agent definition to validate</td>
                        </tr>
                    </tbody>
                </table>
                
                <h5>Returns</h5>
                
                <ul class="list-group mb-4">
                    <li class="list-group-item">
                        <strong>Boolean:</strong> True if the agent definition is valid, false otherwise
                    </li>
                </ul>
                
                <div class="method-heading" id="method-serializeAgent">
                    <h4>serializeAgent(agent)</h4>
                </div>
                
                <p>Serializes an agent definition to a string representation.</p>
                
                <pre><code class="javascript">const serialized = protocol.serializeAgent(agent);</code></pre>
                
                <h5>Parameters</h5>
                
                <table class="table table-striped param-table">
                    <thead>
                        <tr>
                            <th>Parameter</th>
                            <th>Type</th>
                            <th>Description</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="param-name">agent</td>
                            <td>Object</td>
                            <td>Agent definition to serialize</td>
                        </tr>
                    </tbody>
                </table>
                
                <h5>Returns</h5>
                
                <ul class="list-group mb-4">
                    <li class="list-group-item">
                        <strong>String:</strong> Serialized agent definition
                    </li>
                </ul>
                
                <div class="method-heading" id="method-deserializeAgent">
                    <h4>deserializeAgent(serialized)</h4>
                </div>
                
                <p>Deserializes a string representation to an agent definition.</p>
                
                <pre><code class="javascript">const agent = protocol.deserializeAgent(serialized);</code></pre>
                
                <h5>Parameters</h5>
                
                <table class="table table-striped param-table">
                    <thead>
                        <tr>
                            <th>Parameter</th>
                            <th>Type</th>
                            <th>Description</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="param-name">serialized</td>
                            <td>String</td>
                            <td>Serialized agent definition</td>
                        </tr>
                    </tbody>
                </table>
                
                <h5>Returns</h5>
                
                <ul class="list-group mb-4">
                    <li class="list-group-item">
                        <strong>Object:</strong> Deserialized agent definition
                    </li>
                </ul>
                
                <div class="method-heading" id="method-hasCapability">
                    <h4>hasCapability(agent, capability)</h4>
                </div>
                
                <p>Checks if an agent has a specific capability.</p>
                
                <pre><code class="javascript">const canHover = protocol.hasCapability(drone, 'hover');</code></pre>
                
                <h5>Parameters</h5>
                
                <table class="table table-striped param-table">
                    <thead>
                        <tr>
                            <th>Parameter</th>
                            <th>Type</th>
                            <th>Description</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="param-name">agent</td>
                            <td>Object</td>
                            <td>Agent definition to check</td>
                        </tr>
                        <tr>
                            <td class="param-name">capability</td>
                            <td>String</td>
                            <td>Capability to check for</td>
                        </tr>
                    </tbody>
                </table>
                
                <h5>Returns</h5>
                
                <ul class="list-group mb-4">
                    <li class="list-group-item">
                        <strong>Boolean:</strong> True if the agent has the capability, false otherwise
                    </li>
                </ul>
                
                <div class="method-heading" id="method-addCapability">
                    <h4>addCapability(agent, capability)</h4>
                </div>
                
                <p>Adds a capability to an agent.</p>
                
                <pre><code class="javascript">const updatedAgent = protocol.addCapability(drone, 'capture-video');</code></pre>
                
                <h5>Parameters</h5>
                
                <table class="table table-striped param-table">
                    <thead>
                        <tr>
                            <th>Parameter</th>
                            <th>Type</th>
                            <th>Description</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="param-name">agent</td>
                            <td>Object</td>
                            <td>Agent definition to modify</td>
                        </tr>
                        <tr>
                            <td class="param-name">capability</td>
                            <td>String</td>
                            <td>Capability to add</td>
                        </tr>
                    </tbody>
                </table>
                
                <h5>Returns</h5>
                
                <ul class="list-group mb-4">
                    <li class="list-group-item">
                        <strong>Object:</strong> Updated agent definition
                    </li>
                </ul>
                
                <div class="method-heading" id="method-removeCapability">
                    <h4>removeCapability(agent, capability)</h4>
                </div>
                
                <p>Removes a capability from an agent.</p>
                
                <pre><code class="javascript">const updatedAgent = protocol.removeCapability(drone, 'capture-video');</code></pre>
                
                <h5>Parameters</h5>
                
                <table class="table table-striped param-table">
                    <thead>
                        <tr>
                            <th>Parameter</th>
                            <th>Type</th>
                            <th>Description</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="param-name">agent</td>
                            <td>Object</td>
                            <td>Agent definition to modify</td>
                        </tr>
                        <tr>
                            <td class="param-name">capability</td>
                            <td>String</td>
                            <td>Capability to remove</td>
                        </tr>
                    </tbody>
                </table>
                
                <h5>Returns</h5>
                
                <ul class="list-group mb-4">
                    <li class="list-group-item">
                        <strong>Object:</strong> Updated agent definition
                    </li>
                </ul>
                
                <div class="method-heading" id="method-createAgentState">
                    <h4>createAgentState(agentId, state)</h4>
                </div>
                
                <p>Creates a standardized agent state object.</p>
                
                <pre><code class="javascript">const agentState = protocol.createAgentState('drone-123', {
  position: { lat: 47.123, lng: -122.456, alt: 100 },
  heading: 90,
  speed: 5.5,
  batteryLevel: 75,
  status: 'active'
});</code></pre>
                
                <h5>Parameters</h5>
                
                <table class="table table-striped param-table">
                    <thead>
                        <tr>
                            <th>Parameter</th>
                            <th>Type</th>
                            <th>Description</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="param-name">agentId</td>
                            <td>String</td>
                            <td>ID of the agent</td>
                        </tr>
                        <tr>
                            <td class="param-name">state</td>
                            <td>Object</td>
                            <td>State data for the agent</td>
                        </tr>
                    </tbody>
                </table>
                
                <h5>Returns</h5>
                
                <ul class="list-group mb-4">
                    <li class="list-group-item">
                        <strong>Object:</strong> Standardized agent state object
                    </li>
                </ul>
                
                <h2 id="agent-schema">Agent Schema</h2>
                
                <p>The protocol defines a schema for agent definitions that includes:</p>
                
                <div class="card mb-4">
                    <div class="card-header">
                        Agent Schema
                    </div>
                    <div class="card-body">
                        <pre><code class="javascript">{
  // Core properties
  "agentId": "drone-123", // Unique identifier
  "agentType": "drone", // Type of agent
  "protocolVersion": "1.0", // Version of the protocol
  "domain": "air", // Domain in which the agent operates
  
  // Capabilities
  "capabilities": [
    "fly",
    "hover",
    "capture-image",
    "return-to-home"
  ],
  
  // Properties specific to this agent type
  "properties": {
    "model": "Quadcopter X500",
    "manufacturer": "Example Drones Inc.",
    "maxSpeed": 15, // m/s
    "maxAltitude": 120, // meters
    "flightTime": 25 // minutes
  },
  
  // Optional metadata
  "metadata": {
    "createdAt": "2025-09-14T12:00:00.000Z",
    "lastUpdated": "2025-09-14T12:00:00.000Z",
    "owner": "John Doe"
  }
}</code></pre>
                    </div>
                </div>
                
                <h2 id="agent-state-schema">Agent State Schema</h2>
                
                <p>The protocol defines a schema for agent state objects that includes:</p>
                
                <div class="card mb-4">
                    <div class="card-header">
                        Agent State Schema
                    </div>
                    <div class="card-body">
                        <pre><code class="javascript">{
  // Core properties
  "agentId": "drone-123", // Unique identifier
  "timestamp": "2025-09-14T12:05:30.000Z", // Time of this state
  "protocolVersion": "1.0", // Version of the protocol
  
  // Positional data
  "position": {
    "lat": 47.123,
    "lng": -122.456,
    "alt": 100 // meters
  },
  
  // Movement data
  "heading": 90, // degrees
  "speed": 5.5, // m/s
  "velocity": {
    "x": 5.5, // m/s
    "y": 0.0, // m/s
    "z": 0.0 // m/s
  },
  
  // Status information
  "status": "active", // active, idle, error, etc.
  "batteryLevel": 75, // percent
  
  // Current operation
  "currentTask": "survey-area-123",
  
  // Health and diagnostics
  "health": {
    "systemStatus": "nominal",
    "warnings": [],
    "errors": []
  }
}</code></pre>
                    </div>
                </div>
                
                <h2 id="standard-capabilities">Standard Capabilities</h2>
                
                <p>The protocol defines several standard capabilities that can be used across different agent types:</p>
                
                <div class="table-responsive">
                    <table class="table table-bordered">
                        <thead class="thead-light">
                            <tr>
                                <th>Capability</th>
                                <th>Description</th>
                                <th>Applicable Domains</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>move</td>
                                <td>Ability to move in the environment</td>
                                <td>All</td>
                            </tr>
                            <tr>
                                <td>sense-environment</td>
                                <td>Ability to sense the environment (generic)</td>
                                <td>All</td>
                            </tr>
                            <tr>
                                <td>communicate</td>
                                <td>Ability to communicate with other agents</td>
                                <td>All</td>
                            </tr>
                            <tr>
                                <td>fly</td>
                                <td>Ability to fly through the air</td>
                                <td>Air</td>
                            </tr>
                            <tr>
                                <td>hover</td>
                                <td>Ability to hover in place</td>
                                <td>Air</td>
                            </tr>
                            <tr>
                                <td>land</td>
                                <td>Ability to land safely</td>
                                <td>Air</td>
                            </tr>
                            <tr>
                                <td>return-to-home</td>
                                <td>Ability to return to a home position automatically</td>
                                <td>All</td>
                            </tr>
                            <tr>
                                <td>capture-image</td>
                                <td>Ability to capture still images</td>
                                <td>All</td>
                            </tr>
                            <tr>
                                <td>capture-video</td>
                                <td>Ability to capture video</td>
                                <td>All</td>
                            </tr>
                            <tr>
                                <td>manipulate-objects</td>
                                <td>Ability to manipulate physical objects</td>
                                <td>All</td>
                            </tr>
                            <tr>
                                <td>autonomous-navigation</td>
                                <td>Ability to navigate autonomously</td>
                                <td>All</td>
                            </tr>
                            <tr>
                                <td>swim</td>
                                <td>Ability to move through water</td>
                                <td>Sea</td>
                            </tr>
                            <tr>
                                <td>drive</td>
                                <td>Ability to drive on land</td>
                                <td>Land</td>
                            </tr>
                            <tr>
                                <td>orbit</td>
                                <td>Ability to maintain a stable orbit</td>
                                <td>Space</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                
                <h2 id="usage-examples">Usage Examples</h2>
                
                <div class="card mb-4">
                    <div class="card-header">
                        Registering an Agent
                    </div>
                    <div class="card-body">
                        <pre><code class="javascript">// Import required modules
const { AgentProtocol } = require('./AgentProtocol');

// Create an agent protocol instance
const protocol = new AgentProtocol({
  agentType: 'drone',
  domain: 'air',
  capabilities: ['fly', 'hover', 'capture-image', 'return-to-home']
});

// Define a new agent
const droneAgent = {
  agentId: 'drone-123',
  agentType: 'drone',
  capabilities: [
    'fly',
    'hover',
    'capture-image',
    'return-to-home',
    'follow-waypoints'
  ],
  properties: {
    model: 'Quadcopter X500',
    manufacturer: 'Example Drones Inc.',
    maxSpeed: 15, // m/s
    maxAltitude: 120, // meters
    flightTime: 25 // minutes
  }
};

// Validate the agent definition
if (protocol.validateAgent(droneAgent)) {
  console.log('Agent definition is valid');
  
  // Register the agent
  protocol.registerAgent(droneAgent)
    .then(result => {
      console.log('Agent registered successfully:', result);
    })
    .catch(error => {
      console.error('Error registering agent:', error);
    });
} else {
  console.error('Invalid agent definition');
}</code></pre>
                    </div>
                </div>
                
                <div class="card mb-4">
                    <div class="card-header">
                        Working with Agent States
                    </div>
                    <div class="card-body">
                        <pre><code class="javascript">// Create an agent state
const state = protocol.createAgentState('drone-123', {
  position: { lat: 47.123, lng: -122.456, alt: 100 },
  heading: 90,
  speed: 5.5,
  batteryLevel: 75,
  status: 'active',
  currentTask: 'survey-area-123',
  health: {
    systemStatus: 'nominal',
    warnings: [],
    errors: []
  }
});

console.log('Agent state created:', state);

// Serialize the state for transmission
const serializedState = protocol.serializeAgent(state);
console.log('Serialized state:', serializedState);

// Later, deserialize the state
const deserializedState = protocol.deserializeAgent(serializedState);
console.log('Deserialized state:', deserializedState);

// Check for capabilities
const canFly = protocol.hasCapability(droneAgent, 'fly');
console.log('Can fly:', canFly);

// Add a new capability
const updatedAgent = protocol.addCapability(droneAgent, 'night-vision');
console.log('Updated agent capabilities:', updatedAgent.capabilities);</code></pre>
                    </div>
                </div>
                
                <div class="card mb-4">
                    <div class="card-header">
                        Integration with Safeguard System
                    </div>
                    <div class="card-body">
                        <pre><code class="javascript">// Import required modules
const { AgentProtocol } = require('./AgentProtocol');
const { SafeguardBase } = require('./SafeguardBase');

// Create an agent protocol instance
const agentProtocol = new AgentProtocol({
  agentType: 'drone',
  domain: 'air'
});

// Create a safeguard instance
const safeguard = new SafeguardBase({
  vehicleType: 'drone',
  environmentType: 'air'
});

// Initialize the safeguard
await safeguard.initialize();

// Register the agent with the protocol
const agent = await agentProtocol.registerAgent({
  agentId: 'drone-123',
  agentType: 'drone',
  capabilities: ['fly', 'hover', 'return-to-home'],
  properties: {
    model: 'Quadcopter X500',
    maxSpeed: 15,
    maxAltitude: 120
  }
});

// Attach the agent to the safeguard
safeguard.attachAgent(agent);

// Update agent state periodically
setInterval(() => {
  // Get current state from hardware or sensors
  const currentState = getStateFromHardware();
  
  // Create a standardized state object
  const agentState = agentProtocol.createAgentState(agent.agentId, currentState);
  
  // Update the safeguard with the new state
  safeguard.updateAgentState(agentState);
}, 1000); // Update every second

// Helper function to get state from hardware (mock implementation)
function getStateFromHardware() {
  return {
    position: { 
      lat: 47.123 + (Math.random() - 0.5) * 0.001, 
      lng: -122.456 + (Math.random() - 0.5) * 0.001, 
      alt: 100 + (Math.random() - 0.5) * 5 
    },
    heading: 90 + (Math.random() - 0.5) * 10,
    speed: 5.5 + (Math.random() - 0.5) * 1,
    batteryLevel: Math.max(0, 75 - (Date.now() % 1000) / 1000),
    status: 'active'
  };
}</code></pre>
                    </div>
                </div>
            </div>
            
            <!-- Table of Contents -->
            <div class="col-md-2">
                <div id="toc" class="toc">
                    <div class="card">
                        <div class="card-header">
                            On this page
                        </div>
                        <div class="card-body p-0">
                            <ul class="nav flex-column" id="toc-list">
                                <!-- TOC items will be inserted here by JavaScript -->
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-white mt-5 p-4">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h5>Safeguard Robot Swarm Documentation</h5>
                    <p>Comprehensive documentation for the Safeguard Robot Swarm Prediction and Management system.</p>
                </div>
                <div class="col-md-6 text-md-right">
                    <p>&copy; 2025 Autonomy Association International, Inc.</p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <!-- Custom JS for deep linking and TOC -->
    <script>
        $(document).ready(function() {
            // Handle deep linking
            if (window.location.hash) {
                const hash = window.location.hash;
                setTimeout(function() {
                    $('html, body').animate({
                        scrollTop: $(hash).offset().top - 70
                    }, 600);
                    
                    // Highlight the linked element
                    $(hash).addClass('highlight');
                    setTimeout(function() {
                        $(hash).removeClass('highlight');
                    }, 2000);
                }, 300);
            }
            
            // Generate table of contents
            const tocList = $('#toc-list');
            const headings = $('#content h2, #content h3');
            
            headings.each(function() {
                const id = $(this).attr('id') || $(this).text().toLowerCase().replace(/[^a-z0-9]+/g, '-');
                $(this).attr('id', id);
                
                const link = $('<a class="nav-link"></a>')
                    .attr('href', '#' + id)
                    .text($(this).text());
                
                let item;
                if ($(this).is('h2')) {
                    item = $('<li class="nav-item"></li>').append(link);
                    tocList.append(item);
                } else {
                    item = $('<li class="nav-item ml-3"></li>').append(link);
                    tocList.append(item);
                }
            });
        });
    </script>
</body>
</html>
```


### 5. Service Documentation: `/docs/services/WebSocketService.html`

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- services/WebSocketService.html -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WebSocket Service - Robot Swarm Documentation</title>
    
    <!-- Bootstrap 4 CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    
    <!-- Custom CSS -->
    <style>
        body {
            padding-top: 56px;
            position: relative;
        }
        .sidebar {
            position: sticky;
            top: 4rem;
            height: calc(100vh - 4rem);
            overflow-y: auto;
        }
        .main-content {
            margin-bottom: 100px;
        }
        h1, h2, h3, h4, h5, h6 {
            margin-top: 1.5rem;
            margin-bottom: 1rem;
        }
        code {
            color: #e83e8c;
            background-color: #f8f9fa;
            padding: 0.2rem 0.4rem;
            border-radius: 0.25rem;
        }
        pre {
            background-color: #f8f9fa;
            padding: 1rem;
            border-radius: 0.3rem;
            margin-bottom: 1rem;
        }
        .method-heading {
            background-color: #f8f9fa;
            padding: 0.5rem;
            border-left: 4px solid #007bff;
            margin-top: 2rem;
        }
        .toc {
            position: sticky;
            top: 4rem;
        }
        .highlight {
            background-color: #fff3cd;
            transition: background-color 1s ease;
        }
        #content pre code {
            display: block;
            overflow-x: auto;
            color: #333;
            background: #f8f9fa;
        }
        .param-table {
            margin-bottom: 1.5rem;
        }
        .param-name {
            font-weight: bold;
            color: #0056b3;
        }
    </style>
</head>
<body data-spy="scroll" data-target="#toc">
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
        <div class="container">
            <a class="navbar-brand" href="../index.html">Safeguard Documentation</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="../index.html">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="../protocols/index.html">Protocols</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="../predictors/index.html">Predictors</a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" href="../services/index.html">Services</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Page Content -->
    <div class="container mt-4">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3">
                <div class="sidebar">
                    <div class="list-group">
                        <a href="../index.html" class="list-group-item list-group-item-action">Home</a>
                        <div class="list-group-item list-group-item-secondary">Services</div>
                        <a href="WebSocketService.html" class="list-group-item list-group-item-action active ml-3">WebSocketService</a>
                        <a href="WebSocketTransportService.html" class="list-group-item list-group-item-action ml-3">WebSocketTransportService</a>
                        <a href="GeospatialUtilityFunctions.html" class="list-group-item list-group-item-action ml-3">GeospatialUtilityFunctions</a>
                        <a href="GeoJsonService.html" class="list-group-item list-group-item-action ml-3">GeoJsonService</a>
                        <a href="TrajectoryPlanningService.html" class="list-group-item list-group-item-action ml-3">TrajectoryPlanningService</a>
                        <a href="ArrowDataProcessingService.html" class="list-group-item list-group-item-action ml-3">ArrowDataProcessingService</a>
                        <div class="list-group-item list-group-item-secondary">Related</div>
                        <a href="../protocols/MessageCommunicationProtocol.html" class="list-group-item list-group-item-action ml-3">MessageCommunicationProtocol</a>
                        <a href="../core/SafeguardServer.html" class="list-group-item list-group-item-action ml-3">SafeguardServer</a>
                    </div>
                </div>
            </div>
            
            <!-- Main Content -->
            <div class="col-md-7 main-content" id="content">
                <div class="alert alert-secondary">
                    <strong>File:</strong> WebSocketService.js
                </div>
                
                <h1 id="websocket-service">WebSocket Service</h1>
                
                <h2 id="overview">Overview</h2>
                
                <p>The WebSocketService module provides real-time bidirectional communication between clients and the Safeguard server over WebSockets. It enables efficient streaming of telemetry data, commands, and notifications with minimal overhead, making it ideal for real-time applications like drone control and monitoring.</p>
                
                <div class="alert alert-info">
                    <strong>Purpose:</strong> This service handles the establishment, management, and security of WebSocket connections, providing both client and server implementations for seamless integration with the Safeguard ecosystem.
                </div>
                
                <h2 id="class-websocketservice">Class: WebSocketService</h2>
                
                <h3 id="constructor">Constructor</h3>
                
                <pre><code class="javascript">const wsService = new WebSocketService(options);</code></pre>
                
                <h4>Options</h4>
                
                <table class="table table-striped param-table">
                    <thead>
                        <tr>
                            <th>Parameter</th>
                            <th>Type</th>
                            <th>Default</th>
                            <th>Description</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="param-name">port</td>
                            <td>Number</td>
                            <td>8080</td>
                            <td>Port to listen on (server mode) or connect to (client mode)</td>
                        </tr>
                        <tr>
                            <td class="param-name">host</td>
                            <td>String</td>
                            <td>'localhost'</td>
                            <td>Host to bind to (server mode) or connect to (client mode)</td>
                        </tr>
                        <tr>
                            <td class="param-name">mode</td>
                            <td>String</td>
                            <td>'server'</td>
                            <td>Service mode ('server' or 'client')</td>
                        </tr>
                        <tr>
                            <td class="param-name">path</td>
                            <td>String</td>
                            <td>'/ws'</td>
                            <td>WebSocket endpoint path</td>
                        </tr>
                        <tr>
                            <td class="param-name">secure</td>
                            <td>Boolean</td>
                            <td>false</td>
                            <td>Whether to use secure WebSockets (WSS)</td>
                        </tr>
                        <tr>
                            <td class="param-name">ssl</td>
                            <td>Object</td>
                            <td>null</td>
                            <td>SSL configuration for secure connections (key, cert, etc.)</td>
                        </tr>
                        <tr>
                            <td class="param-name">heartbeatInterval</td>
                            <td>Number</td>
                            <td>30000</td>
                            <td>Heartbeat interval in milliseconds</td>
                        </tr>
                        <tr>
                            <td class="param-name">reconnectAttempts</td>
                            <td>Number</td>
                            <td>5</td>
                            <td>Number of reconnection attempts (client mode)</td>
                        </tr>
                        <tr>
                            <td class="param-name">maxPayloadSize</td>
                            <td>Number</td>
                            <td>1048576</td>
                            <td>Maximum payload size in bytes (1MB)</td>
                        </tr>
                        <tr>
                            <td class="param-name">logger</td>
                            <td>Object</td>
                            <td>console</td>
                            <td>Logger to use for logging</td>
                        </tr>
                    </tbody>
                </table>
                
                <h3 id="methods">Methods</h3>
                
                <div class="method-heading" id="method-start">
                    <h4>start()</h4>
                </div>
                
                <p>Starts the WebSocket service. In server mode, this begins listening for connections. In client mode, this initiates a connection to the server.</p>
                
                <pre><code class="javascript">await wsService.start();</code></pre>
                
                <h5>Returns</h5>
                
                <ul class="list-group mb-4">
                    <li class="list-group-item">
                        <strong>Promise:</strong> Resolves when the service is started
                    </li>
                </ul>
                
                <div class="method-heading" id="method-stop">
                    <h4>stop()</h4>
                </div>
                
                <p>Stops the WebSocket service, closing all connections and releasing resources.</p>
                
                <pre><code class="javascript">await wsService.stop();</code></pre>
                
                <h5>Returns</h5>
                
                <ul class="list-group mb-4">
                    <li class="list-group-item">
                        <strong>Promise:</strong> Resolves when the service is stopped
                    </li>
                </ul>
                
                <div class="method-heading" id="method-sendMessage">
                    <h4>sendMessage(client, messageType, data)</h4>
                </div>
                
                <p>Sends a message to a client. In server mode, 'client' should be a client object. In client mode, 'client' can be omitted.</p>
                
                <pre><code class="javascript">wsService.sendMessage(client, 'telemetry', {
  position: { lat: 47.123, lng: -122.456, alt: 100 },
  heading: 90,
  speed: 5.5,
  batteryLevel: 75
});</code></pre>
                
                <h5>Parameters</h5>
                
                <table class="table table-striped param-table">
                    <thead>
                        <tr>
                            <th>Parameter</th>
                            <th>Type</th>
                            <th>Description</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="param-name">client</td>
                            <td>Object</td>
                            <td>Client object (server mode) or null (client mode)</td>
                        </tr>
                        <tr>
                            <td class="param-name">messageType</td>
                            <td>String</td>
                            <td>Type of message being sent</td>
                        </tr>
                        <tr>
                            <td class="param-name">data</td>
                            <td>Object</td>
                            <td>Message data to send</td>
                        </tr>
                    </tbody>
                </table>
                
                <h5>Returns</h5>
                
                <ul class="list-group mb-4">
                    <li class="list-group-item">
                        <strong>Boolean:</strong> True if the message was sent successfully, false otherwise
                    </li>
                </ul>
                
                <div class="method-heading" id="method-broadcast">
                    <h4>broadcast(messageType, data, filter)</h4>
                </div>
                
                <p>Broadcasts a message to all connected clients (server mode only).</p>
                
                <pre><code class="javascript">wsService.broadcast('alert', {
  type: 'warning',
  message: 'Weather conditions deteriorating',
  severity: 'medium'
}, client => client.subscriptions.includes('alerts'));</code></pre>
                
                <h5>Parameters</h5>
                
                <table class="table table-striped param-table">
                    <thead>
                        <tr>
                            <th>Parameter</th>
                            <th>Type</th>
                            <th>Description</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="param-name">messageType</td>
                            <td>String</td>
                            <td>Type of message being sent</td>
                        </tr>
                        <tr>
                            <td class="param-name">data</td>
                            <td>Object</td>
                            <td>Message data to send</td>
                        </tr>
                        <tr>
                            <td class="param-name">filter</td>
                            <td>Function</td>
                            <td>Optional filter function to determine which clients receive the message</td>
                        </tr>
                    </tbody>
                </table>
                
                <div class="method-heading" id="method-onMessage">
                    <h4>onMessage(messageType, callback)</h4>
                </div>
                
                <p>Registers a callback to handle messages of a specific type.</p>
                
                <pre><code class="javascript">wsService.onMessage('command', (message, client) => {
  console.log(`Received command from client ${client.id}:`, message);
  // Process the command
  executeCommand(message.command, message.parameters);
});</code></pre>
                
                <h5>Parameters</h5>
                
                <table class="table table-striped param-table">
                    <thead>
                        <tr>
                            <th>Parameter</th>
                            <th>Type</th>
                            <th>Description</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="param-name">messageType</td>
                            <td>String</td>
                            <td>Type of message to handle</td>
                        </tr>
                        <tr>
                            <td class="param-name">callback</td>
                            <td>Function</td>
                            <td>Callback function to execute when a message of the specified type is received</td>
                        </tr>
                    </tbody>
                </table>
                
                <h5>Returns</h5>
                
                <ul class="list-group mb-4">
                    <li class="list-group-item">
                        <strong>String:</strong> Handler ID that can be used to remove the handler
                    </li>
                </ul>
                
                <div class="method-heading" id="method-offMessage">
                    <h4>offMessage(handlerId)</h4>
                </div>
                
                <p>Removes a message handler.</p>
                
                <pre><code class="javascript">wsService.offMessage(handlerId);</code></pre>
                
                <h5>Parameters</h5>
                
                <table class="table table-striped param-table">
                    <thead>
                        <tr>
                            <th>Parameter</th>
                            <th>Type</th>
                            <th>Description</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="param-name">handlerId</td>
                            <td>String</td>
                            <td>Handler ID returned by onMessage()</td>
                        </tr>
                    </tbody>
                </table>
                
                <div class="method-heading" id="method-onConnection">
                    <h4>onConnection(callback)</h4>
                </div>
                
                <p>Registers a callback to be called when a client connects (server mode only).</p>
                
                <pre><code class="javascript">wsService.onConnection((client) => {
  console.log(`Client connected: ${client.id}`);
  
  // Initialize client-specific state
  client.subscriptions = ['telemetry'];
  client.authenticated = false;
  
  // Send welcome message
  wsService.sendMessage(client, 'system', {
    message: 'Welcome to Safeguard WebSocket Service',
    timestamp: new Date().toISOString()
  });
});</code></pre>
                
                <h5>Parameters</h5>
                
                <table class="table table-striped param-table">
                    <thead>
                        <tr>
                            <th>Parameter</th>
                            <th>Type</th>
                            <th>Description</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="param-name">callback</td>
                            <td>Function</td>
                            <td>Callback function to execute when a client connects</td>
                        </tr>
                    </tbody>
                </table>
                
                <div class="method-heading" id="method-onDisconnection">
                    <h4>onDisconnection(callback)</h4>
                </div>
                
                <p>Registers a callback to be called when a client disconnects (server mode only).</p>
                
                <pre><code class="javascript">wsService.onDisconnection((client) => {
  console.log(`Client disconnected: ${client.id}`);
  
  // Clean up client-specific resources
  cleanupClientResources(client.id);
});</code></pre>
                
                <h5>Parameters</h5>
                
                <table class="table table-striped param-table">
                    <thead>
                        <tr>
                            <th>Parameter</th>
                            <th>Type</th>
                            <th>Description</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="param-name">callback</td>
                            <td>Function</td>
                            <td>Callback function to execute when a client disconnects</td>
                        </tr>
                    </tbody>
                </table>
                
                <div class="method-heading" id="method-getClientCount">
                    <h4>getClientCount()</h4>
                </div>
                
                <p>Gets the number of connected clients (server mode only).</p>
                
                <pre><code class="javascript">const count = wsService.getClientCount();</code></pre>
                
                <h5>Returns</h5>
                
                <ul class="list-group mb-4">
                    <li class="list-group-item">
                        <strong>Number:</strong> Number of connected clients
                    </li>
                </ul>
                
                <div class="method-heading" id="method-isConnected">
                    <h4>isConnected()</h4>
                </div>
                
                <p>Checks if the service is connected to the server (client mode) or if the server is running (server mode).</p>
                
                <pre><code class="javascript">const connected = wsService.isConnected();</code></pre>
                
                <h5>Returns</h5>
                
                <ul class="list-group mb-4">
                    <li class="list-group-item">
                        <strong>Boolean:</strong> True if connected/running, false otherwise
                    </li>
                </ul>
                
                <h2 id="message-format">Message Format</h2>
                
                <p>Messages sent through the WebSocket service follow a standardized format:</p>
                
                <div class="card mb-4">
                    <div class="card-header">
                        Message Format
                    </div>
                    <div class="card-body">
                        <pre><code class="javascript">{
  // Message metadata
  "id": "msg-123456789", // Unique message ID
  "type": "telemetry", // Message type
  "timestamp": "2025-09-14T12:05:30.000Z", // Time the message was created
  
  // Message data (varies by type)
  "data": {
    "position": {
      "lat": 47.123,
      "lng": -122.456,
      "alt": 100
    },
    "heading": 90,
    "speed": 5.5,
    "batteryLevel": 75
  }
}</code></pre>
                    </div>
                </div>
                
                <h2 id="standard-message-types">Standard Message Types</h2>
                
                <p>The WebSocket service defines several standard message types:</p>
                
                <div class="table-responsive">
                    <table class="table table-bordered">
                        <thead class="thead-light">
                            <tr>
                                <th>Message Type</th>
                                <th>Direction</th>
                                <th>Description</th>
                                <th>Example Data</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>system</td>
                                <td>Both</td>
                                <td>System-level messages like connection status, errors, etc.</td>
                                <td><code>{ message: "Connection established", status: "connected" }</code></td>
                            </tr>
                            <tr>
                                <td>auth</td>
                                <td>Both</td>
                                <td>Authentication and authorization messages</td>
                                <td><code>{ token: "jwt-token", expiresAt: "2025-09-14T14:05:30.000Z" }</code></td>
                            </tr>
                            <tr>
                                <td>telemetry</td>
                                <td>Server to Client</td>
                                <td>Vehicle telemetry data</td>
                                <td><code>{ position: { lat: 47.123, lng: -122.456 }, speed: 5.5 }</code></td>
                            </tr>
                            <tr>
                                <td>command</td>
                                <td>Client to Server</td>
                                <td>Commands to control a vehicle</td>
                                <td><code>{ command: "move", parameters: { heading: 90, speed: 5 } }</code></td>
                            </tr>
                            <tr>
                                <td>alert</td>
                                <td>Server to Client</td>
                                <td>Alerts and notifications</td>
                                <td><code>{ type: "warning", message: "Low battery", severity: "medium" }</code></td>
                            </tr>
                            <tr>
                                <td>subscription</td>
                                <td>Client to Server</td>
                                <td>Subscribe/unsubscribe to data streams</td>
                                <td><code>{ action: "subscribe", channels: ["telemetry", "alerts"] }</code></td>
                            </tr>
                            <tr>
                                <td>heartbeat</td>
                                <td>Both</td>
                                <td>Connection heartbeat to keep the connection alive</td>
                                <td><code>{ timestamp: "2025-09-14T12:05:30.000Z" }</code></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                
                <h2 id="usage-examples">Usage Examples</h2>
                
                <div class="card mb-4">
                    <div class="card-header">
                        Server Mode Example
                    </div>
                    <div class="card-body">
                        <pre><code class="javascript">// Import the module
const { WebSocketService } = require('./WebSocketService');

// Create a WebSocket server
const wss = new WebSocketService({
  port: 8080,
  path: '/safeguard',
  mode: 'server',
  secure: true,
  ssl: {
    key: fs.readFileSync('server-key.pem'),
    cert: fs.readFileSync('server-cert.pem')
  }
});

// Handle client connections
wss.onConnection((client) => {
  console.log(`New client connected: ${client.id}`);
  
  // Store client-specific data
  client.subscriptions = [];
  client.authenticated = false;
  
  // Send welcome message
  wss.sendMessage(client, 'system', {
    message: 'Welcome to Safeguard WebSocket Service',
    timestamp: new Date().toISOString()
  });
});

// Handle client disconnections
wss.onDisconnection((client) => {
  console.log(`Client disconnected: ${client.id}`);
});

// Handle authentication messages
wss.onMessage('auth', (message, client) => {
  // Validate the authentication token
  validateToken(message.data.token)
    .then(user => {
      client.authenticated = true;
      client.user = user;
      
      wss.sendMessage(client, 'auth', {
        status: 'authenticated',
        user: {
          id: user.id,
          name: user.name,
          role: user.role
        }
      });
      
      console.log(`Client ${client.id} authenticated as ${user.name}`);
    })
    .catch(error => {
      wss.sendMessage(client, 'auth', {
        status: 'error',
        message: 'Authentication failed',
        error: error.message
      });
    });
});

// Handle subscription messages
wss.onMessage('subscription', (message, client) => {
  if (!client.authenticated) {
    wss.sendMessage(client, 'system', {
      status: 'error',
      message: 'Authentication required'
    });
    return;
  }
  
  const { action, channels } = message.data;
  
  if (action === 'subscribe') {
    // Add channels to client's subscriptions
    channels.forEach(channel => {
      if (!client.subscriptions.includes(channel)) {
        client.subscriptions.push(channel);
      }
    });
    
    wss.sendMessage(client, 'subscription', {
      status: 'subscribed',
      channels: client.subscriptions
    });
  } else if (action === 'unsubscribe') {
    // Remove channels from client's subscriptions
    channels.forEach(channel => {
      const index = client.subscriptions.indexOf(channel);
      if (index !== -1) {
        client.subscriptions.splice(index, 1);
      }
    });
    
    wss.sendMessage(client, 'subscription', {
      status: 'unsubscribed',
      channels: client.subscriptions
    });
  }
});

// Handle command messages
wss.onMessage('command', (message, client) => {
  if (!client.authenticated) {
    wss.sendMessage(client, 'system', {
      status: 'error',
      message: 'Authentication required'
    });
    return;
  }
  
  const { command, parameters } = message.data;
  
  console.log(`Received command from client ${client.id}: ${command}`);
  
  // Process the command
  executeCommand(command, parameters)
    .then(result => {
      wss.sendMessage(client, 'command', {
        status: 'success',
        command,
        result
      });
    })
    .catch(error => {
      wss.sendMessage(client, 'command', {
        status: 'error',
        command,
        error: error.message
      });
    });
});

// Start the WebSocket server
wss.start()
  .then(() => {
    console.log(`WebSocket server started on port ${wss.options.port}`);
  })
  .catch(error => {
    console.error('Failed to start WebSocket server:', error);
  });

// Simulate sending telemetry data to subscribed clients
setInterval(() => {
  const telemetry = generateTelemetryData();
  
  // Broadcast to all clients who are subscribed to telemetry
  wss.broadcast('telemetry', telemetry, client => 
    client.authenticated && client.subscriptions.includes('telemetry')
  );
}, 1000); // Send telemetry every second

// Helper functions (implementation details omitted)
function validateToken(token) { /* ... */ }
function executeCommand(command, parameters) { /* ... */ }
function generateTelemetryData() { /* ... */ }</code></pre>
                    </div>
                </div>
                
                <div class="card mb-4">
                    <div class="card-header">
                        Client Mode Example
                    </div>
                    <div class="card-body">
                        <pre><code class="javascript">// Import the module
const { WebSocketService } = require('./WebSocketService');

// Create a WebSocket client
const wsClient = new WebSocketService({
  host: 'safeguard-server.example.com',
  port: 8080,
  path: '/safeguard',
  mode: 'client',
  secure: true,
  reconnectAttempts: 10
});

// Handle system messages
wsClient.onMessage('system', (message) => {
  console.log(`System message: ${message.data.message}`);
});

// Handle authentication responses
wsClient.onMessage('auth', (message) => {
  if (message.data.status === 'authenticated') {
    console.log(`Authenticated as ${message.data.user.name}`);
    
    // Subscribe to data channels after authentication
    wsClient.sendMessage(null, 'subscription', {
      action: 'subscribe',
      channels: ['telemetry', 'alerts']
    });
  } else {
    console.error(`Authentication failed: ${message.data.message}`);
  }
});

// Handle telemetry data
wsClient.onMessage('telemetry', (message) => {
  const telemetry = message.data;
  
  // Process telemetry data
  updateDashboard(telemetry);
  
  // Check for critical conditions
  if (telemetry.batteryLevel < 20) {
    displayWarning('Low battery level: ' + telemetry.batteryLevel + '%');
  }
});

// Handle alerts
wsClient.onMessage('alert', (message) => {
  const alert = message.data;
  
  // Display the alert based on severity
  switch (alert.severity) {
    case 'critical':
      displayCriticalAlert(alert.message);
      playAlertSound();
      break;
    case 'high':
      displayHighAlert(alert.message);
      break;
    case 'medium':
      displayMediumAlert(alert.message);
      break;
    case 'low':
      displayLowAlert(alert.message);
      break;
  }
});

// Start the WebSocket client
wsClient.start()
  .then(() => {
    console.log('Connected to WebSocket server');
    
    // Authenticate after connection
    wsClient.sendMessage(null, 'auth', {
      token: getAuthToken()
    });
  })
  .catch(error => {
    console.error('Failed to connect to WebSocket server:', error);
  });

// Send a command to the server
function sendCommand(command, parameters) {
  wsClient.sendMessage(null, 'command', {
    command,
    parameters
  });
}

// Helper functions (implementation details omitted)
function getAuthToken() { /* ... */ }
function updateDashboard(telemetry) { /* ... */ }
function displayWarning(message) { /* ... */ }
function displayCriticalAlert(message) { /* ... */ }
function displayHighAlert(message) { /* ... */ }
function displayMediumAlert(message) { /* ... */ }
function displayLowAlert(message) { /* ... */ }
function playAlertSound() { /* ... */ }</code></pre>
                    </div>
                </div>
                
                <h2 id="security-considerations">Security Considerations</h2>
                
                <p>When using the WebSocketService, consider the following security best practices:</p>
                
                <div class="card mb-4">
                    <div class="card-body">
                        <ul>
                            <li><strong>Always use secure WebSockets (WSS)</strong> in production environments by setting the <code>secure</code> option to <code>true</code> and providing SSL certificates.</li>
                            <li><strong>Implement proper authentication</strong> before allowing clients to send commands or receive sensitive data.</li>
                            <li><strong>Validate all incoming messages</strong> to prevent injection attacks and ensure data integrity.</li>
                            <li><strong>Use message encryption</strong> for sensitive data, even when using WSS.</li>
                            <li><strong>Implement rate limiting</strong> to prevent denial-of-service attacks.</li>
                            <li><strong>Monitor connection patterns</strong> and implement anomaly detection to identify potential security threats.</li>
                            <li><strong>Regularly rotate authentication tokens</strong> and implement token expiration.</li>
                            <li><strong>Limit the information exposed</strong> in error messages to prevent information leakage.</li>
                        </ul>
                    </div>
                </div>
            </div>
            
            <!-- Table of Contents -->
            <div class="col-md-2">
                <div id="toc" class="toc">
                    <div class="card">
                        <div class="card-header">
                            On this page
                        </div>
                        <div class="card-body p-0">
                            <ul class="nav flex-column" id="toc-list">
                                <!-- TOC items will be inserted here by JavaScript -->
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-white mt-5 p-4">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h5>Safeguard Robot Swarm Documentation</h5>
                    <p>Comprehensive documentation for the Safeguard Robot Swarm Prediction and Management system.</p>
                </div>
                <div class="col-md-6 text-md-right">
                    <p>&copy; 2025 Autonomy Association International, Inc.</p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <!-- Custom JS for deep linking and TOC -->
    <script>
        $(document).ready(function() {
            // Handle deep linking
            if (window.location.hash) {
                const hash = window.location.hash;
                setTimeout(function() {
                    $('html, body').animate({
                        scrollTop: $(hash).offset().top - 70
                    }, 600);
                    
                    // Highlight the linked element
                    $(hash).addClass('highlight');
                    setTimeout(function() {
                        $(hash).removeClass('highlight');
                    }, 2000);
                }, 300);
            }
            
            // Generate table of contents
            const tocList = $('#toc-list');
            const headings = $('#content h2, #content h3');
            
            headings.each(function() {
                const id = $(this).attr('id') || $(this).text().toLowerCase().replace(/[^a-z0-9]+/g, '-');
                $(this).attr('id', id);
                
                const link = $('<a class="nav-link"></a>')
                    .attr('href', '#' + id)
                    .text($(this).text());
                
                let item;
                if ($(this).is('h2')) {
                    item = $('<li class="nav-item"></li>').append(link);
                    tocList.append(item);
                } else {
                    item = $('<li class="nav-item ml-3"></li>').append(link);
                    tocList.append(item);
                }
            });
        });
    </script>
</body>
</html>
```


I've now created detailed documentation for four key files in the project:

1. SafeguardBase.js (Core System)
2. PeopleSwarmPredictor.js (Predictor)
3. AgentProtocol.js (Protocol)
4. WebSocketService.js (Service)

Each file's documentation follows a consistent structure with:
- File name in a header comment
- Comprehensive explanation of purpose and functionality
- Detailed method documentation with parameters and return values
- Code examples showing practical usage
- Tables for parameters, properties, and options
- Bootstrap 4 styling with responsive design
- Deep linking and table of contents

The index file organizes all files by category, making it easy to find documentation for specific components of the system.

To complete the documentation for all files in your list, I would continue creating similar HTML files for each remaining JavaScript file, following the same pattern and structure. Each file would have its own dedicated documentation page, and all would be linked from the main index.

Would you like me to continue documenting specific files from your list, or would you prefer I focus on creating category index files like `/docs/protocols/index.html` or `/docs/services/index.html`?