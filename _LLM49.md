# Documentation Implementation Plan

I'll create the missing documentation files for the SAFEGUARD platform's monitoring system and discovery service. Here's my implementation plan:

## Phase 1: Create Monitoring Documentation Files
1. Create `/docs/monitoring/opentelemetry_integration.html`
2. Create `/docs/monitoring/performance_testing.html`
3. Create `/docs/monitoring/worker_management.html`
4. Create `/docs/monitoring/dashboard_guide.html`

## Phase 2: Create Discovery Service Documentation
1. Create documentation for Well-Known Discovery Service
2. Create documentation for Protocol Discovery endpoints
3. Create documentation for Plugin Discovery endpoints

## Phase 3: Update Navigation
1. Review and update `/docs/index.html` to include links to new pages
2. Ensure consistent navigation across all pages

Now let's begin implementation, starting with reviewing the index.html to understand the navigation structure.Let me explore the project structure to understand the documentation files better.Let me try an alternative approach to access the files:# Implementation Plan for IQSMS Documentation

I'll implement the four missing documentation pages for the monitoring system and then document the Well-Known Discovery Service. Let me outline my plan before proceeding with implementation.

## Plan Overview

1. **Assess Current Structure**: I'll first examine the existing monitoring documentation to ensure consistency.
2. **Create Missing Monitoring Pages**:
    - `/docs/monitoring/opentelemetry_integration.html`
    - `/docs/monitoring/performance_testing.html`
    - `/docs/monitoring/worker_management.html`
    - `/docs/monitoring/dashboard_guide.html`
3. **Document Well-Known Discovery Service**:
    - Create documentation for the service and its endpoints
    - Include integration information for plugins

Each page will follow the Bootstrap 4 design pattern used in the existing documentation, with consistent navigation, styling, and footer elements.

## Let's implement the plan:

### 1. Create OpenTelemetry Integration documentation# Implementation Plan for Monitoring Documentation

I'll be creating the four missing monitoring documentation files while ensuring they maintain a consistent Bootstrap 4 design and proper linking with the existing documentation. Let me outline my plan before diving into implementation.

## Plan Overview

1. Analyze existing documentation structure and styling
2. Create the four missing files:
    - `/docs/monitoring/opentelemetry_integration.html`
    - `/docs/monitoring/performance_testing.html`
    - `/docs/monitoring/worker_management.html`
    - `/docs/monitoring/dashboard_guide.html`
3. Ensure navigation is consistent across all files
4. Review and validate links between documentation pages

## Implementation Details

For each file, I will:
1. Use the existing Bootstrap 4 template
2. Maintain consistent navigation structure
3. Include proper cross-references to related documentation
4. Include copyright notices
5. Ensure proper section organization with a table of contents
6. Incorporate appropriate FontAwesome icons

Let me now create each file:

## 1. OpenTelemetry Integration Documentation

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <!-- 
    Path: /docs/monitoring/opentelemetry_integration.html - IQSMS OpenTelemetry Integration
    Copyright 2025 Autonomy Association International Inc., all rights reserved 
    Safeguard patent license from National Aeronautics and Space Administration (NASA)
    Copyright 2025 NASA, all rights reserved
  -->
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>OpenTelemetry Integration - IQSMS Documentation</title>
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
              <a class="dropdown-item" href="metrics_collection.html">Metrics Collection</a>
              <a class="dropdown-item active" href="opentelemetry_integration.html">OpenTelemetry Integration</a>
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
          <h1 class="display-4">OpenTelemetry Integration</h1>
          <p class="lead">Distributed tracing and observability for IQSMS components</p>
        </div>
        <div class="col-md-4 text-center">
          <i class="fas fa-project-diagram fa-6x"></i>
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
              <a class="nav-link" href="#setup-configuration">Setup & Configuration</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#protocol-instrumentation">Protocol Instrumentation</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#tracing-concepts">Tracing Concepts</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#exporters">Exporters</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#metrics-integration">Metrics Integration</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#troubleshooting">Troubleshooting</a>
            </li>
          </ul>
        </nav>
      </div>
      <div class="col-md-9">
        <section id="overview">
          <h2>Overview</h2>
          <p class="lead">
            The IQSMS OpenTelemetry Integration provides distributed tracing and observability capabilities for all components of the IQSMS platform.
          </p>
          
          <p>
            OpenTelemetry is an open-source observability framework that provides a standardized approach to collecting, processing, and exporting telemetry data such as traces, metrics, and logs. The IQSMS platform integrates with OpenTelemetry to provide end-to-end visibility into the performance and behavior of distributed systems.
          </p>
          
          <div class="alert alert-info">
            <i class="fas fa-info-circle mr-2"></i>
            <strong>Note:</strong> The OpenTelemetry integration is built on the official OpenTelemetry Node.js SDK and supports all major OpenTelemetry exporters including Zipkin, Jaeger, and the OpenTelemetry Collector.
          </div>
        </section>

        <section id="key-features" class="mt-5">
          <h2>Key Features</h2>
          
          <div class="row mt-4">
            <div class="col-lg-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h4 class="card-title"><i class="fas fa-project-diagram text-primary mr-2"></i>Distributed Tracing</h4>
                  <p class="card-text">End-to-end transaction tracing across distributed components.</p>
                  <ul>
                    <li>Context propagation across services</li>
                    <li>Cross-protocol correlation</li>
                    <li>Automatic instrumentation of key components</li>
                    <li>Custom span attributes for domain-specific data</li>
                  </ul>
                </div>
              </div>
            </div>
            
            <div class="col-lg-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h4 class="card-title"><i class="fas fa-chart-line text-primary mr-2"></i>Metrics Export</h4>
                  <p class="card-text">Export IQSMS metrics to OpenTelemetry-compatible backends.</p>
                  <ul>
                    <li>Counter metrics</li>
                    <li>Gauge metrics</li>
                    <li>Histogram metrics</li>
                    <li>Automatic correlation with traces</li>
                  </ul>
                </div>
              </div>
            </div>
            
            <div class="col-lg-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h4 class="card-title"><i class="fas fa-plug text-primary mr-2"></i>Multiple Exporters</h4>
                  <p class="card-text">Support for various OpenTelemetry exporters.</p>
                  <ul>
                    <li>Zipkin</li>
                    <li>Jaeger</li>
                    <li>OpenTelemetry Collector</li>
                    <li>Prometheus</li>
                  </ul>
                </div>
              </div>
            </div>
            
            <div class="col-lg-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h4 class="card-title"><i class="fas fa-code text-primary mr-2"></i>Simplified API</h4>
                  <p class="card-text">Easy-to-use API for manual instrumentation.</p>
                  <ul>
                    <li>Simplified trace creation</li>
                    <li>Protocol-specific helpers</li>
                    <li>Automatic context management</li>
                    <li>Error tracking</li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </section>

        <section id="setup-configuration" class="mt-5">
          <h2>Setup & Configuration</h2>
          
          <p>
            The OpenTelemetry integration can be set up and configured using the OpenTelemetryIntegration class.
          </p>
          
          <h4>Installation</h4>
          <p>Ensure all required dependencies are installed:</p>
          <pre><code class="language-bash">npm install @opentelemetry/api @opentelemetry/sdk-trace-node @opentelemetry/sdk-metrics \
  @opentelemetry/exporter-zipkin @opentelemetry/exporter-jaeger @opentelemetry/exporter-prometheus \
  @opentelemetry/auto-instrumentations-node @opentelemetry/context-async-hooks</code></pre>
          
          <h4>Basic Configuration</h4>
          <pre><code class="language-javascript">const { OpenTelemetryIntegration } = require('./monitoring/integration/OpenTelemetryIntegration');

// Initialize OpenTelemetry with basic configuration
const openTelemetry = new OpenTelemetryIntegration({
  serviceName: 'iqsms-server',
  serviceVersion: '1.0.0',
  environment: 'production'
});

// Get the tracer
const tracer = openTelemetry.initialize();</code></pre>
          
          <h4>Advanced Configuration</h4>
          <pre><code class="language-javascript">// Initialize OpenTelemetry with advanced configuration
const openTelemetry = new OpenTelemetryIntegration({
  serviceName: 'iqsms-server',
  serviceVersion: '1.0.0',
  environment: 'production',
  
  // Sampling configuration
  sampling: {
    type: 'probability',
    probability: 0.5 // 50% sampling rate
  },
  
  // Exporter configuration
  exporters: {
    zipkin: {
      enabled: true,
      url: 'http://zipkin:9411/api/v2/spans'
    },
    jaeger: {
      enabled: false
    },
    console: {
      enabled: true
    },
    otlp: {
      enabled: false,
      url: 'http://otel-collector:4317'
    }
  },
  
  // Auto-instrumentation configuration
  autoInstrumentation: {
    enabled: true,
    http: true,
    grpc: true,
    mongodb: true,
    redis: true,
    express: true
  },
  
  // Resource attributes
  resourceAttributes: {
    'deployment.environment': 'production',
    'service.instance.id': 'server-1',
    'host.name': 'hostname'
  }
});</code></pre>
        </section>

        <section id="protocol-instrumentation" class="mt-5">
          <h2>Protocol Instrumentation</h2>
          
          <p>
            The OpenTelemetry integration provides automatic instrumentation for IQSMS protocols, enabling distributed tracing across protocol boundaries.
          </p>
          
          <h4>Agent Protocol Instrumentation</h4>
          <pre><code class="language-javascript">// Instrument Agent Protocol
openTelemetry.instrumentProtocol(agentProtocol, 'AgentProtocol', {
  // Methods to instrument
  methods: [
    'initialize',
    'sendMessage',
    'handleIncomingMessage',
    'connect',
    'disconnect'
  ],
  
  // Custom attribute extractors
  attributeExtractors: {
    'sendMessage': (args) => ({
      'agent.message.type': args[0].type,
      'agent.message.id': args[0].id,
      'agent.message.size': JSON.stringify(args[0]).length
    })
  }
});</code></pre>
          
          <h4>Model Context Protocol Instrumentation</h4>
          <pre><code class="language-javascript">// Instrument Model Context Protocol
openTelemetry.instrumentProtocol(modelContextProtocol, 'ModelContextProtocol', {
  // Methods to instrument
  methods: [
    'getModel',
    'updateModel',
    'queryModel',
    'removeModel',
    'createContext',
    'executeQuery'
  ],
  
  // Custom attribute extractors
  attributeExtractors: {
    'queryModel': (args) => ({
      'mcp.model.type': args[0],
      'mcp.model.id': args[1],
      'mcp.query.complexity': args[2]?.complexity || 'low'
    })
  }
});</code></pre>
          
          <h4>Message Handler Instrumentation</h4>
          <pre><code class="language-javascript">// Create an instrumented message handler
const { OpenTelemetryMessageHandler } = require('./monitoring/integration/OpenTelemetryMessageHandler');

const messageHandler = new OpenTelemetryMessageHandler({
  tracer: openTelemetry.getTracer(),
  performanceMonitor,
  baseHandler: originalMessageHandler
});</code></pre>
          
          <div class="alert alert-warning mt-4">
            <i class="fas fa-exclamation-triangle mr-2"></i>
            <strong>Important:</strong> Context propagation between services requires proper header propagation. Ensure that the W3C Trace Context headers are properly propagated in all HTTP, WebSocket, and other communication channels.
          </div>
        </section>

        <section id="tracing-concepts" class="mt-5">
          <h2>Tracing Concepts</h2>
          
          <p>
            Understanding key tracing concepts is essential for effective use of the OpenTelemetry integration.
          </p>
          
          <div class="card mb-4">
            <div class="card-header bg-light">
              <h5 class="mb-0">Traces, Spans, and Context</h5>
            </div>
            <div class="card-body">
              <p>The core concepts in distributed tracing:</p>
              <ul>
                <li><strong>Trace</strong>: A trace represents the entire journey of a request as it moves through a distributed system.</li>
                <li><strong>Span</strong>: A span represents a single operation within a trace. A trace consists of multiple spans.</li>
                <li><strong>Context</strong>: Context carries trace information across process boundaries. It includes the trace ID and span ID.</li>
              </ul>
              <p>A typical trace in IQSMS might include spans for:</p>
              <ul>
                <li>HTTP request handling</li>
                <li>Authentication and authorization</li>
                <li>Protocol message processing</li>
                <li>Database operations</li>
                <li>External service calls</li>
                <li>Response generation</li>
              </ul>
            </div>
          </div>
          
          <h4>Manual Span Creation</h4>
          <p>
            While automatic instrumentation covers most scenarios, you can create spans manually for custom operations:
          </p>
          <pre><code class="language-javascript">const tracer = openTelemetry.getTracer();

// Create a new span
const span = tracer.startSpan('customOperation', {
  attributes: {
    'operation.name': 'custom-operation',
    'operation.type': 'background-task'
  }
});

try {
  // Perform the operation
  await performCustomOperation();
  
  // Set span attributes based on the result
  span.setAttribute('operation.result', 'success');
} catch (error) {
  // Record the error
  span.recordException(error);
  span.setStatus({
    code: SpanStatusCode.ERROR,
    message: error.message
  });
  throw error;
} finally {
  // End the span
  span.end();
}</code></pre>
          
          <h4>Context Propagation</h4>
          <p>
            When passing context between asynchronous operations or different services:
          </p>
          <pre><code class="language-javascript">const { context, trace } = require('@opentelemetry/api');

// Get the current context
const currentContext = context.active();

// Store the context
const storedContext = { value: currentContext };

// Later, in another function or callback
function processResult(result) {
  // Restore the context
  context.with(storedContext.value, () => {
    // Create a child span that will be properly associated with the parent
    const span = tracer.startSpan('processResult');
    try {
      // Process the result
      const processedResult = doSomethingWithResult(result);
      span.end();
      return processedResult;
    } catch (error) {
      span.recordException(error);
      span.end();
      throw error;
    }
  });
}</code></pre>
        </section>

        <section id="exporters" class="mt-5">
          <h2>Exporters</h2>
          
          <p>
            The OpenTelemetry integration supports multiple exporters for sending telemetry data to various backends.
          </p>
          
          <h4>Zipkin Exporter</h4>
          <pre><code class="language-javascript">// Configure Zipkin exporter
