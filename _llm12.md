I'll complete the requested documentation and update all the necessary files for you.

## 1. First, let's create the Drone Swarm Load Balancer plugin page:

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Drone Swarm Load Balancer - IQSMS Plugin System</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="../css/styles.css">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.1/css/all.css">
</head>
<body>
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
      <a class="navbar-brand" href="../index.html">
        <img src="../images/logo.png" alt="IQSMS Plugin System" height="40">
      </a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item">
            <a class="nav-link" href="../index.html">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="../plugin-development.html">Development</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="../api-reference.html">API Reference</a>
          </li>
          <li class="nav-item dropdown active">
            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown">
              Plugins
            </a>
            <div class="dropdown-menu">
              <a class="dropdown-item" href="cloudflare-api.html">Cloudflare API</a>
              <a class="dropdown-item" href="system-info.html">System Info</a>
              <a class="dropdown-item active" href="drone-swarm-loadbalancer.html">Drone Swarm LB</a>
              <a class="dropdown-item" href="database-connector.html">Database Connector</a>
              <a class="dropdown-item" href="authentication-service.html">Authentication Service</a>
              <div class="dropdown-divider"></div>
              <a class="dropdown-item" href="index.html">All Plugins</a>
            </div>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <div class="container my-5">
    <div class="row">
      <div class="col-lg-3">
        <div class="sidebar">
          <h5>Contents</h5>
          <nav class="nav flex-column">
            <a class="nav-link" href="#overview">Overview</a>
            <a class="nav-link" href="#features">Key Features</a>
            <a class="nav-link" href="#installation">Installation</a>
            <a class="nav-link" href="#configuration">Configuration</a>
            <a class="nav-link" href="#task-management">Task Management</a>
            <a class="nav-link" href="#drone-management">Drone Management</a>
            <a class="nav-link" href="#analytics">Analytics</a>
            <a class="nav-link" href="#examples">Examples</a>
            <a class="nav-link" href="#api-reference">API Reference</a>
          </nav>
        </div>
      </div>
      <div class="col-lg-9">
        <div class="plugin-header d-flex align-items-center">
          <i class="fas fa-drone fa-3x text-primary mr-4"></i>
          <div>
            <h1>Drone Swarm Load Balancer</h1>
            <p class="lead mb-0">Advanced task distribution for drone swarms with intelligent scheduling and self-healing</p>
          </div>
        </div>

        <div class="plugin-info mb-4">
          <div class="plugin-info-item">
            <i class="fas fa-code-branch"></i>
            <span>Version: 2.0.0</span>
          </div>
          <div class="plugin-info-item">
            <i class="fas fa-user"></i>
            <span>Publisher: Autonomy Association International</span>
          </div>
          <div class="plugin-info-item">
            <i class="fas fa-coins"></i>
            <span>Cost: 100 tokens</span>
          </div>
        </div>

        <div class="alert alert-primary">
          <i class="fas fa-info-circle mr-2"></i>
          This plugin provides advanced load balancing for drone swarms, with intelligent task scheduling, adaptive resource management, and comprehensive analytics.
        </div>

        <section id="overview">
          <h2>Overview</h2>
          <p>The Drone Swarm Load Balancer plugin provides sophisticated task distribution for managing large fleets of autonomous drones. It intelligently assigns tasks to the most suitable drones based on multiple factors including battery level, processing capabilities, geographic location, and workload.</p>
          
          <p>With the enhanced version 2.0, this plugin now features advanced capabilities like predictive analytics, self-healing functionality, and improved performance for large-scale operations. The system is designed to optimize resource utilization while ensuring critical tasks are completed efficiently and reliably.</p>
        </section>

        <section id="features" class="mt-5">
          <h2>Key Features</h2>
          
          <div class="row">
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title"><i class="fas fa-brain text-primary mr-2"></i>Intelligent Task Distribution</h5>
                  <ul class="card-text">
                    <li>Multi-factor drone selection algorithm</li>
                    <li>Geographic clustering for large swarms</li>
                    <li>Priority-based task queueing</li>
                    <li>Real-time capacity calculation</li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title"><i class="fas fa-calendar-alt text-primary mr-2"></i>Advanced Scheduling</h5>
                  <ul class="card-text">
                    <li>Predictive task duration estimation</li>
                    <li>Future task scheduling</li>
                    <li>Completion time prediction</li>
                    <li>Multi-priority task queues</li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
          
          <div class="row">
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title"><i class="fas fa-heartbeat text-primary mr-2"></i>Self-Healing System</h5>
                  <ul class="card-text">
                    <li>Automatic issue detection and resolution</li>
                    <li>Task timeout recovery</li>
                    <li>Database connectivity monitoring</li>
                    <li>System health grading</li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title"><i class="fas fa-chart-bar text-primary mr-2"></i>Comprehensive Analytics</h5>
                  <ul class="card-text">
                    <li>Detailed performance metrics</li>
                    <li>Drone efficiency tracking</li>
                    <li>Task completion statistics</li>
                    <li>Historical trend analysis</li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </section>

        <section id="installation" class="mt-5">
          <h2>Installation</h2>
          <p>To use the Drone Swarm Load Balancer plugin, you'll need to:</p>
          <ol>
            <li>Install the plugin in your IQSMS Plugin System</li>
            <li>Configure the plugin based on your requirements</li>
            <li>Set up a MongoDB database for data storage</li>
          </ol>

          <h4>Prerequisites</h4>
          <ul>
            <li>Node.js 14.x or higher</li>
            <li>IQSMS Plugin System core</li>
            <li>MongoDB 4.4 or higher</li>
          </ul>

          <h4>Installing the Plugin</h4>
          <pre><code class="language-javascript">const pluginManager = require('./path/to/PluginManager');
await pluginManager.installPlugin('drone-swarm-loadbalancer');</code></pre>
          
          <p>Or install directly from a URL:</p>
          <pre><code class="language-javascript">await pluginManager.pluginLoader.installPluginFromUrl('https://github.com/autonomy-association/drone-swarm-loadbalancer.git');</code></pre>
        </section>

        <section id="configuration" class="mt-5">
          <h2>Configuration</h2>
          <p>The plugin provides several configuration options:</p>

          <table class="table">
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
                <td>maxCpuLoad</td>
                <td>number</td>
                <td>0.8</td>
                <td>Maximum CPU load percentage (0-1)</td>
              </tr>
              <tr>
                <td>maxMemoryUsage</td>
                <td>number</td>
                <td>0.8</td>
                <td>Maximum memory usage percentage (0-1)</td>
              </tr>
              <tr>
                <td>minBatteryLevel</td>
                <td>number</td>
                <td>30</td>
                <td>Minimum drone battery level for tasks (%)</td>
              </tr>
              <tr>
                <td>criticalBatteryLevel</td>
                <td>number</td>
                <td>15</td>
                <td>Critical battery level below which drones are excluded (%)</td>
              </tr>
              <tr>
                <td>batteryWeightFactor</td>
                <td>number</td>
                <td>0.4</td>
                <td>Weight factor for battery level in capacity calculation</td>
              </tr>
              <tr>
                <td>processingPowerWeightFactor</td>
                <td>number</td>
                <td>0.4</td>
                <td>Weight factor for processing power in capacity calculation</td>
              </tr>
              <tr>
                <td>distanceWeightFactor</td>
                <td>number</td>
                <td>0.2</td>
                <td>Weight factor for distance to task in node selection</td>
              </tr>
              <tr>
                <td>enableSelfHealing</td>
                <td>boolean</td>
                <td>true</td>
                <td>Enable self-healing capabilities</td>
              </tr>
            </tbody>
          </table>

          <h4>Configuration Example</h4>
          <pre><code class="language-javascript">const config = {
  minBatteryLevel: 25, // Minimum 25% battery for regular tasks
  criticalBatteryLevel: 10, // Critical level at 10%
  batteryWeightFactor: 0.5, // Prioritize battery level more
  processingPowerWeightFactor: 0.3, // Moderate importance for processing power
  distanceWeightFactor: 0.2, // Less importance for distance
  enableSelfHealing: true, // Enable self-healing capabilities
  db: mongoDbConnection // Your MongoDB connection
};</code></pre>
        </section>

        <section id="task-management" class="mt-5">
          <h2>Task Management</h2>
          <p>The Drone Swarm Load Balancer handles various aspects of task management:</p>

          <div class="api-method">
            <h3>submitTask(task)</h3>
            <p>Submits a task to the drone swarm for execution.</p>
            
            <h4>Parameters</h4>
            <table class="table">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Type</th>
                  <th>Required</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>task</td>
                  <td>object</td>
                  <td>Yes</td>
                  <td>Task information</td>
                </tr>
                <tr>
                  <td>task.type</td>
                  <td>string</td>
                  <td>Yes</td>
                  <td>Task type (e.g., 'surveillance', 'delivery')</td>
                </tr>
                <tr>
                  <td>task.data</td>
                  <td>object</td>
                  <td>No</td>
                  <td>Task-specific data</td>
                </tr>
                <tr>
                  <td>task.location</td>
                  <td>object</td>
                  <td>No</td>
                  <td>Geographic location for the task</td>
                </tr>
                <tr>
                  <td>task.priority</td>
                  <td>number</td>
                  <td>No</td>
                  <td>Task priority (higher = more important)</td>
                </tr>
                <tr>
                  <td>task.requiresImmediateResponse</td>
                  <td>boolean</td>
                  <td>No</td>
                  <td>Whether task requires immediate response</td>
                </tr>
                <tr>
                  <td>task.scheduledTime</td>
                  <td>Date</td>
                  <td>No</td>
                  <td>Scheduled time for future tasks</td>
                </tr>
              </tbody>
            </table>
            
            <h4>Returns</h4>
            <pre><code class="language-javascript">{
  taskId: "task_1631234567890_abc123",
  status: "queued", // or "dispatched" or "scheduled"
  queuePosition: 2, // If queued
  droneId: "drone-456", // If dispatched
  estimatedCompletionTime: "2025-09-14T12:30:00Z" // Estimated completion time
}</code></pre>
            
            <h4>Example</h4>
            <pre><code class="language-javascript">const task = {
  type: "surveillance",
  data: {
    area: {
      center: { lat: 37.7749, lng: -122.4194 },
      radius: 1000 // meters
    },
    duration: 300, // seconds
    resolution: "high"
  },
  location: { lat: 37.7749, lng: -122.4194 },
  priority: 5,
  requiresImmediateResponse: true
};

const result = await droneSwarmLoadBalancer.submitTask(task);
console.log(`Task ${result.taskId} ${result.status}`);</code></pre>
          </div>

          <div class="api-method mt-5">
            <h3>getTaskStatus(taskId)</h3>
            <p>Gets the current status of a task.</p>
            
            <h4>Parameters</h4>
            <table class="table">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Type</th>
                  <th>Required</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>taskId</td>
                  <td>string</td>
                  <td>Yes</td>
                  <td>Task ID</td>
                </tr>
              </tbody>
            </table>
            
            <h4>Returns</h4>
            <pre><code class="language-javascript">{
  taskId: "task_1631234567890_abc123",
  type: "surveillance",
  data: { /* task data */ },
  location: { lat: 37.7749, lng: -122.4194 },
  priority: 5,
  status: "dispatched", // pending, dispatched, completed, failed
  submittedAt: "2025-09-14T12:00:00Z",
  dispatchedAt: "2025-09-14T12:00:05Z",
  droneId: "drone-456",
  estimatedCompletionTime: "2025-09-14T12:30:00Z"
}</code></pre>
          </div>
        </section>

        <section id="drone-management" class="mt-5">
          <h2>Drone Management</h2>
          <p>The Drone Swarm Load Balancer provides functions for managing drones in the swarm:</p>

          <div class="api-method">
            <h3>registerDrone(drone)</h3>
            <p>Registers a new drone with the swarm.</p>
            
            <h4>Parameters</h4>
            <table class="table">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Type</th>
                  <th>Required</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>drone</td>
                  <td>object</td>
                  <td>Yes</td>
                  <td>Drone information</td>
                </tr>
                <tr>
                  <td>drone.droneId</td>
                  <td>string</td>
                  <td>No</td>
                  <td>Drone ID (generated if not provided)</td>
                </tr>
                <tr>
                  <td>drone.name</td>
                  <td>string</td>
                  <td>No</td>
                  <td>Drone name</td>
                </tr>
                <tr>
                  <td>drone.type</td>
                  <td>string</td>
                  <td>No</td>
                  <td>Drone type (e.g., 'quadcopter')</td>
                </tr>
                <tr>
                  <td>drone.batteryLevel</td>
                  <td>number</td>
                  <td>No</td>
                  <td>Battery level percentage (0-100)</td>
                </tr>
                <tr>
                  <td>drone.position</td>
                  <td>object</td>
                  <td>No</td>
                  <td>Current geographic position</td>
                </tr>
                <tr>
                  <td>drone.processingPower</td>
                  <td>number</td>
                  <td>No</td>
                  <td>Processing power (0-100)</td>
                </tr>
                <tr>
                  <td>drone.capabilities</td>
                  <td>array</td>
                  <td>No</td>
                  <td>Array of drone capabilities</td>
                </tr>
              </tbody>
            </table>
            
            <h4>Returns</h4>
            <pre><code class="language-javascript">{
  droneId: "drone-123",
  status: "registered",
  registeredAt: "2025-09-14T12:00:00Z"
}</code></pre>
          </div>
        </section>

        <section id="analytics" class="mt-5">
          <h2>Analytics</h2>
          <p>The Drone Swarm Load Balancer provides comprehensive analytics capabilities:</p>

          <div class="api-method">
            <h3>getAnalytics(options)</h3>
            <p>Gets system analytics and performance metrics.</p>
            
            <h4>Parameters</h4>
            <table class="table">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Type</th>
                  <th>Required</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>options</td>
                  <td>object</td>
                  <td>No</td>
                  <td>Analytics options</td>
                </tr>
                <tr>
                  <td>options.startDate</td>
                  <td>Date</td>
                  <td>No</td>
                  <td>Start date for analytics (default: 24 hours ago)</td>
                </tr>
                <tr>
                  <td>options.endDate</td>
                  <td>Date</td>
                  <td>No</td>
                  <td>End date for analytics (default: now)</td>
                </tr>
              </tbody>
            </table>
            
            <h4>Returns</h4>
            <pre><code class="language-javascript">{
  period: {
    startDate: "2025-09-13T12:00:00Z",
    endDate: "2025-09-14T12:00:00Z",
    durationHours: 24
  },
  taskStats: [
    { _id: "completed", count: 156, avgPriority: 3.5 },
    { _id: "failed", count: 12, avgPriority: 4.1 },
    { _id: "pending", count: 8, avgPriority: 2.3 },
    { _id: "dispatched", count: 15, avgPriority: 6.2 }
  ],
  completionStats: {
    avgQueueTime: 12500, // milliseconds
    avgExecutionTime: 305000, // milliseconds
    avgTotalTime: 317500, // milliseconds
    minTotalTime: 85000, // milliseconds
    maxTotalTime: 1200000, // milliseconds
    count: 156
  },
  dronePerformance: [
    {
      droneId: "drone-123",
      tasksCompleted: 32,
      tasksFailed: 2,
      totalTasks: 34,
      successRate: 94.12
    }
    // More drones...
  ],
  systemEfficiency: {
    taskCompletionRate: 92.85, // percentage
    avgTasksPerHour: 7.2,
    currentQueueLength: 8,
    activeDrones: 12
  }
}</code></pre>
          </div>
        </section>

        <section id="examples" class="mt-5">
          <h2>Examples</h2>
          
          <div class="api-method">
            <h4>Emergency Response Scenario</h4>
            <pre><code class="language-javascript">// Submit high-priority search task
const searchTask = await droneSwarm.submitTask({
  type: 'search_and_rescue',
  data: {
    searchArea: {
      center: { lat: 34.0522, lng: -118.2437 },
      radius: 5000 // meters
    },
    searchPattern: 'grid',
    resolution: 'high'
  },
  location: { lat: 34.0522, lng: -118.2437 },
  priority: 10, // Highest priority
  requiresImmediateResponse: true
});

console.log(`Search task submitted with ID ${searchTask.taskId}`);
console.log(`Task status: ${searchTask.status}`);
if (searchTask.droneId) {
  console.log(`Assigned to drone: ${searchTask.droneId}`);
}</code></pre>
            
            <h4>Drone Fleet Management</h4>
            <pre><code class="language-javascript">// Register multiple drones
const drones = [
  { name: "Alpha", type: "quadcopter", batteryLevel: 100, position: { lat: 37.7749, lng: -122.4194 } },
  { name: "Beta", type: "hexacopter", batteryLevel: 90, position: { lat: 37.7750, lng: -122.4195 } },
  { name: "Gamma", type: "quadcopter", batteryLevel: 80, position: { lat: 37.7751, lng: -122.4196 } },
  { name: "Delta", type: "octocopter", batteryLevel: 95, position: { lat: 37.7752, lng: -122.4197 } }
];

for (const drone of drones) {
  await droneSwarm.registerDrone(drone);
}

// Get analytics after operations
const analytics = await droneSwarm.getAnalytics();
console.log('Task completion rate:', analytics.systemEfficiency.taskCompletionRate.toFixed(1) + '%');</code></pre>
          </div>
        </section>

        <section id="api-reference" class="mt-5">
          <h2>API Reference</h2>
          <p>Complete API reference for the Drone Swarm Load Balancer plugin:</p>
          
          <div class="accordion" id="apiAccordion">
            <div class="card">
              <div class="card-header" id="headingOne">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapseOne">
                    Task Management Methods
                  </button>
                </h2>
              </div>
              <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#apiAccordion">
                <div class="card-body">
                  <ul>
                    <li><code>submitTask(task)</code> - Submit a task to the drone swarm</li>
                    <li><code>getTaskStatus(taskId)</code> - Get the status of a specific task</li>
                    <li><code>getAllTasks(filter)</code> - Get all tasks matching a filter</li>
                    <li><code>processTaskResult(result)</code> - Process a task result from a drone</li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="card">
              <div class="card-header" id="headingTwo">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo">
                    Drone Management Methods
                  </button>
                </h2>
              </div>
              <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#apiAccordion">
                <div class="card-body">
                  <ul>
                    <li><code>registerDrone(drone)</code> - Register a new drone with the swarm</li>
                    <li><code>updateDroneStatus(droneId, status)</code> - Update drone status</li>
                    <li><code>getDroneInfo(droneId)</code> - Get information about a specific drone</li>
                    <li><code>getAllDrones(filter)</code> - Get all registered drones matching a filter</li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="card">
              <div class="card-header" id="headingThree">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseThree">
                    System Management Methods
                  </button>
                </h2>
              </div>
              <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#apiAccordion">
                <div class="card-body">
                  <ul>
                    <li><code>initialize()</code> - Initialize the load balancer</li>
                    <li><code>shutdown()</code> - Shutdown the load balancer</li>
                    <li><code>getStatus()</code> - Get the current system status</li>
                    <li><code>getAnalytics(options)</code> - Get system analytics</li>
                    <li><code>checkSystemHealth()</code> - Check system health</li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </section>

        <div class="alert alert-info mt-5">
          <h5><i class="fas fa-lightbulb mr-2"></i>Related Documentation</h5>
          <ul class="mb-0">
            <li><a href="../api-reference.html">API Reference</a> - Complete API documentation</li>
            <li><a href="../protocols/agent-protocol.html">Agent Protocol</a> - Protocol for agent-to-agent communication</li>
            <li><a href="../examples.html">Code Examples</a> - More usage examples</li>
            <li><a href="../troubleshooting.html">Troubleshooting Guide</a> - Solutions for common issues</li>
          </ul>
        </div>
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
          <p>Written by Greg Deeds, Autonomy Association International</p>
          <p><a href="mailto:support@autonomy.ai" class="text-white"><i class="fas fa-envelope mr-2"></i>Get Support</a></p>
        </div>
      </div>
    </div>
  </footer>

  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
