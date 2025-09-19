# IQSMS Monitoring Dashboard Files

I'll create all the necessary files for the monitoring dashboard according to the file map. Each file will include the path in the header comment.

## 1. Main Dashboard HTML File

```html
<!-- 
  File: /docs/monitoring/dashboard/index.html
  IQSMS Monitoring Dashboard - Main HTML file
  Copyright 2025 Autonomy Association International Inc., all rights reserved 
  Safeguard patent license from National Aeronautics and Space Administration (NASA)
  Copyright 2025 NASA, all rights reserved
-->
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>IQSMS Monitoring Dashboard</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="../../css/styles.css">
  <link rel="stylesheet" href="css/dashboard.css">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.1/css/all.css">
  <script src="https://d3js.org/d3.v7.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/three@0.180.0/build/three.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/socket.io-client@4.7.2/dist/socket.io.min.js"></script>
</head>
<body>
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
      <a class="navbar-brand" href="../../index.html">
        IQSMS Monitoring
      </a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item">
            <a class="nav-link" href="../../index.html">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="../index.html">Monitoring</a>
          </li>
          <li class="nav-item active">
            <a class="nav-link" href="#dashboard">Dashboard</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="../docs/dashboardhowto.html">Help</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <div class="dashboard-container">
    <div class="sidebar">
      <div class="sidebar-header">
        <h4>IQSMS Monitoring</h4>
      </div>
      <div class="time-controls">
        <select id="time-range" class="form-control">
          <option value="15m">Last 15 minutes</option>
          <option value="1h">Last hour</option>
          <option value="3h">Last 3 hours</option>
          <option value="6h">Last 6 hours</option>
          <option value="12h">Last 12 hours</option>
          <option value="24h" selected>Last 24 hours</option>
          <option value="7d">Last 7 days</option>
          <option value="30d">Last 30 days</option>
          <option value="custom">Custom range...</option>
        </select>
        <div class="mt-2">
          <label class="small">Auto refresh:</label>
          <select id="refresh-interval" class="form-control">
            <option value="0">Off</option>
            <option value="5" selected>5s</option>
            <option value="10">10s</option>
            <option value="30">30s</option>
            <option value="60">1m</option>
            <option value="300">5m</option>
          </select>
        </div>
      </div>
      <ul class="nav flex-column">
        <li class="nav-item"><a class="nav-link active" href="#overview">Overview</a></li>
        <li class="nav-item"><a class="nav-link" href="#system">System Resources</a></li>
        <li class="nav-item"><a class="nav-link" href="#protocols">Protocols</a></li>
        <li class="nav-item"><a class="nav-link" href="#network">Network Map</a></li>
        <li class="nav-item"><a class="nav-link" href="#workers">Worker Threads</a></li>
        <li class="nav-item"><a class="nav-link" href="#logs">Logs & Events</a></li>
        <li class="nav-item"><a class="nav-link" href="#alerts">Alerts</a></li>
      </ul>
      <div class="sidebar-footer">
        <div class="connection-status">
          <span id="connection-indicator" class="indicator online"></span>
          <span id="connection-text">Connected</span>
        </div>
      </div>
    </div>

    <div class="main-content">
      <div class="header-row">
        <div class="dashboard-header">
          <h1>IQSMS Monitoring Dashboard</h1>
          <p class="lead">Real-time system monitoring and analytics</p>
        </div>
        <div class="dashboard-controls">
          <button id="export-data" class="btn btn-outline-secondary btn-sm">
            <i class="fas fa-download"></i> Export
          </button>
          <button id="fullscreen-toggle" class="btn btn-outline-secondary btn-sm">
            <i class="fas fa-expand"></i>
          </button>
        </div>
      </div>

      <!-- Overview Section -->
      <section id="overview" class="dashboard-section">
        <h2>System Overview</h2>
        <div class="row">
          <div class="col-md-3">
            <div class="metric-card">
              <div class="metric-header">
                <h4>CPU Load</h4>
                <i class="fas fa-microchip"></i>
              </div>
              <div id="cpu-gauge" class="gauge-container"></div>
              <div class="metric-footer">
                <span id="cpu-value">32%</span>
                <small id="cpu-trend" class="trend up">+2.4%</small>
              </div>
            </div>
          </div>
          <div class="col-md-3">
            <div class="metric-card">
              <div class="metric-header">
                <h4>Memory Usage</h4>
                <i class="fas fa-memory"></i>
              </div>
              <div id="memory-gauge" class="gauge-container"></div>
              <div class="metric-footer">
                <span id="memory-value">68%</span>
                <small id="memory-trend" class="trend down">-1.2%</small>
              </div>
            </div>
          </div>
          <div class="col-md-3">
            <div class="metric-card">
              <div class="metric-header">
                <h4>Network Traffic</h4>
                <i class="fas fa-network-wired"></i>
              </div>
              <div id="network-gauge" class="gauge-container"></div>
              <div class="metric-footer">
                <span id="network-value">42 MB/s</span>
                <small id="network-trend" class="trend up">+5.7%</small>
              </div>
            </div>
          </div>
          <div class="col-md-3">
            <div class="metric-card">
              <div class="metric-header">
                <h4>Active Alerts</h4>
                <i class="fas fa-exclamation-triangle"></i>
              </div>
              <div id="alerts-gauge" class="gauge-container"></div>
              <div class="metric-footer">
                <span id="alerts-value">3</span>
                <small id="alerts-trend" class="trend none">0</small>
              </div>
            </div>
          </div>
        </div>

        <div class="row mt-4">
          <div class="col-md-8">
            <div class="chart-card">
              <div class="chart-header">
                <h4>System Performance</h4>
                <div class="chart-controls">
                  <div class="btn-group btn-group-sm" role="group">
                    <button type="button" class="btn btn-outline-secondary active">CPU</button>
                    <button type="button" class="btn btn-outline-secondary">Memory</button>
                    <button type="button" class="btn btn-outline-secondary">I/O</button>
                    <button type="button" class="btn btn-outline-secondary">Network</button>
                  </div>
                </div>
              </div>
              <div id="performance-chart" class="chart-container"></div>
            </div>
          </div>
          <div class="col-md-4">
            <div class="chart-card">
              <div class="chart-header">
                <h4>Active Protocols</h4>
              </div>
              <div id="protocols-chart" class="chart-container"></div>
            </div>
          </div>
        </div>
      </section>

      <!-- Network Map Section -->
      <section id="network" class="dashboard-section">
        <h2>Network Map</h2>
        <div class="row">
          <div class="col-md-12">
            <div class="chart-card">
              <div class="chart-header">
                <h4>Decentralized Network Visualization</h4>
                <div class="chart-controls">
                  <div class="btn-group btn-group-sm" role="group">
                    <button type="button" class="btn btn-outline-secondary active">3D View</button>
                    <button type="button" class="btn btn-outline-secondary">2D View</button>
                    <button type="button" class="btn btn-outline-secondary">Geo Map</button>
                  </div>
                </div>
              </div>
              <div id="network-map" class="network-container"></div>
            </div>
          </div>
        </div>
      </section>

      <!-- System Resources Section -->
      <section id="system" class="dashboard-section">
        <h2>System Resources</h2>
        <div class="row">
          <div class="col-md-6">
            <div class="chart-card">
              <div class="chart-header">
                <h4>CPU Usage History</h4>
              </div>
              <div id="cpu-history-chart" class="chart-container"></div>
            </div>
          </div>
          <div class="col-md-6">
            <div class="chart-card">
              <div class="chart-header">
                <h4>Memory Usage History</h4>
              </div>
              <div id="memory-history-chart" class="chart-container"></div>
            </div>
          </div>
        </div>
        <div class="row mt-4">
          <div class="col-md-6">
            <div class="chart-card">
              <div class="chart-header">
                <h4>Disk I/O</h4>
              </div>
              <div id="disk-io-chart" class="chart-container"></div>
            </div>
          </div>
          <div class="col-md-6">
            <div class="chart-card">
              <div class="chart-header">
                <h4>Network I/O</h4>
              </div>
              <div id="network-io-chart" class="chart-container"></div>
            </div>
          </div>
        </div>
      </section>

      <!-- Worker Threads Section -->
      <section id="workers" class="dashboard-section">
        <h2>Worker Threads</h2>
        <div class="row">
          <div class="col-md-8">
            <div class="chart-card">
              <div class="chart-header">
                <h4>Worker Activity</h4>
              </div>
              <div id="worker-activity-chart" class="chart-container"></div>
            </div>
          </div>
          <div class="col-md-4">
            <div class="chart-card">
              <div class="chart-header">
                <h4>Worker Status</h4>
              </div>
              <div id="worker-status-chart" class="chart-container"></div>
            </div>
          </div>
        </div>
        <div class="row mt-4">
          <div class="col-md-12">
            <div class="table-card">
              <div class="table-header">
                <h4>Worker Threads</h4>
                <div class="table-controls">
                  <input type="text" class="form-control form-control-sm" placeholder="Filter workers...">
                </div>
              </div>
              <div class="table-container">
                <table class="table table-hover">
                  <thead>
                    <tr>
                      <th>ID</th>
                      <th>Status</th>
                      <th>Type</th>
                      <th>CPU</th>
                      <th>Memory</th>
                      <th>Tasks Completed</th>
                      <th>Uptime</th>
                      <th>Actions</th>
                    </tr>
                  </thead>
                  <tbody id="worker-table-body">
                    <!-- Workers will be loaded here -->
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- Alerts Section -->
      <section id="alerts" class="dashboard-section">
        <h2>System Alerts</h2>
        <div class="row">
          <div class="col-md-12">
            <div class="table-card">
              <div class="table-header">
                <h4>Active Alerts</h4>
                <div class="table-controls">
                  <select class="form-control form-control-sm mr-2">
                    <option>All Severities</option>
                    <option>Critical</option>
                    <option>Warning</option>
                    <option>Info</option>
                  </select>
                  <input type="text" class="form-control form-control-sm" placeholder="Filter alerts...">
                </div>
              </div>
              <div class="table-container">
                <table class="table table-hover">
                  <thead>
                    <tr>
                      <th>Severity</th>
                      <th>Status</th>
                      <th>Time</th>
                      <th>Message</th>
                      <th>Source</th>
                      <th>Duration</th>
                      <th>Actions</th>
                    </tr>
                  </thead>
                  <tbody id="alerts-table-body">
                    <!-- Alerts will be loaded here -->
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </section>
    </div>
  </div>

  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <script src="js/dashboard.js"></script>
  <script src="js/data-manager.js"></script>
  <script src="js/socket-manager.js"></script>
  <script src="js/charts/gauges.js"></script>
  <script src="js/charts/performance.js"></script>
  <script src="js/charts/network-map.js"></script>
  <script src="js/charts/worker-charts.js"></script>
  <script src="js/ui/alerts-panel.js"></script>
  <script src="js/ui/time-controls.js"></script>
  <script src="js/ui/table-manager.js"></script>
</body>
</html>
```


## 2. CSS Files

```css
/**
 * File: /docs/monitoring/dashboard/css/dashboard.css
 * IQSMS Monitoring Dashboard - Main CSS file
 * Copyright 2025 Autonomy Association International Inc., all rights reserved
 */

/* Dashboard Variables */
:root {
  --primary-color: #4e73df;
  --secondary-color: #224abe;
  --success-color: #1cc88a;
  --info-color: #36b9cc;
  --warning-color: #f6c23e;
  --danger-color: #e74a3b;
  --light-color: #f8f9fc;
  --dark-color: #5a5c69;
  --sidebar-width: 240px;
  --header-height: 60px;
}

body {
  padding-top: 56px;
  overflow-x: hidden;
  background-color: #f8f9fc;
}

/* Dashboard Layout */
.dashboard-container {
  display: flex;
  min-height: calc(100vh - 56px);
}

.sidebar {
  width: var(--sidebar-width);
  background-color: #4e73df;
  background-image: linear-gradient(180deg, #4e73df 10%, #224abe 100%);
  color: white;
  position: fixed;
  height: calc(100vh - 56px);
  z-index: 100;
  transition: all 0.3s;
}

.sidebar-header {
  padding: 1.5rem 1rem;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.sidebar .nav-link {
  padding: 0.8rem 1rem;
  color: rgba(255, 255, 255, 0.8);
  font-weight: 500;
  transition: all 0.2s;
}

.sidebar .nav-link:hover {
  color: white;
  background-color: rgba(255, 255, 255, 0.1);
}

.sidebar .nav-link.active {
  color: white;
  background-color: rgba(255, 255, 255, 0.2);
  border-left: 3px solid white;
}

.sidebar .nav-link i {
  margin-right: 0.5rem;
}

.time-controls {
  padding: 1rem;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.sidebar-footer {
  padding: 1rem;
  position: absolute;
  bottom: 0;
  width: 100%;
  border-top: 1px solid rgba(255, 255, 255, 0.1);
}

.connection-status {
  display: flex;
  align-items: center;
}

.indicator {
  width: 10px;
  height: 10px;
  border-radius: 50%;
  margin-right: 8px;
}

.indicator.online {
  background-color: var(--success-color);
}

.indicator.offline {
  background-color: var(--danger-color);
}

.main-content {
  flex: 1;
  margin-left: var(--sidebar-width);
  padding: 1.5rem;
}

/* Cards */
.metric-card, .chart-card, .table-card {
  background-color: white;
  border-radius: 8px;
  box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
  margin-bottom: 1.5rem;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.metric-card:hover, .chart-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 0.3rem 2rem 0 rgba(58, 59, 69, 0.2);
}

.metric-card {
  padding: 1.25rem;
  height: 100%;
  display: flex;
  flex-direction: column;
}

.metric-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1rem;
}

.metric-header h4 {
  margin: 0;
  font-size: 0.9rem;
  font-weight: 600;
  color: var(--dark-color);
}

.metric-header i {
  font-size: 1.5rem;
  color: var(--primary-color);
}

.gauge-container {
  flex: 1;
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 120px;
}

.metric-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 1rem;
}

.metric-footer span {
  font-size: 1.5rem;
  font-weight: 700;
  color: var(--dark-color);
}

.trend {
  font-weight: 600;
  padding: 0.25rem 0.5rem;
  border-radius: 4px;
}

.trend.up {
  color: var(--success-color);
}

.trend.down {
  color: var(--danger-color);
}

.trend.none {
  color: var(--dark-color);
}

.chart-card, .table-card {
  overflow: hidden;
}

.chart-header, .table-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem;
  background-color: #f8f9fc;
  border-bottom: 1px solid #e3e6f0;
}

.chart-header h4, .table-header h4 {
  margin: 0;
  font-size: 1rem;
  font-weight: 600;
  color: var(--dark-color);
}

.chart-controls, .table-controls {
  display: flex;
}

.chart-container {
  padding: 1rem;
  height: 300px;
}

.network-container {
  height: 500px;
  background-color: #181c30;
}

.table-container {
  overflow-x: auto;
}

.dashboard-header {
  margin-bottom: 1.5rem;
}

.header-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1.5rem;
}

.dashboard-controls {
  display: flex;
  gap: 0.5rem;
}

.dashboard-section {
  margin-bottom: 2rem;
}

.dashboard-section h2 {
  margin-bottom: 1rem;
  color: var(--dark-color);
  font-weight: 600;
  font-size: 1.5rem;
}

/* Node details panel */
.node-details-panel {
  position: absolute;
  top: 20px;
  right: 20px;
  width: 300px;
  background-color: white;
  border-radius: 8px;
  box-shadow: 0 0.15rem 1.75rem 0 rgba(0, 0, 0, 0.3);
  z-index: 1000;
  overflow: hidden;
}

.node-details-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0.75rem 1rem;
  background-color: var(--primary-color);
  color: white;
}

.node-details-header h4 {
  margin: 0;
  font-size: 1rem;
  font-weight: 600;
}

.node-details-header .close-button {
  background: none;
  border: none;
  color: white;
  font-size: 1.5rem;
  line-height: 1;
  cursor: pointer;
}

.node-details-content {
  padding: 1rem;
}

/* Alerts styling */
.alert-severity {
  display: inline-block;
  width: 12px;
  height: 12px;
  border-radius: 50%;
  margin-right: 8px;
}

.alert-severity.critical {
  background-color: var(--danger-color);
}

.alert-severity.warning {
  background-color: var(--warning-color);
}

.alert-severity.info {
  background-color: var(--info-color);
}

/* Animation for charts */
.chart-container svg {
  transition: all 0.3s ease;
}

/* 3D Network Map */
.network-container canvas {
  border-radius: 0 0 8px 8px;
}

/* Responsive */
@media (max-width: 992px) {
  .sidebar {
    width: 0;
    padding: 0;
  }
  
  .sidebar.active {
    width: var(--sidebar-width);
    padding: 1rem;
  }
  
  .main-content {
    margin-left: 0;
  }
  
  .main-content.shifted {
    margin-left: var(--sidebar-width);
  }

  .chart-card, .metric-card {
    height: auto;
  }

  .chart-container {
    height: 250px;
  }

  .network-container {
    height: 350px;
  }
}

/* Mobile view */
@media (max-width: 768px) {
  .metric-card {
    margin-bottom: 1rem;
  }

  .chart-container {
    height: 200px;
  }

  .network-container {
    height: 300px;
  }

  .dashboard-controls {
    flex-direction: column;
    gap: 0.25rem;
  }

  .table-controls {
    flex-direction: column;
    gap: 0.25rem;
  }
}
```


## 3. JavaScript Files - Core

### Main Dashboard.js

```javascript
/**
 * File: /docs/monitoring/dashboard/js/dashboard.js
 * IQSMS Monitoring Dashboard - Main initialization file
 * Copyright 2025 Autonomy Association International Inc., all rights reserved
 */

// Initialize the dashboard when the DOM is ready
document.addEventListener('DOMContentLoaded', () => {
  initializeDashboard();
});

/**
 * Initialize the dashboard components and event listeners
 */
function initializeDashboard() {
  // Initialize data manager
  window.dataManager = new DataManager();
  
  // Initialize socket connection
  window.socketManager = new SocketManager({
    url: window.location.origin,
    onConnect: handleSocketConnect,
    onDisconnect: handleSocketDisconnect,
    onError: handleSocketError,
    onMetricsUpdate: (data) => window.dataManager.updateMetrics(data),
    onNetworkUpdate: (data) => window.dataManager.updateNetwork(data),
    onWorkersUpdate: (data) => window.dataManager.updateWorkers(data),
    onAlertsUpdate: (data) => window.dataManager.updateAlerts(data)
  });
  
  // Initialize charts
  initializeGaugeCharts();
  initializePerformanceChart();
  initializeNetworkMap();
  initializeWorkerCharts();
  
  // Initialize UI components
  initializeAlertsPanel();
  initializeTimeControls();
  initializeTableManager();
  
  // Update UI with initial data
  window.dataManager.loadInitialData().then(updateDashboardUI);
  
  // Set up event listeners
  setupEventListeners();
  
  // Set up auto-refresh
  setupAutoRefresh();
  
  // Initially show only the overview section
  showSection('overview');
}

/**
 * Handle socket connection event
 */
function handleSocketConnect() {
  const indicator = document.getElementById('connection-indicator');
  const text = document.getElementById('connection-text');
  
  indicator.classList.remove('offline');
  indicator.classList.add('online');
  text.textContent = 'Connected';
  
  console.log('Socket connected');
}

/**
 * Handle socket disconnect event
 */
function handleSocketDisconnect() {
  const indicator = document.getElementById('connection-indicator');
  const text = document.getElementById('connection-text');
  
  indicator.classList.remove('online');
  indicator.classList.add('offline');
  text.textContent = 'Disconnected';
  
  console.log('Socket disconnected');
}

/**
 * Handle socket error event
 * @param {Error} error - The error object
 */
function handleSocketError(error) {
  console.error('Socket error:', error);
  
  // If socket connection fails, fall back to HTTP polling
  fallbackToHttpPolling();
}

/**
 * Fall back to HTTP polling if WebSocket connection fails
 */
function fallbackToHttpPolling() {
  console.log('Falling back to HTTP polling');
  
  // Set up HTTP polling interval
  const pollingInterval = setInterval(() => {
    fetch('/api/metrics')
      .then(response => response.json())
      .then(data => {
        // Update data manager with fetched data
        window.dataManager.updateMetrics(data);
        // Update UI
        updateDashboardUI();
      })
      .catch(error => {
        console.error('HTTP polling error:', error);
      });
  }, 5000); // Poll every 5 seconds
  
  // Store polling interval in window object to access it later
  window.httpPollingInterval = pollingInterval;
}

/**
 * Set up event listeners for dashboard interactions
 */
function setupEventListeners() {
  // Navigation links
  const navLinks = document.querySelectorAll('.sidebar .nav-link');
  navLinks.forEach(link => {
    link.addEventListener('click', (event) => {
      // Remove active class from all links
      navLinks.forEach(l => l.classList.remove('active'));
      // Add active class to clicked link
      event.target.classList.add('active');
      
      // Show corresponding section
      const targetId = event.target.getAttribute('href').substring(1);
      showSection(targetId);
      
      event.preventDefault();
    });
  });
  
  // Export data button
  const exportButton = document.getElementById('export-data');
  exportButton.addEventListener('click', exportDashboardData);
  
  // Fullscreen toggle button
  const fullscreenButton = document.getElementById('fullscreen-toggle');
  fullscreenButton.addEventListener('click', toggleFullscreen);
  
  // Mobile menu toggle
  const navbarToggler = document.querySelector('.navbar-toggler');
  if (navbarToggler) {
    navbarToggler.addEventListener('click', () => {
      const sidebar = document.querySelector('.sidebar');
      const mainContent = document.querySelector('.main-content');
      
      sidebar.classList.toggle('active');
      mainContent.classList.toggle('shifted');
    });
  }
  
  // System performance chart type buttons
  const chartTypeButtons = document.querySelectorAll('.chart-controls .btn-group button');
  chartTypeButtons.forEach(button => {
    button.addEventListener('click', (event) => {
      // Remove active class from all buttons
      chartTypeButtons.forEach(b => b.classList.remove('active'));
      // Add active class to clicked button
      event.target.classList.add('active');
      
      // Update chart based on selected type
      const chartType = event.target.textContent.trim().toLowerCase();
      updatePerformanceChartType(chartType);
    });
  });
  
  // Network map view buttons
  const networkViewButtons = document.querySelectorAll('#network .chart-controls .btn-group button');
  networkViewButtons.forEach(button => {
    button.addEventListener('click', (event) => {
      // Remove active class from all buttons
      networkViewButtons.forEach(b => b.classList.remove('active'));
      // Add active class to clicked button
      event.target.classList.add('active');
      
      // Update network map based on selected view
      const viewType = event.target.textContent.trim();
      updateNetworkMapView(viewType);
    });
  });
}

/**
 * Show a specific dashboard section
 * @param {string} sectionId - The ID of the section to show
 */
function showSection(sectionId) {
  // Hide all sections
  const sections = document.querySelectorAll('.dashboard-section');
  sections.forEach(section => {
    section.style.display = 'none';
  });
  
  // Show the target section
  const targetSection = document.getElementById(sectionId);
  if (targetSection) {
    targetSection.style.display = 'block';
  }
}

/**
 * Set up auto-refresh functionality
 */
function setupAutoRefresh() {
  // Get the refresh interval from the selector
  const refreshSelector = document.getElementById('refresh-interval');
  const interval = parseInt(refreshSelector.value, 10);
  
  // Set up initial refresh interval
  updateRefreshInterval(interval);
}

/**
 * Update the auto-refresh interval
 * @param {number} seconds - The refresh interval in seconds
 */
function updateRefreshInterval(seconds) {
  // Clear existing interval
  if (window.refreshInterval) {
    clearInterval(window.refreshInterval);
  }
  
  // If interval is 0, disable auto-refresh
  if (seconds === 0) {
    return;
  }
  
  // Set new interval
  window.refreshInterval = setInterval(() => {
    // Fetch latest data
    window.dataManager.refreshData().then(updateDashboardUI);
  }, seconds * 1000);
}

/**
 * Update the dashboard UI with the latest data
 */
function updateDashboardUI() {
  // Update gauge charts
  updateGaugeCharts();
  
  // Update performance chart
  updatePerformanceChart();
  
  // Update network map
  updateNetworkMap();
  
  // Update worker charts and table
  updateWorkerCharts();
  updateWorkerTable();
  
  // Update alerts
  updateAlertsPanel();
}

/**
 * Export dashboard data as JSON or CSV
 */
function exportDashboardData() {
  const data = window.dataManager.getAllMetrics();
  
  // Create a Blob with the data
  const blob = new Blob([JSON.stringify(data, null, 2)], { type: 'application/json' });
  
  // Create a download link
  const url = URL.createObjectURL(blob);
  const a = document.createElement('a');
  a.href = url;
  a.download = `iqsms-metrics-${new Date().toISOString()}.json`;
  
  // Trigger download
  document.body.appendChild(a);
  a.click();
  
  // Clean up
  document.body.removeChild(a);
  URL.revokeObjectURL(url);
}

/**
 * Toggle fullscreen mode
 */
function toggleFullscreen() {
  const dashboard = document.querySelector('.dashboard-container');
  
  if (!document.fullscreenElement) {
    // Enter fullscreen
    if (dashboard.requestFullscreen) {
      dashboard.requestFullscreen();
    } else if (dashboard.mozRequestFullScreen) {
      dashboard.mozRequestFullScreen();
    } else if (dashboard.webkitRequestFullscreen) {
      dashboard.webkitRequestFullscreen();
    } else if (dashboard.msRequestFullscreen) {
      dashboard.msRequestFullscreen();
    }
    
    // Update button icon
    document.getElementById('fullscreen-toggle').innerHTML = '<i class="fas fa-compress"></i>';
  } else {
    // Exit fullscreen
    if (document.exitFullscreen) {
      document.exitFullscreen();
    } else if (document.mozCancelFullScreen) {
      document.mozCancelFullScreen();
    } else if (document.webkitExitFullscreen) {
      document.webkitExitFullscreen();
    } else if (document.msExitFullscreen) {
      document.msExitFullscreen();
    }
    
    // Update button icon
    document.getElementById('fullscreen-toggle').innerHTML = '<i class="fas fa-expand"></i>';
  }
}
```


### Data Manager