const openTelemetry = new OpenTelemetryIntegration({
  serviceName: 'iqsms-server',
  exporters: {
    zipkin: {
      enabled: true,
      url: 'http://zipkin:9411/api/v2/spans'
    }
  }
});</code></pre>
          
          <h4>Jaeger Exporter</h4>
          <pre><code class="language-javascript">// Configure Jaeger exporter
const openTelemetry = new OpenTelemetryIntegration({
  serviceName: 'iqsms-server',
  exporters: {
    jaeger: {
      enabled: true,
      // For HTTP Thrift
      endpoint: 'http://jaeger:14268/api/traces',
      // Or for UDP Thrift (deprecated)
      host: 'jaeger',
      port: 6832
    }
  }
});</code></pre>
          
          <h4>OpenTelemetry Collector</h4>
          <pre><code class="language-javascript">// Configure OpenTelemetry Collector exporter
const openTelemetry = new OpenTelemetryIntegration({
  serviceName: 'iqsms-server',
  exporters: {
    otlp: {
      enabled: true,
      url: 'http://otel-collector:4317', // gRPC endpoint
      httpUrl: 'http://otel-collector:4318/v1/traces', // HTTP endpoint
      headers: {
        'x-api-key': 'api-key-value'
      }
    }
  }
});</code></pre>
          
          <h4>Console Exporter</h4>
          <p>
            The console exporter is useful for development and debugging:
          </p>
          <pre><code class="language-javascript">// Configure Console exporter
const openTelemetry = new OpenTelemetryIntegration({
  serviceName: 'iqsms-server',
  exporters: {
    console: {
      enabled: true
    }
  }
});</code></pre>
          
          <div class="alert alert-info mt-4">
            <i class="fas fa-info-circle mr-2"></i>
            <strong>Note:</strong> Multiple exporters can be enabled simultaneously, allowing telemetry data to be sent to multiple backends.
          </div>
        </section>

        <section id="metrics-integration" class="mt-5">
          <h2>Metrics Integration</h2>
          
          <p>
            The OpenTelemetry integration can export IQSMS metrics to OpenTelemetry-compatible backends.
          </p>
          
          <h4>Metrics Export Configuration</h4>
          <pre><code class="language-javascript">// Initialize OpenTelemetry with metrics export
const openTelemetry = new OpenTelemetryIntegration({
  serviceName: 'iqsms-server',
  serviceVersion: '1.0.0',
  
  // Enable metrics
  metrics: {
    enabled: true,
    interval: 15000, // Export interval in milliseconds
    
    // Prometheus exporter configuration
    prometheus: {
      enabled: true,
      port: 9464,
      endpoint: '/metrics'
    }
  }
});</code></pre>
          
          <h4>Custom Metrics</h4>
          <p>
            You can create and record custom metrics using the OpenTelemetry Metrics API:
          </p>
          <pre><code class="language-javascript">// Get the meter
const meter = openTelemetry.getMeter();

// Create a counter
const requestCounter = meter.createCounter('app.request.count', {
  description: 'Count of requests',
  unit: '1'
});

// Create a histogram
const requestDuration = meter.createHistogram('app.request.duration', {
  description: 'Duration of requests',
  unit: 'ms'
});

// Record metrics
function handleRequest(req, res, next) {
  const startTime = performance.now();
  
  // Increment counter with attributes
  requestCounter.add(1, {
    method: req.method,
    route: req.route.path,
    status: res.statusCode
  });
  
  // Record request duration when finished
  res.on('finish', () => {
    const duration = performance.now() - startTime;
    requestDuration.record(duration, {
      method: req.method,
      route: req.route.path,
      status: res.statusCode
    });
  });
  
  next();
}</code></pre>
          
          <h4>Integration with PerformanceMonitor</h4>
          <p>
            The OpenTelemetry integration can be configured to automatically export metrics from the PerformanceMonitor:
          </p>
          <pre><code class="language-javascript">// Link PerformanceMonitor with OpenTelemetry
openTelemetry.linkPerformanceMonitor(performanceMonitor, {
  // Map of metric types to export
  metricTypes: ['counter', 'gauge', 'histogram', 'timer'],
  
  // Additional filtering
  filter: (metricName, metricType, metricTags) => {
    // Skip internal metrics
    if (metricName.startsWith('internal.')) {
      return false;
    }
    return true;
  }
});</code></pre>
        </section>

        <section id="troubleshooting" class="mt-5">
          <h2>Troubleshooting</h2>
          
          <div class="card mb-4">
            <div class="card-header bg-light">
              <h5 class="mb-0">Common Issues</h5>
            </div>
            <div class="card-body">
              <h6>Missing Traces</h6>
              <p>If traces are not appearing in your backend:</p>
              <ul>
                <li>Check that the exporter is properly configured with the correct URL/endpoint</li>
                <li>Verify that the sampling rate is not set too low</li>
                <li>Ensure that spans are being properly ended</li>
                <li>Check network connectivity between the IQSMS server and the tracing backend</li>
                <li>Verify that the correct context propagation is being used</li>
              </ul>
              
              <h6>Broken Trace Context</h6>
              <p>If spans are not properly connected in a trace:</p>
              <ul>
                <li>Ensure W3C Trace Context headers are being properly propagated</li>
                <li>Check that async operations are properly maintaining context</li>
                <li>Verify that all services are using compatible OpenTelemetry versions</li>
              </ul>
              
              <h6>Performance Issues</h6>
              <p>If the OpenTelemetry integration is causing performance problems:</p>
              <ul>
                <li>Reduce the sampling rate</li>
                <li>Use batch span processors</li>
                <li>Limit the number of attributes per span</li>
                <li>Consider using a local collector to buffer traces</li>
              </ul>
            </div>
          </div>
          
          <h4>Debugging</h4>
          <p>
            To debug OpenTelemetry integration issues, you can enable debug logging and use the console exporter:
          </p>
          <pre><code class="language-javascript">// Enable debug mode
const openTelemetry = new OpenTelemetryIntegration({
  serviceName: 'iqsms-server',
  debug: true,
  exporters: {
    console: {
      enabled: true
    }
  }
});

// Set OpenTelemetry API logging
const { diag, DiagLogLevel } = require('@opentelemetry/api');
diag.setLogger(new DiagConsoleLogger(), DiagLogLevel.DEBUG);</code></pre>
          
          <h4>Validation</h4>
          <p>
            To validate that traces are being properly created and exported:
          </p>
          <pre><code class="language-javascript">// Create a simple test span
const tracer = openTelemetry.getTracer();
const span = tracer.startSpan('test-span');
span.setAttribute('test.attribute', 'test-value');
span.addEvent('test-event', { 'event.detail': 'This is a test event' });
span.end();

console.log('Created test span, check your tracing backend');</code></pre>
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


## 2. Performance Testing Documentation

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <!-- 
    Path: /docs/monitoring/performance_testing.html - IQSMS Performance Testing
    Copyright 2025 Autonomy Association International Inc., all rights reserved 
    Safeguard patent license from National Aeronautics and Space Administration (NASA)
    Copyright 2025 NASA, all rights reserved
  -->
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Performance Testing - IQSMS Documentation</title>
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
              <a class="dropdown-item" href="metrics_collection.html">Metrics Collection</a>
              <a class="dropdown-item" href="opentelemetry_integration.html">OpenTelemetry Integration</a>
              <a class="dropdown-item active" href="performance_testing.html">Performance Testing</a>
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
          <h1 class="display-4">Performance Testing</h1>
          <p class="lead">Automated benchmarking and performance analysis for IQSMS components</p>
        </div>
        <div class="col-md-4 text-center">
          <i class="fas fa-flask fa-6x"></i>
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
              <a class="nav-link" href="#test-types">Test Types</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#scheduled-testing">Scheduled Testing</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#test-configuration">Test Configuration</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#baseline-management">Baseline Management</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#reporting">Reporting</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#alert-integration">Alert Integration</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#custom-tests">Custom Tests</a>
            </li>
          </ul>
        </nav>
      </div>
      <div class="col-md-9">
        <section id="overview">
          <h2>Overview</h2>
          <p class="lead">
            The IQSMS Performance Testing framework provides automated tools for benchmarking and analyzing the performance of IQSMS components.
          </p>
          
          <p>
            Performance testing is a critical aspect of maintaining the reliability and efficiency of the IQSMS platform. The performance testing framework enables automated testing of various components, comparison against established baselines, and detection of performance regressions.
          </p>
          
          <div class="alert alert-info">
            <i class="fas fa-info-circle mr-2"></i>
            <strong>Key Benefit:</strong> Regular performance testing helps identify performance issues early, before they impact production systems.
          </div>
        </section>

        <section id="test-types" class="mt-5">
          <h2>Test Types</h2>
          
          <p>
            The performance testing framework supports several types of performance tests:
          </p>
          
          <div class="row mt-4">
            <div class="col-lg-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h4 class="card-title"><i class="fas fa-tachometer-alt text-primary mr-2"></i>Load Testing</h4>
                  <p class="card-text">Tests system performance under expected load conditions.</p>
                  <ul>
                    <li>Measures response times under normal load</li>
                    <li>Validates throughput capabilities</li>
                    <li>Identifies bottlenecks in standard operations</li>
                    <li>Typically runs with 50-100% of expected peak load</li>
                  </ul>
                </div>
              </div>
            </div>
            
            <div class="col-lg-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h4 class="card-title"><i class="fas fa-weight-hanging text-primary mr-2"></i>Stress Testing</h4>
                  <p class="card-text">Tests system behavior under extreme load conditions.</p>
                  <ul>
                    <li>Identifies breaking points</li>
                    <li>Measures degradation patterns</li>
                    <li>Verifies error handling under stress</li>
                    <li>Typically runs with 150-300% of expected peak load</li>
                  </ul>
                </div>
              </div>
            </div>
            
            <div class="col-lg-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h4 class="card-title"><i class="fas fa-clock text-primary mr-2"></i>Endurance Testing</h4>
                  <p class="card-text">Tests system stability over extended periods.</p>
                  <ul>
                    <li>Identifies memory leaks and resource consumption patterns</li>
                    <li>Validates system stability over time</li>
                    <li>Measures performance degradation during extended use</li>
                    <li>Typically runs for hours or days with moderate load</li>
                  </ul>
                </div>
              </div>
            </div>
            
            <div class="col-lg-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h4 class="card-title"><i class="fas fa-bolt text-primary mr-2"></i>Spike Testing</h4>
                  <p class="card-text">Tests system response to sudden load increases.</p>
                  <ul>
                    <li>Validates recovery capabilities</li>
                    <li>Measures response to sudden load spikes</li>
                    <li>Identifies potential failure points during load transitions</li>
                    <li>Typically runs with sudden jumps from low to high load</li>
                  </ul>
                </div>
              </div>
            </div>
            
            <div class="col-lg-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h4 class="card-title"><i class="fas fa-microchip text-primary mr-2"></i>Component Testing</h4>
                  <p class="card-text">Tests performance of specific system components.</p>
                  <ul>
                    <li>Isolates performance characteristics of individual components</li>
                    <li>Validates component-specific optimizations</li>
                    <li>Provides detailed insights into component behavior</li>
                    <li>Typically focuses on one component or subsystem at a time</li>
                  </ul>
                </div>
              </div>
            </div>
            
            <div class="col-lg-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h4 class="card-title"><i class="fas fa-project-diagram text-primary mr-2"></i>Integration Testing</h4>
                  <p class="card-text">Tests performance of integrated components.</p>
                  <ul>
                    <li>Measures end-to-end transaction performance</li>
                    <li>Identifies bottlenecks in component interactions</li>
                    <li>Validates overall system performance</li>
                    <li>Typically involves multiple interconnected components</li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </section>

        <section id="scheduled-testing" class="mt-5">
          <h2>Scheduled Testing</h2>
          
          <p>
            The IQSMS Performance Testing framework supports scheduled performance tests through the ScheduledPerformanceTest component.
          </p>
          
          <h4>Configuration</h4>
          <pre><code class="language-javascript">const { ScheduledPerformanceTest } = require('./monitoring/testing/ScheduledPerformanceTest');
const { PerformanceTestRunner } = require('./monitoring/testing/PerformanceTestRunner');

// Create test runner
const testRunner = new PerformanceTestRunner({
  performanceMonitor,
  resultsCollection: db.collection('performanceTestResults')
});

// Configure scheduled tests
const scheduledTest = new ScheduledPerformanceTest({
  testRunner,
  schedule: {
    // Run tests every day at 2:00 AM
    cron: '0 2 * * *',
    timezone: 'UTC'
  },
  // Test suite to run
  testSuite: 'core-protocols',
  // Notification options
  notifications: {
    email: ['admin@example.com'],
    slack: 'https://hooks.slack.com/services/XXX/YYY/ZZZ'
  },
  // Comparison options
  comparison: {
    baseline: 'latest-stable',
    threshold: 0.15 // 15% degradation threshold
  }
});</code></pre>
          
          <h4>Test Execution</h4>
          <p>
            Scheduled tests are executed automatically based on the configured schedule. You can also trigger tests manually:
          </p>
          <pre><code class="language-javascript">// Run a scheduled test immediately
await scheduledTest.runNow();

// Run a specific test suite
await testRunner.runTestSuite('api-endpoints', {
  baseline: 'latest-stable',
  saveResults: true,
  notifyOnCompletion: true
});</code></pre>
        </section>

        <section id="test-configuration" class="mt-5">
          <h2>Test Configuration</h2>
          
          <p>
            Performance tests are configured using test definitions that specify the test parameters, workload, and success criteria.
          </p>
          
          <h4>Test Suite Configuration</h4>
          <pre><code class="language-javascript">// Define a test suite
testRunner.defineTestSuite('core-protocols', {
  description: 'Core protocols performance tests',
  tests: [
    'agent-protocol-messaging',
    'mcp-query-performance',
    'message-communication-throughput'
  ],
  // Common configuration for all tests in the suite
  commonConfig: {
    warmup: {
      duration: 30000, // 30 seconds
      rate: 0.5 // 50% of test rate
    },
    cooldown: {
      duration: 10000 // 10 seconds
    },
    metrics: [
      'cpu.usage',
      'memory.usage',
      'response.time',
      'throughput'
    ]
  }
});</code></pre>
          
          <h4>Individual Test Configuration</h4>
          <pre><code class="language-javascript">// Define an individual test