```


## 2. Now let's create the Database Connector plugin page:

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Database Connector - IQSMS Plugin System</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="../css/styles.css">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.1/css/all.css">
</head>
<body>
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
      <a class="navbar-brand" href="../index.html">
        <img src="../images/logo.png" alt="IQSMS Plugin System" height="40">
      </a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item">
            <a class="nav-link" href="../index.html">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="../plugin-development.html">Development</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="../api-reference.html">API Reference</a>
          </li>
          <li class="nav-item dropdown active">
            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown">
              Plugins
            </a>
            <div class="dropdown-menu">
              <a class="dropdown-item" href="cloudflare-api.html">Cloudflare API</a>
              <a class="dropdown-item" href="system-info.html">System Info</a>
              <a class="dropdown-item" href="drone-swarm-loadbalancer.html">Drone Swarm LB</a>
              <a class="dropdown-item active" href="database-connector.html">Database Connector</a>
              <a class="dropdown-item" href="authentication-service.html">Authentication Service</a>
              <div class="dropdown-divider"></div>
              <a class="dropdown-item" href="index.html">All Plugins</a>
            </div>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <div class="container my-5">
    <div class="row">
      <div class="col-lg-3">
        <div class="sidebar">
          <h5>Contents</h5>
          <nav class="nav flex-column">
            <a class="nav-link" href="#overview">Overview</a>
            <a class="nav-link" href="#features">Key Features</a>
            <a class="nav-link" href="#installation">Installation</a>
            <a class="nav-link" href="#configuration">Configuration</a>
            <a class="nav-link" href="#database-types">Supported Databases</a>
            <a class="nav-link" href="#methods">API Methods</a>
            <a class="nav-link" href="#query-builder">Query Builder</a>
            <a class="nav-link" href="#examples">Examples</a>
            <a class="nav-link" href="#best-practices">Best Practices</a>
          </nav>
        </div>
      </div>
      <div class="col-lg-9">
        <div class="plugin-header d-flex align-items-center">
          <i class="fas fa-database fa-3x text-primary mr-4"></i>
          <div>
            <h1>Database Connector</h1>
            <p class="lead mb-0">Unified database interface for multiple database systems with powerful query capabilities</p>
          </div>
        </div>

        <div class="plugin-info mb-4">
          <div class="plugin-info-item">
            <i class="fas fa-code-branch"></i>
            <span>Version: 1.5.2</span>
          </div>
          <div class="plugin-info-item">
            <i class="fas fa-user"></i>
            <span>Publisher: Autonomy Association International</span>
          </div>
          <div class="plugin-info-item">
            <i class="fas fa-coins"></i>
            <span>Cost: 50 tokens</span>
          </div>
        </div>

        <div class="alert alert-primary">
          <i class="fas fa-info-circle mr-2"></i>
          This plugin provides a unified interface for connecting to and querying multiple database systems, including MongoDB, MySQL, PostgreSQL, and SQLite.
        </div>

        <section id="overview">
          <h2>Overview</h2>
          <p>The Database Connector plugin provides a standardized interface for working with various database systems. It allows you to connect to multiple database types using a consistent API, making it easy to switch between databases or work with multiple databases simultaneously.</p>
          
          <p>The plugin handles connection management, query building, transactions, and data mapping, allowing you to focus on your application logic instead of database-specific code.</p>
        </section>

        <section id="features" class="mt-5">
          <h2>Key Features</h2>
          
          <div class="row">
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title"><i class="fas fa-plug text-primary mr-2"></i>Multi-Database Support</h5>
                  <ul class="card-text">
                    <li>MongoDB integration</li>
                    <li>MySQL/MariaDB support</li>
                    <li>PostgreSQL compatibility</li>
                    <li>SQLite for local storage</li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title"><i class="fas fa-exchange-alt text-primary mr-2"></i>Unified API</h5>
                  <ul class="card-text">
                    <li>Consistent interface across databases</li>
                    <li>Database-agnostic query methods</li>
                    <li>Automatic data type conversion</li>
                    <li>Standardized error handling</li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
          
          <div class="row">
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title"><i class="fas fa-tools text-primary mr-2"></i>Advanced Query Features</h5>
                  <ul class="card-text">
                    <li>Fluent query builder</li>
                    <li>Transaction support</li>
                    <li>Pagination helpers</li>
                    <li>Aggregation functions</li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title"><i class="fas fa-shield-alt text-primary mr-2"></i>Security & Performance</h5>
                  <ul class="card-text">
                    <li>Connection pooling</li>
                    <li>Parameterized queries</li>
                    <li>SQL injection protection</li>
                    <li>Performance monitoring</li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </section>

        <section id="installation" class="mt-5">
          <h2>Installation</h2>
          <p>To use the Database Connector plugin, you'll need to:</p>
          <ol>
            <li>Install the plugin in your IQSMS Plugin System</li>
            <li>Install database drivers for the databases you want to use</li>
            <li>Configure your database connections</li>
          </ol>

          <h4>Prerequisites</h4>
          <ul>
            <li>Node.js 14.x or higher</li>
            <li>IQSMS Plugin System core</li>
            <li>Database drivers for your databases of choice</li>
          </ul>

          <h4>Installing Database Drivers</h4>
          <pre><code class="language-bash"># For MongoDB
npm install mongodb

# For MySQL
npm install mysql2

# For PostgreSQL
npm install pg pg-hstore

# For SQLite
npm install sqlite3</code></pre>

          <h4>Installing the Plugin</h4>
          <pre><code class="language-javascript">const pluginManager = require('./path/to/PluginManager');
await pluginManager.installPlugin('database-connector');</code></pre>
        </section>

        <section id="configuration" class="mt-5">
          <h2>Configuration</h2>
          <p>The plugin provides configuration options for each database type:</p>

          <h4>MongoDB Configuration</h4>
          <pre><code class="language-javascript">const mongoConfig = {
  type: 'mongodb',
  name: 'primaryMongo',
  url: 'mongodb://localhost:27017',
  database: 'myApp',
  options: {
    useNewUrlParser: true,
    useUnifiedTopology: true
  }
};</code></pre>

          <h4>MySQL Configuration</h4>
          <pre><code class="language-javascript">const mysqlConfig = {
  type: 'mysql',
  name: 'primaryMySQL',
  host: 'localhost',
  port: 3306,
  database: 'myApp',
  username: 'dbuser',
  password: 'dbpassword',
  options: {
    connectionLimit: 10,
    queueLimit: 0,
    waitForConnections: true
  }
};</code></pre>

          <h4>PostgreSQL Configuration</h4>
          <pre><code class="language-javascript">const postgresConfig = {
  type: 'postgres',
  name: 'primaryPostgres',
  host: 'localhost',
  port: 5432,
  database: 'myApp',
  username: 'dbuser',
  password: 'dbpassword',
  options: {
    max: 20, // Maximum pool size
    idleTimeoutMillis: 30000
  }
};</code></pre>

          <h4>SQLite Configuration</h4>
          <pre><code class="language-javascript">const sqliteConfig = {
  type: 'sqlite',
  name: 'localSQLite',
  file: './data/myApp.db',
  options: {
    verbose: true
  }
};</code></pre>

          <h4>Loading the Plugin with Configurations</h4>
          <pre><code class="language-javascript">await pluginManager.loadPlugin('database-connector', {
  connections: [
    mongoConfig,
    mysqlConfig,
    postgresConfig,
    sqliteConfig
  ],
  defaultConnection: 'primaryMongo'
});</code></pre>
        </section>

        <section id="database-types" class="mt-5">
          <h2>Supported Databases</h2>
          <p>The Database Connector plugin supports the following database systems:</p>

          <div class="row">
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title">MongoDB</h5>
                  <p class="card-text">NoSQL document database with JSON-like documents and flexible schema.</p>
                  <h6>Supported Features:</h6>
                  <ul>
                    <li>CRUD operations</li>
                    <li>Aggregation pipelines</li>
                    <li>Geospatial queries</li>
                    <li>Transactions (MongoDB 4.0+)</li>
                    <li>Change streams</li>
                  </ul>
                </div>
              </div>
            </div>
            
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title">MySQL/MariaDB</h5>
                  <p class="card-text">Popular relational database system with strong ACID properties.</p>
                  <h6>Supported Features:</h6>
                  <ul>
                    <li>CRUD operations</li>
                    <li>Complex joins</li>
                    <li>Transactions</li>
                    <li>Stored procedures</li>
                    <li>Prepared statements</li>
                  </ul>
                </div>
              </div>
            </div>
            
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title">PostgreSQL</h5>
                  <p class="card-text">Advanced open-source relational database with extensibility.</p>
                  <h6>Supported Features:</h6>
                  <ul>
                    <li>CRUD operations</li>
                    <li>Complex joins</li>
                    <li>Transactions</li>
                    <li>JSON/JSONB support</li>
                    <li>Full-text search</li>
                    <li>Geospatial operations</li>
                  </ul>
                </div>
              </div>
            </div>
            
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title">SQLite</h5>
                  <p class="card-text">Self-contained, serverless, zero-configuration database engine.</p>
                  <h6>Supported Features:</h6>
                  <ul>
                    <li>CRUD operations</li>
                    <li>Transactions</li>
                    <li>In-memory databases</li>
                    <li>Full-text search (with extension)</li>
                    <li>JSON support (partial)</li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </section>

        <section id="methods" class="mt-5">
          <h2>API Methods</h2>
          <p>The Database Connector provides a consistent API across all supported databases:</p>

          <div class="api-method">
            <h3>connect(connectionName)</h3>
            <p>Establishes a connection to the specified database or returns an existing connection.</p>
            
            <h4>Parameters</h4>
            <table class="table">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Type</th>
                  <th>Required</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>connectionName</td>
                  <td>string</td>
                  <td>No</td>
                  <td>Name of the connection to use. If not specified, uses the default connection.</td>
                </tr>
              </tbody>
            </table>
            
            <h4>Returns</h4>
            <p>A Promise that resolves to a database connection instance.</p>
            
            <h4>Example</h4>
            <pre><code class="language-javascript">const db = await databaseConnector.connect('primaryMongo');</code></pre>
          </div>

          <div class="api-method mt-4">
            <h3>query(connectionName, queryOptions)</h3>
            <p>Executes a query against the specified database.</p>
            
            <h4>Parameters</h4>
            <table class="table">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Type</th>
                  <th>Required</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>connectionName</td>
                  <td>string</td>
                  <td>No</td>
                  <td>Name of the connection to use. If not specified, uses the default connection.</td>
                </tr>
                <tr>
                  <td>queryOptions</td>
                  <td>object</td>
                  <td>Yes</td>
                  <td>Query options including collection/table, operation, conditions, etc.</td>
                </tr>
              </tbody>
            </table>
            
            <h4>Returns</h4>
            <p>A Promise that resolves to the query result.</p>
            
            <h4>Example</h4>
            <pre><code class="language-javascript">const users = await databaseConnector.query('primaryMongo', {
  collection: 'users',
  operation: 'find',
  conditions: { age: { $gt: 18 } },
  sort: { lastName: 1 },
  limit: 10
});</code></pre>
          </div>

          <div class="api-method mt-4">
            <h3>transaction(connectionName, operations)</h3>
            <p>Executes multiple operations in a transaction.</p>
            
            <h4>Parameters</h4>
            <table class="table">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Type</th>
                  <th>Required</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>connectionName</td>
                  <td>string</td>
                  <td>No</td>
                  <td>Name of the connection to use. If not specified, uses the default connection.</td>
                </tr>
                <tr>
                  <td>operations</td>
                  <td>function</td>
                  <td>Yes</td>
                  <td>Function that receives a transaction object and performs operations.</td>
                </tr>
              </tbody>
            </table>
            
            <h4>Returns</h4>
            <p>A Promise that resolves to the transaction result.</p>
            
            <h4>Example</h4>
            <pre><code class="language-javascript">const result = await databaseConnector.transaction('primaryMySQL', async (tx) => {
  // Deduct amount from account 1
  await tx.query({
    table: 'accounts',
    operation: 'update',
    conditions: { id: 1 },
    values: { balance: { $decrement: 100 } }
  });
  
  // Add amount to account 2
  await tx.query({
    table: 'accounts',
    operation: 'update',
    conditions: { id: 2 },
    values: { balance: { $increment: 100 } }
  });
  
  // Record the transaction
  await tx.query({
    table: 'transfers',
    operation: 'insert',
    values: {
      fromAccount: 1,
      toAccount: 2,
      amount: 100,
      date: new Date()
    }
  });
  
  return { success: true };
});</code></pre>
          </div>
        </section>

        <section id="query-builder" class="mt-5">
          <h2>Query Builder</h2>
          <p>The Database Connector includes a fluent query builder for constructing complex queries:</p>

          <div class="api-method">
            <h4>Simple Query Example</h4>
            <pre><code class="language-javascript">const queryBuilder = databaseConnector.createQueryBuilder('primaryPostgres');

const users = await queryBuilder
  .from('users')
  .select(['id', 'firstName', 'lastName', 'email'])
  .where('age', '>', 18)
  .and('status', '=', 'active')
  .orderBy('lastName', 'ASC')
  .limit(10)
  .execute();</code></pre>

            <h4>Complex Query Example</h4>
            <pre><code class="language-javascript">const orders = await queryBuilder
  .from('orders')
  .select([
    'orders.id',
    'orders.orderDate',
    'orders.total',
    'customers.firstName',
    'customers.lastName'
  ])
  .join('customers', 'customers.id', '=', 'orders.customerId')
  .leftJoin('shipments', 'shipments.orderId', '=', 'orders.id')
  .where('orders.orderDate', '>=', new Date('2025-01-01'))
  .and('orders.status', '=', 'completed')
  .groupBy('orders.id')
  .having('orders.total', '>', 100)
  .orderBy('orders.orderDate', 'DESC')
  .paginate(2, 15) // Page 2, 15 items per page
  .execute();</code></pre>

            <h4>MongoDB Aggregation Example</h4>
            <pre><code class="language-javascript">const salesReport = await queryBuilder
  .from('orders')
  .aggregate([
    {
      $match: {
        orderDate: { $gte: new Date('2025-01-01') }
      }
    },
    {
      $group: {
        _id: { $month: '$orderDate' },
        totalSales: { $sum: '$total' },
        orderCount: { $sum: 1 }
      }
    },
    {
      $sort: { _id: 1 }
    }
  ])
  .execute();</code></pre>
          </div>
        </section>

        <section id="examples" class="mt-5">
          <h2>Examples</h2>
          
          <div class="api-method">
            <h4>Basic CRUD Operations</h4>
            <pre><code class="language-javascript">// Create
const newUser = await databaseConnector.query('primaryMongo', {
  collection: 'users',
  operation: 'insertOne',
  values: {
    firstName: 'John',
    lastName: 'Doe',
    email: 'john.doe@example.com',
    age: 30,
    createdAt: new Date()
  }
});

// Read
const user = await databaseConnector.query('primaryMongo', {
  collection: 'users',
  operation: 'findOne',
  conditions: { email: 'john.doe@example.com' }
});

// Update
const updateResult = await databaseConnector.query('primaryMongo', {
  collection: 'users',
  operation: 'updateOne',
  conditions: { email: 'john.doe@example.com' },
  values: {
    $set: { age: 31, updatedAt: new Date() }
  }
});

// Delete
const deleteResult = await databaseConnector.query('primaryMongo', {
  collection: 'users',
  operation: 'deleteOne',
  conditions: { email: 'john.doe@example.com' }
});</code></pre>
            
            <h4>Working with Multiple Databases</h4>
            <pre><code class="language-javascript">// Get user from MongoDB
const user = await databaseConnector.query('primaryMongo', {
  collection: 'users',
  operation: 'findOne',
  conditions: { email: 'john.doe@example.com' }
});

// Get orders from MySQL
const orders = await databaseConnector.query('primaryMySQL', {
  table: 'orders',
  operation: 'select',
  columns: ['id', 'orderDate', 'total', 'status'],
  conditions: { customerId: user.id },
  orderBy: { orderDate: 'DESC' }
});

// Store analytics in PostgreSQL
await databaseConnector.query('primaryPostgres', {
  table: 'user_activity',
  operation: 'insert',
  values: {
    userId: user.id,
    action: 'login',
    timestamp: new Date(),
    ipAddress: '192.168.1.1'
  }
});</code></pre>
          </div>
        </section>

        <section id="best-practices" class="mt-5">
          <h2>Best Practices</h2>
          <p>Follow these best practices when using the Database Connector plugin:</p>
          
          <div class="row">
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title">Connection Management</h5>
                  <ul>
                    <li>Reuse existing connections instead of creating new ones</li>
                    <li>Close connections when they're no longer needed</li>
                    <li>Use connection pooling for better performance</li>
                    <li>Set appropriate connection limits</li>
                  </ul>
                </div>
              </div>
            </div>
            
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title">Query Optimization</h5>
                  <ul>
                    <li>Select only the columns you need</li>
                    <li>Use appropriate indexes</li>
                    <li>Limit result sets to a reasonable size</li>
                    <li>Use pagination for large datasets</li>
                    <li>Optimize complex queries</li>
                  </ul>
                </div>
              </div>
            </div>
            
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title">Security</h5>
                  <ul>
                    <li>Use parameterized queries to prevent SQL injection</li>
                    <li>Implement proper access controls</li>
                    <li>Use secure connections (SSL/TLS)</li>
                    <li>Store credentials securely</li>
                    <li>Follow the principle of least privilege</li>
                  </ul>
                </div>
              </div>
            </div>
            
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title">Error Handling</h5>
                  <ul>
                    <li>Implement proper error handling for database operations</li>
                    <li>Use transactions for operations that need to be atomic</li>
                    <li>Implement retry logic for transient errors</li>
                    <li>Log database errors for troubleshooting</li>
                    <li>Have fallback strategies for critical operations</li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </section>

        <div class="alert alert-info mt-5">
          <h5><i class="fas fa-lightbulb mr-2"></i>Related Documentation</h5>
          <ul class="mb-0">
            <li><a href="../api-reference.html">API Reference</a> - Complete API documentation</li>
            <li><a href="../examples.html">Code Examples</a> - More usage examples</li>
            <li><a href="../troubleshooting.html">Troubleshooting Guide</a> - Solutions for common issues</li>
            <li><a href="mongodb-utils.html">MongoDB Utils</a> - Additional MongoDB utilities</li>
          </ul>
        </div>
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
          <p>Written by Greg Deeds, Autonomy Association International</p>
          <p><a href="mailto:support@autonomy.ai" class="text-white"><i class="fas fa-envelope mr-2"></i>Get Support</a></p>
        </div>
      </div>
    </div>
  </footer>

  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
```