```javascript
/**
 * File: /docs/monitoring/dashboard/js/data-manager.js
 * IQSMS Monitoring Dashboard - Data management and processing
 * Copyright 2025 Autonomy Association International Inc., all rights reserved
 */

/**
 * Data Manager
 * Handles data fetching, processing, and storage for the dashboard
 */
class DataManager {
  constructor() {
    // Initialize data storage
    this.metrics = {
      current: {},
      history: {},
      timeRange: {
        start: new Date(Date.now() - 24 * 60 * 60 * 1000), // Last 24 hours
        end: new Date()
      }
    };
    
    this.network = {
      nodes: [],
      links: []
    };
    
    this.workers = {
      status: {},
      activity: []
    };
    
    this.alerts = {
      active: [],
      history: []
    };
  }
  
  /**
   * Load initial data
   * @returns {Promise} - Promise that resolves when data is loaded
   */
  async loadInitialData() {
    try {
      // Fetch metrics
      const metricsResponse = await fetch('/api/metrics');
      const metrics = await metricsResponse.json();
      this.metrics.current = metrics;
      
      // Fetch metrics history
      const historyResponse = await fetch(`/api/metrics/history?start=${this.metrics.timeRange.start.toISOString()}&end=${this.metrics.timeRange.end.toISOString()}`);
      const history = await historyResponse.json();
      this.metrics.history = history;
      
      // Fetch network data
      const networkResponse = await fetch('/api/network');
      const network = await networkResponse.json();
      this.network = network;
      
      // Fetch worker data
      const workersResponse = await fetch('/api/workers');
      const workers = await workersResponse.json();
      this.workers = workers;
      
      // Fetch alerts
      const alertsResponse = await fetch('/api/alerts');
      const alerts = await alertsResponse.json();
      this.alerts = alerts;
      
      return true;
    } catch (error) {
      console.error('Error loading initial data:', error);
      return this.loadFallbackData();
    }
  }
  
  /**
   * Load fallback data for development or when API is unavailable
   * @returns {boolean} - Whether fallback data was loaded successfully
   */
  loadFallbackData() {
    console.log('Loading fallback data');
    
    // Load fallback metrics
    this.metrics.current = {
      cpu: {
        usage: 32,
        trend: 2.4
      },
      memory: {
        usage: 68,
        trend: -1.2
      },
      network: {
        throughput: 42,
        trend: 5.7
      },
      alerts: {
        active: 3,
        trend: 0
      }
    };
    
    // Generate historical data
    this.generateHistoricalData();
    
    // Generate network data
    this.generateNetworkData();
    
    // Generate worker data
    this.generateWorkerData();
    
    // Generate alerts data
    this.generateAlertsData();
    
    return true;
  }
  
  /**
   * Generate historical data for development
   */
  generateHistoricalData() {
    const now = new Date();
    const history = {
      cpu: [],
      memory: [],
      network: [],
      disk: []
    };
    
    // Generate data points for the last 24 hours
    for (let i = 0; i < 288; i++) { // 5-minute intervals for 24 hours
      const timestamp = new Date(now.getTime() - (288 - i) * 5 * 60 * 1000);
      
      // Generate CPU data with a realistic pattern
      const hour = timestamp.getHours();
      let cpuBase = 20 + Math.sin(hour / 24 * Math.PI * 2) * 15; // Daily cycle
      const cpuValue = Math.max(0, Math.min(100, cpuBase + Math.random() * 20));
      
      // Generate memory data with a gradual increase and occasional drops
      let memoryBase = 40 + (i / 288) * 30; // Gradual increase
      if (i % 36 === 0) memoryBase -= 15; // Occasional drops
      const memoryValue = Math.max(0, Math.min(100, memoryBase + Math.random() * 10));
      
      // Generate network data with peaks during business hours
      let networkBase = 10;
      if (hour >= 9 && hour <= 17) networkBase = 30; // Higher during business hours
      const networkValue = Math.max(0, networkBase + Math.random() * 40);
      
      // Generate disk data with occasional spikes
      let diskBase = 5;
      if (i % 24 === 0) diskBase = 50; // Occasional spikes
      const diskValue = Math.max(0, diskBase + Math.random() * 10);
      
      history.cpu.push({ timestamp, value: cpuValue });
      history.memory.push({ timestamp, value: memoryValue });
      history.network.push({ timestamp, value: networkValue });
      history.disk.push({ timestamp, value: diskValue });
    }
    
    this.metrics.history = history;
  }
  
  /**
   * Generate network data for development
   */
  generateNetworkData() {
    const nodeTypes = ['server', 'client', 'gateway', 'router', 'sensor'];
    const nodes = [];
    const links = [];
    
    // Generate nodes
    for (let i = 1; i <= 30; i++) {
      const type = nodeTypes[Math.floor(Math.random() * nodeTypes.length)];
      nodes.push({
        id: `node-${i}`,
        name: `Node ${i}`,
        type: type,
        status: Math.random() > 0.9 ? 'warning' : 'normal',
        x: (Math.random() - 0.5) * 100,
        y: (Math.random() - 0.5) * 100,
        z: (Math.random() - 0.5) * 100,
        size: type === 'server' ? 5 : type === 'gateway' ? 4 : 3,
        lastSeen: new Date().toISOString(),
        location: `Location ${Math.floor(Math.random() * 10) + 1}`
      });
    }
    
    // Generate links (connections between nodes)
    for (let i = 0; i < nodes.length; i++) {
      // Each node connects to 1-3 other nodes
      const connectionCount = Math.floor(Math.random() * 3) + 1;
      for (let j = 0; j < connectionCount; j++) {
        const targetIndex = Math.floor(Math.random() * nodes.length);
        if (targetIndex !== i) {
          links.push({
            source: nodes[i].id,
            target: nodes[targetIndex].id,
            type: Math.random() > 0.5 ? 'strong' : 'weak',
            weight: Math.random() > 0.7 ? 2 : 1
          });
        }
      }
    }
    
    this.network = { nodes, links };
  }
  
  /**
   * Generate worker data for development
   */
  generateWorkerData() {
    const workers = {
      status: {
        active: 12,
        idle: 3,
        terminated: 1
      },
      workers: []
    };
    
    // Generate worker list
    const workerTypes = ['processor', 'analyzer', 'connector', 'scheduler'];
    for (let i = 1; i <= 16; i++) {
      const type = workerTypes[Math.floor(Math.random() * workerTypes.length)];
      const status = i <= 12 ? 'active' : i <= 15 ? 'idle' : 'terminated';
      
      workers.workers.push({
        id: `worker-${i}`,
        type: type,
        status: status,
        cpu: status === 'active' ? Math.floor(Math.random() * 80) + 10 : 0,
        memory: status === 'active' ? Math.floor(Math.random() * 70) + 20 : 0,
        tasksCompleted: Math.floor(Math.random() * 1000),
        uptime: status === 'terminated' ? 0 : Math.floor(Math.random() * 86400)
      });
    }
    
    // Generate activity data
    const activity = [];
    const now = new Date();
    for (let i = 0; i < 288; i++) { // 5-minute intervals for 24 hours
      const timestamp = new Date(now.getTime() - (288 - i) * 5 * 60 * 1000);
      activity.push({
        timestamp: timestamp,
        active: Math.floor(Math.random() * 5) + 8,
        idle: Math.floor(Math.random() * 3) + 1,
        tasks: Math.floor(Math.random() * 100) + 50
      });
    }
    
    this.workers = {
      status: workers.status,
      workers: workers.workers,
      activity: activity
    };
  }
  
  /**
   * Generate alerts data for development
   */
  generateAlertsData() {
    const severities = ['critical', 'warning', 'info'];
    const sources = ['system', 'network', 'database', 'application', 'security'];
    const active = [];
    const history = [];
    
    // Generate active alerts
    for (let i = 1; i <= 3; i++) {
      const severity = i === 1 ? 'critical' : i === 2 ? 'warning' : 'info';
      const source = sources[Math.floor(Math.random() * sources.length)];
      
      active.push({
        id: `alert-${i}`,
        severity: severity,
        status: 'active',
        time: new Date(Date.now() - Math.floor(Math.random() * 3600000)).toISOString(),
        message: `${severity.charAt(0).toUpperCase() + severity.slice(1)} alert in ${source} component`,
        source: source,
        duration: Math.floor(Math.random() * 3600)
      });
    }
    
    // Generate historical alerts
    for (let i = 4; i <= 10; i++) {
      const severity = severities[Math.floor(Math.random() * severities.length)];
      const source = sources[Math.floor(Math.random() * sources.length)];
      
      history.push({
        id: `alert-${i}`,
        severity: severity,
        status: Math.random() > 0.5 ? 'resolved' : 'acknowledged',
        time: new Date(Date.now() - Math.floor(Math.random() * 86400000)).toISOString(),
        message: `${severity.charAt(0).toUpperCase() + severity.slice(1)} alert in ${source} component`,
        source: source,
        duration: Math.floor(Math.random() * 3600),
        resolved: new Date(Date.now() - Math.floor(Math.random() * 3600000)).toISOString()
      });
    }
    
    this.alerts = {
      active: active,
      history: history
    };
  }
  
  /**
   * Refresh all data
   * @returns {Promise} - Promise that resolves when data is refreshed
   */
  async refreshData() {
    try {
      // Fetch metrics
      const metricsResponse = await fetch('/api/metrics');
      const metrics = await metricsResponse.json();
      this.metrics.current = metrics;
      
      // Fetch network data
      const networkResponse = await fetch('/api/network');
      const network = await networkResponse.json();
      this.network = network;
      
      // Fetch worker data
      const workersResponse = await fetch('/api/workers');
      const workers = await workersResponse.json();
      this.workers = workers;
      
      // Fetch alerts
      const alertsResponse = await fetch('/api/alerts');
      const alerts = await alertsResponse.json();
      this.alerts = alerts;
      
      return true;
    } catch (error) {
      console.error('Error refreshing data:', error);
      return false;
    }
  }
  
  /**
   * Update metrics with new data (from socket.io)
   * @param {Object} data - The new metrics data
   */
  updateMetrics(data) {
    if (!data) {
      return;
    }
    
    // Update current metrics
    this.metrics.current = data;
    
    // Add to history
    const timestamp = new Date();
    
    // If we don't have this metric type in history yet, initialize it
    Object.keys(data).forEach(metricType => {
      if (!this.metrics.history[metricType]) {
        this.metrics.history[metricType] = [];
      }
      
      // Add the metric to history
      this.metrics.history[metricType].push({
        timestamp,
        value: data[metricType]
      });
      
      // Limit history size (keep last 1000 points)
      if (this.metrics.history[metricType].length > 1000) {
        this.metrics.history[metricType].shift();
      }
    });
  }
  
  /**
   * Update network data (from socket.io)
   * @param {Object} data - The new network data
   */
  updateNetwork(data) {
    if (!data) {
      return;
    }
    
    this.network = data;
  }
  
  /**
   * Update worker data (from socket.io)
   * @param {Object} data - The new worker data
   */
  updateWorkers(data) {
    if (!data) {
      return;
    }
    
    this.workers = data;
  }
  
  /**
   * Update alerts data (from socket.io)
   * @param {Object} data - The new alerts data
   */
  updateAlerts(data) {
    if (!data) {
      return;
    }
    
    this.alerts = data;
  }
  
  /**
   * Set the time range for historical data
   * @param {Date} start - Start time
   * @param {Date} end - End time
   * @returns {Promise} - Promise that resolves when data is updated
   */
  async setTimeRange(start, end) {
    try {
      // Update time range
      this.metrics.timeRange = { start, end };
      
      // Fetch metrics history for the new range
      const url = `/api/metrics/history?start=${start.toISOString()}&end=${end.toISOString()}`;
      const response = await fetch(url);
      const history = await response.json();
      
      // Update history
      this.metrics.history = history;
      
      return true;
    } catch (error) {
      console.error('Error setting time range:', error);
      return false;
    }
  }
  
  /**
   * Get the latest metrics
   * @returns {Object} - The latest metrics
   */
  getLatestMetrics() {
    return this.metrics.current;
  }
  
  /**
   * Get metrics history
   * @param {string} metricType - The type of metric to get history for
   * @returns {Array} - Array of metric data points
   */
  getMetricsHistory(metricType) {
    if (!metricType || !this.metrics.history[metricType]) {
      return [];
    }
    
    // Filter by time range
    return this.metrics.history[metricType].filter(point => {
      const timestamp = new Date(point.timestamp);
      return timestamp >= this.metrics.timeRange.start && timestamp <= this.metrics.timeRange.end;
    });
  }
  
  /**
   * Get all metrics (current and history)
   * @returns {Object} - All metrics data
   */
  getAllMetrics() {
    return this.metrics;
  }
  
  /**
   * Get network data
   * @returns {Object} - Network nodes and links
   */
  getNetworkData() {
    return this.network;
  }
  
  /**
   * Get worker data
   * @returns {Object} - Worker status and activity
   */
  getWorkerData() {
    return this.workers;
  }
  
  /**
   * Get alerts
   * @returns {Object} - Active and historical alerts
   */
  getAlerts() {
    return this.alerts;
  }
}
```


### Socket Manager

```javascript
/**
 * File: /docs/monitoring/dashboard/js/socket-manager.js
 * IQSMS Monitoring Dashboard - Socket.IO connection management
 * Copyright 2025 Autonomy Association International Inc., all rights reserved
 */

/**
 * Socket Manager
 * Handles WebSocket connections for real-time data updates
 */
class SocketManager {
  /**
   * Create a new SocketManager
   * @param {Object} config - Configuration options
   */
  constructor(config) {
    this.config = {
      url: window.location.origin,
      path: '/socket.io',
      reconnectionAttempts: 5,
      reconnectionDelay: 1000,
      ...config
    };
    
    this.socket = null;
    this.connected = false;
    
    // Initialize socket connection
    this.initialize();
  }
  
  /**
   * Initialize the socket connection
   */
  initialize() {
    try {
      // Create socket connection
      this.socket = io(this.config.url, {
        path: this.config.path,
        reconnectionAttempts: this.config.reconnectionAttempts,
        reconnectionDelay: this.config.reconnectionDelay
      });
      
      // Set up event handlers
      this.socket.on('connect', () => {
        this.connected = true;
        console.log('Socket connected');
        
        if (typeof this.config.onConnect === 'function') {
          this.config.onConnect();
        }
      });
      
      this.socket.on('disconnect', (reason) => {
        this.connected = false;
        console.log(`Socket disconnected: ${reason}`);
        
        if (typeof this.config.onDisconnect === 'function') {
          this.config.onDisconnect(reason);
        }
      });
      
      this.socket.on('connect_error', (error) => {
        console.error('Socket connection error:', error);
        
        if (typeof this.config.onError === 'function') {
          this.config.onError(error);
        }
      });
      
      this.socket.on('reconnect_failed', () => {
        console.error('Socket reconnection failed');
        
        if (typeof this.config.onError === 'function') {
          this.config.onError(new Error('Reconnection failed'));
        }
      });
      
      // Set up data event handlers
      this.socket.on('metrics', (data) => {
        if (typeof this.config.onMetricsUpdate === 'function') {
          this.config.onMetricsUpdate(data);
        }
      });
      
      this.socket.on('network', (data) => {
        if (typeof this.config.onNetworkUpdate === 'function') {
          this.config.onNetworkUpdate(data);
        }
      });
      
      this.socket.on('workers', (data) => {
        if (typeof this.config.onWorkersUpdate === 'function') {
          this.config.onWorkersUpdate(data);
        }
      });
      
      this.socket.on('alerts', (data) => {
        if (typeof this.config.onAlertsUpdate === 'function') {
          this.config.onAlertsUpdate(data);
        }
      });
    } catch (error) {
      console.error('Error initializing socket:', error);
      if (typeof this.config.onError === 'function') {
        this.config.onError(error);
      }
    }
  }
  
  /**
   * Check if the socket is connected
   * @returns {boolean} - Whether the socket is connected
   */
  isConnected() {
    return this.connected;
  }
  
  /**
   * Disconnect the socket
   */
  disconnect() {
    if (this.socket) {
      this.socket.disconnect();
    }
  }
  
  /**
   * Reconnect the socket
   */
  reconnect() {
    if (this.socket) {
      this.socket.connect();
    }
  }
  
  /**
   * Send a message to the server
   * @param {string} event - The event name
   * @param {*} data - The data to send
   */
  emit(event, data) {
    if (this.socket && this.connected) {
      this.socket.emit(event, data);
    } else {
      console.warn('Cannot emit event: socket not connected');
    }
  }
}
```


## 4. JavaScript Files - Visualization Components

### Gauge Charts

```javascript
/**
 * File: /docs/monitoring/dashboard/js/charts/gauges.js
 * IQSMS Monitoring Dashboard - D3.js gauge charts
 * Copyright 2025 Autonomy Association International Inc., all rights reserved
 */

let cpuGauge, memoryGauge, networkGauge, alertsGauge;

/**
 * Initialize gauge charts
 */
function initializeGaugeCharts() {
  // Create CPU gauge
  cpuGauge = createGauge('cpu-gauge', {
    min: 0,
    max: 100,
    label: 'CPU %',
    color: d3.scaleLinear()
      .domain([0, 50, 100])
      .range(['#1cc88a', '#f6c23e', '#e74a3b'])
  });
  
  // Create memory gauge
  memoryGauge = createGauge('memory-gauge', {
    min: 0,
    max: 100,
    label: 'Memory %',
    color: d3.scaleLinear()
      .domain([0, 70, 100])
      .range(['#1cc88a', '#f6c23e', '#e74a3b'])
  });
  
  // Create network gauge
  networkGauge = createGauge('network-gauge', {
    min: 0,
    max: 100,
    label: 'Network MB/s',
    color: d3.scaleLinear()
      .domain([0, 60, 100])
      .range(['#1cc88a', '#f6c23e', '#e74a3b'])
  });
  
  // Create alerts gauge
  alertsGauge = createGauge('alerts-gauge', {
    min: 0,
    max: 10,
    label: 'Alerts',
    color: d3.scaleLinear()
      .domain([0, 3, 10])
      .range(['#1cc88a', '#f6c23e', '#e74a3b'])
  });
  
  // Set initial values
  updateGaugeCharts();
}

/**
 * Create a gauge chart
 * @param {string} elementId - The ID of the container element
 * @param {Object} config - Configuration options
 * @returns {Object} - The gauge object
 */
function createGauge(elementId, config) {
  const container = d3.select(`#${elementId}`);
  
  // Clear any existing content
  container.html('');
  
  // Set dimensions
  const width = container.node().getBoundingClientRect().width;
  const height = Math.min(width, 150);
  const radius = Math.min(width, height) / 2;
  
  // Create SVG element
  const svg = container.append('svg')
    .attr('width', width)
    .attr('height', height)
    .append('g')
    .attr('transform', `translate(${width / 2}, ${height / 2})`);
  
  // Create gauge background
  const backgroundArc = d3.arc()
    .innerRadius(radius * 0.7)
    .outerRadius(radius * 0.9)
    .startAngle(-Math.PI / 2)
    .endAngle(Math.PI / 2);
  
  svg.append('path')
    .attr('class', 'gauge-background')
    .attr('d', backgroundArc)
    .style('fill', '#e9ecef');
  
  // Create foreground arc (value indicator)
  const valueArc = d3.arc()
    .innerRadius(radius * 0.7)
    .outerRadius(radius * 0.9)
    .startAngle(-Math.PI / 2);
  
  const foreground = svg.append('path')
    .attr('class', 'gauge-foreground')
    .style('fill', '#4e73df');
  
  // Create gauge needle
  const needleLine = svg.append('line')
    .attr('class', 'gauge-needle')
    .attr('x1', 0)
    .attr('y1', 0)
    .attr('x2', 0)
    .attr('y2', -radius * 0.7)
    .style('stroke', '#5a5c69')
    .style('stroke-width', 2);
  
  const needleCircle = svg.append('circle')
    .attr('class', 'gauge-needle-circle')
    .attr('cx', 0)
    .attr('cy', 0)
    .attr('r', radius * 0.1)
    .style('fill', '#5a5c69');
  
  // Create text element for the value
  const valueText = svg.append('text')
    .attr('class', 'gauge-value')
    .attr('text-anchor', 'middle')
    .attr('dy', radius * 0.3)
    .style('font-size', `${radius * 0.35}px`)
    .style('font-weight', 'bold')
    .text('0');
  
  // Create text element for the label
  const labelText = svg.append('text')
    .attr('class', 'gauge-label')
    .attr('text-anchor', 'middle')
    .attr('dy', radius * 0.6)
    .style('font-size', `${radius * 0.2}px`)
    .text(config.label || '');
  
  // Return gauge object
  return {
    update: function(value) {
      // Clamp value to min/max range
      const clampedValue = Math.max(config.min, Math.min(config.max, value));
      
      // Calculate angle based on value
      const ratio = (clampedValue - config.min) / (config.max - config.min);
      const angle = ratio * Math.PI - Math.PI / 2;
      
      // Update value arc
      valueArc.endAngle(angle);
      foreground.attr('d', valueArc);
      
      // Update color based on value
      if (config.color) {
        foreground.style('fill', config.color(clampedValue));
      }
      
      // Update needle position
      needleLine
        .attr('x2', Math.cos(angle) * radius * 0.7)
        .attr('y2', Math.sin(angle) * radius * 0.7);
      
      // Update value text
      valueText.text(Math.round(clampedValue));
      
      // Animate transition
      needleLine
        .transition()
        .duration(500)
        .attr('x2', Math.cos(angle) * radius * 0.7)
        .attr('y2', Math.sin(angle) * radius * 0.7);
      
      needleCircle
        .transition()
        .duration(500)
        .style('fill', config.color ? config.color(clampedValue) : '#5a5c69');
    }
  };
}

/**
 * Update gauge charts with the latest data
 */
function updateGaugeCharts() {
  // Get the latest metrics
  const metrics = window.dataManager ? window.dataManager.getLatestMetrics() : null;
  
  if (!metrics) {
    // Use dummy data for testing
    cpuGauge.update(Math.random() * 100);
    memoryGauge.update(Math.random() * 100);
    networkGauge.update(Math.random() * 100);
    alertsGauge.update(Math.floor(Math.random() * 10));
    return;
  }
  
  // Update CPU gauge
  if (metrics.cpu) {
    cpuGauge.update(metrics.cpu.usage);
    document.getElementById('cpu-value').textContent = `${Math.round(metrics.cpu.usage)}%`;
    updateTrend('cpu-trend', metrics.cpu.trend);
  }
  
  // Update memory gauge
  if (metrics.memory) {
    memoryGauge.update(metrics.memory.usage);
    document.getElementById('memory-value').textContent = `${Math.round(metrics.memory.usage)}%`;
    updateTrend('memory-trend', metrics.memory.trend);
  }
  
  // Update network gauge
  if (metrics.network) {
    const networkValue = metrics.network.throughput;
    networkGauge.update(networkValue);
    document.getElementById('network-value').textContent = `${networkValue.toFixed(1)} MB/s`;
    updateTrend('network-trend', metrics.network.trend);
  }
  
  // Update alerts gauge
  if (metrics.alerts) {
    const alertCount = metrics.alerts.active;
    alertsGauge.update(alertCount);
    document.getElementById('alerts-value').textContent = alertCount;
    updateTrend('alerts-trend', metrics.alerts.trend);
  }
}

/**
 * Update a trend indicator
 * @param {string} elementId - The ID of the trend element
 * @param {number} trend - The trend value
 */
function updateTrend(elementId, trend) {
  const element = document.getElementById(elementId);
  
  if (!element) {
    return;
  }
  
  // Remove existing classes
  element.classList.remove('up', 'down', 'none');
  
  // Add appropriate class and text
  if (trend > 0) {
    element.classList.add('up');
    element.textContent = `+${trend.toFixed(1)}%`;
  } else if (trend < 0) {
    element.classList.add('down');
    element.textContent = `${trend.toFixed(1)}%`;
  } else {
    element.classList.add('none');
    element.textContent = '0%';
  }
}

/**
 * Handle window resize for gauge charts
 */
window.addEventListener('resize', () => {
  // Reinitialize gauges on window resize
  initializeGaugeCharts();
});
```


### Performance Charts

```javascript
/**
 * File: /docs/monitoring/dashboard/js/charts/performance.js
 * IQSMS Monitoring Dashboard - Performance charts
 * Copyright 2025 Autonomy Association International Inc., all rights reserved
 */

let performanceChart;
let performanceChartType = 'cpu';
let protocolsChart;

/**
 * Initialize the performance chart
 */
function initializePerformanceChart() {
  // Initialize performance chart
  createPerformanceChart();
  
  // Initialize protocols chart
  createProtocolsChart();
  
  // Set initial values
  updatePerformanceChart();
  updateProtocolsChart();
}

/**
 * Create the performance chart
 */
function createPerformanceChart() {
  const container = d3.select('#performance-chart');
  container.html('');
  
  const width = container.node().getBoundingClientRect().width;
  const height = container.node().getBoundingClientRect().height;
  
  // Set margins
  const margin = {top: 20, right: 20, bottom: 30, left: 50};
  const chartWidth = width - margin.left - margin.right;
  const chartHeight = height - margin.top - margin.bottom;
  
  // Create SVG element
  const svg = container.append('svg')
    .attr('width', width)
    .attr('height', height)
    .append('g')
    .attr('transform', `translate(${margin.left}, ${margin.top})`);
  
  // Create scales
  const xScale = d3.scaleTime()
    .range([0, chartWidth]);
  
  const yScale = d3.scaleLinear()
    .range([chartHeight, 0]);
  
  // Create axes
  const xAxis = d3.axisBottom(xScale)
    .ticks(width > 600 ? 10 : 5)
    .tickFormat(d3.timeFormat('%H:%M'));
  
  const yAxis = d3.axisLeft(yScale);
  
  // Add axes
  svg.append('g')
    .attr('class', 'x-axis')
    .attr('transform', `translate(0, ${chartHeight})`)
    .call(xAxis);
  
  svg.append('g')
    .attr('class', 'y-axis')
    .call(yAxis);
  
  // Add y-axis label
  svg.append('text')
    .attr('class', 'y-axis-label')
    .attr('transform', 'rotate(-90)')
    .attr('y', 0 - margin.left)
    .attr('x', 0 - (chartHeight / 2))
    .attr('dy', '1em')
    .style('text-anchor', 'middle')
    .text('CPU Usage (%)');
  
  // Create line generator
  const line = d3.line()
    .x(d => xScale(new Date(d.timestamp)))
    .y(d => yScale(d.value))
    .curve(d3.curveMonotoneX);
  
  // Add line path
  svg.append('path')
    .attr('class', 'line')
    .style('fill', 'none')
    .style('stroke', '#4e73df')
    .style('stroke-width', '2px');
  
  // Add area
  svg.append('path')
    .attr('class', 'area')
    .style('fill', 'url(#area-gradient)')
    .style('opacity', '0.3');
  
  // Create gradient
  const gradient = svg.append('defs')
    .append('linearGradient')
    .attr('id', 'area-gradient')
    .attr('x1', '0%')
    .attr('y1', '0%')
    .attr('x2', '0%')
    .attr('y2', '100%');
  
  gradient.append('stop')
    .attr('offset', '0%')
    .attr('stop-color', '#4e73df')
    .attr('stop-opacity', 0.8);
  
  gradient.append('stop')
    .attr('offset', '100%')
    .attr('stop-color', '#4e73df')
    .attr('stop-opacity', 0.2);
  
  // Store chart components
  performanceChart = {
    svg,
    xScale,
    yScale,
    xAxis,
    yAxis,
    line,
    width,
    height,
    chartWidth,
    chartHeight,
    margin
  };
}

/**
 * Create the protocols chart
 */
function createProtocolsChart() {
  const container = d3.select('#protocols-chart');
  container.html('');
  
  const width = container.node().getBoundingClientRect().width;
  const height = container.node().getBoundingClientRect().height;
  
  // Create SVG element
  const svg = container.append('svg')
    .attr('width', width)
    .attr('height', height)
    .append('g')
    .attr('transform', `translate(${width / 2}, ${height / 2})`);
  
  // Set radius
  const radius = Math.min(width, height) / 2 - 30;
  
  // Create pie layout
  const pie = d3.pie()
    .value(d => d.value)
    .sort(null);
  
  // Create arc generator
  const arc = d3.arc()
    .innerRadius(radius * 0.6)
    .outerRadius(radius);
  
  // Create color scale
  const color = d3.scaleOrdinal()
    .range(['#4e73df', '#1cc88a', '#36b9cc', '#f6c23e', '#e74a3b']);
  
  // Add pie chart
  const arcs = svg.selectAll('.arc')
    .data(pie([]))
    .enter()
    .append('g')
    .attr('class', 'arc');
  
  arcs.append('path')
    .attr('d', arc)
    .attr('fill', (d, i) => color(i));
  
  // Add labels
  const arcLabel = d3.arc()
    .innerRadius(radius * 0.8)
    .outerRadius(radius * 0.8);
  
  arcs.append('text')
    .attr('transform', d => `translate(${arcLabel.centroid(d)})`)
    .attr('dy', '0.35em')
    .text(d => d.data.name)
    .style('text-anchor', 'middle')
    .style('font-size', '12px')
    .style('fill', 'white');
  
  // Add center text
  svg.append('text')
    .attr('class', 'total-text')
    .attr('text-anchor', 'middle')
    .attr('dy', '0.35em')
    .style('font-size', '16px')
    .style('font-weight', 'bold')
    .text('0');
  
  // Store chart components
  protocolsChart = {
    svg,
    pie,
    arc,
    arcLabel,
    color,
    width,
    height,
    radius
  };
}

/**
 * Update the performance chart with the latest data
 */
function updatePerformanceChart() {
  if (!performanceChart) {
    return;
  }
  
  // Get data based on chart type
  const data = window.dataManager ? window.dataManager.getMetricsHistory(performanceChartType) : [];
  
  if (data.length === 0) {
    // Generate dummy data for testing
    const now = new Date();
    const dummyData = [];
    for (let i = 0; i < 50; i++) {
      dummyData.push({
        timestamp: new Date(now.getTime() - (50 - i) * 5 * 60 * 1000),
        value: Math.random() * 100
      });
    }
    
    updatePerformanceChartWithData(dummyData);
    return;
  }
  
  updatePerformanceChartWithData(data);
}

/**
 * Update the performance chart with the provided data
 * @param {Array} data - The data to display
 */
function updatePerformanceChartWithData(data) {
  const {svg, xScale, yScale, xAxis, yAxis, line, chartHeight} = performanceChart;
  
  // Update scales
  xScale.domain(d3.extent(data, d => new Date(d.timestamp)));
  yScale.domain([0, d3.max(data, d => d.value) * 1.1]);
  
  // Update axes
  svg.select('.x-axis')
    .transition()
    .duration(500)
    .call(xAxis);
  
  svg.select('.y-axis')
    .transition()
    .duration(500)
    .call(yAxis);
  
  // Update y-axis label
  let yAxisLabel = 'CPU Usage (%)';
  switch (performanceChartType) {
    case 'memory':
      yAxisLabel = 'Memory Usage (%)';
      break;
    case 'network':
      yAxisLabel = 'Network Traffic (MB/s)';
      break;
    case 'disk':
      yAxisLabel = 'Disk I/O (MB/s)';
      break;
  }
  
  svg.select('.y-axis-label')
    .text(yAxisLabel);
  
  // Update line
  svg.select('.line')
    .datum(data)
    .transition()
    .duration(500)
    .attr('d', line);
  
  // Update area
  const area = d3.area()
    .x(d => xScale(new Date(d.timestamp)))
    .y0(chartHeight)
    .y1(d => yScale(d.value))
    .curve(d3.curveMonotoneX);
  
  svg.select('.area')
    .datum(data)
    .transition()
    .duration(500)
    .attr('d', area);
}

/**
 * Update the protocols chart with the latest data
 */
function updateProtocolsChart() {
  if (!protocolsChart) {
    return;
  }
  
  // Get protocols data
  const metrics = window.dataManager ? window.dataManager.getLatestMetrics() : null;
  let data = [];
  
  if (!metrics || !metrics.protocols) {
    // Generate dummy data for testing
    data = [
      {name: 'Agent', value: 35},
      {name: 'MCP', value: 25},
      {name: 'Message', value: 20},
      {name: 'WebSocket', value: 15},
      {name: 'HTTP', value: 5}
    ];
  } else {
    data = metrics.protocols;
  }
  
  // Calculate total
  const total = data.reduce((sum, d) => sum + d.value, 0);
  
  // Update pie chart
  const {svg, pie, arc, arcLabel, color} = protocolsChart;
  
  // Update arcs
  const arcs = svg.selectAll('.arc')
    .data(pie(data));
  
  // Remove old arcs
  arcs.exit().remove();
  
  // Add new arcs
  const enterArcs = arcs.enter()
    .append('g')
    .attr('class', 'arc');
  
  enterArcs.append('path')
    .attr('d', arc)
    .attr('fill', (d, i) => color(i));
  
  enterArcs.append('text')
    .attr('transform', d => `translate(${arcLabel.centroid(d)})`)
    .attr('dy', '0.35em')
    .style('text-anchor', 'middle')
    .style('font-size', '12px')
    .style('fill', 'white');
  
  // Update existing arcs
  arcs.select('path')
    .transition()
    .duration(500)
    .attrTween('d', function(d) {
      const interpolate = d3.interpolate(this._current || d, d);
      this._current = interpolate(0);
      return function(t) {
        return arc(interpolate(t));
      };
    })
    .attr('fill', (d, i) => color(i));
  
  arcs.select('text')
    .transition()
    .duration(500)
    .attr('transform', d => `translate(${arcLabel.centroid(d)})`)
    .text(d => d.data.value > 5 ? d.data.name : '');
  
  // Update merged selection
  const mergedArcs = enterArcs.merge(arcs);
  
  mergedArcs.select('path')
    .on('mouseover', function(event, d) {
      d3.select(this)
        .transition()
        .duration(200)
        .attr('d', d3.arc()
          .innerRadius(protocolsChart.radius * 0.6)
          .outerRadius(protocolsChart.radius * 1.05)
        );
      
      // Update center text
      svg.select('.total-text')
        .text(`${d.data.name}: ${d.data.value}`);
    })
    .on('mouseout', function() {
      d3.select(this)
        .transition()
        .duration(200)
        .attr('d', arc);
      
      // Restore center text
      svg.select('.total-text')
        .text(total);
    });
  
  // Update center text
  svg.select('.total-text')
    .text(total);
}

