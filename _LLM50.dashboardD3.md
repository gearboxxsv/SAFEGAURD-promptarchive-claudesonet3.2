# Creating a Monitoring Dashboard with D3.js

I'll help you create an innovative monitoring dashboard using D3.js that integrates with your IQSMS system. This dashboard will visualize monitoring data in real-time, with fallback mechanisms for reliability.

## Plan Overview

1. Create the dashboard HTML/CSS/JS structure
2. Set up server-side components for data provision
3. Create the necessary documentation
4. Update navigation on the main page

Let's start by exploring the project structure to better understand what we're working with.Based on my analysis of the project requirements and available resources, I'll create a comprehensive monitoring dashboard using D3.js with an optional Three.js component. Let's start by developing a plan for our implementation.

# Monitoring Dashboard Implementation Plan

I'll create a modern, interactive dashboard for the IQSMS system that visualizes monitoring data. Here's my approach:

## 1. Create the Dashboard Files

First, let's create a new monitoring dashboard HTML file and associated JavaScript files:Now I'll create a comprehensive monitoring dashboard using D3.js and Three.js. Let's start by planning the implementation:

# Comprehensive Monitoring Dashboard Implementation Plan

I'll create a monitoring dashboard that utilizes D3.js for data visualization and Three.js for 3D geographic and network visualization. The system will include:

1. Create the dashboard HTML page with interactive visualization components
2. Implement a server-side component to provide data to the dashboard
3. Create a documentation page for the dashboard
4. Update the main documentation index to include navigation to the new dashboard

Let's start with implementation:I'll now create a comprehensive monitoring dashboard implementation plan based on your requirements, using d3.js and three.js to build an innovative visualization system.

# IQSMS Monitoring Dashboard Implementation

Based on the existing IQSMS documentation and monitoring architecture, I'll design a d3.js-powered dashboard with three.js integration for advanced visualizations.

## 1. Dashboard Structure

Let's start by creating the main dashboard HTML file:

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>IQSMS Monitoring Dashboard</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="../css/styles.css">
  <link rel="stylesheet" href="css/dashboard.css">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.1/css/all.css">
  <script src="https://d3js.org/d3.v7.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/three@0.180.0/build/three.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/socket.io-client@4.7.2/dist/socket.io.min.js"></script>
</head>
<body>
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
      <a class="navbar-brand" href="../index.html">
        IQSMS Monitoring
      </a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item">
            <a class="nav-link" href="../index.html">Home</a>
          </li>
          <li class="nav-item active">
            <a class="nav-link" href="#dashboard">Dashboard</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#system">System</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#protocols">Protocols</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#workers">Workers</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#network">Network</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#alerts">Alerts</a>
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
  <script src="js/charts/gauges.js"></script>
  <script src="js/charts/performance.js"></script>
  <script src="js/charts/network-map.js"></script>
  <script src="js/charts/worker-charts.js"></script>
  <script src="js/data-manager.js"></script>
  <script src="js/socket-manager.js"></script>
</body>
</html>
```


## 2. Dashboard CSS

Now let's create the custom CSS for the dashboard:

```css
/* Dashboard Styles */
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
}

/* Animation for charts */
.chart-container svg {
  transition: all 0.3s ease;
}

/* 3D Network Map */
.network-container canvas {
  border-radius: 0 0 8px 8px;
}
```


## 3. Dashboard JavaScript Core

Here's the main dashboard JavaScript file:

```javascript
/**
 * IQSMS Monitoring Dashboard
 * Main JavaScript file to initialize the dashboard and manage component interactions
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
  const dataManager = new DataManager();
  
  // Initialize socket connection
  const socketManager = new SocketManager({
    url: window.location.origin,
    onConnect: handleSocketConnect,
    onDisconnect: handleSocketDisconnect,
    onError: handleSocketError,
    onMetricsUpdate: (data) => dataManager.updateMetrics(data)
  });
  
  // Initialize charts
  initializeGaugeCharts();
  initializePerformanceChart();
  initializeNetworkMap();
  initializeWorkerCharts();
  
  // Update UI with initial data
  dataManager.loadInitialData().then(updateDashboardUI);
  
  // Set up event listeners
  setupEventListeners();
  
  // Set up auto-refresh
  setupAutoRefresh();
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
  // Time range selector
  const timeRangeSelector = document.getElementById('time-range');
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
  
  // Refresh interval selector
  const refreshSelector = document.getElementById('refresh-interval');
  refreshSelector.addEventListener('change', (event) => {
    const interval = parseInt(event.target.value, 10);
    updateRefreshInterval(interval);
  });
  
  // Export data button
  const exportButton = document.getElementById('export-data');
  exportButton.addEventListener('click', exportDashboardData);
  
  // Fullscreen toggle button
  const fullscreenButton = document.getElementById('fullscreen-toggle');
  fullscreenButton.addEventListener('click', toggleFullscreen);
  
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
  updateAlerts();
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

/**
 * Show custom time range picker modal
 */