## 3. Let's create the Authentication Service plugin page:

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Authentication Service - IQSMS Plugin System</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="../css/styles.css">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.1/css/all.css">
</head>
<body>
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
      <a class="navbar-brand" href="../index.html">
        <img src="../images/logo.png" alt="IQSMS Plugin System" height="40">
      </a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item">
            <a class="nav-link" href="../index.html">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="../plugin-development.html">Development</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="../api-reference.html">API Reference</a>
          </li>
          <li class="nav-item dropdown active">
            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown">
              Plugins
            </a>
            <div class="dropdown-menu">
              <a class="dropdown-item" href="cloudflare-api.html">Cloudflare API</a>
              <a class="dropdown-item" href="system-info.html">System Info</a>
              <a class="dropdown-item" href="drone-swarm-loadbalancer.html">Drone Swarm LB</a>
              <a class="dropdown-item" href="database-connector.html">Database Connector</a>
              <a class="dropdown-item active" href="authentication-service.html">Authentication Service</a>
              <div class="dropdown-divider"></div>
              <a class="dropdown-item" href="index.html">All Plugins</a>
            </div>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <div class="container my-5">
    <div class="row">
      <div class="col-lg-3">
        <div class="sidebar">
          <h5>Contents</h5>
          <nav class="nav flex-column">
            <a class="nav-link" href="#overview">Overview</a>
            <a class="nav-link" href="#features">Key Features</a>
            <a class="nav-link" href="#installation">Installation</a>
            <a class="nav-link" href="#configuration">Configuration</a>
            <a class="nav-link" href="#auth-methods">Authentication Methods</a>
            <a class="nav-link" href="#user-management">User Management</a>
            <a class="nav-link" href="#role-based-access">Role-Based Access</a>
            <a class="nav-link" href="#api-methods">API Methods</a>
            <a class="nav-link" href="#examples">Examples</a>
          </nav>
        </div>
      </div>
      <div class="col-lg-9">
        <div class="plugin-header d-flex align-items-center">
          <i class="fas fa-lock fa-3x text-primary mr-4"></i>
          <div>
            <h1>Authentication Service</h1>
            <p class="lead mb-0">Comprehensive authentication and authorization system with support for multiple authentication methods</p>
          </div>
        </div>

        <div class="plugin-info mb-4">
          <div class="plugin-info-item">
            <i class="fas fa-code-branch"></i>
            <span>Version: 2.1.0</span>
          </div>
          <div class="plugin-info-item">
            <i class="fas fa-user"></i>
            <span>Publisher: Autonomy Association International</span>
          </div>
          <div class="plugin-info-item">
            <i class="fas fa-coins"></i>
            <span>Cost: 75 tokens</span>
          </div>
        </div>

        <div class="alert alert-primary">
          <i class="fas fa-info-circle mr-2"></i>
          This plugin provides a comprehensive authentication and authorization system with support for multiple authentication methods, user management, and role-based access control.
        </div>

        <section id="overview">
          <h2>Overview</h2>
          <p>The Authentication Service plugin provides a complete authentication and authorization solution for your applications. It supports multiple authentication methods, including local username/password, OAuth 2.0, JWT, and multi-factor authentication. The plugin also includes user management features and role-based access control.</p>
          
          <p>With this plugin, you can easily secure your applications and APIs, manage user accounts, and control access to resources based on user roles and permissions.</p>
        </section>

        <section id="features" class="mt-5">
          <h2>Key Features</h2>
          
          <div class="row">
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title"><i class="fas fa-sign-in-alt text-primary mr-2"></i>Authentication Methods</h5>
                  <ul class="card-text">
                    <li>Local username/password</li>
                    <li>OAuth 2.0 (Google, Facebook, GitHub, etc.)</li>
                    <li>JWT (JSON Web Tokens)</li>
                    <li>API keys</li>
                    <li>Multi-factor authentication (MFA)</li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title"><i class="fas fa-users-cog text-primary mr-2"></i>User Management</h5>
                  <ul class="card-text">
                    <li>User registration and verification</li>
                    <li>Profile management</li>
                    <li>Password recovery</li>
                    <li>Account locking and unlocking</li>
                    <li>User activity tracking</li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
          
          <div class="row">
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title"><i class="fas fa-user-shield text-primary mr-2"></i>Authorization</h5>
                  <ul class="card-text">
                    <li>Role-based access control (RBAC)</li>
                    <li>Permission management</li>
                    <li>Resource-based authorization</li>
                    <li>Context-aware access decisions</li>
                    <li>Policy enforcement</li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title"><i class="fas fa-shield-alt text-primary mr-2"></i>Security Features</h5>
                  <ul class="card-text">
                    <li>Secure password hashing</li>
                    <li>Brute force protection</li>
                    <li>Session management</li>
                    <li>Audit logging</li>
                    <li>Security policies</li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </section>

        <section id="installation" class="mt-5">
          <h2>Installation</h2>
          <p>To use the Authentication Service plugin, you'll need to:</p>
          <ol>
            <li>Install the plugin in your IQSMS Plugin System</li>
            <li>Configure the plugin based on your authentication requirements</li>
            <li>Set up a database for user storage</li>
          </ol>

          <h4>Prerequisites</h4>
          <ul>
            <li>Node.js 14.x or higher</li>
            <li>IQSMS Plugin System core</li>
            <li>MongoDB, MySQL, or PostgreSQL database</li>
          </ul>

          <h4>Installing the Plugin</h4>
          <pre><code class="language-javascript">const pluginManager = require('./path/to/PluginManager');
await pluginManager.installPlugin('authentication-service');</code></pre>
        </section>

        <section id="configuration" class="mt-5">
          <h2>Configuration</h2>
          <p>The plugin provides several configuration options:</p>

          <pre><code class="language-javascript">const config = {
  // Database configuration
  database: {
    type: 'mongodb', // 'mongodb', 'mysql', or 'postgres'
    connection: 'primaryMongo', // Connection name from Database Connector plugin
    userCollection: 'users' // Collection or table name
  },
  
  // Authentication methods
  authMethods: {
    local: {
      enabled: true,
      usernameField: 'email',
      passwordField: 'password',
      saltRounds: 10 // For bcrypt
    },
    jwt: {
      enabled: true,
      secret: 'your-jwt-secret',
      expiresIn: '1h'
    },
    oauth: {
      enabled: true,
      providers: {
        google: {
          clientId: 'your-google-client-id',
          clientSecret: 'your-google-client-secret',
          callbackURL: 'https://your-app.com/auth/google/callback'
        },
        // Add other OAuth providers as needed
      }
    },
    apiKey: {
      enabled: true,
      headerName: 'X-API-Key'
    },
    mfa: {
      enabled: true,
      types: ['totp', 'sms']
    }
  },
  
  // Security settings
  security: {
    bruteForce: {
      enabled: true,
      maxAttempts: 5,
      windowMs: 15 * 60 * 1000, // 15 minutes
      blockDuration: 60 * 60 * 1000 // 1 hour
    },
    passwordPolicy: {
      minLength: 8,
      requireUppercase: true,
      requireLowercase: true,
      requireNumbers: true,
      requireSpecialChars: true,
      maxAge: 90 * 24 * 60 * 60 * 1000 // 90 days
    }
  },
  
  // Email settings for verification, password reset, etc.
  email: {
    enabled: true,
    service: 'your-email-service', // e.g., 'sendgrid', 'mailgun'
    apiKey: 'your-email-service-api-key',
    from: 'noreply@your-app.com',
    templates: {
      verification: 'email-verification-template',
      passwordReset: 'password-reset-template',
      welcomeEmail: 'welcome-email-template'
    }
  }
};</code></pre>

          <h4>Loading the Plugin with Configuration</h4>
          <pre><code class="language-javascript">await pluginManager.loadPlugin('authentication-service', config);</code></pre>
        </section>

        <section id="auth-methods" class="mt-5">
          <h2>Authentication Methods</h2>
          <p>The Authentication Service plugin supports multiple authentication methods:</p>

          <div class="row">
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title">Local Authentication</h5>
                  <p class="card-text">Traditional username/password authentication with secure password hashing using bcrypt.</p>
                  <h6>Example:</h6>
                  <pre><code class="language-javascript">const result = await authService.authenticate('local', {
  username: 'user@example.com',
  password: 'securePassword123'
});</code></pre>
                </div>
              </div>
            </div>
            
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title">JWT Authentication</h5>
                  <p class="card-text">JSON Web Token-based authentication for stateless API access.</p>
                  <h6>Example:</h6>
                  <pre><code class="language-javascript">// Generate a token
const token = await authService.generateToken(user);

// Verify a token
const decoded = await authService.verifyToken(token);</code></pre>
                </div>
              </div>
            </div>
            
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title">OAuth 2.0</h5>
                  <p class="card-text">Social login using OAuth 2.0 providers like Google, Facebook, GitHub, etc.</p>
                  <h6>Example:</h6>
                  <pre><code class="language-javascript">// Redirect to OAuth provider
const authUrl = await authService.getOAuthUrl('google');

// Handle OAuth callback
const user = await authService.handleOAuthCallback(
  'google',
  code,
  state
);</code></pre>
                </div>
              </div>
            </div>
            
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title">API Key Authentication</h5>
                  <p class="card-text">Simple API key-based authentication for service-to-service communication.</p>
                  <h6>Example:</h6>
                  <pre><code class="language-javascript">// Generate an API key
const apiKey = await authService.generateApiKey(
  userId,
  { name: 'Service A', expiresIn: '30d' }
);

// Verify an API key
const user = await authService.verifyApiKey(apiKey);</code></pre>
                </div>
              </div>
            </div>
            
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title">Multi-Factor Authentication</h5>
                  <p class="card-text">Additional security layer using TOTP, SMS, or other second factors.</p>
                  <h6>Example:</h6>
                  <pre><code class="language-javascript">// Enable MFA for a user
const mfaInfo = await authService.enableMFA(
  userId,
  'totp'
);

// Verify MFA code
const isValid = await authService.verifyMFACode(
  userId,
  'totp',
  code
);</code></pre>
                </div>
              </div>
            </div>
          </div>
        </section>

        <section id="user-management" class="mt-5">
          <h2>User Management</h2>
          <p>The Authentication Service plugin provides comprehensive user management capabilities:</p>

          <div class="api-method">
            <h3>createUser(userData)</h3>
            <p>Creates a new user account.</p>
            
            <h4>Parameters</h4>
            <table class="table">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Type</th>
                  <th>Required</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>userData</td>
                  <td>object</td>
                  <td>Yes</td>
                  <td>User information including username, password, etc.</td>
                </tr>
              </tbody>
            </table>
            
            <h4>Returns</h4>
            <pre><code class="language-javascript">{
  id: "user-123",
  email: "user@example.com",
  firstName: "John",
  lastName: "Doe",
  roles: ["user"],
  createdAt: "2025-09-14T12:00:00Z",
  verified: false
}</code></pre>
            
            <h4>Example</h4>
            <pre><code class="language-javascript">const user = await authService.createUser({
  email: 'user@example.com',
  password: 'securePassword123',
  firstName: 'John',
  lastName: 'Doe',
  roles: ['user']
});</code></pre>
          </div>

          <div class="api-method mt-4">
            <h3>updateUser(userId, userData)</h3>
            <p>Updates an existing user account.</p>
            
            <h4>Parameters</h4>
            <table class="table">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Type</th>
                  <th>Required</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>userId</td>
                  <td>string</td>
                  <td>Yes</td>
                  <td>ID of the user to update</td>
                </tr>
                <tr>
                  <td>userData</td>
                  <td>object</td>
                  <td>Yes</td>
                  <td>User information to update</td>
                </tr>
              </tbody>
            </table>
            
            <h4>Returns</h4>
            <p>The updated user object.</p>
            
            <h4>Example</h4>
            <pre><code class="language-javascript">const updatedUser = await authService.updateUser('user-123', {
  firstName: 'Jonathan',
  phoneNumber: '555-123-4567'
});</code></pre>
          </div>

          <div class="api-method mt-4">
            <h3>changePassword(userId, currentPassword, newPassword)</h3>
            <p>Changes a user's password.</p>
            
            <h4>Parameters</h4>
            <table class="table">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Type</th>
                  <th>Required</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>userId</td>
                  <td>string</td>
                  <td>Yes</td>
                  <td>ID of the user</td>
                </tr>
                <tr>
                  <td>currentPassword</td>
                  <td>string</td>
                  <td>Yes</td>
                  <td>Current password</td>
                </tr>
                <tr>
                  <td>newPassword</td>
                  <td>string</td>
                  <td>Yes</td>
                  <td>New password</td>
                </tr>
              </tbody>
            </table>
            
            <h4>Returns</h4>
            <pre><code class="language-javascript">{
  success: true,
  message: "Password changed successfully"
}</code></pre>
            
            <h4>Example</h4>
            <pre><code class="language-javascript">const result = await authService.changePassword(
  'user-123',
  'currentPassword',
  'newSecurePassword456'
);</code></pre>
          </div>
        </section>

        <section id="role-based-access" class="mt-5">
          <h2>Role-Based Access Control</h2>
          <p>The Authentication Service plugin provides role-based access control (RBAC) capabilities:</p>

          <div class="api-method">
            <h3>assignRole(userId, role)</h3>
            <p>Assigns a role to a user.</p>
            
            <h4>Parameters</h4>
            <table class="table">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Type</th>
                  <th>Required</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>userId</td>
                  <td>string</td>
                  <td>Yes</td>
                  <td>ID of the user</td>
                </tr>
                <tr>
                  <td>role</td>
                  <td>string</td>
                  <td>Yes</td>
                  <td>Role to assign</td>
                </tr>
              </tbody>
            </table>
            
            <h4>Returns</h4>
            <p>The updated user object with roles.</p>
            
            <h4>Example</h4>
            <pre><code class="language-javascript">const user = await authService.assignRole('user-123', 'admin');</code></pre>
          </div>

          <div class="api-method mt-4">
            <h3>checkPermission(userId, resource, action)</h3>
            <p>Checks if a user has permission to perform an action on a resource.</p>
            
            <h4>Parameters</h4>
            <table class="table">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Type</th>
                  <th>Required</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>userId</td>
                  <td>string</td>
                  <td>Yes</td>
                  <td>ID of the user</td>
                </tr>
                <tr>
                  <td>resource</td>
                  <td>string</td>
                  <td>Yes</td>
                  <td>Resource to access</td>
                </tr>
                <tr>
                  <td>action</td>
                  <td>string</td>
                  <td>Yes</td>
                  <td>Action to perform</td>
                </tr>
              </tbody>
            </table>
            
            <h4>Returns</h4>
            <pre><code class="language-javascript">{
  allowed: true,
  reason: "User has admin role"
}</code></pre>
            
            <h4>Example</h4>
            <pre><code class="language-javascript">const permission = await authService.checkPermission(
  'user-123',
  'users',
  'delete'
);

if (permission.allowed) {
  // User has permission to delete users
  // Proceed with the action
} else {
  // User does not have permission
  console.log(`Access denied: ${permission.reason}`);
}</code></pre>
          </div>
        </section>

        <section id="api-methods" class="mt-5">
          <h2>API Methods</h2>
          <p>The Authentication Service plugin provides a comprehensive API:</p>

          <div class="accordion" id="apiAccordion">
            <div class="card">
              <div class="card-header" id="headingOne">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapseOne">
                    Authentication Methods
                  </button>
                </h2>
              </div>
              <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#apiAccordion">
                <div class="card-body">
                  <ul>
                    <li><code>authenticate(method, credentials)</code> - Authenticate a user with specified method</li>
                    <li><code>generateToken(user)</code> - Generate a JWT token for a user</li>
                    <li><code>verifyToken(token)</code> - Verify a JWT token</li>
                    <li><code>getOAuthUrl(provider)</code> - Get OAuth authorization URL</li>
                    <li><code>handleOAuthCallback(provider, code, state)</code> - Handle OAuth callback</li>
                    <li><code>generateApiKey(userId, options)</code> - Generate an API key</li>
                    <li><code>verifyApiKey(apiKey)</code> - Verify an API key</li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="card">
              <div class="card-header" id="headingTwo">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo">
                    User Management Methods
                  </button>
                </h2>
              </div>
              <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#apiAccordion">
                <div class="card-body">
                  <ul>
                    <li><code>createUser(userData)</code> - Create a new user</li>
                    <li><code>getUser(userId)</code> - Get a user by ID</li>
                    <li><code>findUser(criteria)</code> - Find a user by criteria</li>
                    <li><code>updateUser(userId, userData)</code> - Update a user</li>
                    <li><code>deleteUser(userId)</code> - Delete a user</li>
                    <li><code>changePassword(userId, currentPassword, newPassword)</code> - Change a user's password</li>
                    <li><code>resetPassword(email)</code> - Initiate password reset</li>
                    <li><code>completePasswordReset(token, newPassword)</code> - Complete password reset</li>
                    <li><code>verifyEmail(token)</code> - Verify a user's email</li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="card">
              <div class="card-header" id="headingThree">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseThree">
                    MFA Methods
                  </button>
                </h2>
              </div>
              <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#apiAccordion">
                <div class="card-body">
                  <ul>
                    <li><code>enableMFA(userId, type)</code> - Enable MFA for a user</li>
                    <li><code>disableMFA(userId, type)</code> - Disable MFA for a user</li>
                    <li><code>generateMFACode(userId, type)</code> - Generate an MFA code</li>
                    <li><code>verifyMFACode(userId, type, code)</code> - Verify an MFA code</li>
                    <li><code>getMFAStatus(userId)</code> - Get MFA status for a user</li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="card">
              <div class="card-header" id="headingFour">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseFour">
                    Role & Permission Methods
                  </button>
                </h2>
              </div>
              <div id="collapseFour" class="collapse" aria-labelledby="headingFour" data-parent="#apiAccordion">
                <div class="card-body">
                  <ul>
                    <li><code>createRole(roleName, permissions)</code> - Create a new role</li>
                    <li><code>updateRole(roleName, permissions)</code> - Update role permissions</li>
                    <li><code>deleteRole(roleName)</code> - Delete a role</li>
                    <li><code>assignRole(userId, role)</code> - Assign a role to a user</li>
                    <li><code>removeRole(userId, role)</code> - Remove a role from a user</li>
                    <li><code>getRoles(userId)</code> - Get roles for a user</li>
                    <li><code>checkPermission(userId, resource, action)</code> - Check permission</li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </section>

        <section id="examples" class="mt-5">
          <h2>Examples</h2>
          
          <div class="api-method">
            <h4>User Registration and Authentication</h4>
            <pre><code class="language-javascript">// Register a new user
const newUser = await authService.createUser({
  email: 'user@example.com',
  password: 'securePassword123',
  firstName: 'John',
  lastName: 'Doe'
});

// Send verification email
await authService.sendVerificationEmail(newUser.email);

// Authenticate user
const authResult = await authService.authenticate('local', {
  username: 'user@example.com',
  password: 'securePassword123'
});

if (authResult.success) {
  const token = await authService.generateToken(authResult.user);
  console.log(`Authentication successful. Token: ${token}`);
} else {
  console.error(`Authentication failed: ${authResult.message}`);
}</code></pre>
            
            <h4>Role-Based Access Control</h4>
            <pre><code class="language-javascript">// Create roles with permissions
await authService.createRole('admin', [
  'users:create', 'users:read', 'users:update', 'users:delete',
  'roles:create', 'roles:read', 'roles:update', 'roles:delete'
]);

await authService.createRole('editor', [
  'content:create', 'content:read', 'content:update'
]);

// Assign roles to users
await authService.assignRole('user-123', 'admin');
await authService.assignRole('user-456', 'editor');

// Check permissions
const canDeleteUser = await authService.checkPermission(
  'user-123',
  'users',
  'delete'
);

const canUpdateContent = await authService.checkPermission(
  'user-456',
  'content',
  'update'
);

console.log(`Admin can delete users: ${canDeleteUser.allowed}`);
console.log(`Editor can update content: ${canUpdateContent.allowed}`);</code></pre>
            
            <h4>Multi-Factor Authentication</h4>
            <pre><code class="language-javascript">// Enable TOTP-based MFA for a user
const mfaInfo = await authService.enableMFA('user-123', 'totp');

// Show QR code to user for scanning with authenticator app
console.log(`QR Code URL: ${mfaInfo.qrCodeUrl}`);
console.log(`Secret Key: ${mfaInfo.secret}`);

// Verify MFA setup
const isSetupValid = await authService.verifyMFACode(
  'user-123',
  'totp',
  '123456' // Code from authenticator app
);

// Authentication with MFA
const authResult = await authService.authenticate('local', {
  username: 'user@example.com',
  password: 'securePassword123'
});

if (authResult.requiresMFA) {
  // Prompt user for MFA code
  const mfaCode = '123456'; // Code from authenticator app
  
  const mfaResult = await authService.verifyMFACode(
    authResult.user.id,
    'totp',
    mfaCode
  );
  
  if (mfaResult) {
    const token = await authService.generateToken(authResult.user);
    console.log(`Authentication with MFA successful. Token: ${token}`);
  } else {
    console.error('MFA verification failed');
  }
}</code></pre>
          </div>
        </section>

        <div class="alert alert-info mt-5">
          <h5><i class="fas fa-lightbulb mr-2"></i>Related Documentation</h5>
          <ul class="mb-0">
            <li><a href="../api-reference.html">API Reference</a> - Complete API documentation</li>
            <li><a href="../examples.html">Code Examples</a> - More usage examples</li>
            <li><a href="../troubleshooting.html">Troubleshooting Guide</a> - Solutions for common issues</li>
            <li><a href="security-manager.html">Security Manager</a> - Additional security features</li>
          </ul>
        </div>
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
          <p>Written by Greg Deeds, Autonomy Association International</p>
          <p><a href="mailto:support@autonomy.ai" class="text-white"><i class="fas fa-envelope mr-2"></i>Get Support</a></p>
        </div>
      </div>
    </div>
  </footer>

  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