testRunner.defineTest('agent-protocol-messaging', {
  description: 'Agent Protocol messaging performance',
  type: 'load',
  duration: 300000, // 5 minutes
  
  // Load profile
  load: {
    type: 'constant',
    rate: 100, // 100 messages per second
    users: 50 // 50 concurrent users
  },
  
  // Test scenario
  scenario: async (context) => {
    const { agentProtocol, user } = context;
    
    // Create message
    const message = {
      type: 'STATUS_UPDATE',
      data: {
        status: 'ACTIVE',
        position: {
          lat: Math.random() * 180 - 90,
          lng: Math.random() * 360 - 180,
          alt: Math.random() * 1000
        },
        timestamp: Date.now()
      }
    };
    
    // Send message
    await agentProtocol.sendMessage(message, `agent-${user.id}`);
    
    // Wait for response
    const response = await context.waitForResponse(`agent-${user.id}`, 5000);
    
    // Validate response
    if (response.type !== 'STATUS_ACK') {
      throw new Error(`Invalid response type: ${response.type}`);
    }
    
    return {
      messageSize: JSON.stringify(message).length,
      responseTime: context.getLastOperationDuration(),
      success: true
    };
  },
  
  // Success criteria
  criteria: {
    responseTime: {
      p95: 200, // 95th percentile response time < 200ms
      max: 500  // Maximum response time < 500ms
    },
    successRate: 0.99, // 99% success rate
    throughput: {
      min: 90 // Minimum throughput of 90 messages per second
    }
  }
});</code></pre>
        </section>

        <section id="baseline-management" class="mt-5">
          <h2>Baseline Management</h2>
          
          <p>
            Performance test results can be compared against baselines to detect performance regressions.
          </p>
          
          <h4>Creating Baselines</h4>
          <pre><code class="language-javascript">// Create a new baseline from test results
await testRunner.createBaseline({
  name: 'release-2.5.0',
  description: 'Baseline for release 2.5.0',
  testSuite: 'core-protocols',
  // Optional: specify the test results to use
  testRunId: 'run-123456',
  // Or use the latest results
  useLatestResults: true
});</code></pre>
          
          <h4>Managing Baselines</h4>
          <pre><code class="language-javascript">// List available baselines
const baselines = await testRunner.getBaselines();

// Get a specific baseline
const baseline = await testRunner.getBaseline('release-2.5.0');

// Update baseline metadata
await testRunner.updateBaseline('release-2.5.0', {
  description: 'Updated baseline for release 2.5.0',
  isActive: true
});

// Delete a baseline
await testRunner.deleteBaseline('old-baseline');</code></pre>
          
          <h4>Comparing Against Baselines</h4>
          <pre><code class="language-javascript">// Compare test results against a baseline
const comparison = await testRunner.compareWithBaseline({
  testRunId: 'run-123456',
  baseline: 'release-2.5.0',
  threshold: 0.15 // 15% degradation threshold
});

// Get comparison details
if (comparison.hasDegradation) {
  console.log(`Performance degradation detected: ${comparison.degradationSummary}`);
  console.log('Degraded metrics:');
  comparison.degradedMetrics.forEach(metric => {
    console.log(`- ${metric.name}: ${metric.baselineValue} -> ${metric.currentValue} (${metric.changePercent}%)`);
  });
}</code></pre>
        </section>

        <section id="reporting" class="mt-5">
          <h2>Reporting</h2>
          
          <p>
            The performance testing framework provides comprehensive reporting capabilities for analyzing test results.
          </p>
          
          <h4>Test Result Reports</h4>
          <pre><code class="language-javascript">// Generate a test result report
const report = await testRunner.generateReport({
  testRunId: 'run-123456',
  format: 'html' // or 'json', 'csv'
});

// Export report to a file
await testRunner.exportReport({
  testRunId: 'run-123456',
  format: 'html',
  outputPath: '/reports/performance-test-report.html'
});</code></pre>
          
          <h4>Report Components</h4>
          <p>
            Performance test reports include the following components:
          </p>
          <ul>
            <li><strong>Summary</strong>: Overall test results and status</li>
            <li><strong>Test Details</strong>: Detailed information about the test configuration and execution</li>
            <li><strong>Metrics</strong>: Collected metrics and statistics</li>
            <li><strong>Charts</strong>: Visualizations of key metrics over time</li>
            <li><strong>Comparison</strong>: Comparison with baseline results</li>
            <li><strong>Logs</strong>: Test execution logs and events</li>
            <li><strong>Recommendations</strong>: Automated recommendations for addressing performance issues</li>
          </ul>
          
          <div class="text-center my-4">
            <img src="../images/performance-report-example.svg" alt="Performance Report Example" class="img-fluid rounded border" style="max-width: 90%;">
          </div>
        </section>

        <section id="alert-integration" class="mt-5">
          <h2>Alert Integration</h2>
          
          <p>
            The performance testing framework integrates with the IQSMS alerting system to notify of performance regressions.
          </p>
          
          <h4>Alert Configuration</h4>
          <pre><code class="language-javascript">// Configure performance test alerts
scheduledTest.configureAlerts({
  // Alert on test failure
  testFailure: {
    enabled: true,
    severity: 'critical',
    channels: ['email', 'slack']
  },
  
  // Alert on performance degradation
  performanceDegradation: {
    enabled: true,
    severity: 'warning',
    threshold: 0.15, // 15% degradation threshold
    channels: ['email', 'slack']
  },
  
  // Alert on baseline violation
  baselineViolation: {
    enabled: true,
    severity: 'warning',
    channels: ['email', 'slack']
  }
});</code></pre>
          
          <h4>Custom Alert Actions</h4>
          <pre><code class="language-javascript">// Define a custom alert action
scheduledTest.defineAlertAction('performance-degradation', async (alertData) => {
  // Log detailed alert information
  console.log(`Performance degradation detected: ${alertData.summary}`);
  
  // Create a Jira ticket
  const jiraTicket = await createJiraTicket({
    project: 'PERF',
    summary: `Performance degradation in ${alertData.testSuite}`,
    description: alertData.details,
    priority: 'High',
    labels: ['performance', 'regression']
  });
  
  // Update alert with ticket information
  await alertData.update({
    jiraTicket: jiraTicket.key,
    jiraUrl: jiraTicket.url
  });
});</code></pre>
        </section>

        <section id="custom-tests" class="mt-5">
          <h2>Custom Tests</h2>
          
          <p>
            You can create custom performance tests to address specific testing needs.
          </p>
          
          <h4>Custom Test Scenario</h4>
          <pre><code class="language-javascript">// Define a custom test scenario
testRunner.defineTest('custom-protocol-test', {
  description: 'Custom protocol performance test',
  type: 'load',
  duration: 180000, // 3 minutes
  
  // Custom load profile
  load: {
    type: 'ramp-up',
    startRate: 10,
    endRate: 100,
    steps: 5
  },
  
  // Custom initialization
  setup: async (context) => {
    // Initialize test resources
    const customProtocol = new CustomProtocol();
    await customProtocol.initialize();
    
    // Add to context for use in scenario
    context.customProtocol = customProtocol;
    
    // Create test data
    context.testData = await generateTestData(1000);
  },
  
  // Custom cleanup
  teardown: async (context) => {
    // Clean up test resources
    await context.customProtocol.shutdown();
    
    // Clean up test data
    await cleanupTestData(context.testData);
  },
  
  // Test scenario
  scenario: async (context) => {
    const { customProtocol, testData, iteration } = context;
    
    // Get test data for this iteration
    const data = testData[iteration % testData.length];
    
    // Start measuring
    const startTime = performance.now();
    
    try {
      // Execute test operation
      const result = await customProtocol.processData(data);
      
      // Measure duration
      const duration = performance.now() - startTime;
      
      // Return metrics
      return {
        duration,
        dataSize: JSON.stringify(data).length,
        resultSize: JSON.stringify(result).length,
        success: true
      };
    } catch (error) {
      // Record failure
      return {
        duration: performance.now() - startTime,
        error: error.message,
        success: false
      };
    }
  },
  
  // Custom metrics
  metrics: {
    'custom.duration': {
      extract: (result) => result.duration,
      unit: 'ms',
      aggregations: ['avg', 'p50', 'p95', 'p99']
    },
    'custom.dataSize': {
      extract: (result) => result.dataSize,
      unit: 'bytes',
      aggregations: ['avg', 'min', 'max']
    }
  },
  
  // Success criteria
  criteria: {
    'custom.duration': {
      p95: 200, // 95th percentile < 200ms
      avg: 100  // Average < 100ms
    },
    successRate: 0.995 // 99.5% success rate
  }
});</code></pre>
          
          <h4>Custom Load Patterns</h4>
          <pre><code class="language-javascript">// Define a custom load pattern
testRunner.defineLoadPattern('sawtooth', (time, config) => {
  const { period, minRate, maxRate } = config;
  const normalized = (time % period) / period;
  
  if (normalized < 0.5) {
    // Ramp up
    return minRate + (maxRate - minRate) * (normalized * 2);
  } else {
    // Sudden drop
    return minRate;
  }
});

// Use the custom load pattern
testRunner.defineTest('sawtooth-load-test', {
  description: 'Test with sawtooth load pattern',
  type: 'load',
  duration: 300000, // 5 minutes
  
  // Use the custom load pattern
  load: {
    type: 'custom',
    pattern: 'sawtooth',
    config: {
      period: 60000, // 1 minute period
      minRate: 10,   // Minimum rate
      maxRate: 100   // Maximum rate
    }
  },
  
  // Test scenario
  scenario: async (context) => {
    // Test implementation
  }
});</code></pre>
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


## 3. Worker Management Documentation

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <!-- 
    Path: /docs/monitoring/worker_management.html - IQSMS Worker Management
    Copyright 2025 Autonomy Association International Inc., all rights reserved 
    Safeguard patent license from National Aeronautics and Space Administration (NASA)
    Copyright 2025 NASA, all rights reserved
  -->
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Worker Management - IQSMS Documentation</title>
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
              <a class="dropdown-item" href="metrics_collection.html">Metrics Collection</a>
              <a class="dropdown-item" href="opentelemetry_integration.html">OpenTelemetry Integration</a>
              <a class="dropdown-item" href="performance_testing.html">Performance Testing</a>
              <a class="dropdown-item active" href="worker_management.html">Worker Management</a>
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
          <h1 class="display-4">Worker Management</h1>
          <p class="lead">Efficient worker thread management for distributed processing tasks</p>
        </div>
        <div class="col-md-4 text-center">
          <i class="fas fa-users-cog fa-6x"></i>
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
              <a class="nav-link" href="#worker-pool">Worker Pool</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#job-queue">Job Queue</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#worker-monitoring">Worker Monitoring</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#resource-management">Resource Management</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#task-prioritization">Task Prioritization</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#error-handling">Error Handling</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#scaling-strategies">Scaling Strategies</a>
            </li>
          </ul>
        </nav>
      </div>
      <div class="col-md-9">
        <section id="overview">
          <h2>Overview</h2>
          <p class="lead">
            The IQSMS Worker Management system provides a robust framework for managing worker threads and distributing tasks across them.
          </p>
          
          <p>
            The worker management system enables efficient execution of CPU-intensive tasks without blocking the main event loop. It provides facilities for worker thread creation, job scheduling, resource management, and worker health monitoring.
          </p>
          
          <div class="alert alert-info">
            <i class="fas fa-info-circle mr-2"></i>
            <strong>Key Benefit:</strong> The worker management system optimizes resource utilization and ensures high throughput for compute-intensive tasks while maintaining responsiveness in the main application thread.
          </div>
        </section>

        <section id="worker-pool" class="mt-5">
          <h2>Worker Pool</h2>
          
          <p>
            The WorkerPool component manages a pool of worker threads for executing tasks.
          </p>
          
          <h4>Worker Pool Initialization</h4>
          <pre><code class="language-javascript">const { WorkerPool } = require('./monitoring/workers/WorkerPool');

// Create a worker pool
const workerPool = new WorkerPool({
  // Number of workers to create (defaults to CPU count)
  size: 8,
  
  // Worker script path
  workerScript: './workers/generic-worker.js',
  
  // Shared worker data
  workerData: {
    appConfig: {
      logLevel: 'info',
      metricsEnabled: true
    }
  },
  
  // Worker setup timeout
  setupTimeout: 30000,
  
  // Maximum tasks per worker
  maxTasksPerWorker: 100,
  
  // Idle timeout for workers (ms)
  idleTimeout: 60000,
  
  // Resource limits per worker
  resourceLimits: {
    maxOldGenerationSizeMb: 512,
    maxYoungGenerationSizeMb: 128,
    codeRangeSizeMb: 64
  }
});</code></pre>
          
          <h4>Worker Pool Methods</h4>
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
                  <td><code>initialize()</code></td>
                  <td>Initializes the worker pool</td>
                  <td>None</td>
                </tr>
                <tr>
                  <td><code>submitTask(task, [options])</code></td>
                  <td>Submits a task for execution</td>
                  <td>
                    <ul>
                      <li><code>task</code>: Task object</li>
                      <li><code>options</code>: Task options</li>
                    </ul>
                  </td>
                </tr>
                <tr>
                  <td><code>executeTask(task, [options])</code></td>
                  <td>Executes a task directly (waits for result)</td>
                  <td>
                    <ul>
                      <li><code>task</code>: Task object</li>
                      <li><code>options</code>: Task options</li>
                    </ul>
                  </td>
                </tr>
                <tr>
                  <td><code>resize(size)</code></td>
                  <td>Resizes the worker pool</td>
                  <td>
                    <ul>
                      <li><code>size</code>: New pool size</li>
                    </ul>
                  </td>
                </tr>
                <tr>
                  <td><code>shutdown()</code></td>
                  <td>Shuts down the worker pool</td>
                  <td>None</td>
                </tr>
                <tr>
                  <td><code>getStats()</code></td>
                  <td>Gets worker pool statistics</td>
                  <td>None</td>
                </tr>
              </tbody>
            </table>
          </div>
          
          <h4>Submitting Tasks</h4>
          <pre><code class="language-javascript">// Submit a task to the worker pool
const taskId = await workerPool.submitTask({
  type: 'processData',
  data: {
    inputData: /* input data */,
    parameters: {
      algorithm: 'algorithm1',
      options: { /* algorithm options */ }
    }
  },
  // Task options
  priority: 'high',
  timeout: 30000 // 30 seconds
});

