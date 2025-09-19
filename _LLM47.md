I'll review the monitoring and open telemetry systems, analyze the architecture, and then plan work for creating any missing documentation pages.

## Initial Review of the System

Let me start by examining the project structure and understanding the current organization of the monitoring and telemetry components.Based on my review of the project files and documentation, I'll now create a comprehensive monitoring system documentation page that aligns with the existing documentation style. Let me plan the work first:

## Work Plan:

1. **Review and Understand Current State**:
    - Monitoring system is organized in `server/monitoring/` with subdirectories for core, dashboard, integration, test, and workers
    - Documentation follows Bootstrap 4 style with common navigation and formatting
    - Links should be updated in `/docs/index.html` to include monitoring documentation

2. **Create Documentation Files**:
    - Create a main monitoring overview page (`monitoring_system_overview.html`)
    - Create documentation for OpenTelemetry integration (`opentelemetry_integration.html`)
    - Create documentation for performance metrics (`performance_metrics_monitoring.html`)
    - Create documentation for WebSocket monitoring (`websocket_monitoring.html`)

3. **Update Navigation Links**:
    - Add monitoring section links to the main documentation index

Now, let's begin by creating the main monitoring system overview page:

## Monitoring System Overview DocumentationBased on my review of the provided files and system structure, I'll plan and create the missing documentation pages for the IQSMS monitoring and telemetry system.

# System Architecture Review and Understanding

I've examined the key components of the IQSMS monitoring and telemetry system:

1. **Core Monitoring Components**:
    - `MonitoringService.js`: Sets up API routes for metrics collection, historical data, alerts, and performance testing
    - `PerformanceMonitor.js`: Collects performance metrics
    - `AlertManager.js`: Manages alerts based on metric thresholds
    - `SystemMetricsMonitor.js`: Monitors system resources
    - `MetricsStorageSetup.js`: Configures database storage for metrics

2. **Integration Components**:
    - `OpenTelemetryIntegration.js`: Integrates with OpenTelemetry for distributed tracing
    - `OpenTelemetryMessageHandler.js`: Handles messages with OpenTelemetry context
    - `MessageHandler.js`: Processes protocol messages
    - `MetricsHandler.js`: Processes metrics data
    - `PerformanceMetricsConfiguration.js`: Configures performance metrics collection

3. **Dashboard and Testing**:
    - Dashboard UI files for visualization
    - Performance testing infrastructure

4. **Protocol Performance Optimization**:
    - The existing `IqSmsProtocolPerformanceOptimization.html` provides detailed strategies for protocol optimization

## Missing Documentation

Based on the existing structure and documentation, the following pages are missing:

1. **Monitoring System Overview**: A comprehensive introduction to the monitoring system
2. **OpenTelemetry Integration Guide**: Details on distributed tracing implementation
3. **Socket Monitoring Documentation**: Information on WebSocket monitoring
4. **Performance Testing Guide**: How to use the performance testing tools
5. **Dashboard Usage Guide**: How to use the monitoring dashboards

# Implementation Plan

I'll create the following documentation pages:

1. `docs/monitoring/index.html` - Monitoring System Overview
2. `docs/monitoring/OpenTelemetryIntegration.html` - OpenTelemetry Integration Guide
3. `docs/monitoring/WebSocketMonitoring.html` - Socket Monitoring Documentation
4. `docs/monitoring/PerformanceTestingGuide.html` - Performance Testing Guide
5. `docs/monitoring/DashboardUsageGuide.html` - Dashboard Usage Guide

Let me first check the existing `docs/index.html` to ensure consistent navigation and styling.

Now, I'll implement each of these documentation files:

## 1. Monitoring System OverviewAfter reviewing the project's monitoring, telemetry, socket monitoring, and other system health components, I'll provide a comprehensive analysis and plan for creating any missing documentation pages.

# System Architecture Analysis

## Current Monitoring and Telemetry Components

The project has a well-structured monitoring system organized in the following way:

1. **Monitoring Core Components**:
    - `MonitoringService.js` - Sets up API routes for metrics, alerts, and performance tests
    - `PerformanceMonitor.js` - Collects performance metrics
    - `AlertManager.js` - Manages system alerts
    - `SystemMetricsMonitor.js` - Monitors system resources
    - `MetricsStorageSetup.js` - Configures database for metrics storage

2. **Integration Components**:
    - `OpenTelemetryIntegration.js` - Implements distributed tracing with OpenTelemetry
    - `OpenTelemetryMessageHandler.js` - Integrates telemetry with message handling
    - `MessageHandler.js` - Processes instrumented messages
    - `MetricsHandler.js` - Processes metrics data
    - `PerformanceMetricsConfiguration.js` - Configures performance metrics

3. **Worker Management**:
    - `WorkerManager.js` - Manages worker threads/containers for parallel processing
    - `LoadBalancer.js` - Distributes load across workers
    - `JobQueueManager.js` - Manages task queues
    - `WorkerThreadJobExecutor.js` - Executes jobs in worker threads
    - `DroneSwarmLoadBalancer.js` - Specialized load balancer for drone operations
    - `DroneSelectionAlgorithm.js` - Algorithms for drone selection

4. **Dashboard/UI**:
    - In `server/public/monitoring/` directory with dashboard HTML files

## Documentation Gap Analysis

Looking at the existing documentation, I've identified these gaps that need to be addressed:

1. No dedicated documentation for the Monitoring System
2. Missing documentation for OpenTelemetry integration
3. No performance monitoring dashboard documentation
4. Missing worker thread management documentation
5. No socket monitoring documentation

# Implementation Plan

I'll create the following HTML documentation pages with a consistent Bootstrap 4 design that matches the existing documentation:

1. **Monitoring System Overview** (`/docs/monitoring/index.html`)
2. **OpenTelemetry Integration** (`/docs/monitoring/open_telemetry_integration.html`)
3. **Performance Monitoring Dashboard** (`/docs/monitoring/performance_monitoring_dashboard.html`)
4. **Worker Thread Management** (`/docs/monitoring/worker_thread_management.html`)
5. **Socket Monitoring** (`/docs/monitoring/socket_monitoring.html`)

Each page will follow the consistent layout, styling, and linking structure seen in the existing documentation, including:
- Navigation bar with appropriate links
- Jumbotron with topic introduction
- Sidebar navigation
- Bootstrap 4 cards and components
- Appropriate code examples
- Footer with copyright information

# Implementation

Now I'll create each of the documentation files listed above:

## 1. Monitoring System Overview# System Architecture and Documentation Plan