```


## 4. Let's create the AI Analytics plugin page:

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>AI Analytics - IQSMS Plugin System</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="../css/styles.css">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.1/css/all.css">
</head>
<body>
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
      <a class="navbar-brand" href="../index.html">
        <img src="../images/logo.png" alt="IQSMS Plugin System" height="40">
      </a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item">
            <a class="nav-link" href="../index.html">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="../plugin-development.html">Development</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="../api-reference.html">API Reference</a>
          </li>
          <li class="nav-item dropdown active">
            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown">
              Plugins
            </a>
            <div class="dropdown-menu">
              <a class="dropdown-item" href="cloudflare-api.html">Cloudflare API</a>
              <a class="dropdown-item" href="system-info.html">System Info</a>
              <a class="dropdown-item" href="drone-swarm-loadbalancer.html">Drone Swarm LB</a>
              <a class="dropdown-item" href="database-connector.html">Database Connector</a>
              <a class="dropdown-item" href="authentication-service.html">Authentication Service</a>
              <a class="dropdown-item active" href="ai-analytics.html">AI Analytics</a>
              <div class="dropdown-divider"></div>
              <a class="dropdown-item" href="index.html">All Plugins</a>
            </div>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <div class="container my-5">
    <div class="row">
      <div class="col-lg-3">
        <div class="sidebar">
          <h5>Contents</h5>
          <nav class="nav flex-column">
            <a class="nav-link" href="#overview">Overview</a>
            <a class="nav-link" href="#features">Key Features</a>
            <a class="nav-link" href="#installation">Installation</a>
            <a class="nav-link" href="#configuration">Configuration</a>
            <a class="nav-link" href="#data-processing">Data Processing</a>
            <a class="nav-link" href="#ml-models">Machine Learning Models</a>
            <a class="nav-link" href="#visualization">Visualization</a>
            <a class="nav-link" href="#api-methods">API Methods</a>
            <a class="nav-link" href="#examples">Examples</a>
          </nav>
        </div>
      </div>
      <div class="col-lg-9">
        <div class="plugin-header d-flex align-items-center">
          <i class="fas fa-chart-line fa-3x text-primary mr-4"></i>
          <div>
            <h1>AI Analytics</h1>
            <p class="lead mb-0">Advanced analytics and machine learning capabilities for data analysis, prediction, and visualization</p>
          </div>
        </div>

        <div class="plugin-info mb-4">
          <div class="plugin-info-item">
            <i class="fas fa-code-branch"></i>
            <span>Version: 1.3.5</span>
          </div>
          <div class="plugin-info-item">
            <i class="fas fa-user"></i>
            <span>Publisher: Autonomy Association International</span>
          </div>
          <div class="plugin-info-item">
            <i class="fas fa-coins"></i>
            <span>Cost: 120 tokens</span>
          </div>
        </div>

        <div class="alert alert-primary">
          <i class="fas fa-info-circle mr-2"></i>
          This plugin provides advanced analytics and machine learning capabilities for data analysis, prediction, and visualization.
        </div>

        <section id="overview">
          <h2>Overview</h2>
          <p>The AI Analytics plugin brings powerful data analysis, machine learning, and visualization capabilities to your applications. It provides a comprehensive suite of tools for data preprocessing, model training, prediction, and visualization, all accessible through an easy-to-use API.</p>
          
          <p>Whether you need to analyze trends, predict future values, classify data, or create stunning visualizations, the AI Analytics plugin has you covered. It supports various data sources and can be integrated with other plugins in the IQSMS ecosystem.</p>
        </section>

        <section id="features" class="mt-5">
          <h2>Key Features</h2>
          
          <div class="row">
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title"><i class="fas fa-database text-primary mr-2"></i>Data Processing</h5>
                  <ul class="card-text">
                    <li>Data cleaning and normalization</li>
                    <li>Feature extraction and selection</li>
                    <li>Time series processing</li>
                    <li>Text and natural language processing</li>
                    <li>Image data preprocessing</li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title"><i class="fas fa-brain text-primary mr-2"></i>Machine Learning</h5>
                  <ul class="card-text">
                    <li>Classification and regression models</li>
                    <li>Clustering and anomaly detection</li>
                    <li>Time series forecasting</li>
                    <li>Recommendation systems</li>
                    <li>Deep learning capabilities</li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
          
          <div class="row">
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title"><i class="fas fa-chart-bar text-primary mr-2"></i>Visualization</h5>
                  <ul class="card-text">
                    <li>Interactive charts and graphs</li>
                    <li>Dashboards and reports</li>
                    <li>Geospatial visualization</li>
                    <li>Network and relationship graphs</li>
                    <li>Custom visualization components</li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title"><i class="fas fa-cogs text-primary mr-2"></i>Integration</h5>
                  <ul class="card-text">
                    <li>Multiple data source support</li>
                    <li>Real-time data processing</li>
                    <li>Export to various formats</li>
                    <li>Seamless integration with other plugins</li>
                    <li>API-first design for flexibility</li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </section>

        <section id="installation" class="mt-5">
          <h2>Installation</h2>
          <p>To use the AI Analytics plugin, you'll need to:</p>
          <ol>
            <li>Install the plugin in your IQSMS Plugin System</li>
            <li>Configure the plugin based on your analytics requirements</li>
            <li>Set up data sources and model storage</li>
          </ol>

          <h4>Prerequisites</h4>
          <ul>
            <li>Node.js 14.x or higher</li>
            <li>IQSMS Plugin System core</li>
            <li>MongoDB, MySQL, or PostgreSQL database for data storage</li>
            <li>Sufficient RAM for model training (8GB+ recommended)</li>
          </ul>

          <h4>Installing the Plugin</h4>
          <pre><code class="language-javascript">const pluginManager = require('./path/to/PluginManager');
await pluginManager.installPlugin('ai-analytics');</code></pre>
          
          <h4>Additional Dependencies</h4>
          <p>Some features require additional dependencies:</p>
          <pre><code class="language-bash"># For advanced machine learning
npm install @tensorflow/tfjs tensorflow-node

# For visualization
npm install d3 plotly.js-dist chart.js

# For natural language processing
npm install natural compromise</code></pre>
        </section>

        <section id="configuration" class="mt-5">
          <h2>Configuration</h2>
          <p>The plugin provides several configuration options:</p>

          <pre><code class="language-javascript">const config = {
  // Storage configuration
  storage: {
    type: 'mongodb', // 'mongodb', 'mysql', or 'postgres'
    connection: 'primaryMongo', // Connection name from Database Connector plugin
    collections: {
      models: 'aiModels',
      datasets: 'aiDatasets',
      predictions: 'aiPredictions',
      visualizations: 'aiVisualizations'
    }
  },
  
  // Machine learning configuration
  ml: {
    defaultEngine: 'tfjs', // 'tfjs', 'ml-js', or 'custom'
    maxTrainingTime: 3600, // seconds
    modelCacheSize: 5, // Number of models to keep in memory
    enableGPU: false, // Use GPU for training if available
    autoScaling: true // Automatically scale features
  },
  
  // Visualization configuration
  visualization: {
    defaultEngine: 'plotly', // 'plotly', 'd3', 'chart.js'
    theme: 'light', // 'light' or 'dark'
    colors: ['#4e79a7', '#f28e2c', '#e15759', '#76b7b2', '#59a14f', '#edc949', '#af7aa1', '#ff9da7', '#9c755f', '#bab0ab'],
    responsive: true
  },
  
  // Data processing configuration
  dataProcessing: {
    maxBatchSize: 10000, // Maximum number of records to process in one batch
    textAnalysis: {
      enabled: true,
      language: 'english'
    },
    timeSeriesAnalysis: {
      enabled: true,
      defaultInterval: 'day'
    }
  },
  
  // API configuration
  api: {
    maxConcurrentRequests: 10,
    timeout: 30000 // ms
  }
};</code></pre>

          <h4>Loading the Plugin with Configuration</h4>
          <pre><code class="language-javascript">await pluginManager.loadPlugin('ai-analytics', config);</code></pre>
        </section>

        <section id="data-processing" class="mt-5">
          <h2>Data Processing</h2>
          <p>The AI Analytics plugin provides powerful data processing capabilities:</p>

          <div class="api-method">
            <h3>processData(data, options)</h3>
            <p>Processes and prepares data for analysis or model training.</p>
            
            <h4>Parameters</h4>
            <table class="table">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Type</th>
                  <th>Required</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>data</td>
                  <td>array or object</td>
                  <td>Yes</td>
                  <td>Data to process</td>
                </tr>
                <tr>
                  <td>options</td>
                  <td>object</td>
                  <td>No</td>
                  <td>Processing options</td>
                </tr>
              </tbody>
            </table>
            
            <h4>Returns</h4>
            <p>Processed data ready for analysis or model training.</p>
            
            <h4>Example</h4>
            <pre><code class="language-javascript">const processedData = await aiAnalytics.processData(rawData, {
  normalize: true,
  fillMissingValues: 'mean',
  removeOutliers: true,
  features: ['temperature', 'humidity', 'pressure'],
  target: 'status'
});</code></pre>
          </div>

          <div class="api-method mt-4">
            <h3>extractFeatures(data, options)</h3>
            <p>Extracts features from raw data.</p>
            
            <h4>Parameters</h4>
            <table class="table">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Type</th>
                  <th>Required</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>data</td>
                  <td>array or object</td>
                  <td>Yes</td>
                  <td>Data to process</td>
                </tr>
                <tr>
                  <td>options</td>
                  <td>object</td>
                  <td>No</td>
                  <td>Feature extraction options</td>
                </tr>
              </tbody>
            </table>
            
            <h4>Returns</h4>
            <p>Extracted features.</p>
            
            <h4>Example</h4>
            <pre><code class="language-javascript">// Extract features from text
const textFeatures = await aiAnalytics.extractFeatures(textData, {
  type: 'text',
  method: 'tfidf',
  maxFeatures: 100
});

// Extract features from time series
const timeSeriesFeatures = await aiAnalytics.extractFeatures(timeSeriesData, {
  type: 'timeSeries',
  interval: 'hour',
  features: ['trend', 'seasonality', 'autocorrelation']
});</code></pre>
          </div>
        </section>

        <section id="ml-models" class="mt-5">
          <h2>Machine Learning Models</h2>
          <p>The AI Analytics plugin supports various machine learning models:</p>

          <div class="row">
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title">Classification Models</h5>
                  <ul>
                    <li>Logistic Regression</li>
                    <li>Decision Trees</li>
                    <li>Random Forest</li>
                    <li>Support Vector Machines</li>
                    <li>Neural Networks</li>
                  </ul>
                  <h6>Example:</h6>
                  <pre><code class="language-javascript">const model = await aiAnalytics.createModel({
  type: 'classification',
  algorithm: 'randomForest',
  params: {
    numTrees: 100,
    maxDepth: 10
  }
});</code></pre>
                </div>
              </div>
            </div>
            
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title">Regression Models</h5>
                  <ul>
                    <li>Linear Regression</li>
                    <li>Polynomial Regression</li>
                    <li>Ridge Regression</li>
                    <li>Decision Tree Regression</li>
                    <li>Neural Networks</li>
                  </ul>
                  <h6>Example:</h6>
                  <pre><code class="language-javascript">const model = await aiAnalytics.createModel({
  type: 'regression',
  algorithm: 'linearRegression',
  params: {
    regularization: 'l2',
    alpha: 0.01
  }
});</code></pre>
                </div>
              </div>
            </div>
            
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title">Clustering Models</h5>
                  <ul>
                    <li>K-Means</li>
                    <li>Hierarchical Clustering</li>
                    <li>DBSCAN</li>
                    <li>Gaussian Mixture Models</li>
                  </ul>
                  <h6>Example:</h6>
                  <pre><code class="language-javascript">const model = await aiAnalytics.createModel({
  type: 'clustering',
  algorithm: 'kmeans',
  params: {
    k: 5,
    maxIterations: 100
  }
});</code></pre>
                </div>
              </div>
            </div>
            
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title">Time Series Models</h5>
                  <ul>
                    <li>ARIMA</li>
                    <li>SARIMA</li>
                    <li>Exponential Smoothing</li>
                    <li>Prophet</li>
                    <li>LSTM Neural Networks</li>
                  </ul>
                  <h6>Example:</h6>
                  <pre><code class="language-javascript">const model = await aiAnalytics.createModel({
  type: 'timeSeries',
  algorithm: 'arima',
  params: {
    p: 1,
    d: 1,
    q: 1,
    seasonal: true
  }
});</code></pre>
                </div>
              </div>
            </div>
          </div>

          <div class="api-method mt-4">
            <h3>trainModel(modelId, data, options)</h3>
            <p>Trains a machine learning model with the provided data.</p>
            
            <h4>Parameters</h4>
            <table class="table">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Type</th>
                  <th>Required</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>modelId</td>
                  <td>string</td>
                  <td>Yes</td>
                  <td>ID of the model to train</td>
                </tr>
                <tr>
                  <td>data</td>
                  <td>array or object</td>
                  <td>Yes</td>
                  <td>Training data</td>
                </tr>
                <tr>
                  <td>options</td>
                  <td>object</td>
                  <td>No</td>
                  <td>Training options</td>
                </tr>
              </tbody>
            </table>
            
            <h4>Returns</h4>
            <p>Training results including model performance metrics.</p>
            
            <h4>Example</h4>
            <pre><code class="language-javascript">const trainingResults = await aiAnalytics.trainModel(
  'model-123',
  trainingData,
  {
    validationSplit: 0.2,
    epochs: 50,
    batchSize: 32,
    earlyStop: true,
    features: ['feature1', 'feature2', 'feature3'],
    target: 'target'
  }
);</code></pre>
          </div>

          <div class="api-method mt-4">
            <h3>predict(modelId, data, options)</h3>
            <p>Makes predictions using a trained model.</p>
            
            <h4>Parameters</h4>
            <table class="table">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Type</th>
                  <th>Required</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>modelId</td>
                  <td>string</td>
                  <td>Yes</td>
                  <td>ID of the model to use</td>
                </tr>
                <tr>
                  <td>data</td>
                  <td>array or object</td>
                  <td>Yes</td>
                  <td>Data to make predictions on</td>
                </tr>
                <tr>
                  <td>options</td>
                  <td>object</td>
                  <td>No</td>
                  <td>Prediction options</td>
                </tr>
              </tbody>
            </table>
            
            <h4>Returns</h4>
            <p>Prediction results.</p>
            
            <h4>Example</h4>
            <pre><code class="language-javascript">// Classification prediction
const classificationResults = await aiAnalytics.predict(
  'classification-model',
  newData,
  {
    returnProbabilities: true,
    threshold: 0.7
  }
);

// Regression prediction
const regressionResults = await aiAnalytics.predict(
  'regression-model',
  newData,
  {
    returnConfidenceIntervals: true,
    confidenceLevel: 0.95
  }
);

// Time series forecast
const forecast = await aiAnalytics.predict(
  'time-series-model',
  { startDate: '2025-09-14', periods: 30 },
  {
    returnConfidenceIntervals: true,
    includeComponents: true
  }
);</code></pre>
          </div>
        </section>

        <section id="visualization" class="mt-5">
          <h2>Visualization</h2>
          <p>The AI Analytics plugin provides powerful visualization capabilities:</p>

          <div class="api-method">
            <h3>createVisualization(data, options)</h3>
            <p>Creates a visualization from the provided data.</p>
            
            <h4>Parameters</h4>
            <table class="table">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Type</th>
                  <th>Required</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>data</td>
                  <td>array or object</td>
                  <td>Yes</td>
                  <td>Data to visualize</td>
                </tr>
                <tr>
                  <td>options</td>
                  <td>object</td>
                  <td>Yes</td>
                  <td>Visualization options</td>
                </tr>
              </tbody>
            </table>
            
            <h4>Returns</h4>
            <p>Visualization object that can be rendered.</p>
            
            <h4>Example</h4>
            <pre><code class="language-javascript">// Create a line chart
const lineChart = await aiAnalytics.createVisualization(
  timeSeriesData,
  {
    type: 'line',
    title: 'Temperature Trend',
    xAxis: {
      field: 'date',
      title: 'Date'
    },
    yAxis: {
      field: 'temperature',
      title: 'Temperature (°C)'
    },
    series: [
      { field: 'temperature', name: 'Temperature' },
      { field: 'forecast', name: 'Forecast', style: 'dashed' }
    ]
  }
);

// Create a scatter plot with regression line
const scatterPlot = await aiAnalytics.createVisualization(
  correlationData,
  {
    type: 'scatter',
    title: 'Temperature vs. Energy Consumption',
    xAxis: {
      field: 'temperature',
      title: 'Temperature (°C)'
    },
    yAxis: {
      field: 'energyConsumption',
      title: 'Energy Consumption (kWh)'
    },
    regression: {
      type: 'linear',
      showLine: true,
      showEquation: true
    }
  }
);</code></pre>
          </div>

          <div class="api-method mt-4">
            <h3>renderVisualization(visualizationId, container, options)</h3>
            <p>Renders a visualization to the specified container.</p>
            
            <h4>Parameters</h4>
            <table class="table">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Type</th>
                  <th>Required</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>visualizationId</td>
                  <td>string</td>
                  <td>Yes</td>
                  <td>ID of the visualization to render</td>
                </tr>
                <tr>
                  <td>container</td>
                  <td>string or element</td>
                  <td>Yes</td>
                  <td>Container element or selector</td>
                </tr>
                <tr>
                  <td>options</td>
                  <td>object</td>
                  <td>No</td>
                  <td>Rendering options</td>
                </tr>
              </tbody>
            </table>
            
            <h4>Returns</h4>
            <p>Rendered visualization instance.</p>
            
            <h4>Example</h4>
            <pre><code class="language-javascript">// Render visualization to DOM element
const rendered = await aiAnalytics.renderVisualization(
  'visualization-123',
  '#chart-container',
  {
    width: 800,
    height: 400,
    responsive: true,
    theme: 'dark'
  }
);

// Export visualization to image
const imageData = await rendered.exportToImage({
  format: 'png',
  width: 1200,
  height: 800
});</code></pre>
          </div>
        </section>

        <section id="api-methods" class="mt-5">
          <h2>API Methods</h2>
          <p>The AI Analytics plugin provides a comprehensive API:</p>

          <div class="accordion" id="apiAccordion">
            <div class="card">
              <div class="card-header" id="headingOne">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapseOne">
                    Data Processing Methods
                  </button>
                </h2>
              </div>
              <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#apiAccordion">
                <div class="card-body">
                  <ul>
                    <li><code>processData(data, options)</code> - Process and prepare data</li>
                    <li><code>extractFeatures(data, options)</code> - Extract features from data</li>
                    <li><code>normalizeData(data, options)</code> - Normalize data</li>
                    <li><code>aggregateData(data, options)</code> - Aggregate data</li>
                    <li><code>filterData(data, criteria)</code> - Filter data based on criteria</li>
                    <li><code>joinData(data1, data2, options)</code> - Join two datasets</li>
                    <li><code>splitData(data, options)</code> - Split data into training and testing sets</li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="card">
              <div class="card-header" id="headingTwo">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo">
                    Model Management Methods
                  </button>
                </h2>
              </div>
              <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#apiAccordion">
                <div class="card-body">
                  <ul>
                    <li><code>createModel(options)</code> - Create a new model</li>
                    <li><code>getModel(modelId)</code> - Get a model by ID</li>
                    <li><code>updateModel(modelId, options)</code> - Update model configuration</li>
                    <li><code>deleteModel(modelId)</code> - Delete a model</li>
                    <li><code>trainModel(modelId, data, options)</code> - Train a model</li>
                    <li><code>evaluateModel(modelId, data, options)</code> - Evaluate model performance</li>
                    <li><code>exportModel(modelId, format)</code> - Export a model</li>
                    <li><code>importModel(modelData, options)</code> - Import a model</li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="card">
              <div class="card-header" id="headingThree">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseThree">
                    Prediction and Analysis Methods
                  </button>
                </h2>
              </div>
              <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#apiAccordion">
                <div class="card-body">
                  <ul>
                    <li><code>predict(modelId, data, options)</code> - Make predictions</li>
                    <li><code>forecast(modelId, options)</code> - Make time series forecasts</li>
                    <li><code>analyze(data, analysisType, options)</code> - Perform statistical analysis</li>
                    <li><code>detectAnomalies(data, options)</code> - Detect anomalies in data</li>
                    <li><code>segmentData(data, options)</code> - Segment data into clusters</li>
                    <li><code>correlationAnalysis(data, options)</code> - Analyze correlations</li>
                    <li><code>performanceAnalysis(modelId, options)</code> - Analyze model performance</li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="card">
              <div class="card-header" id="headingFour">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseFour">
                    Visualization Methods
                  </button>
                </h2>
              </div>
              <div id="collapseFour" class="collapse" aria-labelledby="headingFour" data-parent="#apiAccordion">
                <div class="card-body">
                  <ul>
                    <li><code>createVisualization(data, options)</code> - Create a visualization</li>
                    <li><code>getVisualization(visualizationId)</code> - Get a visualization by ID</li>
                    <li><code>updateVisualization(visualizationId, options)</code> - Update visualization</li>
                    <li><code>deleteVisualization(visualizationId)</code> - Delete a visualization</li>
                    <li><code>renderVisualization(visualizationId, container, options)</code> - Render visualization</li>
                    <li><code>createDashboard(visualizations, options)</code> - Create a dashboard</li>
                    <li><code>exportVisualization(visualizationId, format, options)</code> - Export visualization</li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </section>

        <section id="examples" class="mt-5">
          <h2>Examples</h2>
          
          <div class="api-method">
            <h4>Time Series Forecasting</h4>
            <pre><code class="language-javascript">// Process time series data
const processedData = await aiAnalytics.processData(salesData, {
  type: 'timeSeries',
  timeField: 'date',
  valueField: 'sales',
  frequency: 'day',
  fillMissing: 'linear'
});

// Create and train a time series model
const model = await aiAnalytics.createModel({
  type: 'timeSeries',
  algorithm: 'prophet',
  params: {
    seasonality: {
      yearly: true,
      weekly: true,
      daily: false
    },
    changePoints: true
  }
});

// Train the model
const trainingResults = await aiAnalytics.trainModel(
  model.id,
  processedData,
  {
    trainingPeriod: {
      start: '2024-01-01',
      end: '2025-08-31'
    }
  }
);

// Make a forecast
const forecast = await aiAnalytics.predict(
  model.id,
  {
    periods: 90, // Forecast 90 days
    frequency: 'day',
    includeHistory: true
  }
);

// Visualize the results
const visualization = await aiAnalytics.createVisualization(
  forecast,
  {
    type: 'line',
    title: 'Sales Forecast',
    xAxis: {
      field: 'date',
      title: 'Date'
    },
    yAxis: {
      field: 'value',
      title: 'Sales ($)'
    },
    series: [
      { field: 'actual', name: 'Historical Sales' },
      { field: 'forecast', name: 'Forecast', style: 'dashed' }
    ],
    confidenceInterval: {
      field: 'forecast',
      level: 0.95,
      fill: true,
      opacity: 0.2
    }
  }
);

// Render the visualization
await aiAnalytics.renderVisualization(
  visualization.id,
  '#forecast-chart'
);</code></pre>
            
            <h4>Customer Segmentation</h4>
            <pre><code class="language-javascript">// Process customer data
const processedData = await aiAnalytics.processData(customerData, {
  normalize: true,
  features: ['totalSpent', 'frequency', 'recency', 'productCategories'],
  oneHot: ['productCategories']
});

// Create a clustering model
const model = await aiAnalytics.createModel({
  type: 'clustering',
  algorithm: 'kmeans',
  params: {
    k: 5, // 5 customer segments
    maxIterations: 100,
    initialization: 'k-means++'
  }
});

// Train the model
const trainingResults = await aiAnalytics.trainModel(
  model.id,
  processedData
);

// Apply segmentation to customers
const segmentedCustomers = await aiAnalytics.predict(
  model.id,
  customerData
);

// Analyze segments
const segmentAnalysis = await aiAnalytics.analyze(
  segmentedCustomers,
  'clusterAnalysis',
  {
    groupBy: 'segment',
    metrics: ['mean', 'median', 'count'],
    fields: ['totalSpent', 'frequency', 'recency']
  }
);

// Visualize the segments
const visualization = await aiAnalytics.createVisualization(
  segmentedCustomers,
  {
    type: 'scatter',
    title: 'Customer Segments',
    xAxis: {
      field: 'totalSpent',
      title: 'Total Spent ($)'
    },
    yAxis: {
      field: 'frequency',
      title: 'Purchase Frequency'
    },
    color: {
      field: 'segment',
      title: 'Customer Segment'
    },
    size: {
      field: 'recency',
      title: 'Days Since Last Purchase',
      inverse: true
    },
    tooltip: {
      fields: ['customerId', 'totalSpent', 'frequency', 'recency', 'segment']
    }
  }
);

// Render the visualization
await aiAnalytics.renderVisualization(
  visualization.id,
  '#customer-segments-chart'
);</code></pre>
          </div>
        </section>

        <div class="alert alert-info mt-5">
          <h5><i class="fas fa-lightbulb mr-2"></i>Related Documentation</h5>
          <ul class="mb-0">
            <li><a href="../api-reference.html">API Reference</a> - Complete API documentation</li>
            <li><a href="../examples.html">Code Examples</a> - More usage examples</li>
            <li><a href="../troubleshooting.html">Troubleshooting Guide</a> - Solutions for common issues</li>
            <li><a href="database-connector.html">Database Connector</a> - Data source integration</li>
          </ul>
        </div>
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
          <p>Written by Greg Deeds, Autonomy Association International</p>
          <p><a href="mailto:support@autonomy.ai" class="text-white"><i class="fas fa-envelope mr-2"></i>Get Support</a></p>
        </div>
      </div>
    </div>
  </footer>

  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
```