function showCustomTimeRangePicker() {
  // Implementation for custom time range picker
  console.log('Custom time range picker not implemented yet');
}

/**
 * Update charts with the selected time range
 * @param {string} range - The time range to display
 */
function updateChartsTimeRange(range) {
  // Parse the time range and update all charts
  console.log(`Updating charts to show range: ${range}`);
  
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
  
  // Update charts with new time range
  window.dataManager.setTimeRange(start, end).then(updateDashboardUI);
}
```


## 4. Network Map with Three.js

Now let's create the network map visualization using three.js:

```javascript
/**
 * Network Map Visualization
 * Utilizes Three.js to create a 3D representation of the IQSMS network
 */

let networkScene, networkCamera, networkRenderer, networkControls;
let nodes = [], links = [], nodeObjects = {}, linkObjects = [];
let raycaster, mouse;

/**
 * Initialize the network map visualization
 */
function initializeNetworkMap() {
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
  
  // Add orbit controls
  networkControls = new THREE.OrbitControls(networkCamera, networkRenderer.domElement);
  networkControls.enableDamping = true;
  networkControls.dampingFactor = 0.1;
  networkControls.rotateSpeed = 0.5;
  
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
  
  // Add glow effect
  // Implementation depends on post-processing which is beyond the scope of this example
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
  // Implementation for showing node details
  console.log('Node details:', nodeData);
  
  // Create or update a detail panel
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
      <p><strong>Connections:</strong> ${nodeData.connections ? nodeData.connections.length : 0}</p>
      <p><strong>Last Seen:</strong> ${new Date(nodeData.lastSeen).toLocaleString()}</p>
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
 * @returns {string} - The color hex code
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
  // Fetch the latest network data
  const networkData = window.dataManager.getNetworkData();
  
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
  
  // Update controls
  networkControls.update();
  
  // Render scene
  networkRenderer.render(networkScene, networkCamera);
}
```


## 5. Gauge Charts with D3.js

Now let's create the gauge charts for system metrics:

```javascript
/**
 * Gauge Charts
 * Uses D3.js to create gauge charts for key metrics
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
```


## 6. Server-Side Implementation

Now, let's implement the server-side code to provide data for the dashboard:

```javascript
/**
 * Monitoring Dashboard API
 * Provides data for the IQSMS monitoring dashboard
 */

const express = require('express');
const http = require('http');
const socketIo = require('socket.io');
const os = require('os');
const { MonitoringService } = require('./core/MonitoringService');
const { PerformanceMonitor } = require('./core/PerformanceMonitor');
const { SystemMetricsMonitor } = require('./core/SystemMetricsMonitor');

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
const systemMetricsMonitor = new SystemMetricsMonitor({
  interval: 5000 // Collect metrics every 5 seconds
});

const performanceMonitor = new PerformanceMonitor({
  systemMetricsMonitor,
  metricsBuffer: 1000 // Store up to 1000 metric points
});

const monitoringService = new MonitoringService({
  performanceMonitor
});

// Serve static files
app.use(express.static('public'));

// API routes
app.get('/api/metrics', (req, res) => {
  const metrics = performanceMonitor.getLatestMetrics();
  res.json(metrics);
});

app.get('/api/metrics/history', (req, res) => {
  const { start, end, interval } = req.query;
  const metrics = performanceMonitor.getMetricsHistory(start, end, interval);
  res.json(metrics);
});

app.get('/api/system', (req, res) => {
  const systemInfo = systemMetricsMonitor.getSystemInfo();
  res.json(systemInfo);
});

app.get('/api/network', (req, res) => {
  const networkData = monitoringService.getNetworkData();
  res.json(networkData);
});

app.get('/api/workers', (req, res) => {
  const workers = monitoringService.getWorkerStatus();
  res.json(workers);
});

app.get('/api/alerts', (req, res) => {
  const alerts = monitoringService.getAlerts();
  res.json(alerts);
});