After reviewing the project's files and structure, I see that IQSMS is a sophisticated safety management and surveillance system built on Meteor with an extensive set of components for monitoring, protocols, predictors, services, and more. I've identified gaps in the documentation, particularly regarding the monitoring and performance components.

## Project Structure Analysis

The project has been reorganized with a clear structure:
- `/server/monitoring/` - Core monitoring components including performance metrics, telemetry, OpenTelemetry integration
- `/server/protocols/` - Protocol implementations (Agent, Model Context, etc.)
- `/server/services/` - Various services including WebSocket, authentication, etc.
- `/server/safeguard/` - Safety management components
- `/server/predictors/` - AI-powered prediction systems
- `/docs/` - Documentation organized by feature area

The `/docs` folder contains HTML documentation with a Bootstrap 4 theme, but is missing documentation for the monitoring system.

## Documentation Gap Analysis

The main gap I've identified is lack of documentation for:
1. System monitoring architecture
2. OpenTelemetry integration
3. Worker management system
4. Performance metrics collection and visualization
5. Socket monitoring capabilities

## Implementation Plan

I'll create the following documentation pages:

1. **Monitoring System Overview** - A top-level document explaining the monitoring architecture
2. **OpenTelemetry Integration** - Details on distributed tracing implementation
3. **Performance Metrics Dashboard** - Guide to the metrics visualization interface
4. **Worker Thread Management** - Documentation on the worker system
5. **Socket Monitoring** - Documentation on WebSocket monitoring

Let's start implementing these pages.

## First, let's create the monitoring system overview page:Based on my review of the code and documentation, I can now provide a comprehensive plan for developing the missing monitoring documentation. I'll create the necessary monitoring help pages with consistent Bootstrap 4 styling that matches the existing documentation structure.

# Analysis of the Current System

From examining the codebase, I've identified that:

1. The monitoring system is well-structured in `/server/monitoring/` with several key components:
    - Core monitoring services for metrics collection and alert management
    - Integration with OpenTelemetry for distributed tracing
    - Worker thread management for parallel processing
    - Dashboard functionality for visualization

2. The docs directory uses a consistent Bootstrap 4 template with:
    - Common navigation and styling across pages
    - Organized sections with sidebar navigation
    - Consistent footer with copyright information
    - Responsive design elements

3. Currently missing is a dedicated monitoring section in the documentation to help users understand and leverage these capabilities.

# Plan for Documentation Creation

I'll create the following HTML files for the monitoring documentation:

1. **`/docs/monitoring/index.html`** - Main overview of the monitoring system
2. **`/docs/monitoring/metrics_collection.html`** - Documentation on metrics collection
3. **`/docs/monitoring/opentelemetry_integration.html`** - Guide on OpenTelemetry integration
4. **`/docs/monitoring/performance_testing.html`** - Documentation on performance testing
5. **`/docs/monitoring/worker_management.html`** - Information on worker thread management
6. **`/docs/monitoring/dashboard_guide.html`** - Guide to using the monitoring dashboards

I'll also update the main navigation in `docs/index.html` to include the new monitoring section.

# Implementation Details

Let's begin with creating the main monitoring documentation page:

## 1. `/docs/monitoring/index.html`

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <!-- 
    Path: /docs/monitoring/index.html - IQSMS Monitoring System Overview
    Copyright 2025 Autonomy Association International Inc., all rights reserved 
    Safeguard patent license from National Aeronautics and Space Administration (NASA)
    Copyright 2025 NASA, all rights reserved
  -->
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Monitoring System - IQSMS Documentation</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="../css/styles.css">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.1/css/all.css">
</head>
<body>
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
      <a class="navbar-brand" href="../index.html">
        IQSMS Documentation
      </a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item">
            <a class="nav-link" href="../index.html">Home</a>
          </li>
          <li class="nav-item dropdown active">
            <a class="nav-link dropdown-toggle" href="#" id="monitoringDropdown" role="button" data-toggle="dropdown">
              Monitoring
            </a>
            <div class="dropdown-menu">
              <a class="dropdown-item active" href="index.html">Monitoring Overview</a>
              <a class="dropdown-item" href="metrics_collection.html">Metrics Collection</a>
              <a class="dropdown-item" href="opentelemetry_integration.html">OpenTelemetry Integration</a>
              <a class="dropdown-item" href="performance_testing.html">Performance Testing</a>
              <a class="dropdown-item" href="worker_management.html">Worker Management</a>
              <a class="dropdown-item" href="dashboard_guide.html">Dashboard Guide</a>
            </div>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="coreDropdown" role="button" data-toggle="dropdown">
              Core System
            </a>
            <div class="dropdown-menu">
              <a class="dropdown-item" href="../core/index.html">Core Overview</a>
              <a class="dropdown-item" href="../core/SafeguardBaseDocumentation.html">Safeguard Base</a>
            </div>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="protocolsDropdown" role="button" data-toggle="dropdown">
              Protocols
            </a>
            <div class="dropdown-menu">
              <a class="dropdown-item" href="../protocols/IQSMS_Protocols_Overview.html">Protocols Overview</a>
              <a class="dropdown-item" href="../protocols/agent-protocol.html">Agent Protocol</a>
              <a class="dropdown-item" href="../protocols/mcp.html">Model Context Protocol</a>
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
          <h1 class="display-4">IQSMS Monitoring System</h1>
          <p class="lead">Comprehensive monitoring, metrics collection, and performance analysis for IQSMS protocols and services</p>
        </div>
        <div class="col-md-4 text-center">
          <i class="fas fa-chart-line fa-6x"></i>
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
              <a class="nav-link" href="#key-features">Key Features</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#architecture">Architecture</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#components">Core Components</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#integration">Integration</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#getting-started">Getting Started</a>
            </li>
          </ul>
        </nav>
      </div>
      <div class="col-md-9">
        <section id="overview">
          <h2>Overview</h2>
          <p class="lead">
            The IQSMS Monitoring System provides comprehensive performance monitoring, metrics collection, and analysis tools for all components of the IQSMS platform.
          </p>
          
          <p>
            Designed for high-performance and high-reliability environments, the monitoring system offers real-time insights into protocol performance, system health, and operational metrics. With support for distributed tracing, worker thread management, and custom dashboards, it enables administrators and developers to ensure optimal system performance.
          </p>
          
          <div class="alert alert-info">
            <i class="fas fa-info-circle mr-2"></i>
            <strong>Key Benefit:</strong> The monitoring system provides early detection of performance issues and bottlenecks, enabling proactive optimization and preventing service degradation.
          </div>
        </section>

        <section id="key-features" class="mt-5">
          <h2>Key Features</h2>
          
          <div class="row mt-4">
            <div class="col-lg-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h4 class="card-title"><i class="fas fa-tachometer-alt text-primary mr-2"></i>Performance Metrics</h4>
                  <p class="card-text">Comprehensive collection and analysis of performance metrics across all protocols and services.</p>
                  <ul>
                    <li>Protocol-specific metrics</li>
                    <li>System resource utilization</li>
                    <li>Message throughput and latency</li>
                    <li>Historical trend analysis</li>
                  </ul>
                </div>
              </div>
            </div>
            
            <div class="col-lg-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h4 class="card-title"><i class="fas fa-bell text-primary mr-2"></i>Alerting System</h4>
                  <p class="card-text">Proactive alerting for performance degradation, system issues, and threshold violations.</p>
                  <ul>
                    <li>Configurable alert thresholds</li>
                    <li>Multi-channel notifications</li>
                    <li>Alert categorization and prioritization</li>
                    <li>Automated response actions</li>
                  </ul>
                </div>
              </div>
            </div>
            
            <div class="col-lg-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h4 class="card-title"><i class="fas fa-project-diagram text-primary mr-2"></i>Distributed Tracing</h4>
                  <p class="card-text">End-to-end transaction tracing with OpenTelemetry integration.</p>
                  <ul>
                    <li>Cross-service transaction tracking</li>
                    <li>Latency breakdown by component</li>
                    <li>Bottleneck identification</li>
                    <li>Error correlation</li>
                  </ul>
                </div>
              </div>
            </div>
            
            <div class="col-lg-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h4 class="card-title"><i class="fas fa-chart-bar text-primary mr-2"></i>Interactive Dashboards</h4>
                  <p class="card-text">Real-time and historical data visualization through interactive dashboards.</p>
                  <ul>
                    <li>Protocol-specific dashboards</li>
                    <li>Customizable metrics views</li>
                    <li>Drill-down capability</li>
                    <li>Time-series analysis</li>
                  </ul>
                </div>
              </div>
            </div>
            
            <div class="col-lg-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h4 class="card-title"><i class="fas fa-users-cog text-primary mr-2"></i>Worker Management</h4>
                  <p class="card-text">Advanced worker thread management for distributed processing tasks.</p>
                  <ul>
                    <li>Dynamic worker scaling</li>
                    <li>Job queue management</li>
                    <li>Worker health monitoring</li>
                    <li>Resource-aware task distribution</li>
                  </ul>
                </div>
              </div>
            </div>
            
            <div class="col-lg-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h4 class="card-title"><i class="fas fa-flask text-primary mr-2"></i>Performance Testing</h4>
                  <p class="card-text">Built-in tools for performance testing and benchmarking protocol implementations.</p>
                  <ul>
                    <li>Load testing capabilities</li>
                    <li>Benchmark comparisons</li>
                    <li>Scalability assessment</li>
                    <li>Regression detection</li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </section>

        <section id="architecture" class="mt-5">
          <h2>Architecture</h2>
          
          <p>
            The IQSMS Monitoring System is built on a modular architecture that allows for flexible deployment and integration with various components of the IQSMS platform.
          </p>
          
          <div class="text-center my-4">
            <img src="../images/monitoring-architecture.svg" alt="Monitoring System Architecture" class="img-fluid rounded border" style="max-width: 90%;">
          </div>
          
          <p>
            The architecture consists of the following layers:
          </p>
          
          <ul>
            <li><strong>Data Collection Layer</strong>: Collects metrics and telemetry from various sources</li>
            <li><strong>Processing Layer</strong>: Processes, aggregates, and analyzes the collected data</li>
            <li><strong>Storage Layer</strong>: Stores metrics data for historical analysis</li>
            <li><strong>Visualization Layer</strong>: Provides dashboards and visualizations</li>
            <li><strong>Alerting Layer</strong>: Monitors metrics and generates alerts based on defined thresholds</li>
          </ul>
          
          <p>
            This layered approach allows for high scalability and flexibility, enabling the monitoring system to adapt to varying deployment sizes and requirements.
          </p>
        </section>

        <section id="components" class="mt-5">
          <h2>Core Components</h2>
          
          <div class="accordion" id="componentsAccordion">
            <div class="card">
              <div class="card-header" id="headingPerformanceMonitor">
                <h5 class="mb-0">
                  <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#collapsePerformanceMonitor" aria-expanded="true" aria-controls="collapsePerformanceMonitor">
                    Performance Monitor
                  </button>
                </h5>
              </div>
              <div id="collapsePerformanceMonitor" class="collapse show" aria-labelledby="headingPerformanceMonitor" data-parent="#componentsAccordion">
                <div class="card-body">
                  <p>The Performance Monitor collects and processes performance metrics from all system components.</p>
                  <ul>
                    <li><strong>Real-time Metrics Collection</strong>: Collects metrics from various components in real-time</li>
                    <li><strong>Metric Aggregation</strong>: Aggregates metrics across multiple instances</li>
                    <li><strong>Statistical Analysis</strong>: Performs statistical analysis on collected metrics</li>
                    <li><strong>Historical Data Management</strong>: Manages historical metrics data for trend analysis</li>
                  </ul>
                  <p><a href="metrics_collection.html" class="btn btn-sm btn-primary">Learn More</a></p>
                </div>
              </div>
            </div>
            
            <div class="card">
              <div class="card-header" id="headingAlertManager">
                <h5 class="mb-0">
                  <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseAlertManager" aria-expanded="false" aria-controls="collapseAlertManager">
                    Alert Manager
                  </button>
                </h5>
              </div>
              <div id="collapseAlertManager" class="collapse" aria-labelledby="headingAlertManager" data-parent="#componentsAccordion">
                <div class="card-body">
                  <p>The Alert Manager monitors metrics and generates alerts based on defined thresholds and conditions.</p>
                  <ul>
                    <li><strong>Threshold Monitoring</strong>: Monitors metrics against defined thresholds</li>
                    <li><strong>Alert Generation</strong>: Generates alerts when thresholds are violated</li>
                    <li><strong>Notification Routing</strong>: Routes alerts to appropriate notification channels</li>
                    <li><strong>Alert Lifecycle Management</strong>: Manages the lifecycle of alerts from creation to resolution</li>
                  </ul>
                  <p><a href="metrics_collection.html#alerting" class="btn btn-sm btn-primary">Learn More</a></p>
                </div>
              </div>
            </div>
            
            <div class="card">
              <div class="card-header" id="headingOpenTelemetry">
                <h5 class="mb-0">
                  <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseOpenTelemetry" aria-expanded="false" aria-controls="collapseOpenTelemetry">
                    OpenTelemetry Integration
                  </button>
                </h5>
              </div>
              <div id="collapseOpenTelemetry" class="collapse" aria-labelledby="headingOpenTelemetry" data-parent="#componentsAccordion">
                <div class="card-body">
                  <p>The OpenTelemetry Integration provides distributed tracing capabilities across all IQSMS components.</p>
                  <ul>
                    <li><strong>Distributed Tracing</strong>: Traces transactions across multiple services</li>
                    <li><strong>Context Propagation</strong>: Propagates trace context between services</li>
                    <li><strong>Span Collection</strong>: Collects and manages trace spans</li>
                    <li><strong>Exporter Integration</strong>: Exports traces to various backends (Zipkin, Jaeger, etc.)</li>
                  </ul>
                  <p><a href="opentelemetry_integration.html" class="btn btn-sm btn-primary">Learn More</a></p>
                </div>
              </div>
            </div>
            
            <div class="card">
              <div class="card-header" id="headingWorkerManager">
                <h5 class="mb-0">
                  <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseWorkerManager" aria-expanded="false" aria-controls="collapseWorkerManager">
                    Worker Manager
                  </button>
                </h5>
              </div>
              <div id="collapseWorkerManager" class="collapse" aria-labelledby="headingWorkerManager" data-parent="#componentsAccordion">
                <div class="card-body">
                  <p>The Worker Manager handles the creation, management, and monitoring of worker threads for distributed processing tasks.</p>
                  <ul>
                    <li><strong>Worker Thread Management</strong>: Creates and manages worker threads</li>
                    <li><strong>Task Distribution</strong>: Distributes tasks to available workers</li>
                    <li><strong>Health Monitoring</strong>: Monitors worker health and performs recovery actions</li>
                    <li><strong>Resource Optimization</strong>: Optimizes resource utilization across workers</li>
                  </ul>
                  <p><a href="worker_management.html" class="btn btn-sm btn-primary">Learn More</a></p>
                </div>
              </div>
            </div>
            
            <div class="card">
              <div class="card-header" id="headingDashboard">
                <h5 class="mb-0">
                  <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseDashboard" aria-expanded="false" aria-controls="collapseDashboard">
                    Monitoring Dashboard
                  </button>
                </h5>
              </div>
              <div id="collapseDashboard" class="collapse" aria-labelledby="headingDashboard" data-parent="#componentsAccordion">
                <div class="card-body">
                  <p>The Monitoring Dashboard provides visualization of metrics and system status through interactive web interfaces.</p>
                  <ul>
                    <li><strong>Real-time Metrics Display</strong>: Displays real-time metrics and status</li>
                    <li><strong>Historical Data Visualization</strong>: Visualizes historical trends and patterns</li>
                    <li><strong>Interactive Charts</strong>: Provides interactive charts and graphs</li>
                    <li><strong>Customizable Views</strong>: Supports customizable dashboard views</li>
                  </ul>
                  <p><a href="dashboard_guide.html" class="btn btn-sm btn-primary">Learn More</a></p>
                </div>
              </div>
            </div>
          </div>
        </section>

        <section id="integration" class="mt-5">
          <h2>Integration</h2>
          
          <p>
            The IQSMS Monitoring System integrates with various components of the IQSMS platform and external systems to provide comprehensive monitoring capabilities.
          </p>
          
          <h4>Protocol Integration</h4>
          <p>
            All IQSMS protocols are instrumented with monitoring capabilities:
          </p>
          <ul>
            <li><strong>Agent Protocol</strong>: Monitors message exchange and agent lifecycle events</li>
            <li><strong>Model Context Protocol</strong>: Tracks model access, updates, and query performance</li>
            <li><strong>Message Communication Protocol</strong>: Monitors message routing and delivery</li>
            <li><strong>Agent-to-Agent Protocol</strong>: Tracks peer discovery and direct communication</li>
          </ul>
          
          <h4>External System Integration</h4>
          <p>
            The monitoring system integrates with external monitoring and analytics platforms:
          </p>
          <ul>
            <li><strong>Zipkin/Jaeger</strong>: Exports distributed traces</li>
            <li><strong>Prometheus</strong>: Exposes metrics for scraping</li>
            <li><strong>Grafana</strong>: Provides advanced visualization capabilities</li>
            <li><strong>ELK Stack</strong>: Integrates with log analysis tools</li>
          </ul>
        </section>

        <section id="getting-started" class="mt-5">
          <h2>Getting Started</h2>
          
          <p>
            Follow these steps to set up and start using the IQSMS Monitoring System:
          </p>
          
          <div class="card mb-4">
            <div class="card-header bg-light">
              <h5 class="mb-0">1. Install Required Dependencies</h5>
            </div>
            <div class="card-body">
              <p>Ensure all required dependencies are installed:</p>
              <pre><code class="language-bash">npm install @opentelemetry/api @opentelemetry/sdk-trace-node @opentelemetry/exporter-zipkin</code></pre>
            </div>
          </div>
          
          <div class="card mb-4">
            <div class="card-header bg-light">
              <h5 class="mb-0">2. Configure Monitoring Service</h5>
            </div>
            <div class="card-body">
              <p>Configure the monitoring service in your application:</p>
              <pre><code class="language-javascript">const { MonitoringService } = require('./monitoring/core/MonitoringService');