// Listen for task completion
workerPool.on('taskCompleted', (result) => {
  if (result.taskId === taskId) {
    console.log(`Task ${taskId} completed with result:`, result.data);
  }
});

// Listen for task errors
workerPool.on('taskError', (error) => {
  if (error.taskId === taskId) {
    console.error(`Task ${taskId} failed:`, error.message);
  }
});</code></pre>
          
          <h4>Executing Tasks</h4>
          <pre><code class="language-javascript">// Execute a task and wait for the result
try {
  const result = await workerPool.executeTask({
    type: 'calculateTrajectory',
    data: {
      startPosition: { x: 0, y: 0, z: 0 },
      velocity: { x: 10, y: 5, z: 2 },
      timeSteps: 100,
      stepSize: 0.1
    }
  });
  
  console.log('Trajectory calculation result:', result);
} catch (error) {
  console.error('Trajectory calculation failed:', error);
}</code></pre>
        </section>

        <section id="job-queue" class="mt-5">
          <h2>Job Queue</h2>
          
          <p>
            The JobQueue component manages a queue of tasks waiting to be executed by worker threads.
          </p>
          
          <h4>Job Queue Initialization</h4>
          <pre><code class="language-javascript">const { JobQueue } = require('./monitoring/workers/JobQueue');

// Create a job queue
const jobQueue = new JobQueue({
  // Maximum queue size
  maxSize: 1000,
  
  // Default task priority
  defaultPriority: 'normal',
  
  // Priority levels (higher number = higher priority)
  priorityLevels: {
    'critical': 100,
    'high': 70,
    'normal': 50,
    'low': 30,
    'background': 10
  },
  
  // Queue persistence
  persistence: {
    enabled: true,
    collection: db.collection('jobQueue'),
    syncInterval: 10000 // 10 seconds
  }
});</code></pre>
          
          <h4>Job Queue Methods</h4>
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
                  <td><code>enqueue(task, [options])</code></td>
                  <td>Adds a task to the queue</td>
                  <td>
                    <ul>
                      <li><code>task</code>: Task object</li>
                      <li><code>options</code>: Queue options</li>
                    </ul>
                  </td>
                </tr>
                <tr>
                  <td><code>dequeue()</code></td>
                  <td>Removes and returns the next task</td>
                  <td>None</td>
                </tr>
                <tr>
                  <td><code>peek()</code></td>
                  <td>Returns the next task without removing it</td>
                  <td>None</td>
                </tr>
                <tr>
                  <td><code>getTaskById(id)</code></td>
                  <td>Gets a task by ID</td>
                  <td>
                    <ul>
                      <li><code>id</code>: Task ID</li>
                    </ul>
                  </td>
                </tr>
                <tr>
                  <td><code>removeTaskById(id)</code></td>
                  <td>Removes a task by ID</td>
                  <td>
                    <ul>
                      <li><code>id</code>: Task ID</li>
                    </ul>
                  </td>
                </tr>
                <tr>
                  <td><code>size()</code></td>
                  <td>Returns the current queue size</td>
                  <td>None</td>
                </tr>
                <tr>
                  <td><code>clear()</code></td>
                  <td>Clears the queue</td>
                  <td>None</td>
                </tr>
              </tbody>
            </table>
          </div>
          
          <h4>Task Prioritization</h4>
          <pre><code class="language-javascript">// Enqueue tasks with different priorities
await jobQueue.enqueue({
  type: 'processImage',
  data: { /* image data */ }
}, { priority: 'normal' });

await jobQueue.enqueue({
  type: 'processEmergencyAlert',
  data: { /* alert data */ }
}, { priority: 'critical' });

await jobQueue.enqueue({
  type: 'generateReport',
  data: { /* report data */ }
}, { priority: 'background' });

// The critical task will be dequeued first, then normal, then background
const nextTask = jobQueue.dequeue();</code></pre>
          
          <h4>Queue Persistence</h4>
          <p>
            When queue persistence is enabled, tasks are saved to a database collection to survive application restarts:
          </p>
          <pre><code class="language-javascript">// Restore the job queue on startup
await jobQueue.restore();

// Manually sync the queue to the database
await jobQueue.sync();

// Perform a clean shutdown
await jobQueue.shutdown();</code></pre>
        </section>

        <section id="worker-monitoring" class="mt-5">
          <h2>Worker Monitoring</h2>
          
          <p>
            The WorkerMonitor component tracks the health and performance of worker threads.
          </p>
          
          <h4>Worker Monitor Initialization</h4>
          <pre><code class="language-javascript">const { WorkerMonitor } = require('./monitoring/workers/WorkerMonitor');

// Create a worker monitor
const workerMonitor = new WorkerMonitor({
  // Worker pool to monitor
  workerPool,
  
  // Performance monitor for metrics
  performanceMonitor,
  
  // Monitoring interval
  interval: 15000, // 15 seconds
  
  // Health check settings
  healthCheck: {
    enabled: true,
    timeout: 5000,
    maxFailures: 3
  },
  
  // Watchdog settings
  watchdog: {
    enabled: true,
    maxTaskDuration: 300000, // 5 minutes
    stuckTaskAction: 'terminate'
  }
});</code></pre>
          
          <h4>Worker Health Metrics</h4>
          <p>
            The worker monitor collects various health metrics for each worker:
          </p>
          <div class="table-responsive">
            <table class="table table-bordered">
              <thead class="thead-light">
                <tr>
                  <th>Metric</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>CPU Usage</td>
                  <td>CPU usage percentage for the worker process</td>
                </tr>
                <tr>
                  <td>Memory Usage</td>
                  <td>Memory usage for the worker process</td>
                </tr>
                <tr>
                  <td>Task Throughput</td>
                  <td>Number of tasks completed per second</td>
                </tr>
                <tr>
                  <td>Task Success Rate</td>
                  <td>Percentage of tasks completed successfully</td>
                </tr>
                <tr>
                  <td>Task Latency</td>
                  <td>Time taken to complete tasks</td>
                </tr>
                <tr>
                  <td>Health Status</td>
                  <td>Current health status (healthy, degraded, unhealthy)</td>
                </tr>
              </tbody>
            </table>
          </div>
          
          <h4>Health Check and Recovery</h4>
          <pre><code class="language-javascript">// Perform a health check on all workers
await workerMonitor.checkHealth();

// Get health status for a specific worker
const workerHealth = workerMonitor.getWorkerHealth(workerId);
console.log(`Worker ${workerId} health:`, workerHealth);

// Configure automatic recovery actions
workerMonitor.configureRecovery({
  actions: {
    'stalled': {
      action: 'restart',
      retryLimit: 3
    },
    'highMemory': {
      action: 'terminate',
      threshold: 1024 * 1024 * 1024 // 1 GB
    },
    'lowThroughput': {
      action: 'log',
      threshold: 1 // 1 task per second
    }
  }
});</code></pre>
        </section>

        <section id="resource-management" class="mt-5">
          <h2>Resource Management</h2>
          
          <p>
            The worker management system includes resource management capabilities to optimize system resource utilization.
          </p>
          
          <h4>Resource Manager Initialization</h4>
          <pre><code class="language-javascript">const { ResourceManager } = require('./monitoring/workers/ResourceManager');

// Create a resource manager
const resourceManager = new ResourceManager({
  // Worker pool to manage
  workerPool,
  
  // System metrics monitor
  systemMetricsMonitor,
  
  // Resource targets
  targets: {
    cpuUtilization: 0.7, // Target 70% CPU utilization
    memoryUtilization: 0.8, // Target 80% memory utilization
    taskLatency: 200 // Target 200ms task latency
  },
  
  // Scaling settings
  scaling: {
    enabled: true,
    minWorkers: 2,
    maxWorkers: 16,
    scaleUpThreshold: 0.8, // Scale up at 80% of target
    scaleDownThreshold: 0.5, // Scale down at 50% of target
    scaleUpStep: 2, // Add 2 workers at a time
    scaleDownStep: 1, // Remove 1 worker at a time
    cooldownPeriod: 60000 // 1 minute between scaling actions
  }
});</code></pre>
          
          <h4>Dynamic Worker Scaling</h4>
          <pre><code class="language-javascript">// Enable automatic scaling
resourceManager.enableAutomaticScaling();

// Manually scale the worker pool
await resourceManager.scaleWorkerPool(8);

// Get resource utilization
const utilization = resourceManager.getResourceUtilization();
console.log('Current resource utilization:', utilization);

// Configure resource limits
resourceManager.setResourceLimits({
  maxCpuUtilization: 0.9, // 90% CPU utilization
  maxMemoryUtilization: 0.85, // 85% memory utilization
  maxActiveWorkers: 12
});</code></pre>
          
          <h4>Task Distribution Strategies</h4>
          <pre><code class="language-javascript">// Configure task distribution strategy
resourceManager.setTaskDistributionStrategy({
  strategy: 'weighted',
  weights: {
    cpuAvailability: 0.5,
    memoryAvailability: 0.3,
    queueLength: 0.2
  }
});

// Other available strategies
const strategies = {
  'roundRobin': {}, // Simple round-robin distribution
  'leastBusy': {}, // Assign to the least busy worker
  'resourceAware': { // Consider resource usage
    metrics: ['cpu', 'memory', 'queueLength']
  },
  'specialized': { // Task type to worker mapping
    mapping: {
      'imageProcessing': [1, 3, 5], // Assign to workers 1, 3, 5
      'dataAnalysis': [2, 4, 6] // Assign to workers 2, 4, 6
    }
  }
};</code></pre>
        </section>

        <section id="task-prioritization" class="mt-5">
          <h2>Task Prioritization</h2>
          
          <p>
            The worker management system supports task prioritization to ensure critical tasks are processed first.
          </p>
          
          <h4>Priority Scheduler</h4>
          <pre><code class="language-javascript">const { PriorityScheduler } = require('./monitoring/workers/PriorityScheduler');

// Create a priority scheduler
const priorityScheduler = new PriorityScheduler({
  // Job queue
  jobQueue,
  
  // Worker pool
  workerPool,
  
  // Priority preemption (whether higher priority tasks can interrupt lower priority ones)
  preemption: {
    enabled: true,
    minPriorityDiff: 30 // Minimum priority difference for preemption
  },
  
  // Priority aging (increase priority of waiting tasks over time)
  aging: {
    enabled: true,
    factor: 0.1, // Priority increase per aging cycle
    interval: 30000 // 30 seconds per aging cycle
  }
});</code></pre>
          
          <h4>Priority-Based Scheduling</h4>
          <pre><code class="language-javascript">// Submit tasks with priorities
await priorityScheduler.scheduleTask({
  type: 'normalTask',
  data: { /* task data */ }
}, { priority: 'normal' });

await priorityScheduler.scheduleTask({
  type: 'criticalTask',
  data: { /* task data */ }
}, { priority: 'critical' });

// Tasks will be executed in priority order (critical first)

// Get scheduled tasks
const scheduledTasks = priorityScheduler.getScheduledTasks();
console.log('Scheduled tasks:', scheduledTasks);

// Update task priority
await priorityScheduler.updateTaskPriority(taskId, 'high');</code></pre>
          
          <h4>Fairness Policies</h4>
          <pre><code class="language-javascript">// Configure fairness policy
priorityScheduler.setFairnessPolicy({
  // Task starvation prevention
  starvationPrevention: {
    enabled: true,
    maxWaitTime: 300000, // 5 minutes
    priorityBoost: 20 // Priority boost for starving tasks
  },
  
  // Resource allocation fairness
  resourceAllocation: {
    enabled: true,
    userQuotas: {
      'admin': 0.3, // 30% of resources
      'standard': 0.1 // 10% of resources
    },
    defaultQuota: 0.05 // 5% of resources
  }
});</code></pre>
        </section>

        <section id="error-handling" class="mt-5">
          <h2>Error Handling</h2>
          
          <p>
            The worker management system provides robust error handling capabilities for worker threads.
          </p>
          
          <h4>Error Handler Configuration</h4>
          <pre><code class="language-javascript">const { WorkerErrorHandler } = require('./monitoring/workers/WorkerErrorHandler');

// Create an error handler
const errorHandler = new WorkerErrorHandler({
  // Worker pool
  workerPool,
  
  // Performance monitor
  performanceMonitor,
  
  // Error policies
  policies: {
    // Default policy
    default: {
      action: 'retry',
      maxRetries: 3,
      retryDelay: 1000, // 1 second
      escalation: 'log'
    },
    
    // Task-specific policies
    taskTypes: {
      'criticalTask': {
        action: 'retry',
        maxRetries: 5,
        retryDelay: 500, // 0.5 seconds
        escalation: 'alert'
      },
      'nonCriticalTask': {
        action: 'ignore',
        escalation: 'log'
      }
    },
    
    // Error-specific policies
    errorTypes: {
      'TimeoutError': {
        action: 'retry',
        maxRetries: 2,
        retryDelay: 2000, // 2 seconds
        escalation: 'log'
      },
      'ResourceError': {
        action: 'reschedule',
        escalation: 'alert'
      }
    }
  }
});</code></pre>
          
          <h4>Error Handling Actions</h4>
          <div class="table-responsive">
            <table class="table table-bordered">
              <thead class="thead-light">
                <tr>
                  <th>Action</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>retry</td>
                  <td>Retry the task on the same worker</td>
                </tr>
                <tr>
                  <td>reschedule</td>
                  <td>Reschedule the task on a different worker</td>
                </tr>
                <tr>
                  <td>ignore</td>
                  <td>Ignore the error and mark the task as failed</td>
                </tr>
                <tr>
                  <td>terminate</td>
                  <td>Terminate the worker and reschedule the task</td>
                </tr>
                <tr>
                  <td>callback</td>
                  <td>Call a custom error handler function</td>
                </tr>
              </tbody>
            </table>
          </div>
          
          <h4>Custom Error Handlers</h4>
          <pre><code class="language-javascript">// Register a custom error handler