/**
 * Update the performance chart type
 * @param {string} type - The chart type (cpu, memory, disk, network)
 */
function updatePerformanceChartType(type) {
  performanceChartType = type;
  updatePerformanceChart();
}

/**
 * Handle window resize
 */
window.addEventListener('resize', () => {
  // Recreate charts on window resize
  createPerformanceChart();
  createProtocolsChart();
  
  // Update with current data
  updatePerformanceChart();
  updateProtocolsChart();
});
```


### Network Map

```javascript
/**
 * File: /docs/monitoring/dashboard/js/charts/network-map.js
 * IQSMS Monitoring Dashboard - Three.js network visualization
 * Copyright 2025 Autonomy Association International Inc., all rights reserved
 */

let networkScene, networkCamera, networkRenderer, networkControls;
let nodes = [], links = [], nodeObjects = {}, linkObjects = [];
let raycaster, mouse;
let currentViewType = '3D View';

/**
 * Initialize the network map visualization
 */
function initializeNetworkMap() {
  // Check for WebGL support
  if (!isWebGLSupported()) {
    fallbackTo2DView();
    return;
  }
  
  // Create scene, camera, and renderer
  setupThreeJsEnvironment();
  
  // Add lighting to the scene
  addLighting();
  
  // Create helper objects
  setupHelpers();
  
  // Add event listeners
  addNetworkMapEventListeners();
  
  // Start animation loop
  animate();
  
  // Initialize with data
  updateNetworkMap();
}

/**
 * Check if WebGL is supported
 * @returns {boolean} - Whether WebGL is supported
 */
function isWebGLSupported() {
  try {
    const canvas = document.createElement('canvas');
    return !!(window.WebGLRenderingContext && 
      (canvas.getContext('webgl') || canvas.getContext('experimental-webgl')));
  } catch (e) {
    return false;
  }
}

/**
 * Fall back to 2D view if WebGL is not supported
 */
function fallbackTo2DView() {
  console.log('WebGL not supported, falling back to 2D view');
  currentViewType = '2D View';
  const container = document.getElementById('network-map');
  
  // Show fallback message
  const fallbackMessage = document.createElement('div');
  fallbackMessage.className = 'webgl-fallback-message';
  fallbackMessage.innerHTML = `
    <div class="alert alert-warning">
      <i class="fas fa-exclamation-triangle mr-2"></i>
      <strong>WebGL Not Available:</strong> Using 2D visualization instead.
      <button class="btn btn-sm btn-outline-dark ml-3" onclick="initialize2DNetworkMap()">
        Show 2D Network Map
      </button>
    </div>
  `;
  container.appendChild(fallbackMessage);
  
  // Initialize 2D network map
  initialize2DNetworkMap();
}

/**
 * Set up the Three.js environment (scene, camera, renderer)
 */
function setupThreeJsEnvironment() {
  const container = document.getElementById('network-map');
  const width = container.clientWidth;
  const height = container.clientHeight;
  
  // Create scene
  networkScene = new THREE.Scene();
  networkScene.background = new THREE.Color(0x181c30);
  
  // Create camera
  networkCamera = new THREE.PerspectiveCamera(60, width / height, 0.1, 1000);
  networkCamera.position.set(0, 0, 150);
  networkCamera.lookAt(0, 0, 0);
  
  // Create renderer
  networkRenderer = new THREE.WebGLRenderer({ antialias: true });
  networkRenderer.setSize(width, height);
  networkRenderer.setPixelRatio(window.devicePixelRatio);
  container.appendChild(networkRenderer.domElement);
  
  // Add orbit controls if available
  if (typeof THREE.OrbitControls !== 'undefined') {
    networkControls = new THREE.OrbitControls(networkCamera, networkRenderer.domElement);
    networkControls.enableDamping = true;
    networkControls.dampingFactor = 0.1;
    networkControls.rotateSpeed = 0.5;
  }
  
  // Handle window resize
  window.addEventListener('resize', onNetworkMapResize);
}

/**
 * Add lighting to the scene
 */
function addLighting() {
  // Add ambient light
  const ambientLight = new THREE.AmbientLight(0x404040, 1);
  networkScene.add(ambientLight);
  
  // Add directional light
  const directionalLight = new THREE.DirectionalLight(0xffffff, 0.8);
  directionalLight.position.set(1, 1, 1);
  networkScene.add(directionalLight);
  
  // Add point lights for additional illumination
  const pointLight1 = new THREE.PointLight(0x4e73df, 1, 100);
  pointLight1.position.set(50, 50, 50);
  networkScene.add(pointLight1);
  
  const pointLight2 = new THREE.PointLight(0x1cc88a, 1, 100);
  pointLight2.position.set(-50, -50, 50);
  networkScene.add(pointLight2);
}

/**
 * Set up helper objects (raycaster, mouse)
 */
function setupHelpers() {
  // Create raycaster for mouse interaction
  raycaster = new THREE.Raycaster();
  mouse = new THREE.Vector2();
  
  // Create grid helper
  const gridHelper = new THREE.GridHelper(200, 20, 0x303030, 0x303030);
  gridHelper.position.y = -40;
  networkScene.add(gridHelper);
}

/**
 * Add event listeners for the network map
 */
function addNetworkMapEventListeners() {
  const container = document.getElementById('network-map');
  
  // Mouse move event for hover effects
  container.addEventListener('mousemove', onNetworkMapMouseMove);
  
  // Click event for node selection
  container.addEventListener('click', onNetworkMapClick);
}

/**
 * Handle window resize event
 */
function onNetworkMapResize() {
  const container = document.getElementById('network-map');
  const width = container.clientWidth;
  const height = container.clientHeight;
  
  networkCamera.aspect = width / height;
  networkCamera.updateProjectionMatrix();
  networkRenderer.setSize(width, height);
}

/**
 * Handle mouse move event
 * @param {MouseEvent} event - The mouse event
 */
function onNetworkMapMouseMove(event) {
  // Calculate mouse position in normalized device coordinates
  const container = document.getElementById('network-map');
  const rect = container.getBoundingClientRect();
  
  mouse.x = ((event.clientX - rect.left) / container.clientWidth) * 2 - 1;
  mouse.y = -((event.clientY - rect.top) / container.clientHeight) * 2 + 1;
  
  // Update raycaster
  raycaster.setFromCamera(mouse, networkCamera);
  
  // Find intersections with nodes
  const intersects = raycaster.intersectObjects(Object.values(nodeObjects));
  
  // Update cursor and node appearance based on intersections
  if (intersects.length > 0) {
    container.style.cursor = 'pointer';
    // Highlight intersected node
    const intersectedNode = intersects[0].object;
    highlightNode(intersectedNode);
  } else {
    container.style.cursor = 'default';
    // Reset all nodes
    resetNodeHighlights();
  }
}

/**
 * Handle click event
 * @param {MouseEvent} event - The mouse event
 */
function onNetworkMapClick(event) {
  // Calculate mouse position in normalized device coordinates
  const container = document.getElementById('network-map');
  const rect = container.getBoundingClientRect();
  
  mouse.x = ((event.clientX - rect.left) / container.clientWidth) * 2 - 1;
  mouse.y = -((event.clientY - rect.top) / container.clientHeight) * 2 + 1;
  
  // Update raycaster
  raycaster.setFromCamera(mouse, networkCamera);
  
  // Find intersections with nodes
  const intersects = raycaster.intersectObjects(Object.values(nodeObjects));
  
  if (intersects.length > 0) {
    const nodeObject = intersects[0].object;
    selectNode(nodeObject);
  }
}

/**
 * Highlight a node
 * @param {THREE.Mesh} nodeObject - The node to highlight
 */
function highlightNode(nodeObject) {
  // Reset all nodes first
  resetNodeHighlights();
  
  // Scale up the highlighted node
  nodeObject.scale.set(1.2, 1.2, 1.2);
  
  // Change the material color
  nodeObject.material.color.setHex(0xf6c23e);
  
  // Add glow effect (simplified version)
  nodeObject.material.emissive.setHex(0x555555);
}

/**
 * Reset all node highlights
 */
function resetNodeHighlights() {
  Object.values(nodeObjects).forEach(nodeObject => {
    // Reset scale
    nodeObject.scale.set(1, 1, 1);
    
    // Reset color based on node type
    const nodeData = nodes.find(n => n.id === nodeObject.userData.id);
    if (nodeData) {
      const color = getNodeColor(nodeData.type);
      nodeObject.material.color.set(color);
      nodeObject.material.emissive.set(0x000000);
    }
  });
}

/**
 * Select a node
 * @param {THREE.Mesh} nodeObject - The node to select
 */
function selectNode(nodeObject) {
  // Find the node data
  const nodeData = nodes.find(n => n.id === nodeObject.userData.id);
  
  if (nodeData) {
    // Show node details in a popup or panel
    showNodeDetails(nodeData);
    
    // Highlight connected nodes and links
    highlightConnections(nodeData.id);
  }
}

/**
 * Show node details in a popup or panel
 * @param {Object} nodeData - The node data
 */
function showNodeDetails(nodeData) {
  // Remove any existing detail panel
  const existingPanel = document.querySelector('.node-details-panel');
  if (existingPanel) {
    existingPanel.remove();
  }
  
  // Create a detail panel
  const detailPanel = document.createElement('div');
  detailPanel.className = 'node-details-panel';
  detailPanel.innerHTML = `
    <div class="node-details-header">
      <h4>${nodeData.name}</h4>
      <button class="close-button">&times;</button>
    </div>
    <div class="node-details-content">
      <p><strong>Type:</strong> ${nodeData.type}</p>
      <p><strong>Status:</strong> ${nodeData.status}</p>
      <p><strong>Location:</strong> ${nodeData.location || 'Unknown'}</p>
      <p><strong>Connections:</strong> ${
        links.filter(link => link.source === nodeData.id || link.target === nodeData.id).length
      }</p>
      <p><strong>Last Seen:</strong> ${
        nodeData.lastSeen ? new Date(nodeData.lastSeen).toLocaleString() : 'Unknown'
      }</p>
    </div>
  `;
  
  // Add the detail panel to the DOM
  const container = document.getElementById('network-map');
  container.appendChild(detailPanel);
  
  // Add event listener to close button
  const closeButton = detailPanel.querySelector('.close-button');
  closeButton.addEventListener('click', () => {
    container.removeChild(detailPanel);
    resetNodeHighlights();
  });
}

/**
 * Highlight connections for a node
 * @param {string} nodeId - The ID of the node
 */
function highlightConnections(nodeId) {
  // Find all links connected to this node
  const connectedLinks = links.filter(link => link.source === nodeId || link.target === nodeId);
  
  // Find all nodes connected to this node
  const connectedNodeIds = new Set();
  connectedLinks.forEach(link => {
    connectedNodeIds.add(link.source);
    connectedNodeIds.add(link.target);
  });
  
  // Dim all nodes and links
  Object.values(nodeObjects).forEach(nodeObject => {
    nodeObject.material.opacity = 0.2;
  });
  
  linkObjects.forEach(linkObject => {
    linkObject.material.opacity = 0.1;
  });
  
  // Highlight the selected node
  const selectedNodeObject = nodeObjects[nodeId];
  if (selectedNodeObject) {
    selectedNodeObject.material.opacity = 1;
    selectedNodeObject.scale.set(1.2, 1.2, 1.2);
    selectedNodeObject.material.color.setHex(0xf6c23e);
    selectedNodeObject.material.emissive.setHex(0x555555);
  }
  
  // Highlight connected nodes
  connectedNodeIds.forEach(id => {
    const nodeObject = nodeObjects[id];
    if (nodeObject) {
      nodeObject.material.opacity = 1;
    }
  });
  
  // Highlight connected links
  connectedLinks.forEach(link => {
    const linkId = `${link.source}-${link.target}`;
    const linkObject = linkObjects.find(l => l.userData.id === linkId);
    if (linkObject) {
      linkObject.material.opacity = 1;
      linkObject.material.color.setHex(0xf6c23e);
    }
  });
}

/**
 * Get color for a node based on its type
 * @param {string} type - The node type
 * @returns {number} - The color hex code
 */
function getNodeColor(type) {
  switch (type) {
    case 'server':
      return 0x4e73df; // Primary blue
    case 'client':
      return 0x1cc88a; // Success green
    case 'gateway':
      return 0xe74a3b; // Danger red
    case 'router':
      return 0xf6c23e; // Warning yellow
    case 'sensor':
      return 0x36b9cc; // Info cyan
    default:
      return 0x858796; // Secondary gray
  }
}

/**
 * Update the network map with new data
 */
function updateNetworkMap() {
  // Update based on current view type
  switch (currentViewType) {
    case '3D View':
      update3DNetworkMap();
      break;
    case '2D View':
      update2DNetworkMap();
      break;
    case 'Geo Map':
      updateGeoNetworkMap();
      break;
  }
}

/**
 * Update the 3D network map with new data
 */
function update3DNetworkMap() {
  // Fetch the latest network data
  const networkData = window.dataManager ? window.dataManager.getNetworkData() : null;
  
  if (!networkData) {
    return;
  }
  
  // Update nodes and links
  nodes = networkData.nodes || [];
  links = networkData.links || [];
  
  // Clear existing nodes and links
  clearNetworkMap();
  
  // Create new nodes and links
  createNodes();
  createLinks();
}

/**
 * Clear all nodes and links from the network map
 */
function clearNetworkMap() {
  // Remove node objects from the scene
  Object.values(nodeObjects).forEach(nodeObject => {
    networkScene.remove(nodeObject);
  });
  
  // Remove link objects from the scene
  linkObjects.forEach(linkObject => {
    networkScene.remove(linkObject);
  });
  
  // Reset node and link object collections
  nodeObjects = {};
  linkObjects = [];
}

/**
 * Create node objects in the scene
 */
function createNodes() {
  nodes.forEach(node => {
    // Create a sphere geometry for the node
    const geometry = new THREE.SphereGeometry(node.size || 3, 32, 32);
    
    // Create a material with the node's color
    const material = new THREE.MeshPhongMaterial({
      color: getNodeColor(node.type),
      transparent: true,
      opacity: 0.8,
      shininess: 30
    });
    
    // Create the mesh
    const mesh = new THREE.Mesh(geometry, material);
    
    // Set position
    mesh.position.set(
      node.x || (Math.random() * 100 - 50),
      node.y || (Math.random() * 100 - 50),
      node.z || (Math.random() * 100 - 50)
    );
    
    // Store node ID in userData
    mesh.userData = {
      id: node.id,
      type: node.type,
      name: node.name
    };
    
    // Add to scene
    networkScene.add(mesh);
    
    // Store in nodeObjects dictionary
    nodeObjects[node.id] = mesh;
    
    // Add node label
    if (node.name) {
      addNodeLabel(node, mesh.position);
    }
  });
}

/**
 * Add a text label for a node
 * @param {Object} node - The node data
 * @param {THREE.Vector3} position - The position of the node
 */
function addNodeLabel(node, position) {
  // This is a simplified implementation
  // In a real application, you would use a TextSprite or HTML overlay
  console.log(`Added label for node ${node.name} at position ${position.x}, ${position.y}, ${position.z}`);
}

/**
 * Create link objects in the scene
 */
function createLinks() {
  links.forEach(link => {
    // Find source and target nodes
    const sourceNode = nodeObjects[link.source];
    const targetNode = nodeObjects[link.target];
    
    if (!sourceNode || !targetNode) {
      return;
    }
    
    // Create link geometry
    const points = [
      sourceNode.position.clone(),
      targetNode.position.clone()
    ];
    
    const geometry = new THREE.BufferGeometry().setFromPoints(points);
    
    // Create link material
    const material = new THREE.LineBasicMaterial({
      color: link.color || 0x4e73df,
      transparent: true,
      opacity: 0.5,
      linewidth: link.weight || 1
    });
    
    // Create the line
    const line = new THREE.Line(geometry, material);
    
    // Store link data in userData
    line.userData = {
      id: `${link.source}-${link.target}`,
      source: link.source,
      target: link.target,
      type: link.type
    };
    
    // Add to scene
    networkScene.add(line);
    
    // Store in linkObjects array
    linkObjects.push(line);
  });
}

/**
 * Animation loop
 */
function animate() {
  requestAnimationFrame(animate);
  
  // Update controls if available
  if (networkControls) {
    networkControls.update();
  }
  
  // Render scene
  networkRenderer.render(networkScene, networkCamera);
}

/**
 * Initialize 2D network map
 */
function initialize2DNetworkMap() {
  const container = document.getElementById('network-map');
  container.innerHTML = '';
  
  // Create SVG element for 2D network map
  const width = container.clientWidth;
  const height = container.clientHeight;
  
  const svg = d3.select(container)
    .append('svg')
    .attr('width', width)
    .attr('height', height)
    .attr('class', 'network-map-2d');
  
  // Create force simulation
  const simulation = d3.forceSimulation()
    .force('link', d3.forceLink().id(d => d.id).distance(50))
    .force('charge', d3.forceManyBody().strength(-100))
    .force('center', d3.forceCenter(width / 2, height / 2));
  
  // Create groups for links and nodes
  const linkGroup = svg.append('g').attr('class', 'links');
  const nodeGroup = svg.append('g').attr('class', 'nodes');
  
  // Store D3 components
  window.networkMap2D = {
    svg,
    simulation,
    linkGroup,
    nodeGroup,
    width,
    height
  };
  
  // Update with data
  update2DNetworkMap();
}

/**
 * Update the 2D network map with new data
 */
function update2DNetworkMap() {
  if (!window.networkMap2D) {
    initialize2DNetworkMap();
    return;
  }
  
  const {svg, simulation, linkGroup, nodeGroup, width, height} = window.networkMap2D;
  
  // Fetch the latest network data
  const networkData = window.dataManager ? window.dataManager.getNetworkData() : null;
  
  if (!networkData) {
    return;
  }
  
  // Update nodes and links
  const nodes = networkData.nodes || [];
  const links = networkData.links || [];
  
  // Create link elements
  const link = linkGroup.selectAll('line')
    .data(links, d => `${d.source}-${d.target}`);
  
  // Remove old links
  link.exit().remove();
  
  // Add new links
  const linkEnter = link.enter()
    .append('line')
    .attr('stroke', d => d.color || '#4e73df')
    .attr('stroke-width', d => d.weight || 1)
    .attr('stroke-opacity', 0.5);
  
  // Create node elements
  const node = nodeGroup.selectAll('circle')
    .data(nodes, d => d.id);
  
  // Remove old nodes
  node.exit().remove();
  
  // Add new nodes
  const nodeEnter = node.enter()
    .append('circle')
    .attr('r', d => d.size || 5)
    .attr('fill', d => d3.color(getNodeColor(d.type).toString(16)))
    .attr('stroke', '#fff')
    .attr('stroke-width', 1.5)
    .call(d3.drag()
      .on('start', dragstarted)
      .on('drag', dragged)
      .on('end', dragended));
  
  // Add tooltips
  nodeEnter.append('title')
    .text(d => d.name);
  
  // Add interactivity
  nodeEnter
    .on('mouseover', function(event, d) {
      d3.select(this)
        .transition()
        .duration(200)
        .attr('r', (d.size || 5) * 1.2)
        .attr('fill', '#f6c23e');
    })
    .on('mouseout', function(event, d) {
      d3.select(this)
        .transition()
        .duration(200)
        .attr('r', d.size || 5)
        .attr('fill', d3.color(getNodeColor(d.type).toString(16)));
    })
    .on('click', function(event, d) {
      show2DNodeDetails(d);
    });
  
  // Update simulation
  simulation.nodes(nodes).on('tick', ticked);
  simulation.force('link').links(links);
  simulation.alpha(1).restart();
  
  // Tick function to update positions
  function ticked() {
    linkEnter.merge(link)
      .attr('x1', d => d.source.x)
      .attr('y1', d => d.source.y)
      .attr('x2', d => d.target.x)
      .attr('y2', d => d.target.y);
    
    nodeEnter.merge(node)
      .attr('cx', d => d.x = Math.max(d.size || 5, Math.min(width - (d.size || 5), d.x)))
      .attr('cy', d => d.y = Math.max(d.size || 5, Math.min(height - (d.size || 5), d.y)));
  }
  
  // Drag functions
  function dragstarted(event, d) {
    if (!event.active) simulation.alphaTarget(0.3).restart();
    d.fx = d.x;
    d.fy = d.y;
  }
  
  function dragged(event, d) {
    d.fx = event.x;
    d.fy = event.y;
  }
  
  function dragended(event, d) {
    if (!event.active) simulation.alphaTarget(0);
    d.fx = null;
    d.fy = null;
  }
}

/**
 * Show node details in the 2D view
 * @param {Object} nodeData - The node data
 */
function show2DNodeDetails(nodeData) {
  // Find connected links
  const connectedLinks = links.filter(link => 
    link.source.id === nodeData.id || link.target.id === nodeData.id
  );
  
  // Find connected nodes
  const connectedNodeIds = new Set();
  connectedLinks.forEach(link => {
    connectedNodeIds.add(link.source.id !== nodeData.id ? link.source.id : link.target.id);
  });
  
  // Highlight node and connections
  const {svg} = window.networkMap2D;
  
  // Dim all nodes and links
  svg.selectAll('.nodes circle')
    .transition()
    .duration(300)
    .attr('opacity', 0.2);
  
  svg.selectAll('.links line')
    .transition()
    .duration(300)
    .attr('stroke-opacity', 0.1);
  
  // Highlight selected node
  svg.selectAll('.nodes circle')
    .filter(d => d.id === nodeData.id)
    .transition()
    .duration(300)
    .attr('opacity', 1)
    .attr('r', (nodeData.size || 5) * 1.2)
    .attr('fill', '#f6c23e');
  
  // Highlight connected nodes
  svg.selectAll('.nodes circle')
    .filter(d => connectedNodeIds.has(d.id))
    .transition()
    .duration(300)
    .attr('opacity', 1);
  
  // Highlight connected links
  svg.selectAll('.links line')
    .filter(d => d.source.id === nodeData.id || d.target.id === nodeData.id)
    .transition()
    .duration(300)
    .attr('stroke-opacity', 1)
    .attr('stroke', '#f6c23e');
  
  // Show details panel
  const container = document.getElementById('network-map');
  
  // Remove any existing detail panel
  const existingPanel = container.querySelector('.node-details-panel');
  if (existingPanel) {
    existingPanel.remove();
  }
  
  // Create detail panel
  const detailPanel = document.createElement('div');
  detailPanel.className = 'node-details-panel';
  detailPanel.innerHTML = `
    <div class="node-details-header">
      <h4>${nodeData.name}</h4>
      <button class="close-button">&times;</button>
    </div>
    <div class="node-details-content">
      <p><strong>Type:</strong> ${nodeData.type}</p>
      <p><strong>Status:</strong> ${nodeData.status}</p>
      <p><strong>Location:</strong> ${nodeData.location || 'Unknown'}</p>
      <p><strong>Connections:</strong> ${connectedNodeIds.size}</p>
      <p><strong>Last Seen:</strong> ${
        nodeData.lastSeen ? new Date(nodeData.lastSeen).toLocaleString() : 'Unknown'
      }</p>
    </div>
  `;
  
  // Add panel to container
  container.appendChild(detailPanel);
  
  // Add close button event
  detailPanel.querySelector('.close-button').addEventListener('click', () => {
    // Remove panel
    container.removeChild(detailPanel);
    
    // Reset highlighting
    svg.selectAll('.nodes circle')
      .transition()
      .duration(300)
      .attr('opacity', 1)
      .attr('r', d => d.size || 5)
      .attr('fill', d => d3.color(getNodeColor(d.type).toString(16)));
    
    svg.selectAll('.links line')
      .transition()
      .duration(300)
      .attr('stroke-opacity', 0.5)
      .attr('stroke', d => d.color || '#4e73df');
  });
}

/**
 * Initialize geographical network map
 */
function initializeGeoNetworkMap() {
  const container = document.getElementById('network-map');
  container.innerHTML = '';
  
  // Create SVG element for geo network map
  const width = container.clientWidth;
  const height = container.clientHeight;
  
  const svg = d3.select(container)
    .append('svg')
    .attr('width', width)
    .attr('height', height)
    .attr('class', 'network-map-geo');
  
  // Create projection
  const projection = d3.geoMercator()
    .scale(width / 6)
    .center([0, 20])
    .translate([width / 2, height / 2]);
  
  // Create path generator
  const path = d3.geoPath().projection(projection);
  
  // Create groups
  const mapGroup = svg.append('g').attr('class', 'map');
  const linkGroup = svg.append('g').attr('class', 'links');
  const nodeGroup = svg.append('g').attr('class', 'nodes');
  
  // Add world map (simplified)
  mapGroup.append('path')
    .attr('class', 'world-map')
    .attr('d', 'M0,0 L' + width + ',' + height)
    .attr('fill', 'none');
  
  // Create zoom behavior
  const zoom = d3.zoom()
    .scaleExtent([1, 8])
    .on('zoom', (event) => {
      mapGroup.attr('transform', event.transform);
      linkGroup.attr('transform', event.transform);
      nodeGroup.attr('transform', event.transform);
    });
  
  svg.call(zoom);
  
  // Store D3 components
  window.networkMapGeo = {
    svg,
    projection,
    path,
    mapGroup,
    linkGroup,
    nodeGroup,
    width,
    height
  };
  
  // Add loading message
  mapGroup.append('text')
    .attr('x', width / 2)
    .attr('y', height / 2)
    .attr('text-anchor', 'middle')
    .text('Loading geographical data...');
  
  // Update with data
  updateGeoNetworkMap();
}

/**
 * Update the geographical network map
 */
function updateGeoNetworkMap() {
  if (!window.networkMapGeo) {
    initializeGeoNetworkMap();
    return;
  }
  
  // Simplified implementation
  const container = document.getElementById('network-map');
  container.innerHTML = `
    <div style="display: flex; justify-content: center; align-items: center; height: 100%; background-color: #181c30; color: white;">
      <div class="text-center">
        <i class="fas fa-globe fa-4x mb-3"></i>
        <h4>Geographical View</h4>
        <p class="mb-4">This feature requires geographical coordinates for network nodes.</p>
        <button class="btn btn-outline-light" onclick="updateNetworkMapView('3D View')">
          Switch to 3D View
        </button>
      </div>
    </div>
  `;
}

/**
 * Update the network map view
 * @param {string} viewType - The view type (3D View, 2D View, Geo Map)
 */
function updateNetworkMapView(viewType) {
  if (currentViewType === viewType) {
    return;
  }
  
  currentViewType = viewType;
  const container = document.getElementById('network-map');
  container.innerHTML = '';
  
  // Update active button
  const buttons = document.querySelectorAll('#network .chart-controls .btn-group button');
  buttons.forEach(button => {
    button.classList.remove('active');
    if (button.textContent.trim() === viewType) {
      button.classList.add('active');
    }
  });
  
  // Initialize the selected view
  switch (viewType) {
    case '3D View':
      initializeNetworkMap();
      break;
    case '2D View':
      initialize2DNetworkMap();
      break;
    case 'Geo Map':
      initializeGeoNetworkMap();
      break;
  }
}
```


### Worker Charts

```javascript
/**
 * File: /docs/monitoring/dashboard/js/charts/worker-charts.js
 * IQSMS Monitoring Dashboard - Worker thread visualization
 * Copyright 2025 Autonomy Association International Inc., all rights reserved
 */

let workerActivityChart;
let workerStatusChart;

/**
 * Initialize worker charts
 */
function initializeWorkerCharts() {
  // Create worker activity chart
  createWorkerActivityChart();
  
  // Create worker status chart
  createWorkerStatusChart();
  
  // Initialize worker table
  initializeWorkerTable();
  
  // Update with initial data
  updateWorkerCharts();
  updateWorkerTable();
}

/**
 * Create worker activity chart
 */
function createWorkerActivityChart() {
  const container = d3.select('#worker-activity-chart');
  container.html('');
  
  const width = container.node().getBoundingClientRect().width;
  const height = container.node().getBoundingClientRect().height;
  
  // Set margins
  const margin = {top: 20, right: 80, bottom: 30, left: 50};
  const chartWidth = width - margin.left - margin.right;
  const chartHeight = height - margin.top - margin.bottom;
  
  // Create SVG element
  const svg = container.append('svg')
    .attr('width', width)
    .attr('height', height)
    .append('g')
    .attr('transform', `translate(${margin.left}, ${margin.top})`);
  
  // Create scales
  const xScale = d3.scaleTime()
    .range([0, chartWidth]);
  
  const yScale = d3.scaleLinear()
    .range([chartHeight, 0]);
  
  // Create axes
  const xAxis = d3.axisBottom(xScale)
    .ticks(width > 600 ? 10 : 5)
    .tickFormat(d3.timeFormat('%H:%M'));
  
  const yAxis = d3.axisLeft(yScale);
  
  // Add axes
  svg.append('g')
    .attr('class', 'x-axis')
    .attr('transform', `translate(0, ${chartHeight})`)
    .call(xAxis);
  
  svg.append('g')
    .attr('class', 'y-axis')
    .call(yAxis);
  
  // Add y-axis label
  svg.append('text')
    .attr('class', 'y-axis-label')
    .attr('transform', 'rotate(-90)')
    .attr('y', 0 - margin.left)
    .attr('x', 0 - (chartHeight / 2))
    .attr('dy', '1em')
    .style('text-anchor', 'middle')
    .text('Worker Count');
  
  // Create color scale
  const colorScale = d3.scaleOrdinal()
    .range(['#4e73df', '#1cc88a', '#f6c23e']);
  
  // Add legend
  const legend = svg.append('g')
    .attr('class', 'legend')
    .attr('transform', `translate(${chartWidth + 10}, 0)`);
  
  // Store chart components
  workerActivityChart = {
    svg,
    xScale,
    yScale,
    xAxis,
    yAxis,
    colorScale,
    legend,
    width,
    height,
    chartWidth,
    chartHeight,
    margin
  };
}

/**
 * Create worker status chart
 */