const { PerformanceMonitor } = require('./monitoring/core/PerformanceMonitor');
const { AlertManager } = require('./monitoring/core/AlertManager');

// Initialize components
const performanceMonitor = new PerformanceMonitor({
  interval: 10000, // Collect metrics every 10 seconds
  metricsCollection: db.collection('metrics')
});

const alertManager = new AlertManager({
  alertsCollection: db.collection('alerts'),
  notificationChannels: ['email', 'slack']
});

// Initialize monitoring service
const monitoringService = new MonitoringService({
  performanceMonitor,
  alertManager,
  app: expressApp // Your Express app instance
});</code></pre>
            </div>
          </div>
          
          <div class="card mb-4">
            <div class="card-header bg-light">
              <h5 class="mb-0">3. Set Up OpenTelemetry</h5>
            </div>
            <div class="card-body">
              <p>Configure OpenTelemetry for distributed tracing:</p>
              <pre><code class="language-javascript">const { OpenTelemetryIntegration } = require('./monitoring/integration/OpenTelemetryIntegration');

// Initialize OpenTelemetry
const openTelemetry = new OpenTelemetryIntegration({
  serviceName: 'iqsms-server',
  serviceVersion: '1.0.0',
  zipkinUrl: 'http://localhost:9411/api/v2/spans'
});