errorHandler.registerCustomHandler('DataProcessingError', async (error, task, worker) => {
  console.error(`Data processing error in task ${task.id} on worker ${worker.id}:`, error);
  
  // Log the error
  await logErrorToDatabase(error, task, worker);
  
  // Determine if task can be recovered
  if (isRecoverable(error)) {
    // Modify the task data to handle the error case
    task.data.retryStrategy = 'simplified';
    task.data.skipValidation = true;
    
    // Reschedule with modified data
    return {
      action: 'reschedule',
      modifiedTask: task
    };
  } else {
    // Cannot recover, notify user
    await notifyUser(task.userId, error);
    return {
      action: 'ignore',
      notificationSent: true
    };
  }
});</code></pre>
        </section>

        <section id="scaling-strategies" class="mt-5">
          <h2>Scaling Strategies</h2>
          
          <p>
            The worker management system supports various scaling strategies to adapt to changing workloads.
          </p>
          
          <h4>Auto-Scaling Configuration</h4>
          <pre><code class="language-javascript">const { WorkerAutoScaler } = require('./monitoring/workers/WorkerAutoScaler');

// Create an auto-scaler
const autoScaler = new WorkerAutoScaler({
  // Worker pool
  workerPool,
  
  // Resource manager
  resourceManager,
  
  // System metrics monitor
  systemMetricsMonitor,
  
  // Scaling strategy
  strategy: 'reactive',
  
  // Scaling parameters
  parameters: {
    minWorkers: 2,
    maxWorkers: 16,
    scaleUpThreshold: 0.8,
    scaleDownThreshold: 0.3,
    scaleUpFactor: 1.5,
    scaleDownFactor: 0.5,
    cooldownPeriod: 60000 // 1 minute
  },
  
  // Metrics to consider
  metrics: [
    {
      name: 'cpu',
      weight: 0.4,
      source: 'system'
    },
    {
      name: 'memory',
      weight: 0.2,
      source: 'system'
    },
    {
      name: 'queueLength',
      weight: 0.3,
      source: 'jobQueue'
    },
    {
      name: 'taskLatency',
      weight: 0.1,
      source: 'workerPool'
    }
  ]
});</code></pre>
          
          <h4>Scaling Strategies</h4>
          <div class="table-responsive">
            <table class="table table-bordered">
              <thead class="thead-light">
                <tr>
                  <th>Strategy</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>reactive</td>
                  <td>Scales based on current resource utilization</td>
                </tr>
                <tr>
                  <td>predictive</td>
                  <td>Scales based on predicted future resource utilization</td>
                </tr>
                <tr>
                  <td>scheduled</td>
                  <td>Scales based on predefined schedules</td>
                </tr>
                <tr>
                  <td>hybrid</td>
                  <td>Combines multiple scaling strategies</td>
                </tr>
              </tbody>
            </table>
          </div>
          
          <h4>Predictive Scaling</h4>
          <pre><code class="language-javascript">// Configure predictive scaling
autoScaler.setStrategy('predictive', {
  // Prediction window
  predictionWindow: 300000, // 5 minutes
  
  // Prediction algorithm
  algorithm: 'linearRegression',
  
  // Features for prediction
  features: [
    'timeOfDay',
    'dayOfWeek',
    'queueGrowthRate',
    'recentTaskCount'
  ],
  
  // Confidence threshold
  confidenceThreshold: 0.7,
  
  // Fallback strategy
  fallback: 'reactive'
});</code></pre>
          
          <h4>Scheduled Scaling</h4>
          <pre><code class="language-javascript">// Configure scheduled scaling
autoScaler.setStrategy('scheduled', {
  // Schedule entries
  schedule: [
    {
      cron: '0 8 * * 1-5', // Weekdays at 8:00 AM
      workers: 8
    },
    {
      cron: '0 18 * * 1-5', // Weekdays at 6:00 PM
      workers: 4
    },
    {
      cron: '0 0 * * 0,6', // Weekends at midnight
      workers: 2
    }
  ],
  
  // Override options
  overrides: {
    // Allow reactive scaling to override schedule if needed
    allowReactiveOverride: true,
    overrideThreshold: 0.9 // 90% utilization
  }
});</code></pre>
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