function createWorkerStatusChart() {
  const container = d3.select('#worker-status-chart');
  container.html('');
  
  const width = container.node().getBoundingClientRect().width;
  const height = container.node().getBoundingClientRect().height;
  
  // Create SVG element
  const svg = container.append('svg')
    .attr('width', width)
    .attr('height', height)
    .append('g')
    .attr('transform', `translate(${width / 2}, ${height / 2})`);
  
  // Set radius
  const radius = Math.min(width, height) / 2 - 30;
  
  // Create pie layout
  const pie = d3.pie()
    .value(d => d.value)
    .sort(null);
  
  // Create arc generator
  const arc = d3.arc()
    .innerRadius(radius * 0.6)
    .outerRadius(radius);
  
  // Create color scale
  const color = d3.scaleOrdinal()
    .domain(['active', 'idle', 'terminated'])
    .range(['#1cc88a', '#f6c23e', '#e74a3b']);
  
  // Store chart components
  workerStatusChart = {
    svg,
    pie,
    arc,
    color,
    width,
    height,
    radius
  };
}

/**
 * Update worker activity chart
 */
function updateWorkerActivityChart() {
  if (!workerActivityChart) {
    return;
  }
  
  // Get worker activity data
  const workerData = window.dataManager ? window.dataManager.getWorkerData() : null;
  let data = [];
  
  if (!workerData || !workerData.activity) {
    // Generate dummy data for testing
    const now = new Date();
    data = [];
    for (let i = 0; i < 24; i++) {
      const timestamp = new Date(now.getTime() - (24 - i) * 60 * 60 * 1000);
      data.push({
        timestamp: timestamp,
        active: Math.floor(Math.random() * 5) + 8,
        idle: Math.floor(Math.random() * 3) + 1,
        tasks: Math.floor(Math.random() * 100) + 50
      });
    }
  } else {
    data = workerData.activity;
  }
  
  const {svg, xScale, yScale, xAxis, yAxis, colorScale, legend, chartHeight} = workerActivityChart;
  
  // Update scales
  xScale.domain(d3.extent(data, d => new Date(d.timestamp)));
  
  // Determine max value for y-scale
  const yMax = d3.max(data, d => Math.max(d.active + d.idle, d.tasks / 10));
  yScale.domain([0, yMax * 1.1]);
  
  // Update axes
  svg.select('.x-axis')
    .transition()
    .duration(500)
    .call(xAxis);
  
  svg.select('.y-axis')
    .transition()
    .duration(500)
    .call(yAxis);
  
  // Define metrics to display
  const metrics = [
    {key: 'active', name: 'Active Workers', stack: 'workers'},
    {key: 'idle', name: 'Idle Workers', stack: 'workers'},
    {key: 'tasks', name: 'Tasks (÷10)', stack: null}
  ];
  
  // Create stacked data
  const stackedData = d3.stack()
    .keys(['active', 'idle'])
    .order(d3.stackOrderNone)
    .offset(d3.stackOffsetNone)(data);
  
  // Update stacked area
  const area = d3.area()
    .x(d => xScale(new Date(d.data.timestamp)))
    .y0(d => yScale(d[0]))
    .y1(d => yScale(d[1]))
    .curve(d3.curveMonotoneX);
  
  // Update stacked areas
  const stackGroups = svg.selectAll('.stack-group')
    .data(stackedData);
  
  stackGroups.exit().remove();
  
  const enterStackGroups = stackGroups.enter()
    .append('g')
    .attr('class', 'stack-group');
  
  enterStackGroups.append('path')
    .attr('class', 'area')
    .style('fill', (d, i) => colorScale(i))
    .style('opacity', 0.7);
  
  const mergedStackGroups = enterStackGroups.merge(stackGroups);
  
  mergedStackGroups.select('.area')
    .transition()
    .duration(500)
    .attr('d', area);
  
  // Update task line
  const taskLine = d3.line()
    .x(d => xScale(new Date(d.timestamp)))
    .y(d => yScale(d.tasks / 10))
    .curve(d3.curveMonotoneX);
  
  // Update or create task line
  const taskPath = svg.selectAll('.task-line')
    .data([data]);
  
  taskPath.exit().remove();
  
  const enterTaskPath = taskPath.enter()
    .append('path')
    .attr('class', 'task-line')
    .style('fill', 'none')
    .style('stroke', colorScale(2))
    .style('stroke-width', '2px')
    .style('stroke-dasharray', '5,5');
  
  enterTaskPath.merge(taskPath)
    .transition()
    .duration(500)
    .attr('d', taskLine);
  
  // Update legend
  legend.selectAll('*').remove();
  
  metrics.forEach((metric, i) => {
    const legendItem = legend.append('g')
      .attr('transform', `translate(0, ${i * 20})`);
    
    legendItem.append('rect')
      .attr('width', 12)
      .attr('height', 12)
      .attr('fill', colorScale(i));
    
    legendItem.append('text')
      .attr('x', 20)
      .attr('y', 10)
      .attr('text-anchor', 'start')
      .style('font-size', '12px')
      .text(metric.name);
  });
}

/**
 * Update worker status chart
 */
function updateWorkerStatusChart() {
  if (!workerStatusChart) {
    return;
  }
  
  // Get worker status data
  const workerData = window.dataManager ? window.dataManager.getWorkerData() : null;
  let data = [];
  
  if (!workerData || !workerData.status) {
    // Generate dummy data for testing
    data = [
      {name: 'Active', value: 12, status: 'active'},
      {name: 'Idle', value: 3, status: 'idle'},
      {name: 'Terminated', value: 1, status: 'terminated'}
    ];
  } else {
    data = [
      {name: 'Active', value: workerData.status.active || 0, status: 'active'},
      {name: 'Idle', value: workerData.status.idle || 0, status: 'idle'},
      {name: 'Terminated', value: workerData.status.terminated || 0, status: 'terminated'}
    ];
  }
  
  const {svg, pie, arc, color} = workerStatusChart;
  
  // Calculate total
  const total = data.reduce((sum, d) => sum + d.value, 0);
  
  // Update pie chart
  const arcs = svg.selectAll('.arc')
    .data(pie(data));
  
  // Remove old arcs
  arcs.exit().remove();
  
  // Add new arcs
  const enterArcs = arcs.enter()
    .append('g')
    .attr('class', 'arc');
  
  enterArcs.append('path')
    .attr('d', arc)
    .attr('fill', d => color(d.data.status));
  
  enterArcs.append('text')
    .attr('transform', d => `translate(${arc.centroid(d)})`)
    .attr('dy', '0.35em')
    .style('text-anchor', 'middle')
    .style('font-size', '12px')
    .style('fill', 'white');
  
  // Update existing arcs
  arcs.select('path')
    .transition()
    .duration(500)
    .attrTween('d', function(d) {
      const interpolate = d3.interpolate(this._current || d, d);
      this._current = interpolate(0);
      return function(t) {
        return arc(interpolate(t));
      };
    })
    .attr('fill', d => color(d.data.status));
  
  arcs.select('text')
    .transition()
    .duration(500)
    .attr('transform', d => `translate(${arc.centroid(d)})`)
    .text(d => d.data.value > 0 ? d.data.value : '');
  
  // Update merged selection
  const mergedArcs = enterArcs.merge(arcs);
  
  mergedArcs.select('path')
    .on('mouseover', function(event, d) {
      d3.select(this)
        .transition()
        .duration(200)
        .attr('d', d3.arc()
          .innerRadius(workerStatusChart.radius * 0.6)
          .outerRadius(workerStatusChart.radius * 1.05)
        );
      
      // Update center text
      updateCenterText(d.data);
    })
    .on('mouseout', function() {
      d3.select(this)
        .transition()
        .duration(200)
        .attr('d', arc);
      
      // Restore total text
      updateCenterText();
    });
  
  // Add or update center text
  function updateCenterText(data) {
    // Remove existing text
    svg.selectAll('.center-text').remove();
    
    // Add center text group
    const centerText = svg.append('g')
      .attr('class', 'center-text');
    
    if (data) {
      // Show detailed info
      centerText.append('text')
        .attr('class', 'center-title')
        .attr('text-anchor', 'middle')
        .attr('dy', '-0.2em')
        .style('font-size', '14px')
        .style('font-weight', 'bold')
        .text(data.name);
      
      centerText.append('text')
        .attr('class', 'center-value')
        .attr('text-anchor', 'middle')
        .attr('dy', '1em')
        .style('font-size', '16px')
        .text(data.value);
    } else {
      // Show total
      centerText.append('text')
        .attr('class', 'center-title')
        .attr('text-anchor', 'middle')
        .attr('dy', '-0.2em')
        .style('font-size', '14px')
        .text('Total');
      
      centerText.append('text')
        .attr('class', 'center-value')
        .attr('text-anchor', 'middle')
        .attr('dy', '1em')
        .style('font-size', '16px')
        .style('font-weight', 'bold')
        .text(total);
    }
  }
  
  // Initialize with total
  updateCenterText();
}

/**
 * Initialize worker table
 */
function initializeWorkerTable() {
  // The table is already defined in HTML, no initialization needed
}

/**
 * Update worker table with the latest data
 */
function updateWorkerTable() {
  const tableBody = document.getElementById('worker-table-body');
  if (!tableBody) {
    return;
  }
  
  // Get worker data
  const workerData = window.dataManager ? window.dataManager.getWorkerData() : null;
  let workers = [];
  
  if (!workerData || !workerData.workers) {
    // Generate dummy data for testing
    const workerTypes = ['processor', 'analyzer', 'connector', 'scheduler'];
    for (let i = 1; i <= 16; i++) {
      const type = workerTypes[Math.floor(Math.random() * workerTypes.length)];
      const status = i <= 12 ? 'active' : i <= 15 ? 'idle' : 'terminated';
      
      workers.push({
        id: `worker-${i}`,
        type: type,
        status: status,
        cpu: status === 'active' ? Math.floor(Math.random() * 80) + 10 : 0,
        memory: status === 'active' ? Math.floor(Math.random() * 70) + 20 : 0,
        tasksCompleted: Math.floor(Math.random() * 1000),
        uptime: status === 'terminated' ? 0 : Math.floor(Math.random() * 86400)
      });
    }
  } else {
    workers = workerData.workers;
  }
  
  // Clear existing rows
  tableBody.innerHTML = '';
  
  // Add worker rows
  workers.forEach(worker => {
    const row = document.createElement('tr');
    
    // Determine status class
    let statusClass = '';
    switch (worker.status) {
      case 'active':
        statusClass = 'text-success';
        break;
      case 'idle':
        statusClass = 'text-warning';
        break;
      case 'terminated':
        statusClass = 'text-danger';
        break;
    }
    
    // Format uptime
    const uptime = formatUptime(worker.uptime);
    
    // Create row content
    row.innerHTML = `
      <td>${worker.id}</td>
      <td><span class="${statusClass}">${worker.status}</span></td>
      <td>${worker.type}</td>
      <td>${worker.status === 'active' ? worker.cpu + '%' : '-'}</td>
      <td>${worker.status === 'active' ? worker.memory + '%' : '-'}</td>
      <td>${worker.tasksCompleted}</td>
      <td>${uptime}</td>
      <td>
        ${worker.status !== 'terminated' ? `
          <button class="btn btn-sm btn-outline-primary mr-1" title="Restart">
            <i class="fas fa-redo"></i>
          </button>
          <button class="btn btn-sm btn-outline-danger" title="Terminate">
            <i class="fas fa-times"></i>
          </button>
        ` : `
          <button class="btn btn-sm btn-outline-success" title="Start">
            <i class="fas fa-play"></i>
          </button>
        `}
      </td>
    `;
    
    // Add event listeners to buttons
    const buttons = row.querySelectorAll('button');
    buttons.forEach(button => {
      button.addEventListener('click', (event) => {
        event.preventDefault();
        // This would typically call an API to perform the action
        console.log(`Action ${button.title} on worker ${worker.id}`);
      });
    });
    
    // Add row to table
    tableBody.appendChild(row);
  });
}

/**
 * Format uptime in a human-readable format
 * @param {number} seconds - Uptime in seconds
 * @returns {string} - Formatted uptime
 */
function formatUptime(seconds) {
  if (seconds === 0) {
    return '-';
  }
  
  const days = Math.floor(seconds / 86400);
  const hours = Math.floor((seconds % 86400) / 3600);
  const minutes = Math.floor((seconds % 3600) / 60);
  
  if (days > 0) {
    return `${days}d ${hours}h`;
  } else if (hours > 0) {
    return `${hours}h ${minutes}m`;
  } else {
    return `${minutes}m`;
  }
}

/**
 * Update all worker charts
 */
function updateWorkerCharts() {
  updateWorkerActivityChart();
  updateWorkerStatusChart();
}

/**
 * Handle window resize for worker charts
 */
window.addEventListener('resize', () => {
  createWorkerActivityChart();
  createWorkerStatusChart();
  updateWorkerCharts();
});
```


## 5. JavaScript Files - UI Components

### Alerts Panel

```javascript
/**
 * File: /docs/monitoring/dashboard/js/ui/alerts-panel.js
 * IQSMS Monitoring Dashboard - Alerts panel UI
 * Copyright 2025 Autonomy Association International Inc., all rights reserved
 */

/**
 * Initialize the alerts panel
 */
function initializeAlertsPanel() {
  // Add filter change event listeners
  const severityFilter = document.querySelector('#alerts .table-controls select');
  if (severityFilter) {
    severityFilter.addEventListener('change', filterAlerts);
  }
  
  const searchFilter = document.querySelector('#alerts .table-controls input');
  if (searchFilter) {
    searchFilter.addEventListener('input', filterAlerts);
  }
  
  // Initial update
  updateAlertsPanel();
}

/**
 * Update the alerts panel with the latest data
 */
function updateAlertsPanel() {
  const tableBody = document.getElementById('alerts-table-body');
  if (!tableBody) {
    return;
  }
  
  // Get alerts data
  const alertsData = window.dataManager ? window.dataManager.getAlerts() : null;
  let alerts = [];
  
  if (!alertsData) {
    // Generate dummy data for testing
    const severities = ['critical', 'warning', 'info'];
    const sources = ['system', 'network', 'database', 'application', 'security'];
    const statuses = ['active', 'acknowledged'];
    
    for (let i = 1; i <= 10; i++) {
      const severity = i <= 2 ? 'critical' : i <= 5 ? 'warning' : 'info';
      const source = sources[Math.floor(Math.random() * sources.length)];
      const status = i <= 7 ? 'active' : 'acknowledged';
      
      alerts.push({
        id: `alert-${i}`,
        severity: severity,
        status: status,
        time: new Date(Date.now() - Math.floor(Math.random() * 3600000)).toISOString(),
        message: `${severity.charAt(0).toUpperCase() + severity.slice(1)} alert in ${source} component`,
        source: source,
        duration: Math.floor(Math.random() * 3600)
      });
    }
  } else {
    // Combine active and historical alerts
    alerts = [...(alertsData.active || []), ...(alertsData.history || [])];
  }
  
  // Sort alerts by time (newest first) and then by severity
  alerts.sort((a, b) => {
    // First sort by status (active before acknowledged before resolved)
    if (a.status !== b.status) {
      if (a.status === 'active') return -1;
      if (b.status === 'active') return 1;
      if (a.status === 'acknowledged') return -1;
      if (b.status === 'acknowledged') return 1;
    }
    
    // Then sort by severity
    const severityOrder = {critical: 0, warning: 1, info: 2};
    if (a.severity !== b.severity) {
      return severityOrder[a.severity] - severityOrder[b.severity];
    }
    
    // Finally sort by time
    return new Date(b.time) - new Date(a.time);
  });
  
  // Clear existing rows
  tableBody.innerHTML = '';
  
  // Add alert rows
  alerts.forEach(alert => {
    const row = document.createElement('tr');
    
    // Determine severity class
    let severityClass = '';
    switch (alert.severity) {
      case 'critical':
        severityClass = 'danger';
        break;
      case 'warning':
        severityClass = 'warning';
        break;
      case 'info':
        severityClass = 'info';
        break;
    }
    
    // Determine status class
    let statusClass = '';
    let statusText = alert.status;
    switch (alert.status) {
      case 'active':
        statusClass = 'danger';
        break;
      case 'acknowledged':
        statusClass = 'warning';
        break;
      case 'resolved':
        statusClass = 'success';
        break;
    }
    
    // Format time
    const time = new Date(alert.time).toLocaleTimeString();
    
    // Format duration
    const duration = formatDuration(alert.duration);
    
    // Create row content
    row.innerHTML = `
      <td>
        <span class="alert-severity ${alert.severity}"></span>
        ${alert.severity.charAt(0).toUpperCase() + alert.severity.slice(1)}
      </td>
      <td><span class="badge badge-${statusClass}">${statusText}</span></td>
      <td>${time}</td>
      <td>${alert.message}</td>
      <td>${alert.source}</td>
      <td>${duration}</td>
      <td>
        ${alert.status === 'active' ? `
          <button class="btn btn-sm btn-outline-warning mr-1" title="Acknowledge" data-id="${alert.id}">
            <i class="fas fa-check"></i>
          </button>
          <button class="btn btn-sm btn-outline-success" title="Resolve" data-id="${alert.id}">
            <i class="fas fa-check-double"></i>
          </button>
        ` : alert.status === 'acknowledged' ? `
          <button class="btn btn-sm btn-outline-success" title="Resolve" data-id="${alert.id}">
            <i class="fas fa-check-double"></i>
          </button>
        ` : ''}
        <button class="btn btn-sm btn-outline-primary" title="Details" data-id="${alert.id}">
          <i class="fas fa-info-circle"></i>
        </button>
      </td>
    `;
    
    // Add event listeners to buttons
    const buttons = row.querySelectorAll('button');
    buttons.forEach(button => {
      button.addEventListener('click', (event) => {
        event.preventDefault();
        const alertId = button.getAttribute('data-id');
        const action = button.getAttribute('title').toLowerCase();
        
        // This would typically call an API to perform the action
        console.log(`Action ${action} on alert ${alertId}`);
        
        // For demo purposes, update the alert status directly
        if (action === 'acknowledge' || action === 'resolve') {
          const alertToUpdate = alerts.find(a => a.id === alertId);
          if (alertToUpdate) {
            alertToUpdate.status = action === 'acknowledge' ? 'acknowledged' : 'resolved';
            updateAlertsPanel();
          }
        } else if (action === 'details') {
          showAlertDetails(alertId, alerts);
        }
      });
    });
    
    // Add row to table
    tableBody.appendChild(row);
  });
  
  // Apply current filters
  filterAlerts();
}

/**
 * Format duration in a human-readable format
 * @param {number} seconds - Duration in seconds
 * @returns {string} - Formatted duration
 */
function formatDuration(seconds) {
  if (!seconds) {
    return '-';
  }
  
  const hours = Math.floor(seconds / 3600);
  const minutes = Math.floor((seconds % 3600) / 60);
  const secs = seconds % 60;
  
  if (hours > 0) {
    return `${hours}h ${minutes}m`;
  } else if (minutes > 0) {
    return `${minutes}m ${secs}s`;
  } else {
    return `${secs}s`;
  }
}

/**
 * Filter alerts based on selected filters
 */
function filterAlerts() {
  const severityFilter = document.querySelector('#alerts .table-controls select');
  const searchFilter = document.querySelector('#alerts .table-controls input');
  
  const severity = severityFilter ? severityFilter.value : 'All Severities';
  const searchText = searchFilter ? searchFilter.value.toLowerCase() : '';
  
  const rows = document.querySelectorAll('#alerts-table-body tr');
  
  rows.forEach(row => {
    let show = true;
    
    // Apply severity filter
    if (severity !== 'All Severities') {
      const rowSeverity = row.cells[0].textContent.trim();
      if (rowSeverity !== severity) {
        show = false;
      }
    }
    
    // Apply search filter
    if (searchText) {
      const rowText = row.textContent.toLowerCase();
      if (!rowText.includes(searchText)) {
        show = false;
      }
    }
    
    // Show/hide row
    row.style.display = show ? '' : 'none';
  });
}

/**
 * Show alert details
 * @param {string} alertId - The ID of the alert
 * @param {Array} alerts - The array of alerts
 */
function showAlertDetails(alertId, alerts) {
  const alert = alerts.find(a => a.id === alertId);
  if (!alert) {
    return;
  }
  
  // Create modal (simplified version)
  const modal = document.createElement('div');
  modal.className = 'modal fade';
  modal.id = 'alertDetailsModal';
  modal.innerHTML = `
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Alert Details: ${alert.id}</h5>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        <div class="modal-body">
          <div class="alert alert-${getSeverityClass(alert.severity)}">
            <strong>Severity:</strong> ${alert.severity}
          </div>
          <p><strong>Status:</strong> ${alert.status}</p>
          <p><strong>Time:</strong> ${new Date(alert.time).toLocaleString()}</p>
          <p><strong>Source:</strong> ${alert.source}</p>
          <p><strong>Message:</strong> ${alert.message}</p>
          <p><strong>Duration:</strong> ${formatDuration(alert.duration)}</p>
          ${alert.details ? `<p><strong>Details:</strong> ${alert.details}</p>` : ''}
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
          ${alert.status === 'active' ? `
            <button type="button" class="btn btn-warning" data-action="acknowledge">Acknowledge</button>
            <button type="button" class="btn btn-success" data-action="resolve">Resolve</button>
          ` : alert.status === 'acknowledged' ? `
            <button type="button" class="btn btn-success" data-action="resolve">Resolve</button>
          ` : ''}
        </div>
      </div>
    </div>
  `;
  
  // Add modal to body
  document.body.appendChild(modal);
  
  // Initialize modal
  $(modal).modal('show');
  
  // Add event listeners to buttons
  const acknowledgeButton = modal.querySelector('button[data-action="acknowledge"]');
  if (acknowledgeButton) {
    acknowledgeButton.addEventListener('click', () => {
      alert.status = 'acknowledged';
      updateAlertsPanel();
      $(modal).modal('hide');
    });
  }
  
  const resolveButton = modal.querySelector('button[data-action="resolve"]');
  if (resolveButton) {
    resolveButton.addEventListener('click', () => {
      alert.status = 'resolved';
      updateAlertsPanel();
      $(modal).modal('hide');
    });
  }
  
  // Remove modal from DOM when hidden
  $(modal).on('hidden.bs.modal', () => {
    document.body.removeChild(modal);
  });
}

/**
 * Get the Bootstrap severity class for an alert severity
 * @param {string} severity - The alert severity
 * @returns {string} - The Bootstrap class
 */
function getSeverityClass(severity) {
  switch (severity) {
    case 'critical':
      return 'danger';
    case 'warning':
      return 'warning';
    case 'info':
      return 'info';
    default:
      return 'secondary';
  }
}
```


### Time Controls

```javascript
/**
 * File: /docs/monitoring/dashboard/js/ui/time-controls.js
 * IQSMS Monitoring Dashboard - Time range controls
 * Copyright 2025 Autonomy Association International Inc., all rights reserved
 */

/**
 * Initialize time controls
 */
function initializeTimeControls() {
  // Time range selector
  const timeRangeSelector = document.getElementById('time-range');
  if (timeRangeSelector) {
    timeRangeSelector.addEventListener('change', (event) => {
      const range = event.target.value;
      if (range === 'custom') {
        // Show custom time range picker
        showCustomTimeRangePicker();
      } else {
        // Update charts with selected time range
        updateChartsTimeRange(range);
      }
    });
  }
  
  // Refresh interval selector
  const refreshSelector = document.getElementById('refresh-interval');
  if (refreshSelector) {
    refreshSelector.addEventListener('change', (event) => {
      const interval = parseInt(event.target.value, 10);
      updateRefreshInterval(interval);
    });
  }
}

/**
 * Show custom time range picker modal
 */
function showCustomTimeRangePicker() {
  // Create modal (simplified version)
  const modal = document.createElement('div');
  modal.className = 'modal fade';
  modal.id = 'timeRangeModal';
  
  // Get current time range
  const timeRange = window.dataManager ? window.dataManager.metrics.timeRange : {
    start: new Date(Date.now() - 24 * 60 * 60 * 1000),
    end: new Date()
  };
  
  // Format dates for inputs
  const startDate = timeRange.start.toISOString().slice(0, 16);
  const endDate = timeRange.end.toISOString().slice(0, 16);
  
  modal.innerHTML = `
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Custom Time Range</h5>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        <div class="modal-body">
          <form>
            <div class="form-group">
              <label for="start-date">Start Date/Time</label>
              <input type="datetime-local" class="form-control" id="start-date" value="${startDate}">
            </div>
            <div class="form-group">
              <label for="end-date">End Date/Time</label>
              <input type="datetime-local" class="form-control" id="end-date" value="${endDate}">
            </div>
          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
          <button type="button" class="btn btn-primary" id="apply-time-range">Apply</button>
        </div>
      </div>
    </div>
  `;
  
  // Add modal to body
  document.body.appendChild(modal);
  
  // Initialize modal
  $(modal).modal('show');
  
  // Add event listener to apply button
  const applyButton = modal.querySelector('#apply-time-range');
  applyButton.addEventListener('click', () => {
    const startInput = modal.querySelector('#start-date');
    const endInput = modal.querySelector('#end-date');
    
    const start = new Date(startInput.value);
    const end = new Date(endInput.value);
    
    if (start && end && start < end) {
      // Update time range
      updateCustomTimeRange(start, end);
      
      // Hide modal
      $(modal).modal('hide');
    } else {
      alert('Please enter a valid time range (start must be before end)');
    }
  });
  
  // Remove modal from DOM when hidden
  $(modal).on('hidden.bs.modal', () => {
    document.body.removeChild(modal);
    
    // Reset time range selector to current value
    const timeRangeSelector = document.getElementById('time-range');
    if (timeRangeSelector) {
      const currentRange = getCurrentTimeRangeName(timeRange.start, timeRange.end);
      if (currentRange) {
        timeRangeSelector.value = currentRange;
      }
    }
  });
}

/**
 * Update charts with a custom time range
 * @param {Date} start - Start date
 * @param {Date} end - End date
 */
function updateCustomTimeRange(start, end) {
  // Update data manager time range
  if (window.dataManager) {
    window.dataManager.setTimeRange(start, end).then(updateDashboardUI);
  }
  
  // Update time range display
  const timeRangeSelector = document.getElementById('time-range');
  if (timeRangeSelector) {
    timeRangeSelector.value = 'custom';
  }
}

/**
 * Update charts with the selected time range
 * @param {string} range - The time range to display
 */
function updateChartsTimeRange(range) {
  // Calculate start and end times based on the range
  const end = new Date();
  let start;
  
  switch (range) {
    case '15m':
      start = new Date(end.getTime() - 15 * 60 * 1000);
      break;
    case '1h':
      start = new Date(end.getTime() - 60 * 60 * 1000);
      break;
    case '3h':
      start = new Date(end.getTime() - 3 * 60 * 60 * 1000);
      break;
    case '6h':
      start = new Date(end.getTime() - 6 * 60 * 60 * 1000);
      break;
    case '12h':
      start = new Date(end.getTime() - 12 * 60 * 60 * 1000);
      break;
    case '24h':
      start = new Date(end.getTime() - 24 * 60 * 60 * 1000);
      break;
    case '7d':
      start = new Date(end.getTime() - 7 * 24 * 60 * 60 * 1000);
      break;
    case '30d':
      start = new Date(end.getTime() - 30 * 24 * 60 * 60 * 1000);
      break;
    default:
      start = new Date(end.getTime() - 24 * 60 * 60 * 1000);
  }
  
  // Update data manager time range
  if (window.dataManager) {
    window.dataManager.setTimeRange(start, end).then(updateDashboardUI);
  }
}

/**
 * Get the name of the current time range
 * @param {Date} start - Start date
 * @param {Date} end - End date
 * @returns {string|null} - The name of the time range, or null if custom
 */
function getCurrentTimeRangeName(start, end) {
  const diff = end.getTime() - start.getTime();
  const diffMinutes = diff / (60 * 1000);
  const diffHours = diffMinutes / 60;
  const diffDays = diffHours / 24;
  
  // Check if end time is close to now
  const isEndNow = Math.abs(end.getTime() - Date.now()) < 60000; // Within 1 minute
  
  if (!isEndNow) {
    return null; // Custom range
  }
  
  // Check for predefined ranges
  if (Math.abs(diffMinutes - 15) < 1) {
    return '15m';
  } else if (Math.abs(diffHours - 1) < 0.1) {
    return '1h';
  } else if (Math.abs(diffHours - 3) < 0.1) {
    return '3h';
  } else if (Math.abs(diffHours - 6) < 0.1) {
    return '6h';
  } else if (Math.abs(diffHours - 12) < 0.1) {
    return '12h';
  } else if (Math.abs(diffHours - 24) < 0.1) {
    return '24h';
  } else if (Math.abs(diffDays - 7) < 0.1) {
    return '7d';
  } else if (Math.abs(diffDays - 30) < 0.1) {
    return '30d';
  }
  
  return null; // Custom range
}
```


### Table Manager

```javascript
/**
 * File: /docs/monitoring/dashboard/js/ui/table-manager.js
 * IQSMS Monitoring Dashboard - Table management functions
 * Copyright 2025 Autonomy Association International Inc., all rights reserved
 */

/**
 * Initialize table management functionality
 */
function initializeTableManager() {
  // Add worker table filter
  const workerFilter = document.querySelector('#workers .table-controls input');
  if (workerFilter) {
    workerFilter.addEventListener('input', filterWorkerTable);
  }
  
  // Add sorting functionality to tables
  addTableSorting();
}

/**
 * Filter the worker table based on the search input
 */
function filterWorkerTable() {
  const filterInput = document.querySelector('#workers .table-controls input');
  if (!filterInput) {
    return;
  }
  
  const filterText = filterInput.value.toLowerCase();
  const rows = document.querySelectorAll('#worker-table-body tr');
  
  rows.forEach(row => {
    const text = row.textContent.toLowerCase();
    row.style.display = text.includes(filterText) ? '' : 'none';
  });
}

/**
 * Add sorting functionality to tables
 */
function addTableSorting() {
  const tables = document.querySelectorAll('.table');
  
  tables.forEach(table => {
    const headers = table.querySelectorAll('thead th');
    
    headers.forEach((header, index) => {
      // Skip columns with actions
      if (header.textContent.trim() === 'Actions') {
        return;
      }
      
      // Add sort indicator and cursor
      header.style.cursor = 'pointer';
      header.innerHTML = `${header.innerHTML} <span class="sort-icon"></span>`;
      
      // Add click event
      header.addEventListener('click', () => {
        // Get current sort direction
        const currentDirection = header.getAttribute('data-sort') || 'none';
        
        // Reset all headers
        headers.forEach(h => {
          h.setAttribute('data-sort', 'none');
          h.querySelector('.sort-icon').textContent = '';
        });
        
        // Set new sort direction
        let newDirection;
        if (currentDirection === 'none' || currentDirection === 'desc') {
          newDirection = 'asc';
          header.querySelector('.sort-icon').textContent = '▲';
        } else {
          newDirection = 'desc';
          header.querySelector('.sort-icon').textContent = '▼';
        }
        
        header.setAttribute('data-sort', newDirection);
        
        // Sort the table
        sortTable(table, index, newDirection);
      });
    });
  });
}