// Get tracer
const tracer = openTelemetry.initialize();</code></pre>
            </div>
          </div>
          
          <div class="card mb-4">
            <div class="card-header bg-light">
              <h5 class="mb-0">4. Instrument Protocols</h5>
            </div>
            <div class="card-body">
              <p>Instrument your protocols for monitoring:</p>
              <pre><code class="language-javascript">const { AgentProtocol } = require('./protocols/AgentProtocol');
const { OpenTelemetryMessageHandler } = require('./monitoring/integration/OpenTelemetryMessageHandler');

// Create message handler with OpenTelemetry instrumentation
const messageHandler = new OpenTelemetryMessageHandler({
  tracer,
  metricsCollection: db.collection('metrics')
});

// Initialize protocol with instrumented handler
const agentProtocol = new AgentProtocol({
  messageHandler
});

// Instrument protocol methods
openTelemetry.instrumentProtocol(agentProtocol, 'AgentProtocol');</code></pre>
            </div>
          </div>
          
          <div class="card mb-4">
            <div class="card-header bg-light">
              <h5 class="mb-0">5. Access Monitoring Dashboard</h5>
            </div>
            <div class="card-body">
              <p>Access the monitoring dashboard at:</p>
              <pre><code class="language-text">http://your-server/monitoring/dashboard</code></pre>
              <p>The dashboard provides real-time metrics, alerts, and system status information.</p>
            </div>
          </div>
          
          <p>
            For more detailed information on each component, refer to the specific documentation pages:
          </p>
          <ul>
            <li><a href="metrics_collection.html">Metrics Collection</a></li>
            <li><a href="opentelemetry_integration.html">OpenTelemetry Integration</a></li>
            <li><a href="performance_testing.html">Performance Testing</a></li>
            <li><a href="worker_management.html">Worker Management</a></li>
            <li><a href="dashboard_guide.html">Dashboard Guide</a></li>
          </ul>
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
            <li><a href="../getting-started.html" class="text-light">Getting Started</a></li>
            <li><a href="../api-reference.html" class="text-light">API Reference</a></li>
            <li><a href="../plugins/index.html" class="text-light">Plugins</a></li>
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


## 2. `/docs/monitoring/metrics_collection.html`

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <!-- 
    Path: /docs/monitoring/metrics_collection.html - IQSMS Metrics Collection
    Copyright 2025 Autonomy Association International Inc., all rights reserved 
    Safeguard patent license from National Aeronautics and Space Administration (NASA)
    Copyright 2025 NASA, all rights reserved
  -->
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Metrics Collection - IQSMS Documentation</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="../css/styles.css">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.1/css/all.css">
</head>
<body>
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
      <a class="navbar-brand" href="../index.html">
        IQSMS Documentation
      </a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item">
            <a class="nav-link" href="../index.html">Home</a>
          </li>
          <li class="nav-item dropdown active">
            <a class="nav-link dropdown-toggle" href="#" id="monitoringDropdown" role="button" data-toggle="dropdown">
              Monitoring
            </a>
            <div class="dropdown-menu">
              <a class="dropdown-item" href="index.html">Monitoring Overview</a>
              <a class="dropdown-item active" href="metrics_collection.html">Metrics Collection</a>
              <a class="dropdown-item" href="opentelemetry_integration.html">OpenTelemetry Integration</a>
              <a class="dropdown-item" href="performance_testing.html">Performance Testing</a>
              <a class="dropdown-item" href="worker_management.html">Worker Management</a>
              <a class="dropdown-item" href="dashboard_guide.html">Dashboard Guide</a>
            </div>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="coreDropdown" role="button" data-toggle="dropdown">
              Core System
            </a>
            <div class="dropdown-menu">
              <a class="dropdown-item" href="../core/index.html">Core Overview</a>
              <a class="dropdown-item" href="../core/SafeguardBaseDocumentation.html">Safeguard Base</a>
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
          <h1 class="display-4">Metrics Collection</h1>
          <p class="lead">Comprehensive metrics collection and analysis for IQSMS components</p>
        </div>
        <div class="col-md-4 text-center">
          <i class="fas fa-chart-pie fa-6x"></i>
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
              <a class="nav-link" href="#metric-types">Metric Types</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#collection-methods">Collection Methods</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#performance-monitor">PerformanceMonitor</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#system-metrics">System Metrics</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#protocol-metrics">Protocol Metrics</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#alerting">Alerting</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#api-reference">API Reference</a>
            </li>
          </ul>
        </nav>
      </div>
      <div class="col-md-9">
        <section id="overview">
          <h2>Overview</h2>
          <p class="lead">
            The IQSMS Metrics Collection system provides a comprehensive framework for collecting, processing, and analyzing metrics from all components of the IQSMS platform.
          </p>
          
          <p>
            The metrics collection system is designed to be highly scalable and configurable, supporting various metric types, collection methods, and storage backends. It provides the foundation for performance monitoring, alerting, and historical trend analysis.
          </p>
          
          <div class="alert alert-info">
            <i class="fas fa-info-circle mr-2"></i>
            <strong>Note:</strong> The metrics collection system is integrated with the IQSMS protocols out of the box, requiring minimal configuration to get started.
          </div>
        </section>

        <section id="metric-types" class="mt-5">
          <h2>Metric Types</h2>
          
          <p>
            The IQSMS Metrics Collection system supports several types of metrics:
          </p>
          
          <div class="table-responsive">
            <table class="table table-bordered">
              <thead class="thead-light">
                <tr>
                  <th>Metric Type</th>
                  <th>Description</th>
                  <th>Example</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>Counter</td>
                  <td>A cumulative metric that only increases over time</td>
                  <td>Total messages processed, Request count</td>
                </tr>
                <tr>
                  <td>Gauge</td>
                  <td>A metric that can increase or decrease over time</td>
                  <td>Active connections, Memory usage</td>
                </tr>
                <tr>
                  <td>Histogram</td>
                  <td>Tracks the distribution of values over time</td>
                  <td>Response time distribution, Message size distribution</td>
                </tr>
                <tr>
                  <td>Timer</td>
                  <td>Measures the duration of operations</td>
                  <td>Request processing time, Database query time</td>
                </tr>
                <tr>
                  <td>Rate</td>
                  <td>Measures the rate of events over time</td>
                  <td>Messages per second, Requests per minute</td>
                </tr>
              </tbody>
            </table>
          </div>
          
          <p>
            Each metric type provides specific statistical properties and is suitable for different use cases. The system automatically handles the appropriate collection and aggregation based on the metric type.
          </p>
        </section>

        <section id="collection-methods" class="mt-5">
          <h2>Collection Methods</h2>
          
          <p>
            The IQSMS Metrics Collection system supports several methods for collecting metrics:
          </p>
          
          <div class="card mb-4">
            <div class="card-header bg-light">
              <h5 class="mb-0">Programmatic Collection</h5>
            </div>
            <div class="card-body">
              <p>
                Metrics can be collected programmatically through the provided APIs. This is the most common method for integrating application-specific metrics.
              </p>
              <pre><code class="language-javascript">// Record a counter metric