## 4. Dashboard Guide Documentation

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <!-- 
    Path: /docs/monitoring/dashboard_guide.html - IQSMS Dashboard Guide
    Copyright 2025 Autonomy Association International Inc., all rights reserved 
    Safeguard patent license from National Aeronautics and Space Administration (NASA)
    Copyright 2025 NASA, all rights reserved
  -->
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Dashboard Guide - IQSMS Documentation</title>
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
              <a class="dropdown-item" href="metrics_collection.html">Metrics Collection</a>
              <a class="dropdown-item" href="opentelemetry_integration.html">OpenTelemetry Integration</a>
              <a class="dropdown-item" href="performance_testing.html">Performance Testing</a>
              <a class="dropdown-item" href="worker_management.html">Worker Management</a>
              <a class="dropdown-item active" href="dashboard_guide.html">Dashboard Guide</a>
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
          <h1 class="display-4">Dashboard Guide</h1>
          <p class="lead">Interactive visualizations and monitoring dashboards for the IQSMS platform</p>
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
              <a class="nav-link" href="#overview">Overview</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#dashboard-types">Dashboard Types</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#system-dashboard">System Dashboard</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#protocol-dashboards">Protocol Dashboards</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#alert-dashboard">Alert Dashboard</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#worker-dashboard">Worker Dashboard</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#custom-dashboards">Custom Dashboards</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#dashboard-integration">Dashboard Integration</a>
            </li>
          </ul>
        </nav>
      </div>
      <div class="col-md-9">
        <section id="overview">
          <h2>Overview</h2>
          <p class="lead">
            The IQSMS Dashboard provides interactive visualizations and monitoring capabilities for all aspects of the IQSMS platform.
          </p>
          
          <p>
            The dashboard system is built on a flexible and modular architecture that allows for real-time monitoring, historical data analysis, and customizable visualizations. It integrates with the IQSMS Metrics Collection system to provide a comprehensive view of system performance and health.
          </p>
          
          <div class="alert alert-info">
            <i class="fas fa-info-circle mr-2"></i>
            <strong>Key Benefit:</strong> The dashboard system enables administrators and operators to quickly identify issues, analyze trends, and make data-driven decisions about system performance and health.
          </div>
          
          <h4>Accessing the Dashboard</h4>
          <p>
            The IQSMS Dashboard can be accessed at the following URL:
          </p>
          <pre><code class="language-text">http://your-server/monitoring/dashboard</code></pre>
          
          <div class="text-center my-4">
            <img src="../images/dashboard-main.svg" alt="IQSMS Dashboard Main View" class="img-fluid rounded border" style="max-width: 90%;">
          </div>
        </section>

        <section id="dashboard-types" class="mt-5">
          <h2>Dashboard Types</h2>
          
          <p>
            The IQSMS Dashboard system includes several specialized dashboards for different aspects of the platform:
          </p>
          
          <div class="row mt-4">
            <div class="col-lg-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h4 class="card-title"><i class="fas fa-server text-primary mr-2"></i>System Dashboard</h4>
                  <p class="card-text">Provides an overview of system health and performance.</p>
                  <ul>
                    <li>CPU, memory, disk, and network utilization</li>
                    <li>System-wide metrics and trends</li>
                    <li>Active connections and sessions</li>
                    <li>System alerts and notifications</li>
                  </ul>
                  <a href="#system-dashboard" class="btn btn-sm btn-outline-primary">Learn More</a>
                </div>
              </div>
            </div>
            
            <div class="col-lg-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h4 class="card-title"><i class="fas fa-exchange-alt text-primary mr-2"></i>Protocol Dashboards</h4>
                  <p class="card-text">Specialized dashboards for each IQSMS protocol.</p>
                  <ul>
                    <li>Agent Protocol monitoring</li>
                    <li>Model Context Protocol performance</li>
                    <li>Message Communication Protocol metrics</li>
                    <li>Protocol-specific visualizations</li>
                  </ul>
                  <a href="#protocol-dashboards" class="btn btn-sm btn-outline-primary">Learn More</a>
                </div>
              </div>
            </div>
            
            <div class="col-lg-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h4 class="card-title"><i class="fas fa-bell text-primary mr-2"></i>Alert Dashboard</h4>
                  <p class="card-text">Real-time view of system alerts and notifications.</p>
                  <ul>
                    <li>Active alerts and their severity</li>
                    <li>Alert history and trends</li>
                    <li>Alert acknowledgment and resolution</li>
                    <li>Alert configuration and management</li>
                  </ul>
                  <a href="#alert-dashboard" class="btn btn-sm btn-outline-primary">Learn More</a>
                </div>
              </div>
            </div>
            
            <div class="col-lg-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h4 class="card-title"><i class="fas fa-users-cog text-primary mr-2"></i>Worker Dashboard</h4>
                  <p class="card-text">Monitoring for worker threads and distributed tasks.</p>
                  <ul>
                    <li>Worker pool status and metrics</li>
                    <li>Task queue monitoring</li>
                    <li>Worker health and performance</li>
                    <li>Task execution statistics</li>
                  </ul>
                  <a href="#worker-dashboard" class="btn btn-sm btn-outline-primary">Learn More</a>
                </div>
              </div>
            </div>
          </div>
        </section>

        <section id="system-dashboard" class="mt-5">
          <h2>System Dashboard</h2>
          
          <p>
            The System Dashboard provides a comprehensive overview of the IQSMS platform's health and performance.
          </p>
          
          <div class="text-center my-4">
            <img src="../images/system-dashboard.svg" alt="System Dashboard" class="img-fluid rounded border" style="max-width: 90%;">
          </div>
          
          <h4>Dashboard Components</h4>
          <div class="accordion" id="systemDashboardAccordion">
            <div class="card">
              <div class="card-header" id="headingSystemOverview">
                <h5 class="mb-0">
                  <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#collapseSystemOverview" aria-expanded="true" aria-controls="collapseSystemOverview">
                    System Overview
                  </button>
                </h5>
              </div>
              <div id="collapseSystemOverview" class="collapse show" aria-labelledby="headingSystemOverview" data-parent="#systemDashboardAccordion">
                <div class="card-body">
                  <p>The System Overview panel provides a high-level view of the system's current status:</p>
                  <ul>
                    <li><strong>System Health Indicator</strong>: Visual indicator of overall system health</li>
                    <li><strong>Active Alerts</strong>: Count of active alerts by severity</li>
                    <li><strong>Uptime</strong>: System uptime since last restart</li>
                    <li><strong>Version Information</strong>: Current system version and update status</li>
                    <li><strong>Connected Clients</strong>: Number of currently connected clients</li>
                    <li><strong>Active Sessions</strong>: Number of active user sessions</li>
                  </ul>
                </div>
              </div>
            </div>
            
            <div class="card">
              <div class="card-header" id="headingResourceUtilization">
                <h5 class="mb-0">
                  <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseResourceUtilization" aria-expanded="false" aria-controls="collapseResourceUtilization">
                    Resource Utilization
                  </button>
                </h5>
              </div>
              <div id="collapseResourceUtilization" class="collapse" aria-labelledby="headingResourceUtilization" data-parent="#systemDashboardAccordion">
                <div class="card-body">
                  <p>The Resource Utilization panel displays real-time and historical resource usage:</p>
                  <ul>
                    <li><strong>CPU Usage</strong>: Current and historical CPU utilization</li>
                    <li><strong>Memory Usage</strong>: Current and historical memory utilization</li>
                    <li><strong>Disk I/O</strong>: Disk read and write rates</li>
                    <li><strong>Network I/O</strong>: Network traffic in and out</li>
                    <li><strong>Process Information</strong>: Process-specific resource usage</li>
                  </ul>
                  <p>Each metric includes real-time gauges and time-series charts for historical analysis.</p>
                </div>
              </div>
            </div>
            
            <div class="card">
              <div class="card-header" id="headingSystemActivity">
                <h5 class="mb-0">
                  <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseSystemActivity" aria-expanded="false" aria-controls="collapseSystemActivity">
                    System Activity
                  </button>
                </h5>
              </div>
              <div id="collapseSystemActivity" class="collapse" aria-labelledby="headingSystemActivity" data-parent="#systemDashboardAccordion">
                <div class="card-body">
                  <p>The System Activity panel shows real-time activity metrics:</p>
                  <ul>
                    <li><strong>Request Rate</strong>: Incoming requests per second</li>
                    <li><strong>Response Time</strong>: Average response time for requests</li>
                    <li><strong>Error Rate</strong>: Percentage of requests resulting in errors</li>
                    <li><strong>Active Connections</strong>: Current connection count by protocol</li>
                    <li><strong>Message Throughput</strong>: Messages processed per second</li>
                    <li><strong>Active Tasks</strong>: Currently executing background tasks</li>
                  </ul>
                </div>
              </div>
            </div>
            
            <div class="card">
              <div class="card-header" id="headingSystemAlerts">
                <h5 class="mb-0">
                  <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseSystemAlerts" aria-expanded="false" aria-controls="collapseSystemAlerts">
                    System Alerts
                  </button>
                </h5>
              </div>
              <div id="collapseSystemAlerts" class="collapse" aria-labelledby="headingSystemAlerts" data-parent="#systemDashboardAccordion">
                <div class="card-body">
                  <p>The System Alerts panel displays active and recent alerts:</p>
                  <ul>
                    <li><strong>Active Alerts</strong>: Currently active alerts with severity, time, and description</li>
                    <li><strong>Recent Alerts</strong>: Recently resolved alerts</li>
                    <li><strong>Alert Trends</strong>: Chart showing alert frequency over time</li>
                    <li><strong>Alert Actions</strong>: Buttons for acknowledging and resolving alerts</li>
                  </ul>
                  <p>Alerts are color-coded by severity (critical, warning, info) for easy identification.</p>
                </div>
              </div>
            </div>
          </div>
          
          <h4 class="mt-4">Time Range Selection</h4>
          <p>
            The System Dashboard includes a time range selector that allows you to view data for different time periods:
          </p>
          <ul>
            <li><strong>Real-time</strong>: Live updating view of current metrics</li>
            <li><strong>Last Hour</strong>: Data from the past hour</li>
            <li><strong>Last Day</strong>: Data from the past 24 hours</li>
            <li><strong>Last Week</strong>: Data from the past 7 days</li>
            <li><strong>Last Month</strong>: Data from the past 30 days</li>
            <li><strong>Custom Range</strong>: Specify a custom date and time range</li>
          </ul>
          
          <h4 class="mt-4">Auto-Refresh</h4>
          <p>
            The dashboard supports auto-refresh with configurable intervals:
          </p>
          <ul>
            <li><strong>Off</strong>: No automatic refreshing</li>
            <li><strong>10s</strong>: Refresh every 10 seconds</li>
            <li><strong>30s</strong>: Refresh every 30 seconds</li>
            <li><strong>1m</strong>: Refresh every minute</li>
            <li><strong>5m</strong>: Refresh every 5 minutes</li>
            <li><strong>15m</strong>: Refresh every 15 minutes</li>
          </ul>
        </section>

        <section id="protocol-dashboards" class="mt-5">
          <h2>Protocol Dashboards</h2>
          
          <p>
            The IQSMS Dashboard includes specialized dashboards for each protocol, providing detailed insights into protocol performance and behavior.
          </p>
          
          <h4>Agent Protocol Dashboard</h4>
          <div class="text-center my-4">
            <img src="../images/agent-protocol-dashboard.svg" alt="Agent Protocol Dashboard" class="img-fluid rounded border" style="max-width: 90%;">
          </div>
          
          <p>
            The Agent Protocol Dashboard provides detailed metrics for the Agent Protocol:
          </p>
          <ul>
            <li><strong>Connected Agents</strong>: Count and list of currently connected agents</li>
            <li><strong>Message Rates</strong>: Incoming and outgoing message rates</li>
            <li><strong>Message Types</strong>: Distribution of messages by type</li>
            <li><strong>Message Latency</strong>: Message processing and delivery times</li>
            <li><strong>Error Rates</strong>: Message errors by type and agent</li>
            <li><strong>Agent Map</strong>: Geographical map of agent locations</li>
            <li><strong>Agent Status</strong>: Status of each agent (active, idle, disconnected)</li>
          </ul>
          
          <h4>Model Context Protocol Dashboard</h4>
          <p>
            The Model Context Protocol Dashboard focuses on model access and updates:
          </p>
          <ul>
            <li><strong>Model Queries</strong>: Query rate and latency</li>
            <li><strong>Model Updates</strong>: Update rate and latency</li>
            <li><strong>Model Types</strong>: Distribution of operations by model type</li>
            <li><strong>Cache Performance</strong>: Cache hit rates and size</li>
            <li><strong>Context Creation</strong>: Context creation rate and lifetime</li>
            <li><strong>Query Complexity</strong>: Distribution of queries by complexity</li>
            <li><strong>Error Analysis</strong>: Query and update errors by type</li>
          </ul>
          
          <h4>Message Communication Protocol Dashboard</h4>
          <p>
            The Message Communication Protocol Dashboard provides insights into message routing and delivery:
          </p>
          <ul>
            <li><strong>Message Volume</strong>: Message counts by topic and channel</li>
            <li><strong>Throughput</strong>: Messages per second by channel</li>
            <li><strong>Delivery Latency</strong>: Message delivery times</li>
            <li><strong>Channel Activity</strong>: Active channels and their traffic</li>
            <li><strong>Subscriber Count</strong>: Subscribers per topic</li>
            <li><strong>Message Size</strong>: Distribution of message sizes</li>
            <li><strong>Protocol Distribution</strong>: Usage distribution across transport protocols (HTTP, WebSocket, AMQP, MQTT)</li>
          </ul>
        </section>

        <section id="alert-dashboard" class="mt-5">
          <h2>Alert Dashboard</h2>
          
          <p>
            The Alert Dashboard provides a comprehensive view of system alerts and notifications.
          </p>
          
          <div class="text-center my-4">
            <img src="../images/alert-dashboard.svg" alt="Alert Dashboard" class="img-fluid rounded border" style="max-width: 90%;">
          </div>
          
          <h4>Alert List</h4>
          <p>
            The Alert List displays all active and recent alerts:
          </p>
          <div class="table-responsive">
            <table class="table table-bordered">
              <thead class="thead-light">
                <tr>
                  <th>Column</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>Severity</td>
                  <td>Alert severity (Critical, Warning, Info)</td>
                </tr>
                <tr>
                  <td>Status</td>
                  <td>Alert status (Active, Acknowledged, Resolved)</td>
                </tr>
                <tr>
                  <td>Time</td>
                  <td>Time when the alert was triggered</td>
                </tr>
                <tr>
                  <td>Message</td>
                  <td>Alert message describing the issue</td>
                </tr>
                <tr>
                  <td>Source</td>
                  <td>Component or metric that triggered the alert</td>
                </tr>
                <tr>
                  <td>Duration</td>
                  <td>How long the alert has been active</td>
                </tr>
                <tr>
                  <td>Actions</td>
                  <td>Buttons for acknowledging or resolving the alert</td>
                </tr>
              </tbody>
            </table>
          </div>
          
          <h4>Alert Filters</h4>
          <p>
            The Alert Dashboard includes filters to help you find specific alerts:
          </p>
          <ul>
            <li><strong>Severity</strong>: Filter by alert severity</li>
            <li><strong>Status</strong>: Filter by alert status</li>
            <li><strong>Time Range</strong>: Filter by alert trigger time</li>
            <li><strong>Source</strong>: Filter by alert source</li>
            <li><strong>Keyword</strong>: Search for alerts by keyword</li>
          </ul>
          
          <h4>Alert Statistics</h4>
          <p>
            The Alert Statistics panel provides insights into alert patterns:
          </p>
          <ul>
            <li><strong>Alert Count by Severity</strong>: Distribution of alerts by severity</li>
            <li><strong>Alert Trend</strong>: Chart showing alert frequency over time</li>
            <li><strong>Top Alert Sources</strong>: Most common alert sources</li>
            <li><strong>Mean Time to Resolution</strong>: Average time to resolve alerts</li>
            <li><strong>Alert Heatmap</strong>: Visualization of alert frequency by time and day</li>
          </ul>
          
          <h4>Alert Actions</h4>
          <p>
            The Alert Dashboard allows you to perform various actions on alerts:
          </p>
          <ul>
            <li><strong>Acknowledge</strong>: Mark an alert as acknowledged</li>
            <li><strong>Resolve</strong>: Mark an alert as resolved</li>
            <li><strong>Silence</strong>: Temporarily silence an alert</li>
            <li><strong>Escalate</strong>: Escalate an alert to a higher priority</li>
            <li><strong>Export</strong>: Export alerts to CSV or JSON</li>
            <li><strong>Create Ticket</strong>: Create a ticket in an external system</li>
          </ul>
        </section>

        <section id="worker-dashboard" class="mt-5">
          <h2>Worker Dashboard</h2>
          
          <p>
            The Worker Dashboard provides detailed insights into worker thread performance and task execution.
          </p>
          
          <div class="text-center my-4">
            <img src="../images/worker-dashboard.svg" alt="Worker Dashboard" class="img-fluid rounded border" style="max-width: 90%;">
          </div>
          
          <h4>Worker Pool Overview</h4>
          <p>
            The Worker Pool Overview panel provides a high-level view of the worker pool:
          </p>
          <ul>
            <li><strong>Active Workers</strong>: Number of currently active workers</li>
            <li><strong>Idle Workers</strong>: Number of idle workers</li>
            <li><strong>Busy Workers</strong>: Number of busy workers</li>
            <li><strong>Task Queue Length</strong>: Number of tasks waiting in the queue</li>
            <li><strong>Tasks Completed</strong>: Total tasks completed</li>
            <li><strong>Tasks Failed</strong>: Total tasks failed</li>
            <li><strong>Average Task Duration</strong>: Average time to complete a task</li>
          </ul>
          
          <h4>Worker Status</h4>
          <p>
            The Worker Status panel shows detailed information for each worker:
          </p>
          <div class="table-responsive">
            <table class="table table-bordered">
              <thead class="thead-light">
                <tr>
                  <th>Column</th>
                  <th>Description</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>Worker ID</td>
                  <td>Unique identifier for the worker</td>
                </tr>
                <tr>
                  <td>Status</td>
                  <td>Current worker status (Active, Idle, Terminated)</td>
                </tr>
                <tr>
                  <td>CPU Usage</td>
                  <td>Current CPU usage of the worker</td>
                </tr>
                <tr>
                  <td>Memory Usage</td>
                  <td>Current memory usage of the worker</td>
                </tr>
                <tr>
                  <td>Uptime</td>
                  <td>How long the worker has been running</td>
                </tr>
                <tr>
                  <td>Tasks Completed</td>
                  <td>Number of tasks completed by this worker</td>
                </tr>
                <tr>
                  <td>Current Task</td>
                  <td>Task currently being executed by the worker</td>
                </tr>
                <tr>
                  <td>Actions</td>
                  <td>Buttons for worker actions (restart, terminate)</td>
                </tr>
              </tbody>
            </table>
          </div>
          
          <h4>Task Queue</h4>
          <p>
            The Task Queue panel shows the current task queue:
          </p>
          <ul>
            <li><strong>Pending Tasks</strong>: List of tasks waiting to be executed</li>
            <li><strong>Task Priority</strong>: Priority of each task</li>
            <li><strong>Task Type</strong>: Type of each task</li>
            <li><strong>Task Age</strong>: How long the task has been in the queue</li>
            <li><strong>Queue Distribution</strong>: Distribution of tasks by type and priority</li>
            <li><strong>Queue Length Trend</strong>: Chart showing queue length over time</li>
          </ul>
          
          <h4>Task Execution Metrics</h4>
          <p>
            The Task Execution Metrics panel provides performance metrics for task execution:
          </p>
          <ul>
            <li><strong>Task Throughput</strong>: Tasks completed per second</li>
            <li><strong>Task Latency</strong>: Distribution of task execution times</li>
            <li><strong>Task Success Rate</strong>: Percentage of tasks completed successfully</li>
            <li><strong>Task Error Rate</strong>: Percentage of tasks that failed</li>
            <li><strong>Task Wait Time</strong>: Time spent in the queue before execution</li>
            <li><strong>Task Resource Usage</strong>: CPU and memory usage by task type</li>
          </ul>
        </section>

        <section id="custom-dashboards" class="mt-5">
          <h2>Custom Dashboards</h2>
          
          <p>
            The IQSMS Dashboard system allows you to create custom dashboards tailored to your specific monitoring needs.
          </p>
          
          <h4>Creating a Custom Dashboard</h4>
          <ol>
            <li>
              <p><strong>Access the Dashboard Creator</strong></p>
              <p>Click the "Create Dashboard" button in the dashboard navigation bar.</p>
            </li>
            <li>
              <p><strong>Configure Dashboard Properties</strong></p>
              <p>Set the dashboard name, description, and access permissions.</p>
              <pre><code class="language-javascript">// Example dashboard configuration
{
  "name": "Protocol Performance Dashboard",
  "description": "Performance metrics for IQSMS protocols",
  "refreshInterval": 30,
  "permissions": {
    "view": ["admin", "operator"],
    "edit": ["admin"]
  }
}</code></pre>
            </li>
            <li>
              <p><strong>Add Panels</strong></p>
              <p>Add various panels to your dashboard using the panel selector.</p>
              <ul>
                <li><strong>Chart Panel</strong>: Time-series charts for metrics</li>
                <li><strong>Gauge Panel</strong>: Visual representation of current values</li>
                <li><strong>Table Panel</strong>: Tabular data display</li>
                <li><strong>Stat Panel</strong>: Single-value display with thresholds</li>
                <li><strong>Text Panel</strong>: Custom text and markdown</li>
                <li><strong>Alert Panel</strong>: Alert list and summary</li>
                <li><strong>Map Panel</strong>: Geographical map visualization</li>
              </ul>
            </li>
            <li>
              <p><strong>Configure Panels</strong></p>
              <p>Configure each panel with metrics, queries, and visualization options.</p>
              <pre><code class="language-javascript">// Example panel configuration
{
  "type": "chart",
  "title": "Protocol Message Rate",
  "description": "Message rate by protocol type",
  "metrics": [
    {
      "name": "agent.message.received",
      "aggregation": "rate",
      "label": "Agent Protocol"
    },
    {
      "name": "mcp.query.count",
      "aggregation": "rate",
      "label": "Model Context Protocol"
    },
    {
      "name": "message.published",
      "aggregation": "rate",
      "label": "Message Communication Protocol"
    }
  ],
  "visualization": {
    "type": "line",
    "stacked": false,
    "legend": true,
    "yAxis": {
      "label": "Messages/second",
      "min": 0
    },
    "thresholds": [
      {
        "value": 1000,
        "color": "yellow"
      },
      {
        "value": 2000,
        "color": "red"
      }
    ]
  }
}</code></pre>
            </li>
            <li>
              <p><strong>Arrange Panels</strong></p>
              <p>Arrange panels on the dashboard grid using drag-and-drop.</p>
            </li>
            <li>
              <p><strong>Save Dashboard</strong></p>
              <p>Save your custom dashboard configuration.</p>
            </li>
          </ol>
          
          <h4>Dashboard Templates</h4>
          <p>
            The IQSMS Dashboard system includes several pre-built templates that you can use as starting points for your custom dashboards:
          </p>
          <ul>
            <li><strong>Protocol Performance</strong>: Performance metrics for all protocols</li>
            <li><strong>System Health</strong>: System health and resource utilization</li>
            <li><strong>Error Analysis</strong>: Detailed error tracking and analysis</li>
            <li><strong>Worker Performance</strong>: Worker thread and task performance</li>
            <li><strong>Network Activity</strong>: Network traffic and connection metrics</li>
          </ul>
        </section>

        <section id="dashboard-integration" class="mt-5">
          <h2>Dashboard Integration</h2>
          
          <p>
            The IQSMS Dashboard system can be integrated with external monitoring and visualization tools.
          </p>
          
          <h4>Grafana Integration</h4>
          <p>
            You can integrate the IQSMS metrics with Grafana for advanced visualization:
          </p>
          <ol>
            <li>
              <p><strong>Configure Prometheus Data Source</strong></p>
              <p>The IQSMS Metrics Collection system exposes metrics in Prometheus format at:</p>
              <pre><code class="language-text">http://your-server/metrics</code></pre>
              <p>Configure this URL as a Prometheus data source in Grafana.</p>
            </li>
            <li>
              <p><strong>Import Dashboard Templates</strong></p>
              <p>IQSMS provides pre-built Grafana dashboard templates that you can import:</p>
              <ul>
                <li><code>iqsms-system-dashboard.json</code></li>
                <li><code>iqsms-protocol-dashboard.json</code></li>
                <li><code>iqsms-worker-dashboard.json</code></li>
              </ul>
            </li>
            <li>
              <p><strong>Configure Alerting</strong></p>
              <p>Configure Grafana alerting to notify you of important events:</p>
              <pre><code class="language-javascript">// Example Grafana alert
{
  "name": "High CPU Usage",
  "rule": {
    "query": "avg(system_cpu_usage{job=\"iqsms\"})",
    "condition": "> 80",
    "duration": "5m"
  },
  "notifications": [
    {
      "type": "email",
      "address": "admin@example.com"
    },
    {
      "type": "slack",
      "channel": "#alerts"
    }
  ]
}</code></pre>
            </li>
          </ol>
          
          <h4>API Access</h4>
          <p>
            The IQSMS Dashboard system provides a RESTful API for programmatic access to metrics and dashboards:
          </p>
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
                  <td><code>/api/metrics</code></td>
                  <td>GET</td>
                  <td>Get all available metrics</td>
                </tr>
                <tr>
                  <td><code>/api/metrics/:name</code></td>
                  <td>GET</td>
                  <td>Get a specific metric by name</td>
                </tr>
                <tr>
                  <td><code>/api/dashboards</code></td>
                  <td>GET</td>
                  <td>Get all available dashboards</td>
                </tr>
                <tr>
                  <td><code>/api/dashboards/:id</code></td>
                  <td>GET</td>
                  <td>Get a specific dashboard by ID</td>
                </tr>
                <tr>
                  <td><code>/api/dashboards</code></td>
                  <td>POST</td>
                  <td>Create a new dashboard</td>
                </tr>
                <tr>
                  <td><code>/api/dashboards/:id</code></td>
                  <td>PUT</td>
                  <td>Update a dashboard</td>
                </tr>
                <tr>
                  <td><code>/api/alerts</code></td>
                  <td>GET</td>
                  <td>Get all active alerts</td>
                </tr>
                <tr>
                  <td><code>/api/alerts/:id/acknowledge</code></td>
                  <td>POST</td>
                  <td>Acknowledge an alert</td>
                </tr>
              </tbody>
            </table>
          </div>
          
          <h4>Embedding Dashboards</h4>
          <p>
            You can embed IQSMS dashboards in other web applications using the provided iframe embed code:
          </p>
          <pre><code class="language-html">&lt;iframe
  src="http://your-server/monitoring/dashboard/embed?id=dashboard-id&amp;theme=light"
  width="800"
  height="600"
  frameborder="0"