## 5. Let's create the Workflow Automation plugin page:

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Workflow Automation - IQSMS Plugin System</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="../css/styles.css">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.1/css/all.css">
</head>
<body>
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
      <a class="navbar-brand" href="../index.html">
        <img src="../images/logo.png" alt="IQSMS Plugin System" height="40">
      </a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item">
            <a class="nav-link" href="../index.html">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="../plugin-development.html">Development</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="../api-reference.html">API Reference</a>
          </li>
          <li class="nav-item dropdown active">
            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown">
              Plugins
            </a>
            <div class="dropdown-menu">
              <a class="dropdown-item" href="cloudflare-api.html">Cloudflare API</a>
              <a class="dropdown-item" href="system-info.html">System Info</a>
              <a class="dropdown-item" href="drone-swarm-loadbalancer.html">Drone Swarm LB</a>
              <a class="dropdown-item" href="database-connector.html">Database Connector</a>
              <a class="dropdown-item" href="authentication-service.html">Authentication Service</a>
              <a class="dropdown-item" href="ai-analytics.html">AI Analytics</a>
              <a class="dropdown-item active" href="workflow-automation.html">Workflow Automation</a>
              <div class="dropdown-divider"></div>
              <a class="dropdown-item" href="index.html">All Plugins</a>
            </div>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <div class="container my-5">
    <div class="row">
      <div class="col-lg-3">
        <div class="sidebar">
          <h5>Contents</h5>
          <nav class="nav flex-column">
            <a class="nav-link" href="#overview">Overview</a>
            <a class="nav-link" href="#features">Key Features</a>
            <a class="nav-link" href="#installation">Installation</a>
            <a class="nav-link" href="#configuration">Configuration</a>
            <a class="nav-link" href="#workflow-types">Workflow Types</a>
            <a class="nav-link" href="#workflow-components">Workflow Components</a>
            <a class="nav-link" href="#api-methods">API Methods</a>
            <a class="nav-link" href="#examples">Examples</a>
          </nav>
        </div>
      </div>
      <div class="col-lg-9">
        <div class="plugin-header d-flex align-items-center">
          <i class="fas fa-cogs fa-3x text-primary mr-4"></i>
          <div>
            <h1>Workflow Automation</h1>
            <p class="lead mb-0">Create, manage, and monitor automated workflows with visual designer, triggers, conditions, and actions</p>
          </div>
        </div>

        <div class="plugin-info mb-4">
          <div class="plugin-info-item">
            <i class="fas fa-code-branch"></i>
            <span>Version: 2.0.1</span>
          </div>
          <div class="plugin-info-item">
            <i class="fas fa-user"></i>
            <span>Publisher: Autonomy Association International</span>
          </div>
          <div class="plugin-info-item">
            <i class="fas fa-coins"></i>
            <span>Cost: 80 tokens</span>
          </div>
        </div>

        <div class="alert alert-primary">
          <i class="fas fa-info-circle mr-2"></i>
          This plugin provides a comprehensive workflow automation system for creating and managing automated processes and tasks.
        </div>

        <section id="overview">
          <h2>Overview</h2>
          <p>The Workflow Automation plugin enables you to create, manage, and monitor automated workflows in your applications. It provides a flexible framework for defining triggers, conditions, and actions that can be combined to automate complex business processes.</p>
          
          <p>With this plugin, you can automate repetitive tasks, create approval workflows, set up notifications, and integrate with other systems, all through an intuitive API or visual workflow designer.</p>
        </section>

        <section id="features" class="mt-5">
          <h2>Key Features</h2>
          
          <div class="row">
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title"><i class="fas fa-sitemap text-primary mr-2"></i>Workflow Design</h5>
                  <ul class="card-text">
                    <li>Visual workflow designer</li>
                    <li>Drag-and-drop components</li>
                    <li>Complex workflow paths</li>
                    <li>Nested workflows</li>
                    <li>Version control</li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title"><i class="fas fa-bolt text-primary mr-2"></i>Triggers & Events</h5>
                  <ul class="card-text">
                    <li>Database change triggers</li>
                    <li>Scheduled triggers</li>
                    <li>API event triggers</li>
                    <li>Manual triggers</li>
                    <li>External service webhooks</li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
          
          <div class="row">
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title"><i class="fas fa-tasks text-primary mr-2"></i>Actions & Tasks</h5>
                  <ul class="card-text">
                    <li>Database operations</li>
                    <li>API calls and integrations</li>
                    <li>Email and notifications</li>
                    <li>File operations</li>
                    <li>Custom script execution</li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title"><i class="fas fa-chart-line text-primary mr-2"></i>Monitoring & Analytics</h5>
                  <ul class="card-text">
                    <li>Real-time workflow monitoring</li>
                    <li>Execution history and logs</li>
                    <li>Performance analytics</li>
                    <li>Error tracking and alerts</li>
                    <li>Custom dashboards</li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </section>

        <section id="installation" class="mt-5">
          <h2>Installation</h2>
          <p>To use the Workflow Automation plugin, you'll need to:</p>
          <ol>
            <li>Install the plugin in your IQSMS Plugin System</li>
            <li>Configure the plugin based on your workflow requirements</li>
            <li>Set up a database for workflow storage</li>
          </ol>

          <h4>Prerequisites</h4>
          <ul>
            <li>Node.js 14.x or higher</li>
            <li>IQSMS Plugin System core</li>
            <li>MongoDB, MySQL, or PostgreSQL database</li>
            <li>Database Connector plugin (recommended)</li>
          </ul>

          <h4>Installing the Plugin</h4>
          <pre><code class="language-javascript">const pluginManager = require('./path/to/PluginManager');
await pluginManager.installPlugin('workflow-automation');</code></pre>
        </section>

        <section id="configuration" class="mt-5">
          <h2>Configuration</h2>
          <p>The plugin provides several configuration options:</p>

          <pre><code class="language-javascript">const config = {
  // Database configuration
  database: {
    type: 'mongodb', // 'mongodb', 'mysql', or 'postgres'
    connection: 'primaryMongo', // Connection name from Database Connector plugin
    collections: {
      workflows: 'workflows',
      executions: 'workflowExecutions',
      tasks: 'workflowTasks',
      triggers: 'workflowTriggers'
    }
  },
  
  // Execution settings
  execution: {
    concurrency: 10, // Maximum concurrent workflow executions
    timeout: 300000, // 5 minutes execution timeout
    retries: {
      maxRetries: 3,
      retryDelay: 60000 // 1 minute between retries
    },
    errorHandling: 'continue' // 'stop', 'continue', or 'branch'
  },
  
  // Trigger settings
  triggers: {
    polling: {
      enabled: true,
      interval: 60000 // 1 minute polling interval
    },
    scheduler: {
      enabled: true,
      checkInterval: 60000 // 1 minute schedule check
    }
  },
  
  // Monitoring settings
  monitoring: {
    enabled: true,
    historyRetention: 30, // days
    detailedLogs: true,
    alerting: {
      enabled: true,
      email: 'admin@example.com',
      errorThreshold: 5 // Alert after 5 errors
    }
  },
  
  // Integration settings
  integrations: {
    email: {
      enabled: true,
      service: 'smtp',
      config: {
        host: 'smtp.example.com',
        port: 587,
        secure: false,
        auth: {
          user: 'notifications@example.com',
          pass: 'your-password'
        }
      }
    },
    webhook: {
      enabled: true,
      timeout: 10000 // 10 seconds
    }
  }
};</code></pre>

          <h4>Loading the Plugin with Configuration</h4>
          <pre><code class="language-javascript">await pluginManager.loadPlugin('workflow-automation', config);</code></pre>
        </section>

        <section id="workflow-types" class="mt-5">
          <h2>Workflow Types</h2>
          <p>The Workflow Automation plugin supports various types of workflows:</p>

          <div class="row">
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title">Sequential Workflows</h5>
                  <p class="card-text">A series of steps executed in order, with each step completing before the next begins.</p>
                  <h6>Example:</h6>
                  <pre><code class="language-javascript">const workflow = await workflowAutomation.createWorkflow({
  name: 'Document Approval Process',
  type: 'sequential',
  steps: [
    { name: 'Submit Document', action: 'documentSubmission' },
    { name: 'Manager Review', action: 'managerReview' },
    { name: 'Department Head Approval', action: 'departmentApproval' },
    { name: 'Final Approval', action: 'finalApproval' },
    { name: 'Document Publishing', action: 'documentPublishing' }
  ]
});</code></pre>
                </div>
              </div>
            </div>
            
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title">Conditional Workflows</h5>
                  <p class="card-text">Workflows with branching paths based on conditions and decision points.</p>
                  <h6>Example:</h6>
                  <pre><code class="language-javascript">const workflow = await workflowAutomation.createWorkflow({
  name: 'Order Processing',
  type: 'conditional',
  trigger: 'newOrder',
  start: 'validateOrder',
  nodes: {
    'validateOrder': {
      type: 'action',
      action: 'validateOrderData',
      next: 'checkInventory'
    },
    'checkInventory': {
      type: 'condition',
      condition: 'isInStock',
      outcomes: {
        true: 'processPayment',
        false: 'backorderProcess'
      }
    },
    'processPayment': {
      type: 'action',
      action: 'chargeCustomer',
      next: 'fulfillOrder'
    },
    'backorderProcess': {
      type: 'action',
      action: 'createBackorder',
      next: 'notifyCustomer'
    },
    'fulfillOrder': {
      type: 'action',
      action: 'createShipment',
      next: 'notifyCustomer'
    },
    'notifyCustomer': {
      type: 'action',
      action: 'sendOrderEmail',
      next: null
    }
  }
});</code></pre>
                </div>
              </div>
            </div>
            
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title">State Machine Workflows</h5>
                  <p class="card-text">Workflows that model entities moving through various states with defined transitions.</p>
                  <h6>Example:</h6>
                  <pre><code class="language-javascript">const workflow = await workflowAutomation.createWorkflow({
  name: 'Support Ticket Lifecycle',
  type: 'stateMachine',
  entity: 'supportTicket',
  initialState: 'new',
  states: {
    'new': {
      description: 'Ticket has been created',
      transitions: {
        'assign': { toState: 'assigned', action: 'assignTicket' },
        'close': { toState: 'closed', action: 'closeTicket' }
      }
    },
    'assigned': {
      description: 'Ticket assigned to agent',
      transitions: {
        'start': { toState: 'inProgress', action: 'startWork' },
        'reassign': { toState: 'assigned', action: 'reassignTicket' },
        'close': { toState: 'closed', action: 'closeTicket' }
      }
    },
    'inProgress': {
      description: 'Agent working on ticket',
      transitions: {
        'resolve': { toState: 'resolved', action: 'resolveTicket' },
        'escalate': { toState: 'escalated', action: 'escalateTicket' },
        'wait': { toState: 'waiting', action: 'waitForInfo' }
      }
    },
    'waiting': {
      description: 'Waiting for customer response',
      transitions: {
        'resume': { toState: 'inProgress', action: 'resumeWork' },
        'timeout': { toState: 'closed', action: 'timeoutTicket' }
      }
    },
    'escalated': {
      description: 'Ticket escalated to specialist',
      transitions: {
        'resolve': { toState: 'resolved', action: 'resolveTicket' },
        'reassign': { toState: 'assigned', action: 'reassignTicket' }
      }
    },
    'resolved': {
      description: 'Issue has been resolved',
      transitions: {
        'close': { toState: 'closed', action: 'closeTicket' },
        'reopen': { toState: 'assigned', action: 'reopenTicket' }
      }
    },
    'closed': {
      description: 'Ticket is closed',
      transitions: {
        'reopen': { toState: 'assigned', action: 'reopenTicket' }
      }
    }
  }
});</code></pre>
                </div>
              </div>
            </div>
            
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title">Parallel Workflows</h5>
                  <p class="card-text">Workflows with multiple branches executing simultaneously and synchronizing at join points.</p>
                  <h6>Example:</h6>
                  <pre><code class="language-javascript">const workflow = await workflowAutomation.createWorkflow({
  name: 'Product Launch',
  type: 'parallel',
  trigger: 'launchApproved',
  start: 'initiateLaunch',
  nodes: {
    'initiateLaunch': {
      type: 'action',
      action: 'createLaunchPlan',
      next: 'parallelTasks'
    },
    'parallelTasks': {
      type: 'fork',
      branches: ['prepareMarketing', 'prepareProduct', 'prepareSales'],
      join: 'finalReview'
    },
    'prepareMarketing': {
      type: 'action',
      action: 'createMarketingCampaign',
      next: 'approveMarketing'
    },
    'approveMarketing': {
      type: 'action',
      action: 'getMarketingApproval',
      next: null // joins automatically
    },
    'prepareProduct': {
      type: 'action',
      action: 'finalizeProduct',
      next: 'deployProduct'
    },
    'deployProduct': {
      type: 'action',
      action: 'deployToProduction',
      next: null // joins automatically
    },
    'prepareSales': {
      type: 'action',
      action: 'trainSalesTeam',
      next: 'prepareSalesMaterials'
    },
    'prepareSalesMaterials': {
      type: 'action',
      action: 'createSalesMaterials',
      next: null // joins automatically
    },
    'finalReview': {
      type: 'action',
      action: 'conductFinalReview',
      next: 'launch'
    },
    'launch': {
      type: 'action',
      action: 'launchProduct',
      next: null
    }
  }
});</code></pre>
                </div>
              </div>
            </div>
          </div>
        </section>

        <section id="workflow-components" class="mt-5">
          <h2>Workflow Components</h2>
          <p>The Workflow Automation plugin provides various components for building workflows:</p>

          <div class="api-method">
            <h3>Triggers</h3>
            <p>Triggers initiate workflow execution when specific events occur.</p>
            
            <h4>Available Trigger Types</h4>
            <table class="table">
              <thead>
                <tr>
                  <th>Type</th>
                  <th>Description</th>
                  <th>Configuration Options</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>Schedule</td>
                  <td>Triggers at specified times or intervals</td>
                  <td>Cron expression, timezone, start/end dates</td>
                </tr>
                <tr>
                  <td>Database</td>
                  <td>Triggers on database changes</td>
                  <td>Collection/table, operation type, conditions</td>
                </tr>
                <tr>
                  <td>API</td>
                  <td>Triggers when API endpoint is called</td>
                  <td>Method, path, authentication requirements</td>
                </tr>
                <tr>
                  <td>Webhook</td>
                  <td>Triggers when webhook receives data</td>
                  <td>URL path, authentication, payload validation</td>
                </tr>
                <tr>
                  <td>Manual</td>
                  <td>Triggers when manually activated</td>
                  <td>Required parameters, permissions</td>
                </tr>
                <tr>
                  <td>File</td>
                  <td>Triggers on file system events</td>
                  <td>Path, event type (create, modify, delete)</td>
                </tr>
              </tbody>
            </table>
            
            <h4>Example</h4>
            <pre><code class="language-javascript">// Create a scheduled trigger
const trigger = await workflowAutomation.createTrigger({
  name: 'Daily Report',
  type: 'schedule',
  workflow: 'workflow-123',
  config: {
    cron: '0 8 * * 1-5', // 8:00 AM Monday-Friday
    timezone: 'America/New_York'
  }
});