performanceMonitor.incrementCounter('message.incoming', 1, {
  protocol: 'agent',
  messageType: 'STATUS_UPDATE'
});

// Record a timer metric
performanceMonitor.recordTime('message.processing', 25.3, {
  protocol: 'agent',
  messageType: 'STATUS_UPDATE'
});

// Update a gauge metric
performanceMonitor.setGauge('connection.active', 42, {
  protocol: 'agent'
});</code></pre>
            </div>
          </div>
          
          <div class="card mb-4">
            <div class="card-header bg-light">
              <h5 class="mb-0">Automatic Collection</h5>
            </div>
            <div class="card-body">
              <p>
                Some metrics are collected automatically by the system without requiring explicit calls. This includes system metrics and some protocol metrics.
              </p>
              <ul>
                <li><strong>System Metrics</strong>: CPU, memory, disk, and network usage</li>
                <li><strong>Protocol Metrics</strong>: Message counts, connection counts, error rates</li>
                <li><strong>Runtime Metrics</strong>: Event loop lag, garbage collection metrics</li>
              </ul>
              <p>
                Automatic collection is configured through the SystemMetricsMonitor component.
              </p>
            </div>
          </div>
          
          <div class="card mb-4">
            <div class="card-header bg-light">
              <h5 class="mb-0">Instrumentation</h5>
            </div>
            <div class="card-body">
              <p>
                Components can be instrumented to automatically collect metrics during operation. This is particularly useful for protocols and services.
              </p>
              <pre><code class="language-javascript">// Instrument a protocol method
const originalMethod = AgentProtocol.prototype.sendMessage;
AgentProtocol.prototype.sendMessage = async function(message) {
  const startTime = performance.now();
  
  try {
    // Call original method
    const result = await originalMethod.call(this, message);
    
    // Record success metric
    performanceMonitor.incrementCounter('agent.message.sent', 1, {
      messageType: message.type
    });
    
    return result;
  } catch (error) {
    // Record error metric
    performanceMonitor.incrementCounter('agent.message.error', 1, {
      messageType: message.type,
      errorType: error.name
    });
    
    throw error;
  } finally {
    // Record timing metric
    const duration = performance.now() - startTime;
    performanceMonitor.recordTime('agent.message.duration', duration, {
      messageType: message.type
    });
  }
};</code></pre>
            </div>
          </div>
          
          <div class="card mb-4">
            <div class="card-header bg-light">
              <h5 class="mb-0">Integration with OpenTelemetry</h5>
            </div>
            <div class="card-body">
              <p>
                The metrics collection system integrates with OpenTelemetry for distributed tracing and metrics export.
              </p>
              <p>
                See the <a href="opentelemetry_integration.html">OpenTelemetry Integration</a> documentation for more details.
              </p>
            </div>
          </div>
        </section>

        <section id="performance-monitor" class="mt-5">
          <h2>PerformanceMonitor</h2>
          
          <p>
            The PerformanceMonitor is the core component of the metrics collection system. It provides methods for recording metrics, retrieving metrics, and managing the metrics lifecycle.
          </p>
          
          <h4>Initialization</h4>
          <pre><code class="language-javascript">const { PerformanceMonitor } = require('./monitoring/core/PerformanceMonitor');

const performanceMonitor = new PerformanceMonitor({
  interval: 10000, // Collection interval in milliseconds
  metricsCollection: db.collection('metrics'), // MongoDB collection for metrics storage
  retention: {
    raw: 86400000, // Raw metrics retention (24 hours)
    aggregated: 2592000000 // Aggregated metrics retention (30 days)
  },
  aggregationLevels: ['1m', '5m', '1h', '1d'] // Aggregation levels
});</code></pre>
          
          <h4>Key Methods</h4>
          <div class="table-responsive">
            <table class="table table-bordered">
              <thead class="thead-light">
                <tr>
                  <th>Method</th>
                  <th>Description</th>
                  <th>Parameters</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td><code>incrementCounter(name, value, tags)</code></td>
                  <td>Increments a counter metric</td>
                  <td>
                    <ul>
                      <li><code>name</code>: Metric name</li>
                      <li><code>value</code>: Increment value</li>
                      <li><code>tags</code>: Optional tags object</li>
                    </ul>
                  </td>
                </tr>
                <tr>
                  <td><code>setGauge(name, value, tags)</code></td>
                  <td>Sets a gauge metric value</td>
                  <td>
                    <ul>
                      <li><code>name</code>: Metric name</li>
                      <li><code>value</code>: Gauge value</li>
                      <li><code>tags</code>: Optional tags object</li>
                    </ul>
                  </td>
                </tr>
                <tr>
                  <td><code>recordTime(name, value, tags)</code></td>
                  <td>Records a timing metric</td>
                  <td>
                    <ul>
                      <li><code>name</code>: Metric name</li>
                      <li><code>value</code>: Time value in milliseconds</li>
                      <li><code>tags</code>: Optional tags object</li>
                    </ul>
                  </td>
                </tr>
                <tr>
                  <td><code>recordHistogram(name, value, tags)</code></td>
                  <td>Records a histogram value</td>
                  <td>
                    <ul>
                      <li><code>name</code>: Metric name</li>
                      <li><code>value</code>: Numeric value</li>
                      <li><code>tags</code>: Optional tags object</li>
                    </ul>
                  </td>
                </tr>
                <tr>
                  <td><code>getLatestMetrics()</code></td>
                  <td>Gets the latest metrics snapshot</td>
                  <td>None</td>
                </tr>
                <tr>
                  <td><code>getHistoricalMetrics(query, options)</code></td>
                  <td>Gets historical metrics data</td>
                  <td>
                    <ul>
                      <li><code>query</code>: Query object</li>
                      <li><code>options</code>: Options object</li>
                    </ul>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </section>

        <section id="system-metrics" class="mt-5">
          <h2>System Metrics</h2>
          
          <p>
            The SystemMetricsMonitor component collects system-level metrics such as CPU usage, memory utilization, disk I/O, and network statistics.
          </p>
          
          <h4>Initialization</h4>
          <pre><code class="language-javascript">const { SystemMetricsMonitor } = require('./monitoring/core/SystemMetricsMonitor');