// Socket.IO connections
io.on('connection', (socket) => {
  console.log('Client connected');
  
  // Send initial data
  socket.emit('metrics', performanceMonitor.getLatestMetrics());
  socket.emit('system', systemMetricsMonitor.getSystemInfo());
  socket.emit('network', monitoringService.getNetworkData());
  socket.emit('workers', monitoringService.getWorkerStatus());
  socket.emit('alerts', monitoringService.getAlerts());
  
  // Handle client disconnection
  socket.on('disconnect', () => {
    console.log('Client disconnected');
  });
});

// Set up periodic updates
setInterval(() => {
  const metrics = performanceMonitor.getLatestMetrics();
  io.emit('metrics', metrics);
}, 5000);

setInterval(() => {
  const networkData = monitoringService.getNetworkData();
  io.emit('network', networkData);
}, 10000);

setInterval(() => {
  const workers = monitoringService.getWorkerStatus();
  io.emit('workers', workers);
}, 10000);

setInterval(() => {
  const alerts = monitoringService.getAlerts();
  io.emit('alerts', alerts);
}, 5000);

// Start server
const PORT = process.env.PORT || 3000;
server.listen(PORT, () => {
  console.log(`IQSMS Monitoring Dashboard server running on port ${PORT}`);
});
```


## 7. Data Manager Class

Let's create a client-side data manager to handle fetching and processing data:

```javascript
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
      const historyResponse = await fetch('/api/metrics/history');
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
      return false;
    }
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


## 8. Socket Manager Class

Let's create a Socket.IO manager for real-time updates:

```javascript
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
}
```


## 9. Documentation Page

Let's create the dashboard documentation page:

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <!-- 
    Copyright 2025 Autonomy Association International Inc., all rights reserved 
    Safeguard patent license from National Aeronautics and Space Administration (NASA)
    Copyright 2025 NASA, all rights reserved
  -->
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
                      <td><code>/api/system</code></td>
                      <td>GET</td>
                      <td>Get system information</td>
                      <td>None</td>
                    </tr>
                    <tr>
                      <td><code>/api/network</code></td>
                      <td>GET</td>
                      <td>Get network topology data</td>
                      <td>None</td>
                    </tr>
                    <tr>
                      <td><code>/api/workers</code></td>
                      <td>GET</td>
                      <td>Get worker thread status</td>
                      <td>None</td>
                    </tr>
                    <tr>
                      <td><code>/api/alerts</code></td>
                      <td>GET</td>
                      <td>Get active and recent alerts</td>
                      <td>
                        <ul>
                          <li><code>severity</code>: Filter by severity (optional)</li>
                          <li><code>status</code>: Filter by status (optional)</li>
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


## 10. Update to Index.html Navigation

Let's update the main index.html to include a link to our new dashboard documentation:

```html
<!-- ... existing code ... -->
<div class="dropdown-menu">
    <a class="dropdown-item" href="monitoring/index.html">Monitoring Overview</a>
    <a class="dropdown-item" href="monitoring/metrics_collection.html">Metrics Collection</a>
    <a class="dropdown-item" href="monitoring/opentelemetry_integration.html">OpenTelemetry Integration</a>
    <a class="dropdown-item" href="monitoring/performance_testing.html">Performance Testing</a>
    <a class="dropdown-item" href="monitoring/worker_management.html">Worker Management</a>
    <a class="dropdown-item" href="monitoring/dashboard_guide.html">Dashboard Guide</a>
    <a class="dropdown-item" href="monitoring/docs/dashboardhowto.html">Dashboard How-To</a>
</div>
<!-- ... existing code ... -->
```


## Conclusion

This implementation provides a comprehensive monitoring dashboard solution for the IQSMS platform with the following features:

1. **Real-time Monitoring**: Uses Socket.IO for real-time updates with fallback to HTTP polling
2. **Interactive Visualizations**: Leverages D3.js for creating dynamic charts and gauges
3. **3D Network Map**: Utilizes Three.js to create an immersive 3D visualization of the network
4. **Responsive Design**: Works on both desktop and mobile devices
5. **Customizable Time Ranges**: Allows users to select different time periods for analysis
6. **Comprehensive Documentation**: Includes detailed how-to guide for users

The dashboard is organized into clear sections:
- System Overview with key metrics
- System Resources with detailed performance charts
- Network Map with 3D visualization
- Worker Threads with management capabilities
- Alerts for monitoring system issues

The implementation follows best practices for modern web development, including:
- Modular JavaScript architecture
- Responsive design principles
- Graceful degradation for older browsers
- Comprehensive error handling
- Detailed documentation

This solution meets all the requirements specified and provides an innovative, pioneering dashboard that showcases the power of d3.js and three.js for data visualization in a real-time monitoring context.

# IQSMS Monitoring Dashboard File Structure