// Create a database trigger
const dbTrigger = await workflowAutomation.createTrigger({
  name: 'New Order',
  type: 'database',
  workflow: 'workflow-456',
  config: {
    connection: 'primaryMongo',
    collection: 'orders',
    operation: 'insert',
    conditions: {
      status: 'new'
    }
  }
});</code></pre>
          </div>

          <div class="api-method mt-4">
            <h3>Actions</h3>
            <p>Actions perform tasks within workflows.</p>
            
            <h4>Available Action Types</h4>
            <table class="table">
              <thead>
                <tr>
                  <th>Type</th>
                  <th>Description</th>
                  <th>Configuration Options</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>Database</td>
                  <td>Performs database operations</td>
                  <td>Connection, collection/table, operation, data</td>
                </tr>
                <tr>
                  <td>HTTP</td>
                  <td>Makes HTTP requests to external services</td>
                  <td>URL, method, headers, body, authentication</td>
                </tr>
                <tr>
                  <td>Email</td>
                  <td>Sends emails</td>
                  <td>Recipients, subject, body, attachments</td>
                </tr>
                <tr>
                  <td>Notification</td>
                  <td>Sends system notifications</td>
                  <td>Recipients, channel, message, priority</td>
                </tr>
                <tr>
                  <td>File</td>
                  <td>Performs file operations</td>
                  <td>Path, operation, content, options</td>
                </tr>
                <tr>
                  <td>Script</td>
                  <td>Executes custom scripts</td>
                  <td>Language, code, arguments, timeout</td>
                </tr>
                <tr>
                  <td>Wait</td>
                  <td>Waits for a specified duration or condition</td>
                  <td>Duration, condition, timeout</td>
                </tr>
                <tr>
                  <td>Custom</td>
                  <td>Executes custom action handlers</td>
                  <td>Handler, parameters</td>
                </tr>
              </tbody>
            </table>
            
            <h4>Example</h4>
            <pre><code class="language-javascript">// Create a database action
const action = await workflowAutomation.createAction({
  name: 'Update Order Status',
  type: 'database',
  config: {
    connection: 'primaryMongo',
    collection: 'orders',
    operation: 'update',
    conditions: {
      _id: '{{orderId}}'
    },
    data: {
      $set: {
        status: '{{status}}',
        updatedAt: '{{now}}'
      }
    }
  }
});

// Create an HTTP action
const httpAction = await workflowAutomation.createAction({
  name: 'Send to Shipping API',
  type: 'http',
  config: {
    url: 'https://shipping-api.example.com/orders',
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer {{shippingApiKey}}'
    },
    body: {
      orderId: '{{orderId}}',
      customer: {
        name: '{{customer.name}}',
        address: '{{customer.address}}'
      },
      items: '{{items}}',
      shippingMethod: '{{shippingMethod}}'
    }
  }
});</code></pre>
          </div>

          <div class="api-method mt-4">
            <h3>Conditions</h3>
            <p>Conditions determine workflow paths based on data evaluation.</p>
            
            <h4>Available Condition Types</h4>
            <table class="table">
              <thead>
                <tr>
                  <th>Type</th>
                  <th>Description</th>
                  <th>Configuration Options</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>Expression</td>
                  <td>Evaluates a JavaScript expression</td>
                  <td>Expression, variables</td>
                </tr>
                <tr>
                  <td>Comparison</td>
                  <td>Compares values</td>
                  <td>Left operand, operator, right operand</td>
                </tr>
                <tr>
                  <td>Logic</td>
                  <td>Combines multiple conditions</td>
                  <td>Operator (AND, OR), conditions</td>
                </tr>
                <tr>
                  <td>Exists</td>
                  <td>Checks if a value exists</td>
                  <td>Path, negate</td>
                </tr>
                <tr>
                  <td>Script</td>
                  <td>Evaluates a custom script</td>
                  <td>Language, code, arguments, timeout</td>
                </tr>
              </tbody>
            </table>
            
            <h4>Example</h4>
            <pre><code class="language-javascript">// Create a comparison condition
const condition = await workflowAutomation.createCondition({
  name: 'Is High Value Order',
  type: 'comparison',
  config: {
    left: '{{order.total}}',
    operator: '>=',
    right: 1000
  }
});

// Create a logic condition
const logicCondition = await workflowAutomation.createCondition({
  name: 'Is Priority Customer with Large Order',
  type: 'logic',
  config: {
    operator: 'AND',
    conditions: [
      {
        type: 'comparison',
        config: {
          left: '{{customer.tier}}',
          operator: '==',
          right: 'premium'
        }
      },
      {
        type: 'comparison',
        config: {
          left: '{{order.itemCount}}',
          operator: '>',
          right: 10
        }
      }
    ]
  }
});</code></pre>
          </div>
        </section>

        <section id="api-methods" class="mt-5">
          <h2>API Methods</h2>
          <p>The Workflow Automation plugin provides a comprehensive API:</p>

          <div class="accordion" id="apiAccordion">
            <div class="card">
              <div class="card-header" id="headingOne">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapseOne">
                    Workflow Management Methods
                  </button>
                </h2>
              </div>
              <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#apiAccordion">
                <div class="card-body">
                  <ul>
                    <li><code>createWorkflow(definition)</code> - Create a new workflow</li>
                    <li><code>getWorkflow(workflowId)</code> - Get a workflow by ID</li>
                    <li><code>updateWorkflow(workflowId, updates)</code> - Update a workflow</li>
                    <li><code>deleteWorkflow(workflowId)</code> - Delete a workflow</li>
                    <li><code>listWorkflows(filter)</code> - List workflows</li>
                    <li><code>exportWorkflow(workflowId, format)</code> - Export a workflow</li>
                    <li><code>importWorkflow(definition)</code> - Import a workflow</li>
                    <li><code>cloneWorkflow(workflowId, newName)</code> - Clone a workflow</li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="card">
              <div class="card-header" id="headingTwo">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo">
                    Component Management Methods
                  </button>
                </h2>
              </div>
              <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#apiAccordion">
                <div class="card-body">
                  <ul>
                    <li><code>createTrigger(definition)</code> - Create a trigger</li>
                    <li><code>getTrigger(triggerId)</code> - Get a trigger</li>
                    <li><code>updateTrigger(triggerId, updates)</code> - Update a trigger</li>
                    <li><code>deleteTrigger(triggerId)</code> - Delete a trigger</li>
                    <li><code>createAction(definition)</code> - Create an action</li>
                    <li><code>getAction(actionId)</code> - Get an action</li>
                    <li><code>updateAction(actionId, updates)</code> - Update an action</li>
                    <li><code>deleteAction(actionId)</code> - Delete an action</li>
                    <li><code>createCondition(definition)</code> - Create a condition</li>
                    <li><code>getCondition(conditionId)</code> - Get a condition</li>
                    <li><code>updateCondition(conditionId, updates)</code> - Update a condition</li>
                    <li><code>deleteCondition(conditionId)</code> - Delete a condition</li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="card">
              <div class="card-header" id="headingThree">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseThree">
                    Execution Methods
                  </button>
                </h2>
              </div>
              <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#apiAccordion">
                <div class="card-body">
                  <ul>
                    <li><code>startWorkflow(workflowId, data)</code> - Start a workflow</li>
                    <li><code>stopExecution(executionId)</code> - Stop a workflow execution</li>
                    <li><code>pauseExecution(executionId)</code> - Pause a workflow execution</li>
                    <li><code>resumeExecution(executionId)</code> - Resume a workflow execution</li>
                    <li><code>getExecution(executionId)</code> - Get execution details</li>
                    <li><code>listExecutions(filter)</code> - List workflow executions</li>
                    <li><code>getExecutionHistory(executionId)</code> - Get execution history</li>
                    <li><code>retryExecution(executionId)</code> - Retry a failed execution</li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="card">
              <div class="card-header" id="headingFour">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseFour">
                    Monitoring Methods
                  </button>
                </h2>
              </div>
              <div id="collapseFour" class="collapse" aria-labelledby="headingFour" data-parent="#apiAccordion">
                <div class="card-body">
                  <ul>
                    <li><code>getWorkflowStats(workflowId, period)</code> - Get workflow statistics</li>
                    <li><code>getActiveExecutions()</code> - Get currently active executions</li>
                    <li><code>getSystemStats()</code> - Get system-wide statistics</li>
                    <li><code>getErrorReport(filter)</code> - Get error report</li>
                    <li><code>getExecutionLogs(executionId)</code> - Get execution logs</li>
                    <li><code>createAlert(definition)</code> - Create a monitoring alert</li>
                    <li><code>getAlert(alertId)</code> - Get an alert</li>
                    <li><code>updateAlert(alertId, updates)</code> - Update an alert</li>
                    <li><code>deleteAlert(alertId)</code> - Delete an alert</li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </section>

        <section id="examples" class="mt-5">
          <h2>Examples</h2>
          
          <div class="api-method">
            <h4>Order Processing Workflow</h4>
            <pre><code class="language-javascript">// Create an order processing workflow
const workflow = await workflowAutomation.createWorkflow({
  name: 'Order Processing Workflow',
  description: 'Process new orders from submission to fulfillment',
  type: 'conditional',
  version: '1.0',
  trigger: {
    type: 'database',
    config: {
      connection: 'primaryMongo',
      collection: 'orders',
      operation: 'insert',
      conditions: { status: 'new' }
    }
  },
  variables: {
    order: { type: 'object', required: true },
    customer: { type: 'object', required: true },
    paymentResult: { type: 'object' },
    shippingInfo: { type: 'object' }
  },
  nodes: {
    'start': {
      type: 'action',
      action: {
        type: 'database',
        config: {
          connection: 'primaryMongo',
          collection: 'orders',
          operation: 'update',
          conditions: { _id: '{{order._id}}' },
          data: { $set: { status: 'processing', processedAt: '{{now}}' } }
        }
      },
      next: 'validateOrder'
    },
    'validateOrder': {
      type: 'action',
      action: {
        type: 'script',
        config: {
          language: 'javascript',
          code: `
            const order = workflowData.order;
            
            // Validate order items
            if (!order.items || order.items.length === 0) {
              return { valid: false, error: 'No items in order' };
            }
            
            // Validate customer information
            if (!workflowData.customer.email) {
              return { valid: false, error: 'Missing customer email' };
            }
            
            return { valid: true };
          `
        }
      },
      next: 'checkOrderValidity'
    },
    'checkOrderValidity': {
      type: 'condition',
      condition: {
        type: 'expression',
        config: {
          expression: 'workflowData.validateOrder.valid === true'
        }
      },
      outcomes: {
        true: 'checkInventory',
        false: 'handleInvalidOrder'
      }
    },
    'handleInvalidOrder': {
      type: 'action',
      action: {
        type: 'database',
        config: {
          connection: 'primaryMongo',
          collection: 'orders',
          operation: 'update',
          conditions: { _id: '{{order._id}}' },
          data: {
            $set: {
              status: 'invalid',
              error: '{{validateOrder.error}}',
              updatedAt: '{{now}}'
            }
          }
        }
      },
      next: 'sendRejectionEmail'
    },
    'sendRejectionEmail': {
      type: 'action',
      action: {
        type: 'email',
        config: {
          to: '{{customer.email}}',
          subject: 'Your order {{order._id}} could not be processed',
          body: 'Dear {{customer.name}},\n\nWe were unable to process your order due to the following issue: {{validateOrder.error}}.\n\nPlease update your order and try again.\n\nThank you,\nThe Store Team'
        }
      },
      next: null
    },
    'checkInventory': {
      type: 'action',
      action: {
        type: 'http',
        config: {
          url: 'https://inventory-api.example.com/check',
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer {{env.INVENTORY_API_KEY}}'
          },
          body: {
            items: '{{order.items}}'
          }
        }
      },
      next: 'checkInventoryResult'
    },
    'checkInventoryResult': {
      type: 'condition',
      condition: {
        type: 'expression',
        config: {
          expression: 'workflowData.checkInventory.inStock === true'
        }
      },
      outcomes: {
        true: 'processPayment',
        false: 'handleOutOfStock'
      }
    },
    // More nodes for payment processing, fulfillment, etc.
  }
});

// Start a workflow execution with data
const execution = await workflowAutomation.startWorkflow(
  workflow.id,
  {
    order: {
      _id: 'order-123',
      items: [
        { id: 'product-1', quantity: 2, price: 25.99 },
        { id: 'product-2', quantity: 1, price: 49.99 }
      ],
      total: 101.97
    },
    customer: {
      _id: 'customer-456',
      name: 'John Doe',
      email: 'john.doe@example.com',
      address: {
        street: '123 Main St',
        city: 'Anytown',
        state: 'CA',
        zipCode: '12345'
      }
    }
  }
);</code></pre>
            
            <h4>Document Approval Workflow</h4>
            <pre><code class="language-javascript">// Create a document approval workflow
const workflow = await workflowAutomation.createWorkflow({
  name: 'Document Approval Workflow',
  description: 'Multi-step approval process for documents',
  type: 'stateMachine',
  version: '1.0',
  entity: 'document',
  initialState: 'draft',
  variables: {
    document: { type: 'object', required: true },
    approvers: { type: 'array', required: true },
    currentApprover: { type: 'object' },
    approvalHistory: { type: 'array', default: [] }
  },
  states: {
    'draft': {
      description: 'Document is in draft state',
      onEnter: {
        type: 'action',
        action: {
          type: 'database',
          config: {
            connection: 'primaryMongo',
            collection: 'documents',
            operation: 'update',
            conditions: { _id: '{{document._id}}' },
            data: {
              $set: {
                status: 'draft',
                updatedAt: '{{now}}'
              }
            }
          }
        }
      },
      transitions: {
        'submit': {
          toState: 'pendingApproval',
          conditions: [
            {
              type: 'expression',
              config: {
                expression: 'workflowData.document.content && workflowData.document.content.length > 0'
              }
            }
          ],
          action: {
            type: 'action',
            action: {
              type: 'script',
              config: {
                language: 'javascript',
                code: `
                  // Set the first approver
                  const approvers = workflowData.approvers;
                  if (!approvers || approvers.length === 0) {
                    throw new Error('No approvers specified');
                  }
                  
                  return {
                    currentApprover: approvers[0],
                    approvalHistory: []
                  };
                `
              }
            }
          }
        }
      }
    },
    'pendingApproval': {
      description: 'Document is waiting for approval',
      onEnter: {
        type: 'action',
        action: {
          type: 'email',
          config: {
            to: '{{currentApprover.email}}',
            subject: 'Document Approval Request',
            body: 'Hello {{currentApprover.name}},\n\nA document requires your approval: {{document.title}}.\n\nPlease review and approve or reject it.\n\nThank you.'
          }
        }
      },
      transitions: {
        'approve': {
          toState: 'approved',
          action: {
            type: 'action',
            action: {
              type: 'script',
              config: {
                language: 'javascript',
                code: `
                  // Add to approval history
                  const history = workflowData.approvalHistory || [];
                  history.push({
                    approver: workflowData.currentApprover,
                    decision: 'approved',
                    timestamp: new Date().toISOString(),
                    comments: workflowData.comments || ''
                  });
                  
                  // Find next approver
                  const approvers = workflowData.approvers;
                  const currentIndex = approvers.findIndex(a => 
                    a.id === workflowData.currentApprover.id
                  );
                  
                  const nextIndex = currentIndex + 1;
                  const nextApprover = nextIndex < approvers.length ? 
                    approvers[nextIndex] : null;
                  
                  return {
                    approvalHistory: history,
                    currentApprover: nextApprover,
                    needsMoreApprovals: nextApprover !== null
                  };
                `
              }
            }
          },
          conditions: []
        },
        'reject': {
          toState: 'rejected',
          action: {
            type: 'action',
            action: {
              type: 'script',
              config: {
                language: 'javascript',
                code: `
                  // Add to approval history
                  const history = workflowData.approvalHistory || [];
                  history.push({
                    approver: workflowData.currentApprover,
                    decision: 'rejected',
                    timestamp: new Date().toISOString(),
                    comments: workflowData.comments || ''
                  });
                  
                  return {
                    approvalHistory: history
                  };
                `
              }
            }
          },
          conditions: []
        }
      }
    },
    'approved': {
      description: 'Document is approved',
      onEnter: {
        type: 'condition',
        condition: {
          type: 'expression',
          config: {
            expression: 'workflowData.needsMoreApprovals === true'
          }
        },
        outcomes: {
          true: {
            type: 'transition',
            transition: 'nextApproval'
          },
          false: {
            type: 'action',
            action: {
              type: 'database',
              config: {
                connection: 'primaryMongo',
                collection: 'documents',
                operation: 'update',
                conditions: { _id: '{{document._id}}' },
                data: {
                  $set: {
                    status: 'approved',
                    approvalHistory: '{{approvalHistory}}',
                    approvedAt: '{{now}}'
                  }
                }
              }
            }
          }
        }
      },
      transitions: {
        'nextApproval': {
          toState: 'pendingApproval',
          conditions: []
        },
        'publish': {
          toState: 'published',
          conditions: [
            {
              type: 'expression',
              config: {
                expression: 'workflowData.needsMoreApprovals !== true'
              }
            }
          ]
        }
      }
    },
    'rejected': {
      description: 'Document is rejected',
      onEnter: {
        type: 'action',
        action: {
          type: 'database',
          config: {
            connection: 'primaryMongo',
            collection: 'documents',
            operation: 'update',
            conditions: { _id: '{{document._id}}' },
            data: {
              $set: {
                status: 'rejected',
                approvalHistory: '{{approvalHistory}}',
                rejectedAt: '{{now}}'
              }
            }
          }
        }
      },
      transitions: {
        'revise': {
          toState: 'draft',
          conditions: []
        }
      }
    },
    'published': {
      description: 'Document is published',
      onEnter: {
        type: 'action',
        action: {
          type: 'database',
          config: {
            connection: 'primaryMongo',
            collection: 'documents',
            operation: 'update',
            conditions: { _id: '{{document._id}}' },
            data: {
              $set: {
                status: 'published',
                publishedAt: '{{now}}'
              }
            }
          }
        }
      },
      transitions: {
        'archive': {
          toState: 'archived',
          conditions: []
        },
        'revise': {
          toState: 'draft',
          conditions: []
        }
      }
    },
    'archived': {
      description: 'Document is archived',
      onEnter: {
        type: 'action',
        action: {
          type: 'database',
          config: {
            connection: 'primaryMongo',
            collection: 'documents',
            operation: 'update',
            conditions: { _id: '{{document._id}}' },
            data: {
              $set: {
                status: 'archived',
                archivedAt: '{{now}}'
              }
            }
          }
        }
      },
      transitions: {
        'restore': {
          toState: 'draft',
          conditions: []
        }
      }
    }
  }
});</code></pre>
          </div>
        </section>

        <div class="alert alert-info mt-5">
          <h5><i class="fas fa-lightbulb mr-2"></i>Related Documentation</h5>
          <ul class="mb-0">
            <li><a href="../api-reference.html">API Reference</a> - Complete API documentation</li>
            <li><a href="../examples.html">Code Examples</a> - More usage examples</li>
            <li><a href="../troubleshooting.html">Troubleshooting Guide</a> - Solutions for common issues</li>
            <li><a href="database-connector.html">Database Connector</a> - Data source integration</li>
          </ul>
        </div>
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
          <p>Written by Greg Deeds, Autonomy Association International</p>
          <p><a href="mailto:support@autonomy.ai" class="text-white"><i class="fas fa-envelope mr-2"></i>Get Support</a></p>
        </div>
      </div>
    </div>
  </footer>

  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