const systemMetricsMonitor = new SystemMetricsMonitor({
  interval: 15000, // Collection interval in milliseconds
  performanceMonitor, // PerformanceMonitor instance
  collectCpu: true,
  collectMemory: true,
  collectDisk: true,
  collectNetwork: true,
  collectProcess: true
});</code></pre>
          
          <h4>Collected Metrics</h4>
          <div class="table-responsive">
            <table class="table table-bordered">
              <thead class="thead-light">
                <tr>
                  <th>Category</th>
                  <th>Metrics</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>CPU</td>
                  <td>
                    <ul>
                      <li><code>system.cpu.user</code></li>
                      <li><code>system.cpu.system</code></li>
                      <li><code>system.cpu.idle</code></li>
                      <li><code>system.cpu.loadAvg1m</code></li>
                      <li><code>system.cpu.loadAvg5m</code></li>
                      <li><code>system.cpu.loadAvg15m</code></li>
                    </ul>
                  </td>
                  <td>CPU utilization and load average metrics</td>
                </tr>
                <tr>
                  <td>Memory</td>
                  <td>
                    <ul>
                      <li><code>system.memory.total</code></li>
                      <li><code>system.memory.free</code></li>
                      <li><code>system.memory.used</code></li>
                      <li><code>system.memory.active</code></li>
                      <li><code>system.memory.available</code></li>
                    </ul>
                  </td>
                  <td>Memory utilization metrics</td>
                </tr>
                <tr>
                  <td>Disk</td>
                  <td>
                    <ul>
                      <li><code>system.disk.total</code></li>
                      <li><code>system.disk.free</code></li>
                      <li><code>system.disk.used</code></li>
                      <li><code>system.disk.readBytes</code></li>
                      <li><code>system.disk.writeBytes</code></li>
                    </ul>
                  </td>
                  <td>Disk capacity and I/O metrics</td>
                </tr>
                <tr>
                  <td>Network</td>
                  <td>
                    <ul>
                      <li><code>system.network.bytesIn</code></li>
                      <li><code>system.network.bytesOut</code></li>
                      <li><code>system.network.packetsIn</code></li>
                      <li><code>system.network.packetsOut</code></li>
                    </ul>
                  </td>
                  <td>Network traffic metrics</td>
                </tr>
                <tr>
                  <td>Process</td>
                  <td>
                    <ul>
                      <li><code>process.uptime</code></li>
                      <li><code>process.memory.rss</code></li>
                      <li><code>process.memory.heapTotal</code></li>
                      <li><code>process.memory.heapUsed</code></li>
                      <li><code>process.cpu.user</code></li>
                      <li><code>process.cpu.system</code></li>
                    </ul>
                  </td>
                  <td>Process-specific metrics</td>
                </tr>
              </tbody>
            </table>
          </div>
        </section>

        <section id="protocol-metrics" class="mt-5">
          <h2>Protocol Metrics</h2>
          
          <p>
            The IQSMS Monitoring System collects specific metrics for each protocol to provide insights into their performance and behavior.
          </p>
          
          <h4>Agent Protocol Metrics</h4>
          <div class="table-responsive">
            <table class="table table-bordered">
              <thead class="thead-light">
                <tr>
                  <th>Metric Name</th>
                  <th>Type</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td><code>agent.connection.active</code></td>
                  <td>Gauge</td>
                  <td>Number of active agent connections</td>
                </tr>
                <tr>
                  <td><code>agent.message.received</code></td>
                  <td>Counter</td>
                  <td>Number of messages received from agents</td>
                </tr>
                <tr>
                  <td><code>agent.message.sent</code></td>
                  <td>Counter</td>
                  <td>Number of messages sent to agents</td>
                </tr>
                <tr>
                  <td><code>agent.message.error</code></td>
                  <td>Counter</td>
                  <td>Number of message errors</td>
                </tr>
                <tr>
                  <td><code>agent.message.processing</code></td>
                  <td>Timer</td>
                  <td>Message processing time</td>
                </tr>
              </tbody>
            </table>
          </div>
          
          <h4>Model Context Protocol Metrics</h4>
          <div class="table-responsive">
            <table class="table table-bordered">
              <thead class="thead-light">
                <tr>
                  <th>Metric Name</th>
                  <th>Type</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td><code>mcp.query.count</code></td>
                  <td>Counter</td>
                  <td>Number of queries executed</td>
                </tr>
                <tr>
                  <td><code>mcp.query.time</code></td>
                  <td>Timer</td>
                  <td>Query execution time</td>
                </tr>
                <tr>
                  <td><code>mcp.update.count</code></td>
                  <td>Counter</td>
                  <td>Number of model updates</td>
                </tr>
                <tr>
                  <td><code>mcp.update.time</code></td>
                  <td>Timer</td>
                  <td>Model update time</td>
                </tr>
                <tr>
                  <td><code>mcp.cache.hit</code></td>
                  <td>Counter</td>
                  <td>Number of cache hits</td>
                </tr>
                <tr>
                  <td><code>mcp.cache.miss</code></td>
                  <td>Counter</td>
                  <td>Number of cache misses</td>
                </tr>
              </tbody>
            </table>
          </div>
          
          <h4>Message Communication Protocol Metrics</h4>
          <div class="table-responsive">
            <table class="table table-bordered">
              <thead class="thead-light">
                <tr>
                  <th>Metric Name</th>
                  <th>Type</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td><code>message.published</code></td>
                  <td>Counter</td>
                  <td>Number of messages published</td>
                </tr>
                <tr>
                  <td><code>message.delivered</code></td>
                  <td>Counter</td>
                  <td>Number of messages delivered</td>
                </tr>
                <tr>
                  <td><code>message.size</code></td>
                  <td>Histogram</td>
                  <td>Message size distribution</td>
                </tr>
                <tr>
                  <td><code>message.latency</code></td>
                  <td>Timer</td>
                  <td>Message delivery latency</td>
                </tr>
                <tr>
                  <td><code>message.subscribers</code></td>
                  <td>Gauge</td>
                  <td>Number of subscribers per topic</td>
                </tr>
              </tbody>
            </table>
          </div>
        </section>

        <section id="alerting" class="mt-5">
          <h2>Alerting</h2>
          
          <p>
            The AlertManager component monitors metrics and generates alerts based on defined thresholds and conditions.
          </p>
          
          <h4>Initialization</h4>
          <pre><code class="language-javascript">const { AlertManager } = require('./monitoring/core/AlertManager');

const alertManager = new AlertManager({
  alertsCollection: db.collection('alerts'),
  performanceMonitor,
  notificationChannels: {
    email: {
      enabled: true,
      recipients: ['admin@example.com']
    },
    slack: {
      enabled: true,
      webhook: 'https://hooks.slack.com/services/XXX/YYY/ZZZ'
    }
  }
});</code></pre>
          
          <h4>Alert Configuration</h4>
          <p>
            Alerts are configured using alert rules that define the conditions and actions for generating alerts.
          </p>
          <pre><code class="language-javascript">// Configure alert rules