&gt;&lt;/iframe&gt;</code></pre>
          
          <p>
            The embed URL supports several parameters:
          </p>
          <ul>
            <li><code>id</code>: Dashboard ID to embed</li>
            <li><code>theme</code>: Dashboard theme (light or dark)</li>
            <li><code>refresh</code>: Auto-refresh interval in seconds</li>
            <li><code>from</code>: Start time for time range</li>
            <li><code>to</code>: End time for time range</li>
            <li><code>variables</code>: Dashboard template variables</li>
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


## Project Implementation Report

I've now completed the implementation of all four requested documentation files:

1. `/docs/monitoring/opentelemetry_integration.html` - Provides comprehensive documentation on the OpenTelemetry integration, covering distributed tracing, exporters, metrics integration, and troubleshooting.

2. `/docs/monitoring/performance_testing.html` - Details the performance testing framework, including test types, scheduled testing, baseline management, and reporting.

3. `/docs/monitoring/worker_management.html` - Documents the worker thread management system, covering worker pools, job queues, monitoring, resource management, and scaling strategies.

4. `/docs/monitoring/dashboard_guide.html` - Explains the monitoring dashboards, their components, customization options, and integration capabilities.

### Key Features Implemented

All documents maintain a consistent structure and style with:

1. Proper Bootstrap 4 styling and navigation
2. Consistent header and footer sections
3. Table of contents navigation
4. Appropriate FontAwesome icons
5. Code examples and visual aids
6. Cross-references to related documentation
7. Clear section organization

### Navigation Structure

Each page includes the same navigation structure, ensuring users can easily navigate between monitoring documentation pages. The navigation menu highlights the current page appropriately.

### Technical Details

1. Each page uses semantic HTML5 elements
2. CSS is linked from CDN sources for Bootstrap and FontAwesome
3. JavaScript is included for Bootstrap functionality
4. All pages include proper copyright notices
5. Code samples are properly formatted in `<pre><code>` blocks

### Integration with Existing Documentation

These new pages seamlessly integrate with the existing documentation structure. The main index page already includes links to these pages in the monitoring dropdown menu.

The documentation is now ready for use and provides a comprehensive guide to the IQSMS monitoring system components.


I'll update the navigation links in the main `/docs/index.html` file to ensure proper links to the newly created monitoring documentation pages.

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
  <title>IQSMS - IQ Safety Management Surveillance System</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="css/styles.css">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.1/css/all.css">