```


## 6. Let's create the Network Monitor plugin page:

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Network Monitor - IQSMS Plugin System</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="../css/styles.css">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.1/css/all.css">
</head>
<body>
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
      <a class="navbar-brand" href="../index.html">
        <img src="../images/logo.png" alt="IQSMS Plugin System" height="40">
      </a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item">
            <a class="nav-link" href="../index.html">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="../plugin-development.html">Development</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="../api-reference.html">API Reference</a>
          </li>
          <li class="nav-item dropdown active">
            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown">
              Plugins
            </a>
            <div class="dropdown-menu">
              <a class="dropdown-item" href="cloudflare-api.html">Cloudflare API</a>
              <a class="dropdown-item" href="system-info.html">System Info</a>
              <a class="dropdown-item" href="drone-swarm-loadbalancer.html">Drone Swarm LB</a>
              <a class="dropdown-item" href="database-connector.html">Database Connector</a>
              <a class="dropdown-item" href="authentication-service.html">Authentication Service</a>
              <a class="dropdown-item" href="ai-analytics.html">AI Analytics</a>
              <a class="dropdown-item" href="workflow-automation.html">Workflow Automation</a>
              <a class="dropdown-item active" href="network-monitor.html">Network Monitor</a>
              <div class="dropdown-divider"></div>
              <a class="dropdown-item" href="index.html">All Plugins</a>
            </div>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <div class="container my-5">
    <div class="row">
      <div class="col-lg-3">
        <div class="sidebar">
          <h5>Contents</h5>
          <nav class="nav flex-column">
            <a class="nav-link" href="#overview">Overview</a>
            <a class="nav-link" href="#features">Key Features</a>
            <a class="nav-link" href="#installation">Installation</a>
            <a class="nav-link" href="#configuration">Configuration</a>
            <a class="nav-link" href="#network-discovery">Network Discovery</a>
            <a class="nav-link" href="#traffic-analysis">Traffic Analysis</a>
            <a class="nav-link" href="#monitoring">Monitoring & Alerts</a>
            <a class="nav-link" href="#api-methods">API Methods</a>
            <a class="nav-link" href="#examples">Examples</a>
          </nav>
        </div>
      </div>
      <div class="col-lg-9">
        <div class="plugin-header d-flex align-items-center">
          <i class="fas fa-network-wired fa-3x text-primary mr-4"></i>
          <div>
            <h1>Network Monitor</h1>
            <p class="lead mb-0">Comprehensive network monitoring with traffic analysis, device discovery, and alerting capabilities</p>
          </div>
        </div>

        <div class="plugin-info mb-4">
          <div class="plugin-info-item">
            <i class="fas fa-code-branch"></i>
            <span>Version: 1.1.0</span>
          </div>
          <div class="plugin-info-item">
            <i class="fas fa-user"></i>
            <span>Publisher: Autonomy Association International</span>
          </div>
          <div class="plugin-info-item">
            <i class="fas fa-coins"></i>
            <span>Cost: 60 tokens</span>
          </div>
        </div>

        <div class="alert alert-primary">
          <i class="fas fa-info-circle mr-2"></i>
          This plugin provides comprehensive network monitoring, traffic analysis, device discovery, and alerting capabilities.
        </div>

        <section id="overview">
          <h2>Overview</h2>
          <p>The Network Monitor plugin provides a comprehensive solution for monitoring network performance, discovering devices, analyzing traffic patterns, and generating alerts. It helps you maintain optimal network operations by providing real-time insights into your network infrastructure.</p>
          
          <p>Whether you need to monitor a small office network or a complex enterprise infrastructure, the Network Monitor plugin offers the tools you need to understand network behavior, identify potential issues, and ensure reliable connectivity.</p>
        </section>

        <section id="features" class="mt-5">
          <h2>Key Features</h2>
          
          <div class="row">
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title"><i class="fas fa-search text-primary mr-2"></i>Network Discovery</h5>
                  <ul class="card-text">
                    <li>Automatic device discovery</li>
                    <li>Device identification and classification</li>
                    <li>Network topology mapping</li>
                    <li>Port scanning and service detection</li>
                    <li>IP range scanning</li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title"><i class="fas fa-chart-line text-primary mr-2"></i>Performance Monitoring</h5>
                  <ul class="card-text">
                    <li>Bandwidth usage tracking</li>
                    <li>Latency and packet loss monitoring</li>
                    <li>Interface statistics</li>
                    <li>Quality of Service (QoS) analysis</li>
                    <li>Historical performance data</li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
          
          <div class="row">
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title"><i class="fas fa-exchange-alt text-primary mr-2"></i>Traffic Analysis</h5>
                  <ul class="card-text">
                    <li>Protocol analysis</li>
                    <li>Application identification</li>
                    <li>Traffic flow monitoring</li>
                    <li>Packet inspection</li>
                    <li>Bandwidth utilization by service</li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title"><i class="fas fa-bell text-primary mr-2"></i>Alerting & Reporting</h5>
                  <ul class="card-text">
                    <li>Customizable alert thresholds</li>
                    <li>Email and SMS notifications</li>
                    <li>Scheduled reports</li>
                    <li>Alert escalation workflows</li>
                    <li>Integration with incident management</li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </section>

        <section id="installation" class="mt-5">
          <h2>Installation</h2>
          <p>To use the Network Monitor plugin, you'll need to:</p>
          <ol>
            <li>Install the plugin in your IQSMS Plugin System</li>
            <li>Configure the plugin based on your network monitoring requirements</li>
            <li>Set up a database for storing monitoring data</li>
          </ol>

          <h4>Prerequisites</h4>
          <ul>
            <li>Node.js 14.x or higher</li>
            <li>IQSMS Plugin System core</li>
            <li>MongoDB, MySQL, or PostgreSQL database</li>
            <li>Sufficient network access permissions</li>
            <li>libpcap or WinPcap for packet capture (optional)</li>
          </ul>

          <h4>Installing the Plugin</h4>
          <pre><code class="language-javascript">const pluginManager = require('./path/to/PluginManager');
await pluginManager.installPlugin('network-monitor');</code></pre>
          
          <h4>Additional Dependencies</h4>
          <p>Some features require additional dependencies:</p>
          <pre><code class="language-bash"># For packet capture and analysis
npm install pcap libpcap

# For SNMP monitoring
npm install net-snmp

# For network scanning
npm install network-scanner</code></pre>
        </section>

        <section id="configuration" class="mt-5">
          <h2>Configuration</h2>
          <p>The plugin provides several configuration options:</p>

          <pre><code class="language-javascript">const config = {
  // Database configuration
  database: {
    type: 'mongodb', // 'mongodb', 'mysql', or 'postgres'
    connection: 'primaryMongo', // Connection name from Database Connector plugin
    collections: {
      devices: 'networkDevices',
      interfaces: 'networkInterfaces',
      traffic: 'networkTraffic',
      alerts: 'networkAlerts'
    }
  },
  
  // Network discovery configuration
  discovery: {
    enabled: true,
    scanInterval: 3600000, // 1 hour
    ipRanges: ['192.168.1.0/24', '10.0.0.0/24'],
    excludedIps: ['192.168.1.100', '192.168.1.101'],
    ports: [22, 80, 443, 3306, 5432, 27017],
    scanTimeout: 2000, // 2 seconds
    deviceIdentification: true,
    topologyMapping: true
  },
  
  // Traffic monitoring configuration
  traffic: {
    enabled: true,
    interfaces: ['eth0', 'eth1'],
    capturePackets: false, // Enable for detailed packet analysis
    sampleRate: 1000, // 1 second
    retentionPeriod: {
      detailed: '7d', // 7 days for detailed data
      hourly: '30d', // 30 days for hourly aggregates
      daily: '365d' // 1 year for daily aggregates
    }
  },
  
  // SNMP monitoring configuration
  snmp: {
    enabled: true,
    devices: [
      {
        host: '192.168.1.1',
        community: 'public',
        version: 2,
        port: 161
      }
    ],
    pollInterval: 60000, // 1 minute
    timeout: 5000 // 5 seconds
  },
  
  // Alert configuration
  alerts: {
    enabled: true,
    thresholds: {
      cpu: 90, // 90% CPU usage
      memory: 90, // 90% memory usage
      bandwidth: 90, // 90% bandwidth utilization
      latency: 100, // 100ms latency
      packetLoss: 5 // 5% packet loss
    },
    notifications: {
      email: {
        enabled: true,
        recipients: ['admin@example.com'],
        from: 'alerts@example.com'
      },
      sms: {
        enabled: false,
        recipients: ['+12345678901']
      },
      webhook: {
        enabled: false,
        url: 'https://example.com/webhook'
      }
    }
  }
};</code></pre>

          <h4>Loading the Plugin with Configuration</h4>
          <pre><code class="language-javascript">await pluginManager.loadPlugin('network-monitor', config);</code></pre>
        </section>

        <section id="network-discovery" class="mt-5">
          <h2>Network Discovery</h2>
          <p>The Network Monitor plugin provides powerful network discovery capabilities:</p>

          <div class="api-method">
            <h3>discoverDevices(options)</h3>
            <p>Discovers devices on the network.</p>
            
            <h4>Parameters</h4>
            <table class="table">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Type</th>
                  <th>Required</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>options</td>
                  <td>object</td>
                  <td>No</td>
                  <td>Discovery options</td>
                </tr>
              </tbody>
            </table>
            
            <h4>Returns</h4>
            <p>An array of discovered devices.</p>
            
            <h4>Example</h4>
            <pre><code class="language-javascript">const devices = await networkMonitor.discoverDevices({
  ipRanges: ['192.168.1.0/24'],
  ports: [22, 80, 443, 8080],
  timeout: 2000,
  parallel: 10
});

console.log(`Discovered ${devices.length} devices`);
devices.forEach(device => {
  console.log(`Device: ${device.hostname || device.ip}`);
  console.log(`  Type: ${device.type}`);
  console.log(`  MAC: ${device.mac}`);
  console.log(`  Open ports: ${device.ports.join(', ')}`);
});</code></pre>
          </div>

          <div class="api-method mt-4">
            <h3>createNetworkMap(options)</h3>
            <p>Creates a map of the network topology.</p>
            
            <h4>Parameters</h4>
            <table class="table">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Type</th>
                  <th>Required</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>options</td>
                  <td>object</td>
                  <td>No</td>
                  <td>Mapping options</td>
                </tr>
              </tbody>
            </table>
            
            <h4>Returns</h4>
            <p>A network topology map object.</p>
            
            <h4>Example</h4>
            <pre><code class="language-javascript">const networkMap = await networkMonitor.createNetworkMap({
  includeEndpoints: true,
  detectVLANs: true,
  traceRoutes: true
});

console.log(`Network map created with ${networkMap.nodes.length} nodes and ${networkMap.links.length} links`);

// Export network map to JSON
await networkMonitor.exportNetworkMap(networkMap, {
  format: 'json',
  filePath: './network-map.json'
});

// Visualize network map
await networkMonitor.visualizeNetworkMap(networkMap, {
  container: '#network-map-container',
  width: 800,
  height: 600
});</code></pre>
          </div>
        </section>

        <section id="traffic-analysis" class="mt-5">
          <h2>Traffic Analysis</h2>
          <p>The Network Monitor plugin provides comprehensive traffic analysis capabilities:</p>

          <div class="api-method">
            <h3>startTrafficMonitoring(options)</h3>
            <p>Starts monitoring network traffic.</p>
            
            <h4>Parameters</h4>
            <table class="table">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Type</th>
                  <th>Required</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>options</td>
                  <td>object</td>
                  <td>No</td>
                  <td>Monitoring options</td>
                </tr>
              </tbody>
            </table>
            
            <h4>Returns</h4>
            <p>A monitoring session object.</p>
            
            <h4>Example</h4>
            <pre><code class="language-javascript">const monitoringSession = await networkMonitor.startTrafficMonitoring({
  interface: 'eth0',
  capturePackets: true,
  filter: 'tcp port 80 or tcp port 443',
  duration: 3600000 // 1 hour
});

console.log(`Traffic monitoring started on ${monitoringSession.interface}`);
console.log(`Session ID: ${monitoringSession.id}`);</code></pre>
          </div>

          <div class="api-method mt-4">
            <h3>getTrafficAnalysis(sessionId, options)</h3>
            <p>Gets traffic analysis results for a monitoring session.</p>
            
            <h4>Parameters</h4>
            <table class="table">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Type</th>
                  <th>Required</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>sessionId</td>
                  <td>string</td>
                  <td>Yes</td>
                  <td>Monitoring session ID</td>
                </tr>
                <tr>
                  <td>options</td>
                  <td>object</td>
                  <td>No</td>
                  <td>Analysis options</td>
                </tr>
              </tbody>
            </table>
            
            <h4>Returns</h4>
            <p>Traffic analysis results.</p>
            
            <h4>Example</h4>
            <pre><code class="language-javascript">const trafficAnalysis = await networkMonitor.getTrafficAnalysis(
  monitoringSession.id,
  {
    groupBy: 'protocol',
    topN: 10,
    includePacketSamples: false
  }
);

console.log('Traffic Analysis Results:');
console.log(`Total bytes: ${trafficAnalysis.totalBytes}`);
console.log(`Total packets: ${trafficAnalysis.totalPackets}`);

console.log('Top Protocols:');
trafficAnalysis.byProtocol.forEach(protocol => {
  console.log(`  ${protocol.name}: ${(protocol.percentage).toFixed(2)}% (${protocol.bytes} bytes)`);
});

console.log('Top Source IPs:');
trafficAnalysis.bySourceIp.forEach(source => {
  console.log(`  ${source.ip}: ${(source.percentage).toFixed(2)}% (${source.bytes} bytes)`);
});

console.log('Top Destination IPs:');
trafficAnalysis.byDestinationIp.forEach(destination => {
  console.log(`  ${destination.ip}: ${(destination.percentage).toFixed(2)}% (${destination.bytes} bytes)`);
});</code></pre>
          </div>
        </section>

        <section id="monitoring" class="mt-5">
          <h2>Monitoring & Alerts</h2>
          <p>The Network Monitor plugin provides comprehensive monitoring and alerting capabilities:</p>

          <div class="api-method">
            <h3>monitorDevice(deviceId, options)</h3>
            <p>Monitors a specific network device.</p>
            
            <h4>Parameters</h4>
            <table class="table">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Type</th>
                  <th>Required</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>deviceId</td>
                  <td>string</td>
                  <td>Yes</td>
                  <td>Device ID or IP address</td>
                </tr>
                <tr>
                  <td>options</td>
                  <td>object</td>
                  <td>No</td>
                  <td>Monitoring options</td>
                </tr>
              </tbody>
            </table>
            
            <h4>Returns</h4>
            <p>A device monitoring session object.</p>
            
            <h4>Example</h4>
            <pre><code class="language-javascript">const deviceMonitoring = await networkMonitor.monitorDevice(
  '192.168.1.1',
  {
    metrics: ['cpu', 'memory', 'bandwidth', 'connections'],
    interval: 60000, // 1 minute
    snmp: {
      community: 'public',
      version: 2
    }
  }
);

console.log(`Device monitoring started for ${deviceMonitoring.deviceId}`);
console.log(`Monitoring ID: ${deviceMonitoring.id}`);</code></pre>
          </div>

          <div class="api-method mt-4">
            <h3>createAlert(definition)</h3>
            <p>Creates a network monitoring alert.</p>
            
            <h4>Parameters</h4>
            <table class="table">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Type</th>
                  <th>Required</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>definition</td>
                  <td>object</td>
                  <td>Yes</td>
                  <td>Alert definition</td>
                </tr>
              </tbody>
            </table>
            
            <h4>Returns</h4>
            <p>The created alert object.</p>
            
            <h4>Example</h4>
            <pre><code class="language-javascript">const alert = await networkMonitor.createAlert({
  name: 'High Bandwidth Usage Alert',
  description: 'Alerts when bandwidth usage exceeds threshold',
  target: {
    type: 'device',
    id: '192.168.1.1',
    interface: 'eth0'
  },
  metric: 'bandwidth',
  condition: {
    operator: '>',
    threshold: 90, // 90%
    duration: 300000 // 5 minutes
  },
  severity: 'warning',
  notifications: {
    email: {
      enabled: true,
      recipients: ['admin@example.com'],
      subject: 'High Bandwidth Usage Alert'
    }
  },
  autoResolve: true
});

console.log(`Alert created with ID: ${alert.id}`);</code></pre>
          </div>

          <div class="api-method mt-4">
            <h3>getNetworkStatus(options)</h3>
            <p>Gets the current status of the network.</p>
            
            <h4>Parameters</h4>
            <table class="table">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Type</th>
                  <th>Required</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>options</td>
                  <td>object</td>
                  <td>No</td>
                  <td>Status options</td>
                </tr>
              </tbody>
            </table>
            
            <h4>Returns</h4>
            <p>The current network status.</p>
            
            <h4>Example</h4>
            <pre><code class="language-javascript">const networkStatus = await networkMonitor.getNetworkStatus({
  includeDevices: true,
  includeInterfaces: true,
  includeAlerts: true
});

console.log('Network Status:');
console.log(`Overall health: ${networkStatus.health.score}% (${networkStatus.health.grade})`);
console.log(`Active devices: ${networkStatus.devices.active} of ${networkStatus.devices.total}`);
console.log(`Active alerts: ${networkStatus.alerts.active.length}`);

console.log('Bandwidth Usage:');
Object.entries(networkStatus.bandwidth).forEach(([interface, usage]) => {
  console.log(`  ${interface}: ${usage.in.toFixed(2)} Mbps in, ${usage.out.toFixed(2)} Mbps out (${usage.utilization.toFixed(2)}%)`);
});

if (networkStatus.alerts.active.length > 0) {
  console.log('Active Alerts:');
  networkStatus.alerts.active.forEach(alert => {
    console.log(`  ${alert.severity.toUpperCase()}: ${alert.name} - ${alert.message}`);
  });
}</code></pre>
          </div>
        </section>

        <section id="api-methods" class="mt-5">
          <h2>API Methods</h2>
          <p>The Network Monitor plugin provides a comprehensive API:</p>

          <div class="accordion" id="apiAccordion">
            <div class="card">
              <div class="card-header" id="headingOne">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapseOne">
                    Discovery Methods
                  </button>
                </h2>
              </div>
              <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#apiAccordion">
                <div class="card-body">
                  <ul>
                    <li><code>discoverDevices(options)</code> - Discover network devices</li>
                    <li><code>scanPorts(host, options)</code> - Scan ports on a host</li>
                    <li><code>getDevice(deviceId)</code> - Get device information</li>
                    <li><code>listDevices(filter)</code> - List discovered devices</li>
                    <li><code>createNetworkMap(options)</code> - Create network topology map</li>
                    <li><code>exportNetworkMap(map, options)</code> - Export network map</li>
                    <li><code>visualizeNetworkMap(map, options)</code> - Visualize network map</li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="card">
              <div class="card-header" id="headingTwo">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo">
                    Traffic Methods
                  </button>
                </h2>
              </div>
              <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#apiAccordion">
                <div class="card-body">
                  <ul>
                    <li><code>startTrafficMonitoring(options)</code> - Start traffic monitoring</li>
                    <li><code>stopTrafficMonitoring(sessionId)</code> - Stop traffic monitoring</li>
                    <li><code>getTrafficAnalysis(sessionId, options)</code> - Get traffic analysis</li>
                    <li><code>capturePackets(options)</code> - Capture network packets</li>
                    <li><code>analyzePackets(packetData, options)</code> - Analyze captured packets</li>
                    <li><code>getTrafficHistory(options)</code> - Get historical traffic data</li>
                    <li><code>exportTrafficData(data, options)</code> - Export traffic data</li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="card">
              <div class="card-header" id="headingThree">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseThree">
                    Monitoring Methods
                  </button>
                </h2>
              </div>
              <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#apiAccordion">
                <div class="card-body">
                  <ul>
                    <li><code>monitorDevice(deviceId, options)</code> - Monitor a device</li>
                    <li><code>stopMonitoring(monitoringId)</code> - Stop device monitoring</li>
                    <li><code>getMonitoringData(monitoringId, options)</code> - Get monitoring data</li>
                    <li><code>getNetworkStatus(options)</code> - Get network status</li>
                    <li><code>testConnectivity(host, options)</code> - Test connectivity to a host</li>
                    <li><code>measureLatency(host, options)</code> - Measure latency to a host</li>
                    <li><code>traceroute(host, options)</code> - Perform traceroute to a host</li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="card">
              <div class="card-header" id="headingFour">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseFour">
                    Alert Methods
                  </button>
                </h2>
              </div>
              <div id="collapseFour" class="collapse" aria-labelledby="headingFour" data-parent="#apiAccordion">
                <div class="card-body">
                  <ul>
                    <li><code>createAlert(definition)</code> - Create an alert</li>
                    <li><code>getAlert(alertId)</code> - Get an alert</li>
                    <li><code>updateAlert(alertId, updates)</code> - Update an alert</li>
                    <li><code>deleteAlert(alertId)</code> - Delete an alert</li>
                    <li><code>listAlerts(filter)</code> - List alerts</li>
                    <li><code>acknowledgeAlert(alertId, comment)</code> - Acknowledge an alert</li>
                    <li><code>resolveAlert(alertId, comment)</code> - Resolve an alert</li>
                    <li><code>getAlertHistory(options)</code> - Get alert history</li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </section>

        <section id="examples" class="mt-5">
          <h2>Examples</h2>
          
          <div class="api-method">
            <h4>Network Scanning and Monitoring</h4>
            <pre><code class="language-javascript">// Discover devices on the network
const devices = await networkMonitor.discoverDevices({
  ipRanges: ['192.168.1.0/24'],
  timeout: 5000
});

console.log(`Discovered ${devices.length} devices on the network`);

// Get detailed information about each device
for (const device of devices) {
  console.log(`Device: ${device.hostname || device.ip}`);
  
  // Scan open ports
  const portScan = await networkMonitor.scanPorts(device.ip, {
    ports: [22, 80, 443, 3306, 5432, 8080],
    timeout: 2000
  });
  
  console.log(`  Open ports: ${portScan.open.join(', ')}`);
  
  // Test connectivity
  const connectivity = await networkMonitor.testConnectivity(device.ip, {
    protocol: 'icmp',
    count: 5
  });
  
  console.log(`  Connectivity: ${connectivity.success ? 'OK' : 'Failed'}`);
  console.log(`  Packet loss: ${connectivity.packetLoss}%`);
  console.log(`  Average latency: ${connectivity.avgLatency}ms`);
  
  // Start monitoring the device if it's a router or switch
  if (device.type === 'router' || device.type === 'switch') {
    const monitoring = await networkMonitor.monitorDevice(device.ip, {
      metrics: ['cpu', 'memory', 'bandwidth', 'connections'],
      interval: 60000 // 1 minute
    });
    
    console.log(`  Monitoring started with ID: ${monitoring.id}`);
    
    // Create an alert for high CPU usage
    const alert = await networkMonitor.createAlert({
      name: `High CPU Usage - ${device.hostname || device.ip}`,
      target: {
        type: 'device',
        id: device.ip
      },
      metric: 'cpu',
      condition: {
        operator: '>',
        threshold: 80, // 80%
        duration: 300000 // 5 minutes
      },
      severity: 'warning',
      notifications: {
        email: {
          enabled: true,
          recipients: ['admin@example.com']
        }
      }
    });
    
    console.log(`  Alert created with ID: ${alert.id}`);
  }
}</code></pre>
            
            <h4>Traffic Analysis Dashboard</h4>
            <pre><code class="language-javascript">// Start traffic monitoring
const monitoring = await networkMonitor.startTrafficMonitoring({
  interface: 'eth0',
  capturePackets: true,
  filter: 'not port 22', // Exclude SSH traffic
  duration: 3600000 // 1 hour
});

console.log(`Traffic monitoring started with ID: ${monitoring.id}`);

// Set up a real-time dashboard update function
async function updateDashboard() {
  // Get current traffic analysis
  const analysis = await networkMonitor.getTrafficAnalysis(monitoring.id, {
    groupBy: ['protocol', 'application', 'source', 'destination'],
    interval: '1m' // 1 minute intervals
  });
  
  // Update bandwidth usage chart
  updateBandwidthChart(analysis.bandwidthOverTime);
  
  // Update protocol distribution chart
  updateProtocolChart(analysis.byProtocol);
  
  // Update application usage chart
  updateApplicationChart(analysis.byApplication);
  
  // Update top talkers list
  updateTopTalkers(analysis.bySource);
  
  // Update connection map
  updateConnectionMap(analysis.connections);
  
  // Get network status
  const status = await networkMonitor.getNetworkStatus();
  
  // Update status indicators
  updateStatusIndicators(status);
  
  // Update alerts panel
  if (status.alerts.active.length > 0) {
    updateAlertsPanel(status.alerts.active);
  }
}

// Update dashboard every minute
const dashboardInterval = setInterval(updateDashboard, 60000);

// Stop monitoring and clear interval when done
setTimeout(async () => {
  clearInterval(dashboardInterval);
  
  // Stop traffic monitoring
  await networkMonitor.stopTrafficMonitoring(monitoring.id);
  
  // Get final analysis
  const finalAnalysis = await networkMonitor.getTrafficAnalysis(monitoring.id, {
    summary: true
  });
  
  // Export report
  await networkMonitor.exportTrafficData(finalAnalysis, {
    format: 'pdf',
    filePath: './network-traffic-report.pdf',
    title: 'Network Traffic Analysis Report'
  });
  
  console.log('Traffic monitoring completed and report generated');
}, 3600000); // After 1 hour

// Helper functions for updating dashboard (simplified)
function updateBandwidthChart(data) {
  console.log('Updating bandwidth chart with', data.length, 'data points');
}

function updateProtocolChart(data) {
  console.log('Updating protocol chart with', data.length, 'protocols');
}

// More helper functions...</code></pre>
          </div>
        </section>

        <div class="alert alert-info mt-5">
          <h5><i class="fas fa-lightbulb mr-2"></i>Related Documentation</h5>
          <ul class="mb-0">
            <li><a href="../api-reference.html">API Reference</a> - Complete API documentation</li>
            <li><a href="../examples.html">Code Examples</a> - More usage examples</li>
            <li><a href="../troubleshooting.html">Troubleshooting Guide</a> - Solutions for common issues</li>
            <li><a href="system-info.html">System Info</a> - System monitoring plugin</li>
          </ul>
        </div>
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
          <p>Written by Greg Deeds, Autonomy Association International</p>
          <p><a href="mailto:support@autonomy.ai" class="text-white"><i class="fas fa-envelope mr-2"></i>Get Support</a></p>
        </div>
      </div>
    </div>
  </footer>

  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
```