Based on your implementation requirements and the existing project structure, here's a comprehensive file map for the JavaScript files and associated assets for the monitoring dashboard:

## Client-Side Files

### Main Dashboard HTML File
```
/docs/monitoring/dashboard/index.html
```


### CSS Files
```
/docs/monitoring/dashboard/css/dashboard.css
```


### JavaScript Files - Core

```
/docs/monitoring/dashboard/js/dashboard.js             # Main dashboard initialization
/docs/monitoring/dashboard/js/data-manager.js          # Data fetching and management
/docs/monitoring/dashboard/js/socket-manager.js        # WebSocket connection handling
```


### JavaScript Files - Visualization Components

```
/docs/monitoring/dashboard/js/charts/gauges.js         # D3.js gauge charts
/docs/monitoring/dashboard/js/charts/performance.js    # Performance charts
/docs/monitoring/dashboard/js/charts/network-map.js    # Three.js network visualization
/docs/monitoring/dashboard/js/charts/worker-charts.js  # Worker thread visualizations
```


### JavaScript Files - UI Components

```
/docs/monitoring/dashboard/js/ui/alerts-panel.js       # Alerts UI components
/docs/monitoring/dashboard/js/ui/time-controls.js      # Time range selection
/docs/monitoring/dashboard/js/ui/table-manager.js      # Table data management
```


### Assets

```
/docs/monitoring/dashboard/img/icons/                  # Custom icons
/docs/monitoring/dashboard/img/screenshots/            # Screenshots for documentation
```


## Server-Side Files

### API and Socket Server

```
/server/monitoring/dashboard/dashboard-server.js            # Main server file for the dashboard
/server/monitoring/dashboard/api/metrics-api.js             # Metrics API endpoints
/server/monitoring/dashboard/api/network-api.js             # Network data API endpoints
/server/monitoring/dashboard/api/workers-api.js             # Worker status API endpoints
/server/monitoring/dashboard/api/alerts-api.js              # Alerts API endpoints
```


### Data Collection and Processing

```
/server/monitoring/dashboard/services/metrics-service.js    # Metrics collection service
/server/monitoring/dashboard/services/network-service.js    # Network data collection
/server/monitoring/dashboard/services/alerts-service.js     # Alert management service
/server/monitoring/dashboard/services/worker-service.js     # Worker monitoring service
```


### Utilities

```
/server/monitoring/dashboard/utils/data-formatter.js        # Data formatting utilities
/server/monitoring/dashboard/utils/socket-manager.js        # Socket.IO connection management
/server/monitoring/dashboard/utils/config-loader.js         # Configuration loading
```


### Configuration

```
/server/monitoring/dashboard/config/dashboard-config.js     # Dashboard configuration
/server/monitoring/dashboard/config/metrics-config.js       # Metrics configuration
/server/monitoring/dashboard/config/thresholds-config.js    # Alert thresholds configuration
```


## Documentation Files

```
/docs/monitoring/docs/dashboardhowto.html                  # Dashboard how-to guide
/docs/monitoring/dashboard_guide.html                      # Dashboard guide (existing file)
/docs/images/dashboard-screenshot.png                      # Main dashboard screenshot
/docs/images/dashboard-overview.png                        # Overview section screenshot
/docs/images/dashboard-system.png                          # System section screenshot
/docs/images/dashboard-network.png                         # Network section screenshot
/docs/images/dashboard-workers.png                         # Workers section screenshot
/docs/images/dashboard-alerts.png                          # Alerts section screenshot
```


## Integration with Existing Structure

This file structure integrates with the existing project structure while maintaining a clean separation of concerns:

1. **Client-side files** are organized under `/docs/monitoring/dashboard/` for easy access through the web server
2. **Server-side files** are organized under `/server/monitoring/dashboard/` to integrate with existing monitoring components
3. **Documentation files** are placed in the appropriate documentation directories

## Implementation Notes

1. **Installation Steps**:
    - Create all necessary directories
    - Install the JavaScript files in their respective locations
    - Update server startup scripts to include the dashboard server

2. **Dependencies**:
    - Ensure D3.js (v7), Three.js, and Socket.IO are available
    - Add these dependencies to the project's package.json if not already included

3. **Integration with Existing Code**:
    - The server-side implementation should interface with existing monitoring components
    - The client-side should be standalone but able to consume data from the server

4. **Documentation**:
    - Update existing documentation to reference the new dashboard
    - Create the detailed how-to documentation as specified

This file structure follows best practices for organizing a modern web application with clear separation between client and server components, and a modular approach to JavaScript code organization.