</head>
<body>
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
      <a class="navbar-brand" href="index.html">
        IQSMS Documentation
      </a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="index.html">Home</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="coreDropdown" role="button" data-toggle="dropdown">
                        Core System
                    </a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="core/index.html">Core Overview</a>
                        <a class="dropdown-item" href="core/SafeguardBaseDocumentation.html">Safeguard Base</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="getting-started.html">Getting Started</a>
                        <a class="dropdown-item" href="system_info.html">System Info</a>
                    </div>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="servicesDropdown" role="button" data-toggle="dropdown">
                        Services
                    </a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="services/IQSMS_Services_Overview.html">Services Overview</a>
                        <a class="dropdown-item" href="services/WebSocketServiceDocumentation.html">WebSocket Service</a>
                        <a class="dropdown-item" href="services/MCP_RAG_System_Overview.html">MCP RAG System</a>
                        <a class="dropdown-item" href="services/MCP_RAG_Integration_Documentation.html">RAG Integration</a>
                    </div>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="pluginsDropdown" role="button" data-toggle="dropdown">
                        Plugins
                    </a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="plugins/index.html">All Plugins</a>
                        <a class="dropdown-item" href="plugin-development.html">Plugin Development</a>
                    </div>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="protocolsDropdown" role="button" data-toggle="dropdown">
                        Protocols
                    </a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="protocols/IQSMS_Protocols_Overview.html">Protocols Overview</a>
                        <a class="dropdown-item" href="protocols/agent-protocol.html">Agent Protocol</a>
                        <a class="dropdown-item" href="protocols/mcp.html">Model Context Protocol</a>
                        <a class="dropdown-item" href="protocols/json-rpc.html">JSON-RPC Protocol</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="protocols/agent_to_agent_communication_protocol.html">Agent-to-Agent Communication</a>
                    </div>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="predictorsDropdown" role="button" data-toggle="dropdown">
                        Predictors
                    </a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="predictors/IQSMS_Predictors_Overview.html">Predictors Overview</a>
                        <a class="dropdown-item" href="predictors/PeopleSwarmPredictor.html">People Swarm Predictor</a>
                        <a class="dropdown-item" href="predictors/industrial_robotics_swarm_predictor.html">Industrial Robotics</a>
                        <a class="dropdown-item" href="predictors/aerial_vehicle_predictor.html">Aerial Vehicle Predictor</a>
                        <a class="dropdown-item" href="predictors/space_vehicle_predictor.html">Space Vehicle Predictor</a>
                        <a class="dropdown-item" href="predictors/battery_health_predictor.html">Battery Health Predictor</a>
                    </div>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="simulationDropdown" role="button" data-toggle="dropdown">
                        Simulation
                    </a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="simulation/index.html">Simulation Overview</a>
                        <a class="dropdown-item" href="simulation/WebXR_Simulation_Features.html">WebXR Features</a>
                        <a class="dropdown-item" href="simulation/WebXR_Implementation_Guide.html">WebXR Implementation</a>
                        <a class="dropdown-item" href="simulation/Multi_Modal_Simulation.html">Multi-Modal Simulation</a>
                    </div>
                </li>
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
            </ul>
        </div>
    </div>
  </nav>

  <div class="jumbotron bg-primary text-white">
    <div class="container">
      <div class="row align-items-center">
        <div class="col-md-8">
          <h1 class="display-4">IQ Safety Management Surveillance System</h1>
          <p class="lead">Comprehensive documentation for the IQSMS platform, plugins, protocols, predictors, and simulation capabilities</p>
          <a href="getting-started.html" class="btn btn-light btn-lg">Get Started</a>
          <a href="#features" class="btn btn-outline-light btn-lg">Features</a>
        </div>
        <div class="col-md-4 text-center">
          <i class="fas fa-shield-alt fa-6x"></i>
        </div>
      </div>
    </div>
  </div>

  <div class="container my-5">
    <section id="overview">
      <div class="row">
        <div class="col-md-12">
          <h2 class="mb-4">System Overview</h2>
          <p class="lead">The IQ Safety Management Surveillance System (IQSMS) is a comprehensive platform for managing safety across multiple domains including aerial, terrestrial, marine, space, and robotic systems.</p>
          
          <div class="row mt-4">
            <div class="col-lg-3 mb-4">
              <div class="card h-100">
                <div class="card-body text-center">
                  <i class="fas fa-plug fa-3x text-primary mb-3"></i>
                  <h3 class="card-title">Plugin Architecture</h3>
                  <p class="card-text">Extend functionality through a consistent plugin interface with runtime loading and configuration.</p>
                  <a href="plugin-development.html" class="btn btn-outline-primary">Learn More</a>
                </div>
              </div>
            </div>
            <div class="col-lg-3 mb-4">
              <div class="card h-100">
                <div class="card-body text-center">
                  <i class="fas fa-brain fa-3x text-primary mb-3"></i>
                  <h3 class="card-title">Predictive Analytics</h3>
                  <p class="card-text">AI-powered predictors for swarm behavior, collision risk assessment, and hazard detection.</p>
                  <a href="predictors/IQSMS_Predictors_Overview.html" class="btn btn-outline-primary">Learn More</a>
                </div>
              </div>
            </div>
            <div class="col-lg-3 mb-4">
              <div class="card h-100">
                <div class="card-body text-center">
                  <i class="fas fa-vr-cardboard fa-3x text-primary mb-3"></i>
                  <h3 class="card-title">Immersive Simulation</h3>
                  <p class="card-text">WebXR-powered 3D simulations with multi-modal support for VR/AR training and testing.</p>
                  <a href="simulation/WebXR_Simulation_Features.html" class="btn btn-outline-primary">Learn More</a>
                </div>
              </div>
            </div>
            <div class="col-lg-3 mb-4">
              <div class="card h-100">
                <div class="card-body text-center">
                  <i class="fas fa-chart-line fa-3x text-primary mb-3"></i>
                  <h3 class="card-title">Monitoring System</h3>
                  <p class="card-text">Comprehensive performance monitoring, metrics collection, and analysis capabilities.</p>
                  <a href="monitoring/index.html" class="btn btn-outline-primary">Learn More</a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <hr class="my-5" id="features">

    <section id="main-components">
      <h2 class="mb-4">Core Components</h2>
      <div class="row">
        <div class="col-md-6">
          <div class="card mb-4">
            <div class="card-header bg-primary text-white">
              <h3 class="mb-0">Core System</h3>
            </div>
            <div class="card-body">
              <p>The foundation of the IQSMS platform, providing essential services for safety management across different domains.</p>
              <ul class="list-unstyled">
                <li><i class="fas fa-check-circle text-success mr-2"></i> <a href="core/SafeguardBaseDocumentation.html">Safeguard Base</a></li>
                <li><i class="fas fa-check-circle text-success mr-2"></i> <a href="GeospatialUtilityFunctions.html">Geospatial Utilities</a></li>
                <li><i class="fas fa-check-circle text-success mr-2"></i> <a href="api-reference.html">API Reference</a></li>
                <li><i class="fas fa-check-circle text-success mr-2"></i> <a href="system_info.html">System Information</a></li>
              </ul>
              <a href="core/index.html" class="btn btn-primary">Explore Core System</a>
            </div>
          </div>
        </div>
        <div class="col-md-6">
          <div class="card mb-4">
            <div class="card-header bg-primary text-white">
              <h3 class="mb-0">Monitoring</h3>
            </div>
            <div class="card-body">
              <p>Comprehensive monitoring and performance analysis for all IQSMS components.</p>
              <ul class="list-unstyled">
                <li><i class="fas fa-check-circle text-success mr-2"></i> <a href="monitoring/metrics_collection.html">Metrics Collection</a></li>
                <li><i class="fas fa-check-circle text-success mr-2"></i> <a href="monitoring/opentelemetry_integration.html">OpenTelemetry Integration</a></li>
                <li><i class="fas fa-check-circle text-success mr-2"></i> <a href="monitoring/performance_testing.html">Performance Testing</a></li>
                <li><i class="fas fa-check-circle text-success mr-2"></i> <a href="monitoring/dashboard_guide.html">Dashboard Guide</a></li>
              </ul>
              <a href="monitoring/index.html" class="btn btn-primary">Explore Monitoring</a>
            </div>
          </div>
        </div>
      </div>
      
      <div class="row">
        <div class="col-md-6">
          <div class="card mb-4">
            <div class="card-header bg-primary text-white">
              <h3 class="mb-0">Protocols</h3>
            </div>
            <div class="card-body">
              <p>Communication standards for seamless integration between system components and external services.</p>
              <ul class="list-unstyled">
                <li><i class="fas fa-check-circle text-success mr-2"></i> <a href="protocols/IQSMS_Protocols_Overview.html">Protocols Overview</a></li>
                <li><i class="fas fa-check-circle text-success mr-2"></i> <a href="protocols/agent-protocol.html">Agent Protocol</a></li>
                <li><i class="fas fa-check-circle text-success mr-2"></i> <a href="protocols/mcp.html">Model Context Protocol</a></li>
                <li><i class="fas fa-check-circle text-success mr-2"></i> <a href="protocols/agent_to_agent_communication_protocol.html">Agent-to-Agent Communication</a></li>
              </ul>
              <a href="protocols/IQSMS_Protocols_Overview.html" class="btn btn-primary">Explore Protocols</a>
            </div>
          </div>
        </div>
        <div class="col-md-6">
          <div class="card mb-4">
            <div class="card-header bg-primary text-white">
              <h3 class="mb-0">Plugins</h3>
            </div>
            <div class="card-body">
              <p>Extend and customize IQSMS with a rich ecosystem of plugins for various functionality domains.</p>
              <ul class="list-unstyled">
                <li><i class="fas fa-check-circle text-success mr-2"></i> <a href="plugins/network_monitor_plugin.html">Network Monitoring</a></li>
                <li><i class="fas fa-check-circle text-success mr-2"></i> <a href="plugins/security_scanner_plugin.html">Security Scanner</a></li>
                <li><i class="fas fa-check-circle text-success mr-2"></i> <a href="plugins/drone_swarm_load_balancer.html">Drone Swarm Load Balancer</a></li>
                <li><i class="fas fa-check-circle text-success mr-2"></i> <a href="plugins/index.html">View All Plugins</a></li>
              </ul>
              <a href="plugins/index.html" class="btn btn-primary">Explore Plugins</a>
            </div>
          </div>
        </div>
      </div>
    </section>

    <hr class="my-5">

    <section id="monitoring-section" class="my-5">
      <h2 class="mb-4">Monitoring & Performance Analysis</h2>
      <p class="lead">Comprehensive monitoring tools for tracking performance, collecting metrics, and analyzing system behavior.</p>
      
      <div class="row">
        <div class="col-lg-4 mb-4">
          <div class="card h-100">
            <div class="card-body">
              <h4 class="card-title"><i class="fas fa-chart-bar text-primary mr-2"></i> Metrics Collection</h4>
              <p class="card-text">Comprehensive framework for collecting, processing, and analyzing metrics from all system components.</p>
              <a href="monitoring/metrics_collection.html" class="btn btn-sm btn-outline-primary">Documentation</a>
            </div>
          </div>
        </div>
        <div class="col-lg-4 mb-4">
          <div class="card h-100">
            <div class="card-body">
              <h4 class="card-title"><i class="fas fa-project-diagram text-primary mr-2"></i> OpenTelemetry Integration</h4>
              <p class="card-text">Distributed tracing and observability for tracking end-to-end transactions across services.</p>
              <a href="monitoring/opentelemetry_integration.html" class="btn btn-sm btn-outline-primary">Documentation</a>
            </div>
          </div>
        </div>
        <div class="col-lg-4 mb-4">
          <div class="card h-100">
            <div class="card-body">
              <h4 class="card-title"><i class="fas fa-flask text-primary mr-2"></i> Performance Testing</h4>
              <p class="card-text">Automated benchmarking and performance analysis tools for testing system components.</p>
              <a href="monitoring/performance_testing.html" class="btn btn-sm btn-outline-primary">Documentation</a>
            </div>
          </div>
        </div>
        <div class="col-lg-4 mb-4">
          <div class="card h-100">
            <div class="card-body">
              <h4 class="card-title"><i class="fas fa-users-cog text-primary mr-2"></i> Worker Management</h4>
              <p class="card-text">Advanced worker thread management for distributed processing tasks with auto-scaling.</p>
              <a href="monitoring/worker_management.html" class="btn btn-sm btn-outline-primary">Documentation</a>
            </div>
          </div>
        </div>
        <div class="col-lg-4 mb-4">
          <div class="card h-100">
            <div class="card-body">
              <h4 class="card-title"><i class="fas fa-tachometer-alt text-primary mr-2"></i> Dashboard Guide</h4>
              <p class="card-text">Interactive visualization dashboards for monitoring and analyzing system performance.</p>
              <a href="monitoring/dashboard_guide.html" class="btn btn-sm btn-outline-primary">Documentation</a>
            </div>
          </div>
        </div>
        <div class="col-lg-4 mb-4">
          <div class="card h-100">
            <div class="card-body">
              <h4 class="card-title"><i class="fas fa-bell text-primary mr-2"></i> Alerting System</h4>
              <p class="card-text">Proactive alerting and notification system for detecting and responding to issues.</p>
              <a href="monitoring/metrics_collection.html#alerting" class="btn btn-sm btn-outline-primary">Documentation</a>
            </div>
          </div>
        </div>
      </div>
      
      <div class="text-center mt-3">
        <a href="monitoring/index.html" class="btn btn-primary">Explore Monitoring System</a>
      </div>
    </section>

    <hr class="my-5">

    <section id="predictors-section">
      <h2 class="mb-4">IQSMS Predictors</h2>
      <p class="lead">AI-powered prediction engines for anticipating and managing various safety scenarios.</p>
      
      <div class="row">
        <div class="col-lg-4 mb-4">
          <div class="card h-100">
            <div class="card-body">
              <h4 class="card-title"><i class="fas fa-users text-primary mr-2"></i> People Swarm Predictor</h4>
              <p class="card-text">Models human crowd behavior to anticipate movement patterns and potential congestion points.</p>
              <a href="predictors/PeopleSwarmPredictor.html" class="btn btn-sm btn-outline-primary">Documentation</a>
            </div>
          </div>
        </div>
        <div class="col-lg-4 mb-4">
          <div class="card h-100">
            <div class="card-body">
              <h4 class="card-title"><i class="fas fa-industry text-primary mr-2"></i> Industrial Robotics</h4>
              <p class="card-text">Predicts industrial robot swarm behavior for factory floor safety and efficiency.</p>
              <a href="industrial_robotics_swarm_predictor.html" class="btn btn-sm btn-outline-primary">Documentation</a>
            </div>
          </div>
        </div>
        <div class="col-lg-4 mb-4">
          <div class="card h-100">
            <div class="card-body">
              <h4 class="card-title"><i class="fas fa-car text-primary mr-2"></i> Land Vehicle Predictor</h4>
              <p class="card-text">Analyzes and predicts ground vehicle movement patterns for traffic management.</p>
              <a href="robot_swarm_prediction_and_management_documentation.html" class="btn btn-sm btn-outline-primary">Documentation</a>
            </div>
          </div>
        </div>
        <div class="col-lg-4 mb-4">
          <div class="card h-100">
            <div class="card-body">
              <h4 class="card-title"><i class="fas fa-plane text-primary mr-2"></i> Aerial Vehicle Predictor</h4>
              <p class="card-text">Forecasts drone and aircraft trajectories for collision avoidance and airspace management.</p>
              <a href="robot_swarm_prediction_and_management_documentation.html" class="btn btn-sm btn-outline-primary">Documentation</a>
            </div>
          </div>
        </div>
        <div class="col-lg-4 mb-4">
          <div class="card h-100">
            <div class="card-body">
              <h4 class="card-title"><i class="fas fa-rocket text-primary mr-2"></i> Space Vehicle Predictor</h4>
              <p class="card-text">Predicts satellite and spacecraft movement for orbital safety management.</p>
              <a href="robot_swarm_prediction_and_management_documentation.html" class="btn btn-sm btn-outline-primary">Documentation</a>
            </div>
          </div>
        </div>
        <div class="col-lg-4 mb-4">
          <div class="card h-100">
            <div class="card-body">
              <h4 class="card-title"><i class="fas fa-battery-three-quarters text-primary mr-2"></i> Battery Health Predictor</h4>
              <p class="card-text">Monitors and forecasts battery performance for preventive maintenance.</p>
              <a href="robot_swarm_prediction_and_management_documentation.html" class="btn btn-sm btn-outline-primary">Documentation</a>
            </div>
          </div>
        </div>
      </div>
      
      <div class="text-center mt-3">
        <a href="predictors/IQSMS_Predictors_Overview.html" class="btn btn-primary">Explore All Predictors</a>
      </div>
    </section>

    <hr class="my-5">

    <section id="simulation-section">
      <h2 class="mb-4">3D Simulation & WebXR Integration</h2>
      <p class="lead">Immersive simulation environments for training, testing, and visualization across multiple modalities.</p>
      
      <div class="row">
        <div class="col-md-6">
          <div class="card mb-4">
            <img src="images/NetworkGraphWithText.svg" class="card-img-top" alt="3D Simulation">
            <div class="card-body">
              <h4 class="card-title">3D Simulation Integration</h4>
              <p class="card-text">Comprehensive Three.js based simulation environment with WebXR support for immersive VR/AR experiences.</p>
              <ul>
                <li>Multi-modal simulation support (aerial, terrestrial, marine, space)</li>
                <li>WebXR integration for VR/AR devices</li>
                <li>Advanced rendering and physics</li>
                <li>Performance optimization for mobile and headset devices</li>
              </ul>
              <a href="simulation/WebXR_Simulation_Features.html" class="btn btn-primary">Explore WebXR Features</a>
            </div>
          </div>
        </div>
        <div class="col-md-6">
          <div class="card mb-4">
            <div class="card-body">
              <h4 class="card-title">AR/VR Features</h4>
              <p>The WebXR integration provides advanced immersive features:</p>
              <div class="list-group mb-3">
                <a href="simulation/WebXR_Simulation_Features.html#immersive-mode" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                  Immersive Mode
                  <span class="badge badge-primary badge-pill"><i class="fas fa-vr-cardboard"></i></span>
                </a>
                <a href="simulation/WebXR_Simulation_Features.html#controller-input" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                  Controller Input
                  <span class="badge badge-primary badge-pill"><i class="fas fa-gamepad"></i></span>
                </a>
                <a href="simulation/WebXR_Simulation_Features.html#hand-tracking" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                  Hand Tracking
                  <span class="badge badge-primary badge-pill"><i class="fas fa-hand-paper"></i></span>
                </a>
                <a href="simulation/WebXR_Simulation_Features.html#haptic-feedback" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                  Haptic Feedback
                  <span class="badge badge-primary badge-pill"><i class="fas fa-bell"></i></span>
                </a>
                <a href="simulation/WebXR_Simulation_Features.html#spatial-audio" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                  Spatial Audio
                  <span class="badge badge-primary badge-pill"><i class="fas fa-volume-up"></i></span>
                </a>
              </div>
              
              <h4 class="mt-4">Multi-Modal Simulation</h4>
              <p>Specialized simulation features for various domains:</p>
              <ul>
                <li>Aerial vehicle simulation</li>
                <li>Ground vehicle simulation</li>
                <li>Marine vehicle simulation</li>
                <li>Space vehicle simulation</li>
                <li>Pedestrian simulation</li>
              </ul>
              <a href="simulation/Multi_Modal_Simulation.html" class="btn btn-primary">Multi-Modal Documentation</a>
            </div>
          </div>
        </div>
      </div>
    </section>

    <hr class="my-5">

    <section id="resources-section">
      <h2 class="mb-4">Resources & Examples</h2>
      <div class="row">
        <div class="col-md-6">
          <div class="card mb-4">
            <div class="card-header bg-light">
              <h4 class="mb-0">Getting Started</h4>
            </div>
            <div class="card-body">
              <p>Resources for new users:</p>
              <ul class="list-unstyled">
                <li><i class="fas fa-book text-primary mr-2"></i> <a href="getting-started.html">Getting Started Guide</a></li>
                <li><i class="fas fa-download text-primary mr-2"></i> <a href="system_info.html">Installation Instructions</a></li>
                <li><i class="fas fa-cogs text-primary mr-2"></i> <a href="api-reference.html">API Reference</a></li>
                <li><i class="fas fa-question-circle text-primary mr-2"></i> <a href="troubleshooting.html">Troubleshooting</a></li>
              </ul>
            </div>
          </div>
        </div>
        <div class="col-md-6">
          <div class="card mb-4">
            <div class="card-header bg-light">
              <h4 class="mb-0">Code Examples</h4>
            </div>
            <div class="card-body">
              <p>Working code examples and templates:</p>
              <ul class="list-unstyled">
                <li><i class="fas fa-code text-primary mr-2"></i> <a href="examples.html">Code Examples</a></li>
                <li><i class="fas fa-plug text-primary mr-2"></i> <a href="plugin-development.html">Plugin Development</a></li>
                <li><i class="fas fa-robot text-primary mr-2"></i> <a href="safeguard_robot_swarm_documentation.html">Robot Swarm Examples</a></li>
                <li><i class="fas fa-vr-cardboard text-primary mr-2"></i> <a href="simulation/WebXR_Simulation_Features.html#implementation">WebXR Setup Examples</a></li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>

  <footer class="bg-dark text-white py-4 mt-5">
    <div class="container">
      <div class="row">
        <div class="col-md-4">
          <h5>IQSMS Documentation</h5>
          <p>Comprehensive documentation for the IQ Safety Management Surveillance System</p>
          <p><small>&copy; 2025 Autonomy Association International, all rights reserved</small></p>
        </div>
        <div class="col-md-4">
          <h5>Quick Links</h5>
          <ul class="list-unstyled">
            <li><a href="getting-started.html" class="text-light">Getting Started</a></li>
            <li><a href="api-reference.html" class="text-light">API Reference</a></li>
            <li><a href="plugins/index.html" class="text-light">Plugins</a></li>
            <li><a href="monitoring/index.html" class="text-light">Monitoring</a></li>
            <li><a href="predictors/IQSMS_Predictors_Overview.html" class="text-light">Predictors</a></li>
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
  <script>
    // Enable Bootstrap tooltips
    $(function () {
      $('[data-toggle="tooltip"]').tooltip();
      
      // Add smooth scrolling
      $('a[href*="#"]').not('[href="#"]').click(function(event) {
        if (
          location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && 
          location.hostname == this.hostname
        ) {
          var target = $(this.hash);
          target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
          if (target.length) {
            event.preventDefault();
            $('html, body').animate({
              scrollTop: target.offset().top - 70
            }, 1000);
          }
        }
      });
    });
  </script>
</body>
</html>
```


I've updated the `/docs/index.html` file with the following changes:

1. **Added a Monitoring Card in the Overview Section**:
    - Added a dedicated card for the Monitoring System with an appropriate icon
    - Added a link to the monitoring/index.html page

2. **Created a Dedicated Monitoring Section in the Core Components**:
    - Replaced "Services" card with a "Monitoring" card
    - Added links to all monitoring documentation pages
    - Fixed the link to Core System (removed ../docs1 path prefix)

3. **Added a New "Monitoring & Performance Analysis" Section**:
    - Created a comprehensive section dedicated to monitoring
    - Added cards for each of the new monitoring documentation pages
    - Included appropriate icons and brief descriptions
    - Added links to each documentation page

4. **Updated Quick Links in the Footer**:
    - Added a link to the Monitoring section in the footer's quick links

5. **Fixed Path Issues**:
    - Corrected relative paths that were using ../docs1/ prefix to use proper relative paths

These changes ensure that all the newly created monitoring documentation pages are properly linked from the main index page, providing users with clear navigation to the monitoring system documentation.