## 7. Let's create the Security Scanner plugin page:

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Security Scanner - IQSMS Plugin System</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="../css/styles.css">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.1/css/all.css">
</head>
<body>
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
      <a class="navbar-brand" href="../index.html">
        <img src="../images/logo.png" alt="IQSMS Plugin System" height="40">
      </a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item">
            <a class="nav-link" href="../index.html">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="../plugin-development.html">Development</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="../api-reference.html">API Reference</a>
          </li>
          <li class="nav-item dropdown active">
            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown">
              Plugins
            </a>
            <div class="dropdown-menu">
              <a class="dropdown-item" href="cloudflare-api.html">Cloudflare API</a>
              <a class="dropdown-item" href="system-info.html">System Info</a>
              <a class="dropdown-item" href="drone-swarm-loadbalancer.html">Drone Swarm LB</a>
              <a class="dropdown-item" href="database-connector.html">Database Connector</a>
              <a class="dropdown-item" href="authentication-service.html">Authentication Service</a>
              <a class="dropdown-item" href="ai-analytics.html">AI Analytics</a>
              <a class="dropdown-item" href="workflow-automation.html">Workflow Automation</a>
              <a class="dropdown-item" href="network-monitor.html">Network Monitor</a>
              <a class="dropdown-item active" href="security-scanner.html">Security Scanner</a>
              <div class="dropdown-divider"></div>
              <a class="dropdown-item" href="index.html">All Plugins</a>
            </div>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <div class="container my-5">
    <div class="row">
      <div class="col-lg-3">
        <div class="sidebar">
          <h5>Contents</h5>
          <nav class="nav flex-column">
            <a class="nav-link" href="#overview">Overview</a>
            <a class="nav-link" href="#features">Key Features</a>
            <a class="nav-link" href="#installation">Installation</a>
            <a class="nav-link" href="#configuration">Configuration</a>
            <a class="nav-link" href="#vulnerability-scanning">Vulnerability Scanning</a>
            <a class="nav-link" href="#compliance">Compliance Checks</a>
            <a class="nav-link" href="#reporting">Reporting</a>
            <a class="nav-link" href="#api-methods">API Methods</a>
            <a class="nav-link" href="#examples">Examples</a>
          </nav>
        </div>
      </div>
      <div class="col-lg-9">
        <div class="plugin-header d-flex align-items-center">
          <i class="fas fa-shield-alt fa-3x text-primary mr-4"></i>
          <div>
            <h1>Security Scanner</h1>
            <p class="lead mb-0">Comprehensive security scanning for vulnerabilities, malware detection, and compliance verification</p>
          </div>
        </div>

        <div class="plugin-info mb-4">
          <div class="plugin-info-item">
            <i class="fas fa-code-branch"></i>
            <span>Version: 2.2.1</span>
          </div>
          <div class="plugin-info-item">
            <i class="fas fa-user"></i>
            <span>Publisher: Autonomy Association International</span>
          </div>
          <div class="plugin-info-item">
            <i class="fas fa-coins"></i>
            <span>Cost: 90 tokens</span>
          </div>
        </div>

        <div class="alert alert-primary">
          <i class="fas fa-info-circle mr-2"></i>
          This plugin provides comprehensive security scanning capabilities, including vulnerability assessment, malware detection, and compliance checking.
        </div>

        <section id="overview">
          <h2>Overview</h2>
          <p>The Security Scanner plugin offers a powerful set of tools for identifying security vulnerabilities, detecting malware, and verifying compliance with security standards. It helps you maintain a secure environment by continuously monitoring your systems, applications, and networks for potential security issues.</p>
          
          <p>With support for multiple scanning techniques, integration with popular vulnerability databases, and comprehensive reporting capabilities, the Security Scanner plugin provides a complete security assessment solution for your infrastructure.</p>
        </section>

        <section id="features" class="mt-5">
          <h2>Key Features</h2>
          
          <div class="row">
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title"><i class="fas fa-bug text-primary mr-2"></i>Vulnerability Scanning</h5>
                  <ul class="card-text">
                    <li>Network vulnerability scanning</li>
                    <li>Web application security testing</li>
                    <li>Database security assessment</li>
                    <li>API security testing</li>
                    <li>Container security scanning</li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title"><i class="fas fa-virus text-primary mr-2"></i>Malware Detection</h5>
                  <ul class="card-text">
                    <li>File scanning for malware</li>
                    <li>Memory analysis for threats</li>
                    <li>Rootkit detection</li>
                    <li>Behavioral analysis</li>
                    <li>Signature-based detection</li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
          
          <div class="row">
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title"><i class="fas fa-clipboard-check text-primary mr-2"></i>Compliance Checking</h5>
                  <ul class="card-text">
                    <li>PCI DSS compliance verification</li>
                    <li>HIPAA security rule checks</li>
                    <li>GDPR compliance assessment</li>
                    <li>ISO 27001 controls validation</li>
                    <li>Custom compliance frameworks</li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title"><i class="fas fa-chart-bar text-primary mr-2"></i>Reporting & Remediation</h5>
                  <ul class="card-text">
                    <li>Comprehensive security reports</li>
                    <li>Risk scoring and prioritization</li>
                    <li>Remediation recommendations</li>
                    <li>Historical trend analysis</li>
                    <li>Compliance attestation reports</li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </section>

        <section id="installation" class="mt-5">
          <h2>Installation</h2>
          <p>To use the Security Scanner plugin, you'll need to:</p>
          <ol>
            <li>Install the plugin in your IQSMS Plugin System</li>
            <li>Configure the plugin based on your security requirements</li>
            <li>Set up a database for storing scan results</li>
          </ol>

          <h4>Prerequisites</h4>
          <ul>
            <li>Node.js 14.x or higher</li>
            <li>IQSMS Plugin System core</li>
            <li>MongoDB, MySQL, or PostgreSQL database</li>
            <li>Sufficient permissions to perform security scans</li>
          </ul>

          <h4>Installing the Plugin</h4>
          <pre><code class="language-javascript">const pluginManager = require('./path/to/PluginManager');
await pluginManager.installPlugin('security-scanner');</code></pre>
          
          <h4>Additional Dependencies</h4>
          <p>Some features require additional dependencies:</p>
          <pre><code class="language-bash"># For vulnerability scanning
npm install vulnerability-scanner dependency-check

# For malware detection
npm install malware-detector virus-total-api

# For compliance checking
npm install compliance-checker policy-enforcer</code></pre>
        </section>

        <section id="configuration" class="mt-5">
          <h2>Configuration</h2>
          <p>The plugin provides several configuration options:</p>

          <pre><code class="language-javascript">const config = {
  // Database configuration
  database: {
    type: 'mongodb', // 'mongodb', 'mysql', or 'postgres'
    connection: 'primaryMongo', // Connection name from Database Connector plugin
    collections: {
      scans: 'securityScans',
      vulnerabilities: 'securityVulnerabilities',
      malware: 'securityMalware',
      compliance: 'securityCompliance'
    }
  },
  
  // Vulnerability scanning configuration
  vulnerabilityScanning: {
    enabled: true,
    scanInterval: 86400000, // 24 hours
    vulnerabilityDatabases: [
      {
        name: 'nvd',
        url: 'https://nvd.nist.gov/feeds/json/cve/1.1/'
      },
      {
        name: 'exploitDb',
        url: 'https://www.exploit-db.com/download/'
      }
    ],
    severityThreshold: 'medium', // 'critical', 'high', 'medium', 'low', 'info'
    excludedVulnerabilities: ['CVE-2020-1234', 'CVE-2021-5678'],
    scanTimeout: 3600000 // 1 hour
  },
  
  // Malware detection configuration
  malwareDetection: {
    enabled: true,
    scanInterval: 86400000, // 24 hours
    signatureDatabases: [
      {
        name: 'clamav',
        url: 'https://database.clamav.net/main.cvd'
      }
    ],
    behavioralAnalysis: true,
    scanPaths: ['/var/www', '/home'],
    excludedPaths: ['/var/www/cache', '/tmp'],
    fileTypes: ['.js', '.php', '.exe', '.dll', '.sh'],
    scanTimeout: 7200000 // 2 hours
  },
  
  // Compliance checking configuration
  complianceChecking: {
    enabled: true,
    scanInterval: 604800000, // 7 days
    frameworks: [
      {
        name: 'pci-dss',
        version: '3.2.1',
        enabled: true
      },
      {
        name: 'hipaa',
        version: '2.0',
        enabled: false
      },
      {
        name: 'gdpr',
        version: '1.0',
        enabled: true
      }
    ],
    customControls: './security/custom-controls.json',
    scanTimeout: 14400000 // 4 hours
  },
  
  // Reporting configuration
  reporting: {
    enabled: true,
    formats: ['json', 'pdf', 'html'],
    includeEvidence: true,
    includeRemediation: true,
    retentionPeriod: 90 // days
  },
  
  // Notification configuration
  notifications: {
    enabled: true,
    email: {
      enabled: true,
      recipients: ['security@example.com'],
      severityThreshold: 'high'
    },
    slack: {
      enabled: false,
      webhook: 'https://hooks.slack.com/services/YOUR/SLACK/WEBHOOK',
      channel: '#security-alerts',
      severityThreshold: 'critical'
    }
  }
};</code></pre>

          <h4>Loading the Plugin with Configuration</h4>
          <pre><code class="language-javascript">await pluginManager.loadPlugin('security-scanner', config);</code></pre>
        </section>

        <section id="vulnerability-scanning" class="mt-5">
          <h2>Vulnerability Scanning</h2>
          <p>The Security Scanner plugin provides comprehensive vulnerability scanning capabilities:</p>

          <div class="api-method">
            <h3>scanForVulnerabilities(target, options)</h3>
            <p>Scans a target for vulnerabilities.</p>
            
            <h4>Parameters</h4>
            <table class="table">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Type</th>
                  <th>Required</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>target</td>
                  <td>string or object</td>
                  <td>Yes</td>
                  <td>Target to scan (URL, IP, hostname, or object)</td>
                </tr>
                <tr>
                  <td>options</td>
                  <td>object</td>
                  <td>No</td>
                  <td>Scan options</td>
                </tr>
              </tbody>
            </table>
            
            <h4>Returns</h4>
            <p>A vulnerability scan result object.</p>
            
            <h4>Example</h4>
            <pre><code class="language-javascript">// Scan a web application
const webScan = await securityScanner.scanForVulnerabilities(
  'https://example.com',
  {
    scanType: 'web',
    auth: {
      type: 'basic',
      username: 'user',
      password: 'password'
    },
    depth: 3,
    includeSubdomains: true
  }
);

console.log(`Web scan completed with ID: ${webScan.scanId}`);
console.log(`Found ${webScan.vulnerabilities.length} vulnerabilities`);

// Scan a network
const networkScan = await securityScanner.scanForVulnerabilities(
  '192.168.1.0/24',
  {
    scanType: 'network',
    ports: [22, 80, 443, 3306, 5432, 8080],
    services: true,
    osDetection: true
  }
);

console.log(`Network scan completed with ID: ${networkScan.scanId}`);
console.log(`Scanned ${networkScan.hostsScanned} hosts`);
console.log(`Found ${networkScan.vulnerabilities.length} vulnerabilities`);</code></pre>
          </div>

          <div class="api-method mt-4">
            <h3>getVulnerabilityDetails(vulnerabilityId)</h3>
            <p>Gets detailed information about a specific vulnerability.</p>
            
            <h4>Parameters</h4>
            <table class="table">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Type</th>
                  <th>Required</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>vulnerabilityId</td>
                  <td>string</td>
                  <td>Yes</td>
                  <td>Vulnerability ID (e.g., CVE-2021-1234)</td>
                </tr>
              </tbody>
            </table>
            
            <h4>Returns</h4>
            <p>Detailed information about the vulnerability.</p>
            
            <h4>Example</h4>
            <pre><code class="language-javascript">const vulnDetails = await securityScanner.getVulnerabilityDetails('CVE-2021-1234');

console.log('Vulnerability Details:');
console.log(`Title: ${vulnDetails.title}`);
console.log(`Severity: ${vulnDetails.severity} (CVSS: ${vulnDetails.cvssScore})`);
console.log(`Description: ${vulnDetails.description}`);
console.log('Affected Systems:');
vulnDetails.affectedSystems.forEach(system => {
  console.log(`  - ${system}`);
});
console.log('Remediation:');
console.log(`  ${vulnDetails.remediation}`);</code></pre>
          </div>
        </section>

        <section id="compliance" class="mt-5">
          <h2>Compliance Checks</h2>
          <p>The Security Scanner plugin provides comprehensive compliance checking capabilities:</p>

          <div class="api-method">
            <h3>checkCompliance(target, framework, options)</h3>
            <p>Checks a target for compliance with a security framework.</p>
            
            <h4>Parameters</h4>
            <table class="table">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Type</th>
                  <th>Required</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>target</td>
                  <td>string or object</td>
                  <td>Yes</td>
                  <td>Target to check (URL, IP, hostname, or object)</td>
                </tr>
                <tr>
                  <td>framework</td>
                  <td>string</td>
                  <td>Yes</td>
                  <td>Compliance framework (e.g., 'pci-dss', 'hipaa', 'gdpr')</td>
                </tr>
                <tr>
                  <td>options</td>
                  <td>object</td>
                  <td>No</td>
                  <td>Check options</td>
                </tr>
              </tbody>
            </table>
            
            <h4>Returns</h4>
            <p>A compliance check result object.</p>
            
            <h4>Example</h4>
            <pre><code class="language-javascript">// Check PCI DSS compliance
const pciCheck = await securityScanner.checkCompliance(
  {
    server: 'web-server-1',
    ip: '192.168.1.10',
    services: ['web', 'database']
  },
  'pci-dss',
  {
    version: '3.2.1',
    controls: ['all'], // or specific controls like ['1.1', '1.2', '2.1']
    evidence: true
  }
);

console.log(`PCI DSS compliance check completed with ID: ${pciCheck.checkId}`);
console.log(`Overall compliance: ${pciCheck.overallCompliance.toFixed(2)}%`);
console.log(`Passed controls: ${pciCheck.passedControls.length}`);
console.log(`Failed controls: ${pciCheck.failedControls.length}`);

// Check GDPR compliance
const gdprCheck = await securityScanner.checkCompliance(
  'https://example.com',
  'gdpr',
  {
    scope: ['data-storage', 'consent', 'access-controls'],
    evidence: true,
    includeRecommendations: true
  }
);

console.log(`GDPR compliance check completed with ID: ${gdprCheck.checkId}`);
console.log(`Overall compliance: ${gdprCheck.overallCompliance.toFixed(2)}%`);</code></pre>
          </div>

          <div class="api-method mt-4">
            <h3>getComplianceReport(checkId, options)</h3>
            <p>Generates a compliance report for a specific check.</p>
            
            <h4>Parameters</h4>
            <table class="table">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Type</th>
                  <th>Required</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>checkId</td>
                  <td>string</td>
                  <td>Yes</td>
                  <td>Compliance check ID</td>
                </tr>
                <tr>
                  <td>options</td>
                  <td>object</td>
                  <td>No</td>
                  <td>Report options</td>
                </tr>
              </tbody>
            </table>
            
            <h4>Returns</h4>
            <p>A compliance report object or file.</p>
            
            <h4>Example</h4>
            <pre><code class="language-javascript">// Generate a PCI DSS compliance report
const report = await securityScanner.getComplianceReport(
```