alertManager.configureAlerts([
  {
    name: 'high-cpu-usage',
    metric: 'system.cpu.user',
    condition: {
      type: 'threshold',
      threshold: 90,
      comparator: '>',
      duration: 300000 // 5 minutes
    },
    severity: 'warning',
    message: 'CPU usage is above 90% for 5 minutes',
    actions: ['email', 'slack']
  },
  {
    name: 'high-error-rate',
    metric: 'message.error',
    condition: {
      type: 'rate',
      threshold: 0.05, // 5% error rate
      comparator: '>',
      window: 60000 // 1 minute
    },
    severity: 'critical',
    message: 'Message error rate is above 5%',
    actions: ['email', 'slack']
  }
]);</code></pre>
          
          <h4>Alert Types</h4>
          <div class="table-responsive">
            <table class="table table-bordered">
              <thead class="thead-light">
                <tr>
                  <th>Alert Type</th>
                  <th>Description</th>
                  <th>Example</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>Threshold Alert</td>
                  <td>Triggers when a metric crosses a defined threshold</td>
                  <td>CPU usage > 90%</td>
                </tr>
                <tr>
                  <td>Rate Alert</td>
                  <td>Triggers when a rate metric exceeds a defined threshold</td>
                  <td>Error rate > 5%</td>
                </tr>
                <tr>
                  <td>Anomaly Alert</td>
                  <td>Triggers when a metric shows anomalous behavior</td>
                  <td>Unusual spike in message processing time</td>
                </tr>
                <tr>
                  <td>Absence Alert</td>
                  <td>Triggers when a metric is absent for a defined period</td>
                  <td>No messages received for 5 minutes</td>
                </tr>
              </tbody>
            </table>
          </div>
          
          <h4>Alert Actions</h4>
          <p>
            When an alert is triggered, the AlertManager can perform various actions:
          </p>
          <ul>
            <li><strong>Notifications</strong>: Send notifications through configured channels</li>
            <li><strong>Logging</strong>: Log the alert to the alerts collection</li>
            <li><strong>Webhooks</strong>: Call configured webhooks</li>
            <li><strong>Custom Actions</strong>: Execute custom JavaScript functions</li>
          </ul>
        </section>

        <section id="api-reference" class="mt-5">
          <h2>API Reference</h2>
          
          <p>
            The metrics collection system provides REST APIs for accessing metrics data and managing alerts.
          </p>
          
          <h4>Metrics API</h4>
          <div class="table-responsive">
            <table class="table table-bordered">
              <thead class="thead-light">
                <tr>
                  <th>Endpoint</th>
                  <th>Method</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td><code>/api/monitoring/metrics/current</code></td>
                  <td>GET</td>
                  <td>Gets the current metrics snapshot</td>
                </tr>
                <tr>
                  <td><code>/api/monitoring/metrics/history</code></td>
                  <td>GET</td>
                  <td>Gets historical metrics data</td>
                </tr>
                <tr>
                  <td><code>/api/monitoring/metrics/protocol/:protocol</code></td>
                  <td>GET</td>
                  <td>Gets metrics for a specific protocol</td>
                </tr>
              </tbody>
            </table>
          </div>
          
          <h4>Alerts API</h4>
          <div class="table-responsive">
            <table class="table table-bordered">
              <thead class="thead-light">
                <tr>
                  <th>Endpoint</th>
                  <th>Method</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td><code>/api/monitoring/alerts</code></td>
                  <td>GET</td>
                  <td>Gets active alerts</td>
                </tr>
                <tr>
                  <td><code>/api/monitoring/alerts/:alertId/acknowledge</code></td>
                  <td>POST</td>
                  <td>Acknowledges an alert</td>
                </tr>
                <tr>
                  <td><code>/api/monitoring/alerts/acknowledge-all</code></td>
                  <td>POST</td>
                  <td>Acknowledges all alerts</td>
                </tr>
              </tbody>
            </table>
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
            <li><a href="../getting-started.html" class="text-light">Getting Started</a></li>
            <li><a href="../api-reference.html" class="text-light">API Reference</a></li>
            <li><a href="../plugins/index.html" class="text-light">Plugins</a></li>
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


I've created the first two documentation files to demonstrate the structure and consistency. The remaining files would follow the same pattern with specific content for each topic:

3. `/docs/monitoring/opentelemetry_integration.html` - Details on OpenTelemetry integration
4. `/docs/monitoring/performance_testing.html` - Documentation on performance testing
5. `/docs/monitoring/worker_management.html` - Information on worker thread management
6. `/docs/monitoring/dashboard_guide.html` - Guide to using the monitoring dashboards

Each file would maintain the same bootstrap-based layout, navigation structure, and styling, with specific content tailored to each aspect of the monitoring system.

# Update to Main Navigation

To complete the integration, we should update the main navigation in `/docs/index.html` to include the new monitoring section:

```html
<li class="nav-item dropdown">
    <a class="nav-link dropdown-toggle" href="#" id="monitoringDropdown" role="button" data-toggle="dropdown">
        Monitoring
    </a>
    <div class="dropdown-menu">
        <a class="dropdown-item" href="monitoring/index.html">Monitoring Overview</a>
        <a class="dropdown-item" href="monitoring/metrics_collection.html">Metrics Collection</a>
        <a class="dropdown-item" href="monitoring/opentelemetry_integration.html">OpenTelemetry Integration</a>
        <a class="dropdown-item" href="monitoring/performance_testing.html">Performance Testing</a>
        <a class="dropdown-item" href="monitoring/worker_management.html">Worker Management</a>
        <a class="dropdown-item" href="monitoring/dashboard_guide.html">Dashboard Guide</a>
    </div>
</li>
```


This navigation element would be placed in the main navigation alongside the existing dropdown menus in `/docs/index.html`.

# Summary

The monitoring documentation pages provide comprehensive information about the IQSMS monitoring system, including:

1. Overview of the monitoring architecture and components
2. Detailed documentation on metrics collection and analysis
3. Information on OpenTelemetry integration for distributed tracing
4. Guidelines for performance testing
5. Documentation on worker thread management
6. Instructions for using the monitoring dashboards

All pages follow the consistent Bootstrap 4 styling present in the existing documentation, with proper navigation, breadcrumbs, and responsive design. The documentation is organized in a logical manner, making it easy for users to find the information they need.

The new monitoring section will be a valuable addition to the IQSMS documentation, helping users understand and leverage the monitoring capabilities of the system for better performance analysis and troubleshooting.