/**
 * Sort a table by a specific column
 * @param {HTMLElement} table - The table element
 * @param {number} columnIndex - The index of the column to sort by
 * @param {string} direction - The sort direction ('asc' or 'desc')
 */
function sortTable(table, columnIndex, direction) {
  const tbody = table.querySelector('tbody');
  const rows = Array.from(tbody.querySelectorAll('tr'));
  
  // Sort rows
  const sortedRows = rows.sort((a, b) => {
    const aValue = getCellValue(a, columnIndex);
    const bValue = getCellValue(b, columnIndex);
    
    // Compare values
    if (aValue === bValue) {
      return 0;
    }
    
    // Handle special cases (numbers, dates)
    if (!isNaN(aValue) && !isNaN(bValue)) {
      return direction === 'asc' ? aValue - bValue : bValue - aValue;
    }
    
    // Default string comparison
    return direction === 'asc' 
      ? aValue.localeCompare(bValue)
      : bValue.localeCompare(aValue);
  });
  
  // Reorder rows
  sortedRows.forEach(row => {
    tbody.appendChild(row);
  });
}

/**
 * Get the value of a cell for sorting
 * @param {HTMLElement} row - The table row
 * @param {number} columnIndex - The index of the column
 * @returns {string|number} - The cell value
 */
function getCellValue(row, columnIndex) {
  const cell = row.cells[columnIndex];
  
  // Check for numeric content
  const text = cell.textContent.trim();
  const numericMatch = text.match(/^(\d+(\.\d+)?)/);
  if (numericMatch) {
    return parseFloat(numericMatch[1]);
  }
  
  // Check for percentage
  const percentMatch = text.match(/^(\d+(\.\d+)?)%/);
  if (percentMatch) {
    return parseFloat(percentMatch[1]);
  }
  
  // Return text
  return text;
}
```


## 6. Server-Side Files

### Dashboard Server

```javascript
/**
 * File: /server/monitoring/dashboard/dashboard-server.js
 * IQSMS Monitoring Dashboard - Server implementation
 * Copyright 2025 Autonomy Association International Inc., all rights reserved
 */

const express = require('express');
const http = require('http');
const socketIo = require('socket.io');
const path = require('path');
const os = require('os');
const { MonitoringService } = require('../core/MonitoringService');
const { PerformanceMonitor } = require('../core/PerformanceMonitor');
const { SystemMetricsMonitor } = require('../core/SystemMetricsMonitor');
const metricsApi = require('./api/metrics-api');
const networkApi = require('./api/network-api');
const workersApi = require('./api/workers-api');
const alertsApi = require('./api/alerts-api');

/**
 * Create and configure the dashboard server
 * @param {Object} options - Server options
 * @returns {Object} - The configured server
 */
function createDashboardServer(options = {}) {
  // Default options
  const config = {
    port: options.port || process.env.DASHBOARD_PORT || 3000,
    metricsInterval: options.metricsInterval || 5000,
    staticRoot: options.staticRoot || path.join(__dirname, '../../../docs'),
    ...options
  };
  
  // Create Express app
  const app = express();
  const server = http.createServer(app);
  const io = socketIo(server, {
    cors: {
      origin: "*",
      methods: ["GET", "POST"]
    }
  });
  
  // Initialize monitoring components
  const systemMetricsMonitor = options.systemMetricsMonitor || new SystemMetricsMonitor({
    interval: config.metricsInterval
  });
  
  const performanceMonitor = options.performanceMonitor || new PerformanceMonitor({
    systemMetricsMonitor,
    metricsBuffer: 1000
  });
  
  const monitoringService = options.monitoringService || new MonitoringService({
    performanceMonitor
  });
  
  // Serve static files
  app.use(express.static(config.staticRoot));
  
  // Configure API routes
  app.use('/api/metrics', metricsApi(performanceMonitor));
  app.use('/api/network', networkApi(monitoringService));
  app.use('/api/workers', workersApi(monitoringService));
  app.use('/api/alerts', alertsApi(monitoringService));
  
  // Serve index page for dashboard routes
  app.get('/monitoring/dashboard*', (req, res) => {
    res.sendFile(path.join(config.staticRoot, 'monitoring/dashboard/index.html'));
  });
  
  // Socket.IO connections
  io.on('connection', (socket) => {
    console.log('Client connected to dashboard socket');
    
    // Send initial data
    socket.emit('metrics', performanceMonitor.getLatestMetrics());
    socket.emit('network', monitoringService.getNetworkData());
    socket.emit('workers', monitoringService.getWorkerStatus());
    socket.emit('alerts', monitoringService.getAlerts());
    
    // Handle client disconnection
    socket.on('disconnect', () => {
      console.log('Client disconnected from dashboard socket');
    });
  });
  
  // Set up periodic updates
  const updateIntervals = {
    metrics: setInterval(() => {
      const metrics = performanceMonitor.getLatestMetrics();
      io.emit('metrics', metrics);
    }, config.metricsInterval),
    
    network: setInterval(() => {
      const networkData = monitoringService.getNetworkData();
      io.emit('network', networkData);
    }, config.metricsInterval * 2),
    
    workers: setInterval(() => {
      const workers = monitoringService.getWorkerStatus();
      io.emit('workers', workers);
    }, config.metricsInterval * 2),
    
    alerts: setInterval(() => {
      const alerts = monitoringService.getAlerts();
      io.emit('alerts', alerts);
    }, config.metricsInterval)
  };
  
  // Start server
  const startServer = () => {
    return new Promise((resolve, reject) => {
      server.listen(config.port, () => {
        console.log(`IQSMS Monitoring Dashboard server running on port ${config.port}`);
        resolve(server);
      }).on('error', (err) => {
        reject(err);
      });
    });
  };
  
  // Stop server
  const stopServer = () => {
    return new Promise((resolve) => {
      // Clear intervals
      Object.values(updateIntervals).forEach(interval => clearInterval(interval));
      
      // Close server
      server.close(() => {
        console.log('IQSMS Monitoring Dashboard server stopped');
        resolve();
      });
    });
  };
  
  return {
    app,
    server,
    io,
    startServer,
    stopServer,
    performanceMonitor,
    monitoringService
  };
}

module.exports = createDashboardServer;
```


### Metrics API

```javascript
/**
 * File: /server/monitoring/dashboard/api/metrics-api.js
 * IQSMS Monitoring Dashboard - Metrics API endpoints
 * Copyright 2025 Autonomy Association International Inc., all rights reserved
 */

const express = require('express');

/**
 * Create metrics API router
 * @param {Object} performanceMonitor - The performance monitor instance
 * @returns {Object} - Express router
 */
function createMetricsApi(performanceMonitor) {
  const router = express.Router();
  
  // Get latest metrics
  router.get('/', (req, res) => {
    try {
      const metrics = performanceMonitor.getLatestMetrics();
      res.json(metrics);
    } catch (error) {
      console.error('Error getting latest metrics:', error);
      res.status(500).json({ error: 'Error getting metrics' });
    }
  });
  
  // Get metrics history
  router.get('/history', (req, res) => {
    try {
      let { start, end, interval } = req.query;
      
      // Parse start and end dates
      const startDate = start ? new Date(start) : new Date(Date.now() - 24 * 60 * 60 * 1000);
      const endDate = end ? new Date(end) : new Date();
      
      // Parse interval (if provided)
      const aggregationInterval = interval ? parseInt(interval, 10) : null;
      
      // Get metrics history
      const metrics = performanceMonitor.getMetricsHistory(startDate, endDate, aggregationInterval);
      res.json(metrics);
    } catch (error) {
      console.error('Error getting metrics history:', error);
      res.status(500).json({ error: 'Error getting metrics history' });
    }
  });
  
  // Get specific metric type
  router.get('/:type', (req, res) => {
    try {
      const { type } = req.params;
      const metrics = performanceMonitor.getLatestMetrics();
      
      if (metrics[type]) {
        res.json(metrics[type]);
      } else {
        res.status(404).json({ error: `Metric type ${type} not found` });
      }
    } catch (error) {
      console.error(`Error getting ${req.params.type} metrics:`, error);
      res.status(500).json({ error: 'Error getting metrics' });
    }
  });
  
  return router;
}

module.exports = createMetricsApi;
```


### Network API

```javascript
/**
 * File: /server/monitoring/dashboard/api/network-api.js
 * IQSMS Monitoring Dashboard - Network API endpoints
 * Copyright 2025 Autonomy Association International Inc., all rights reserved
 */

const express = require('express');

/**
 * Create network API router
 * @param {Object} monitoringService - The monitoring service instance
 * @returns {Object} - Express router
 */
function createNetworkApi(monitoringService) {
  const router = express.Router();
  
  // Get network data
  router.get('/', (req, res) => {
    try {
      const networkData = monitoringService.getNetworkData();
      res.json(networkData);
    } catch (error) {
      console.error('Error getting network data:', error);
      res.status(500).json({ error: 'Error getting network data' });
    }
  });
  
  // Get network node details
  router.get('/nodes/:id', (req, res) => {
    try {
      const { id } = req.params;
      const nodeData = monitoringService.getNetworkNodeData(id);
      
      if (nodeData) {
        res.json(nodeData);
      } else {
        res.status(404).json({ error: `Node ${id} not found` });
      }
    } catch (error) {
      console.error(`Error getting node ${req.params.id} data:`, error);
      res.status(500).json({ error: 'Error getting node data' });
    }
  });
  
  // Get network traffic data
  router.get('/traffic', (req, res) => {
    try {
      let { start, end, interval } = req.query;
      
      // Parse start and end dates
      const startDate = start ? new Date(start) : new Date(Date.now() - 24 * 60 * 60 * 1000);
      const endDate = end ? new Date(end) : new Date();
      
      // Parse interval (if provided)
      const aggregationInterval = interval ? parseInt(interval, 10) : null;
      
      // Get network traffic history
      const trafficData = monitoringService.getNetworkTrafficHistory(startDate, endDate, aggregationInterval);
      res.json(trafficData);
    } catch (error) {
      console.error('Error getting network traffic data:', error);
      res.status(500).json({ error: 'Error getting network traffic data' });
    }
  });
  
  return router;
}

module.exports = createNetworkApi;
```


### Workers API

```javascript
/**
 * File: /server/monitoring/dashboard/api/workers-api.js
 * IQSMS Monitoring Dashboard - Workers API endpoints
 * Copyright 2025 Autonomy Association International Inc., all rights reserved
 */

const express = require('express');

/**
 * Create workers API router
 * @param {Object} monitoringService - The monitoring service instance
 * @returns {Object} - Express router
 */
function createWorkersApi(monitoringService) {
  const router = express.Router();
  
  // Get worker status
  router.get('/', (req, res) => {
    try {
      const workerStatus = monitoringService.getWorkerStatus();
      res.json(workerStatus);
    } catch (error) {
      console.error('Error getting worker status:', error);
      res.status(500).json({ error: 'Error getting worker status' });
    }
  });
  
  // Get worker details
  router.get('/:id', (req, res) => {
    try {
      const { id } = req.params;
      const workerData = monitoringService.getWorkerData(id);
      
      if (workerData) {
        res.json(workerData);
      } else {
        res.status(404).json({ error: `Worker ${id} not found` });
      }
    } catch (error) {
      console.error(`Error getting worker ${req.params.id} data:`, error);
      res.status(500).json({ error: 'Error getting worker data' });
    }
  });
  
  // Get worker activity history
  router.get('/activity/history', (req, res) => {
    try {
      let { start, end, interval } = req.query;
      
      // Parse start and end dates
      const startDate = start ? new Date(start) : new Date(Date.now() - 24 * 60 * 60 * 1000);
      const endDate = end ? new Date(end) : new Date();
      
      // Parse interval (if provided)
      const aggregationInterval = interval ? parseInt(interval, 10) : null;
      
      // Get worker activity history
      const activityData = monitoringService.getWorkerActivityHistory(startDate, endDate, aggregationInterval);
      res.json(activityData);
    } catch (error) {
      console.error('Error getting worker activity history:', error);
      res.status(500).json({ error: 'Error getting worker activity history' });
    }
  });
  
  // Worker control endpoints
  router.post('/:id/restart', (req, res) => {
    try {
      const { id } = req.params;
      const result = monitoringService.restartWorker(id);
      
      if (result.success) {
        res.json({ message: `Worker ${id} restarted successfully` });
      } else {
        res.status(400).json({ error: result.error || `Failed to restart worker ${id}` });
      }
    } catch (error) {
      console.error(`Error restarting worker ${req.params.id}:`, error);
      res.status(500).json({ error: 'Error restarting worker' });
    }
  });
  
  router.post('/:id/terminate', (req, res) => {
    try {
      const { id } = req.params;
      const result = monitoringService.terminateWorker(id);
      
      if (result.success) {
        res.json({ message: `Worker ${id} terminated successfully` });
      } else {
        res.status(400).json({ error: result.error || `Failed to terminate worker ${id}` });
      }
    } catch (error) {
      console.error(`Error terminating worker ${req.params.id}:`, error);
      res.status(500).json({ error: 'Error terminating worker' });
    }
  });
  
  router.post('/:id/start', (req, res) => {
    try {
      const { id } = req.params;
      const result = monitoringService.startWorker(id);
      
      if (result.success) {
        res.json({ message: `Worker ${id} started successfully` });
      } else {
        res.status(400).json({ error: result.error || `Failed to start worker ${id}` });
      }
    } catch (error) {
      console.error(`Error starting worker ${req.params.id}:`, error);
      res.status(500).json({ error: 'Error starting worker' });
    }
  });
  
  return router;
}

module.exports = createWorkersApi;
```


### Alerts API

```javascript
/**
 * File: /server/monitoring/dashboard/api/alerts-api.js
 * IQSMS Monitoring Dashboard - Alerts API endpoints
 * Copyright 2025 Autonomy Association International Inc., all rights reserved
 */

const express = require('express');

/**
 * Create alerts API router
 * @param {Object} monitoringService - The monitoring service instance
 * @returns {Object} - Express router
 */
function createAlertsApi(monitoringService) {
  const router = express.Router();
  
  // Get all alerts
  router.get('/', (req, res) => {
    try {
      const alerts = monitoringService.getAlerts();
      res.json(alerts);
    } catch (error) {
      console.error('Error getting alerts:', error);
      res.status(500).json({ error: 'Error getting alerts' });
    }
  });
  
  // Get active alerts
  router.get('/active', (req, res) => {
    try {
      const alerts = monitoringService.getAlerts();
      res.json({ active: alerts.active });
    } catch (error) {
      console.error('Error getting active alerts:', error);
      res.status(500).json({ error: 'Error getting active alerts' });
    }
  });
  
  // Get alert history
  router.get('/history', (req, res) => {
    try {
      const alerts = monitoringService.getAlerts();
      res.json({ history: alerts.history });
    } catch (error) {
      console.error('Error getting alert history:', error);
      res.status(500).json({ error: 'Error getting alert history' });
    }
  });
  
  // Get specific alert
  router.get('/:id', (req, res) => {
    try {
      const { id } = req.params;
      const alert = monitoringService.getAlert(id);
      
      if (alert) {
        res.json(alert);
      } else {
        res.status(404).json({ error: `Alert ${id} not found` });
      }
    } catch (error) {
      console.error(`Error getting alert ${req.params.id}:`, error);
      res.status(500).json({ error: 'Error getting alert' });
    }
  });
  
  // Acknowledge an alert
  router.post('/:id/acknowledge', (req, res) => {
    try {
      const { id } = req.params;
      const result = monitoringService.acknowledgeAlert(id);
      
      if (result.success) {
        res.json({ message: `Alert ${id} acknowledged successfully` });
      } else {
        res.status(400).json({ error: result.error || `Failed to acknowledge alert ${id}` });
      }
    } catch (error) {
      console.error(`Error acknowledging alert ${req.params.id}:`, error);
      res.status(500).json({ error: 'Error acknowledging alert' });
    }
  });
  
  // Resolve an alert
  router.post('/:id/resolve', (req, res) => {
    try {
      const { id } = req.params;
      const result = monitoringService.resolveAlert(id);
      
      if (result.success) {
        res.json({ message: `Alert ${id} resolved successfully` });
      } else {
        res.status(400).json({ error: result.error || `Failed to resolve alert ${id}` });
      }
    } catch (error) {
      console.error(`Error resolving alert ${req.params.id}:`, error);
      res.status(500).json({ error: 'Error resolving alert' });
    }
  });
  
  return router;
}

module.exports = createAlertsApi;
```


## 7. Documentation Files

```html
<!-- 
  File: /docs/monitoring/docs/dashboardhowto.html
  IQSMS Monitoring Dashboard - How-To Guide
  Copyright 2025 Autonomy Association International Inc., all rights reserved 
  Safeguard patent license from National Aeronautics and Space Administration (NASA)
  Copyright 2025 NASA, all rights reserved
-->
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Dashboard How-To - IQSMS Documentation</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="../../css/styles.css">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.1/css/all.css">
</head>
<body>
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
      <a class="navbar-brand" href="../../index.html">
        IQSMS Documentation
      </a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item">
            <a class="nav-link" href="../../index.html">Home</a>
          </li>
          <li class="nav-item dropdown active">
            <a class="nav-link dropdown-toggle" href="#" id="monitoringDropdown" role="button" data-toggle="dropdown">
              Monitoring
            </a>
            <div class="dropdown-menu">
              <a class="dropdown-item" href="../index.html">Monitoring Overview</a>
              <a class="dropdown-item" href="../metrics_collection.html">Metrics Collection</a>
              <a class="dropdown-item" href="../opentelemetry_integration.html">OpenTelemetry Integration</a>
              <a class="dropdown-item" href="../performance_testing.html">Performance Testing</a>
              <a class="dropdown-item" href="../worker_management.html">Worker Management</a>
              <a class="dropdown-item" href="../dashboard_guide.html">Dashboard Guide</a>
              <a class="dropdown-item active" href="dashboardhowto.html">Dashboard How-To</a>
            </div>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="../dashboard/index.html" target="_blank">
              Open Dashboard <i class="fas fa-external-link-alt ml-1"></i>
            </a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <div class="jumbotron bg-primary text-white">
    <div class="container">
      <div class="row align-items-center">
        <div class="col-md-8">
          <h1 class="display-4">Dashboard How-To Guide</h1>
          <p class="lead">Comprehensive guide to using and customizing the IQSMS Monitoring Dashboard</p>
        </div>
        <div class="col-md-4 text-center">
          <i class="fas fa-tachometer-alt fa-6x"></i>
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
              <a class="nav-link" href="#introduction">Introduction</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#getting-started">Getting Started</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#dashboard-sections">Dashboard Sections</a>
              <ul class="nav flex-column ml-3">
                <li class="nav-item">
                  <a class="nav-link" href="#overview-section">Overview</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="#system-section">System Resources</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="#network-section">Network Map</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="#workers-section">Worker Threads</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="#alerts-section">Alerts</a>
                </li>
              </ul>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#customizing">Customizing the Dashboard</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#api-reference">API Reference</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#troubleshooting">Troubleshooting</a>
            </li>
          </ul>
        </nav>
      </div>
      <div class="col-md-9">
        <section id="introduction">
          <h2>Introduction</h2>
          <p class="lead">
            The IQSMS Monitoring Dashboard provides a comprehensive real-time view of your system's performance, health, and status.
          </p>
          
          <p>
            Built with D3.js and Three.js, the dashboard offers interactive visualizations of system metrics, network topology, worker threads, and alerts. It's designed to be responsive, accessible on both desktop and mobile devices, and customizable to meet your specific monitoring needs.
          </p>
          
          <div class="alert alert-info">
            <i class="fas fa-info-circle mr-2"></i>
            <strong>Key Features:</strong>
            <ul class="mb-0">
              <li>Real-time monitoring of system resources and performance</li>
              <li>Interactive 3D visualization of your network topology</li>
              <li>Comprehensive worker thread management</li>
              <li>Alert monitoring and management</li>
              <li>Customizable time ranges and auto-refresh intervals</li>
              <li>Responsive design for desktop and mobile access</li>
            </ul>
          </div>
          
          <div class="text-center my-4">
            <img src="../../images/dashboard-screenshot.png" alt="IQSMS Dashboard Screenshot" class="img-fluid rounded border" style="max-width: 90%;">
          </div>
        </section>

        <section id="getting-started" class="mt-5">
          <h2>Getting Started</h2>
          
          <h4>Accessing the Dashboard</h4>
          <p>
            The IQSMS Monitoring Dashboard can be accessed at:
          </p>
          <pre><code class="language-text">http://your-server/monitoring/dashboard</code></pre>
          
          <p>
            You can also access the dashboard directly from the IQSMS main interface by clicking on the "Monitoring" link in the navigation menu.
          </p>
          
          <h4>Browser Requirements</h4>
          <p>
            The dashboard is optimized for modern browsers that support HTML5, CSS3, WebGL, and modern JavaScript features. For the best experience, we recommend using:
          </p>
          <ul>
            <li>Google Chrome (latest version)</li>
            <li>Mozilla Firefox (latest version)</li>
            <li>Microsoft Edge (Chromium-based, latest version)</li>
            <li>Safari (latest version)</li>
          </ul>
          
          <div class="alert alert-warning">
            <i class="fas fa-exclamation-triangle mr-2"></i>
            <strong>Note:</strong> The 3D Network Map feature requires WebGL support. Most modern browsers support WebGL, but it may not be available on older browsers or devices with limited graphics capabilities.
          </div>
          
          <h4>Mobile Access</h4>
          <p>
            The dashboard is fully responsive and can be accessed on mobile devices. On smaller screens, some visualizations may be simplified or arranged differently to ensure optimal viewing.
          </p>
        </section>

        <section id="dashboard-sections" class="mt-5">
          <h2>Dashboard Sections</h2>
          
          <p>
            The IQSMS Monitoring Dashboard is organized into several main sections, each focusing on a specific aspect of system monitoring.
          </p>
          
          <div id="overview-section" class="subsection">
            <h3>Overview Section</h3>
            
            <p>
              The Overview section provides a high-level summary of your system's current status and performance.
            </p>
            
            <div class="text-center my-4">
              <img src="../../images/dashboard-overview.png" alt="Dashboard Overview Section" class="img-fluid rounded border" style="max-width: 90%;">
            </div>
            
            <h4>Key Components</h4>
            <ul>
              <li>
                <strong>System Metrics Gauges</strong>: Real-time gauges showing CPU load, memory usage, network traffic, and active alerts.
              </li>
              <li>
                <strong>Performance Chart</strong>: A time-series chart showing key performance metrics over time.
              </li>
              <li>
                <strong>Protocol Distribution</strong>: A pie chart showing the distribution of active protocols.
              </li>
            </ul>
            
            <h4>Interaction Tips</h4>
            <ul>
              <li>Hover over any gauge to see detailed information.</li>
              <li>Use the buttons above the Performance Chart to switch between different metrics (CPU, Memory, I/O, Network).</li>
              <li>Click on a segment in the Protocol Distribution chart to see detailed information about that protocol.</li>
            </ul>
          </div>
          
          <div id="system-section" class="subsection mt-4">
            <h3>System Resources Section</h3>
            
            <p>
              The System Resources section provides detailed information about your system's resource utilization.
            </p>
            
            <div class="text-center my-4">
              <img src="../../images/dashboard-system.png" alt="Dashboard System Resources Section" class="img-fluid rounded border" style="max-width: 90%;">
            </div>
            
            <h4>Key Components</h4>
            <ul>
              <li>
                <strong>CPU Usage History</strong>: A time-series chart showing CPU usage over time.
              </li>
              <li>
                <strong>Memory Usage History</strong>: A time-series chart showing memory usage over time.
              </li>
              <li>
                <strong>Disk I/O</strong>: A chart showing disk read and write rates.
              </li>
              <li>
                <strong>Network I/O</strong>: A chart showing network traffic in and out.
              </li>
            </ul>
            
            <h4>Interaction Tips</h4>
            <ul>
              <li>Hover over any point on the charts to see the exact value at that time.</li>
              <li>Click and drag on any chart to zoom in on a specific time range.</li>
              <li>Double-click on a chart to reset the zoom level.</li>
              <li>Use the time range selector in the sidebar to change the time period shown in all charts.</li>
            </ul>
          </div>
          
          <div id="network-section" class="subsection mt-4">
            <h3>Network Map Section</h3>
            
            <p>
              The Network Map section provides an interactive 3D visualization of your network topology.
            </p>
            
            <div class="text-center my-4">
              <img src="../../images/dashboard-network.png" alt="Dashboard Network Map Section" class="img-fluid rounded border" style="max-width: 90%;">
            </div>
            
            <h4>Key Components</h4>
            <ul>
              <li>
                <strong>3D Network Map</strong>: An interactive 3D visualization of your network, showing nodes and connections.
              </li>
              <li>
                <strong>View Controls</strong>: Buttons to switch between 3D view, 2D view, and geographical map view.
              </li>
            </ul>
            
            <h4>Interaction Tips</h4>
            <ul>
              <li>Click and drag to rotate the 3D view.</li>
              <li>Scroll to zoom in and out.</li>
              <li>Hover over a node to see its name and basic information.</li>
              <li>Click on a node to see detailed information and highlight its connections.</li>
              <li>Use the view controls to switch between different visualization modes.</li>
            </ul>
            
            <div class="alert alert-info">
              <i class="fas fa-info-circle mr-2"></i>
              <strong>Tip:</strong> In the 3D view, nodes are color-coded by type:
              <ul class="mb-0">
                <li>Blue: Servers</li>
                <li>Green: Clients</li>
                <li>Red: Gateways</li>
                <li>Yellow: Routers</li>
                <li>Cyan: Sensors</li>
                <li>Gray: Other/Unknown</li>
              </ul>
            </div>
          </div>
          
          <div id="workers-section" class="subsection mt-4">
            <h3>Worker Threads Section</h3>
            
            <p>
              The Worker Threads section provides information about worker threads and their activity.
            </p>
            
            <div class="text-center my-4">
              <img src="../../images/dashboard-workers.png" alt="Dashboard Worker Threads Section" class="img-fluid rounded border" style="max-width: 90%;">
            </div>
            
            <h4>Key Components</h4>
            <ul>
              <li>
                <strong>Worker Activity Chart</strong>: A time-series chart showing worker activity over time.
              </li>
              <li>
                <strong>Worker Status Chart</strong>: A pie chart showing the distribution of worker statuses.
              </li>
              <li>
                <strong>Worker Threads Table</strong>: A detailed table of all worker threads and their current status.
              </li>
            </ul>
            
            <h4>Interaction Tips</h4>
            <ul>
              <li>Hover over any point on the Worker Activity chart to see detailed information.</li>
              <li>Click on a segment in the Worker Status chart to filter the table by that status.</li>
              <li>Use the filter box above the table to search for specific workers.</li>
              <li>Click on a worker in the table to see detailed information and available actions.</li>
            </ul>
          </div>
          
          <div id="alerts-section" class="subsection mt-4">
            <h3>Alerts Section</h3>
            
            <p>
              The Alerts section provides information about active and recent alerts.
            </p>
            
            <div class="text-center my-4">
              <img src="../../images/dashboard-alerts.png" alt="Dashboard Alerts Section" class="img-fluid rounded border" style="max-width: 90%;">
            </div>
            
            <h4>Key Components</h4>
            <ul>
              <li>
                <strong>Alerts Table</strong>: A detailed table of all active and recent alerts.
              </li>
            </ul>
            
            <h4>Interaction Tips</h4>
            <ul>
              <li>Use the severity dropdown to filter alerts by severity (Critical, Warning, Info).</li>
              <li>Use the search box to filter alerts by keyword.</li>
              <li>Click on an alert to see detailed information and available actions.</li>
              <li>Use the action buttons to acknowledge, resolve, or silence alerts.</li>
            </ul>
            
            <div class="alert alert-info">
              <i class="fas fa-info-circle mr-2"></i>
              <strong>Tip:</strong> Alerts are color-coded by severity:
              <ul class="mb-0">
                <li>Red: Critical</li>
                <li>Yellow: Warning</li>
                <li>Blue: Info</li>
              </ul>
            </div>
          </div>
        </section>

        <section id="customizing" class="mt-5">
          <h2>Customizing the Dashboard</h2>
          
          <p>
            The IQSMS Monitoring Dashboard can be customized to meet your specific needs.
          </p>
          
          <h4>Time Range Selection</h4>
          <p>
            You can customize the time range shown in the dashboard using the time range selector in the sidebar.
          </p>
          <ul>
            <li>
              <strong>Predefined Ranges</strong>: Select from predefined ranges such as "Last 15 minutes", "Last hour", "Last day", etc.
            </li>
            <li>
              <strong>Custom Range</strong>: Select "Custom range..." to specify a custom date and time range.
            </li>
          </ul>
          
          <h4>Auto-Refresh</h4>
          <p>
            You can control how often the dashboard auto-refreshes using the auto-refresh selector in the sidebar.
          </p>
          <ul>
            <li>
              <strong>Off</strong>: Disable auto-refresh (you'll need to manually refresh the dashboard).
            </li>
            <li>
              <strong>5s/10s/30s/1m/5m</strong>: Refresh every 5 seconds, 10 seconds, 30 seconds, 1 minute, or 5 minutes.
            </li>
          </ul>
          
          <h4>Chart Customization</h4>
          <p>
            Many charts in the dashboard can be customized to show different metrics or time periods.
          </p>
          <ul>
            <li>
              <strong>Metric Selection</strong>: Use the buttons above charts to switch between different metrics.
            </li>
            <li>
              <strong>Zooming</strong>: Click and drag on time-series charts to zoom in on a specific time period.
            </li>
            <li>
              <strong>Filtering</strong>: Some charts allow you to filter by clicking on legend items or chart elements.
            </li>
          </ul>
          
          <h4>Advanced Customization</h4>
          <p>
            For advanced customization, you can modify the dashboard's configuration files or create custom dashboards.
          </p>
          <div class="card mb-4">
            <div class="card-header bg-light">
              <h5 class="mb-0">Dashboard Configuration File</h5>
            </div>
            <div class="card-body">
              <p>The dashboard's main configuration file is located at:</p>
              <pre><code class="language-text">/server/monitoring/dashboard/config/dashboard-config.js</code></pre>
              <p>You can modify this file to change default settings, add new metrics, or customize visualization options.</p>
            </div>
          </div>
          
          <div class="card mb-4">
            <div class="card-header bg-light">
              <h5 class="mb-0">Creating Custom Dashboards</h5>
            </div>
            <div class="card-body">
              <p>To create a custom dashboard:</p>
              <ol>
                <li>Copy an existing dashboard template from <code>/server/monitoring/dashboard/templates/</code></li>
                <li>Modify the template to include the metrics and visualizations you need</li>
                <li>Save the modified template to <code>/server/monitoring/dashboard/custom/</code></li>
                <li>Access your custom dashboard at <code>http://your-server/monitoring/dashboard/custom/your-dashboard</code></li>
              </ol>
            </div>
          </div>
        </section>

        <section id="api-reference" class="mt-5">
          <h2>API Reference</h2>
          
          <p>
            The IQSMS Monitoring Dashboard provides a RESTful API for programmatic access to monitoring data.
          </p>
          
          <div class="card mb-4">
            <div class="card-header bg-light">
              <h5 class="mb-0">API Endpoints</h5>
            </div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered">
                  <thead class="thead-light">
                    <tr>
                      <th>Endpoint</th>
                      <th>Method</th>
                      <th>Description</th>
                      <th>Parameters</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td><code>/api/metrics</code></td>
                      <td>GET</td>
                      <td>Get the latest metrics</td>
                      <td>None</td>
                    </tr>
                    <tr>
                      <td><code>/api/metrics/history</code></td>
                      <td>GET</td>
                      <td>Get historical metrics</td>
                      <td>
                        <ul>
                          <li><code>start</code>: Start time (ISO8601)</li>
                          <li><code>end</code>: End time (ISO8601)</li>
                          <li><code>interval</code>: Aggregation interval (optional)</li>
                        </ul>
                      </td>
                    </tr>
                    <tr>
                      <td><code>/api/network</code></td>
                      <td>GET</td>
                      <td>Get network topology data</td>
                      <td>None</td>
                    </tr>
                    <tr>
                      <td><code>/api/network/nodes/:id</code></td>
                      <td>GET</td>
                      <td>Get details for a specific network node</td>
                      <td>
                        <ul>
                          <li><code>id</code>: Node ID</li>
                        </ul>
                      </td>
                    </tr>
                    <tr>
                      <td><code>/api/workers</code></td>
                      <td>GET</td>
                      <td>Get worker thread status</td>
                      <td>None</td>
                    </tr>
                    <tr>
                      <td><code>/api/workers/:id</code></td>
                      <td>GET</td>
                      <td>Get details for a specific worker</td>
                      <td>
                        <ul>
                          <li><code>id</code>: Worker ID</li>
                        </ul>
                      </td>
                    </tr>
                    <tr>
                      <td><code>/api/workers/:id/restart</code></td>
                      <td>POST</td>
                      <td>Restart a worker</td>
                      <td>
                        <ul>
                          <li><code>id</code>: Worker ID</li>
                        </ul>
                      </td>
                    </tr>
                    <tr>
                      <td><code>/api/alerts</code></td>
                      <td>GET</td>
                      <td>Get active and recent alerts</td>
                      <td>None</td>
                    </tr>
                    <tr>
                      <td><code>/api/alerts/:id/acknowledge</code></td>
                      <td>POST</td>
                      <td>Acknowledge an alert</td>
                      <td>
                        <ul>
                          <li><code>id</code>: Alert ID</li>
                        </ul>
                      </td>
                    </tr>
                    <tr>
                      <td><code>/api/alerts/:id/resolve</code></td>
                      <td>POST</td>
                      <td>Resolve an alert</td>
                      <td>
                        <ul>
                          <li><code>id</code>: Alert ID</li>
                        </ul>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
          
          <div class="card mb-4">
            <div class="card-header bg-light">
              <h5 class="mb-0">API Usage Example</h5>
            </div>
            <div class="card-body">
              <p>Example of fetching historical CPU metrics for the last hour:</p>
              <pre><code class="language-javascript">const start = new Date(Date.now() - 60 * 60 * 1000).toISOString();
const end = new Date().toISOString();

fetch(`/api/metrics/history?start=${start}&end=${end}`)
  .then(response => response.json())
  .then(data => {
    // Process historical metrics data
    console.log(data);
  })
  .catch(error => {
    console.error('Error fetching metrics:', error);
  });</code></pre>
            </div>
          </div>
        </section>

        <section id="troubleshooting" class="mt-5">
          <h2>Troubleshooting</h2>
          
          <p>
            If you encounter issues with the IQSMS Monitoring Dashboard, here are some common problems and solutions.
          </p>
          
          <div class="accordion" id="troubleshootingAccordion">
            <div class="card">
              <div class="card-header" id="headingConnection">
                <h5 class="mb-0">
                  <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#collapseConnection" aria-expanded="true" aria-controls="collapseConnection">
                    Dashboard shows "Disconnected" status
                  </button>
                </h5>
              </div>
              <div id="collapseConnection" class="collapse show" aria-labelledby="headingConnection" data-parent="#troubleshootingAccordion">
                <div class="card-body">
                  <p>If the dashboard shows a "Disconnected" status, it means the WebSocket connection to the server has been lost.</p>
                  <p><strong>Possible causes and solutions:</strong></p>
                  <ul>
                    <li>
                      <strong>Server is down or unreachable</strong>: Check if the server is running and accessible.
                    </li>
                    <li>
                      <strong>Network issues</strong>: Check your network connection and ensure there are no firewall or proxy issues blocking WebSocket connections.
                    </li>
                    <li>
                      <strong>Browser issues</strong>: Try refreshing the page or using a different browser.
                    </li>
                  </ul>
                  <p>The dashboard will automatically attempt to reconnect several times. If it fails, it will fall back to HTTP polling to continue showing data, but with less real-time updates.</p>
                </div>
              </div>
            </div>
            
            <div class="card">
              <div class="card-header" id="headingNetworkMap">
                <h5 class="mb-0">
                  <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseNetworkMap" aria-expanded="false" aria-controls="collapseNetworkMap">
                    Network Map not displaying
                  </button>
                </h5>
              </div>
              <div id="collapseNetworkMap" class="collapse" aria-labelledby="headingNetworkMap" data-parent="#troubleshootingAccordion">
                <div class="card-body">
                  <p>If the Network Map section is not displaying properly, it may be due to WebGL issues.</p>
                  <p><strong>Possible causes and solutions:</strong></p>
                  <ul>
                    <li>
                      <strong>WebGL not supported</strong>: Check if your browser supports WebGL by visiting <a href="https://get.webgl.org/" target="_blank">https://get.webgl.org/</a>.
                    </li>
                    <li>
                      <strong>WebGL disabled</strong>: Enable WebGL in your browser settings.
                    </li>
                    <li>
                      <strong>Hardware acceleration issues</strong>: Try enabling hardware acceleration in your browser settings.
                    </li>
                    <li>
                      <strong>Outdated graphics drivers</strong>: Update your graphics drivers.
                    </li>
                  </ul>
                  <p>If you cannot enable WebGL, the dashboard will automatically fall back to a 2D visualization for the Network Map.</p>
                </div>
              </div>
            </div>
            
            <div class="card">
              <div class="card-header" id="headingPerformance">
                <h5 class="mb-0">
                  <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapsePerformance" aria-expanded="false" aria-controls="collapsePerformance">
                    Dashboard performance is slow
                  </button>
                </h5>
              </div>
              <div id="collapsePerformance" class="collapse" aria-labelledby="headingPerformance" data-parent="#troubleshootingAccordion">
                <div class="card-body">
                  <p>If the dashboard is slow or unresponsive, it may be due to performance issues.</p>
                  <p><strong>Possible causes and solutions:</strong></p>
                  <ul>
                    <li>
                      <strong>Too much data</strong>: Try reducing the time range to show less data.
                    </li>
                    <li>
                      <strong>Network Map complexity</strong>: If the 3D Network Map is causing slowness, switch to the 2D view.
                    </li>
                    <li>
                      <strong>Auto-refresh interval too short</strong>: Increase the auto-refresh interval or turn it off.
                    </li>
                    <li>
                      <strong>Browser resources</strong>: Close other tabs or applications to free up resources.
                    </li>
                    <li>
                      <strong>Mobile device limitations</strong>: On mobile devices, some visualizations may be simplified for better performance.
                    </li>
                  </ul>
                </div>
              </div>
            </div>
            
            <div class="card">
              <div class="card-header" id="headingData">
                <h5 class="mb-0">
                  <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseData" aria-expanded="false" aria-controls="collapseData">
                    Dashboard shows no data or incorrect data
                  </button>
                </h5>
              </div>
              <div id="collapseData" class="collapse" aria-labelledby="headingData" data-parent="#troubleshootingAccordion">
                <div class="card-body">
                  <p>If the dashboard shows no data or incorrect data, it may be due to data collection or API issues.</p>
                  <p><strong>Possible causes and solutions:</strong></p>
                  <ul>
                    <li>
                      <strong>Metrics collection not running</strong>: Check if the metrics collection service is running on the server.
                    </li>
                    <li>
                      <strong>API errors</strong>: Check the browser console for API error messages.
                    </li>
                    <li>
                      <strong>Time range issues</strong>: Ensure the selected time range contains data.
                    </li>
                    <li>
                      <strong>Data storage issues</strong>: Check if the metrics database is accessible and contains data.
                    </li>
                  </ul>
                  <p>Try refreshing the dashboard or selecting a different time range to see if data appears.</p>
                </div>
              </div>
            </div>
          </div>
          
          <div class="alert alert-info mt-4">
            <i class="fas fa-info-circle mr-2"></i>
            <strong>Need more help?</strong> If you continue to experience issues with the dashboard, please contact your system administrator or refer to the IQSMS technical support resources.
          </div>
        </section>
      </div>
    </div>
  </div>

  <footer class="bg-dark text-white py-4 mt-5">
    <div class="container">
      <div class="row">
        <div class="col-md-4">
          <h5>IQSMS Documentation</h5>
          <p>Comprehensive documentation for the IQ Safety Management Surveillance System</p>
          <p><small>&copy; 2025 Autonomy Association International Inc., all rights reserved</small></p>
        </div>
        <div class="col-md-4">
          <h5>Quick Links</h5>
          <ul class="list-unstyled">
            <li><a href="../../getting-started.html" class="text-light">Getting Started</a></li>
            <li><a href="../../api-reference.html" class="text-light">API Reference</a></li>
            <li><a href="../../plugins/index.html" class="text-light">Plugins</a></li>
          </ul>
        </div>
        <div class="col-md-4">
          <h5>Legal</h5>
          <p><small>Safeguard patent license from National Aeronautics and Space Administration (NASA)</small></p>
          <p><small>Copyright 2025 NASA, all rights reserved</small></p>
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


The files provided above represent a comprehensive monitoring dashboard solution for the IQSMS platform. All JavaScript files include proper path information in their header comments for easy organization and reference.



# Dashboard Images for IQSMS Monitoring Dashboard

To complete the Dashboard How-To guide, I'll create the necessary images referenced in the documentation. These images will provide visual references for each section of the dashboard.

## 1. Main Dashboard Screenshot

**File: `/docs/images/dashboard-screenshot.png`**

This image should provide an overview of the entire dashboard interface, showcasing all major components including gauges, charts, and the network visualization. The image would show:

- The four metric gauges (CPU, Memory, Network, Alerts)
- The performance chart showing CPU usage over time
- The protocols distribution pie chart
- The sidebar with navigation and time controls
- The dashboard header with controls

The image would have a professional, clean look with the IQSMS blue color scheme.

## 2. Overview Section Screenshot

**File: `/docs/images/dashboard-overview.png`**

This image would focus specifically on the Overview section, showing:

- The four metric gauges with real-time values
- The performance chart showing system metrics over time
- The protocol distribution pie chart
- Trend indicators showing whether metrics are increasing or decreasing

The image would highlight the interactive elements such as the chart type selector buttons.

## 3. System Resources Section Screenshot

**File: `/docs/images/dashboard-system.png`**

This image would showcase the System Resources section with:

- CPU usage history chart with a time-series line graph
- Memory usage history chart showing memory consumption over time
- Disk I/O chart displaying read/write operations
- Network I/O chart showing incoming and outgoing traffic

The image would demonstrate the time-series data visualization with hover tooltips visible.

## 4. Network Map Section Screenshot

**File: `/docs/images/dashboard-network.png`**

This image would display the Network Map visualization:

- The 3D network graph showing nodes and connections
- Different colored nodes representing different types (servers, clients, gateways)
- Connection lines between nodes
- The view control buttons (3D View, 2D View, Geo Map)
- A node details panel showing information about a selected node

The image would demonstrate the interactive 3D visualization built with Three.js.

## 5. Worker Threads Section Screenshot

**File: `/docs/images/dashboard-workers.png`**

This image would show the Worker Threads section:

- The worker activity chart showing active, idle, and tasks over time
- The worker status pie chart showing the distribution of worker states
- The worker threads table with columns for ID, status, type, CPU, memory, tasks, and actions
- Filter controls for searching workers

The image would demonstrate the data table with different status indicators.

## 6. Alerts Section Screenshot

**File: `/docs/images/dashboard-alerts.png`**

This image would display the Alerts section:

- The alerts table showing active and recent alerts
- Color-coded severity indicators (critical, warning, info)
- Status badges (active, acknowledged, resolved)
- Filter controls for severity and search
- Action buttons for each alert

The image would show alerts of different severities and statuses to demonstrate the visual indicators.

## Implementation Notes

These images would typically be created by:

1. Taking screenshots of the actual dashboard running with real or sample data
2. Editing them to ensure they're clear and properly highlight the key features
3. Optimizing them for web display (balancing quality and file size)
4. Saving them in the `/docs/images/` directory

In a production environment, you would want to ensure these images are:
- Updated when the dashboard interface changes
- Show realistic but not sensitive data
- Include captions or annotations in the documentation to explain key features
- Are responsive and properly displayed on different screen sizes

With these images in place, the Dashboard How-To guide would provide users with clear visual references to help them understand and navigate the monitoring dashboard effectively.


# SVG Graphics for IQSMS Monitoring Dashboard

I'll now create the SVG graphics described in the previous response. These will be designed to illustrate the different sections of the monitoring dashboard in the documentation.

## 1. Main Dashboard Screenshot (dashboard-screenshot.svg)

```svg
<svg width="800" height="600" viewBox="0 0 800 600" xmlns="http://www.w3.org/2000/svg">
  <!-- Background -->
  <rect width="800" height="600" fill="#f8f9fc"/>
  
  <!-- Sidebar -->
  <rect x="0" y="0" width="200" height="600" fill="url(#sidebar-gradient)"/>
  
  <!-- Sidebar content -->
  <text x="20" y="30" font-family="Arial" font-size="16" font-weight="bold" fill="#ffffff">IQSMS Monitoring</text>
  <rect x="10" y="50" width="180" height="1" fill="rgba(255,255,255,0.1)"/>
  
  <!-- Sidebar navigation -->
  <rect x="10" y="100" width="180" height="30" fill="rgba(255,255,255,0.2)"/>
  <text x="20" y="120" font-family="Arial" font-size="14" fill="#ffffff">Overview</text>
  
  <text x="20" y="150" font-family="Arial" font-size="14" fill="rgba(255,255,255,0.8)">System Resources</text>
  <text x="20" y="180" font-family="Arial" font-size="14" fill="rgba(255,255,255,0.8)">Network Map</text>
  <text x="20" y="210" font-family="Arial" font-size="14" fill="rgba(255,255,255,0.8)">Worker Threads</text>
  <text x="20" y="240" font-family="Arial" font-size="14" fill="rgba(255,255,255,0.8)">Alerts</text>
  
  <!-- Time control -->
  <rect x="10" y="500" width="180" height="1" fill="rgba(255,255,255,0.1)"/>
  <text x="20" y="530" font-family="Arial" font-size="12" fill="#ffffff">Last updated: 2 seconds ago</text>
  <circle cx="15" cy="550" r="5" fill="#1cc88a"/>
  <text x="25" y="555" font-family="Arial" font-size="12" fill="#ffffff">Connected</text>
  
  <!-- Main content area -->
  <rect x="200" y="0" width="600" height="60" fill="#ffffff"/>
  <text x="220" y="35" font-family="Arial" font-size="20" font-weight="bold" fill="#333333">System Overview</text>
  
  <!-- Metric cards row -->
  <g transform="translate(220, 80)">
    <!-- CPU card -->
    <rect width="130" height="140" rx="5" fill="#ffffff" stroke="#e3e6f0" stroke-width="1"/>
    <text x="10" y="25" font-family="Arial" font-size="14" font-weight="bold" fill="#4e73df">CPU Usage</text>
    
    <!-- CPU gauge -->
    <circle cx="65" cy="80" r="40" fill="none" stroke="#e9ecef" stroke-width="8"/>
    <path d="M65,80 L65,40 A40,40 0 0,1 99.3,102 z" fill="#4e73df" opacity="0.8"/>
    <text x="65" y="85" font-family="Arial" font-size="18" font-weight="bold" fill="#333333" text-anchor="middle">42%</text>
    
    <!-- Memory card -->
    <rect x="140" width="130" height="140" rx="5" fill="#ffffff" stroke="#e3e6f0" stroke-width="1"/>
    <text x="150" y="25" font-family="Arial" font-size="14" font-weight="bold" fill="#4e73df">Memory</text>
    
    <!-- Memory gauge -->
    <circle cx="205" cy="80" r="40" fill="none" stroke="#e9ecef" stroke-width="8"/>
    <path d="M205,80 L205,40 A40,40 0 0,1 239.3,102 z" fill="#1cc88a" opacity="0.8"/>
    <text x="205" y="85" font-family="Arial" font-size="18" font-weight="bold" fill="#333333" text-anchor="middle">68%</text>
    
    <!-- Network card -->
    <rect x="280" width="130" height="140" rx="5" fill="#ffffff" stroke="#e3e6f0" stroke-width="1"/>
    <text x="290" y="25" font-family="Arial" font-size="14" font-weight="bold" fill="#4e73df">Network</text>
    
    <!-- Network gauge -->
    <circle cx="345" cy="80" r="40" fill="none" stroke="#e9ecef" stroke-width="8"/>
    <path d="M345,80 L345,40 A40,40 0 0,1 379.3,102 z" fill="#36b9cc" opacity="0.8"/>
    <text x="345" y="85" font-family="Arial" font-size="18" font-weight="bold" fill="#333333" text-anchor="middle">24MB/s</text>
    
    <!-- Alerts card -->
    <rect x="420" width="130" height="140" rx="5" fill="#ffffff" stroke="#e3e6f0" stroke-width="1"/>
    <text x="430" y="25" font-family="Arial" font-size="14" font-weight="bold" fill="#4e73df">Alerts</text>
    
    <!-- Alerts gauge -->
    <circle cx="485" cy="80" r="40" fill="none" stroke="#e9ecef" stroke-width="8"/>
    <path d="M485,80 L485,40 A40,40 0 0,1 519.3,102 z" fill="#e74a3b" opacity="0.8"/>
    <text x="485" y="85" font-family="Arial" font-size="18" font-weight="bold" fill="#333333" text-anchor="middle">3</text>
  </g>
  
  <!-- Charts row -->
  <g transform="translate(220, 240)">
    <!-- Performance chart card -->
    <rect width="360" height="200" rx="5" fill="#ffffff" stroke="#e3e6f0" stroke-width="1"/>
    <rect width="360" height="40" rx="5 5 0 0" fill="#f8f9fc" stroke="#e3e6f0" stroke-width="1"/>
    <text x="10" y="25" font-family="Arial" font-size="14" font-weight="bold" fill="#333333">System Performance</text>
    
    <!-- Chart buttons -->
    <rect x="180" y="10" width="40" height="20" rx="3" fill="#4e73df"/>
    <text x="200" y="24" font-family="Arial" font-size="10" fill="#ffffff" text-anchor="middle">CPU</text>
    
    <rect x="225" y="10" width="60" height="20" rx="3" fill="#ffffff" stroke="#d1d3e2" stroke-width="1"/>
    <text x="255" y="24" font-family="Arial" font-size="10" fill="#333333" text-anchor="middle">Memory</text>
    
    <rect x="290" y="10" width="40" height="20" rx="3" fill="#ffffff" stroke="#d1d3e2" stroke-width="1"/>
    <text x="310" y="24" font-family="Arial" font-size="10" fill="#333333" text-anchor="middle">I/O</text>
    
    <!-- Line chart -->
    <polyline points="10,170 30,150 50,160 70,140 90,150 110,130 130,140 150,120 170,130 190,100 210,110 230,90 250,80 270,100 290,70 310,60 330,50 350,40" 
              fill="none" stroke="#4e73df" stroke-width="2"/>
              
    <!-- Chart axes -->
    <line x1="10" y1="170" x2="350" y2="170" stroke="#e3e6f0" stroke-width="1"/>
    <line x1="10" y1="40" x2="10" y2="170" stroke="#e3e6f0" stroke-width="1"/>
    
    <!-- X-axis labels -->
    <text x="30" y="185" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">12:00</text>
    <text x="110" y="185" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">12:10</text>
    <text x="190" y="185" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">12:20</text>
    <text x="270" y="185" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">12:30</text>
    <text x="350" y="185" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">12:40</text>
    
    <!-- Y-axis labels -->
    <text x="5" y="170" font-family="Arial" font-size="8" fill="#858796" text-anchor="end">0%</text>
    <text x="5" y="130" font-family="Arial" font-size="8" fill="#858796" text-anchor="end">25%</text>
    <text x="5" y="90" font-family="Arial" font-size="8" fill="#858796" text-anchor="end">50%</text>
    <text x="5" y="50" font-family="Arial" font-size="8" fill="#858796" text-anchor="end">75%</text>
    
    <!-- Protocol distribution card -->
    <rect x="370" width="190" height="200" rx="5" fill="#ffffff" stroke="#e3e6f0" stroke-width="1"/>
    <rect x="370" width="190" height="40" rx="5 5 0 0" fill="#f8f9fc" stroke="#e3e6f0" stroke-width="1"/>
    <text x="380" y="25" font-family="Arial" font-size="14" font-weight="bold" fill="#333333">Active Protocols</text>
    
    <!-- Donut chart -->
    <circle cx="465" cy="120" r="60" fill="#ffffff"/>
    <!-- Agent protocol (blue) -->
    <path d="M465,120 L465,60 A60,60 0 0,1 522.2,140 z" fill="#4e73df"/>
    <!-- MCP protocol (green) -->
    <path d="M465,120 L522.2,140 A60,60 0 0,1 465,180 z" fill="#1cc88a"/>
    <!-- Message protocol (cyan) -->
    <path d="M465,120 L465,180 A60,60 0 0,1 407.8,140 z" fill="#36b9cc"/>
    <!-- Other protocols (yellow) -->
    <path d="M465,120 L407.8,140 A60,60 0 0,1 465,60 z" fill="#f6c23e"/>
    
    <!-- Inner circle for donut -->
    <circle cx="465" cy="120" r="40" fill="#ffffff"/>
    <text x="465" y="125" font-family="Arial" font-size="18" font-weight="bold" fill="#333333" text-anchor="middle">42</text>
    
    <!-- Legend -->
    <rect x="380" y="190" width="10" height="10" fill="#4e73df"/>
    <text x="395" y="199" font-family="Arial" font-size="10" fill="#333333">Agent</text>
    
    <rect x="430" y="190" width="10" height="10" fill="#1cc88a"/>
    <text x="445" y="199" font-family="Arial" font-size="10" fill="#333333">MCP</text>
    
    <rect x="480" y="190" width="10" height="10" fill="#36b9cc"/>
    <text x="495" y="199" font-family="Arial" font-size="10" fill="#333333">Message</text>
  </g>
  
  <!-- Network section -->
  <g transform="translate(220, 460)">
    <rect width="560" height="120" rx="5" fill="#ffffff" stroke="#e3e6f0" stroke-width="1"/>
    <rect width="560" height="40" rx="5 5 0 0" fill="#f8f9fc" stroke="#e3e6f0" stroke-width="1"/>
    <text x="10" y="25" font-family="Arial" font-size="14" font-weight="bold" fill="#333333">Network Map</text>
    
    <!-- Network visualization (simplified) -->
    <rect x="10" y="50" width="540" height="60" fill="#181c30" rx="3"/>
    
    <!-- Nodes and connections -->
    <circle cx="100" cy="80" r="6" fill="#4e73df"/>
    <circle cx="150" cy="70" r="5" fill="#1cc88a"/>
    <circle cx="200" cy="90" r="5" fill="#1cc88a"/>
    <circle cx="250" cy="75" r="6" fill="#e74a3b"/>
    <circle cx="300" cy="85" r="5" fill="#1cc88a"/>
    <circle cx="350" cy="65" r="5" fill="#f6c23e"/>
    <circle cx="400" cy="80" r="4" fill="#36b9cc"/>
    <circle cx="450" cy="75" r="4" fill="#36b9cc"/>
    <circle cx="500" cy="85" r="6" fill="#4e73df"/>
    
    <!-- Connections -->
    <line x1="100" y1="80" x2="150" y2="70" stroke="#4e73df" stroke-width="1" opacity="0.5"/>
    <line x1="100" y1="80" x2="200" y2="90" stroke="#4e73df" stroke-width="1" opacity="0.5"/>
    <line x1="100" y1="80" x2="250" y2="75" stroke="#4e73df" stroke-width="1" opacity="0.5"/>
    <line x1="250" y1="75" x2="300" y2="85" stroke="#e74a3b" stroke-width="1" opacity="0.5"/>
    <line x1="250" y1="75" x2="350" y2="65" stroke="#e74a3b" stroke-width="1" opacity="0.5"/>
    <line x1="350" y1="65" x2="400" y2="80" stroke="#f6c23e" stroke-width="1" opacity="0.5"/>
    <line x1="350" y1="65" x2="450" y2="75" stroke="#f6c23e" stroke-width="1" opacity="0.5"/>
    <line x1="500" y1="85" x2="400" y2="80" stroke="#4e73df" stroke-width="1" opacity="0.5"/>
    <line x1="500" y1="85" x2="450" y2="75" stroke="#4e73df" stroke-width="1" opacity="0.5"/>
  </g>
  
  <!-- Definitions -->
  <defs>
    <linearGradient id="sidebar-gradient" x1="0%" y1="0%" x2="0%" y2="100%">
      <stop offset="0%" stop-color="#4e73df"/>
      <stop offset="100%" stop-color="#224abe"/>
    </linearGradient>
  </defs>
</svg>
```


## 2. Overview Section Screenshot (dashboard-overview.svg)

```svg
<svg width="800" height="400" viewBox="0 0 800 400" xmlns="http://www.w3.org/2000/svg">
  <!-- Background -->
  <rect width="800" height="400" fill="#f8f9fc"/>
  
  <!-- Header -->
  <rect x="0" y="0" width="800" height="60" fill="#ffffff"/>
  <text x="20" y="35" font-family="Arial" font-size="20" font-weight="bold" fill="#333333">System Overview</text>
  
  <!-- Metric cards row -->
  <g transform="translate(20, 80)">
    <!-- CPU card -->
    <rect width="180" height="140" rx="5" fill="#ffffff" stroke="#e3e6f0" stroke-width="1"/>
    <text x="15" y="30" font-family="Arial" font-size="16" font-weight="bold" fill="#4e73df">CPU Load</text>
    <text x="150" y="30" font-family="Arial" font-size="16" fill="#4e73df">
      <tspan font-family="FontAwesome">&#xf2db;</tspan>
    </text>
    
    <!-- CPU gauge -->
    <circle cx="90" cy="85" r="40" fill="none" stroke="#e9ecef" stroke-width="8"/>
    <path d="M90,85 L90,45 A40,40 0 0,1 124.3,107 z" fill="#4e73df" opacity="0.8"/>
    <text x="90" y="90" font-family="Arial" font-size="18" font-weight="bold" fill="#333333" text-anchor="middle">42%</text>
    <text x="50" y="130" font-family="Arial" font-size="14" font-weight="bold" fill="#333333">42%</text>
    <text x="130" y="130" font-family="Arial" font-size="12" fill="#1cc88a">+2.4%</text>
    
    <!-- Memory card -->
    <rect x="190" width="180" height="140" rx="5" fill="#ffffff" stroke="#e3e6f0" stroke-width="1"/>
    <text x="205" y="30" font-family="Arial" font-size="16" font-weight="bold" fill="#4e73df">Memory Usage</text>
    <text x="340" y="30" font-family="Arial" font-size="16" fill="#4e73df">
      <tspan font-family="FontAwesome">&#xf538;</tspan>
    </text>
    
    <!-- Memory gauge -->
    <circle cx="280" cy="85" r="40" fill="none" stroke="#e9ecef" stroke-width="8"/>
    <path d="M280,85 L280,45 A40,40 0 0,1 314.3,107 z" fill="#1cc88a" opacity="0.8"/>
    <text x="280" y="90" font-family="Arial" font-size="18" font-weight="bold" fill="#333333" text-anchor="middle">68%</text>
    <text x="240" y="130" font-family="Arial" font-size="14" font-weight="bold" fill="#333333">68%</text>
    <text x="320" y="130" font-family="Arial" font-size="12" fill="#e74a3b">-1.2%</text>
    
    <!-- Network card -->
    <rect x="380" width="180" height="140" rx="5" fill="#ffffff" stroke="#e3e6f0" stroke-width="1"/>
    <text x="395" y="30" font-family="Arial" font-size="16" font-weight="bold" fill="#4e73df">Network Traffic</text>
    <text x="530" y="30" font-family="Arial" font-size="16" fill="#4e73df">
      <tspan font-family="FontAwesome">&#xf6ff;</tspan>
    </text>
    
    <!-- Network gauge -->
    <circle cx="470" cy="85" r="40" fill="none" stroke="#e9ecef" stroke-width="8"/>
    <path d="M470,85 L470,45 A40,40 0 0,1 504.3,107 z" fill="#36b9cc" opacity="0.8"/>
    <text x="470" y="90" font-family="Arial" font-size="18" font-weight="bold" fill="#333333" text-anchor="middle">24MB/s</text>
    <text x="420" y="130" font-family="Arial" font-size="14" font-weight="bold" fill="#333333">24MB/s</text>
    <text x="510" y="130" font-family="Arial" font-size="12" fill="#1cc88a">+5.7%</text>
    
    <!-- Alerts card -->
    <rect x="570" width="180" height="140" rx="5" fill="#ffffff" stroke="#e3e6f0" stroke-width="1"/>
    <text x="585" y="30" font-family="Arial" font-size="16" font-weight="bold" fill="#4e73df">Active Alerts</text>
    <text x="720" y="30" font-family="Arial" font-size="16" fill="#4e73df">
      <tspan font-family="FontAwesome">&#xf071;</tspan>
    </text>
    
    <!-- Alerts gauge -->
    <circle cx="660" cy="85" r="40" fill="none" stroke="#e9ecef" stroke-width="8"/>
    <path d="M660,85 L660,45 A40,40 0 0,1 694.3,107 z" fill="#e74a3b" opacity="0.8"/>
    <text x="660" y="90" font-family="Arial" font-size="18" font-weight="bold" fill="#333333" text-anchor="middle">3</text>
    <text x="630" y="130" font-family="Arial" font-size="14" font-weight="bold" fill="#333333">3</text>
    <text x="700" y="130" font-family="Arial" font-size="12" fill="#858796">0</text>
  </g>
  
  <!-- Charts row -->
  <g transform="translate(20, 240)">
    <!-- Performance chart card -->
    <rect width="480" height="150" rx="5" fill="#ffffff" stroke="#e3e6f0" stroke-width="1"/>
    <rect width="480" height="40" rx="5 5 0 0" fill="#f8f9fc" stroke="#e3e6f0" stroke-width="1"/>
    <text x="15" y="25" font-family="Arial" font-size="16" font-weight="bold" fill="#333333">System Performance</text>
    
    <!-- Chart buttons -->
    <rect x="280" y="10" width="40" height="20" rx="3" fill="#4e73df"/>
    <text x="300" y="24" font-family="Arial" font-size="10" fill="#ffffff" text-anchor="middle">CPU</text>
    
    <rect x="325" y="10" width="60" height="20" rx="3" fill="#ffffff" stroke="#d1d3e2" stroke-width="1"/>
    <text x="355" y="24" font-family="Arial" font-size="10" fill="#333333" text-anchor="middle">Memory</text>
    
    <rect x="390" y="10" width="40" height="20" rx="3" fill="#ffffff" stroke="#d1d3e2" stroke-width="1"/>
    <text x="410" y="24" font-family="Arial" font-size="10" fill="#333333" text-anchor="middle">I/O</text>

    <rect x="435" y="10" width="40" height="20" rx="3" fill="#ffffff" stroke="#d1d3e2" stroke-width="1"/>
    <text x="455" y="24" font-family="Arial" font-size="10" fill="#333333" text-anchor="middle">Network</text>
    
    <!-- Line chart -->
    <polyline points="20,120 40,100 60,110 80,90 100,100 120,80 140,90 160,70 180,80 200,50 220,60 240,40 260,30 280,50 300,20 320,10 340,30 360,20 380,30 400,40 420,30 440,20 460,10" 
              fill="none" stroke="#4e73df" stroke-width="2"/>
              
    <!-- Chart axes -->
    <line x1="20" y1="120" x2="460" y2="120" stroke="#e3e6f0" stroke-width="1"/>
    <line x1="20" y1="10" x2="20" y2="120" stroke="#e3e6f0" stroke-width="1"/>
    
    <!-- X-axis labels -->
    <text x="40" y="135" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">12:00</text>
    <text x="100" y="135" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">12:05</text>
    <text x="160" y="135" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">12:10</text>
    <text x="220" y="135" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">12:15</text>
    <text x="280" y="135" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">12:20</text>
    <text x="340" y="135" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">12:25</text>
    <text x="400" y="135" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">12:30</text>
    
    <!-- Y-axis labels -->
    <text x="15" y="120" font-family="Arial" font-size="8" fill="#858796" text-anchor="end">0%</text>
    <text x="15" y="90" font-family="Arial" font-size="8" fill="#858796" text-anchor="end">25%</text>
    <text x="15" y="60" font-family="Arial" font-size="8" fill="#858796" text-anchor="end">50%</text>
    <text x="15" y="30" font-family="Arial" font-size="8" fill="#858796" text-anchor="end">75%</text>
    
    <!-- Protocol distribution card -->
    <rect x="490" width="270" height="150" rx="5" fill="#ffffff" stroke="#e3e6f0" stroke-width="1"/>
    <rect x="490" width="270" height="40" rx="5 5 0 0" fill="#f8f9fc" stroke="#e3e6f0" stroke-width="1"/>
    <text x="505" y="25" font-family="Arial" font-size="16" font-weight="bold" fill="#333333">Active Protocols</text>
    
    <!-- Donut chart -->
    <circle cx="625" cy="95" r="60" fill="#ffffff"/>
    <!-- Agent protocol (blue) -->
    <path d="M625,95 L625,35 A60,60 0 0,1 682.2,115 z" fill="#4e73df"/>
    <!-- MCP protocol (green) -->
    <path d="M625,95 L682.2,115 A60,60 0 0,1 625,155 z" fill="#1cc88a"/>
    <!-- Message protocol (cyan) -->
    <path d="M625,95 L625,155 A60,60 0 0,1 567.8,115 z" fill="#36b9cc"/>
    <!-- Other protocols (yellow) -->
    <path d="M625,95 L567.8,115 A60,60 0 0,1 625,35 z" fill="#f6c23e"/>
    
    <!-- Inner circle for donut -->
    <circle cx="625" cy="95" r="40" fill="#ffffff"/>
    <text x="625" y="100" font-family="Arial" font-size="18" font-weight="bold" fill="#333333" text-anchor="middle">42</text>
    
    <!-- Legend -->
    <rect x="500" y="170" width="10" height="10" fill="#4e73df"/>
    <text x="515" y="179" font-family="Arial" font-size="10" fill="#333333">Agent (40%)</text>
    
    <rect x="580" y="170" width="10" height="10" fill="#1cc88a"/>
    <text x="595" y="179" font-family="Arial" font-size="10" fill="#333333">MCP (25%)</text>
    
    <rect x="660" y="170" width="10" height="10" fill="#36b9cc"/>
    <text x="675" y="179" font-family="Arial" font-size="10" fill="#333333">Message (20%)</text>
    
    <rect x="740" y="170" width="10" height="10" fill="#f6c23e"/>
    <text x="755" y="179" font-family="Arial" font-size="10" fill="#333333">Other (15%)</text>
  </g>
</svg>
```


## 3. System Resources Section Screenshot (dashboard-system.svg)

```svg
<svg width="800" height="500" viewBox="0 0 800 500" xmlns="http://www.w3.org/2000/svg">
  <!-- Background -->
  <rect width="800" height="500" fill="#f8f9fc"/>
  
  <!-- Header -->
  <rect x="0" y="0" width="800" height="60" fill="#ffffff"/>
  <text x="20" y="35" font-family="Arial" font-size="20" font-weight="bold" fill="#333333">System Resources</text>
  
  <!-- CPU Usage chart -->
  <g transform="translate(20, 80)">
    <rect width="370" height="180" rx="5" fill="#ffffff" stroke="#e3e6f0" stroke-width="1"/>
    <rect width="370" height="40" rx="5 5 0 0" fill="#f8f9fc" stroke="#e3e6f0" stroke-width="1"/>
    <text x="15" y="25" font-family="Arial" font-size="16" font-weight="bold" fill="#333333">CPU Usage History</text>
    
    <!-- CPU chart -->
    <line x1="40" y1="150" x2="350" y2="150" stroke="#e3e6f0" stroke-width="1"/>
    <line x1="40" y1="50" x2="40" y2="150" stroke="#e3e6f0" stroke-width="1"/>
    
    <!-- CPU line -->
    <polyline points="40,120 60,110 80,100 100,110 120,90 140,80 160,70 180,90 200,100 220,80 240,60 260,70 280,80 300,50 320,70 340,60" 
              fill="none" stroke="#4e73df" stroke-width="2"/>
              
    <!-- Area under line (with opacity) -->
    <path d="M40,120 60,110 80,100 100,110 120,90 140,80 160,70 180,90 200,100 220,80 240,60 260,70 280,80 300,50 320,70 340,60 L340,150 40,150 Z" 
          fill="#4e73df" opacity="0.2"/>
          
    <!-- X-axis labels -->
    <text x="40" y="165" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">12:00</text>
    <text x="90" y="165" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">12:05</text>
    <text x="140" y="165" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">12:10</text>
    <text x="190" y="165" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">12:15</text>
    <text x="240" y="165" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">12:20</text>
    <text x="290" y="165" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">12:25</text>
    <text x="340" y="165" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">12:30</text>
    
    <!-- Y-axis labels -->
    <text x="35" y="150" font-family="Arial" font-size="8" fill="#858796" text-anchor="end">0%</text>
    <text x="35" y="120" font-family="Arial" font-size="8" fill="#858796" text-anchor="end">25%</text>
    <text x="35" y="90" font-family="Arial" font-size="8" fill="#858796" text-anchor="end">50%</text>
    <text x="35" y="60" font-family="Arial" font-size="8" fill="#858796" text-anchor="end">75%</text>
    
    <!-- Hover tooltip -->
    <g transform="translate(240, 60)">
      <rect width="80" height="40" fill="#ffffff" stroke="#e3e6f0" stroke-width="1" rx="3"/>
      <text x="5" y="15" font-family="Arial" font-size="8" fill="#333333">Time: 12:20</text>
      <text x="5" y="30" font-family="Arial" font-size="10" font-weight="bold" fill="#333333">CPU: 56%</text>
    </g>
  </g>
  
  <!-- Memory Usage chart -->
  <g transform="translate(410, 80)">
    <rect width="370" height="180" rx="5" fill="#ffffff" stroke="#e3e6f0" stroke-width="1"/>
    <rect width="370" height="40" rx="5 5 0 0" fill="#f8f9fc" stroke="#e3e6f0" stroke-width="1"/>
    <text x="15" y="25" font-family="Arial" font-size="16" font-weight="bold" fill="#333333">Memory Usage History</text>
    
    <!-- Memory chart -->
    <line x1="40" y1="150" x2="350" y2="150" stroke="#e3e6f0" stroke-width="1"/>
    <line x1="40" y1="50" x2="40" y2="150" stroke="#e3e6f0" stroke-width="1"/>
    
    <!-- Memory line -->
    <polyline points="40,110 60,105 80,100 100,95 120,90 140,95 160,90 180,85 200,80 220,75 240,80 260,85 280,80 300,70 320,75 340,70" 
              fill="none" stroke="#1cc88a" stroke-width="2"/>
              
    <!-- Area under line (with opacity) -->
    <path d="M40,110 60,105 80,100 100,95 120,90 140,95 160,90 180,85 200,80 220,75 240,80 260,85 280,80 300,70 320,75 340,70 L340,150 40,150 Z" 
          fill="#1cc88a" opacity="0.2"/>
          
    <!-- X-axis labels -->
    <text x="40" y="165" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">12:00</text>
    <text x="90" y="165" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">12:05</text>
    <text x="140" y="165" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">12:10</text>
    <text x="190" y="165" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">12:15</text>
    <text x="240" y="165" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">12:20</text>
    <text x="290" y="165" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">12:25</text>
    <text x="340" y="165" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">12:30</text>
    
    <!-- Y-axis labels -->
    <text x="35" y="150" font-family="Arial" font-size="8" fill="#858796" text-anchor="end">0%</text>
    <text x="35" y="120" font-family="Arial" font-size="8" fill="#858796" text-anchor="end">25%</text>
    <text x="35" y="90" font-family="Arial" font-size="8" fill="#858796" text-anchor="end">50%</text>
    <text x="35" y="60" font-family="Arial" font-size="8" fill="#858796" text-anchor="end">75%</text>
  </g>
  
  <!-- Disk I/O chart -->
  <g transform="translate(20, 280)">
    <rect width="370" height="180" rx="5" fill="#ffffff" stroke="#e3e6f0" stroke-width="1"/>
    <rect width="370" height="40" rx="5 5 0 0" fill="#f8f9fc" stroke="#e3e6f0" stroke-width="1"/>
    <text x="15" y="25" font-family="Arial" font-size="16" font-weight="bold" fill="#333333">Disk I/O</text>
    
    <!-- Disk chart -->
    <line x1="40" y1="150" x2="350" y2="150" stroke="#e3e6f0" stroke-width="1"/>
    <line x1="40" y1="50" x2="40" y2="150" stroke="#e3e6f0" stroke-width="1"/>
    
    <!-- Read line -->
    <polyline points="40,140 60,130 80,135 100,120 120,125 140,115 160,120 180,110 200,120 220,100 240,110 260,105 280,110 300,95 320,100 340,90" 
              fill="none" stroke="#4e73df" stroke-width="2"/>
              
    <!-- Write line -->
    <polyline points="40,145 60,140 80,130 100,135 120,125 140,130 160,125 180,120 200,125 220,115 240,120 260,110 280,115 300,105 320,110 340,100" 
              fill="none" stroke="#e74a3b" stroke-width="2" stroke-dasharray="3,3"/>
              
    <!-- X-axis labels -->
    <text x="40" y="165" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">12:00</text>
    <text x="90" y="165" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">12:05</text>
    <text x="140" y="165" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">12:10</text>
    <text x="190" y="165" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">12:15</text>
    <text x="240" y="165" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">12:20</text>
    <text x="290" y="165" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">12:25</text>
    <text x="340" y="165" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">12:30</text>
    
    <!-- Y-axis labels -->
    <text x="35" y="150" font-family="Arial" font-size="8" fill="#858796" text-anchor="end">0MB/s</text>
    <text x="35" y="120" font-family="Arial" font-size="8" fill="#858796" text-anchor="end">10MB/s</text>
    <text x="35" y="90" font-family="Arial" font-size="8" fill="#858796" text-anchor="end">20MB/s</text>
    <text x="35" y="60" font-family="Arial" font-size="8" fill="#858796" text-anchor="end">30MB/s</text>
    
    <!-- Legend -->
    <rect x="200" y="70" width="10" height="5" fill="#4e73df"/>
    <text x="215" y="75" font-family="Arial" font-size="8" fill="#333333">Read</text>
    
    <line x1="250" y1="72" x2="260" y2="72" stroke="#e74a3b" stroke-width="2" stroke-dasharray="3,3"/>
    <text x="265" y="75" font-family="Arial" font-size="8" fill="#333333">Write</text>
  </g>
  
  <!-- Network I/O chart -->
  <g transform="translate(410, 280)">
    <rect width="370" height="180" rx="5" fill="#ffffff" stroke="#e3e6f0" stroke-width="1"/>
    <rect width="370" height="40" rx="5 5 0 0" fill="#f8f9fc" stroke="#e3e6f0" stroke-width="1"/>
    <text x="15" y="25" font-family="Arial" font-size="16" font-weight="bold" fill="#333333">Network I/O</text>
    
    <!-- Network chart -->
    <line x1="40" y1="150" x2="350" y2="150" stroke="#e3e6f0" stroke-width="1"/>
    <line x1="40" y1="50" x2="40" y2="150" stroke="#e3e6f0" stroke-width="1"/>
    
    <!-- Inbound line -->
    <polyline points="40,130 60,125 80,120 100,125 120,110 140,115 160,100 180,105 200,95 220,100 240,85 260,90 280,80 300,85 320,70 340,75" 
              fill="none" stroke="#36b9cc" stroke-width="2"/>
              
    <!-- Outbound line -->
    <polyline points="40,140 60,135 80,130 100,125 120,130 140,120 160,125 180,115 200,120 220,110 240,115 260,105 280,110 300,95 320,100 340,90" 
              fill="none" stroke="#f6c23e" stroke-width="2" stroke-dasharray="3,3"/>
              
    <!-- X-axis labels -->
    <text x="40" y="165" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">12:00</text>
    <text x="90" y="165" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">12:05</text>
    <text x="140" y="165" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">12:10</text>
    <text x="190" y="165" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">12:15</text>
    <text x="240" y="165" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">12:20</text>
    <text x="290" y="165" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">12:25</text>
    <text x="340" y="165" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">12:30</text>
    
    <!-- Y-axis labels -->
    <text x="35" y="150" font-family="Arial" font-size="8" fill="#858796" text-anchor="end">0MB/s</text>
    <text x="35" y="120" font-family="Arial" font-size="8" fill="#858796" text-anchor="end">10MB/s</text>
    <text x="35" y="90" font-family="Arial" font-size="8" fill="#858796" text-anchor="end">20MB/s</text>
    <text x="35" y="60" font-family="Arial" font-size="8" fill="#858796" text-anchor="end">30MB/s</text>
    
    <!-- Legend -->
    <rect x="200" y="70" width="10" height="5" fill="#36b9cc"/>
    <text x="215" y="75" font-family="Arial" font-size="8" fill="#333333">Inbound</text>
    
    <line x1="250" y1="72" x2="260" y2="72" stroke="#f6c23e" stroke-width="2" stroke-dasharray="3,3"/>
    <text x="265" y="75" font-family="Arial" font-size="8" fill="#333333">Outbound</text>
  </g>
</svg>
```


## 4. Network Map Section Screenshot (dashboard-network.svg)

```svg
<svg width="800" height="500" viewBox="0 0 800 500" xmlns="http://www.w3.org/2000/svg">
  <!-- Background -->
  <rect width="800" height="500" fill="#f8f9fc"/>
  
  <!-- Header -->
  <rect x="0" y="0" width="800" height="60" fill="#ffffff"/>
  <text x="20" y="35" font-family="Arial" font-size="20" font-weight="bold" fill="#333333">Network Map</text>
  
  <!-- Network Map Card -->
  <g transform="translate(20, 80)">
    <rect width="760" height="400" rx="5" fill="#ffffff" stroke="#e3e6f0" stroke-width="1"/>
    <rect width="760" height="40" rx="5 5 0 0" fill="#f8f9fc" stroke="#e3e6f0" stroke-width="1"/>
    <text x="15" y="25" font-family="Arial" font-size="16" font-weight="bold" fill="#333333">Decentralized Network Visualization</text>
    
    <!-- View toggle buttons -->
    <rect x="580" y="10" width="60" height="20" rx="3" fill="#4e73df"/>
    <text x="610" y="24" font-family="Arial" font-size="10" fill="#ffffff" text-anchor="middle">3D View</text>
    
    <rect x="645" y="10" width="60" height="20" rx="3" fill="#ffffff" stroke="#d1d3e2" stroke-width="1"/>
    <text x="675" y="24" font-family="Arial" font-size="10" fill="#333333" text-anchor="middle">2D View</text>
    
    <rect x="710" y="10" width="60" height="20" rx="3" fill="#ffffff" stroke="#d1d3e2" stroke-width="1"/>
    <text x="740" y="24" font-family="Arial" font-size="10" fill="#333333" text-anchor="middle">Geo Map</text>
    
    <!-- Network visualization area -->
    <rect x="10" y="50" width="740" height="340" fill="#181c30" rx="0 0 5 5"/>
    
    <!-- 3D Network visualization (simplified representation) -->
    <!-- Central server node -->
    <circle cx="380" cy="220" r="15" fill="#4e73df"/>
    <text x="380" y="224" font-family="Arial" font-size="8" fill="#ffffff" text-anchor="middle">Server 1</text>
    
    <!-- Gateway nodes -->
    <circle cx="200" cy="150" r="12" fill="#e74a3b"/>
    <text x="200" y="154" font-family="Arial" font-size="7" fill="#ffffff" text-anchor="middle">Gateway 1</text>
    
    <circle cx="560" cy="150" r="12" fill="#e74a3b"/>
    <text x="560" y="154" font-family="Arial" font-size="7" fill="#ffffff" text-anchor="middle">Gateway 2</text>
    
    <circle cx="200" cy="290" r="12" fill="#e74a3b"/>
    <text x="200" y="294" font-family="Arial" font-size="7" fill="#ffffff" text-anchor="middle">Gateway 3</text>
    
    <circle cx="560" cy="290" r="12" fill="#e74a3b"/>
    <text x="560" y="294" font-family="Arial" font-size="7" fill="#ffffff" text-anchor="middle">Gateway 4</text>
    
    <!-- Router nodes -->
    <circle cx="300" cy="100" r="10" fill="#f6c23e"/>
    <text x="300" y="104" font-family="Arial" font-size="6" fill="#ffffff" text-anchor="middle">Router 1</text>
    
    <circle cx="460" cy="100" r="10" fill="#f6c23e"/>
    <text x="460" y="104" font-family="Arial" font-size="6" fill="#ffffff" text-anchor="middle">Router 2</text>
    
    <circle cx="300" cy="340" r="10" fill="#f6c23e"/>
    <text x="300" y="344" font-family="Arial" font-size="6" fill="#ffffff" text-anchor="middle">Router 3</text>
    
    <circle cx="460" cy="340" r="10" fill="#f6c23e"/>
    <text x="460" y="344" font-family="Arial" font-size="6" fill="#ffffff" text-anchor="middle">Router 4</text>
    
    <!-- Client nodes -->
    <circle cx="100" cy="100" r="8" fill="#1cc88a"/>
    <circle cx="120" cy="130" r="8" fill="#1cc88a"/>
    <circle cx="140" cy="160" r="8" fill="#1cc88a"/>
    
    <circle cx="100" cy="340" r="8" fill="#1cc88a"/>
    <circle cx="120" cy="310" r="8" fill="#1cc88a"/>
    <circle cx="140" cy="280" r="8" fill="#1cc88a"/>
    
    <circle cx="660" cy="100" r="8" fill="#1cc88a"/>
    <circle cx="640" cy="130" r="8" fill="#1cc88a"/>
    <circle cx="620" cy="160" r="8" fill="#1cc88a"/>
    
    <circle cx="660" cy="340" r="8" fill="#1cc88a"/>
    <circle cx="640" cy="310" r="8" fill="#1cc88a"/>
    <circle cx="620" cy="280" r="8" fill="#1cc88a"/>
    
    <!-- Sensor nodes -->
    <circle cx="240" cy="70" r="5" fill="#36b9cc"/>
    <circle cx="260" cy="85" r="5" fill="#36b9cc"/>
    <circle cx="280" cy="65" r="5" fill="#36b9cc"/>
    
    <circle cx="520" cy="70" r="5" fill="#36b9cc"/>
    <circle cx="500" cy="85" r="5" fill="#36b9cc"/>
    <circle cx="480" cy="65" r="5" fill="#36b9cc"/>
    
    <circle cx="240" cy="370" r="5" fill="#36b9cc"/>
    <circle cx="260" cy="355" r="5" fill="#36b9cc"/>
    <circle cx="280" cy="375" r="5" fill="#36b9cc"/>
    
    <circle cx="520" cy="370" r="5" fill="#36b9cc"/>
    <circle cx="500" cy="355" r="5" fill="#36b9cc"/>
    <circle cx="480" cy="375" r="5" fill="#36b9cc"/>
    
    <!-- Connections -->
    <!-- Central server to gateways -->
    <line x1="380" y1="220" x2="200" y2="150" stroke="#4e73df" stroke-width="2" opacity="0.5"/>
    <line x1="380" y1="220" x2="560" y2="150" stroke="#4e73df" stroke-width="2" opacity="0.5"/>
    <line x1="380" y1="220" x2="200" y2="290" stroke="#4e73df" stroke-width="2" opacity="0.5"/>
    <line x1="380" y1="220" x2="560" y2="290" stroke="#4e73df" stroke-width="2" opacity="0.5"/>
    
    <!-- Gateways to routers -->
    <line x1="200" y1="150" x2="300" y2="100" stroke="#e74a3b" stroke-width="1.5" opacity="0.5"/>
    <line x1="560" y1="150" x2="460" y2="100" stroke="#e74a3b" stroke-width="1.5" opacity="0.5"/>
    <line x1="200" y1="290" x2="300" y2="340" stroke="#e74a3b" stroke-width="1.5" opacity="0.5"/>
    <line x1="560" y1="290" x2="460" y2="340" stroke="#e74a3b" stroke-width="1.5" opacity="0.5"/>
    
    <!-- Routers to clients -->
    <line x1="300" y1="100" x2="100" y2="100" stroke="#f6c23e" stroke-width="1" opacity="0.5"/>
    <line x1="300" y1="100" x2="120" y2="130" stroke="#f6c23e" stroke-width="1" opacity="0.5"/>
    <line x1="300" y1="100" x2="140" y2="160" stroke="#f6c23e" stroke-width="1" opacity="0.5"/>
    
    <line x1="460" y1="100" x2="660" y2="100" stroke="#f6c23e" stroke-width="1" opacity="0.5"/>
    <line x1="460" y1="100" x2="640" y2="130" stroke="#f6c23e" stroke-width="1" opacity="0.5"/>
    <line x1="460" y1="100" x2="620" y2="160" stroke="#f6c23e" stroke-width="1" opacity="0.5"/>
    
    <line x1="300" y1="340" x2="100" y2="340" stroke="#f6c23e" stroke-width="1" opacity="0.5"/>
    <line x1="300" y1="340" x2="120" y2="310" stroke="#f6c23e" stroke-width="1" opacity="0.5"/>
    <line x1="300" y1="340" x2="140" y2="280" stroke="#f6c23e" stroke-width="1" opacity="0.5"/>
    
    <line x1="460" y1="340" x2="660" y2="340" stroke="#f6c23e" stroke-width="1" opacity="0.5"/>
    <line x1="460" y1="340" x2="640" y2="310" stroke="#f6c23e" stroke-width="1" opacity="0.5"/>
    <line x1="460" y1="340" x2="620" y2="280" stroke="#f6c23e" stroke-width="1" opacity="0.5"/>
    
    <!-- Routers to sensors -->
    <line x1="300" y1="100" x2="240" y2="70" stroke="#f6c23e" stroke-width="0.5" opacity="0.5"/>
    <line x1="300" y1="100" x2="260" y2="85" stroke="#f6c23e" stroke-width="0.5" opacity="0.5"/>
    <line x1="300" y1="100" x2="280" y2="65" stroke="#f6c23e" stroke-width="0.5" opacity="0.5"/>
    
    <line x1="460" y1="100" x2="520" y2="70" stroke="#f6c23e" stroke-width="0.5" opacity="0.5"/>
    <line x1="460" y1="100" x2="500" y2="85" stroke="#f6c23e" stroke-width="0.5" opacity="0.5"/>
    <line x1="460" y1="100" x2="480" y2="65" stroke="#f6c23e" stroke-width="0.5" opacity="0.5"/>
    
    <line x1="300" y1="340" x2="240" y2="370" stroke="#f6c23e" stroke-width="0.5" opacity="0.5"/>
    <line x1="300" y1="340" x2="260" y2="355" stroke="#f6c23e" stroke-width="0.5" opacity="0.5"/>
    <line x1="300" y1="340" x2="280" y2="375" stroke="#f6c23e" stroke-width="0.5" opacity="0.5"/>
    
    <line x1="460" y1="340" x2="520" y2="370" stroke="#f6c23e" stroke-width="0.5" opacity="0.5"/>
    <line x1="460" y1="340" x2="500" y2="355" stroke="#f6c23e" stroke-width="0.5" opacity="0.5"/>
    <line x1="460" y1="340" x2="480" y2="375" stroke="#f6c23e" stroke-width="0.5" opacity="0.5"/>
    
    <!-- Highlighted node and its connections -->
    <circle cx="200" cy="150" r="14" fill="#f6c23e" stroke="#ffffff" stroke-width="1"/>
    <text x="200" y="154" font-family="Arial" font-size="7" fill="#ffffff" text-anchor="middle">Gateway 1</text>
    
    <line x1="200" y1="150" x2="380" y2="220" stroke="#f6c23e" stroke-width="2" opacity="0.8"/>
    <line x1="200" y1="150" x2="300" y2="100" stroke="#f6c23e" stroke-width="2" opacity="0.8"/>
    
    <!-- Node details panel -->
    <rect x="580" y="80" width="160" height="140" rx="3" fill="#ffffff" stroke="#e3e6f0" stroke-width="1"/>
    <rect x="580" y="80" width="160" height="30" rx="3 3 0 0" fill="#4e73df"/>
    <text x="590" y="100" font-family="Arial" font-size="14" fill="#ffffff">Gateway 1</text>
    <text x="725" y="100" font-family="Arial" font-size="14" fill="#ffffff">×</text>
    
    <text x="590" y="130" font-family="Arial" font-size="12" fill="#333333">Type: Gateway</text>
    <text x="590" y="150" font-family="Arial" font-size="12" fill="#333333">Status: Online</text>
    <text x="590" y="170" font-family="Arial" font-size="12" fill="#333333">Location: East Wing</text>
    <text x="590" y="190" font-family="Arial" font-size="12" fill="#333333">Connections: 2</text>
    <text x="590" y="210" font-family="Arial" font-size="12" fill="#333333">Last Seen: Just now</text>
  </g>
  
  <!-- Legend -->
  <g transform="translate(30, 430)">
    <circle cx="10" cy="10" r="6" fill="#4e73df"/>
    <text x="25" y="14" font-family="Arial" font-size="12" fill="#333333">Server</text>
    
    <circle cx="85" cy="10" r="6" fill="#e74a3b"/>
    <text x="100" y="14" font-family="Arial" font-size="12" fill="#333333">Gateway</text>
    
    <circle cx="160" cy="10" r="6" fill="#f6c23e"/>
    <text x="175" y="14" font-family="Arial" font-size="12" fill="#333333">Router</text>
    
    <circle cx="235" cy="10" r="6" fill="#1cc88a"/>
    <text x="250" y="14" font-family="Arial" font-size="12" fill="#333333">Client</text>
    
    <circle cx="310" cy="10" r="6" fill="#36b9cc"/>
    <text x="325" y="14" font-family="Arial" font-size="12" fill="#333333">Sensor</text>
  </g>
</svg>
```


## 5. Worker Threads Section Screenshot (dashboard-workers.svg)

```svg
<svg width="800" height="600" viewBox="0 0 800 600" xmlns="http://www.w3.org/2000/svg">
  <!-- Background -->
  <rect width="800" height="600" fill="#f8f9fc"/>
  
  <!-- Header -->
  <rect x="0" y="0" width="800" height="60" fill="#ffffff"/>
  <text x="20" y="35" font-family="Arial" font-size="20" font-weight="bold" fill="#333333">Worker Threads</text>
  
  <!-- Worker Activity Chart -->
  <g transform="translate(20, 80)">
    <rect width="520" height="200" rx="5" fill="#ffffff" stroke="#e3e6f0" stroke-width="1"/>
    <rect width="520" height="40" rx="5 5 0 0" fill="#f8f9fc" stroke="#e3e6f0" stroke-width="1"/>
    <text x="15" y="25" font-family="Arial" font-size="16" font-weight="bold" fill="#333333">Worker Activity</text>
    
    <!-- Chart -->
    <line x1="40" y1="170" x2="500" y2="170" stroke="#e3e6f0" stroke-width="1"/>
    <line x1="40" y1="60" x2="40" y2="170" stroke="#e3e6f0" stroke-width="1"/>
    
    <!-- Active workers area -->
    <path d="M40,120 60,110 80,100 100,110 120,100 140,90 160,100 180,90 200,80 220,90 240,80 260,70 280,80 300,70 320,80 340,70 360,60 380,70 400,80 420,70 440,80 460,70 480,80 500,70 L500,170 40,170 Z" 
          fill="#4e73df" opacity="0.5"/>
    <polyline points="40,120 60,110 80,100 100,110 120,100 140,90 160,100 180,90 200,80 220,90 240,80 260,70 280,80 300,70 320,80 340,70 360,60 380,70 400,80 420,70 440,80 460,70 480,80 500,70" 
              fill="none" stroke="#4e73df" stroke-width="2"/>
    
    <!-- Tasks line -->
    <polyline points="40,150 60,140 80,150 100,140 120,130 140,140 160,130 180,120 200,130 220,120 240,110 260,120 280,110 300,100 320,110 340,100 360,90 380,100 400,110 420,100 440,110 460,100 480,110 500,100" 
              fill="none" stroke="#1cc88a" stroke-width="2" stroke-dasharray="3,3"/>
    
    <!-- Idle workers line -->
    <polyline points="40,160 60,160 80,155 100,160 120,155 140,160 160,155 180,160 200,155 220,160 240,155 260,160 280,155 300,160 320,155 340,160 360,155 380,160 400,155 420,160 440,155 460,160 480,155 500,160" 
              fill="none" stroke="#f6c23e" stroke-width="2"/>
              
    <!-- X-axis labels -->
    <text x="40" y="185" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">00:00</text>
    <text x="100" y="185" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">01:00</text>
    <text x="160" y="185" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">02:00</text>
    <text x="220" y="185" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">03:00</text>
    <text x="280" y="185" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">04:00</text>
    <text x="340" y="185" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">05:00</text>
    <text x="400" y="185" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">06:00</text>
    <text x="460" y="185" font-family="Arial" font-size="8" fill="#858796" text-anchor="middle">07:00</text>
    
    <!-- Y-axis labels -->
    <text x="35" y="170" font-family="Arial" font-size="8" fill="#858796" text-anchor="end">0</text>
    <text x="35" y="140" font-family="Arial" font-size="8" fill="#858796" text-anchor="end">5</text>
    <text x="35" y="110" font-family="Arial" font-size="8" fill="#858796" text-anchor="end">10</text>
    <text x="35" y="80" font-family="Arial" font-size="8" fill="#858796" text-anchor="end">15</text>
    
    <!-- Legend -->
    <rect x="300" y="70" width="10" height="5" fill="#4e73df"/>
    <text x="315" y="75" font-family="Arial" font-size="8" fill="#333333">Active Workers</text>
    
    <line x1="380" y1="72" x2="390" y2="72" stroke="#1cc88a" stroke-width="2" stroke-dasharray="3,3"/>
    <text x="395" y="75" font-family="Arial" font-size="8" fill="#333333">Tasks (÷10)</text>
    
    <rect x="450" y="70" width="10" height="5" fill="#f6c23e"/>
    <text x="465" y="75" font-family="Arial" font-size="8" fill="#333333">Idle Workers</text>
  </g>
  
  <!-- Worker Status Chart -->
  <g transform="translate(560, 80)">
    <rect width="220" height="200" rx="5" fill="#ffffff" stroke="#e3e6f0" stroke-width="1"/>
    <rect width="220" height="40" rx="5 5 0 0" fill="#f8f9fc" stroke="#e3e6f0" stroke-width="1"/>
    <text x="15" y="25" font-family="Arial" font-size="16" font-weight="bold" fill="#333333">Worker Status</text>
    
    <!-- Donut chart -->
    <circle cx="110" cy="120" r="60" fill="#ffffff"/>
    <!-- Active workers (green) -->
    <path d="M110,120 L110,60 A60,60 0 0,1 167.2,140 z" fill="#1cc88a"/>
    <!-- Idle workers (yellow) -->
    <path d="M110,120 L167.2,140 A60,60 0 0,1 100,180 z" fill="#f6c23e"/>
    <!-- Terminated workers (red) -->
    <path d="M110,120 L100,180 A60,60 0 0,1 100,60 z" fill="#e74a3b" opacity="0.6"/>
    <path d="M110,120 L100,60 A60,60 0 0,1 110,60 z" fill="#e74a3b" opacity="0.6"/>
    
    <!-- Inner circle for donut -->
    <circle cx="110" cy="120" r="40" fill="#ffffff"/>
    <text x="110" y="125" font-family="Arial" font-size="18" font-weight="bold" fill="#333333" text-anchor="middle">16</text>
    
    <!-- Legend -->
    <rect x="15" y="180" width="10" height="10" fill="#1cc88a"/>
    <text x="30" y="189" font-family="Arial" font-size="10" fill="#333333">Active (12)</text>
    
    <rect x="95" y="180" width="10" height="10" fill="#f6c23e"/>
    <text x="110" y="189" font-family="Arial" font-size="10" fill="#333333">Idle (3)</text>
    
    <rect x="160" y="180" width="10" height="10" fill="#e74a3b"/>
    <text x="175" y="189" font-family="Arial" font-size="10" fill="#333333">Terminated (1)</text>
  </g>
  
  <!-- Worker Threads Table -->
  <g transform="translate(20, 300)">
    <rect width="760" height="280" rx="5" fill="#ffffff" stroke="#e3e6f0" stroke-width="1"/>
    <rect width="760" height="40" rx="5 5 0 0" fill="#f8f9fc" stroke="#e3e6f0" stroke-width="1"/>
    <text x="15" y="25" font-family="Arial" font-size="16" font-weight="bold" fill="#333333">Worker Threads</text>
    
    <!-- Search box -->
    <rect x="580" y="10" width="160" height="20" rx="3" fill="#ffffff" stroke="#d1d3e2" stroke-width="1"/>
    <text x="590" y="24" font-family="Arial" font-size="10" fill="#858796">Filter workers...</text>
    
    <!-- Table header -->
    <rect x="10" y="50" width="740" height="30" fill="#f8f9fc"/>
    <text x="20" y="70" font-family="Arial" font-size="12" font-weight="bold" fill="#333333">ID</text>
    <text x="120" y="70" font-family="Arial" font-size="12" font-weight="bold" fill="#333333">Status</text>
    <text x="200" y="70" font-family="Arial" font-size="12" font-weight="bold" fill="#333333">Type</text>
    <text x="280" y="70" font-family="Arial" font-size="12" font-weight="bold" fill="#333333">CPU</text>
    <text x="340" y="70" font-family="Arial" font-size="12" font-weight="bold" fill="#333333">Memory</text>
    <text x="420" y="70" font-family="Arial" font-size="12" font-weight="bold" fill="#333333">Tasks Completed</text>
    <text x="540" y="70" font-family="Arial" font-size="12" font-weight="bold" fill="#333333">Uptime</text>
    <text x="640" y="70" font-family="Arial" font-size="12" font-weight="bold" fill="#333333">Actions</text>
    <line x1="10" y1="80" x2="750" y2="80" stroke="#e3e6f0" stroke-width="1"/>
    
    <!-- Table rows -->
    <!-- Row 1 -->
    <rect x="10" y="80" width="740" height="30" fill="#ffffff"/>
    <text x="20" y="100" font-family="Arial" font-size="12" fill="#333333">worker-1</text>
    <text x="120" y="100" font-family="Arial" font-size="12" fill="#1cc88a">active</text>
    <text x="200" y="100" font-family="Arial" font-size="12" fill="#333333">processor</text>
    <text x="280" y="100" font-family="Arial" font-size="12" fill="#333333">65%</text>
    <text x="340" y="100" font-family="Arial" font-size="12" fill="#333333">42%</text>
    <text x="420" y="100" font-family="Arial" font-size="12" fill="#333333">523</text>
    <text x="540" y="100" font-family="Arial" font-size="12" fill="#333333">3h 45m</text>
    
    <!-- Action buttons -->
    <rect x="640" y="85" width="25" height="20" rx="3" fill="#ffffff" stroke="#4e73df" stroke-width="1"/>
    <text x="652" y="99" font-family="Arial" font-size="10" fill="#4e73df" text-anchor="middle">↻</text>
    
    <rect x="670" y="85" width="25" height="20" rx="3" fill="#ffffff" stroke="#e74a3b" stroke-width="1"/>
    <text x="682" y="99" font-family="Arial" font-size="10" fill="#e74a3b" text-anchor="middle">×</text>
    
    <line x1="10" y1="110" x2="750" y2="110" stroke="#e3e6f0" stroke-width="1"/>
    
    <!-- Row 2 -->
    <rect x="10" y="110" width="740" height="30" fill="#ffffff"/>
    <text x="20" y="130" font-family="Arial" font-size="12" fill="#333333">worker-2</text>
    <text x="120" y="130" font-family="Arial" font-size="12" fill="#1cc88a">active</text>
    <text x="200" y="130" font-family="Arial" font-size="12" fill="#333333">analyzer</text>
    <text x="280" y="130" font-family="Arial" font-size="12" fill="#333333">78%</text>
    <text x="340" y="130" font-family="Arial" font-size="12" fill="#333333">55%</text>
    <text x="420" y="130" font-family="Arial" font-size="12" fill="#333333">341</text>
    <text x="540" y="130" font-family="Arial" font-size="12" fill="#333333">2h 20m</text>
    
    <!-- Action buttons -->
    <rect x="640" y="115" width="25" height="20" rx="3" fill="#ffffff" stroke="#4e73df" stroke-width="1"/>
    <text x="652" y="129" font-family="Arial" font-size="10" fill="#4e73df" text-anchor="middle">↻</text>
    
    <rect x="670" y="115" width="25" height="20" rx="3" fill="#ffffff" stroke="#e74a3b" stroke-width="1"/>
    <text x="682" y="129" font-family="Arial" font-size="10" fill="#e74a3b" text-anchor="middle">×</text>
    
    <line x1="10" y1="140" x2="750" y2="140" stroke="#e3e6f0" stroke-width="1"/>
    
    <!-- Row 3 -->
    <rect x="10" y="140" width="740" height="30" fill="#f8f9fc"/>
    <text x="20" y="160" font-family="Arial" font-size="12" fill="#333333">worker-3</text>
    <text x="120" y="160" font-family="Arial" font-size="12" fill="#f6c23e">idle</text>
    <text x="200" y="160" font-family="Arial" font-size="12" fill="#333333">connector</text>
    <text x="280" y="160" font-family="Arial" font-size="12" fill="#333333">-</text>
    <text x="340" y="160" font-family="Arial" font-size="12" fill="#333333">-</text>
    <text x="420" y="160" font-family="Arial" font-size="12" fill="#333333">189</text>
    <text x="540" y="160" font-family="Arial" font-size="12" fill="#333333">4h 10m</text>
    
    <!-- Action buttons -->
    <rect x="640" y="145" width="25" height="20" rx="3" fill="#ffffff" stroke="#4e73df" stroke-width="1"/>
    <text x="652" y="159" font-family="Arial" font-size="10" fill="#4e73df" text-anchor="middle">↻</text>
    
    <rect x="670" y="145" width="25" height="20" rx="3" fill="#ffffff" stroke="#e74a3b" stroke-width="1"/>
    <text x="682" y="159" font-family="Arial" font-size="10" fill="#e74a3b" text-anchor="middle">×</text>
    
    <line x1="10" y1="170" x2="750" y2="170" stroke="#e3e6f0" stroke-width="1"/>
    
    <!-- Row 4 -->
    <rect x="10" y="170" width="740" height="30" fill="#ffffff"/>
    <text x="20" y="190" font-family="Arial" font-size="12" fill="#333333">worker-4</text>
    <text x="120" y="190" font-family="Arial" font-size="12" fill="#1cc88a">active</text>
    <text x="200" y="190" font-family="Arial" font-size="12" fill="#333333">processor</text>
    <text x="280" y="190" font-family="Arial" font-size="12" fill="#333333">42%</text>
    <text x="340" y="190" font-family="Arial" font-size="12" fill="#333333">38%</text>
    <text x="420" y="190" font-family="Arial" font-size="12" fill="#333333">612</text>
    <text x="540" y="190" font-family="Arial" font-size="12" fill="#333333">6h 15m</text>
    
    <!-- Action buttons -->
    <rect x="640" y="175" width="25" height="20" rx="3" fill="#ffffff" stroke="#4e73df" stroke-width="1"/>
    <text x="652" y="189" font-family="Arial" font-size="10" fill="#4e73df" text-anchor="middle">↻</text>
    
    <rect x="670" y="175" width="25" height="20" rx="3" fill="#ffffff" stroke="#e74a3b" stroke-width="1"/>
    <text x="682" y="189" font-family="Arial" font-size="10" fill="#e74a3b" text-anchor="middle">×</text>
    
    <line x1="10" y1="200" x2="750" y2="200" stroke="#e3e6f0" stroke-width="1"/>
    
    <!-- Row 5 -->
    <rect x="10" y="200" width="740" height="30" fill="#f8f9fc"/>
    <text x="20" y="220" font-family="Arial" font-size="12" fill="#333333">worker-5</text>
    <text x="120" y="220" font-family="Arial" font-size="12" fill="#e74a3b">terminated</text>
    <text x="200" y="220" font-family="Arial" font-size="12" fill="#333333">scheduler</text>
    <text x="280" y="220" font-family="Arial" font-size="12" fill="#333333">-</text>
    <text x="340" y="220" font-family="Arial" font-size="12" fill="#333333">-</text>
    <text x="420" y="220" font-family="Arial" font-size="12" fill="#333333">72</text>
    <text x="540" y="220" font-family="Arial" font-size="12" fill="#333333">-</text>
    
    <!-- Action button -->
    <rect x="640" y="205" width="40" height="20" rx="3" fill="#ffffff" stroke="#1cc88a" stroke-width="1"/>
    <text x="660" y="219" font-family="Arial" font-size="10" fill="#1cc88a" text-anchor="middle">Start</text>
    
    <line x1="10" y1="230" x2="750" y2="230" stroke="#e3e6f0" stroke-width="1"/>
    
    <!-- Pagination -->
    <text x="20" y="260" font-family="Arial" font-size="12" fill="#858796">Showing 1 to 5 of 16 entries</text>
    
    <rect x="600" y="245" width="30" height="25" rx="3" fill="#ffffff" stroke="#4e73df" stroke-width="1"/>
    <text x="615" y="262" font-family="Arial" font-size="12" fill="#4e73df" text-anchor="middle">1</text>
    
    <rect x="635" y="245" width="30" height="25" rx="3" fill="#f8f9fc" stroke="#d1d3e2" stroke-width="1"/>
    <text x="650" y="262" font-family="Arial" font-size="12" fill="#858796" text-anchor="middle">2</text>
    
    <rect x="670" y="245" width="30" height="25" rx="3" fill="#f8f9fc" stroke="#d1d3e2" stroke-width="1"/>
    <text x="685" y="262" font-family="Arial" font-size="12" fill="#858796" text-anchor="middle">3</text>
    
    <rect x="705" y="245" width="30" height="25" rx="3" fill="#f8f9fc" stroke="#d1d3e2" stroke-width="1"/>
    <text x="720" y="262" font-family="Arial" font-size="12" fill="#858796" text-anchor="middle">4</text>
  </g>
</svg>
```


## 6. Alerts Section Screenshot (dashboard-alerts.svg)

```svg
<svg width="800" height="400" viewBox="0 0 800 400" xmlns="http://www.w3.org/2000/svg">
  <!-- Background -->
  <rect width="800" height="400" fill="#f8f9fc"/>
  
  <!-- Header -->
  <rect x="0" y="0" width="800" height="60" fill="#ffffff"/>
  <text x="20" y="35" font-family="Arial" font-size="20" font-weight="bold" fill="#333333">System Alerts</text>
  
  <!-- Alerts Table -->
  <g transform="translate(20, 80)">
    <rect width="760" height="300" rx="5" fill="#ffffff" stroke="#e3e6f0" stroke-width="1"/>
    <rect width="760" height="40" rx="5 5 0 0" fill="#f8f9fc" stroke="#e3e6f0" stroke-width="1"/>
    <text x="15" y="25" font-family="Arial" font-size="16" font-weight="bold" fill="#333333">Active Alerts</text>
    
    <!-- Filter controls -->
    <rect x="500" y="10" width="120" height="20" rx="3" fill="#ffffff" stroke="#d1d3e2" stroke-width="1"/>
    <text x="510" y="24" font-family="Arial" font-size="10" fill="#333333">All Severities</text>
    <text x="605" y="24" font-family="Arial" font-size="10" fill="#333333">▼</text>
    
    <rect x="630" y="10" width="120" height="20" rx="3" fill="#ffffff" stroke="#d1d3e2" stroke-width="1"/>
    <text x="640" y="24" font-family="Arial" font-size="10" fill="#858796">Filter alerts...</text>
    
    <!-- Table header -->
    <rect x="10" y="50" width="740" height="30" fill="#f8f9fc"/>
    <text x="25" y="70" font-family="Arial" font-size="12" font-weight="bold" fill="#333333">Severity</text>
    <text x="110" y="70" font-family="Arial" font-size="12" font-weight="bold" fill="#333333">Status</text>
    <text x="200" y="70" font-family="Arial" font-size="12" font-weight="bold" fill="#333333">Time</text>
    <text x="290" y="70" font-family="Arial" font-size="12" font-weight="bold" fill="#333333">Message</text>
    <text x="500" y="70" font-family="Arial" font-size="12" font-weight="bold" fill="#333333">Source</text>
    <text x="580" y="70" font-family="Arial" font-size="12" font-weight="bold" fill="#333333">Duration</text>
    <text x="670" y="70" font-family="Arial" font-size="12" font-weight="bold" fill="#333333">Actions</text>
    <line x1="10" y1="80" x2="750" y2="80" stroke="#e3e6f0" stroke-width="1"/>
    
    <!-- Table rows -->
    <!-- Row 1 -->
    <rect x="10" y="80" width="740" height="40" fill="#ffffff"/>
    <circle cx="20" cy="100" r="4" fill="#e74a3b"/>
    <text x="30" y="104" font-family="Arial" font-size="12" fill="#333333">Critical</text>
    
    <rect x="110" y="90" width="70" height="20" rx="10" fill="#e74a3b" opacity="0.8"/>
    <text x="145" y="104" font-family="Arial" font-size="10" fill="#ffffff" text-anchor="middle">Active</text>
    
    <text x="200" y="104" font-family="Arial" font-size="12" fill="#333333">12:34 PM</text>
    <text x="290" y="104" font-family="Arial" font-size="12" fill="#333333">High CPU usage detected on Server-01</text>
    <text x="500" y="104" font-family="Arial" font-size="12" fill="#333333">system</text>
    <text x="580" y="104" font-family="Arial" font-size="12" fill="#333333">10m 23s</text>
    
    <!-- Action buttons -->
    <rect x="650" y="90" width="25" height="20" rx="3" fill="#ffffff" stroke="#f6c23e" stroke-width="1"/>
    <text x="662" y="104" font-family="Arial" font-size="10" fill="#f6c23e" text-anchor="middle">✓</text>
    
    <rect x="680" y="90" width="25" height="20" rx="3" fill="#ffffff" stroke="#1cc88a" stroke-width="1"/>
    <text x="692" y="104" font-family="Arial" font-size="10" fill="#1cc88a" text-anchor="middle">✓✓</text>
    
    <rect x="710" y="90" width="25" height="20" rx="3" fill="#ffffff" stroke="#4e73df" stroke-width="1"/>
    <text x="722" y="104" font-family="Arial" font-size="10" fill="#4e73df" text-anchor="middle">ⓘ</text>
    
    <line x1="10" y1="120" x2="750" y2="120" stroke="#e3e6f0" stroke-width="1"/>
    
    <!-- Row 2 -->
    <rect x="10" y="120" width="740" height="40" fill="#f8f9fc"/>
    <circle cx="20" cy="140" r="4" fill="#f6c23e"/>
    <text x="30" y="144" font-family="Arial" font-size="12" fill="#333333">Warning</text>
    
    <rect x="110" y="130" width="70" height="20" rx="10" fill="#e74a3b" opacity="0.8"/>
    <text x="145" y="144" font-family="Arial" font-size="10" fill="#ffffff" text-anchor="middle">Active</text>
    
    <text x="200" y="144" font-family="Arial" font-size="12" fill="#333333">12:22 PM</text>
    <text x="290" y="144" font-family="Arial" font-size="12" fill="#333333">Database connection pool reaching limit</text>
    <text x="500" y="144" font-family="Arial" font-size="12" fill="#333333">database</text>
    <text x="580" y="144" font-family="Arial" font-size="12" fill="#333333">22m 45s</text>
    
    <!-- Action buttons -->
    <rect x="650" y="130" width="25" height="20" rx="3" fill="#ffffff" stroke="#f6c23e" stroke-width="1"/>
    <text x="662" y="144" font-family="Arial" font-size="10" fill="#f6c23e" text-anchor="middle">✓</text>
    
    <rect x="680" y="130" width="25" height="20" rx="3" fill="#ffffff" stroke="#1cc88a" stroke-width="1"/>
    <text x="692" y="144" font-family="Arial" font-size="10" fill="#1cc88a" text-anchor="middle">✓✓</text>
    
    <rect x="710" y="130" width="25" height="20" rx="3" fill="#ffffff" stroke="#4e73df" stroke-width="1"/>
    <text x="722" y="144" font-family="Arial" font-size="10" fill="#4e73df" text-anchor="middle">ⓘ</text>
    
    <line x1="10" y1="160" x2="750" y2="160" stroke="#e3e6f0" stroke-width="1"/>
    
    <!-- Row 3 -->
    <rect x="10" y="160" width="740" height="40" fill="#ffffff"/>
    <circle cx="20" cy="180" r="4" fill="#36b9cc"/>
    <text x="30" y="184" font-family="Arial" font-size="12" fill="#333333">Info</text>
    
    <rect x="110" y="170" width="70" height="20" rx="10" fill="#f6c23e" opacity="0.8"/>
    <text x="145" y="184" font-family="Arial" font-size="10" fill="#ffffff" text-anchor="middle">Acknowledged</text>
    
    <text x="200" y="184" font-family="Arial" font-size="12" fill="#333333">12:10 PM</text>
    <text x="290" y="184" font-family="Arial" font-size="12" fill="#333333">Worker thread reconnection successful</text>
    <text x="500" y="184" font-family="Arial" font-size="12" fill="#333333">worker</text>
    <text x="580" y="184" font-family="Arial" font-size="12" fill="#333333">34m 12s</text>
    
    <!-- Action buttons -->
    <rect x="680" y="170" width="25" height="20" rx="3" fill="#ffffff" stroke="#1cc88a" stroke-width="1"/>
    <text x="692" y="184" font-family="Arial" font-size="10" fill="#1cc88a" text-anchor="middle">✓✓</text>
    
    <rect x="710" y="170" width="25" height="20" rx="3" fill="#ffffff" stroke="#4e73df" stroke-width="1"/>
    <text x="722" y="184" font-family="Arial" font-size="10" fill="#4e73df" text-anchor="middle">ⓘ</text>
    
    <line x1="10" y1="200" x2="750" y2="200" stroke="#e3e6f0" stroke-width="1"/>
    
    <!-- Row 4 -->
    <rect x="10" y="200" width="740" height="40" fill="#f8f9fc"/>
    <circle cx="20" cy="220" r="4" fill="#f6c23e"/>
    <text x="30" y="224" font-family="Arial" font-size="12" fill="#333333">Warning</text>
    
    <rect x="110" y="210" width="70" height="20" rx="10" fill="#1cc88a" opacity="0.8"/>
    <text x="145" y="224" font-family="Arial" font-size="10" fill="#ffffff" text-anchor="middle">Resolved</text>
    
    <text x="200" y="224" font-family="Arial" font-size="12" fill="#333333">11:45 AM</text>
    <text x="290" y="224" font-family="Arial" font-size="12" fill="#333333">Network latency above threshold</text>
    <text x="500" y="224" font-family="Arial" font-size="12" fill="#333333">network</text>
    <text x="580" y="224" font-family="Arial" font-size="12" fill="#333333">15m 33s</text>
    
    <!-- Action button -->
    <rect x="710" y="210" width="25" height="20" rx="3" fill="#ffffff" stroke="#4e73df" stroke-width="1"/>
    <text x="722" y="224" font-family="Arial" font-size="10" fill="#4e73df" text-anchor="middle">ⓘ</text>
    
    <line x1="10" y1="240" x2="750" y2="240" stroke="#e3e6f0" stroke-width="1"/>
    
    <!-- Row 5 -->
    <rect x="10" y="240" width="740" height="40" fill="#ffffff"/>
    <circle cx="20" cy="260" r="4" fill="#e74a3b"/>
    <text x="30" y="264" font-family="Arial" font-size="12" fill="#333333">Critical</text>
    
    <rect x="110" y="250" width="70" height="20" rx="10" fill="#1cc88a" opacity="0.8"/>
    <text x="145" y="264" font-family="Arial" font-size="10" fill="#ffffff" text-anchor="middle">Resolved</text>
    
    <text x="200" y="264" font-family="Arial" font-size="12" fill="#333333">11:20 AM</text>
    <text x="290" y="264" font-family="Arial" font-size="12" fill="#333333">Gateway-3 connection lost</text>
    <text x="500" y="264" font-family="Arial" font-size="12" fill="#333333">network</text>
    <text x="580" y="264" font-family="Arial" font-size="12" fill="#333333">8m 45s</text>
    
    <!-- Action button -->
    <rect x="710" y="250" width="25" height="20" rx="3" fill="#ffffff" stroke="#4e73df" stroke-width="1"/>
    <text x="722" y="264" font-family="Arial" font-size="10" fill="#4e73df" text-anchor="middle">ⓘ</text>
    
    <line x1="10" y1="280" x2="750" y2="280" stroke="#e3e6f0" stroke-width="1"/>
    
    <!-- Pagination -->
    <text x="20" y="310" font-family="Arial" font-size="12" fill="#858796">Showing 1 to 5 of 12 entries</text>
    
    <rect x="600" y="295" width="30" height="25" rx="3" fill="#ffffff" stroke="#4e73df" stroke-width="1"/>
    <text x="615" y="312" font-family="Arial" font-size="12" fill="#4e73df" text-anchor="middle">1</text>
    
    <rect x="635" y="295" width="30" height="25" rx="3" fill="#f8f9fc" stroke="#d1d3e2" stroke-width="1"/>
    <text x="650" y="312" font-family="Arial" font-size="12" fill="#858796" text-anchor="middle">2</text>
    
    <rect x="670" y="295" width="30" height="25" rx="3" fill="#f8f9fc" stroke="#d1d3e2" stroke-width="1"/>
    <text x="685" y="312" font-family="Arial" font-size="12" fill="#858796" text-anchor="middle">3</text>
  </g>
  
  <!-- Alert Details Modal -->
  <g transform="translate(300, 100)">
    <rect width="400" height="250" rx="5" fill="#ffffff" stroke="#e3e6f0" stroke-width="2" filter="drop-shadow(0 0 10px rgba(0,0,0,0.2))"/>
    
    <!-- Modal header -->
    <rect width="400" height="40" rx="5 5 0 0" fill="#4e73df"/>
    <text x="15" y="25" font-family="Arial" font-size="16" font-weight="bold" fill="#ffffff">Alert Details: alert-1</text>
    <text x="385" y="25" font-family="Arial" font-size="18" font-weight="bold" fill="#ffffff">×</text>
    
    <!-- Modal body -->
    <rect x="15" y="50" width="370" height="40" rx="3" fill="#e74a3b" opacity="0.2"/>
    <text x="25" y="75" font-family="Arial" font-size="14" font-weight="bold" fill="#e74a3b">Severity: Critical</text>
    
    <text x="15" y="105" font-family="Arial" font-size="14" fill="#333333"><tspan font-weight="bold">Status:</tspan> Active</text>
    <text x="15" y="130" font-family="Arial" font-size="14" fill="#333333"><tspan font-weight="bold">Time:</tspan> 12:34 PM, Sep 17, 2025</text>
    <text x="15" y="155" font-family="Arial" font-size="14" fill="#333333"><tspan font-weight="bold">Source:</tspan> system</text>
    <text x="15" y="180" font-family="Arial" font-size="14" fill="#333333"><tspan font-weight="bold">Message:</tspan> High CPU usage detected on Server-01</text>
    <text x="15" y="205" font-family="Arial" font-size="14" fill="#333333"><tspan font-weight="bold">Duration:</tspan> 10m 23s</text>
    
    <!-- Modal footer -->
    <line x1="0" y1="220" x2="400" y2="220" stroke="#e3e6f0" stroke-width="1"/>
    
    <rect x="240" y="230" width="70" height="30" rx="3" fill="#f8f9fc" stroke="#d1d3e2" stroke-width="1"/>
    <text x="275" y="250" font-family="Arial" font-size="12" fill="#858796" text-anchor="middle">Close</text>
    
    <rect x="320" y="230" width="70" height="30" rx="3" fill="#1cc88a"/>
    <text x="355" y="250" font-family="Arial" font-size="12" fill="#ffffff" text-anchor="middle">Resolve</text>
  </g>
</svg>
```


These SVG graphics provide a comprehensive visual representation of the various sections of the IQSMS Monitoring Dashboard. Each image is designed to illustrate the features and functionality described in the Dashboard How-To guide, making it easier for users to understand how to use the dashboard effectively.

To include these graphics in your documentation, you'll need to save each SVG file with the appropriate filename in the `/docs/images/` directory. Then the `<img src="../../images/dashboard-screenshot.png">` tags in your HTML will correctly reference these images.