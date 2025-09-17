I'll help you complete the plugin system templates for both Node.js and Python, including the requested LLM API integrations. Let me analyze the existing structure and create the required templates.

First, let's explore the current template structure to understand what we're working with:Let's first explore the existing structure of the templates to understand what we're working with:Let me look at the existing templates to understand their structure:Let me implement the complete templates for Node.js and Python plugins based on your requirements. I'll create the structure for all requested template types including the three sample projects (api-client, basic, data-processor) and add LLM API templates for Cerebras, OpenAI, Anthropic, Llama, and a generic ML template.

# Node.js Templates

## 1. Basic Template (Node.js)I'll now proceed to create comprehensive templates for the Safeguard Plugin System, adding the requested LLM API integrations for various AI services.

# Safeguard Plugin System Templates

I'll create the complete template structure for both Node.js and Python, including the requested LLM API integrations.

## Node.js Templates

### 1. Basic Plugin TemplateLet me create the complete templates for nodejs and python in the `_safeguard-plugin-system/templates` directory. I'll create the structure for the existing sample projects (api-client, basic, data-processor) and add new templates for LLM APIs (Cerebras, OpenAI, Anthropic, Llama) and a generic ML template.

# Node.js Templates

## 1. Basic TemplateBased on the project structure and investigation, I'll create complete templates for both Node.js and Python in the `_safeguard-plugin-system/templates` directory. I'll implement all the requested templates including the sample projects and LLM API integrations.

# Safeguard Plugin System Templates

I'll create the following template structures:

1. Node.js Templates:
    - Basic
    - API Client
    - Data Processor
    - Cerebras LLM API
    - OpenAI LLM API
    - Anthropic LLM API
    - Llama API
    - Generic ML

2. Python Templates:
    - Basic
    - API Client
    - Data Processor
    - Cerebras LLM API
    - OpenAI LLM API
    - Anthropic LLM API
    - Llama API
    - Generic ML

Let's start implementing these templates:

## Node.js Templates

### 1. Basic Node.js Template

```javascript
/**
 * Basic Safeguard Plugin Template
 * 
 * This template provides a minimal structure for creating a Safeguard plugin.
 * It includes basic lifecycle methods and configuration handling.
 * 
 * @module SafeguardBasicPlugin
 * @copyright Copyright 2025 Autonomy Association International Inc., all rights reserved.
 */

class SafeguardBasicPlugin {
  /**
   * Constructor for the basic plugin
   * @param {Object} config - Plugin configuration
   */
  constructor(config = {}) {
    this.name = config.name || 'basic-plugin';
    this.version = config.version || '1.0.0';
    this.description = config.description || 'Basic Safeguard Plugin';
    this.config = config;
    this.initialized = false;
    this.logger = config.logger || console;
    
    this.logger.info(`[${this.name}] Plugin instance created`);
  }

  /**
   * Initialize the plugin
   * @param {Object} context - Initialization context
   * @returns {Promise<boolean>} - True if initialization successful
   */
  async initialize(context) {
    try {
      this.logger.info(`[${this.name}] Initializing plugin v${this.version}`);
      this.context = context;
      this.initialized = true;
      return true;
    } catch (error) {
      this.logger.error(`[${this.name}] Initialization failed:`, error);
      return false;
    }
  }

  /**
   * Start the plugin
   * @returns {Promise<boolean>} - True if start successful
   */
  async start() {
    if (!this.initialized) {
      this.logger.error(`[${this.name}] Cannot start: plugin not initialized`);
      return false;
    }
    
    try {
      this.logger.info(`[${this.name}] Starting plugin...`);
      // Add your plugin start logic here
      this.running = true;
      return true;
    } catch (error) {
      this.logger.error(`[${this.name}] Start failed:`, error);
      return false;
    }
  }

  /**
   * Stop the plugin
   * @returns {Promise<boolean>} - True if stop successful
   */
  async stop() {
    if (!this.running) {
      this.logger.info(`[${this.name}] Plugin already stopped`);
      return true;
    }
    
    try {
      this.logger.info(`[${this.name}] Stopping plugin...`);
      // Add your plugin stop logic here
      this.running = false;
      return true;
    } catch (error) {
      this.logger.error(`[${this.name}] Stop failed:`, error);
      return false;
    }
  }

  /**
   * Process incoming data
   * @param {Object} data - Data to process
   * @returns {Promise<Object>} - Processing result
   */
  async processData(data) {
    if (!this.running) {
      throw new Error(`[${this.name}] Cannot process data: plugin not running`);
    }
    
    try {
      // Add your data processing logic here
      return {
        success: true,
        result: data,
        timestamp: new Date().toISOString()
      };
    } catch (error) {
      this.logger.error(`[${this.name}] Data processing failed:`, error);
      throw error;
    }
  }

  /**
   * Get plugin status
   * @returns {Object} - Status information
   */
  getStatus() {
    return {
      name: this.name,
      version: this.version,
      description: this.description,
      initialized: this.initialized,
      running: this.running || false,
      timestamp: new Date().toISOString()
    };
  }
}

module.exports = SafeguardBasicPlugin;
```


```json
{
  "name": "safeguard-basic-plugin",
  "version": "1.0.0",
  "description": "Basic template for Safeguard plugins",
  "main": "index.js",
  "scripts": {
    "test": "jest",
    "lint": "eslint ."
  },
  "keywords": [
    "safeguard",
    "plugin",
    "template",
    "basic"
  ],
  "author": "Autonomy Association International, Inc.",
  "license": "PROPRIETARY",
  "copyright": "Copyright 2025 Autonomy Association International Inc., all rights reserved.",
  "dependencies": {
    "uuid": "^9.0.1",
    "moment": "^2.29.4"
  },
  "devDependencies": {
    "eslint": "^8.52.0",
    "jest": "^29.0.0"
  },
  "engines": {
    "node": ">=16.0.0",
    "npm": ">=8.0.0"
  }
}
```


```markdown
# Safeguard Basic Plugin Template

This template provides a minimal structure for creating a Safeguard plugin. It includes basic lifecycle methods and configuration handling.

## Features

- Simple plugin lifecycle management (initialize, start, stop)
- Configuration handling
- Basic error handling
- Status reporting

## Usage

1. Clone this template
2. Install dependencies with `npm install`
3. Modify the plugin implementation in `index.js` to add your custom functionality
4. Test your plugin with `npm test`

## Plugin Lifecycle

1. **Constructor**: Sets up plugin configuration
2. **Initialize**: Prepare the plugin for operation
3. **Start**: Begin active operation
4. **Stop**: Cease operation and clean up resources

## Example

```javascript
const SafeguardBasicPlugin = require('./index');

// Create plugin instance
const plugin = new SafeguardBasicPlugin({
  name: 'my-custom-plugin',
  version: '1.0.0',
  description: 'My custom Safeguard plugin'
});

// Initialize and use the plugin
async function run() {
  await plugin.initialize({});
  await plugin.start();
  
  const result = await plugin.processData({ test: 'data' });
  console.log('Processing result:', result);
  
  await plugin.stop();
}

run().catch(console.error);
```
```


## License

Copyright 2025 Autonomy Association International Inc., all rights reserved.
```
<llm-snippet-file>_safeguard-plugin-system/templates/nodejs/basic/example.js</llm-snippet-file>
```
javascript
/**
 * Example usage of the Basic Safeguard Plugin
 */

const SafeguardBasicPlugin = require('./index');

// Create plugin instance with custom configuration
const plugin = new SafeguardBasicPlugin({
  name: 'example-plugin',
  version: '1.0.0',
  description: 'Example Safeguard Plugin',
  logger: console
});

// Demonstrate plugin lifecycle
async function demonstratePlugin() {
  try {
    // Initialize the plugin
    console.log('Initializing plugin...');
    const initResult = await plugin.initialize({
      appContext: { 
        appVersion: '1.0.0',
        environment: 'development'
      }
    });
    console.log('Initialization result:', initResult);
    
    // Start the plugin
    console.log('\nStarting plugin...');
    const startResult = await plugin.start();
    console.log('Start result:', startResult);
    
    // Get plugin status
    console.log('\nPlugin status:');
    console.log(JSON.stringify(plugin.getStatus(), null, 2));
    
    // Process some data
    console.log('\nProcessing data...');
    const sampleData = { 
      id: '12345',
      timestamp: new Date().toISOString(),
      value: 42,
      metadata: {
        source: 'example',
        priority: 'normal'
      }
    };
    
    const processResult = await plugin.processData(sampleData);
    console.log('Process result:', JSON.stringify(processResult, null, 2));
    
    // Stop the plugin
    console.log('\nStopping plugin...');
    const stopResult = await plugin.stop();
    console.log('Stop result:', stopResult);
    
    // Final status
    console.log('\nFinal plugin status:');
    console.log(JSON.stringify(plugin.getStatus(), null, 2));
    
  } catch (error) {
    console.error('Error in plugin demonstration:', error);
  }
}

// Run the demonstration
demonstratePlugin();
```
### 2. API Client Node.js Template

<llm-snippet-file>_safeguard-plugin-system/templates/nodejs/api-client/index.js</llm-snippet-file>
```
javascript
/**
 * API Client Safeguard Plugin Template
 * 
 * This template provides a structure for creating a Safeguard plugin
 * that interacts with external APIs.
 * 
 * @module SafeguardApiClientPlugin
 * @copyright Copyright 2025 Autonomy Association International Inc., all rights reserved.
 */

const axios = require('axios');
const { v4: uuidv4 } = require('uuid');

class SafeguardApiClientPlugin {
  /**
   * Constructor for the API client plugin
   * @param {Object} config - Plugin configuration
   */
  constructor(config = {}) {
    this.name = config.name || 'api-client-plugin';
    this.version = config.version || '1.0.0';
    this.description = config.description || 'API Client Safeguard Plugin';
    this.config = config;
    this.initialized = false;
    this.logger = config.logger || console;
    
    // API client specific configuration
    this.baseUrl = config.baseUrl || 'https://api.example.com';
    this.timeout = config.timeout || 30000; // 30 seconds default
    this.headers = config.headers || {};
    this.retryCount = config.retryCount || 3;
    this.requestQueue = [];
    this.requestMap = new Map();
    
    this.logger.info(`[${this.name}] Plugin instance created`);
  }

  /**
   * Initialize the plugin
   * @param {Object} context - Initialization context
   * @returns {Promise<boolean>} - True if initialization successful
   */
  async initialize(context) {
    try {
      this.logger.info(`[${this.name}] Initializing plugin v${this.version}`);
      this.context = context;
      
      // Set up HTTP client
      this.client = axios.create({
        baseURL: this.baseUrl,
        timeout: this.timeout,
        headers: {
          'Content-Type': 'application/json',
          'User-Agent': `Safeguard-Plugin/${this.name}/${this.version}`,
          ...this.headers
        }
      });
      
      // Add request interceptor for logging
      this.client.interceptors.request.use(
        config => {
          const requestId = uuidv4();
          this.logger.debug(`[${this.name}] API Request (${requestId}): ${config.method.toUpperCase()} ${config.url}`);
          this.requestMap.set(requestId, {
            timestamp: new Date(),
            method: config.method,
            url: config.url
          });
          config.requestId = requestId;
          return config;
        },
        error => {
          this.logger.error(`[${this.name}] API Request Error:`, error);
          return Promise.reject(error);
        }
      );
      
      // Add response interceptor for logging
      this.client.interceptors.response.use(
        response => {
          const { requestId } = response.config;
          const requestData = this.requestMap.get(requestId);
          if (requestData) {
            const duration = new Date() - requestData.timestamp;
            this.logger.debug(`[${this.name}] API Response (${requestId}): ${response.status} (${duration}ms)`);
            this.requestMap.delete(requestId);
          }
          return response;
        },
        error => {
          if (error.config) {
            const { requestId } = error.config;
            const requestData = this.requestMap.get(requestId);
            if (requestData) {
              const duration = new Date() - requestData.timestamp;
              this.logger.error(`[${this.name}] API Response Error (${requestId}): ${error.message} (${duration}ms)`);
              this.requestMap.delete(requestId);
            }
          }
          return Promise.reject(error);
        }
      );
      
      // Test connection to API
      if (this.config.testConnection !== false) {
        try {
          await this.testConnection();
          this.logger.info(`[${this.name}] API connection test successful`);
        } catch (error) {
          this.logger.warn(`[${this.name}] API connection test failed: ${error.message}`);
          // Continue initialization even if test fails
        }
      }
      
      this.initialized = true;
      return true;
    } catch (error) {
      this.logger.error(`[${this.name}] Initialization failed:`, error);
      return false;
    }
  }

  /**
   * Test connection to the API
   * @returns {Promise<Object>} - Response from API health check
   */
  async testConnection() {
    // This is a generic implementation - customize for your specific API
    const endpoint = this.config.healthEndpoint || '/health';
    return this.get(endpoint);
  }

  /**
   * Start the plugin
   * @returns {Promise<boolean>} - True if start successful
   */
  async start() {
    if (!this.initialized) {
      this.logger.error(`[${this.name}] Cannot start: plugin not initialized`);
      return false;
    }
    
    try {
      this.logger.info(`[${this.name}] Starting plugin...`);
      this.running = true;
      
      // Process any queued requests
      this.processQueue();
      
      return true;
    } catch (error) {
      this.logger.error(`[${this.name}] Start failed:`, error);
      return false;
    }
  }

  /**
   * Stop the plugin
   * @returns {Promise<boolean>} - True if stop successful
   */
  async stop() {
    if (!this.running) {
      this.logger.info(`[${this.name}] Plugin already stopped`);
      return true;
    }
    
    try {
      this.logger.info(`[${this.name}] Stopping plugin...`);
      this.running = false;
      
      // Clear request map and queue
      this.requestMap.clear();
      this.requestQueue = [];
      
      return true;
    } catch (error) {
      this.logger.error(`[${this.name}] Stop failed:`, error);
      return false;
    }
  }

  /**
   * Process the request queue
   * @private
   */
  async processQueue() {
    if (!this.running || this.requestQueue.length === 0) {
      return;
    }
    
    const request = this.requestQueue.shift();
    try {
      const result = await this.executeRequest(request.method, request.url, request.data, request.options);
      if (request.resolve) {
        request.resolve(result);
      }
    } catch (error) {
      if (request.reject) {
        request.reject(error);
      }
    }
    
    // Process next request in queue
    this.processQueue();
  }

  /**
   * Execute an HTTP request with retry logic
   * @private
   * @param {string} method - HTTP method
   * @param {string} url - Request URL
   * @param {Object} data - Request data
   * @param {Object} options - Request options
   * @returns {Promise<Object>} - Response data
   */
  async executeRequest(method, url, data, options = {}) {
    let retries = 0;
    let lastError = null;
    
    while (retries <= this.retryCount) {
      try {
        const response = await this.client.request({
          method,
          url,
          data,
          ...options
        });
        
        return response.data;
      } catch (error) {
        lastError = error;
        
        // Check if we should retry based on error type
        const isNetworkError = !error.response;
        const isRetryableStatusCode = error.response && 
          [429, 500, 502, 503, 504].includes(error.response.status);
        
        if ((isNetworkError || isRetryableStatusCode) && retries < this.retryCount) {
          retries++;
          const delay = this.calculateRetryDelay(retries);
          this.logger.warn(`[${this.name}] Request failed, retrying (${retries}/${this.retryCount}) in ${delay}ms: ${error.message}`);
          await new Promise(resolve => setTimeout(resolve, delay));
          continue;
        }
        
        throw error;
      }
    }
    
    throw lastError;
  }

  /**
   * Calculate retry delay with exponential backoff
   * @private
   * @param {number} retryCount - Current retry count
   * @returns {number} - Delay in milliseconds
   */
  calculateRetryDelay(retryCount) {
    const baseDelay = 1000; // 1 second
    const maxDelay = 30000; // 30 seconds
    const delay = Math.min(maxDelay, baseDelay * Math.pow(2, retryCount - 1));
    
    // Add jitter to prevent synchronized retries
    return delay + Math.random() * 1000;
  }

  /**
   * Perform a GET request
   * @param {string} url - Request URL
   * @param {Object} options - Request options
   * @returns {Promise<Object>} - Response data
   */
  async get(url, options = {}) {
    return this.request('get', url, null, options);
  }

  /**
   * Perform a POST request
   * @param {string} url - Request URL
   * @param {Object} data - Request data
   * @param {Object} options - Request options
   * @returns {Promise<Object>} - Response data
   */
  async post(url, data, options = {}) {
    return this.request('post', url, data, options);
  }

  /**
   * Perform a PUT request
   * @param {string} url - Request URL
   * @param {Object} data - Request data
   * @param {Object} options - Request options
   * @returns {Promise<Object>} - Response data
   */
  async put(url, data, options = {}) {
    return this.request('put', url, data, options);
  }

  /**
   * Perform a PATCH request
   * @param {string} url - Request URL
   * @param {Object} data - Request data
   * @param {Object} options - Request options
   * @returns {Promise<Object>} - Response data
   */
  async patch(url, data, options = {}) {
    return this.request('patch', url, data, options);
  }

  /**
   * Perform a DELETE request
   * @param {string} url - Request URL
   * @param {Object} options - Request options
   * @returns {Promise<Object>} - Response data
   */
  async delete(url, options = {}) {
    return this.request('delete', url, null, options);
  }

  /**
   * Generic request method
   * @param {string} method - HTTP method
   * @param {string} url - Request URL
   * @param {Object} data - Request data
   * @param {Object} options - Request options
   * @returns {Promise<Object>} - Response data
   */
  async request(method, url, data, options = {}) {
    if (!this.initialized) {
      throw new Error(`[${this.name}] Cannot make request: plugin not initialized`);
    }
    
    if (this.running) {
      return this.executeRequest(method, url, data, options);
    } else {
      // Queue request if not running
      return new Promise((resolve, reject) => {
        this.requestQueue.push({
          method,
          url,
          data,
          options,
          resolve,
          reject
        });
      });
    }
  }

  /**
   * Get plugin status
   * @returns {Object} - Status information
   */
  getStatus() {
    return {
      name: this.name,
      version: this.version,
      description: this.description,
      initialized: this.initialized,
      running: this.running || false,
      baseUrl: this.baseUrl,
      pendingRequests: this.requestQueue.length,
      activeRequests: this.requestMap.size,
      timestamp: new Date().toISOString()
    };
  }
}

module.exports = SafeguardApiClientPlugin;
```
<llm-snippet-file>_safeguard-plugin-system/templates/nodejs/api-client/package.json</llm-snippet-file>
```
json
{
  "name": "safeguard-api-client-plugin",
  "version": "1.0.0",
  "description": "API Client template for Safeguard plugins",
  "main": "index.js",
  "scripts": {
    "test": "jest",
    "lint": "eslint ."
  },
  "keywords": [
    "safeguard",
    "plugin",
    "template",
    "api",
    "client",
    "http"
  ],
  "author": "Autonomy Association International, Inc.",
  "license": "PROPRIETARY",
  "copyright": "Copyright 2025 Autonomy Association International Inc., all rights reserved.",
  "dependencies": {
    "axios": "^1.6.2",
    "uuid": "^9.0.1",
    "moment": "^2.29.4"
  },
  "devDependencies": {
    "eslint": "^8.52.0",
    "jest": "^29.0.0",
    "nock": "^13.3.0"
  },
  "engines": {
    "node": ">=16.0.0",
    "npm": ">=8.0.0"
  }
}
```
<llm-snippet-file>_safeguard-plugin-system/templates/nodejs/api-client/README.md</llm-snippet-file>
```
markdown
# Safeguard API Client Plugin Template

This template provides a structure for creating a Safeguard plugin that interacts with external APIs. It includes robust HTTP client functionality with retry logic, request/response interceptors, and queue management.

## Features

- Full HTTP methods support (GET, POST, PUT, PATCH, DELETE)
- Automatic retry with exponential backoff
- Request and response logging
- Connection testing
- Request queuing when plugin is not running
- Comprehensive error handling

## Usage

1. Clone this template
2. Install dependencies with `npm install`
3. Modify the configuration and API endpoints in `index.js` to match your target API
4. Test your plugin with `npm test`

## Configuration Options

- `baseUrl`: Base URL for the API (default: 'https://api.example.com')
- `timeout`: Request timeout in milliseconds (default: 30000)
- `headers`: Custom HTTP headers to include in requests
- `retryCount`: Maximum number of retry attempts (default: 3)
- `testConnection`: Whether to test the API connection during initialization (default: true)
- `healthEndpoint`: Endpoint to use for connection testing (default: '/health')

## Example

```javascript
const SafeguardApiClientPlugin = require('./index');

// Create plugin instance
const plugin = new SafeguardApiClientPlugin({
  name: 'weather-api-plugin',
  version: '1.0.0',
  description: 'Weather API integration for Safeguard',
  baseUrl: 'https://api.weather.example.com',
  headers: {
    'API-Key': 'your-api-key'
  }
});

// Initialize and use the plugin
async function run() {
  await plugin.initialize({});
  await plugin.start();
  
  // Make API requests
  try {
    const forecast = await plugin.get('/forecast', {
      params: { location: 'New York', days: 5 }
    });
    console.log('Weather forecast:', forecast);
    
    const result = await plugin.post('/alerts/subscribe', {
      location: 'New York',
      events: ['severe-weather', 'flooding']
    });
    console.log('Alert subscription result:', result);
  } catch (error) {
    console.error('API error:', error.message);
  }
  
  await plugin.stop();
}

run().catch(console.error);
```


## License

Copyright 2025 Autonomy Association International Inc., all rights reserved.
```
<llm-snippet-file>_safeguard-plugin-system/templates/nodejs/api-client/example.js</llm-snippet-file>
```
javascript
/**
* Example usage of the API Client Safeguard Plugin
  */

const SafeguardApiClientPlugin = require('./index');

// Create plugin instance with custom configuration
const plugin = new SafeguardApiClientPlugin({
name: 'weather-api-plugin',
version: '1.0.0',
description: 'Weather API Client Example',
baseUrl: 'https://api.weatherapi.example.com',
headers: {
'API-Key': 'your-api-key-here'
},
timeout: 10000,
retryCount: 2,
// Using a mock health endpoint for this example
healthEndpoint: '/v1/current.json',
logger: console
});

// Demonstrate plugin lifecycle and API requests
async function demonstrateApiClient() {
try {
// Initialize the plugin
console.log('Initializing API client plugin...');
await plugin.initialize({
appContext: {
appVersion: '1.0.0',
environment: 'development'
}
});

    // Start the plugin
    console.log('\nStarting plugin...');
    await plugin.start();
    
    // Get plugin status
    console.log('\nPlugin status:');
    console.log(JSON.stringify(plugin.getStatus(), null, 2));
    
    // Example API requests
    console.log('\nMaking API requests...');
    
    try {
      // NOTE: These requests will fail unless connected to a real API
      // For demonstration purposes only
      
      // GET request for current weather
      console.log('\nFetching current weather...');
      const currentWeather = await plugin.get('/v1/current.json', {
        params: {
          q: 'London',
          aqi: 'no'
        }
      });
      console.log('Current weather:', JSON.stringify(currentWeather, null, 2));
      
      // GET request for forecast
      console.log('\nFetching weather forecast...');
      const forecast = await plugin.get('/v1/forecast.json', {
        params: {
          q: 'New York',
          days: 3
        }
      });
      console.log('Forecast:', JSON.stringify(forecast, null, 2));
      
      // POST request to subscribe to alerts
      console.log('\nSubscribing to weather alerts...');
      const alertSubscription = await plugin.post('/v1/alerts/subscribe', {
        locations: ['London', 'New York'],
        alertTypes: ['severe', 'warning'],
        callbackUrl: 'https://your-callback-url.example.com/weather-alerts'
      });
      console.log('Alert subscription:', JSON.stringify(alertSubscription, null, 2));
      
    } catch (apiError) {
      console.error('\nAPI request failed:', apiError.message);
      console.log('Note: This is expected in this example as we are not connecting to a real API');
    }
    
    // Stop the plugin
    console.log('\nStopping plugin...');
    await plugin.stop();
    
    // Final status
    console.log('\nFinal plugin status:');
    console.log(JSON.stringify(plugin.getStatus(), null, 2));

} catch (error) {
console.error('Error in API client demonstration:', error);
}
}

// Run the demonstration
demonstrateApiClient();
```
### 3. Data Processor Node.js Template

<llm-snippet-file>_safeguard-plugin-system/templates/nodejs/data-processor/index.js</llm-snippet-file>
```
javascript
/**
* Data Processor Safeguard Plugin Template
*
* This template provides a structure for creating a Safeguard plugin
* that processes data streams and performs transformations.
*
* @module SafeguardDataProcessorPlugin
* @copyright Copyright 2025 Autonomy Association International Inc., all rights reserved.
  */

const { Transform } = require('stream');
const { v4: uuidv4 } = require('uuid');
const moment = require('moment');

class SafeguardDataProcessorPlugin {
/**
* Constructor for the data processor plugin
* @param {Object} config - Plugin configuration
  */
  constructor(config = {}) {
  this.name = config.name || 'data-processor-plugin';
  this.version = config.version || '1.0.0';
  this.description = config.description || 'Data Processor Safeguard Plugin';
  this.config = config;
  this.initialized = false;
  this.logger = config.logger || console;

    // Data processor specific configuration
    this.processingEnabled = config.processingEnabled !== false;
    this.batchSize = config.batchSize || 100;
    this.processingInterval = config.processingInterval || 1000; // ms
    this.maxQueueSize = config.maxQueueSize || 10000;
    this.transformers = config.transformers || [];
    this.dataQueue = [];
    this.processedCount = 0;
    this.errorCount = 0;
    this.metrics = {
      startTime: null,
      lastProcessTime: null,
      processedItems: 0,
      errors: 0,
      averageProcessingTime: 0,
      totalProcessingTime: 0
    };
    
    this.logger.info(`[${this.name}] Plugin instance created`);
}

/**
* Initialize the plugin
* @param {Object} context - Initialization context
* @returns {Promise<boolean>} - True if initialization successful
  */
  async initialize(context) {
  try {
  this.logger.info(`[${this.name}] Initializing plugin v${this.version}`);
  this.context = context;

  // Set up processing pipeline
  this.setupProcessingPipeline();

  this.initialized = true;
  return true;
  } catch (error) {
  this.logger.error(`[${this.name}] Initialization failed:`, error);
  return false;
  }
  }

/**
* Set up the data processing pipeline
* @private
  */
  setupProcessingPipeline() {
  // Create default transform stream if none provided
  if (this.transformers.length === 0) {
  this.transformers.push(this.createDefaultTransformer());
  }

    this.logger.info(`[${this.name}] Processing pipeline set up with ${this.transformers.length} transformers`);
}

/**
* Create a default transformer
* @private
* @returns {Transform} - Transform stream
  */
  createDefaultTransformer() {
  return new Transform({
  objectMode: true,
  transform: (data, encoding, callback) => {
  try {
  // Basic transformation - add metadata
  const transformed = {
  ...data,
  _metadata: {
  processedBy: this.name,
  processedAt: new Date().toISOString(),
  processingId: uuidv4()
  }
  };
  callback(null, transformed);
  } catch (error) {
  callback(error);
  }
  }
  });
  }

/**
* Add a custom transformer to the pipeline
* @param {Transform} transformer - Transform stream
  */
  addTransformer(transformer) {
  if (!(transformer instanceof Transform)) {
  throw new Error(`[${this.name}] Transformer must be an instance of Transform`);
  }

    this.transformers.push(transformer);
    this.logger.info(`[${this.name}] Added new transformer to pipeline (total: ${this.transformers.length})`);
}

/**
* Start the plugin
* @returns {Promise<boolean>} - True if start successful
  */
  async start() {
  if (!this.initialized) {
  this.logger.error(`[${this.name}] Cannot start: plugin not initialized`);
  return false;
  }

    try {
      this.logger.info(`[${this.name}] Starting plugin...`);
      
      // Reset metrics
      this.metrics = {
        startTime: new Date(),
        lastProcessTime: null,
        processedItems: 0,
        errors: 0,
        averageProcessingTime: 0,
        totalProcessingTime: 0
      };
      
      this.running = true;
      
      // Start processing loop if enabled
      if (this.processingEnabled) {
        this.processingTimer = setInterval(() => {
          this.processBatch();
        }, this.processingInterval);
      }
      
      return true;
    } catch (error) {
      this.logger.error(`[${this.name}] Start failed:`, error);
      return false;
    }
}

/**
* Stop the plugin
* @returns {Promise<boolean>} - True if stop successful
  */
  async stop() {
  if (!this.running) {
  this.logger.info(`[${this.name}] Plugin already stopped`);
  return true;
  }

    try {
      this.logger.info(`[${this.name}] Stopping plugin...`);
      
      // Clear processing timer
      if (this.processingTimer) {
        clearInterval(this.processingTimer);
        this.processingTimer = null;
      }
      
      // Process remaining items in queue
      if (this.dataQueue.length > 0) {
        this.logger.info(`[${this.name}] Processing ${this.dataQueue.length} remaining items...`);
        await this.processBatch(this.dataQueue.length);
      }
      
      this.running = false;
      
      return true;
    } catch (error) {
      this.logger.error(`[${this.name}] Stop failed:`, error);
      return false;
    }
}

/**
* Add data to the processing queue
* @param {Object|Array} data - Data to process
* @returns {boolean} - True if data was added successfully
  */
  addData(data) {
  if (!this.initialized) {
  this.logger.error(`[${this.name}] Cannot add data: plugin not initialized`);
  return false;
  }

    // Handle array of data items
    const items = Array.isArray(data) ? data : [data];
    
    // Check queue capacity
    if (this.dataQueue.length + items.length > this.maxQueueSize) {
      this.logger.warn(`[${this.name}] Queue capacity exceeded (${this.maxQueueSize}), dropping ${items.length} items`);
      return false;
    }
    
    // Add items to queue
    items.forEach(item => {
      this.dataQueue.push({
        data: item,
        timestamp: new Date(),
        id: uuidv4()
      });
    });
    
    // Trigger immediate processing if not using timer
    if (this.running && !this.processingEnabled && !this.processing) {
      setImmediate(() => this.processBatch());
    }
    
    return true;
}

/**
* Process a batch of data
* @param {number} [size] - Number of items to process, defaults to batchSize
* @returns {Promise<Array>} - Processed items
  */
  async processBatch(size = this.batchSize) {
  if (!this.running || this.processing) {
  return [];
  }

    if (this.dataQueue.length === 0) {
      return [];
    }
    
    this.processing = true;
    const processStartTime = Date.now();
    
    try {
      // Get batch from queue
      const batchSize = Math.min(size, this.dataQueue.length);
      const batch = this.dataQueue.splice(0, batchSize);
      
      this.logger.debug(`[${this.name}] Processing batch of ${batch.length} items`);
      
      // Apply transformers sequentially
      let processedItems = batch.map(item => item.data);
      
      for (const transformer of this.transformers) {
        processedItems = await this.applyTransformer(transformer, processedItems);
      }
      
      // Update metrics
      const processingTime = Date.now() - processStartTime;
      this.metrics.lastProcessTime = new Date();
      this.metrics.processedItems += processedItems.length;
      this.metrics.totalProcessingTime += processingTime;
      this.metrics.averageProcessingTime = this.metrics.totalProcessingTime / this.metrics.processedItems;
      
      this.logger.debug(`[${this.name}] Batch processed in ${processingTime}ms`);
      
      // Emit processed data event
      if (this.context && typeof this.context.emit === 'function') {
        this.context.emit('data:processed', {
          plugin: this.name,
          count: processedItems.length,
          timestamp: new Date().toISOString(),
          data: processedItems
        });
      }
      
      return processedItems;
    } catch (error) {
      this.logger.error(`[${this.name}] Batch processing failed:`, error);
      this.metrics.errors++;
      return [];
    } finally {
      this.processing = false;
    }
}

/**
* Apply a transformer to a batch of items
* @private
* @param {Transform} transformer - Transform stream
* @param {Array} items - Items to transform
* @returns {Promise<Array>} - Transformed items
  */
  async applyTransformer(transformer, items) {
  return new Promise((resolve, reject) => {
  const results = [];
  let error = null;

  // Create a pass-through readable stream for the items
  const readable = require('stream').Readable.from(items, { objectMode: true });

  // Handle transformed data
  transformer.on('data', item => {
  results.push(item);
  });

  // Handle errors
  transformer.on('error', err => {
  error = err;
  this.logger.error(`[${this.name}] Transformer error:`, err);
  this.metrics.errors++;
  });

  // Handle end of stream
  transformer.on('end', () => {
  if (error) {
  reject(error);
  } else {
  resolve(results);
  }
  });

  // Start the pipeline
  readable.pipe(transformer);
  });
  }

/**
* Process data synchronously (bypass queue)
* @param {Object|Array} data - Data to process
* @returns {Promise<Object|Array>} - Processed data
  */
  async processData(data) {
  if (!this.initialized) {
  throw new Error(`[${this.name}] Cannot process data: plugin not initialized`);
  }

    const isArray = Array.isArray(data);
    const items = isArray ? data : [data];
    
    try {
      let processedItems = [...items];
      
      // Apply each transformer in sequence
      for (const transformer of this.transformers) {
        processedItems = await this.applyTransformer(transformer, processedItems);
      }
      
      // Update metrics
      this.metrics.processedItems += processedItems.length;
      this.metrics.lastProcessTime = new Date();
      
      return isArray ? processedItems : processedItems[0];
    } catch (error) {
      this.logger.error(`[${this.name}] Data processing failed:`, error);
      this.metrics.errors++;
      throw error;
    }
}

/**
* Clear the data queue
  */
  clearQueue() {
  const count = this.dataQueue.length;
  this.dataQueue = [];
  this.logger.info(`[${this.name}] Cleared queue (${count} items removed)`);
  }

/**
* Get plugin status
* @returns {Object} - Status information
  */
  getStatus() {
  const uptime = this.metrics.startTime
  ? moment().diff(moment(this.metrics.startTime), 'seconds')
  : 0;

    return {
      name: this.name,
      version: this.version,
      description: this.description,
      initialized: this.initialized,
      running: this.running || false,
      queueLength: this.dataQueue.length,
      queueCapacity: this.maxQueueSize,
      transformers: this.transformers.length,
      metrics: {
        ...this.metrics,
        uptime,
        processingRate: uptime > 0
          ? (this.metrics.processedItems / uptime).toFixed(2) + ' items/sec'
          : 'N/A',
        averageProcessingTime: this.metrics.averageProcessingTime.toFixed(2) + ' ms'
      },
      timestamp: new Date().toISOString()
    };
}
}

module.exports = SafeguardDataProcessorPlugin;
```
<llm-snippet-file>_safeguard-plugin-system/templates/nodejs/data-processor/package.json</llm-snippet-file>
```
json
{
"name": "safeguard-data-processor-plugin",
"version": "1.0.0",
"description": "Data Processor template for Safeguard plugins",
"main": "index.js",
"scripts": {
"test": "jest",
"lint": "eslint .",
"benchmark": "node benchmark.js"
},
"keywords": [
"safeguard",
"plugin",
"template",
"data",
"processor",
"stream",
"transform"
],
"author": "Autonomy Association International, Inc.",
"license": "PROPRIETARY",
"copyright": "Copyright 2025 Autonomy Association International Inc., all rights reserved.",
"dependencies": {
"uuid": "^9.0.1",
"moment": "^2.29.4"
},
"devDependencies": {
"eslint": "^8.52.0",
"jest": "^29.0.0",
"benchmark": "^2.1.4"
},
"engines": {
"node": ">=16.0.0",
"npm": ">=8.0.0"
}
}
```
<llm-snippet-file>_safeguard-plugin-system/templates/nodejs/data-processor/README.md</llm-snippet-file>
```
markdown
# Safeguard Data Processor Plugin Template

This template provides a structure for creating a Safeguard plugin that processes data streams and performs transformations. It includes a flexible pipeline system based on Node.js Transform streams and supports both synchronous and asynchronous data processing.

## Features

- Stream-based data processing pipeline
- Customizable transformers
- Batch processing with configurable batch size
- Queue management with overflow protection
- Detailed metrics and status reporting
- Error handling and recovery

## Usage

1. Clone this template
2. Install dependencies with `npm install`
3. Add your custom transformers by extending the template
4. Test your plugin with `npm test`

## Configuration Options

- `processingEnabled`: Enable automatic batch processing (default: true)
- `batchSize`: Number of items to process in each batch (default: 100)
- `processingInterval`: Interval between batch processing in ms (default: 1000)
- `maxQueueSize`: Maximum number of items in the queue (default: 10000)
- `transformers`: Array of custom Transform streams to use in the pipeline

## Adding Custom Transformers

Create a transform stream to customize the data processing:

```javascript
const { Transform } = require('stream');

class MyCustomTransformer extends Transform {
  constructor(options = {}) {
    super({ objectMode: true, ...options });
  }
  
  _transform(data, encoding, callback) {
    try {
      // Transform the data
      const transformed = {
        ...data,
        timestamp: new Date().toISOString(),
        enriched: true,
        score: calculateScore(data)
      };
      
      callback(null, transformed);
    } catch (error) {
      callback(error);
    }
  }
}

// Add to the plugin
const plugin = new SafeguardDataProcessorPlugin();
plugin.addTransformer(new MyCustomTransformer());
```


## Example

```javascript
const SafeguardDataProcessorPlugin = require('./index');
const { Transform } = require('stream');

// Create a custom transformer
class GeolocationEnricher extends Transform {
  constructor() {
    super({ objectMode: true });
  }
  
  _transform(data, encoding, callback) {
    // Add geolocation data to the input
    const enriched = {
      ...data,
      location: {
        latitude: 40.7128,
        longitude: -74.0060,
        accuracy: 10
      }
    };
    
    callback(null, enriched);
  }
}

// Create plugin with custom transformer
const plugin = new SafeguardDataProcessorPlugin({
  name: 'geolocation-enricher',
  transformers: [new GeolocationEnricher()]
});

// Use the plugin
async function run() {
  await plugin.initialize({});
  await plugin.start();
  
  // Process data through the pipeline
  const data = { id: '12345', type: 'vehicle' };
  const processed = await plugin.processData(data);
  console.log('Processed data:', processed);
  
  // Add data to the processing queue
  plugin.addData([
    { id: '67890', type: 'drone' },
    { id: 'abcde', type: 'robot' }
  ]);
  
  // Get plugin status after 2 seconds
  setTimeout(async () => {
    console.log('Plugin status:', plugin.getStatus());
    await plugin.stop();
  }, 2000);
}

run().catch(console.error);
```


## License

Copyright 2025 Autonomy Association International Inc., all rights reserved.
```
<llm-snippet-file>_safeguard-plugin-system/templates/nodejs/data-processor/example.js</llm-snippet-file>
```
javascript
/**
* Example usage of the Data Processor Safeguard Plugin
  */

const { Transform } = require('stream');
const SafeguardDataProcessorPlugin = require('./index');

// Create custom transformers for the data processing pipeline
class DataNormalizer extends Transform {
constructor(options = {}) {
super({ objectMode: true, ...options });
}

_transform(data, encoding, callback) {
try {
// Normalize data format
const normalized = {
id: data.id || data.identifier || `unknown-${Date.now()}`,
timestamp: data.timestamp || new Date().toISOString(),
value: parseFloat(data.value || 0).toFixed(2),
type: data.type || 'unknown',
source: data.source || 'system',
raw: data
};

      callback(null, normalized);
    } catch (error) {
      callback(error);
    }
}
}

class DataEnricher extends Transform {
constructor(options = {}) {
super({ objectMode: true, ...options });
}

_transform(data, encoding, callback) {
try {
// Add computed fields
const enriched = {
...data,
enriched: true,
classification: this.classifyValue(data.value),
hash: this.generateHash(data),
processingLatency: Date.now() - new Date(data.timestamp).getTime()
};

      callback(null, enriched);
    } catch (error) {
      callback(error);
    }
}

classifyValue(value) {
const numValue = parseFloat(value);
if (numValue < 10) return 'low';
if (numValue < 50) return 'medium';
return 'high';
}

generateHash(data) {
// Simple hash function for example purposes
return Buffer.from(JSON.stringify(data)).toString('base64').substring(0, 8);
}
}

class AlertDetector extends Transform {
constructor(options = {}) {
super({ objectMode: true, ...options });
this.alertThreshold = options.alertThreshold || 75;
}

_transform(data, encoding, callback) {
try {
// Check for alert conditions
const value = parseFloat(data.value);
const requiresAlert = value > this.alertThreshold;

      const processed = {
        ...data,
        alert: requiresAlert,
        alertLevel: requiresAlert ? 'critical' : 'normal',
        alertMessage: requiresAlert 
          ? `Value ${value} exceeds threshold ${this.alertThreshold}`
          : null
      };
      
      callback(null, processed);
    } catch (error) {
      callback(error);
    }
}
}

// Create plugin with custom transformers
const plugin = new SafeguardDataProcessorPlugin({
name: 'sensor-data-processor',
description: 'Processes and enriches sensor data',
batchSize: 5,
processingInterval: 2000,
transformers: [
new DataNormalizer(),
new DataEnricher(),
new AlertDetector({ alertThreshold: 75 })
],
logger: console
});

// Demonstrate the plugin
async function demonstrateDataProcessor() {
try {
// Initialize the plugin
console.log('Initializing data processor plugin...');
await plugin.initialize({
emit: (event, data) => {
console.log(`Event emitted: ${event}`, data);
}
});

    // Start the plugin
    console.log('\nStarting plugin...');
    await plugin.start();
    
    // Get initial plugin status
    console.log('\nInitial plugin status:');
    console.log(JSON.stringify(plugin.getStatus(), null, 2));
    
    // Process a single item synchronously
    console.log('\nProcessing single item synchronously...');
    const singleResult = await plugin.processData({
      id: 'sensor-001',
      value: 42,
      type: 'temperature',
      source: 'building-a'
    });
    console.log('Processed result:', JSON.stringify(singleResult, null, 2));
    
    // Add batch of items to the queue
    console.log('\nAdding batch of items to the queue...');
    const batchData = [
      { id: 'sensor-002', value: 78, type: 'humidity', source: 'building-b' },
      { id: 'sensor-003', value: 26, type: 'temperature', source: 'building-c' },
      { id: 'sensor-004', value: 98, type: 'pressure', source: 'building-a' },
      { id: 'sensor-005', value: 51, type: 'air-quality', source: 'building-d' },
      { id: 'sensor-006', value: 33, type: 'temperature', source: 'building-b' }
    ];
    plugin.addData(batchData);
    
    // Wait for batch processing to complete
    console.log('\nWaiting for batch processing...');
    await new Promise(resolve => setTimeout(resolve, 3000));
    
    // Get updated plugin status
    console.log('\nUpdated plugin status after batch processing:');
    console.log(JSON.stringify(plugin.getStatus(), null, 2));
    
    // Process another batch with manual processing
    console.log('\nProcessing another batch manually...');
    const manualBatch = [
      { id: 'sensor-007', value: 88, type: 'humidity', source: 'building-e' },
      { id: 'sensor-008', value: 12, type: 'temperature', source: 'building-f' }
    ];
    const batchResult = await plugin.processData(manualBatch);
    console.log('Batch processing results:', JSON.stringify(batchResult, null, 2));
    
    // Stop the plugin
    console.log('\nStopping plugin...');
    await plugin.stop();
    
    // Final status
    console.log('\nFinal plugin status:');
    console.log(JSON.stringify(plugin.getStatus(), null, 2));

} catch (error) {
console.error('Error in data processor demonstration:', error);
}
}

// Run the demonstration
demonstrateDataProcessor();
```
### 4. Cerebras LLM API Node.js Template

<llm-snippet-file>_safeguard-plugin-system/templates/nodejs/cerebras-llm-api/index.js</llm-snippet-file>
```
javascript
/**
* Cerebras LLM API Safeguard Plugin Template
*
* This template provides a structure for creating a Safeguard plugin
* that interacts with the Cerebras Cloud LLM API for language model inference.
*
* @module SafeguardCerebrasLLMPlugin
* @copyright Copyright 2025 Autonomy Association International Inc., all rights reserved.
  */

const { CerebrasCloudClient } = require('@cerebras/cerebras-cloud-sdk');
const { v4: uuidv4 } = require('uuid');

class SafeguardCerebrasLLMPlugin {
/**
* Constructor for the Cerebras LLM API plugin
* @param {Object} config - Plugin configuration
  */
  constructor(config = {}) {
  this.name = config.name || 'cerebras-llm-plugin';
  this.version = config.version || '1.0.0';
  this.description = config.description || 'Cerebras LLM API Safeguard Plugin';
  this.config = config;
  this.initialized = false;
  this.logger = config.logger || console;

    // Cerebras specific configuration
    this.apiKey = config.apiKey;
    this.baseUrl = config.baseUrl || 'https://api.cerebras.cloud';
    this.defaultModel = config.defaultModel || 'cerebras-1';
    this.timeout = config.timeout || 60000; // 60 seconds default
    this.requestHistory = [];
    this.maxHistorySize = config.maxHistorySize || 100;
    
    this.logger.info(`[${this.name}] Plugin instance created`);
}

/**
* Initialize the plugin
* @param {Object} context - Initialization context
* @returns {Promise<boolean>} - True if initialization successful
  */
  async initialize(context) {
  try {
  this.logger.info(`[${this.name}] Initializing plugin v${this.version}`);
  this.context = context;

  if (!this.apiKey) {
  throw new Error('API key is required for Cerebras Cloud SDK');
  }

  // Initialize Cerebras client
  this.client = new CerebrasCloudClient({
  apiKey: this.apiKey,
  baseUrl: this.baseUrl,
  timeout: this.timeout
  });

  // Validate API key by testing a simple request
  if (this.config.validateApiKey !== false) {
  try {
  await this.testConnection();
  this.logger.info(`[${this.name}] API key validation successful`);
  } catch (error) {
  throw new Error(`API key validation failed: ${error.message}`);
  }
  }

  this.initialized = true;
  return true;
  } catch (error) {
  this.logger.error(`[${this.name}] Initialization failed:`, error);
  return false;
  }
  }

/**
* Test connection to the Cerebras API
* @returns {Promise<Object>} - Response from API health check
  */
  async testConnection() {
  try {
  const models = await this.client.listModels();
  if (!models || models.length === 0) {
  throw new Error('No models available');
  }
  return models;
  } catch (error) {
  this.logger.error(`[${this.name}] Connection test failed:`, error);
  throw error;
  }
  }

/**
* Start the plugin
* @returns {Promise<boolean>} - True if start successful
  */
  async start() {
  if (!this.initialized) {
  this.logger.error(`[${this.name}] Cannot start: plugin not initialized`);
  return false;
  }

    try {
      this.logger.info(`[${this.name}] Starting plugin...`);
      this.running = true;
      return true;
    } catch (error) {
      this.logger.error(`[${this.name}] Start failed:`, error);
      return false;
    }
}

/**
* Stop the plugin
* @returns {Promise<boolean>} - True if stop successful
  */
  async stop() {
  if (!this.running) {
  this.logger.info(`[${this.name}] Plugin already stopped`);
  return true;
  }

    try {
      this.logger.info(`[${this.name}] Stopping plugin...`);
      this.running = false;
      return true;
    } catch (error) {
      this.logger.error(`[${this.name}] Stop failed:`, error);
      return false;
    }
}

/**
* Generate text using the Cerebras LLM API
* @param {Object} params - Generation parameters
* @param {string} params.prompt - The input prompt
* @param {string} [params.model] - Model to use, defaults to this.defaultModel
* @param {number} [params.maxTokens] - Maximum tokens to generate
* @param {number} [params.temperature] - Sampling temperature (0.0-1.0)
* @param {number} [params.topP] - Nucleus sampling parameter (0.0-1.0)
* @param {number} [params.topK] - Top-k sampling parameter
* @param {number} [params.presencePenalty] - Presence penalty (0.0-1.0)
* @param {number} [params.frequencyPenalty] - Frequency penalty (0.0-1.0)
* @param {Array} [params.stopSequences] - Sequences that stop generation
* @returns {Promise<Object>} - Generated text and metadata
  */
  async generateText(params) {
  if (!this.initialized || !this.running) {
  throw new Error(`[${this.name}] Cannot generate text: plugin not running`);
  }

    const requestId = uuidv4();
    const startTime = Date.now();
    
    try {
      const model = params.model || this.defaultModel;
      this.logger.info(`[${this.name}] Generating text with model: ${model} (${requestId})`);
      
      const requestParams = {
        model,
        prompt: params.prompt,
        max_tokens: params.maxTokens || 1024,
        temperature: params.temperature !== undefined ? params.temperature : 0.7,
        top_p: params.topP !== undefined ? params.topP : 0.9,
        top_k: params.topK !== undefined ? params.topK : 40,
        presence_penalty: params.presencePenalty !== undefined ? params.presencePenalty : 0.0,
        frequency_penalty: params.frequencyPenalty !== undefined ? params.frequencyPenalty : 0.0,
        stop_sequences: params.stopSequences || []
      };
      
      // Log request (exclude prompt for privacy)
      this.logger.debug(`[${this.name}] Request (${requestId}):`, {
        ...requestParams,
        prompt: `[${requestParams.prompt.length} chars]`
      });
      
      // Make API call to Cerebras
      const response = await this.client.completions.create(requestParams);
      
      const duration = Date.now() - startTime;
      this.logger.info(`[${this.name}] Text generation completed in ${duration}ms (${requestId})`);
      
      // Process and format response
      const result = {
        id: requestId,
        model: model,
        text: response.completion,
        promptTokens: response.prompt_tokens,
        completionTokens: response.completion_tokens,
        totalTokens: response.total_tokens,
        finishReason: response.finish_reason,
        duration: duration,
        timestamp: new Date().toISOString()
      };
      
      // Add to request history
      this.addToHistory({
        id: requestId,
        type: 'text-generation',
        model: model,
        params: {
          ...requestParams,
          prompt: `[${requestParams.prompt.length} chars]` // Don't store full prompt in history
        },
        status: 'success',
        duration: duration,
        timestamp: new Date().toISOString()
      });
      
      return result;
    } catch (error) {
      const duration = Date.now() - startTime;
      this.logger.error(`[${this.name}] Text generation failed (${requestId}):`, error);
      
      // Add failed request to history
      this.addToHistory({
        id: requestId,
        type: 'text-generation',
        model: params.model || this.defaultModel,
        params: {
          ...params,
          prompt: `[${params.prompt.length} chars]` // Don't store full prompt in history
        },
        status: 'error',
        error: error.message,
        duration: duration,
        timestamp: new Date().toISOString()
      });
      
      throw error;
    }
}

/**
* Embed text using the Cerebras LLM API
* @param {Object} params - Embedding parameters
* @param {string|Array<string>} params.input - Text to embed
* @param {string} [params.model] - Model to use, defaults to "cerebras-embedding-1"
* @returns {Promise<Object>} - Embedding vectors and metadata
  */
  async generateEmbeddings(params) {
  if (!this.initialized || !this.running) {
  throw new Error(`[${this.name}] Cannot generate embeddings: plugin not running`);
  }

    const requestId = uuidv4();
    const startTime = Date.now();
    
    try {
      const model = params.model || 'cerebras-embedding-1';
      const input = Array.isArray(params.input) ? params.input : [params.input];
      
      this.logger.info(`[${this.name}] Generating embeddings for ${input.length} texts with model: ${model} (${requestId})`);
      
      // Make API call to Cerebras
      const response = await this.client.embeddings.create({
        model: model,
        input: input
      });
      
      const duration = Date.now() - startTime;
      this.logger.info(`[${this.name}] Embeddings generation completed in ${duration}ms (${requestId})`);
      
      // Process and format response
      const result = {
        id: requestId,
        model: model,
        embeddings: response.data.map(item => item.embedding),
        dimensions: response.data[0]?.embedding.length || 0,
        duration: duration,
        timestamp: new Date().toISOString()
      };
      
      // Add to request history
      this.addToHistory({
        id: requestId,
        type: 'embeddings',
        model: model,
        params: {
          model: model,
          input: input.map(text => `[${text.length} chars]`) // Don't store full text in history
        },
        status: 'success',
        duration: duration,
        timestamp: new Date().toISOString()
      });
      
      return result;
    } catch (error) {
      const duration = Date.now() - startTime;
      this.logger.error(`[${this.name}] Embeddings generation failed (${requestId}):`, error);
      
      // Add failed request to history
      this.addToHistory({
        id: requestId,
        type: 'embeddings',
        model: params.model || 'cerebras-embedding-1',
        params: {
          model: params.model || 'cerebras-embedding-1',
          input: Array.isArray(params.input) 
            ? params.input.map(text => `[${text.length} chars]`)
            : `[${params.input.length} chars]`
        },
        status: 'error',
        error: error.message,
        duration: duration,
        timestamp: new Date().toISOString()
      });
      
      throw error;
    }
}

/**
* Add a request to the history
* @private
* @param {Object} entry - History entry
  */
  addToHistory(entry) {
  this.requestHistory.unshift(entry);

    // Trim history if it exceeds max size
    if (this.requestHistory.length > this.maxHistorySize) {
      this.requestHistory = this.requestHistory.slice(0, this.maxHistorySize);
    }
}

/**
* Get request history
* @param {number} [limit] - Maximum number of entries to return
* @returns {Array} - Request history
  */
  getRequestHistory(limit) {
  const count = limit && limit > 0 ? Math.min(limit, this.requestHistory.length) : this.requestHistory.length;
  return this.requestHistory.slice(0, count);
  }

/**
* List available models
* @returns {Promise<Array>} - List of available models
  */
  async listModels() {
  if (!this.initialized) {
  throw new Error(`[${this.name}] Cannot list models: plugin not initialized`);
  }

    try {
      const models = await this.client.listModels();
      return models;
    } catch (error) {
      this.logger.error(`[${this.name}] List models failed:`, error);
      throw error;
    }
}

/**
* Get plugin status
* @returns {Object} - Status information
  */
  getStatus() {
  return {
  name: this.name,
  version: this.version,
  description: this.description,
  initialized: this.initialized,
  running: this.running || false,
  defaultModel: this.defaultModel,
  requestsProcessed: this.requestHistory.length,
  lastRequestTimestamp: this.requestHistory[0]?.timestamp || null,
  timestamp: new Date().toISOString()
  };
  }
  }

module.exports = SafeguardCerebrasLLMPlugin;
```
<llm-snippet-file>_safeguard-plugin-system/templates/nodejs/cerebras-llm-api/package.json</llm-snippet-file>
```
json
{
"name": "safeguard-cerebras-llm-plugin",
"version": "1.0.0",
"description": "Cerebras LLM API template for Safeguard plugins",
"main": "index.js",
"scripts": {
"test": "jest",
"lint": "eslint ."
},
"keywords": [
"safeguard",
"plugin",
"template",
"cerebras",
"llm",
"ai",
"language-model",
"nlp"
],
"author": "Autonomy Association International, Inc.",
"license": "PROPRIETARY",
"copyright": "Copyright 2025 Autonomy Association International Inc., all rights reserved.",
"dependencies": {
"@cerebras/cerebras-cloud-sdk": "^1.0.0",
"uuid": "^9.0.1",
"axios": "^1.6.2"
},
"devDependencies": {
"eslint": "^8.52.0",
"jest": "^29.0.0",
"nock": "^13.3.0"
},
"engines": {
"node": ">=16.0.0",
"npm": ">=8.0.0"
}
}
```
<llm-snippet-file>_safeguard-plugin-system/templates/nodejs/cerebras-llm-api/README.md</llm-snippet-file>
```
markdown
# Safeguard Cerebras LLM API Plugin Template

This template provides a structure for creating a Safeguard plugin that interacts with the Cerebras Cloud LLM API for language model inference. It supports text generation (completions) and embeddings generation with various model parameters.

## Features

- Text generation with the Cerebras LLM API
- Embeddings generation for semantic search and NLP tasks
- Request history tracking and management
- Model availability checking
- Comprehensive error handling and logging

## Prerequisites

- Cerebras Cloud API key
- Node.js 16.x or higher
- NPM 8.x or higher

## Usage

1. Clone this template
2. Install dependencies with `npm install`
3. Set your Cerebras API key in the configuration
4. Initialize and use the plugin in your application

## Configuration Options

- `apiKey`: Cerebras Cloud API key (required)
- `baseUrl`: API base URL (default: 'https://api.cerebras.cloud')
- `defaultModel`: Default model to use (default: 'cerebras-1')
- `timeout`: Request timeout in milliseconds (default: 60000)
- `maxHistorySize`: Maximum number of requests to keep in history (default: 100)
- `validateApiKey`: Whether to validate the API key during initialization (default: true)

## API Methods

### Text Generation

```javascript
const result = await plugin.generateText({
  prompt: "Once upon a time in the digital realm,",
  model: "cerebras-1", // optional, uses defaultModel if not specified
  maxTokens: 1024,
  temperature: 0.7,
  topP: 0.9,
  topK: 40,
  presencePenalty: 0.0,
  frequencyPenalty: 0.0,
  stopSequences: ["\n\n"]
});
```


### Embeddings Generation

```javascript
const result = await plugin.generateEmbeddings({
  input: ["The quick brown fox jumps over the lazy dog"],
  model: "cerebras-embedding-1" // optional
});
```


### List Available Models

```javascript
const models = await plugin.listModels();
```


## Example

```javascript
const SafeguardCerebrasLLMPlugin = require('./index');

// Create plugin instance
const plugin = new SafeguardCerebrasLLMPlugin({
  name: 'cerebras-llm',
  apiKey: 'your-cerebras-api-key-here'
});

// Initialize and use the plugin
async function run() {
  await plugin.initialize({});
  await plugin.start();
  
  // Generate text
  const completion = await plugin.generateText({
    prompt: "Explain the benefits of using AI in autonomous systems:",
    maxTokens: 512
  });
  
  console.log('Generated text:', completion.text);
  
  // Generate embeddings
  const embeddings = await plugin.generateEmbeddings({
    input: ["Safety-critical systems", "Autonomous navigation"]
  });
  
  console.log('Embedding dimensions:', embeddings.dimensions);
  console.log('First embedding vector (first 5 values):', embeddings.embeddings[0].slice(0, 5));
  
  await plugin.stop();
}

run().catch(console.error);
```


## License

Copyright 2025 Autonomy Association International Inc., all rights reserved.
```
<llm-snippet-file>_safeguard-plugin-system/templates/nodejs/cerebras-llm-api/example.js</llm-snippet-file>
```
javascript
/**
* Example usage of the Cerebras LLM API Safeguard Plugin
  */

const SafeguardCerebrasLLMPlugin = require('./index');

// Create plugin instance with your API key
// NOTE: Replace 'your-cerebras-api-key' with your actual API key
const plugin = new SafeguardCerebrasLLMPlugin({
name: 'cerebras-assistant',
version: '1.0.0',
description: 'Cerebras LLM Integration Example',
apiKey: 'your-cerebras-api-key',
defaultModel: 'cerebras-1',
logger: console
});

// Demonstrate the plugin capabilities
async function demonstrateCerebrasLLM() {
try {
// Initialize the plugin
console.log('Initializing Cerebras LLM plugin...');
await plugin.initialize({
appContext: {
appVersion: '1.0.0',
environment: 'development'
}
});

    // Start the plugin
    console.log('\nStarting plugin...');
    await plugin.start();
    
    // Get plugin status
    console.log('\nPlugin status:');
    console.log(JSON.stringify(plugin.getStatus(), null, 2));
    
    // List available models
    try {
      console.log('\nListing available models...');
      const models = await plugin.listModels();
      console.log('Available models:', models);
    } catch (modelError) {
      console.error('Error listing models:', modelError.message);
      console.log('Continuing with the default model');
    }
    
    // Generate text completion
    try {
      console.log('\nGenerating text completion...');
      const completionResult = await plugin.generateText({
        prompt: "Explain the three laws of robotics in simple terms:",
        maxTokens: 256,
        temperature: 0.7
      });
      
      console.log('\nCompletion result:');
      console.log('Text:', completionResult.text);
      console.log('Model:', completionResult.model);
      console.log('Tokens used:', completionResult.totalTokens);
      console.log('Duration:', completionResult.duration, 'ms');
    } catch (completionError) {
      console.error('Error generating completion:', completionError.message);
    }
    
    // Generate embeddings
    try {
      console.log('\nGenerating embeddings...');
      const embeddingsResult = await plugin.generateEmbeddings({
        input: [
          "Autonomous vehicles must prioritize safety",
          "Machine learning algorithms improve over time"
        ]
      });
      
      console.log('\nEmbeddings result:');
      console.log('Model:', embeddingsResult.model);
      console.log('Embedding count:', embeddingsResult.embeddings.length);
      console.log('Dimensions:', embeddingsResult.dimensions);
      console.log('First embedding (first 5 values):', embeddingsResult.embeddings[0].slice(0, 5));
      console.log('Duration:', embeddingsResult.duration, 'ms');
    } catch (embeddingsError) {
      console.error('Error generating embeddings:', embeddingsError.message);
    }
    
    // Get request history
    console.log('\nRequest history:');
    const history = plugin.getRequestHistory(5);
    console.log(JSON.stringify(history, null, 2));
    
    // Stop the plugin
    console.log('\nStopping plugin...');
    await plugin.stop();
    
    // Final status
    console.log('\nFinal plugin status:');
    console.log(JSON.stringify(plugin.getStatus(), null, 2));

} catch (error) {
console.error('Error in Cerebras LLM demonstration:', error);
}
}

// Run the demonstration
demonstrateCerebrasLLM();
```
### 5. OpenAI LLM API Node.js Template

<llm-snippet-file>_safeguard-plugin-system/templates/nodejs/openai-llm-api/index.js</llm-snippet-file>
```
javascript
/**
* OpenAI LLM API Safeguard Plugin Template
*
* This template provides a structure for creating a Safeguard plugin
* that interacts with the OpenAI API for language model inference.
*
* @module SafeguardOpenAIPlugin
* @copyright Copyright 2025 Autonomy Association International Inc., all rights reserved.
  */

const OpenAI = require('openai');
const { v4: uuidv4 } = require('uuid');

class SafeguardOpenAIPlugin {
/**
* Constructor for the OpenAI API plugin
* @param {Object} config - Plugin configuration
  */
  constructor(config = {}) {
  this.name = config.name || 'openai-plugin';
  this.version = config.version || '1.0.0';
  this.description = config.description || 'OpenAI API Safeguard Plugin';
  this.config = config;
  this.initialized = false;
  this.logger = config.logger || console;

    // OpenAI specific configuration
    this.apiKey = config.apiKey;
    this.organization = config.organization;
    this.defaultModel = config.defaultModel || 'gpt-4o';
    this.baseURL = config.baseURL;
    this.timeout = config.timeout || 60000; // 60 seconds default
    this.requestHistory = [];
    this.maxHistorySize = config.maxHistorySize || 100;
    
    this.logger.info(`[${this.name}] Plugin instance created`);
}

/**
* Initialize the plugin
* @param {Object} context - Initialization context
* @returns {Promise<boolean>} - True if initialization successful
  */
  async initialize(context) {
  try {
  this.logger.info(`[${this.name}] Initializing plugin v${this.version}`);
  this.context = context;

  if (!this.apiKey) {
  throw new Error('API key is required for OpenAI SDK');
  }

  // Initialize OpenAI client
  const clientOptions = {
  apiKey: this.apiKey,
  timeout: this.timeout
  };

  if (this.organization) {
  clientOptions.organization = this.organization;
  }

  if (this.baseURL) {
  clientOptions.baseURL = this.baseURL;
  }

  this.client = new OpenAI(clientOptions);

  // Validate API key by testing a simple request
  if (this.config.validateApiKey !== false) {
  try {
  await this.testConnection();
  this.logger.info(`[${this.name}] API key validation successful`);
  } catch (error) {
  throw new Error(`API key validation failed: ${error.message}`);
  }
  }

  this.initialized = true;
  return true;
  } catch (error) {
  this.logger.error(`[${this.name}] Initialization failed:`, error);
  return false;
  }
  }

/**
* Test connection to the OpenAI API
* @returns {Promise<Object>} - Response from API health check
  */
  async testConnection() {
  try {
  const models = await this.client.models.list();
  if (!models || models.data.length === 0) {
  throw new Error('No models available');
  }
  return models;
  } catch (error) {
  this.logger.error(`[${this.name}] Connection test failed:`, error);
  throw error;
  }
  }

/**
* Start the plugin
* @returns {Promise<boolean>} - True if start successful
  */
  async start() {
  if (!this.initialized) {
  this.logger.error(`[${this.name}] Cannot start: plugin not initialized`);
  return false;
  }

    try {
      this.logger.info(`[${this.name}] Starting plugin...`);
      this.running = true;
      return true;
    } catch (error) {
      this.logger.error(`[${this.name}] Start failed:`, error);
      return false;
    }
}

/**
* Stop the plugin
* @returns {Promise<boolean>} - True if stop successful
  */
  async stop() {
  if (!this.running) {
  this.logger.info(`[${this.name}] Plugin already stopped`);
  return true;
  }

    try {
      this.logger.info(`[${this.name}] Stopping plugin...`);
      this.running = false;
      return true;
    } catch (error) {
      this.logger.error(`[${this.name}] Stop failed:`, error);
      return false;
    }
}

/**
* Create a chat completion
* @param {Object} params - Chat completion parameters
* @param {Array<Object>} params.messages - Chat messages array
* @param {string} [params.model] - Model to use, defaults to this.defaultModel
* @param {number} [params.temperature] - Sampling temperature (0.0-2.0)
* @param {number} [params.maxTokens] - Maximum tokens to generate
* @param {number} [params.topP] - Nucleus sampling parameter (0.0-1.0)
* @param {number} [params.frequencyPenalty] - Frequency penalty (-2.0-2.0)
* @param {number} [params.presencePenalty] - Presence penalty (-2.0-2.0)
* @param {Array<string>} [params.stop] - Sequences that stop generation
* @param {boolean} [params.stream] - Whether to stream the response
* @param {Array<Object>} [params.tools] - Tools available to the model
* @returns {Promise<Object>} - Chat completion result
  */
  async createChatCompletion(params) {
  if (!this.initialized || !this.running) {
  throw new Error(`[${this.name}] Cannot create chat completion: plugin not running`);
  }

    const requestId = uuidv4();
    const startTime = Date.now();
    
    try {
      const model = params.model || this.defaultModel;
      this.logger.info(`[${this.name}] Creating chat completion with model: ${model} (${requestId})`);
      
      // Prepare request parameters
      const requestParams = {
        model,
        messages: params.messages,
        temperature: params.temperature !== undefined ? params.temperature : 0.7,
        max_tokens: params.maxTokens,
        top_p: params.topP,
        frequency_penalty: params.frequencyPenalty,
        presence_penalty: params.presencePenalty,
        stop: params.stop,
        stream: params.stream,
        tools: params.tools
      };
      
      // Clean undefined values
      Object.keys(requestParams).forEach(key => {
        if (requestParams[key] === undefined) {
          delete requestParams[key];
        }
      });
      
      // Log request (exclude messages for privacy)
      this.logger.debug(`[${this.name}] Request (${requestId}):`, {
        ...requestParams,
        messages: `[${requestParams.messages.length} messages]`
      });
      
      // Handle streaming response
      if (params.stream) {
        const stream = await this.client.chat.completions.create(requestParams);
        
        // Return the stream directly
        this.addToHistory({
          id: requestId,
          type: 'chat-completion-stream',
          model: model,
          params: {
            ...requestParams,
            messages: `[${requestParams.messages.length} messages]`
          },
          status: 'success',
          timestamp: new Date().toISOString()
        });
        
        return stream;
      }
      
      // Make API call to OpenAI
      const response = await this.client.chat.completions.create(requestParams);
      
      const duration = Date.now() - startTime;
      this.logger.info(`[${this.name}] Chat completion completed in ${duration}ms (${requestId})`);
      
      // Process and format response
      const result = {
        id: response.id,
        object: response.object,
        created: response.created,
        model: response.model,
        choices: response.choices,
        usage: response.usage,
        systemFingerprint: response.system_fingerprint,
        duration: duration,
        timestamp: new Date().toISOString()
      };
      
      // Add to request history
      this.addToHistory({
        id: requestId,
        type: 'chat-completion',
        model: model,
        params: {
          ...requestParams,
          messages: `[${requestParams.messages.length} messages]`
        },
        status: 'success',
        usage: response.usage,
        duration: duration,
        timestamp: new Date().toISOString()
      });
      
      return result;
    } catch (error) {
      const duration = Date.now() - startTime;
      this.logger.error(`[${this.name}] Chat completion failed (${requestId}):`, error);
      
      // Add failed request to history
      this.addToHistory({
        id: requestId,
        type: 'chat-completion',
        model: params.model || this.defaultModel,
        params: {
          model: params.model || this.defaultModel,
          messages: params.messages ? `[${params.messages.length} messages]` : '[]'
        },
        status: 'error',
        error: error.message,
        duration: duration,
        timestamp: new Date().toISOString()
      });
      
      throw error;
    }
}

/**
* Generate embeddings
* @param {Object} params - Embedding parameters
* @param {string|Array<string>} params.input - Text to embed
* @param {string} [params.model] - Model to use, defaults to "text-embedding-3-small"
* @returns {Promise<Object>} - Embedding vectors and metadata
  */
  async createEmbeddings(params) {
  if (!this.initialized || !this.running) {
  throw new Error(`[${this.name}] Cannot create embeddings: plugin not running`);
  }

    const requestId = uuidv4();
    const startTime = Date.now();
    
    try {
      const model = params.model || 'text-embedding-3-small';
      const input = Array.isArray(params.input) ? params.input : [params.input];
      
      this.logger.info(`[${this.name}] Creating embeddings for ${input.length} texts with model: ${model} (${requestId})`);
      
      // Make API call to OpenAI
      const response = await this.client.embeddings.create({
        model: model,
        input: input
      });
      
      const duration = Date.now() - startTime;
      this.logger.info(`[${this.name}] Embeddings creation completed in ${duration}ms (${requestId})`);
      
      // Process and format response
      const result = {
        id: response.id,
        object: response.object,
        model: response.model,
        data: response.data,
        usage: response.usage,
        dimensions: response.data[0]?.embedding.length || 0,
        duration: duration,
        timestamp: new Date().toISOString()
      };
      
      // Add to request history
      this.addToHistory({
        id: requestId,
        type: 'embeddings',
        model: model,
        params: {
          model: model,
          input: input.map(text => `[${text.length} chars]`)
        },
        status: 'success',
        usage: response.usage,
        duration: duration,
        timestamp: new Date().toISOString()
      });
      
      return result;
    } catch (error) {
      const duration = Date.now() - startTime;
      this.logger.error(`[${this.name}] Embeddings creation failed (${requestId}):`, error);
      
      // Add failed request to history
      this.addToHistory({
        id: requestId,
        type: 'embeddings',
        model: params.model || 'text-embedding-3-small',
        params: {
          model: params.model || 'text-embedding-3-small',
          input: Array.isArray(params.input) 
            ? params.input.map(text => `[${text.length} chars]`)
            : `[${params.input.length} chars]`
        },
        status: 'error',
        error: error.message,
        duration: duration,
        timestamp: new Date().toISOString()
      });
      
      throw error;
    }
}

/**
* Create an image using DALL-E
* @param {Object} params - Image generation parameters
* @param {string} params.prompt - The image description
* @param {string} [params.model] - Model to use, defaults to "dall-e-3"
* @param {number} [params.n] - Number of images to generate (1-10)
* @param {string} [params.size] - Image size (e.g., "1024x1024")
* @param {string} [params.quality] - Image quality ("standard" or "hd")
* @param {string} [params.style] - Image style ("vivid" or "natural")
* @returns {Promise<Object>} - Generated images and metadata
  */
  async createImage(params) {
  if (!this.initialized || !this.running) {
  throw new Error(`[${this.name}] Cannot create image: plugin not running`);
  }

    const requestId = uuidv4();
    const startTime = Date.now();
    
    try {
      const model = params.model || 'dall-e-3';
      this.logger.info(`[${this.name}] Creating image with model: ${model} (${requestId})`);
      
      // Prepare request parameters
      const requestParams = {
        model,
        prompt: params.prompt,
        n: params.n || 1,
        size: params.size || '1024x1024',
        quality: params.quality || 'standard',
        style: params.style || 'vivid'
      };
      
      // Log request (include prompt since it's needed for context)
      this.logger.debug(`[${this.name}] Request (${requestId}):`, requestParams);
      
      // Make API call to OpenAI
      const response = await this.client.images.generate(requestParams);
      
      const duration = Date.now() - startTime;
      this.logger.info(`[${this.name}] Image creation completed in ${duration}ms (${requestId})`);
      
      // Process and format response
      const result = {
        created: response.created,
        data: response.data,
        duration: duration,
        timestamp: new Date().toISOString()
      };
      
      // Add to request history
      this.addToHistory({
        id: requestId,
        type: 'image-generation',
        model: model,
        params: requestParams,
        status: 'success',
        duration: duration,
        timestamp: new Date().toISOString()
      });
      
      return result;
    } catch (error) {
      const duration = Date.now() - startTime;
      this.logger.error(`[${this.name}] Image creation failed (${requestId}):`, error);
      
      // Add failed request to history
      this.addToHistory({
        id: requestId,
        type: 'image-generation',
        model: params.model || 'dall-e-3',
        params: {
          model: params.model || 'dall-e-3',
          prompt: params.prompt
        },
        status: 'error',
        error: error.message,
        duration: duration,
        timestamp: new Date().toISOString()
      });
      
      throw error;
    }
}

/**
* Transcribe audio to text
* @param {Object} params - Transcription parameters
* @param {string|Buffer|ReadStream} params.file - Audio file to transcribe
* @param {string} [params.model] - Model to use, defaults to "whisper-1"
* @param {string} [params.language] - Language code (e.g., "en")
* @param {string} [params.prompt] - Optional prompt to guide transcription
* @param {string} [params.response_format] - Response format (e.g., "json", "text")
* @returns {Promise<Object>} - Transcription result
  */
  async createTranscription(params) {
  if (!this.initialized || !this.running) {
  throw new Error(`[${this.name}] Cannot create transcription: plugin not running`);
  }

    const requestId = uuidv4();
    const startTime = Date.now();
    
    try {
      const model = params.model || 'whisper-1';
      this.logger.info(`[${this.name}] Creating transcription with model: ${model} (${requestId})`);
      
      // Prepare request parameters
      const requestParams = {
        file: params.file,
        model,
        language: params.language,
        prompt: params.prompt,
        response_format: params.response_format || 'json'
      };
      
      // Clean undefined values
      Object.keys(requestParams).forEach(key => {
        if (requestParams[key] === undefined) {
          delete requestParams[key];
        }
      });
      
      // Log request (exclude file for brevity)
      this.logger.debug(`[${this.name}] Request (${requestId}):`, {
        ...requestParams,
        file: '[audio file]'
      });
      
      // Make API call to OpenAI
      const response = await this.client.audio.transcriptions.create(requestParams);
      
      const duration = Date.now() - startTime;
      this.logger.info(`[${this.name}] Transcription completed in ${duration}ms (${requestId})`);
      
      // Process and format response
      const result = {
        text: response.text,
        duration: duration,
        timestamp: new Date().toISOString()
      };
      
      // Add to request history
      this.addToHistory({
        id: requestId,
        type: 'transcription',
        model: model,
        params: {
          model: model,
          language: params.language,
          response_format: params.response_format || 'json'
        },
        status: 'success',
        duration: duration,
        timestamp: new Date().toISOString()
      });
      
      return result;
    } catch (error) {
      const duration = Date.now() - startTime;
      this.logger.error(`[${this.name}] Transcription failed (${requestId}):`, error);
      
      // Add failed request to history
      this.addToHistory({
        id: requestId,
        type: 'transcription',
        model: params.model || 'whisper-1',
        params: {
          model: params.model || 'whisper-1',
          language: params.language
        },
        status: 'error',
        error: error.message,
        duration: duration,
        timestamp: new Date().toISOString()
      });
      
      throw error;
    }
}

/**
* Add a request to the history
* @private
* @param {Object} entry - History entry
  */
  addToHistory(entry) {
  this.requestHistory.unshift(entry);

    // Trim history if it exceeds max size
    if (this.requestHistory.length > this.maxHistorySize) {
      this.requestHistory = this.requestHistory.slice(0, this.maxHistorySize);
    }
}

/**
* Get request history
* @param {number} [limit] - Maximum number of entries to return
* @returns {Array} - Request history
  */
  getRequestHistory(limit) {
  const count = limit && limit > 0 ? Math.min(limit, this.requestHistory.length) : this.requestHistory.length;
  return this.requestHistory.slice(0, count);
  }

/**
* List available models
* @returns {Promise<Array>} - List of available models
  */
  async listModels() {
  if (!this.initialized) {
  throw new Error(`[${this.name}] Cannot list models: plugin not initialized`);
  }

    try {
      const response = await this.client.models.list();
      return response.data;
    } catch (error) {
      this.logger.error(`[${this.name}] List models failed:`, error);
      throw error;
    }
}

/**
* Get information about a specific model
* @param {string} modelId - Model ID
* @returns {Promise<Object>} - Model information
  */
  async retrieveModel(modelId) {
  if (!this.initialized) {
  throw new Error(`[${this.name}] Cannot retrieve model: plugin not initialized`);
  }

    try {
      const model = await this.client.models.retrieve(modelId);
      return model;
    } catch (error) {
      this.logger.error(`[${this.name}] Retrieve model failed:`, error);
      throw error;
    }
}

/**
* Get plugin status
* @returns {Object} - Status information
  */
  getStatus() {
  return {
  name: this.name,
  version: this.version,
  description: this.description,
  initialized: this.initialized,
  running: this.running || false,
  defaultModel: this.defaultModel,
  requestsProcessed: this.requestHistory.length,
  lastRequestTimestamp: this.requestHistory[0]?.timestamp || null,
  timestamp: new Date().toISOString()
  };
  }
  }

module.exports = SafeguardOpenAIPlugin;
```
<llm-snippet-file>_safeguard-plugin-system/templates/nodejs/openai-llm-api/package.json</llm-snippet-file>
```
json
{
"name": "safeguard-openai-plugin",
"version": "1.0.0",
"description": "OpenAI API template for Safeguard plugins",
"main": "index.js",
"scripts": {
"test": "jest",
"lint": "eslint ."
},
"keywords": [
"safeguard",
"plugin",
"template",
"openai",
"gpt",
"llm",
"ai",
"language-model",
"nlp",
"dall-e",
"whisper"
],
"author": "Autonomy Association International, Inc.",
"license": "PROPRIETARY",
"copyright": "Copyright 2025 Autonomy Association International Inc., all rights reserved.",
"dependencies": {
"openai": "^4.17.4",
"uuid": "^9.0.1"
},
"devDependencies": {
"eslint": "^8.52.0",
"jest": "^29.0.0",
"nock": "^13.3.0"
},
"engines": {
"node": ">=16.0.0",
"npm": ">=8.0.0"
}
}
```
<llm-snippet-file>_safeguard-plugin-system/templates/nodejs/openai-llm-api/README.md</llm-snippet-file>
```
markdown
# Safeguard OpenAI API Plugin Template

This template provides a structure for creating a Safeguard plugin that interacts with the OpenAI API for language model inference, embeddings generation, image creation, and audio transcription.

## Features

- Chat completions with GPT models
- Embeddings generation for semantic search and NLP tasks
- Image generation with DALL-E models
- Audio transcription with Whisper
- Request history tracking and management
- Model listing and information retrieval
- Comprehensive error handling and logging

## Prerequisites

- OpenAI API key
- Node.js 16.x or higher
- NPM 8.x or higher

## Usage

1. Clone this template
2. Install dependencies with `npm install`
3. Set your OpenAI API key in the configuration
4. Initialize and use the plugin in your application

## Configuration Options

- `apiKey`: OpenAI API key (required)
- `organization`: OpenAI organization ID (optional)
- `defaultModel`: Default model to use for chat completions (default: 'gpt-4o')
- `baseURL`: API base URL (optional, for custom endpoints)
- `timeout`: Request timeout in milliseconds (default: 60000)
- `maxHistorySize`: Maximum number of requests to keep in history (default: 100)
- `validateApiKey`: Whether to validate the API key during initialization (default: true)

## API Methods

### Chat Completions

```javascript
const completion = await plugin.createChatCompletion({
  messages: [
    { role: 'system', content: 'You are a helpful assistant.' },
    { role: 'user', content: 'Tell me about autonomous systems.' }
  ],
  model: 'gpt-4o', // optional, uses defaultModel if not specified
  temperature: 0.7,
  maxTokens: 1000,
  tools: [{
    type: 'function',
    function: {
      name: 'get_weather',
      description: 'Get the current weather in a location',
      parameters: {
        type: 'object',
        properties: {
          location: {
            type: 'string',
            description: 'The city and state, e.g. San Francisco, CA'
          }
        },
        required: ['location']
      }
    }
  }]
});
```


### Embeddings Generation

```javascript
const embeddings = await plugin.createEmbeddings({
  input: ['Autonomous systems require robust safety measures'],
  model: 'text-embedding-3-small' // optional
});
```


### Image Generation

```javascript
const images = await plugin.createImage({
  prompt: 'A futuristic autonomous vehicle navigating a city at night',
  model: 'dall-e-3', // optional
  size: '1024x1024',
  quality: 'hd',
  style: 'vivid'
});
```


### Audio Transcription

```javascript
const transcription = await plugin.createTranscription({
  file: fs.createReadStream('audio.mp3'),
  model: 'whisper-1', // optional
  language: 'en',
  response_format: 'json'
});
```


### Model Management

```javascript
// List available models
const models = await plugin.listModels();

// Get information about a specific model
const modelInfo = await plugin.retrieveModel('gpt-4o');
```


## Example

```javascript
const SafeguardOpenAIPlugin = require('./index');
const fs = require('fs');

// Create plugin instance
const plugin = new SafeguardOpenAIPlugin({
  name: 'openai-assistant',
  apiKey: 'your-openai-api-key'
});

// Initialize and use the plugin
async function run() {
  await plugin.initialize({});
  await plugin.start();
  
  // Generate chat completion
  const completion = await plugin.createChatCompletion({
    messages: [
      { role: 'system', content: 'You are a helpful assistant specialized in robotics.' },
      { role: 'user', content: 'What are the key safety considerations for autonomous robots?' }
    ]
  });
  
  console.log('Completion:', completion.choices[0].message.content);
  
  // Generate embeddings for semantic search
  const embeddings = await plugin.createEmbeddings({
    input: [
      'Autonomous navigation systems',
      'Computer vision for robotics',
      'Safety protocols for autonomous vehicles'
    ]
  });
  
  console.log('Embedding dimensions:', embeddings.dimensions);
  
  await plugin.stop();
}

run().catch(console.error);
```


## License

Copyright 2025 Autonomy Association International Inc., all rights reserved.
```
<llm-snippet-file>_safeguard-plugin-system/templates/nodejs/openai-llm-api/example.js</llm-snippet-file>
```
javascript
/**
* Example usage of the OpenAI API Safeguard Plugin
  */

const SafeguardOpenAIPlugin = require('./index');
const fs = require('fs');
const path = require('path');

// Create plugin instance with your API key
// NOTE: Replace 'your-openai-api-key' with your actual API key
const plugin = new SafeguardOpenAIPlugin({
name: 'openai-assistant',
version: '1.0.0',
description: 'OpenAI Integration Example',
apiKey: 'your-openai-api-key',
defaultModel: 'gpt-4o',
logger: console
});

// Demonstrate the plugin capabilities
async function demonstrateOpenAI() {
try {
// Initialize the plugin
console.log('Initializing OpenAI plugin...');
await plugin.initialize({
appContext: {
appVersion: '1.0.0',
environment: 'development'
}
});

    // Start the plugin
    console.log('\nStarting plugin...');
    await plugin.start();
    
    // Get plugin status
    console.log('\nPlugin status:');
    console.log(JSON.stringify(plugin.getStatus(), null, 2));
    
    // List available models
    try {
      console.log('\nListing available models...');
      const models = await plugin.listModels();
      console.log(`Available models: ${models.length}`);
      // Show first 5 models
      console.log(models.slice(0, 5).map(m => m.id).join(', '));
    } catch (modelError) {
      console.error('Error listing models:', modelError.message);
      console.log('Continuing with the default model');
    }
    
    // Create chat completion
    try {
      console.log('\nCreating chat completion...');
      const completionResult = await plugin.createChatCompletion({
        messages: [
          { role: 'system', content: 'You are a helpful assistant specializing in robotics and autonomous systems.' },
          { role: 'user', content: 'What are the three most important safety considerations for autonomous robots in urban environments? Please be concise.' }
        ],
        temperature: 0.7,
        maxTokens: 300
      });
      
      console.log('\nChat completion result:');
      console.log('Model:', completionResult.model);
      console.log('Response:', completionResult.choices[0].message.content);
      console.log('Usage:', completionResult.usage);
      console.log('Duration:', completionResult.duration, 'ms');
    } catch (completionError) {
      console.error('Error creating chat completion:', completionError.message);
    }
    
    // Create chat completion with tools
    try {
      console.log('\nCreating chat completion with tools...');
      const toolsResult = await plugin.createChatCompletion({
        messages: [
          { role: 'system', content: 'You are a helpful assistant with access to tools.' },
          { role: 'user', content: 'What\'s the weather like in New York today?' }
        ],
        tools: [
          {
            type: 'function',
            function: {
              name: 'get_weather',
              description: 'Get the current weather in a location',
              parameters: {
                type: 'object',
                properties: {
                  location: {
                    type: 'string',
                    description: 'The city and state, e.g. San Francisco, CA'
                  }
                },
                required: ['location']
              }
            }
          }
        ]
      });
      
      console.log('\nTools completion result:');
      console.log('Model:', toolsResult.model);
      console.log('Response type:', toolsResult.choices[0].message.content === null ? 'Tool call' : 'Content');
      
      if (toolsResult.choices[0].message.tool_calls) {
        const toolCall = toolsResult.choices[0].message.tool_calls[0];
        console.log('Tool call:', toolCall.function.name);
        console.log('Arguments:', toolCall.function.arguments);
      } else {
        console.log('Content:', toolsResult.choices[0].message.content);
      }
    } catch (toolsError) {
      console.error('Error creating chat completion with tools:', toolsError.message);
    }
    
    // Generate embeddings
    try {
      console.log('\nGenerating embeddings...');
      const embeddingsResult = await plugin.createEmbeddings({
        input: [
          "Autonomous robots must prioritize human safety",
          "Vision systems are critical for environmental awareness"
        ]
      });
      
      console.log('\nEmbeddings result:');
      console.log('Model:', embeddingsResult.model);
      console.log('Embedding count:', embeddingsResult.data.length);
      console.log('Dimensions:', embeddingsResult.dimensions);
      console.log('First embedding (first 5 values):', embeddingsResult.data[0].embedding.slice(0, 5));
      console.log('Usage:', embeddingsResult.usage);
      console.log('Duration:', embeddingsResult.duration, 'ms');
    } catch (embeddingsError) {
      console.error('Error generating embeddings:', embeddingsError.message);
    }
    
    // Generate image (commented out to avoid charges)
    /*
    try {
      console.log('\nGenerating image...');
      const imageResult = await plugin.createImage({
        prompt: "A futuristic autonomous robot safely interacting with humans in an urban park, digital art style",
        size: "1024x1024",
        quality: "standard",
        style: "vivid"
      });
      
      console.log('\nImage generation result:');
      console.log('Image URL:', imageResult.data[0].url);
      console.log('Duration:', imageResult.duration, 'ms');
    } catch (imageError) {
      console.error('Error generating image:', imageError.message);
    }
    */
    
    // Audio transcription (commented out as it requires an audio file)
    /*
    try {
      console.log('\nTranscribing audio...');
      const audioPath = path.join(__dirname, 'sample-audio.mp3');
      
      if (fs.existsSync(audioPath)) {
        const transcriptionResult = await plugin.createTranscription({
          file: fs.createReadStream(audioPath),
          language: 'en'
        });
        
        console.log('\nTranscription result:');
        console.log('Text:', transcriptionResult.text);
        console.log('Duration:', transcriptionResult.duration, 'ms');
      } else {
        console.log('Skipping transcription: audio file not found');
      }
    } catch (transcriptionError) {
      console.error('Error transcribing audio:', transcriptionError.message);
    }
    */
    
    // Get request history
    console.log('\nRequest history:');
    const history = plugin.getRequestHistory(5);
    console.log(JSON.stringify(history, null, 2));
    
    // Stop the plugin
    console.log('\nStopping plugin...');
    await plugin.stop();
    
    // Final status
    console.log('\nFinal plugin status:');
    console.log(JSON.stringify(plugin.getStatus(), null, 2));

} catch (error) {
console.error('Error in OpenAI demonstration:', error);
}
}

// Run the demonstration
demonstrateOpenAI();
```
### 6. Anthropic LLM API Node.js Template

<llm-snippet-file>_safeguard-plugin-system/templates/nodejs/anthropic-llm-api/index.js</llm-snippet-file>
```
javascript
/**
* Anthropic LLM API Safeguard Plugin Template
*
* This template provides a structure for creating a Safeguard plugin
* that interacts with the Anthropic API for Claude language model inference.
*
* @module SafeguardAnthropicPlugin
* @copyright Copyright 2025 Autonomy Association International Inc., all rights reserved.
  */

const Anthropic = require('@anthropic-ai/sdk');
const { v4: uuidv4 } = require('uuid');

class SafeguardAnthropicPlugin {
/**
* Constructor for the Anthropic API plugin
* @param {Object} config - Plugin configuration
  */
  constructor(config = {}) {
  this.name = config.name || 'anthropic-plugin';
  this.version = config.version || '1.0.0';
  this.description = config.description || 'Anthropic API Safeguard Plugin';
  this.config = config;
  this.initialized = false;
  this.logger = config.logger || console;

    // Anthropic specific configuration
    this.apiKey = config.apiKey;
    this.defaultModel = config.defaultModel || 'claude-3-opus-20240229';
    this.baseURL = config.baseURL;
    this.timeout = config.timeout || 60000; // 60 seconds default
    this.requestHistory = [];
    this.maxHistorySize = config.maxHistorySize || 100;
    
    this.logger.info(`[${this.name}] Plugin instance created`);
}

/**
* Initialize the plugin
* @param {Object} context - Initialization context
* @returns {Promise<boolean>} - True if initialization successful
  */
  async initialize(context) {
  try {
  this.logger.info(`[${this.name}] Initializing plugin v${this.version}`);
  this.context = context;

  if (!this.apiKey) {
  throw new Error('API key is required for Anthropic SDK');
  }

  // Initialize Anthropic client
  const clientOptions = {
  apiKey: this.apiKey,
  timeout: this.timeout
  };

  if (this.baseURL) {
  clientOptions.baseURL = this.baseURL;
  }

  this.client = new Anthropic(clientOptions);

  // Validate API key by testing a simple request
  if (this.config.validateApiKey !== false) {
  try {
  await this.testConnection();
  this.logger.info(`[${this.name}] API key validation successful`);
  } catch (error) {
  throw new Error(`API key validation failed: ${error.message}`);
  }
  }

  this.initialized = true;
  return true;
  } catch (error) {
  this.logger.error(`[${this.name}] Initialization failed:`, error);
  return false;
  }
  }

/**
* Test connection to the Anthropic API
* @returns {Promise<Object>} - Response from API test
  */
  async testConnection() {
  try {
  // Test with a minimal message to validate API key
  const response = await this.client.messages.create({
  model: this.defaultModel,
  max_tokens: 10,
  messages: [
  { role: 'user', content: 'Hello' }
  ]
  });

  if (!response || !response.id) {
  throw new Error('Invalid response from Anthropic API');
  }

  return response;
  } catch (error) {
  this.logger.error(`[${this.name}] Connection test failed:`, error);
  throw error;
  }
  }

/**
* Start the plugin
* @returns {Promise<boolean>} - True if start successful
  */
  async start() {
  if (!this.initialized) {
  this.logger.error(`[${this.name}] Cannot start: plugin not initialized`);
  return false;
  }

    try {
      this.logger.info(`[${this.name}] Starting plugin...`);
      this.running = true;
      return true;
    } catch (error) {
      this.logger.error(`[${this.name}] Start failed:`, error);
      return false;
    }
}

/**
* Stop the plugin
* @returns {Promise<boolean>} - True if stop successful
  */
  async stop() {
  if (!this.running) {
  this.logger.info(`[${this.name}] Plugin already stopped`);
  return true;
  }

    try {
      this.logger.info(`[${this.name}] Stopping plugin...`);
      this.running = false;
      return true;
    } catch (error) {
      this.logger.error(`[${this.name}] Stop failed:`, error);
      return false;
    }
}

/**
* Create a message using Claude
* @param {Object} params - Message parameters
* @param {Array<Object>} params.messages - Message array
* @param {string} [params.model] - Model to use, defaults to this.defaultModel
* @param {number} [params.maxTokens] - Maximum tokens to generate
* @param {number} [params.temperature] - Sampling temperature (0.0-1.0)
* @param {number} [params.topP] - Nucleus sampling parameter (0.0-1.0)
* @param {number} [params.topK] - Top-k sampling parameter
* @param {boolean} [params.stream] - Whether to stream the response
* @param {Array<Object>} [params.tools] - Tools available to the model
* @param {Object} [params.system] - System prompt
* @returns {Promise<Object>} - Message completion result
  */
  async createMessage(params) {
  if (!this.initialized || !this.running) {
  throw new Error(`[${this.name}] Cannot create message: plugin not running`);
  }

    const requestId = uuidv4();
    const startTime = Date.now();
    
    try {
      const model = params.model || this.defaultModel;
      this.logger.info(`[${this.name}] Creating message with model: ${model} (${requestId})`);
      
      // Prepare request parameters
      const requestParams = {
        model,
        messages: params.messages,
        max_tokens: params.maxTokens || 1024,
        temperature: params.temperature !== undefined ? params.temperature : 0.7,
        top_p: params.topP !== undefined ? params.topP : 0.9,
        top_k: params.topK !== undefined ? params.topK : 40,
        stream: params.stream || false,
        tools: params.tools,
        system: params.system
      };
      
      // Clean undefined values
      Object.keys(requestParams).forEach(key => {
        if (requestParams[key] === undefined) {
          delete requestParams[key];
        }
      });
      
      // Log request (exclude messages for privacy)
      this.logger.debug(`[${this.name}] Request (${requestId}):`, {
        ...requestParams,
        messages: `[${requestParams.messages.length} messages]`,
        system: requestParams.system ? '[system prompt]' : undefined
      });
      
      // Handle streaming response
      if (params.stream) {
        const stream = await this.client.messages.create({
          ...requestParams,
          stream: true
        });
        
        // Return the stream directly
        this.addToHistory({
          id: requestId,
          type: 'message-stream',
          model: model,
          params: {
            ...requestParams,
            messages: `[${requestParams.messages.length} messages]`,
            system: requestParams.system ? '[system prompt]' : undefined
          },
          status: 'success',
          timestamp: new Date().toISOString()
        });
        
        return stream;
      }
      
      // Make API call to Anthropic
      const response = await this.client.messages.create(requestParams);
      
      const duration = Date.now() - startTime;
      this.logger.info(`[${this.name}] Message creation completed in ${duration}ms (${requestId})`);
      
      // Process and format response
      const result = {
        id: response.id,
        model: response.model,
        type: response.type,
        role: response.role,
        content: response.content,
        stopReason: response.stop_reason,
        stopSequence: response.stop_sequence,
        usage: response.usage,
        duration: duration,
        timestamp: new Date().toISOString()
      };
      
      // Add to request history
      this.addToHistory({
        id: requestId,
        type: 'message',
        model: model,
        params: {
          ...requestParams,
          messages: `[${requestParams.messages.length} messages]`,
          system: requestParams.system ? '[system prompt]' : undefined
        },
        status: 'success',
        usage: response.usage,
        duration: duration,
        timestamp: new Date().toISOString()
      });
      
      return result;
    } catch (error) {
      const duration = Date.now() - startTime;
      this.logger.error(`[${this.name}] Message creation failed (${requestId}):`, error);
      
      // Add failed request to history
      this.addToHistory({
        id: requestId,
        type: 'message',
        model: params.model || this.defaultModel,
        params: {
          model: params.model || this.defaultModel,
          messages: params.messages ? `[${params.messages.length} messages]` : '[]',
          system: params.system ? '[system prompt]' : undefined
        },
        status: 'error',
        error: error.message,
        duration: duration,
        timestamp: new Date().toISOString()
      });
      
      throw error;
    }
}

/**
* Complete a prompt using Claude (legacy API)
* @param {Object} params - Completion parameters
* @param {string} params.prompt - The input prompt
* @param {string} [params.model] - Model to use, defaults to this.defaultModel
* @param {number} [params.maxTokensToSample] - Maximum tokens to generate
* @param {number} [params.temperature] - Sampling temperature (0.0-1.0)
* @param {number} [params.topP] - Nucleus sampling parameter (0.0-1.0)
* @param {number} [params.topK] - Top-k sampling parameter
* @param {Array<string>} [params.stopSequences] - Sequences that stop generation
* @param {boolean} [params.stream] - Whether to stream the response
* @returns {Promise<Object>} - Completion result
  */
  async createCompletion(params) {
  if (!this.initialized || !this.running) {
  throw new Error(`[${this.name}] Cannot create completion: plugin not running`);
  }

    const requestId = uuidv4();
    const startTime = Date.now();
    
    try {
      const model = params.model || this.defaultModel;
      this.logger.info(`[${this.name}] Creating completion with model: ${model} (${requestId})`);
      
      // Prepare request parameters
      const requestParams = {
        model,
        prompt: params.prompt,
        max_tokens_to_sample: params.maxTokensToSample || 1024,
        temperature: params.temperature !== undefined ? params.temperature : 0.7,
        top_p: params.topP !== undefined ? params.topP : 0.9,
        top_k: params.topK !== undefined ? params.topK : 40,
        stop_sequences: params.stopSequences || [],
        stream: params.stream || false
      };
      
      // Log request (exclude prompt for privacy)
      this.logger.debug(`[${this.name}] Request (${requestId}):`, {
        ...requestParams,
        prompt: `[${requestParams.prompt.length} chars]`
      });
      
      // Handle streaming response
      if (params.stream) {
        const stream = await this.client.completions.create({
          ...requestParams,
          stream: true
        });
        
        // Return the stream directly
        this.addToHistory({
          id: requestId,
          type: 'completion-stream',
          model: model,
          params: {
            ...requestParams,
            prompt: `[${requestParams.prompt.length} chars]`
          },
          status: 'success',
          timestamp: new Date().toISOString()
        });
        
        return stream;
      }
      
      // Make API call to Anthropic
      const response = await this.client.completions.create(requestParams);
      
      const duration = Date.now() - startTime;
      this.logger.info(`[${this.name}] Completion created in ${duration}ms (${requestId})`);
      
      // Process and format response
      const result = {
        id: response.id,
        model: response.model,
        completion: response.completion,
        stopReason: response.stop_reason,
        stopSequence: response.stop_sequence,
        duration: duration,
        timestamp: new Date().toISOString()
      };
      
      // Add to request history
      this.addToHistory({
        id: requestId,
        type: 'completion',
        model: model,
        params: {
          ...requestParams,
          prompt: `[${requestParams.prompt.length} chars]`
        },
        status: 'success',
        duration: duration,
        timestamp: new Date().toISOString()
      });
      
      return result;
    } catch (error) {
      const duration = Date.now() - startTime;
      this.logger.error(`[${this.name}] Completion failed (${requestId}):`, error);
      
      // Add failed request to history
      this.addToHistory({
        id: requestId,
        type: 'completion',
        model: params.model || this.defaultModel,
        params: {
          model: params.model || this.defaultModel,
          prompt: params.prompt ? `[${params.prompt.length} chars]` : '[]'
        },
        status: 'error',
        error: error.message,
        duration: duration,
        timestamp: new Date().toISOString()
      });
      
      throw error;
    }
}

/**
* Add a request to the history
* @private
* @param {Object} entry - History entry
  */
  addToHistory(entry) {
  this.requestHistory.unshift(entry);

    // Trim history if it exceeds max size
    if (this.requestHistory.length > this.maxHistorySize) {
      this.requestHistory = this.requestHistory.slice(0, this.maxHistorySize);
    }
}

/**
* Get request history
* @param {number} [limit] - Maximum number of entries to return
* @returns {Array} - Request history
  */
  getRequestHistory(limit) {
  const count = limit && limit > 0 ? Math.min(limit, this.requestHistory.length) : this.requestHistory.length;
  return this.requestHistory.slice(0, count);
  }

/**
* Format messages in the Anthropic message format
* @param {Array<Object>} messages - Array of messages
* @returns {Array<Object>} - Formatted messages
  */
  formatMessages(messages) {
  return messages.map(message => {
  // Convert OpenAI-style roles to Anthropic roles
  let role = message.role;
  if (role === 'assistant') {
  role = 'assistant';
  } else if (role === 'user') {
  role = 'user';
  } else if (role === 'system') {
  // System messages are handled differently in Anthropic API
  return { role: 'system', content: message.content };
  }

  return {
  role,
  content: message.content
  };
  });
  }

/**
* Get available models
* @returns {Array<Object>} - List of available Claude models
  */
  getAvailableModels() {
  return [
  {
  id: 'claude-3-opus-20240229',
  name: 'Claude 3 Opus',
  description: 'Most powerful Claude model for highly complex tasks',
  contextWindow: 200000,
  created: '2024-02-29'
  },
  {
  id: 'claude-3-sonnet-20240229',
  name: 'Claude 3 Sonnet',
  description: 'Balanced model for most tasks',
  contextWindow: 200000,
  created: '2024-02-29'
  },
  {
  id: 'claude-3-haiku-20240307',
  name: 'Claude 3 Haiku',
  description: 'Fastest and most compact Claude model',
  contextWindow: 200000,
  created: '2024-03-07'
  },
  {
  id: 'claude-2.1',
  name: 'Claude 2.1',
  description: 'Previous generation model',
  contextWindow: 100000,
  created: '2023-11-21'
  },
  {
  id: 'claude-2.0',
  name: 'Claude 2.0',
  description: 'Legacy model',
  contextWindow: 100000,
  created: '2023-07-11'
  },
  {
  id: 'claude-instant-1.2',
  name: 'Claude Instant 1.2',
  description: 'Fastest legacy model',
  contextWindow: 100000,
  created: '2023-03-14'
  }
  ];
  }

/**
* Get plugin status
* @returns {Object} - Status information
  */
  getStatus() {
  return {
  name: this.name,
  version: this.version,
  description: this.description,
  initialized: this.initialized,
  running: this.running || false,
  defaultModel: this.defaultModel,
  requestsProcessed: this.requestHistory.length,
  lastRequestTimestamp: this.requestHistory[0]?.timestamp || null,
  timestamp: new Date().toISOString()
  };
  }
  }

module.exports = SafeguardAnthropicPlugin;
```
<llm-snippet-file>_safeguard-plugin-system/templates/nodejs/anthropic-llm-api/package.json</llm-snippet-file>
```
json
{
"name": "safeguard-anthropic-plugin",
"version": "1.0.0",
"description": "Anthropic Claude API template for Safeguard plugins",
"main": "index.js",
"scripts": {
"test": "jest",
"lint": "eslint ."
},
"keywords": [
"safeguard",
"plugin",
"template",
"anthropic",
"claude",
"llm",
"ai",
"language-model",
"nlp"
],
"author": "Autonomy Association International, Inc.",
"license": "PROPRIETARY",
"copyright": "Copyright 2025 Autonomy Association International Inc., all rights reserved.",
"dependencies": {
"@anthropic-ai/sdk": "^0.8.0",
"uuid": "^9.0.1"
},
"devDependencies": {
"eslint": "^8.52.0",
"jest": "^29.0.0",
"nock": "^13.3.0"
},
"engines": {
"node": ">=16.0.0",
"npm": ">=8.0.0"
}
}
```
<llm-snippet-file>_safeguard-plugin-system/templates/nodejs/anthropic-llm-api/README.md</llm-snippet-file>
```markdown
# Safeguard Anthropic Claude API Plugin Template

This template provides a structure for creating a Safeguard plugin that interacts with the Anthropic API for Claude language model inference. It supports both the modern Messages API and legacy Completions API for maximum compatibility.

## Features

- Message creation with Claude 3 models (recommended API)
- Text completion with Claude models (legacy API)
- Request history tracking and management
- Support for streaming responses
- Tool usage with Claude
- Comprehensive error handling and logging

## Prerequisites

- Anthropic API key
- Node.js 16.x or higher
- NPM 8.x or higher

## Usage

1. Clone this template
2. Install dependencies with `npm install`
3. Set your Anthropic API key in the configuration
4. Initialize and use the plugin in your application

## Configuration Options

- `apiKey`: Anthropic API key (required)
- `defaultModel`: Default model to use (default: 'claude-3-opus-20240229')
- `baseURL`: API base URL (optional, for custom endpoints)
- `timeout`: Request timeout in milliseconds (default: 60000)
- `maxHistorySize`: Maximum number of requests to keep in history (default: 100)
- `validateApiKey`: Whether to validate the API key during initialization (default: true)

## API Methods

### Messages API (Recommended)

```javascript
const result = await plugin.createMessage({
  messages: [
    { role: 'user', content: 'Tell me about autonomous systems.' }
  ],
  model: 'claude-3-opus-20240229', // optional, uses defaultModel if not specified
  maxTokens: 1024,
  temperature: 0.7,
  system: 'You are a helpful assistant specialized in robotics and AI.' // optional
});
```
```


### Completions API (Legacy)

```javascript
const result = await plugin.createCompletion({
  prompt: '\n\nHuman: Tell me about autonomous systems.\n\nAssistant:',
  model: 'claude-2.1', // optional, uses defaultModel if not specified
  maxTokensToSample: 1024,
  temperature: 0.7,
  stopSequences: ['\n\nHuman:']
});
```


### Using Tools

```javascript
const result = await plugin.createMessage({
  messages: [
    { role: 'user', content: 'What\'s the weather like in San Francisco today?' }
  ],
  tools: [
    {
      name: 'get_weather',
      description: 'Get the current weather in a location',
      input_schema: {
        type: 'object',
        properties: {
          location: {
            type: 'string',
            description: 'The city and state, e.g. San Francisco, CA'
          }
        },
        required: ['location']
      }
    }
  ]
});
```


### Streaming Responses

```javascript
const stream = await plugin.createMessage({
  messages: [
    { role: 'user', content: 'Write a poem about robots.' }
  ],
  stream: true
});

for await (const chunk of stream) {
  process.stdout.write(chunk.delta.text || '');
}
```


## Example

```javascript
const SafeguardAnthropicPlugin = require('./index');

// Create plugin instance
const plugin = new SafeguardAnthropicPlugin({
  name: 'claude-assistant',
  apiKey: 'your-anthropic-api-key'
});

// Initialize and use the plugin
async function run() {
  await plugin.initialize({});
  await plugin.start();
  
  // Use the Messages API
  const message = await plugin.createMessage({
    messages: [
      { role: 'user', content: 'What are the key safety considerations for autonomous robots?' }
    ],
    system: 'You are a helpful assistant specialized in robotics and AI systems. Be concise and technical in your responses.'
  });
  
  console.log('Claude response:', message.content[0].text);
  
  // Check available models
  const models = plugin.getAvailableModels();
  console.log('Available Claude models:', models.map(m => m.name).join(', '));
  
  await plugin.stop();
}

run().catch(console.error);
```


## License

Copyright 2025 Autonomy Association International Inc., all rights reserved.
```
<llm-snippet-file>_safeguard-plugin-system/templates/nodejs/anthropic-llm-api/example.js</llm-snippet-file>
```javascript
/**
 * Example usage of the Anthropic Claude API Safeguard Plugin
 */

const SafeguardAnthropicPlugin = require('./index');

// Create plugin instance with your API key
// NOTE: Replace 'your-anthropic-api-key' with your actual API key
const plugin = new SafeguardAnthropicPlugin({
  name: 'claude-assistant',
  version: '1.0.0',
  description: 'Anthropic Claude Integration Example',
  apiKey: 'your-anthropic-api-key',
  defaultModel: 'claude-3-sonnet-20240229', // Using Sonnet for this example (cheaper than Opus)
  logger: console
});

// Demonstrate the plugin capabilities
async function demonstrateAnthropicClaude() {
  try {
    // Initialize the plugin
    console.log('Initializing Anthropic Claude plugin...');
    await plugin.initialize({
      appContext: { 
        appVersion: '1.0.0',
        environment: 'development'
      }
    });
    
    // Start the plugin
    console.log('\nStarting plugin...');
    await plugin.start();
    
    // Get plugin status
    console.log('\nPlugin status:');
    console.log(JSON.stringify(plugin.getStatus(), null, 2));
    
    // List available models
    console.log('\nAvailable Claude models:');
    const models = plugin.getAvailableModels();
    models.forEach(model => {
      console.log(`- ${model.name} (${model.id}): ${model.description}`);
    });
    
    // Create a message with the Messages API
    try {
      console.log('\nCreating message with Claude...');
      const messageResult = await plugin.createMessage({
        messages: [
          { role: 'user', content: 'What are three important considerations for the safe deployment of autonomous robots in urban environments? Please be concise.' }
        ],
        system: 'You are a helpful assistant specializing in robotics, AI, and autonomous systems. Your responses should be clear, technical, and focused on safety.'
      });
      
      console.log('\nClaude message result:');
      console.log('Model:', messageResult.model);
      console.log('Response:');
      messageResult.content.forEach(part => {
        if (part.type === 'text') {
          console.log(part.text);
        }
      });
      console.log('Usage:', messageResult.usage);
      console.log('Duration:', messageResult.duration, 'ms');
    } catch (messageError) {
      console.error('Error creating message:', messageError.message);
    }
    
    // Create a message with tool use
    try {
      console.log('\nCreating message with tools...');
      const toolsResult = await plugin.createMessage({
        messages: [
          { role: 'user', content: 'What\'s the weather like in New York City right now?' }
        ],
        tools: [
          {
            name: 'get_weather',
            description: 'Get the current weather in a location',
            input_schema: {
              type: 'object',
              properties: {
                location: {
                  type: 'string',
                  description: 'The city and state, e.g. San Francisco, CA'
                },
                unit: {
                  type: 'string',
                  enum: ['celsius', 'fahrenheit'],
                  description: 'The unit of temperature'
                }
              },
              required: ['location']
            }
          }
        ]
      });
      
      console.log('\nTools message result:');
      console.log('Model:', toolsResult.model);
      
      // Check if there's a tool use in the response
      const hasToolUse = toolsResult.content.some(part => part.type === 'tool_use');
      
      if (hasToolUse) {
        toolsResult.content.forEach(part => {
          if (part.type === 'tool_use') {
            console.log('Tool use request:');
            console.log('Tool:', part.name);
            console.log('Input:', JSON.stringify(part.input, null, 2));
          } else if (part.type === 'text') {
            console.log('Text:', part.text);
          }
        });
      } else {
        console.log('No tool use in response. Claude said:');
        toolsResult.content.forEach(part => {
          if (part.type === 'text') {
            console.log(part.text);
          }
        });
      }
    } catch (toolsError) {
      console.error('Error creating message with tools:', toolsError.message);
    }
    
    // Try the legacy Completions API
    try {
      console.log('\nCreating completion with Claude (legacy API)...');
      const completionResult = await plugin.createCompletion({
        prompt: '\n\nHuman: Explain how autonomous drones navigate in GPS-denied environments. Keep it brief.\n\nAssistant:',
        maxTokensToSample: 300,
        temperature: 0.7,
        stopSequences: ['\n\nHuman:']
      });
      
      console.log('\nClaude completion result (legacy API):');
      console.log('Model:', completionResult.model);
      console.log('Completion:', completionResult.completion);
      console.log('Stop reason:', completionResult.stopReason);
      console.log('Duration:', completionResult.duration, 'ms');
    } catch (completionError) {
      console.error('Error creating completion:', completionError.message);
    }
    
    // Demonstrate streaming (commented out for clarity in console output)
    /*
    try {
      console.log('\nDemonstrating streaming response...');
      const stream = await plugin.createMessage({
        messages: [
          { role: 'user', content: 'Write a very short poem about robots and humans working together.' }
        ],
        stream: true
      });
      
      console.log('\nStreaming response:');
      process.stdout.write('\n');
      
      for await (const chunk of stream) {
        if (chunk.type === 'content_block_delta' && chunk.delta.type === 'text') {
          process.stdout.write(chunk.delta.text || '');
        }
      }
      process.stdout.write('\n\n');
      
    } catch (streamError) {
      console.error('Error with streaming response:', streamError.message);
    }
    */
    
    // Get request history
    console.log('\nRequest history:');
    const history = plugin.getRequestHistory(5);
    console.log(JSON.stringify(history, null, 2));
    
    // Stop the plugin
    console.log('\nStopping plugin...');
    await plugin.stop();
    
    // Final status
    console.log('\nFinal plugin status:');
    console.log(JSON.stringify(plugin.getStatus(), null, 2));
    
  } catch (error) {
    console.error('Error in Anthropic Claude demonstration:', error);
  }
}

// Run the demonstration
demonstrateAnthropicClaude();
```
```


### 7. Llama API Node.js Template

```javascript
/**
 * Llama API Safeguard Plugin Template
 * 
 * This template provides a structure for creating a Safeguard plugin
 * that interacts with the Llama API for language model inference.
 * Uses the LM Studio client for Node.js.
 * 
 * @module SafeguardLlamaPlugin
 * @copyright Copyright 2025 Autonomy Association International Inc., all rights reserved.
 */

const { LMStudioClient } = require('@lmstudio/client');
const { v4: uuidv4 } = require('uuid');

class SafeguardLlamaPlugin {
  /**
   * Constructor for the Llama API plugin
   * @param {Object} config - Plugin configuration
   */
  constructor(config = {}) {
    this.name = config.name || 'llama-plugin';
    this.version = config.version || '1.0.0';
    this.description = config.description || 'Llama API Safeguard Plugin';
    this.config = config;
    this.initialized = false;
    this.logger = config.logger || console;
    
    // Llama specific configuration
    this.baseUrl = config.baseUrl || 'http://localhost:1234/v1';
    this.defaultModel = config.defaultModel || 'llama3';
    this.timeout = config.timeout || 60000; // 60 seconds default
    this.requestHistory = [];
    this.maxHistorySize = config.maxHistorySize || 100;
    
    this.logger.info(`[${this.name}] Plugin instance created`);
  }

  /**
   * Initialize the plugin
   * @param {Object} context - Initialization context
   * @returns {Promise<boolean>} - True if initialization successful
   */
  async initialize(context) {
    try {
      this.logger.info(`[${this.name}] Initializing plugin v${this.version}`);
      this.context = context;
      
      // Initialize Llama client
      this.client = new LMStudioClient({
        baseURL: this.baseUrl,
        timeout: this.timeout
      });
      
      // Validate connection by testing a simple request
      if (this.config.validateConnection !== false) {
        try {
          await this.testConnection();
          this.logger.info(`[${this.name}] Connection validation successful`);
        } catch (error) {
          throw new Error(`Connection validation failed: ${error.message}`);
        }
      }
      
      this.initialized = true;
      return true;
    } catch (error) {
      this.logger.error(`[${this.name}] Initialization failed:`, error);
      return false;
    }
  }

  /**
   * Test connection to the Llama API
   * @returns {Promise<Object>} - Response from API test
   */
  async testConnection() {
    try {
      // Test with a minimal message to validate connection
      const response = await this.client.chat.completions.create({
        model: this.defaultModel,
        messages: [
          { role: 'user', content: 'Hello' }
        ],
        max_tokens: 5
      });
      
      if (!response || !response.choices) {
        throw new Error('Invalid response from Llama API');
      }
      
      return response;
    } catch (error) {
      this.logger.error(`[${this.name}] Connection test failed:`, error);
      throw error;
    }
  }

  /**
   * Start the plugin
   * @returns {Promise<boolean>} - True if start successful
   */
  async start() {
    if (!this.initialized) {
      this.logger.error(`[${this.name}] Cannot start: plugin not initialized`);
      return false;
    }
    
    try {
      this.logger.info(`[${this.name}] Starting plugin...`);
      this.running = true;
      return true;
    } catch (error) {
      this.logger.error(`[${this.name}] Start failed:`, error);
      return false;
    }
  }

  /**
   * Stop the plugin
   * @returns {Promise<boolean>} - True if stop successful
   */
  async stop() {
    if (!this.running) {
      this.logger.info(`[${this.name}] Plugin already stopped`);
      return true;
    }
    
    try {
      this.logger.info(`[${this.name}] Stopping plugin...`);
      this.running = false;
      return true;
    } catch (error) {
      this.logger.error(`[${this.name}] Stop failed:`, error);
      return false;
    }
  }

  /**
   * Create a chat completion
   * @param {Object} params - Chat completion parameters
   * @param {Array<Object>} params.messages - Chat messages array
   * @param {string} [params.model] - Model to use, defaults to this.defaultModel
   * @param {number} [params.temperature] - Sampling temperature (0.0-2.0)
   * @param {number} [params.maxTokens] - Maximum tokens to generate
   * @param {number} [params.topP] - Nucleus sampling parameter (0.0-1.0)
   * @param {number} [params.presencePenalty] - Presence penalty (-2.0-2.0)
   * @param {number} [params.frequencyPenalty] - Frequency penalty (-2.0-2.0)
   * @param {Array<string>} [params.stop] - Sequences that stop generation
   * @param {boolean} [params.stream] - Whether to stream the response
   * @returns {Promise<Object>} - Chat completion result
   */
  async createChatCompletion(params) {
    if (!this.initialized || !this.running) {
      throw new Error(`[${this.name}] Cannot create chat completion: plugin not running`);
    }
    
    const requestId = uuidv4();
    const startTime = Date.now();
    
    try {
      const model = params.model || this.defaultModel;
      this.logger.info(`[${this.name}] Creating chat completion with model: ${model} (${requestId})`);
      
      // Prepare request parameters
      const requestParams = {
        model,
        messages: params.messages,
        temperature: params.temperature !== undefined ? params.temperature : 0.7,
        max_tokens: params.maxTokens || 1024,
        top_p: params.topP !== undefined ? params.topP : 0.9,
        presence_penalty: params.presencePenalty,
        frequency_penalty: params.frequencyPenalty,
        stop: params.stop,
        stream: params.stream
      };
      
      // Clean undefined values
      Object.keys(requestParams).forEach(key => {
        if (requestParams[key] === undefined) {
          delete requestParams[key];
        }
      });
      
      // Log request (exclude messages for privacy)
      this.logger.debug(`[${this.name}] Request (${requestId}):`, {
        ...requestParams,
        messages: `[${requestParams.messages.length} messages]`
      });
      
      // Handle streaming response
      if (params.stream) {
        const stream = await this.client.chat.completions.create({
          ...requestParams,
          stream: true
        });
        
        // Return the stream directly
        this.addToHistory({
          id: requestId,
          type: 'chat-completion-stream',
          model: model,
          params: {
            ...requestParams,
            messages: `[${requestParams.messages.length} messages]`
          },
          status: 'success',
          timestamp: new Date().toISOString()
        });
        
        return stream;
      }
      
      // Make API call to Llama
      const response = await this.client.chat.completions.create(requestParams);
      
      const duration = Date.now() - startTime;
      this.logger.info(`[${this.name}] Chat completion completed in ${duration}ms (${requestId})`);
      
      // Process and format response
      const result = {
        id: response.id || requestId,
        object: response.object || 'chat.completion',
        created: response.created || Math.floor(Date.now() / 1000),
        model: response.model || model,
        choices: response.choices || [],
        usage: response.usage || {
          prompt_tokens: 0,
          completion_tokens: 0,
          total_tokens: 0
        },
        duration: duration,
        timestamp: new Date().toISOString()
      };
      
      // Add to request history
      this.addToHistory({
        id: requestId,
        type: 'chat-completion',
        model: model,
        params: {
          ...requestParams,
          messages: `[${requestParams.messages.length} messages]`
        },
        status: 'success',
        duration: duration,
        timestamp: new Date().toISOString()
      });
      
      return result;
    } catch (error) {
      const duration = Date.now() - startTime;
      this.logger.error(`[${this.name}] Chat completion failed (${requestId}):`, error);
      
      // Add failed request to history
      this.addToHistory({
        id: requestId,
        type: 'chat-completion',
        model: params.model || this.defaultModel,
        params: {
          model: params.model || this.defaultModel,
          messages: params.messages ? `[${params.messages.length} messages]` : '[]'
        },
        status: 'error',
        error: error.message,
        duration: duration,
        timestamp: new Date().toISOString()
      });
      
      throw error;
    }
  }

  /**
   * Create a completion
   * @param {Object} params - Completion parameters
   * @param {string} params.prompt - The input prompt
   * @param {string} [params.model] - Model to use, defaults to this.defaultModel
   * @param {number} [params.temperature] - Sampling temperature (0.0-2.0)
   * @param {number} [params.maxTokens] - Maximum tokens to generate
   * @param {number} [params.topP] - Nucleus sampling parameter (0.0-1.0)
   * @param {number} [params.presencePenalty] - Presence penalty (-2.0-2.0)
   * @param {number} [params.frequencyPenalty] - Frequency penalty (-2.0-2.0)
   * @param {Array<string>} [params.stop] - Sequences that stop generation
   * @param {boolean} [params.stream] - Whether to stream the response
   * @returns {Promise<Object>} - Completion result
   */
  async createCompletion(params) {
    if (!this.initialized || !this.running) {
      throw new Error(`[${this.name}] Cannot create completion: plugin not running`);
    }
    
    const requestId = uuidv4();
    const startTime = Date.now();
    
    try {
      const model = params.model || this.defaultModel;
      this.logger.info(`[${this.name}] Creating completion with model: ${model} (${requestId})`);
      
      // Prepare request parameters
      const requestParams = {
        model,
        prompt: params.prompt,
        temperature: params.temperature !== undefined ? params.temperature : 0.7,
        max_tokens: params.maxTokens || 1024,
        top_p: params.topP !== undefined ? params.topP : 0.9,
        presence_penalty: params.presencePenalty,
        frequency_penalty: params.frequencyPenalty,
        stop: params.stop,
        stream: params.stream
      };
      
      // Clean undefined values
      Object.keys(requestParams).forEach(key => {
        if (requestParams[key] === undefined) {
          delete requestParams[key];
        }
      });
      
      // Log request (exclude prompt for privacy)
      this.logger.debug(`[${this.name}] Request (${requestId}):`, {
        ...requestParams,
        prompt: `[${requestParams.prompt.length} chars]`
      });
      
      // Handle streaming response
      if (params.stream) {
        const stream = await this.client.completions.create({
          ...requestParams,
          stream: true
        });
        
        // Return the stream directly
        this.addToHistory({
          id: requestId,
          type: 'completion-stream',
          model: model,
          params: {
            ...requestParams,
            prompt: `[${requestParams.prompt.length} chars]`
          },
          status: 'success',
          timestamp: new Date().toISOString()
        });
        
        return stream;
      }
      
      // Make API call to Llama
      const response = await this.client.completions.create(requestParams);
      
      const duration = Date.now() - startTime;
      this.logger.info(`[${this.name}] Completion completed in ${duration}ms (${requestId})`);
      
      // Process and format response
      const result = {
        id: response.id || requestId,
        object: response.object || 'completion',
        created: response.created || Math.floor(Date.now() / 1000),
        model: response.model || model,
        choices: response.choices || [],
        usage: response.usage || {
          prompt_tokens: 0,
          completion_tokens: 0,
          total_tokens: 0
        },
        duration: duration,
        timestamp: new Date().toISOString()
      };
      
      // Add to request history
      this.addToHistory({
        id: requestId,
        type: 'completion',
        model: model,
        params: {
          ...requestParams,
          prompt: `[${requestParams.prompt.length} chars]`
        },
        status: 'success',
        duration: duration,
        timestamp: new Date().toISOString()
      });
      
      return result;
    } catch (error) {
      const duration = Date.now() - startTime;
      this.logger.error(`[${this.name}] Completion failed (${requestId}):`, error);
      
      // Add failed request to history
      this.addToHistory({
        id: requestId,
        type: 'completion',
        model: params.model || this.defaultModel,
        params: {
          model: params.model || this.defaultModel,
          prompt: params.prompt ? `[${params.prompt.length} chars]` : ''
        },
        status: 'error',
        error: error.message,
        duration: duration,
        timestamp: new Date().toISOString()
      });
      
      throw error;
    }
  }

  /**
   * Generate embeddings
   * @param {Object} params - Embedding parameters
   * @param {string|Array<string>} params.input - Text to embed
   * @param {string} [params.model] - Model to use, defaults to this.defaultModel + "-embed"
   * @returns {Promise<Object>} - Embedding vectors and metadata
   */
  async createEmbeddings(params) {
    if (!this.initialized || !this.running) {
      throw new Error(`[${this.name}] Cannot create embeddings: plugin not running`);
    }
    
    const requestId = uuidv4();
    const startTime = Date.now();
    
    try {
      const model = params.model || `${this.defaultModel}-embed`;
      const input = Array.isArray(params.input) ? params.input : [params.input];
      
      this.logger.info(`[${this.name}] Creating embeddings for ${input.length} texts with model: ${model} (${requestId})`);
      
      // Prepare request parameters
      const requestParams = {
        model,
        input
      };
      
      // Log request (exclude input text for privacy)
      this.logger.debug(`[${this.name}] Request (${requestId}):`, {
        model,
        input: `[${input.length} texts]`
      });
      
      // Make API call to Llama
      const response = await this.client.embeddings.create(requestParams);
      
      const duration = Date.now() - startTime;
      this.logger.info(`[${this.name}] Embeddings creation completed in ${duration}ms (${requestId})`);
      
      // Process and format response
      const result = {
        object: response.object || 'list',
        data: response.data || [],
        model: response.model || model,
        usage: response.usage || {
          prompt_tokens: 0,
          total_tokens: 0
        },
        dimensions: response.data && response.data[0] ? response.data[0].embedding.length : 0,
        duration: duration,
        timestamp: new Date().toISOString()
      };
      
      // Add to request history
      this.addToHistory({
        id: requestId,
        type: 'embeddings',
        model: model,
        params: {
          model,
          input: input.map(text => `[${text.length} chars]`)
        },
        status: 'success',
        duration: duration,
        timestamp: new Date().toISOString()
      });
      
      return result;
    } catch (error) {
      const duration = Date.now() - startTime;
      this.logger.error(`[${this.name}] Embeddings creation failed (${requestId}):`, error);
      
      // Add failed request to history
      this.addToHistory({
        id: requestId,
        type: 'embeddings',
        model: params.model || `${this.defaultModel}-embed`,
        params: {
          model: params.model || `${this.defaultModel}-embed`,
          input: Array.isArray(params.input) 
            ? params.input.map(text => `[${text.length} chars]`)
            : `[${params.input.length} chars]`
        },
        status: 'error',
        error: error.message,
        duration: duration,
        timestamp: new Date().toISOString()
      });
      
      throw error;
    }
  }

  /**
   * List available models
   * @returns {Promise<Array>} - List of available models
   */
  async listModels() {
    if (!this.initialized) {
      throw new Error(`[${this.name}] Cannot list models: plugin not initialized`);
    }
    
    try {
      const response = await this.client.models.list();
      return response.data || [];
    } catch (error) {
      this.logger.error(`[${this.name}] List models failed:`, error);
      throw error;
    }
  }

  /**
   * Add a request to the history
   * @private
   * @param {Object} entry - History entry
   */
  addToHistory(entry) {
    this.requestHistory.unshift(entry);
    
    // Trim history if it exceeds max size
    if (this.requestHistory.length > this.maxHistorySize) {
      this.requestHistory = this.requestHistory.slice(0, this.maxHistorySize);
    }
  }

  /**
   * Get request history
   * @param {number} [limit] - Maximum number of entries to return
   * @returns {Array} - Request history
   */
  getRequestHistory(limit) {
    const count = limit && limit > 0 ? Math.min(limit, this.requestHistory.length) : this.requestHistory.length;
    return this.requestHistory.slice(0, count);
  }

  /**
   * Get plugin status
   * @returns {Object} - Status information
   */
  getStatus() {
    return {
      name: this.name,
      version: this.version,
      description: this.description,
      initialized: this.initialized,
      running: this.running || false,
      baseUrl: this.baseUrl,
      defaultModel: this.defaultModel,
      requestsProcessed: this.requestHistory.length,
      lastRequestTimestamp: this.requestHistory[0]?.timestamp || null,
      timestamp: new Date().toISOString()
    };
  }
}

module.exports = SafeguardLlamaPlugin;
```


```json
{
  "name": "safeguard-llama-plugin",
  "version": "1.0.0",
  "description": "Llama API template for Safeguard plugins",
  "main": "index.js",
  "scripts": {
    "test": "jest",
    "lint": "eslint ."
  },
  "keywords": [
    "safeguard",
    "plugin",
    "template",
    "llama",
    "llm",
    "ai",
    "language-model",
    "local-llm",
    "lmstudio",
    "ollama"
  ],
  "author": "Autonomy Association International, Inc.",
  "license": "PROPRIETARY",
  "copyright": "Copyright 2025 Autonomy Association International Inc., all rights reserved.",
  "dependencies": {
    "@lmstudio/client": "^0.3.0",
    "uuid": "^9.0.1"
  },
  "devDependencies": {
    "eslint": "^8.52.0",
    "jest": "^29.0.0"
  },
  "engines": {
    "node": ">=16.0.0",
    "npm": ">=8.0.0"
  }
}
```


```markdown
# Safeguard Llama API Plugin Template

This template provides a structure for creating a Safeguard plugin that interacts with the Llama API for language model inference. It uses the LM Studio client for Node.js, which is compatible with the OpenAI API format and works with LM Studio, Ollama, and other local LLM servers.

## Features

- Chat completions with locally running LLMs
- Text completions with traditional prompt format
- Embeddings generation for semantic search and NLP tasks
- Support for streaming responses
- Request history tracking and management
- Comprehensive error handling and logging

## Prerequisites

- Local LLM server running (LM Studio, Ollama, or similar)
- Node.js 16.x or higher
- NPM 8.x or higher

## Usage

1. Clone this template
2. Install dependencies with `npm install`
3. Configure the connection to your local LLM server
4. Initialize and use the plugin in your application

## Configuration Options

- `baseUrl`: URL of the local LLM server (default: 'http://localhost:1234/v1')
- `defaultModel`: Default model to use (default: 'llama3')
- `timeout`: Request timeout in milliseconds (default: 60000)
- `maxHistorySize`: Maximum number of requests to keep in history (default: 100)
- `validateConnection`: Whether to validate the connection during initialization (default: true)

## API Methods

### Chat Completions

```javascript
const completion = await plugin.createChatCompletion({
  messages: [
    { role: 'system', content: 'You are a helpful assistant.' },
    { role: 'user', content: 'Tell me about autonomous systems.' }
  ],
  model: 'llama3', // optional, uses defaultModel if not specified
  temperature: 0.7,
  maxTokens: 1000
});
```
```


### Text Completions

```javascript
const completion = await plugin.createCompletion({
  prompt: 'Once upon a time in the world of artificial intelligence,',
  model: 'llama3', // optional, uses defaultModel if not specified
  maxTokens: 1000,
  temperature: 0.7
});
```


### Embeddings Generation

```javascript
const embeddings = await plugin.createEmbeddings({
  input: ['Autonomous systems require robust safety measures'],
  model: 'llama3-embed' // optional, uses defaultModel + "-embed" if not specified
});
```


### Streaming Responses

```javascript
const stream = await plugin.createChatCompletion({
  messages: [
    { role: 'user', content: 'Write a poem about robots.' }
  ],
  stream: true
});

for await (const chunk of stream) {
  process.stdout.write(chunk.choices[0]?.delta?.content || '');
}
```


### List Available Models

```javascript
const models = await plugin.listModels();
```


## Example

```javascript
const SafeguardLlamaPlugin = require('./index');

// Create plugin instance
const plugin = new SafeguardLlamaPlugin({
  name: 'local-llm',
  baseUrl: 'http://localhost:1234/v1',
  defaultModel: 'llama3'
});

// Initialize and use the plugin
async function run() {
  await plugin.initialize({});
  await plugin.start();
  
  // Generate text with chat interface
  const chat = await plugin.createChatCompletion({
    messages: [
      { role: 'system', content: 'You are a helpful assistant specialized in robotics.' },
      { role: 'user', content: 'What are the key safety considerations for autonomous robots?' }
    ]
  });
  
  console.log('Chat response:', chat.choices[0].message.content);
  
  // Generate text with completion interface
  const completion = await plugin.createCompletion({
    prompt: 'Autonomous robots must consider the following safety aspects:'
  });
  
  console.log('Completion:', completion.choices[0].text);
  
  await plugin.stop();
}

run().catch(console.error);
```


## Compatible LLM Servers

This plugin works with any server that implements the OpenAI API format, including:

- [LM Studio](https://lmstudio.ai/)
- [Ollama](https://ollama.ai/)
- [LocalAI](https://github.com/go-skynet/LocalAI)
- [vLLM](https://github.com/vllm-project/vllm)
- [oobabooga/text-generation-webui](https://github.com/oobabooga/text-generation-webui)

## License

Copyright 2025 Autonomy Association International Inc., all rights reserved.
```
<llm-snippet-file>_safeguard-plugin-system/templates/nodejs/llama-llm-api/example.js</llm-snippet-file>
```javascript
/**
 * Example usage of the Llama API Safeguard Plugin
 */

const SafeguardLlamaPlugin = require('./index');

// Create plugin instance
// NOTE: Adjust the baseUrl and defaultModel to match your local LLM server configuration
const plugin = new SafeguardLlamaPlugin({
  name: 'local-llm-assistant',
  version: '1.0.0',
  description: 'Local Llama LLM Integration Example',
  baseUrl: 'http://localhost:1234/v1', // Default for LM Studio
  defaultModel: 'llama3', // Change to match your loaded model
  logger: console
});

// Demonstrate the plugin capabilities
async function demonstrateLlamaLLM() {
  try {
    // Initialize the plugin
    console.log('Initializing Llama plugin...');
    await plugin.initialize({
      appContext: { 
        appVersion: '1.0.0',
        environment: 'development'
      }
    });
    
    // Start the plugin
    console.log('\nStarting plugin...');
    await plugin.start();
    
    // Get plugin status
    console.log('\nPlugin status:');
    console.log(JSON.stringify(plugin.getStatus(), null, 2));
    
    // List available models
    try {
      console.log('\nListing available models...');
      const models = await plugin.listModels();
      console.log('Available models:', models);
    } catch (modelError) {
      console.error('Error listing models:', modelError.message);
      console.log('Continuing with the default model');
    }
    
    // Create chat completion
    try {
      console.log('\nCreating chat completion...');
      const chatResult = await plugin.createChatCompletion({
        messages: [
          { role: 'system', content: 'You are a helpful assistant specializing in robotics and autonomous systems.' },
          { role: 'user', content: 'What are three important safety considerations for autonomous robots in urban environments? Please be concise.' }
        ],
        temperature: 0.7,
        maxTokens: 500
      });
      
      console.log('\nChat completion result:');
      console.log('Model:', chatResult.model);
      console.log('Response:', chatResult.choices[0]?.message?.content);
      if (chatResult.usage) {
        console.log('Usage:', chatResult.usage);
      }
      console.log('Duration:', chatResult.duration, 'ms');
    } catch (chatError) {
      console.error('Error creating chat completion:', chatError.message);
    }
    
    // Create text completion
    try {
      console.log('\nCreating text completion...');
      const completionResult = await plugin.createCompletion({
        prompt: 'Write a brief explanation of how autonomous drones navigate in urban environments:',
        temperature: 0.7,
        maxTokens: 300
      });
      
      console.log('\nText completion result:');
      console.log('Model:', completionResult.model);
      console.log('Response:', completionResult.choices[0]?.text);
      if (completionResult.usage) {
        console.log('Usage:', completionResult.usage);
      }
      console.log('Duration:', completionResult.duration, 'ms');
    } catch (completionError) {
      console.error('Error creating text completion:', completionError.message);
    }
    
    // Generate embeddings
    try {
      console.log('\nGenerating embeddings...');
      const embeddingsResult = await plugin.createEmbeddings({
        input: [
          "Autonomous robots must prioritize human safety",
          "Vision systems are critical for environmental awareness"
        ]
      });
      
      console.log('\nEmbeddings result:');
      console.log('Model:', embeddingsResult.model);
      console.log('Embedding count:', embeddingsResult.data.length);
      console.log('Dimensions:', embeddingsResult.dimensions);
      console.log('First embedding (first 5 values):', embeddingsResult.data[0]?.embedding.slice(0, 5));
      if (embeddingsResult.usage) {
        console.log('Usage:', embeddingsResult.usage);
      }
      console.log('Duration:', embeddingsResult.duration, 'ms');
    } catch (embeddingsError) {
      console.error('Error generating embeddings:', embeddingsError.message);
    }
    
    // Demonstrate streaming (uncomment to try)
    /*
    try {
      console.log('\nDemonstrating streaming response...');
      const stream = await plugin.createChatCompletion({
        messages: [
          { role: 'user', content: 'Write a very short poem about robots and humans working together.' }
        ],
        stream: true
      });
      
      console.log('\nStreaming response:');
      process.stdout.write('\n');
      
      for await (const chunk of stream) {
        process.stdout.write(chunk.choices[0]?.delta?.content || '');
      }
      process.stdout.write('\n\n');
      
    } catch (streamError) {
      console.error('Error with streaming response:', streamError.message);
    }
    */
    
    // Get request history
    console.log('\nRequest history:');
    const history = plugin.getRequestHistory(5);
    console.log(JSON.stringify(history, null, 2));
    
    // Stop the plugin
    console.log('\nStopping plugin...');
    await plugin.stop();
    
    // Final status
    console.log('\nFinal plugin status:');
    console.log(JSON.stringify(plugin.getStatus(), null, 2));
    
  } catch (error) {
    console.error('Error in Llama LLM demonstration:', error);
  }
}

// Run the demonstration
demonstrateLlamaLLM();
```
```


### 8. Generic ML Node.js Template

```javascript
/**
 * Generic ML Safeguard Plugin Template
 * 
 * This template provides a structure for creating a Safeguard plugin
 * that integrates with machine learning models for inference and prediction.
 * 
 * @module SafeguardGenericMLPlugin
 * @copyright Copyright 2025 Autonomy Association International Inc., all rights reserved.
 */

const { v4: uuidv4 } = require('uuid');
const fs = require('fs');
const path = require('path');

class SafeguardGenericMLPlugin {
  /**
   * Constructor for the Generic ML plugin
   * @param {Object} config - Plugin configuration
   */
  constructor(config = {}) {
    this.name = config.name || 'generic-ml-plugin';
    this.version = config.version || '1.0.0';
    this.description = config.description || 'Generic ML Safeguard Plugin';
    this.config = config;
    this.initialized = false;
    this.logger = config.logger || console;
    
    // ML specific configuration
    this.modelPath = config.modelPath;
    this.modelType = config.modelType || 'generic';
    this.modelConfig = config.modelConfig || {};
    this.preprocessors = config.preprocessors || [];
    this.postprocessors = config.postprocessors || [];
    this.inferenceTimeout = config.inferenceTimeout || 30000; // 30 seconds default
    this.batchSize = config.batchSize || 1;
    this.requestHistory = [];
    this.maxHistorySize = config.maxHistorySize || 100;
    this.modelInstance = null;
    
    this.logger.info(`[${this.name}] Plugin instance created`);
  }

  /**
   * Initialize the plugin
   * @param {Object} context - Initialization context
   * @returns {Promise<boolean>} - True if initialization successful
   */
  async initialize(context) {
    try {
      this.logger.info(`[${this.name}] Initializing plugin v${this.version}`);
      this.context = context;
      
      // Check if model path exists
      if (this.modelPath) {
        if (!fs.existsSync(this.modelPath)) {
          throw new Error(`Model path does not exist: ${this.modelPath}`);
        }
        this.logger.info(`[${this.name}] Using model at: ${this.modelPath}`);
      }
      
      // Load model based on model type
      await this.loadModel();
      
      // Initialize preprocessors
      if (this.preprocessors.length > 0) {
        this.logger.info(`[${this.name}] Initializing ${this.preprocessors.length} preprocessors`);
        for (const preprocessor of this.preprocessors) {
          if (typeof preprocessor.initialize === 'function') {
            await preprocessor.initialize();
          }
        }
      }
      
      // Initialize postprocessors
      if (this.postprocessors.length > 0) {
        this.logger.info(`[${this.name}] Initializing ${this.postprocessors.length} postprocessors`);
        for (const postprocessor of this.postprocessors) {
          if (typeof postprocessor.initialize === 'function') {
            await postprocessor.initialize();
          }
        }
      }
      
      this.initialized = true;
      return true;
    } catch (error) {
      this.logger.error(`[${this.name}] Initialization failed:`, error);
      return false;
    }
  }

  /**
   * Load ML model
   * @private
   */
  async loadModel() {
    // This is a generic implementation - override for specific ML frameworks
    this.logger.info(`[${this.name}] Loading model of type: ${this.modelType}`);
    
    switch (this.modelType.toLowerCase()) {
      case 'tensorflow':
        await this.loadTensorflowModel();
        break;
      case 'onnx':
        await this.loadONNXModel();
        break;
      case 'pytorch':
        await this.loadPyTorchModel();
        break;
      case 'custom':
        await this.loadCustomModel();
        break;
      default:
        this.logger.warn(`[${this.name}] No specific loader for model type: ${this.modelType}. Using generic loader.`);
        await this.loadGenericModel();
    }
  }

  /**
   * Load TensorFlow.js model
   * @private
   */
  async loadTensorflowModel() {
    // Dynamically import TensorFlow.js
    try {
      const tf = require('@tensorflow/tfjs-node');
      this.modelInstance = await tf.loadLayersModel(`file://${this.modelPath}`);
      this.logger.info(`[${this.name}] TensorFlow.js model loaded successfully`);
    } catch (error) {
      this.logger.error(`[${this.name}] Failed to load TensorFlow.js model:`, error);
      throw error;
    }
  }

  /**
   * Load ONNX model
   * @private
   */
  async loadONNXModel() {
    // Dynamically import ONNX Runtime
    try {
      const ort = require('onnxruntime-node');
      this.modelInstance = await ort.InferenceSession.create(this.modelPath);
      this.logger.info(`[${this.name}] ONNX model loaded successfully`);
    } catch (error) {
      this.logger.error(`[${this.name}] Failed to load ONNX model:`, error);
      throw error;
    }
  }

  /**
   * Load PyTorch model via ONNX
   * @private
   */
  async loadPyTorchModel() {
    // For PyTorch models, we use ONNX as the bridge
    this.logger.info(`[${this.name}] Loading PyTorch model via ONNX`);
    await this.loadONNXModel();
  }

  /**
   * Load custom model implementation
   * @private
   */
  async loadCustomModel() {
    if (!this.config.customModelLoader) {
      throw new Error('Custom model loader is required for custom model type');
    }
    
    try {
      this.modelInstance = await this.config.customModelLoader(this.modelPath, this.modelConfig);
      this.logger.info(`[${this.name}] Custom model loaded successfully`);
    } catch (error) {
      this.logger.error(`[${this.name}] Failed to load custom model:`, error);
      throw error;
    }
  }

  /**
   * Load generic model (placeholder)
   * @private
   */
  async loadGenericModel() {
    // This is a placeholder for a generic model
    // In a real implementation, you would load your model here
    this.modelInstance = {
      predict: async (input) => {
        // Simulate a prediction
        return {
          output: input,
          confidence: 0.95
        };
      }
    };
    
    this.logger.info(`[${this.name}] Generic model placeholder created`);
  }

  /**
   * Start the plugin
   * @returns {Promise<boolean>} - True if start successful
   */
  async start() {
    if (!this.initialized) {
      this.logger.error(`[${this.name}] Cannot start: plugin not initialized`);
      return false;
    }
    
    try {
      this.logger.info(`[${this.name}] Starting plugin...`);
      this.running = true;
      return true;
    } catch (error) {
      this.logger.error(`[${this.name}] Start failed:`, error);
      return false;
    }
  }

  /**
   * Stop the plugin
   * @returns {Promise<boolean>} - True if stop successful
   */
  async stop() {
    if (!this.running) {
      this.logger.info(`[${this.name}] Plugin already stopped`);
      return true;
    }
    
    try {
      this.logger.info(`[${this.name}] Stopping plugin...`);
      this.running = false;
      return true;
    } catch (error) {
      this.logger.error(`[${this.name}] Stop failed:`, error);
      return false;
    }
  }

  /**
   * Make a prediction with the ML model
   * @param {Object|Array} input - Input data for prediction
   * @param {Object} [options] - Prediction options
   * @returns {Promise<Object>} - Prediction results
   */
  async predict(input, options = {}) {
    if (!this.initialized || !this.running) {
      throw new Error(`[${this.name}] Cannot predict: plugin not running`);
    }
    
    if (!this.modelInstance) {
      throw new Error(`[${this.name}] Model not loaded`);
    }
    
    const requestId = uuidv4();
    const startTime = Date.now();
    
    try {
      this.logger.info(`[${this.name}] Making prediction (${requestId})`);
      
      // Preprocess input
      let processedInput = input;
      if (this.preprocessors.length > 0) {
        for (const preprocessor of this.preprocessors) {
          processedInput = await preprocessor.process(processedInput, options);
        }
      }
      
      // Run prediction with timeout
      const predictionPromise = this.modelInstance.predict(processedInput, options);
      const timeoutPromise = new Promise((_, reject) => {
        setTimeout(() => reject(new Error('Prediction timeout')), this.inferenceTimeout);
      });
      
      let prediction = await Promise.race([predictionPromise, timeoutPromise]);
      
      // Postprocess output
      if (this.postprocessors.length > 0) {
        for (const postprocessor of this.postprocessors) {
          prediction = await postprocessor.process(prediction, options);
        }
      }
      
      const duration = Date.now() - startTime;
      this.logger.info(`[${this.name}] Prediction completed in ${duration}ms (${requestId})`);
      
      // Format result
      const result = {
        id: requestId,
        prediction,
        duration,
        timestamp: new Date().toISOString()
      };
      
      // Add to request history
      this.addToHistory({
        id: requestId,
        type: 'prediction',
        input: Array.isArray(input) ? `[Array of ${input.length} items]` : typeof input,
        options,
        status: 'success',
        duration,
        timestamp: new Date().toISOString()
      });
      
      return result;
    } catch (error) {
      const duration = Date.now() - startTime;
      this.logger.error(`[${this.name}] Prediction failed (${requestId}):`, error);
      
      // Add failed request to history
      this.addToHistory({
        id: requestId,
        type: 'prediction',
        input: Array.isArray(input) ? `[Array of ${input.length} items]` : typeof input,
        options,
        status: 'error',
        error: error.message,
        duration,
        timestamp: new Date().toISOString()
      });
      
      throw error;
    }
  }

  /**
   * Make predictions on a batch of inputs
   * @param {Array} inputs - Array of input data
   * @param {Object} [options] - Prediction options
   * @returns {Promise<Array<Object>>} - Array of prediction results
   */
  async batchPredict(inputs, options = {}) {
    if (!this.initialized || !this.running) {
      throw new Error(`[${this.name}] Cannot batch predict: plugin not running`);
    }
    
    if (!Array.isArray(inputs)) {
      throw new Error(`[${this.name}] Batch prediction requires an array of inputs`);
    }
    
    const requestId = uuidv4();
    const startTime = Date.now();
    
    try {
      this.logger.info(`[${this.name}] Making batch prediction with ${inputs.length} inputs (${requestId})`);
      
      // Split inputs into batches
      const batchSize = options.batchSize || this.batchSize;
      const batches = [];
      
      for (let i = 0; i < inputs.length; i += batchSize) {
        batches.push(inputs.slice(i, i + batchSize));
      }
      
      // Process each batch
      const results = [];
      for (let i = 0; i < batches.length; i++) {
        const batch = batches[i];
        this.logger.debug(`[${this.name}] Processing batch ${i+1}/${batches.length} with ${batch.length} inputs`);
        
        // Preprocess batch
        let processedBatch = batch;
        if (this.preprocessors.length > 0) {
          for (const preprocessor of this.preprocessors) {
            processedBatch = await preprocessor.processBatch(processedBatch, options);
          }
        }
        
        // Run prediction
        let predictions;
        if (typeof this.modelInstance.batchPredict === 'function') {
          predictions = await this.modelInstance.batchPredict(processedBatch, options);
        } else {
          // Fall back to individual predictions if batchPredict is not available
          predictions = [];
          for (const item of processedBatch) {
            const prediction = await this.modelInstance.predict(item, options);
            predictions.push(prediction);
          }
        }
        
        // Postprocess batch
        if (this.postprocessors.length > 0) {
          for (const postprocessor of this.postprocessors) {
            predictions = await postprocessor.processBatch(predictions, options);
          }
        }
        
        results.push(...predictions);
      }
      
      const duration = Date.now() - startTime;
      this.logger.info(`[${this.name}] Batch prediction completed in ${duration}ms (${requestId})`);
      
      // Format result
      const result = {
        id: requestId,
        predictions: results,
        count: results.length,
        duration,
        timestamp: new Date().toISOString()
      };
      
      // Add to request history
      this.addToHistory({
        id: requestId,
        type: 'batch-prediction',
        input: `[Array of ${inputs.length} items]`,
        options,
        batchCount: batches.length,
        status: 'success',
        duration,
        timestamp: new Date().toISOString()
      });
      
      return result;
    } catch (error) {
      const duration = Date.now() - startTime;
      this.logger.error(`[${this.name}] Batch prediction failed (${requestId}):`, error);
      
      // Add failed request to history
      this.addToHistory({
        id: requestId,
        type: 'batch-prediction',
        input: `[Array of ${inputs.length} items]`,
        options,
        status: 'error',
        error: error.message,
        duration,
        timestamp: new Date().toISOString()
      });
      
      throw error;
    }
  }

  /**
   * Add a preprocessor to the pipeline
   * @param {Object} preprocessor - Preprocessor with process method
   */
  addPreprocessor(preprocessor) {
    if (!preprocessor || typeof preprocessor.process !== 'function') {
      throw new Error(`[${this.name}] Preprocessor must have a process method`);
    }
    
    this.preprocessors.push(preprocessor);
    this.logger.info(`[${this.name}] Added preprocessor to pipeline (total: ${this.preprocessors.length})`);
  }

  /**
   * Add a postprocessor to the pipeline
   * @param {Object} postprocessor - Postprocessor with process method
   */
  addPostprocessor(postprocessor) {
    if (!postprocessor || typeof postprocessor.process !== 'function') {
      throw new Error(`[${this.name}] Postprocessor must have a process method`);
    }
    
    this.postprocessors.push(postprocessor);
    this.logger.info(`[${this.name}] Added postprocessor to pipeline (total: ${this.postprocessors.length})`);
  }

  /**
   * Get model information
   * @returns {Object} - Model information
   */
  getModelInfo() {
    const info = {
      modelType: this.modelType,
      modelPath: this.modelPath,
      isLoaded: !!this.modelInstance,
      preprocessors: this.preprocessors.length,
      postprocessors: this.postprocessors.length
    };
    
    // Add model-specific information if available
    if (this.modelInstance && typeof this.modelInstance.getMetadata === 'function') {
      info.metadata = this.modelInstance.getMetadata();
    }
    
    return info;
  }

  /**
   * Add a request to the history
   * @private
   * @param {Object} entry - History entry
   */
  addToHistory(entry) {
    this.requestHistory.unshift(entry);
    
    // Trim history if it exceeds max size
    if (this.requestHistory.length > this.maxHistorySize) {
      this.requestHistory = this.requestHistory.slice(0, this.maxHistorySize);
    }
  }

  /**
   * Get request history
   * @param {number} [limit] - Maximum number of entries to return
   * @returns {Array} - Request history
   */
  getRequestHistory(limit) {
    const count = limit && limit > 0 ? Math.min(limit, this.requestHistory.length) : this.requestHistory.length;
    return this.requestHistory.slice(0, count);
  }

  /**
   * Get plugin status
   * @returns {Object} - Status information
   */
  getStatus() {
    return {
      name: this.name,
      version: this.version,
      description: this.description,
      initialized: this.initialized,
      running: this.running || false,
      modelInfo: this.getModelInfo(),
      requestsProcessed: this.requestHistory.length,
      lastRequestTimestamp: this.requestHistory[0]?.timestamp || null,
      timestamp: new Date().toISOString()
    };
  }
}

module.exports = SafeguardGenericMLPlugin;
```


```json
{
  "name": "safeguard-generic-ml-plugin",
  "version": "1.0.0",
  "description": "Generic ML template for Safeguard plugins",
  "main": "index.js",
  "scripts": {
    "test": "jest",
    "lint": "eslint ."
  },
  "keywords": [
    "safeguard",
    "plugin",
    "template",
    "ml",
    "machine-learning",
    "ai",
    "tensorflow",
    "onnx",
    "pytorch"
  ],
  "author": "Autonomy Association International, Inc.",
  "license": "PROPRIETARY",
  "copyright": "Copyright 2025 Autonomy Association International Inc., all rights reserved.",
  "dependencies": {
    "uuid": "^9.0.1"
  },
  "optionalDependencies": {
    "@tensorflow/tfjs-node": "^4.10.0",
    "onnxruntime-node": "^1.15.1"
  },
  "devDependencies": {
    "eslint": "^8.52.0",
    "jest": "^29.0.0"
  },
  "engines": {
    "node": ">=16.0.0",
    "npm": ">=8.0.0"
  }
}
```


```markdown
# Safeguard Generic ML Plugin Template

This template provides a structure for creating a Safeguard plugin that integrates with machine learning models for inference and prediction. It supports various ML frameworks like TensorFlow.js, ONNX Runtime, and custom model implementations.

## Features

- Flexible model loading for different ML frameworks
- Preprocessing and postprocessing pipeline
- Batch prediction support
- Inference timeout protection
- Request history tracking
- Comprehensive error handling and logging

## Prerequisites

- Node.js 16.x or higher
- NPM 8.x or higher
- ML framework of your choice (TensorFlow.js, ONNX Runtime, etc.)

## Usage

1. Clone this template
2. Install dependencies with `npm install`
3. Install specific ML framework dependencies (e.g., `npm install @tensorflow/tfjs-node`)
4. Configure the model path and type
5. Add custom preprocessors and postprocessors if needed
6. Initialize and use the plugin in your application

## Configuration Options

- `modelPath`: Path to the ML model file or directory
- `modelType`: Type of model ('tensorflow', 'onnx', 'pytorch', 'custom', 'generic')
- `modelConfig`: Additional configuration for the model
- `preprocessors`: Array of preprocessor objects with `process` method
- `postprocessors`: Array of postprocessor objects with `process` method
- `inferenceTimeout`: Timeout for inference in milliseconds (default: 30000)
- `batchSize`: Default batch size for batch predictions (default: 1)
- `maxHistorySize`: Maximum number of requests to keep in history (default: 100)
- `customModelLoader`: Function to load a custom model (required for 'custom' model type)

## Supported Model Types

- **TensorFlow.js**: Load and run TensorFlow.js models
- **ONNX**: Load and run ONNX Runtime models
- **PyTorch**: Load PyTorch models exported to ONNX format
- **Custom**: Load custom model implementations
- **Generic**: Placeholder for custom implementations

## Preprocessor and Postprocessor

Create custom data processors to transform inputs before prediction and outputs after prediction:

```javascript
const imagePreprocessor = {
  process: async (input, options) => {
    // Normalize image data
    return input.map(pixel => pixel / 255.0);
  },
  processBatch: async (batch, options) => {
    // Process a batch of images
    return batch.map(image => image.map(pixel => pixel / 255.0));
  }
};

plugin.addPreprocessor(imagePreprocessor);

const confidencePostprocessor = {
  process: async (prediction, options) => {
    // Only return predictions with confidence above threshold
    const threshold = options.confidenceThreshold || 0.5;
    return {
      ...prediction,
      results: prediction.results.filter(r => r.confidence >= threshold)
    };
  }
};

plugin.addPostprocessor(confidencePostprocessor);
```
```


## Example

```javascript
const SafeguardGenericMLPlugin = require('./index');
const tf = require('@tensorflow/tfjs-node');

// Create a TensorFlow.js model
async function createModel() {
  const model = tf.sequential();
  model.add(tf.layers.dense({ units: 1, inputShape: [10] }));
  model.compile({ loss: 'meanSquaredError', optimizer: 'sgd' });
  
  // Save model to a directory
  await model.save('file://./model');
  return './model';
}

// Create custom preprocessor
const normalizer = {
  process: async (input) => {
    return tf.tensor2d([input]).div(tf.scalar(100));
  }
};

// Create custom postprocessor
const formatter = {
  process: async (prediction) => {
    const values = await prediction.array();
    return {
      value: values[0][0],
      scaled: values[0][0] * 100
    };
  }
};

async function run() {
  // Create and save a simple model
  const modelPath = await createModel();
  
  // Create plugin instance
  const plugin = new SafeguardGenericMLPlugin({
    name: 'tensorflow-plugin',
    modelPath,
    modelType: 'tensorflow',
    inferenceTimeout: 5000
  });
  
  // Add processors
  plugin.addPreprocessor(normalizer);
  plugin.addPostprocessor(formatter);
  
  // Initialize and use the plugin
  await plugin.initialize({});
  await plugin.start();
  
  // Make a prediction
  const input = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  const result = await plugin.predict(input);
  
  console.log('Prediction result:', result);
  console.log('Model info:', plugin.getModelInfo());
  
  await plugin.stop();
}

run().catch(console.error);
```


## License

Copyright 2025 Autonomy Association International Inc., all rights reserved.
```
<llm-snippet-file>_safeguard-plugin-system/templates/nodejs/generic-ml/example.js</llm-snippet-file>
```javascript
/**
 * Example usage of the Generic ML Safeguard Plugin
 */

const SafeguardGenericMLPlugin = require('./index');
const path = require('path');

// Example preprocessor for normalizing numerical data
const normalizationPreprocessor = {
  // Initialize can be used to set up the preprocessor
  initialize: async function() {
    this.mean = 0;
    this.stdDev = 1;
    return true;
  },
  
  // Process a single input
  process: async function(input, options) {
    if (Array.isArray(input) && input.every(i => typeof i === 'number')) {
      // Normalize numerical array
      return input.map(val => (val - this.mean) / this.stdDev);
    } else if (typeof input === 'object') {
      // For objects, normalize any numeric arrays found in properties
      const result = { ...input };
      for (const key in result) {
        if (Array.isArray(result[key]) && result[key].every(i => typeof i === 'number')) {
          result[key] = result[key].map(val => (val - this.mean) / this.stdDev);
        }
      }
      return result;
    }
    // Return unchanged if not a format we can process
    return input;
  },
  
  // Process a batch of inputs
  processBatch: async function(inputs, options) {
    return Promise.all(inputs.map(input => this.process(input, options)));
  }
};

// Example postprocessor for formatting results
const formattingPostprocessor = {
  // Process a single prediction result
  process: async function(prediction, options) {
    // Add confidence scores and labels
    if (Array.isArray(prediction)) {
      return prediction.map((val, idx) => ({
        value: val,
        label: `Class ${idx}`,
        confidence: Math.max(0, Math.min(1, val))
      }));
    }
    return prediction;
  },
  
  // Process a batch of prediction results
  processBatch: async function(predictions, options) {
    return Promise.all(predictions.map(pred => this.process(pred, options)));
  }
};

// Custom model loader function for demonstration
async function customModelLoader(modelPath, config) {
  console.log(`Loading custom model from: ${modelPath}`);
  console.log(`With config:`, config);
  
  // This is a mock model for demonstration
  return {
    predict: async (input) => {
      // Simulate model inference
      if (Array.isArray(input)) {
        // For array inputs, return classification-like output
        const sum = input.reduce((a, b) => a + b, 0);
        return [
          0.1 + 0.4 * Math.random(),
          0.2 + 0.3 * Math.random(),
          0.3 + 0.2 * Math.random(),
          0.4 * Math.random()
        ];
      } else if (typeof input === 'object') {
        // For object inputs, return regression-like output
        return {
          prediction: Math.random() * 10,
          uncertainty: Math.random()
        };
      }
      return Math.random(); // Default case
    },
    
    // Batch prediction support
    batchPredict: async (inputs) => {
      return Promise.all(inputs.map(input => ({
        prediction: Math.random() * 10,
        uncertainty: Math.random()
      })));
    },
    
    // Model metadata
    getMetadata: () => {
      return {
        name: "Demo Model",
        version: "1.0",
        inputShape: [10],
        outputShape: [4],
        accuracy: 0.92,
        framework: "Custom",
        trainingDate: "2025-01-15"
      };
    }
  };
}

// Demonstrate the plugin
async function demonstrateGenericMLPlugin() {
  try {
    // Create plugin instance with custom model
    const plugin = new SafeguardGenericMLPlugin({
      name: 'demo-ml-plugin',
      version: '1.0.0',
      description: 'Generic ML Plugin Example',
      modelType: 'custom',
      modelPath: path.join(__dirname, 'models', 'demo-model'),
      modelConfig: {
        threshold: 0.5,
        classes: ['class1', 'class2', 'class3', 'class4']
      },
      customModelLoader: customModelLoader,
      inferenceTimeout: 5000,
      batchSize: 5,
      logger: console
    });
    
    // Add preprocessor and postprocessor
    plugin.addPreprocessor(normalizationPreprocessor);
    plugin.addPostprocessor(formattingPostprocessor);
    
    // Initialize the plugin
    console.log('Initializing Generic ML plugin...');
    await plugin.initialize({
      appContext: { 
        appVersion: '1.0.0',
        environment: 'development'
      }
    });
    
    // Start the plugin
    console.log('\nStarting plugin...');
    await plugin.start();
    
    // Get plugin status
    console.log('\nPlugin status:');
    console.log(JSON.stringify(plugin.getStatus(), null, 2));
    
    // Make a single prediction
    console.log('\nMaking single prediction...');
    const input = [0.5, 1.2, 2.3, 3.4, 4.5, 5.6, 6.7, 7.8, 8.9, 9.0];
    const result = await plugin.predict(input);
    
    console.log('Prediction result:');
    console.log(JSON.stringify(result, null, 2));
    
    // Make a batch prediction
    console.log('\nMaking batch prediction...');
    const batchInputs = [
      { features: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], id: 'sample1' },
      { features: [2, 3, 4, 5, 6, 7, 8, 9, 10, 11], id: 'sample2' },
      { features: [3, 4, 5, 6, 7, 8, 9, 10, 11, 12], id: 'sample3' },
      { features: [4, 5, 6, 7, 8, 9, 10, 11, 12, 13], id: 'sample4' },
      { features: [5, 6, 7, 8, 9, 10, 11, 12, 13, 14], id: 'sample5' },
      { features: [6, 7, 8, 9, 10, 11, 12, 13, 14, 15], id: 'sample6' },
      { features: [7, 8, 9, 10, 11, 12, 13, 14, 15, 16], id: 'sample7' }
    ];
    
    const batchResults = await plugin.batchPredict(batchInputs);
    
    console.log('Batch prediction results:');
    console.log(`Total predictions: ${batchResults.count}`);
    console.log(`Duration: ${batchResults.duration}ms`);
    console.log('First 2 results:');
    console.log(JSON.stringify(batchResults.predictions.slice(0, 2), null, 2));
    
    // Get model information
    console.log('\nModel information:');
    console.log(JSON.stringify(plugin.getModelInfo(), null, 2));
    
    // Get request history
    console.log('\nRequest history:');
    const history = plugin.getRequestHistory(5);
    console.log(JSON.stringify(history, null, 2));
    
    // Stop the plugin
    console.log('\nStopping plugin...');
    await plugin.stop();
    
    // Final status
    console.log('\nFinal plugin status:');
    console.log(JSON.stringify(plugin.getStatus(), null, 2));
    
  } catch (error) {
    console.error('Error in Generic ML demonstration:', error);
  }
}

// Run the demonstration
demonstrateGenericMLPlugin();
```
```


## Python Templates

### 1. Basic Python Template

```textmate
"""
Basic Safeguard Plugin Template

This template provides a minimal structure for creating a Safeguard plugin in Python.
It includes basic lifecycle methods and configuration handling.

Copyright 2025 Autonomy Association International Inc., all rights reserved.
"""

import logging
import uuid
import json
from datetime import datetime
from typing import Dict, Any, Optional, List, Union

class SafeguardBasicPlugin:
    """
    Basic template for a Safeguard plugin.
    
    This class provides a foundation for building Safeguard plugins with Python.
    It includes the core lifecycle methods and configuration handling.
    """
    
    def __init__(self, config: Dict[str, Any] = None):
        """
        Initialize the plugin with configuration.
        
        Args:
            config: Dictionary containing plugin configuration
        """
        self.name = config.get('name', 'basic-python-plugin')
        self.version = config.get('version', '1.0.0')
        self.description = config.get('description', 'Basic Safeguard Python Plugin')
        self.config = config or {}
        self.initialized = False
        self.running = False
        
        # Configure logging
        self.logger = self._setup_logging()
        self.logger.info(f"[{self.name}] Plugin instance created")
    
    def _setup_logging(self) -> logging.Logger:
        """
        Set up the plugin's logger.
        
        Returns:
            Logger instance
        """
        logger = logging.getLogger(f"safeguard.plugin.{self.name}")
        if not logger.handlers:
            handler = logging.StreamHandler()
            formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
            handler.setFormatter(formatter)
            logger.addHandler(handler)
            logger.setLevel(self.config.get('log_level', logging.INFO))
        return logger
    
    async def initialize(self, context: Dict[str, Any]) -> bool:
        """
        Initialize the plugin.
        
        Args:
            context: Initialization context
            
        Returns:
            True if initialization successful, False otherwise
        """
        try:
            self.logger.info(f"[{self.name}] Initializing plugin v{self.version}")
            self.context = context
            self.initialized = True
            return True
        except Exception as e:
            self.logger.error(f"[{self.name}] Initialization failed: {str(e)}")
            return False
    
    async def start(self) -> bool:
        """
        Start the plugin.
        
        Returns:
            True if start successful, False otherwise
        """
        if not self.initialized:
            self.logger.error(f"[{self.name}] Cannot start: plugin not initialized")
            return False
        
        try:
            self.logger.info(f"[{self.name}] Starting plugin...")
            # Add your plugin start logic here
            self.running = True
            return True
        except Exception as e:
            self.logger.error(f"[{self.name}] Start failed: {str(e)}")
            return False
    
    async def stop(self) -> bool:
        """
        Stop the plugin.
        
        Returns:
            True if stop successful, False otherwise
        """
        if not self.running:
            self.logger.info(f"[{self.name}] Plugin already stopped")
            return True
        
        try:
            self.logger.info(f"[{self.name}] Stopping plugin...")
            # Add your plugin stop logic here
            self.running = False
            return True
        except Exception as e:
            self.logger.error(f"[{self.name}] Stop failed: {str(e)}")
            return False
    
    async def process_data(self, data: Any) -> Dict[str, Any]:
        """
        Process incoming data.
        
        Args:
            data: Data to process
            
        Returns:
            Processing result
        """
        if not self.running:
            raise RuntimeError(f"[{self.name}] Cannot process data: plugin not running")
        
        try:
            # Add your data processing logic here
            return {
                'success': True,
                'result': data,
                'timestamp': datetime.utcnow().isoformat()
            }
        except Exception as e:
            self.logger.error(f"[{self.name}] Data processing failed: {str(e)}")
            raise
    
    def get_status(self) -> Dict[str, Any]:
        """
        Get plugin status.
        
        Returns:
            Status information
        """
        return {
            'name': self.name,
            'version': self.version,
            'description': self.description,
            'initialized': self.initialized,
            'running': self.running,
            'timestamp': datetime.utcnow().isoformat()
        }
    
    def to_json(self) -> str:
        """
        Convert plugin status to JSON.
        
        Returns:
            JSON string representation of plugin status
        """
        return json.dumps(self.get_status())


# Example usage
if __name__ == "__main__":
    async def run_example():
        # Create plugin instance
        plugin = SafeguardBasicPlugin({
            'name': 'example-plugin',
            'version': '1.0.0',
            'description': 'Example Python Safeguard Plugin'
        })
        
        # Initialize and start
        await plugin.initialize({})
        await plugin.start()
        
        # Process data
        result = await plugin.process_data({"test": "data"})
        print(f"Processing result: {result}")
        
        # Get status
        status = plugin.get_status()
        print(f"Plugin status: {status}")
        
        # Stop the plugin
        await plugin.stop()
    
    import asyncio
    asyncio.run(run_example())
```


```
# Basic requirements for the Safeguard Basic Plugin
pydantic>=2.0.0
aiohttp>=3.8.5
```


```markdown
# Safeguard Basic Python Plugin Template

This template provides a minimal structure for creating a Safeguard plugin in Python. It includes basic lifecycle methods and configuration handling.

## Features

- Simple plugin lifecycle management (initialize, start, stop)
- Configuration handling
- Basic error handling
- Status reporting
- Async/await support

## Usage

1. Clone this template
2. Install dependencies with `pip install -r requirements.txt`
3. Modify the plugin implementation in `plugin.py` to add your custom functionality
4. Test your plugin

## Plugin Lifecycle

1. **Constructor**: Sets up plugin configuration
2. **Initialize**: Prepare the plugin for operation
3. **Start**: Begin active operation
4. **Stop**: Cease operation and clean up resources

## Example
```
python
import asyncio
from plugin import SafeguardBasicPlugin

async def run():
# Create plugin instance
plugin = SafeguardBasicPlugin({
'name': 'my-custom-plugin',
'version': '1.0.0',
'description': 'My custom Safeguard plugin'
})

    # Initialize and use the plugin
    await plugin.initialize({})
    await plugin.start()
    
    result = await plugin.process_data({"test": "data"})
    print(f"Processing result: {result}")
    
    await plugin.stop()

# Run the example
asyncio.run(run())
```
## Extending the Plugin

To extend the functionality of the basic plugin, subclass `SafeguardBasicPlugin` and override the methods you want to customize:
```
python
from plugin import SafeguardBasicPlugin

class MyCustomPlugin(SafeguardBasicPlugin):
async def initialize(self, context):
# Add custom initialization logic
result = await super().initialize(context)

        # Additional setup
        self.custom_data = {}
        
        return result
    
    async def process_data(self, data):
        # Custom data processing
        processed = await super().process_data(data)
        
        # Add additional processing
        processed['custom_field'] = 'custom value'
        
        return processed
```
## License

Copyright 2025 Autonomy Association International Inc., all rights reserved.
```


```textmate
"""
Example usage of the Basic Safeguard Plugin
"""

import asyncio
import logging
from datetime import datetime
from plugin import SafeguardBasicPlugin

# Configure root logger
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)

async def demonstrate_plugin():
    """
    Demonstrate the basic plugin functionality
    """
    try:
        # Create plugin instance with custom configuration
        plugin = SafeguardBasicPlugin({
            'name': 'example-plugin',
            'version': '1.0.0',
            'description': 'Example Safeguard Plugin',
            'log_level': logging.DEBUG
        })
        
        # Initialize the plugin
        print("Initializing plugin...")
        init_result = await plugin.initialize({
            'app_context': {
                'app_version': '1.0.0',
                'environment': 'development'
            }
        })
        print(f"Initialization result: {init_result}")
        
        # Start the plugin
        print("\nStarting plugin...")
        start_result = await plugin.start()
        print(f"Start result: {start_result}")
        
        # Get plugin status
        print("\nPlugin status:")
        print(plugin.to_json())
        
        # Process some data
        print("\nProcessing data...")
        sample_data = {
            'id': '12345',
            'timestamp': datetime.utcnow().isoformat(),
            'value': 42,
            'metadata': {
                'source': 'example',
                'priority': 'normal'
            }
        }
        
        process_result = await plugin.process_data(sample_data)
        print(f"Process result: {process_result}")
        
        # Stop the plugin
        print("\nStopping plugin...")
        stop_result = await plugin.stop()
        print(f"Stop result: {stop_result}")
        
        # Final status
        print("\nFinal plugin status:")
        print(plugin.to_json())
        
    except Exception as e:
        print(f"Error in plugin demonstration: {e}")

# Run the demonstration
if __name__ == "__main__":
    asyncio.run(demonstrate_plugin())
```


### 2. API Client Python Template

```textmate
"""
API Client Safeguard Plugin Template

This template provides a structure for creating a Safeguard plugin in Python
that interacts with external APIs.

Copyright 2025 Autonomy Association International Inc., all rights reserved.
"""

import logging
import uuid
import json
import asyncio
import time
from datetime import datetime
from typing import Dict, Any, Optional, List, Union, Callable
import aiohttp
from pydantic import BaseModel

class RequestInfo(BaseModel):
    """
    Information about an API request
    """
    request_id: str
    method: str
    url: str
    timestamp: datetime
    headers: Optional[Dict] = None
    params: Optional[Dict] = None
    data: Optional[Any] = None

class ResponseInfo(BaseModel):
    """
    Information about an API response
    """
    request_id: str
    status: int
    duration: float
    timestamp: datetime
    headers: Optional[Dict] = None
    size: Optional[int] = None
    error: Optional[str] = None

class SafeguardApiClientPlugin:
    """
    API Client template for a Safeguard plugin.
    
    This class provides a foundation for building Safeguard plugins that interact with external APIs.
    It includes robust HTTP client functionality with retry logic, request/response tracking, and queue management.
    """
    
    def __init__(self, config: Dict[str, Any] = None):
        """
        Initialize the plugin with configuration.
        
        Args:
            config: Dictionary containing plugin configuration
        """
        config = config or {}
        self.name = config.get('name', 'api-client-plugin')
        self.version = config.get('version', '1.0.0')
        self.description = config.get('description', 'API Client Safeguard Plugin')
        self.config = config
        self.initialized = False
        self.running = False
        
        # API client specific configuration
        self.base_url = config.get('base_url', 'https://api.example.com')
        self.timeout = config.get('timeout', 30)  # 30 seconds default
        self.headers = config.get('headers', {})
        self.retry_count = config.get('retry_count', 3)
        self.request_queue = asyncio.Queue()
        self.request_map = {}
        self.request_history = []
        self.max_history_size = config.get('max_history_size', 100)
        
        # Configure logging
        self.logger = self._setup_logging()
        self.logger.info(f"[{self.name}] Plugin instance created")
        
        # HTTP session will be created during initialization
        self.session = None
    
    def _setup_logging(self) -> logging.Logger:
        """
        Set up the plugin's logger.
        
        Returns:
            Logger instance
        """
        logger = logging.getLogger(f"safeguard.plugin.{self.name}")
        if not logger.handlers:
            handler = logging.StreamHandler()
            formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
            handler.setFormatter(formatter)
            logger.addHandler(handler)
            logger.setLevel(self.config.get('log_level', logging.INFO))
        return logger
    
    async def initialize(self, context: Dict[str, Any]) -> bool:
        """
        Initialize the plugin.
        
        Args:
            context: Initialization context
            
        Returns:
            True if initialization successful, False otherwise
        """
        try:
            self.logger.info(f"[{self.name}] Initializing plugin v{self.version}")
            self.context = context
            
            # Create HTTP session
            timeout = aiohttp.ClientTimeout(total=self.timeout)
            self.session = aiohttp.ClientSession(
                timeout=timeout,
                headers={
                    'Content-Type': 'application/json',
                    'User-Agent': f'Safeguard-Plugin/{self.name}/{self.version}',
                    **self.headers
                }
            )
            
            # Test connection to API
            if self.config.get('test_connection', True):
                try:
                    await self.test_connection()
                    self.logger.info(f"[{self.name}] API connection test successful")
                except Exception as e:
                    self.logger.warning(f"[{self.name}] API connection test failed: {str(e)}")
                    # Continue initialization even if test fails
            
            self.initialized = True
            return True
        except Exception as e:
            self.logger.error(f"[{self.name}] Initialization failed: {str(e)}")
            return False
    
    async def test_connection(self) -> Dict[str, Any]:
        """
        Test connection to the API.
        
        Returns:
            Response from API health check
        """
        # This is a generic implementation - customize for your specific API
        endpoint = self.config.get('health_endpoint', '/health')
        return await self.get(endpoint)
    
    async def start(self) -> bool:
        """
        Start the plugin.
        
        Returns:
            True if start successful, False otherwise
        """
        if not self.initialized:
            self.logger.error(f"[{self.name}] Cannot start: plugin not initialized")
            return False
        
        try:
            self.logger.info(f"[{self.name}] Starting plugin...")
            self.running = True
            
            # Start the queue processor
            self.queue_processor_task = asyncio.create_task(self._process_queue())
            
            return True
        except Exception as e:
            self.logger.error(f"[{self.name}] Start failed: {str(e)}")
            return False
    
    async def stop(self) -> bool:
        """
        Stop the plugin.
        
        Returns:
            True if stop successful, False otherwise
        """
        if not self.running:
            self.logger.info(f"[{self.name}] Plugin already stopped")
            return True
        
        try:
            self.logger.info(f"[{self.name}] Stopping plugin...")
            self.running = False
            
            # Cancel queue processor task
            if hasattr(self, 'queue_processor_task'):
                self.queue_processor_task.cancel()
                try:
                    await self.queue_processor_task
                except asyncio.CancelledError:
                    pass
            
            # Close HTTP session
            if self.session and not self.session.closed:
                await self.session.close()
            
            # Clear request map and history
            self.request_map = {}
            
            return True
        except Exception as e:
            self.logger.error(f"[{self.name}] Stop failed: {str(e)}")
            return False
    
    async def _process_queue(self):
        """
        Process the request queue.
        """
        while self.running:
            try:
                # Get request from queue with timeout
                try:
                    request = await asyncio.wait_for(self.request_queue.get(), timeout=1.0)
                except asyncio.TimeoutError:
                    continue
                
                # Process request
                try:
                    result = await self._execute_request(
                        request['method'],
                        request['url'],
                        headers=request.get('headers'),
                        params=request.get('params'),
                        data=request.get('data'),
                        timeout=request.get('timeout')
                    )
                    if request.get('future'):
                        request['future'].set_result(result)
                except Exception as e:
                    if request.get('future'):
                        request['future'].set_exception(e)
                finally:
                    self.request_queue.task_done()
            except asyncio.CancelledError:
                break
            except Exception as e:
                self.logger.error(f"[{self.name}] Error in queue processor: {str(e)}")
                await asyncio.sleep(1)  # Prevent tight loop in case of recurring errors
    
    async def _execute_request(
        self,
        method: str,
        url: str,
        headers: Dict[str, str] = None,
        params: Dict[str, Any] = None,
        data: Any = None,
        timeout: float = None
    ) -> Dict[str, Any]:
        """
        Execute an HTTP request with retry logic.
        
        Args:
            method: HTTP method (GET, POST, etc.)
            url: Request URL
            headers: Request headers
            params: Query parameters
            data: Request data
            timeout: Request timeout in seconds
            
        Returns:
            Response data
        """
        retries = 0
        last_error = None
        request_id = str(uuid.uuid4())
        
        # Record request info
        self.request_map[request_id] = RequestInfo(
            request_id=request_id,
            method=method,
            url=url,
            timestamp=datetime.utcnow(),
            headers=headers,
            params=params,
            data=data if not isinstance(data, (dict, list)) else "[data]"
        )
        
        # Ensure URL is absolute
        if not url.startswith(('http://', 'https://')):
            url = f"{self.base_url.rstrip('/')}/{url.lstrip('/')}"
        
        while retries <= self.retry_count:
            start_time = time.time()
            
            try:
                self.logger.debug(f"[{self.name}] API Request ({request_id}): {method} {url}")
                
                timeout_obj = aiohttp.ClientTimeout(total=timeout or self.timeout)
                
                async with self.session.request(
                    method=method,
                    url=url,
                    headers=headers,
                    params=params,
                    json=data if isinstance(data, (dict, list)) else None,
                    data=data if not isinstance(data, (dict, list)) else None,
                    timeout=timeout_obj
                ) as response:
                    duration = time.time() - start_time
                    
                    # Record response info
                    response_info = ResponseInfo(
                        request_id=request_id,
                        status=response.status,
                        duration=duration,
                        timestamp=datetime.utcnow(),
                        headers=dict(response.headers),
                        size=int(response.headers.get('Content-Length', 0)) if 'Content-Length' in response.headers else None
                    )
                    
                    # Add to history
                    self._add_to_history({
                        'request': self.request_map[request_id].dict(),
                        'response': response_info.dict(),
                        'timestamp': datetime.utcnow().isoformat()
                    })
                    
                    # Log response
                    self.logger.debug(f"[{self.name}] API Response ({request_id}): {response.status} ({duration:.2f}s)")
                    
                    # Handle HTTP errors
                    if response.status >= 400:
                        text = await response.text()
                        error_msg = f"HTTP {response.status}: {text}"
                        
                        # Determine if we should retry based on status code
                        if response.status in (429, 500, 502, 503, 504) and retries < self.retry_count:
                            retries += 1
                            delay = self._calculate_retry_delay(retries)
                            self.logger.warning(
                                f"[{self.name}] Request failed with {response.status}, "
                                f"retrying ({retries}/{self.retry_count}) in {delay:.2f}s: {error_msg}"
                            )
                            await asyncio.sleep(delay)
                            continue
                        
                        raise aiohttp.ClientResponseError(
                            request_info=response.request_info,
                            history=response.history,
                            status=response.status,
                            message=error_msg,
                            headers=response.headers
                        )
                    
                    # Parse response based on content type
                    content_type = response.headers.get('Content-Type', '')
                    if 'application/json' in content_type:
                        return await response.json()
                    else:
                        return {
                            'text': await response.text(),
                            'status': response.status,
                            'headers': dict(response.headers)
                        }
            
            except (aiohttp.ClientConnectorError, aiohttp.ServerDisconnectedError, asyncio.TimeoutError) as e:
                duration = time.time() - start_time
                last_error = e
                
                # Record error response
                response_info = ResponseInfo(
                    request_id=request_id,
                    status=0,
                    duration=duration,
                    timestamp=datetime.utcnow(),
                    error=str(e)
                )
                
                # Add to history
                self._add_to_history({
                    'request': self.request_map[request_id].dict(),
                    'response': response_info.dict(),
                    'timestamp': datetime.utcnow().isoformat()
                })
                
                if retries < self.retry_count:
                    retries += 1
                    delay = self._calculate_retry_delay(retries)
                    self.logger.warning(
                        f"[{self.name}] Network error, retrying ({retries}/{self.retry_count}) "
                        f"in {delay:.2f}s: {str(e)}"
                    )
                    await asyncio.sleep(delay)
                else:
                    # Clean up request map
                    if request_id in self.request_map:
                        del self.request_map[request_id]
                    raise
            
            except Exception as e:
                duration = time.time() - start_time
                last_error = e
                
                # Record error response
                response_info = ResponseInfo(
                    request_id=request_id,
                    status=0,
                    duration=duration,
                    timestamp=datetime.utcnow(),
                    error=str(e)
                )
                
                # Add to history
                self._add_to_history({
                    'request': self.request_map[request_id].dict(),
                    'response': response_info.dict(),
                    'timestamp': datetime.utcnow().isoformat()
                })
                
                # Clean up request map
                if request_id in self.request_map:
                    del self.request_map[request_id]
                raise
        
        # Clean up request map
        if request_id in self.request_map:
            del self.request_map[request_id]
        
        # If we've exhausted retries, raise the last error
        raise last_error
    
    def _calculate_retry_delay(self, retry_count: int) -> float:
        """
        Calculate retry delay with exponential backoff.
        
        Args:
            retry_count: Current retry count
            
        Returns:
            Delay in seconds
        """
        base_delay = 1.0  # 1 second
        max_delay = 30.0  # 30 seconds
        delay = min(max_delay, base_delay * (2 ** (retry_count - 1)))
        
        # Add jitter to prevent synchronized retries
        jitter = delay * 0.2 * (0.5 - (time.time() % 1))  # ±10% jitter
        return delay + jitter
    
    def _add_to_history(self, entry: Dict[str, Any]):
        """
        Add a request/response pair to the history.
        
        Args:
            entry: History entry
        """
        self.request_history.append(entry)
        
        # Trim history if it exceeds max size
        if len(self.request_history) > self.max_history_size:
            self.request_history = self.request_history[-self.max_history_size:]
    
    async def get(self, url: str, params: Dict[str, Any] = None, headers: Dict[str, str] = None, timeout: float = None) -> Dict[str, Any]:
        """
        Perform a GET request.
        
        Args:
            url: Request URL
            params: Query parameters
            headers: Request headers
            timeout: Request timeout in seconds
            
        Returns:
            Response data
        """
        return await self.request('GET', url, headers=headers, params=params, timeout=timeout)
    
    async def post(self, url: str, data: Any = None, params: Dict[str, Any] = None, headers: Dict[str, str] = None, timeout: float = None) -> Dict[str, Any]:
        """
        Perform a POST request.
        
        Args:
            url: Request URL
            data: Request data
            params: Query parameters
            headers: Request headers
            timeout: Request timeout in seconds
            
        Returns:
            Response data
        """
        return await self.request('POST', url, data=data, headers=headers, params=params, timeout=timeout)
    
    async def put(self, url: str, data: Any = None, params: Dict[str, Any] = None, headers: Dict[str, str] = None, timeout: float = None) -> Dict[str, Any]:
        """
        Perform a PUT request.
        
        Args:
            url: Request URL
            data: Request data
            params: Query parameters
            headers: Request headers
            timeout: Request timeout in seconds
            
        Returns:
            Response data
        """
        return await self.request('PUT', url, data=data, headers=headers, params=params, timeout=timeout)
    
    async def patch(self, url: str, data: Any = None, params: Dict[str, Any] = None, headers: Dict[str, str] = None, timeout: float = None) -> Dict[str, Any]:
        """
        Perform a PATCH request.
        
        Args:
            url: Request URL
            data: Request data
            params: Query parameters
            headers: Request headers
            timeout: Request timeout in seconds
            
        Returns:
            Response data
        """
        return await self.request('PATCH', url, data=data, headers=headers, params=params, timeout=timeout)
    
    async def delete(self, url: str, params: Dict[str, Any] = None, headers: Dict[str, str] = None, timeout: float = None) -> Dict[str, Any]:
        """
        Perform a DELETE request.
        
        Args:
            url: Request URL
            params: Query parameters
            headers: Request headers
            timeout: Request timeout in seconds
            
        Returns:
            Response data
        """
        return await self.request('DELETE', url, headers=headers, params=params, timeout=timeout)
    
    async def request(self, method: str, url: str, data: Any = None, headers: Dict[str, str] = None, params: Dict[str, Any] = None, timeout: float = None) -> Dict[str, Any]:
        """
        Perform an HTTP request.
        
        Args:
            method: HTTP method (GET, POST, etc.)
            url: Request URL
            data: Request data
            headers: Request headers
            params: Query parameters
            timeout: Request timeout in seconds
            
        Returns:
            Response data
        """
        if not self.initialized:
            raise RuntimeError(f"[{self.name}] Cannot make request: plugin not initialized")
        
        if self.running:
            return await self._execute_request(method, url, headers, params, data, timeout)
        else:
            # Queue request if not running
            future = asyncio.get_event_loop().create_future()
            await self.request_queue.put({
                'method': method,
                'url': url,
                'headers': headers,
                'params': params,
                'data': data,
                'timeout': timeout,
                'future': future
            })
            return await future
    
    def get_request_history(self, limit: int = None) -> List[Dict[str, Any]]:
        """
        Get request history.
        
        Args:
            limit: Maximum number of entries to return
            
        Returns:
            Request history
        """
        if limit is not None and limit > 0:
            return self.request_history[-limit:]
        return self.request_history
    
    def get_status(self) -> Dict[str, Any]:
        """
        Get plugin status.
        
        Returns:
            Status information
        """
        return {
            'name': self.name,
            'version': self.version,
            'description': self.description,
            'initialized': self.initialized,
            'running': self.running,
            'base_url': self.base_url,
            'pending_requests': self.request_queue.qsize(),
            'active_requests': len(self.request_map),
            'request_history_size': len(self.request_history),
            'timestamp': datetime.utcnow().isoformat()
        }
    
    def to_json(self) -> str:
        """
        Convert plugin status to JSON.
        
        Returns:
            JSON string representation of plugin status
        """
        return json.dumps(self.get_status())


# Example usage
if __name__ == "__main__":
    async def run_example():
        # Create plugin instance
        plugin = SafeguardApiClientPlugin({
            'name': 'example-api-client',
            'base_url': 'https://jsonplaceholder.typicode.com',
            'timeout': 10
        })
        
        # Initialize and start
        await plugin.initialize({})
        await plugin.start()
        
        try:
            # Make API requests
            posts = await plugin.get('/posts')
            print(f"Got {len(posts)} posts")
            
            user = await plugin.get('/users/1')
            print(f"User: {user['name']}")
            
            new_post = await plugin.post('/posts', {
                'title': 'Safeguard API Client',
                'body': 'Testing the API client plugin',
                'userId': 1
            })
            print(f"Created new post with ID: {new_post['id']}")
        
        except Exception as e:
            print(f"API request error: {e}")
        
        # Get status
        status = plugin.get_status()
        print(f"Plugin status: {status}")
        
        # Get request history
        history = plugin.get_request_history(5)
        print(f"Request history (last 5): {len(history)} entries")
        
        # Stop the plugin
        await plugin.stop()
    
    asyncio.run(run_example())
```


```
# Requirements for the Safeguard API Client Plugin
pydantic>=2.0.0
aiohttp>=3.8.5
```


```markdown
# Safeguard API Client Python Plugin Template

This template provides a structure for creating a Safeguard plugin in Python that interacts with external APIs. It includes robust HTTP client functionality with retry logic, request/response tracking, and queue management.

## Features

- Full HTTP methods support (GET, POST, PUT, PATCH, DELETE)
- Automatic retry with exponential backoff
- Request and response logging
- Connection testing
- Request queuing when plugin is not running
- Request history tracking
- Comprehensive error handling
- Async/await support

## Usage

1. Clone this template
2. Install dependencies with `pip install -r requirements.txt`
3. Modify the configuration and API endpoints in `plugin.py` to match your target API
4. Test your plugin

## Configuration Options

- `base_url`: Base URL for the API (default: 'https://api.example.com')
- `timeout`: Request timeout in seconds (default: 30)
- `headers`: Custom HTTP headers to include in requests
- `retry_count`: Maximum number of retry attempts (default: 3)
- `test_connection`: Whether to test the API connection during initialization (default: True)
- `health_endpoint`: Endpoint to use for connection testing (default: '/health')
- `max_history_size`: Maximum number of request/response pairs to keep in history (default: 100)

## Example
```
python
import asyncio
from plugin import SafeguardApiClientPlugin

async def run():
# Create plugin instance
plugin = SafeguardApiClientPlugin({
'name': 'weather-api-plugin',
'base_url': 'https://api.weather.example.com',
'headers': {
'API-Key': 'your-api-key'
}
})

    # Initialize and use the plugin
    await plugin.initialize({})
    await plugin.start()
    
    try:
        # Make API requests
        forecast = await plugin.get('/forecast', params={
            'location': 'New York',
            'days': 5
        })
        print(f"Weather forecast: {forecast}")
        
        result = await plugin.post('/alerts/subscribe', {
            'location': 'New York',
            'events': ['severe-weather', 'flooding']
        })
        print(f"Alert subscription result: {result}")
    except Exception as e:
        print(f"API error: {e}")
    
    # Get request history
    history = plugin.get_request_history(5)
    print(f"Last 5 requests: {history}")
    
    await plugin.stop()

# Run the example
asyncio.run(run())
```
## Error Handling

The API client includes built-in error handling with automatic retries for certain failure types:

- Network errors (connection failures, timeouts)
- Server errors (HTTP 500, 502, 503, 504)
- Rate limiting (HTTP 429)

For other errors, the exception will be raised to the caller for handling.

## Extending the Plugin

To extend the functionality of the API client plugin, subclass `SafeguardApiClientPlugin` and override the methods you want to customize:
```
python
from plugin import SafeguardApiClientPlugin

class MyApiPlugin(SafeguardApiClientPlugin):
async def initialize(self, context):
# Add custom initialization logic
result = await super().initialize(context)

        # Set up API authentication
        auth_result = await self.authenticate()
        if not auth_result:
            return False
        
        return result
    
    async def authenticate(self):
        # Implement authentication logic
        try:
            auth_response = await self.post('/auth/token', {
                'username': self.config.get('username'),
                'password': self.config.get('password')
            })
            
            if 'token' in auth_response:
                # Update headers with auth token
                self.headers['Authorization'] = f"Bearer {auth_response['token']}"
                self.session.headers.update(self.headers)
                return True
            return False
        except Exception as e:
            self.logger.error(f"Authentication failed: {e}")
            return False
```
## License

Copyright 2025 Autonomy Association International Inc., all rights reserved.
```


```textmate
"""
Example usage of the API Client Safeguard Plugin
"""

import asyncio
import logging
from datetime import datetime
from plugin import SafeguardApiClientPlugin

# Configure root logger
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)

async def demonstrate_api_client():
    """
    Demonstrate the API client plugin functionality
    """
    try:
        # Create plugin instance with custom configuration
        plugin = SafeguardApiClientPlugin({
            'name': 'weather-api-plugin',
            'version': '1.0.0',
            'description': 'Weather API Client Example',
            'base_url': 'https://api.weatherapi.example.com',
            'headers': {
                'API-Key': 'your-api-key-here'
            },
            'timeout': 10,
            'retry_count': 2,
            'health_endpoint': '/v1/current.json',  # Mock health endpoint
            'log_level': logging.DEBUG
        })
        
        # Initialize the plugin
        print("Initializing API client plugin...")
        await plugin.initialize({
            'app_context': {
                'app_version': '1.0.0',
                'environment': 'development'
            }
        })
        
        # Start the plugin
        print("\nStarting plugin...")
        await plugin.start()
        
        # Get plugin status
```
I'll continue creating the complete templates for the Safeguard Plugin System, focusing on completing the remaining Python templates and the example file for the API client.

```textmate
"""
Example usage of the API Client Safeguard Plugin
"""

import asyncio
import logging
from datetime import datetime
from plugin import SafeguardApiClientPlugin

# Configure root logger
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)

async def demonstrate_api_client():
    """
    Demonstrate the API client plugin functionality
    """
    try:
        # Create plugin instance with custom configuration
        plugin = SafeguardApiClientPlugin({
            'name': 'weather-api-plugin',
            'version': '1.0.0',
            'description': 'Weather API Client Example',
            'base_url': 'https://api.weatherapi.example.com',
            'headers': {
                'API-Key': 'your-api-key-here'
            },
            'timeout': 10,
            'retry_count': 2,
            'health_endpoint': '/v1/current.json',  # Mock health endpoint
            'log_level': logging.DEBUG
        })
        
        # Initialize the plugin
        print("Initializing API client plugin...")
        await plugin.initialize({
            'app_context': {
                'app_version': '1.0.0',
                'environment': 'development'
            }
        })
        
        # Start the plugin
        print("\nStarting plugin...")
        await plugin.start()
        
        # Get plugin status
        print("\nPlugin status:")
        print(plugin.to_json())
        
        # Example API requests
        print("\nMaking API requests...")
        
        try:
            # NOTE: These requests will fail unless connected to a real API
            # For demonstration purposes only
            
            # GET request for current weather
            print("\nFetching current weather...")
            current_weather = await plugin.get('/v1/current.json', params={
                'q': 'London',
                'aqi': 'no'
            })
            print(f"Current weather: {current_weather}")
            
            # GET request for forecast
            print("\nFetching weather forecast...")
            forecast = await plugin.get('/v1/forecast.json', params={
                'q': 'New York',
                'days': 3
            })
            print(f"Forecast: {forecast}")
            
            # POST request to subscribe to alerts
            print("\nSubscribing to weather alerts...")
            alert_subscription = await plugin.post('/v1/alerts/subscribe', {
                'locations': ['London', 'New York'],
                'alert_types': ['severe', 'warning'],
                'callback_url': 'https://your-callback-url.example.com/weather-alerts'
            })
            print(f"Alert subscription: {alert_subscription}")
            
        except Exception as e:
            print(f"\nAPI request failed: {e}")
            print("Note: This is expected in this example as we are not connecting to a real API")
        
        # Get request history
        print("\nRequest history:")
        history = plugin.get_request_history(5)
        for entry in history:
            req = entry['request']
            res = entry['response']
            print(f"- {req['method']} {req['url']} -> Status: {res['status']}, Duration: {res['duration']:.2f}s")
        
        # Stop the plugin
        print("\nStopping plugin...")
        await plugin.stop()
        
        # Final status
        print("\nFinal plugin status:")
        print(plugin.to_json())
        
    except Exception as e:
        print(f"Error in API client demonstration: {e}")

# Run the demonstration
if __name__ == "__main__":
    asyncio.run(demonstrate_api_client())
```


### 3. Data Processor Python Template

```textmate
"""
Data Processor Safeguard Plugin Template

This template provides a structure for creating a Safeguard plugin in Python
that processes data streams and performs transformations.

Copyright 2025 Autonomy Association International Inc., all rights reserved.
"""

import logging
import uuid
import json
import asyncio
import time
from datetime import datetime
from typing import Dict, Any, Optional, List, Union, Callable
import traceback

class DataTransformer:
    """
    Base class for data transformers
    """
    async def process(self, data: Any, options: Dict[str, Any] = None) -> Any:
        """
        Process a single data item
        
        Args:
            data: Data to process
            options: Processing options
            
        Returns:
            Processed data
        """
        # Default implementation just passes data through
        return data
    
    async def process_batch(self, batch: List[Any], options: Dict[str, Any] = None) -> List[Any]:
        """
        Process a batch of data items
        
        Args:
            batch: Batch of data to process
            options: Processing options
            
        Returns:
            Processed batch
        """
        # Default implementation processes each item individually
        results = []
        for item in batch:
            result = await self.process(item, options)
            results.append(result)
        return results

class SafeguardDataProcessorPlugin:
    """
    Data Processor template for a Safeguard plugin.
    
    This class provides a foundation for building Safeguard plugins that process data streams
    and perform transformations. It includes a flexible pipeline system and supports both
    synchronous and asynchronous data processing.
    """
    
    def __init__(self, config: Dict[str, Any] = None):
        """
        Initialize the plugin with configuration.
        
        Args:
            config: Dictionary containing plugin configuration
        """
        config = config or {}
        self.name = config.get('name', 'data-processor-plugin')
        self.version = config.get('version', '1.0.0')
        self.description = config.get('description', 'Data Processor Safeguard Plugin')
        self.config = config
        self.initialized = False
        self.running = False
        
        # Data processor specific configuration
        self.processing_enabled = config.get('processing_enabled', True)
        self.batch_size = config.get('batch_size', 100)
        self.processing_interval = config.get('processing_interval', 1.0)  # seconds
        self.max_queue_size = config.get('max_queue_size', 10000)
        self.transformers = config.get('transformers', [])
        self.data_queue = asyncio.Queue(maxsize=self.max_queue_size)
        self.processing = False
        self.metrics = {
            'start_time': None,
            'last_process_time': None,
            'processed_items': 0,
            'errors': 0,
            'average_processing_time': 0,
            'total_processing_time': 0
        }
        
        # Configure logging
        self.logger = self._setup_logging()
        self.logger.info(f"[{self.name}] Plugin instance created")
    
    def _setup_logging(self) -> logging.Logger:
        """
        Set up the plugin's logger.
        
        Returns:
            Logger instance
        """
        logger = logging.getLogger(f"safeguard.plugin.{self.name}")
        if not logger.handlers:
            handler = logging.StreamHandler()
            formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
            handler.setFormatter(formatter)
            logger.addHandler(handler)
            logger.setLevel(self.config.get('log_level', logging.INFO))
        return logger
    
    async def initialize(self, context: Dict[str, Any]) -> bool:
        """
        Initialize the plugin.
        
        Args:
            context: Initialization context
            
        Returns:
            True if initialization successful, False otherwise
        """
        try:
            self.logger.info(f"[{self.name}] Initializing plugin v{self.version}")
            self.context = context
            
            # Set up processing pipeline
            await self._setup_processing_pipeline()
            
            self.initialized = True
            return True
        except Exception as e:
            self.logger.error(f"[{self.name}] Initialization failed: {str(e)}")
            traceback.print_exc()
            return False
    
    async def _setup_processing_pipeline(self):
        """
        Set up the data processing pipeline
        """
        # Create default transformer if none provided
        if not self.transformers:
            self.transformers.append(self._create_default_transformer())
        
        # Initialize transformers if they have initialize method
        for transformer in self.transformers:
            if hasattr(transformer, 'initialize') and callable(transformer.initialize):
                await transformer.initialize()
        
        self.logger.info(f"[{self.name}] Processing pipeline set up with {len(self.transformers)} transformers")
    
    def _create_default_transformer(self) -> DataTransformer:
        """
        Create a default transformer
        
        Returns:
            Default transformer
        """
        class DefaultTransformer(DataTransformer):
            async def process(self, data, options=None):
                # Basic transformation - add metadata
                if isinstance(data, dict):
                    return {
                        **data,
                        '_metadata': {
                            'processed_by': self.name,
                            'processed_at': datetime.utcnow().isoformat(),
                            'processing_id': str(uuid.uuid4())
                        }
                    }
                return data
        
        return DefaultTransformer()
    
    def add_transformer(self, transformer: DataTransformer):
        """
        Add a custom transformer to the pipeline
        
        Args:
            transformer: Transformer to add
        """
        if not isinstance(transformer, DataTransformer):
            raise TypeError(f"[{self.name}] Transformer must be an instance of DataTransformer")
        
        self.transformers.append(transformer)
        self.logger.info(f"[{self.name}] Added new transformer to pipeline (total: {len(self.transformers)})")
    
    async def start(self) -> bool:
        """
        Start the plugin.
        
        Returns:
            True if start successful, False otherwise
        """
        if not self.initialized:
            self.logger.error(f"[{self.name}] Cannot start: plugin not initialized")
            return False
        
        try:
            self.logger.info(f"[{self.name}] Starting plugin...")
            
            # Reset metrics
            self.metrics = {
                'start_time': datetime.utcnow(),
                'last_process_time': None,
                'processed_items': 0,
                'errors': 0,
                'average_processing_time': 0,
                'total_processing_time': 0
            }
            
            self.running = True
            
            # Start processing loop if enabled
            if self.processing_enabled:
                self.processing_task = asyncio.create_task(self._processing_loop())
            
            return True
        except Exception as e:
            self.logger.error(f"[{self.name}] Start failed: {str(e)}")
            return False
    
    async def stop(self) -> bool:
        """
        Stop the plugin.
        
        Returns:
            True if stop successful, False otherwise
        """
        if not self.running:
            self.logger.info(f"[{self.name}] Plugin already stopped")
            return True
        
        try:
            self.logger.info(f"[{self.name}] Stopping plugin...")
            
            # Stop processing loop
            self.running = False
            
            if hasattr(self, 'processing_task'):
                try:
                    self.processing_task.cancel()
                    await self.processing_task
                except asyncio.CancelledError:
                    pass
            
            # Process remaining items in queue
            if not self.data_queue.empty():
                self.logger.info(f"[{self.name}] Processing {self.data_queue.qsize()} remaining items...")
                await self._process_batch(self.data_queue.qsize())
            
            return True
        except Exception as e:
            self.logger.error(f"[{self.name}] Stop failed: {str(e)}")
            return False
    
    async def _processing_loop(self):
        """
        Main processing loop
        """
        while self.running:
            try:
                if not self.data_queue.empty() and not self.processing:
                    await self._process_batch()
                else:
                    await asyncio.sleep(self.processing_interval)
            except asyncio.CancelledError:
                break
            except Exception as e:
                self.logger.error(f"[{self.name}] Error in processing loop: {str(e)}")
                self.metrics['errors'] += 1
                await asyncio.sleep(1)  # Prevent tight loop in case of recurring errors
    
    async def add_data(self, data: Union[Any, List[Any]]) -> bool:
        """
        Add data to the processing queue
        
        Args:
            data: Data to process
            
        Returns:
            True if data was added successfully
        """
        if not self.initialized:
            self.logger.error(f"[{self.name}] Cannot add data: plugin not initialized")
            return False
        
        # Handle array of data items
        items = data if isinstance(data, list) else [data]
        
        # Check queue capacity
        if self.data_queue.qsize() + len(items) > self.max_queue_size:
            self.logger.warning(
                f"[{self.name}] Queue capacity exceeded ({self.max_queue_size}), "
                f"dropping {len(items)} items"
            )
            return False
        
        # Add items to queue
        for item in items:
            await self.data_queue.put({
                'data': item,
                'timestamp': datetime.utcnow(),
                'id': str(uuid.uuid4())
            })
        
        # Trigger immediate processing if not using timer
        if self.running and not self.processing_enabled and not self.processing:
            asyncio.create_task(self._process_batch())
        
        return True
    
    async def _process_batch(self, size: int = None) -> List[Any]:
        """
        Process a batch of data
        
        Args:
            size: Number of items to process, defaults to batch_size
            
        Returns:
            Processed items
        """
        if not self.running or self.processing:
            return []
        
        if self.data_queue.empty():
            return []
        
        self.processing = True
        process_start_time = time.time()
        
        try:
            # Get batch from queue
            batch_size = size if size is not None else min(self.batch_size, self.data_queue.qsize())
            batch = []
            for _ in range(batch_size):
                if self.data_queue.empty():
                    break
                batch.append(await self.data_queue.get())
            
            self.logger.debug(f"[{self.name}] Processing batch of {len(batch)} items")
            
            # Extract data from queue items
            processed_items = [item['data'] for item in batch]
            
            # Apply transformers sequentially
            for transformer in self.transformers:
                processed_items = await transformer.process_batch(processed_items)
            
            # Update metrics
            processing_time = time.time() - process_start_time
            self.metrics['last_process_time'] = datetime.utcnow()
            self.metrics['processed_items'] += len(processed_items)
            self.metrics['total_processing_time'] += processing_time
            if self.metrics['processed_items'] > 0:
                self.metrics['average_processing_time'] = (
                    self.metrics['total_processing_time'] / self.metrics['processed_items']
                )
            
            self.logger.debug(f"[{self.name}] Batch processed in {processing_time:.2f}s")
            
            # Emit processed data event if context has emit method
            if self.context and hasattr(self.context, 'emit') and callable(self.context.emit):
                await self.context.emit('data:processed', {
                    'plugin': self.name,
                    'count': len(processed_items),
                    'timestamp': datetime.utcnow().isoformat(),
                    'data': processed_items
                })
            
            # Mark queue tasks as done
            for _ in batch:
                self.data_queue.task_done()
            
            return processed_items
        except Exception as e:
            self.logger.error(f"[{self.name}] Batch processing failed: {str(e)}")
            self.metrics['errors'] += 1
            return []
        finally:
            self.processing = False
    
    async def process_data(self, data: Union[Any, List[Any]], options: Dict[str, Any] = None) -> Union[Any, List[Any]]:
        """
        Process data synchronously (bypass queue)
        
        Args:
            data: Data to process
            options: Processing options
            
        Returns:
            Processed data
        """
        if not self.initialized:
            raise RuntimeError(f"[{self.name}] Cannot process data: plugin not initialized")
        
        is_array = isinstance(data, list)
        items = data if is_array else [data]
        options = options or {}
        
        try:
            processed_items = items.copy()
            
            # Apply each transformer in sequence
            for transformer in self.transformers:
                processed_items = await transformer.process_batch(processed_items, options)
            
            # Update metrics
            self.metrics['processed_items'] += len(processed_items)
            self.metrics['last_process_time'] = datetime.utcnow()
            
            return processed_items if is_array else processed_items[0]
        except Exception as e:
            self.logger.error(f"[{self.name}] Data processing failed: {str(e)}")
            self.metrics['errors'] += 1
            raise
    
    async def clear_queue(self) -> int:
        """
        Clear the data queue
        
        Returns:
            Number of items removed
        """
        count = self.data_queue.qsize()
        
        # Create a new queue
        old_queue = self.data_queue
        self.data_queue = asyncio.Queue(maxsize=self.max_queue_size)
        
        # Clear the old queue
        while not old_queue.empty():
            try:
                old_queue.get_nowait()
                old_queue.task_done()
            except asyncio.QueueEmpty:
                break
        
        self.logger.info(f"[{self.name}] Cleared queue ({count} items removed)")
        return count
    
    def get_queue_size(self) -> int:
        """
        Get the current queue size
        
        Returns:
            Queue size
        """
        return self.data_queue.qsize()
    
    def get_status(self) -> Dict[str, Any]:
        """
        Get plugin status.
        
        Returns:
            Status information
        """
        uptime = 0
        if self.metrics['start_time']:
            uptime = (datetime.utcnow() - self.metrics['start_time']).total_seconds()
        
        processing_rate = 0
        if uptime > 0:
            processing_rate = self.metrics['processed_items'] / uptime
        
        return {
            'name': self.name,
            'version': self.version,
            'description': self.description,
            'initialized': self.initialized,
            'running': self.running,
            'queue_length': self.data_queue.qsize(),
            'queue_capacity': self.max_queue_size,
            'transformers': len(self.transformers),
            'metrics': {
                **self.metrics,
                'start_time': self.metrics['start_time'].isoformat() if self.metrics['start_time'] else None,
                'last_process_time': self.metrics['last_process_time'].isoformat() if self.metrics['last_process_time'] else None,
                'uptime': uptime,
                'processing_rate': f"{processing_rate:.2f} items/sec",
                'average_processing_time': f"{self.metrics['average_processing_time']:.2f} sec"
            },
            'timestamp': datetime.utcnow().isoformat()
        }
    
    def to_json(self) -> str:
        """
        Convert plugin status to JSON.
        
        Returns:
            JSON string representation of plugin status
        """
        return json.dumps(self.get_status())


# Example usage
if __name__ == "__main__":
    class NormalizationTransformer(DataTransformer):
        async def process(self, data, options=None):
            if isinstance(data, dict) and 'value' in data and isinstance(data['value'], (int, float)):
                data['normalized_value'] = data['value'] / 100.0
            return data
    
    class EnrichmentTransformer(DataTransformer):
        async def process(self, data, options=None):
            if isinstance(data, dict):
                data['enriched'] = True
                data['timestamp'] = datetime.utcnow().isoformat()
            return data
    
    async def run_example():
        # Create plugin instance
        plugin = SafeguardDataProcessorPlugin({
            'name': 'example-processor',
            'batch_size': 5
        })
        
        # Add custom transformers
        plugin.add_transformer(NormalizationTransformer())
        plugin.add_transformer(EnrichmentTransformer())
        
        # Initialize and start
        await plugin.initialize({})
        await plugin.start()
        
        # Add data to queue
        await plugin.add_data([
            {'id': '1', 'value': 42},
            {'id': '2', 'value': 78},
            {'id': '3', 'value': 99}
        ])
        
        # Process data directly
        result = await plugin.process_data({'id': '4', 'value': 55})
        print(f"Processed data: {result}")
        
        # Wait for queue processing
        await asyncio.sleep(2)
        
        # Get status
        status = plugin.get_status()
        print(f"Plugin status: {status}")
        
        # Stop the plugin
        await plugin.stop()
    
    asyncio.run(run_example())
```


```
# Requirements for the Safeguard Data Processor Plugin
pydantic>=2.0.0
aiohttp>=3.8.5
```


```markdown
# Safeguard Data Processor Python Plugin Template

This template provides a structure for creating a Safeguard plugin in Python that processes data streams and performs transformations. It includes a flexible pipeline system based on transformation classes and supports both synchronous and asynchronous data processing.

## Features

- Class-based data processing pipeline
- Customizable transformers
- Batch processing with configurable batch size
- Queue management with overflow protection
- Detailed metrics and status reporting
- Error handling and recovery
- Async/await support

## Usage

1. Clone this template
2. Install dependencies with `pip install -r requirements.txt`
3. Add your custom transformers by extending the `DataTransformer` class
4. Test your plugin

## Configuration Options

- `processing_enabled`: Enable automatic batch processing (default: True)
- `batch_size`: Number of items to process in each batch (default: 100)
- `processing_interval`: Interval between batch processing in seconds (default: 1.0)
- `max_queue_size`: Maximum number of items in the queue (default: 10000)
- `transformers`: Array of custom transformer instances to use in the pipeline

## Adding Custom Transformers

Create transformer classes to customize the data processing:

```python
from plugin import DataTransformer

class MyCustomTransformer(DataTransformer):
    async def initialize(self):
        # Optional initialization
        self.threshold = 0.5
        return True
    
    async def process(self, data, options=None):
        # Transform a single data item
        if isinstance(data, dict):
            data['timestamp'] = datetime.utcnow().isoformat()
            data['enriched'] = True
            data['score'] = self.calculate_score(data)
        return data
    
    async def process_batch(self, batch, options=None):
        # Override if you need custom batch processing logic
        # By default, it calls process() on each item
        return await super().process_batch(batch, options)
    
    def calculate_score(self, data):
        # Helper method for transformation
        return 0.95  # Example score

# Add to the plugin
plugin = SafeguardDataProcessorPlugin()
plugin.add_transformer(MyCustomTransformer())
```
```


## Example

```textmate
import asyncio
from plugin import SafeguardDataProcessorPlugin, DataTransformer
from datetime import datetime

# Create a custom transformer
class GeolocationEnricher(DataTransformer):
    async def process(self, data, options=None):
        # Add geolocation data to the input
        if isinstance(data, dict):
            data['location'] = {
                'latitude': 40.7128,
                'longitude': -74.0060,
                'accuracy': 10
            }
        return data

# Create plugin with custom transformer
async def run():
    plugin = SafeguardDataProcessorPlugin({
        'name': 'geolocation-enricher',
        'batch_size': 10
    })
    
    # Add the transformer
    plugin.add_transformer(GeolocationEnricher())
    
    # Initialize and use the plugin
    await plugin.initialize({})
    await plugin.start()
    
    # Process data through the pipeline
    data = {'id': '12345', 'type': 'vehicle'}
    processed = await plugin.process_data(data)
    print(f"Processed data: {processed}")
    
    # Add data to the processing queue
    await plugin.add_data([
        {'id': '67890', 'type': 'drone'},
        {'id': 'abcde', 'type': 'robot'}
    ])
    
    # Get plugin status after 2 seconds
    await asyncio.sleep(2)
    print(f"Plugin status: {plugin.get_status()}")
    
    await plugin.stop()

# Run the example
asyncio.run(run())
```


## Queue Management

The plugin includes a queue system for handling data asynchronously:

- `add_data()`: Add data to the queue for async processing
- `process_data()`: Process data immediately, bypassing the queue
- `clear_queue()`: Remove all pending items from the queue
- `get_queue_size()`: Get current number of items in the queue

## Metrics

The plugin tracks the following metrics:

- Processed items count
- Error count
- Average processing time
- Total processing time
- Processing rate (items/second)
- Uptime
- Last processing timestamp

## License

Copyright 2025 Autonomy Association International Inc., all rights reserved.
```
<llm-snippet-file>_safeguard-plugin-system/templates/python/data-processor/example.py</llm-snippet-file>
```python
"""
Example usage of the Data Processor Safeguard Plugin
"""

import asyncio
import logging
from datetime import datetime
from plugin import SafeguardDataProcessorPlugin, DataTransformer

# Configure root logger
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)

# Create custom transformers for the data processing pipeline
class DataNormalizer(DataTransformer):
    async def process(self, data, options=None):
        try:
            # Normalize data format
            normalized = {
                'id': data.get('id') or data.get('identifier') or f"unknown-{datetime.utcnow().timestamp()}",
                'timestamp': data.get('timestamp') or datetime.utcnow().isoformat(),
                'value': round(float(data.get('value', 0)), 2),
                'type': data.get('type') or 'unknown',
                'source': data.get('source') or 'system',
                'raw': data
            }
            return normalized
        except Exception as e:
            print(f"Error in normalizer: {e}")
            return data

class DataEnricher(DataTransformer):
    async def process(self, data, options=None):
        try:
            # Add computed fields
            value = float(data.get('value', 0))
            enriched = {
                **data,
                'enriched': True,
                'classification': self.classify_value(value),
                'hash': self.generate_hash(data),
                'processing_latency': None
            }
            
            # Calculate processing latency if timestamp exists
            if 'timestamp' in data and isinstance(data['timestamp'], str):
                try:
                    ts = datetime.fromisoformat(data['timestamp'])
                    enriched['processing_latency'] = (datetime.utcnow() - ts).total_seconds()
                except ValueError:
                    pass
                
            return enriched
        except Exception as e:
            print(f"Error in enricher: {e}")
            return data
    
    def classify_value(self, value):
        if value < 10:
            return 'low'
        if value < 50:
            return 'medium'
        return 'high'
    
    def generate_hash(self, data):
        # Simple hash function for example purposes
        import hashlib
        import json
        try:
            data_str = json.dumps(data, sort_keys=True)
            return hashlib.md5(data_str.encode()).hexdigest()[:8]
        except:
            return "hash-error"

class AlertDetector(DataTransformer):
    async def initialize(self):
        self.alert_threshold = 75
        return True
    
    async def process(self, data, options=None):
        try:
            # Check for alert conditions
            value = float(data.get('value', 0))
            requires_alert = value > self.alert_threshold
            
            processed = {
                **data,
                'alert': requires_alert,
                'alert_level': 'critical' if requires_alert else 'normal',
                'alert_message': f"Value {value} exceeds threshold {self.alert_threshold}" if requires_alert else None
            }
            
            return processed
        except Exception as e:
            print(f"Error in alert detector: {e}")
            return data

async def demonstrate_data_processor():
    """
    Demonstrate the data processor plugin functionality
    """
    try:
        # Create plugin with custom transformers
        plugin = SafeguardDataProcessorPlugin({
            'name': 'sensor-data-processor',
            'description': 'Processes and enriches sensor data',
            'batch_size': 5,
            'processing_interval': 2.0,
            'log_level': logging.DEBUG
        })
        
        # Add processors to pipeline
        plugin.add_transformer(DataNormalizer())
        plugin.add_transformer(DataEnricher())
        plugin.add_transformer(AlertDetector())
        
        # Initialize the plugin
        print("Initializing data processor plugin...")
        await plugin.initialize({
            'app_context': {
                'app_version': '1.0.0',
                'environment': 'development'
            },
            'emit': lambda event, data: print(f"Event emitted: {event}")
        })
        
        # Start the plugin
        print("\nStarting plugin...")
        await plugin.start()
        
        # Get initial plugin status
        print("\nInitial plugin status:")
        print(plugin.to_json())
        
        # Process a single item synchronously
        print("\nProcessing single item synchronously...")
        single_result = await plugin.process_data({
            'id': 'sensor-001',
            'value': 42,
            'type': 'temperature',
            'source': 'building-a'
        })
        print(f"Processed result: {single_result}")
        
        # Add batch of items to the queue
        print("\nAdding batch of items to the queue...")
        batch_data = [
            {'id': 'sensor-002', 'value': 78, 'type': 'humidity', 'source': 'building-b'},
            {'id': 'sensor-003', 'value': 26, 'type': 'temperature', 'source': 'building-c'},
            {'id': 'sensor-004', 'value': 98, 'type': 'pressure', 'source': 'building-a'},
            {'id': 'sensor-005', 'value': 51, 'type': 'air-quality', 'source': 'building-d'},
            {'id': 'sensor-006', 'value': 33, 'type': 'temperature', 'source': 'building-b'}
        ]
        await plugin.add_data(batch_data)
        
        # Wait for batch processing to complete
        print("\nWaiting for batch processing...")
        await asyncio.sleep(3)
        
        # Get updated plugin status
        print("\nUpdated plugin status after batch processing:")
        print(plugin.to_json())
        
        # Process another batch with manual processing
        print("\nProcessing another batch manually...")
        manual_batch = [
            {'id': 'sensor-007', 'value': 88, 'type': 'humidity', 'source': 'building-e'},
            {'id': 'sensor-008', 'value': 12, 'type': 'temperature', 'source': 'building-f'}
        ]
        batch_result = await plugin.process_data(manual_batch)
        print(f"Batch processing results:")
        for result in batch_result:
            print(f"- {result['id']}: {result['value']} ({result['classification']}, Alert: {result['alert']})")
        
        # Stop the plugin
        print("\nStopping plugin...")
        await plugin.stop()
        
        # Final status
        print("\nFinal plugin status:")
        print(plugin.to_json())
        
    except Exception as e:
        print(f"Error in data processor demonstration: {e}")
        import traceback
        traceback.print_exc()

# Run the demonstration
if __name__ == "__main__":
    asyncio.run(demonstrate_data_processor())
```
```


### 4. Cerebras LLM API Python Template

```textmate
"""
Cerebras LLM API Safeguard Plugin Template

This template provides a structure for creating a Safeguard plugin in Python
that interacts with the Cerebras Cloud LLM API for language model inference.

Copyright 2025 Autonomy Association International Inc., all rights reserved.
"""

import logging
import uuid
import json
import asyncio
import time
from datetime import datetime
from typing import Dict, Any, Optional, List, Union, Callable

import aiohttp
import requests  # For synchronous requests when needed

class SafeguardCerebrasLLMPlugin:
    """
    Cerebras LLM API template for a Safeguard plugin.
    
    This class provides a foundation for building Safeguard plugins that interact with
    the Cerebras Cloud LLM API for language model inference.
    """
    
    def __init__(self, config: Dict[str, Any] = None):
        """
        Initialize the plugin with configuration.
        
        Args:
            config: Dictionary containing plugin configuration
        """
        config = config or {}
        self.name = config.get('name', 'cerebras-llm-plugin')
        self.version = config.get('version', '1.0.0')
        self.description = config.get('description', 'Cerebras LLM API Safeguard Plugin')
        self.config = config
        self.initialized = False
        self.running = False
        
        # Cerebras specific configuration
        self.api_key = config.get('api_key')
        self.base_url = config.get('base_url', 'https://api.cerebras.cloud')
        self.default_model = config.get('default_model', 'cerebras-1')
        self.timeout = config.get('timeout', 60)  # 60 seconds default
        self.request_history = []
        self.max_history_size = config.get('max_history_size', 100)
        
        # Configure logging
        self.logger = self._setup_logging()
        self.logger.info(f"[{self.name}] Plugin instance created")
        
        # HTTP session will be created during initialization
        self.session = None
    
    def _setup_logging(self) -> logging.Logger:
        """
        Set up the plugin's logger.
        
        Returns:
            Logger instance
        """
        logger = logging.getLogger(f"safeguard.plugin.{self.name}")
        if not logger.handlers:
            handler = logging.StreamHandler()
            formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
            handler.setFormatter(formatter)
            logger.addHandler(handler)
            logger.setLevel(self.config.get('log_level', logging.INFO))
        return logger
    
    async def initialize(self, context: Dict[str, Any]) -> bool:
        """
        Initialize the plugin.
        
        Args:
            context: Initialization context
            
        Returns:
            True if initialization successful, False otherwise
        """
        try:
            self.logger.info(f"[{self.name}] Initializing plugin v{self.version}")
            self.context = context
            
            if not self.api_key:
                raise ValueError("API key is required for Cerebras Cloud API")
            
            # Create HTTP session
            timeout = aiohttp.ClientTimeout(total=self.timeout)
            self.session = aiohttp.ClientSession(
                timeout=timeout,
                headers={
                    'Content-Type': 'application/json',
                    'Authorization': f'Bearer {self.api_key}',
                    'User-Agent': f'Safeguard-Plugin/{self.name}/{self.version}'
                }
            )
            
            # Validate API key by testing a simple request
            if self.config.get('validate_api_key', True):
                try:
                    await self.test_connection()
                    self.logger.info(f"[{self.name}] API key validation successful")
                except Exception as e:
                    raise ValueError(f"API key validation failed: {str(e)}")
            
            self.initialized = True
            return True
        except Exception as e:
            self.logger.error(f"[{self.name}] Initialization failed: {str(e)}")
            return False
    
    async def test_connection(self) -> Dict[str, Any]:
        """
        Test connection to the Cerebras API.
        
        Returns:
            Response from API test
        """
        try:
            # Try to list models to test connection
            models = await self.list_models()
            if not models or len(models) == 0:
                raise ValueError("No models available")
            return models
        except Exception as e:
            self.logger.error(f"[{self.name}] Connection test failed: {str(e)}")
            raise
    
    async def start(self) -> bool:
        """
        Start the plugin.
        
        Returns:
            True if start successful, False otherwise
        """
        if not self.initialized:
            self.logger.error(f"[{self.name}] Cannot start: plugin not initialized")
            return False
        
        try:
            self.logger.info(f"[{self.name}] Starting plugin...")
            self.running = True
            return True
        except Exception as e:
            self.logger.error(f"[{self.name}] Start failed: {str(e)}")
            return False
    
    async def stop(self) -> bool:
        """
        Stop the plugin.
        
        Returns:
            True if stop successful, False otherwise
        """
        if not self.running:
            self.logger.info(f"[{self.name}] Plugin already stopped")
            return True
        
        try:
            self.logger.info(f"[{self.name}] Stopping plugin...")
            self.running = False
            
            # Close HTTP session
            if self.session and not self.session.closed:
                await self.session.close()
            
            return True
        except Exception as e:
            self.logger.error(f"[{self.name}] Stop failed: {str(e)}")
            return False
    
    async def generate_text(self, params: Dict[str, Any]) -> Dict[str, Any]:
        """
        Generate text using the Cerebras LLM API.
        
        Args:
            params: Generation parameters
                - prompt: The input prompt
                - model: Model to use, defaults to this.default_model
                - max_tokens: Maximum tokens to generate
                - temperature: Sampling temperature (0.0-1.0)
                - top_p: Nucleus sampling parameter (0.0-1.0)
                - top_k: Top-k sampling parameter
                - presence_penalty: Presence penalty (0.0-1.0)
                - frequency_penalty: Frequency penalty (0.0-1.0)
                - stop_sequences: Sequences that stop generation
            
        Returns:
            Generated text and metadata
        """
        if not self.initialized or not self.running:
            raise RuntimeError(f"[{self.name}] Cannot generate text: plugin not running")
        
        request_id = str(uuid.uuid4())
        start_time = time.time()
        
        try:
            model = params.get('model', self.default_model)
            self.logger.info(f"[{self.name}] Generating text with model: {model} ({request_id})")
            
            request_params = {
                'model': model,
                'prompt': params['prompt'],
                'max_tokens': params.get('max_tokens', 1024),
                'temperature': params.get('temperature', 0.7),
                'top_p': params.get('top_p', 0.9),
                'top_k': params.get('top_k', 40),
                'presence_penalty': params.get('presence_penalty', 0.0),
                'frequency_penalty': params.get('frequency_penalty', 0.0),
                'stop_sequences': params.get('stop_sequences', [])
            }
            
            # Log request (exclude prompt for privacy)
            self.logger.debug(f"[{self.name}] Request ({request_id}): {self._sanitize_for_logging(request_params)}")
            
            # Make API call to Cerebras
            endpoint = f"{self.base_url}/v1/completions"
            async with self.session.post(endpoint, json=request_params) as response:
                if response.status != 200:
                    error_text = await response.text()
                    raise Exception(f"API returned {response.status}: {error_text}")
                
                result = await response.json()
            
            duration = time.time() - start_time
            self.logger.info(f"[{self.name}] Text generation completed in {duration:.2f}s ({request_id})")
            
            # Process and format response
            formatted_result = {
                'id': request_id,
                'model': model,
                'text': result.get('completion', ''),
                'prompt_tokens': result.get('prompt_tokens', 0),
                'completion_tokens': result.get('completion_tokens', 0),
                'total_tokens': result.get('total_tokens', 0),
                'finish_reason': result.get('finish_reason', 'unknown'),
                'duration': duration,
                'timestamp': datetime.utcnow().isoformat()
            }
            
            # Add to request history
            self._add_to_history({
                'id': request_id,
                'type': 'text-generation',
                'model': model,
                'params': self._sanitize_for_logging(request_params),
                'status': 'success',
                'duration': duration,
                'timestamp': datetime.utcnow().isoformat()
            })
            
            return formatted_result
        except Exception as e:
            duration = time.time() - start_time
            self.logger.error(f"[{self.name}] Text generation failed ({request_id}): {str(e)}")
            
            # Add failed request to history
            self._add_to_history({
                'id': request_id,
                'type': 'text-generation',
                'model': params.get('model', self.default_model),
                'params': self._sanitize_for_logging(params),
                'status': 'error',
                'error': str(e),
                'duration': duration,
                'timestamp': datetime.utcnow().isoformat()
            })
            
            raise
    
    async def generate_embeddings(self, params: Dict[str, Any]) -> Dict[str, Any]:
        """
        Generate embeddings using the Cerebras LLM API.
        
        Args:
            params: Embedding parameters
                - input: Text to embed (string or array of strings)
                - model: Model to use, defaults to "cerebras-embedding-1"
            
        Returns:
            Embedding vectors and metadata
        """
        if not self.initialized or not self.running:
            raise RuntimeError(f"[{self.name}] Cannot generate embeddings: plugin not running")
        
        request_id = str(uuid.uuid4())
        start_time = time.time()
        
        try:
            model = params.get('model', 'cerebras-embedding-1')
            input_text = params['input']
            input_list = input_text if isinstance(input_text, list) else [input_text]
            
            self.logger.info(f"[{self.name}] Generating embeddings for {len(input_list)} texts with model: {model} ({request_id})")
            
            # Prepare request parameters
            request_params = {
                'model': model,
                'input': input_list
            }
            
            # Log request (exclude input text for privacy)
            self.logger.debug(f"[{self.name}] Request ({request_id}): {{'model': '{model}', 'input': '[{len(input_list)} texts]'}}")
            
            # Make API call to Cerebras
            endpoint = f"{self.base_url}/v1/embeddings"
            async with self.session.post(endpoint, json=request_params) as response:
                if response.status != 200:
                    error_text = await response.text()
                    raise Exception(f"API returned {response.status}: {error_text}")
                
                result = await response.json()
            
            duration = time.time() - start_time
            self.logger.info(f"[{self.name}] Embeddings generation completed in {duration:.2f}s ({request_id})")
            
            # Process and format response
            embeddings = [item.get('embedding', []) for item in result.get('data', [])]
            dimensions = len(embeddings[0]) if embeddings and len(embeddings) > 0 else 0
            
            formatted_result = {
                'id': request_id,
                'model': model,
                'embeddings': embeddings,
                'dimensions': dimensions,
                'duration': duration,
                'timestamp': datetime.utcnow().isoformat()
            }
            
            # Add to request history
            self._add_to_history({
                'id': request_id,
                'type': 'embeddings',
                'model': model,
                'params': {
                    'model': model,
                    'input': f"[{len(input_list)} texts]"
                },
                'status': 'success',
                'duration': duration,
                'timestamp': datetime.utcnow().isoformat()
            })
            
            return formatted_result
        except Exception as e:
            duration = time.time() - start_time
            self.logger.error(f"[{self.name}] Embeddings generation failed ({request_id}): {str(e)}")
            
            # Add failed request to history
            self._add_to_history({
                'id': request_id,
                'type': 'embeddings',
                'model': params.get('model', 'cerebras-embedding-1'),
                'params': {
                    'model': params.get('model', 'cerebras-embedding-1'),
                    'input': f"[{len(input_list) if 'input' in params and isinstance(params['input'], list) else 1} texts]"
                },
                'status': 'error',
                'error': str(e),
                'duration': duration,
                'timestamp': datetime.utcnow().isoformat()
            })
            
            raise
    
    async def list_models(self) -> List[Dict[str, Any]]:
        """
        List available models.
        
        Returns:
            List of available models
        """
        if not self.initialized:
            raise RuntimeError(f"[{self.name}] Cannot list models: plugin not initialized")
        
        try:
            endpoint = f"{self.base_url}/v1/models"
            async with self.session.get(endpoint) as response:
                if response.status != 200:
                    error_text = await response.text()
                    raise Exception(f"API returned {response.status}: {error_text}")
                
                result = await response.json()
                return result.get('data', [])
        except Exception as e:
            self.logger.error(f"[{self.name}] List models failed: {str(e)}")
            raise
    
    def _sanitize_for_logging(self, params: Dict[str, Any]) -> Dict[str, Any]:
        """
        Sanitize parameters for logging (remove sensitive data)
        
        Args:
            params: Parameters to sanitize
            
        Returns:
            Sanitized parameters
        """
        sanitized = params.copy()
        
        # Remove or truncate potentially sensitive or large fields
        if 'prompt' in sanitized:
            sanitized['prompt'] = f"[{len(sanitized['prompt'])} chars]"
        
        if 'input' in sanitized and isinstance(sanitized['input'], list):
            sanitized['input'] = f"[{len(sanitized['input'])} texts]"
        elif 'input' in sanitized:
            sanitized['input'] = f"[{len(str(sanitized['input']))} chars]"
        
        return sanitized
    
    def _add_to_history(self, entry: Dict[str, Any]):
        """
        Add a request to the history
        
        Args:
            entry: History entry
        """
        self.request_history.insert(0, entry)
        
        # Trim history if it exceeds max size
        if len(self.request_history) > self.max_history_size:
            self.request_history = self.request_history[:self.max_history_size]
    
    def get_request_history(self, limit: int = None) -> List[Dict[str, Any]]:
        """
        Get request history
        
        Args:
            limit: Maximum number of entries to return
            
        Returns:
            Request history
        """
        if limit is not None and limit > 0:
            return self.request_history[:limit]
        return self.request_history
    
    def get_status(self) -> Dict[str, Any]:
        """
        Get plugin status.
        
        Returns:
            Status information
        """
        return {
            'name': self.name,
            'version': self.version,
            'description': self.description,
            'initialized': self.initialized,
            'running': self.running,
            'default_model': self.default_model,
            'requests_processed': len(self.request_history),
            'last_request_timestamp': self.request_history[0]['timestamp'] if self.request_history else None,
            'timestamp': datetime.utcnow().isoformat()
        }
    
    def to_json(self) -> str:
        """
        Convert plugin status to JSON.
        
        Returns:
            JSON string representation of plugin status
        """
        return json.dumps(self.get_status())


# Example usage
if __name__ == "__main__":
    async def run_example():
        # Create plugin instance
        plugin = SafeguardCerebrasLLMPlugin({
            'name': 'cerebras-llm',
            'api_key': 'your-cerebras-api-key-here'  # Replace with actual API key
        })
        
        # Initialize and start
        await plugin.initialize({})
        await plugin.start()
        
        try:
            # Generate text
            completion = await plugin.generate_text({
                'prompt': "Explain the benefits of using AI in autonomous systems:",
                'max_tokens': 512
            })
            
            print(f"Generated text: {completion['text']}")
            
            # Generate embeddings
            embeddings = await plugin.generate_embeddings({
                'input': ["Safety-critical systems", "Autonomous navigation"]
            })
            
            print(f"Embedding dimensions: {embeddings['dimensions']}")
            print(f"First embedding vector (first 5 values): {embeddings['embeddings'][0][:5]}")
        
        except Exception as e:
            print(f"API request error: {e}")
        
        # Get status
        status = plugin.get_status()
        print(f"Plugin status: {status}")
        
        # Stop the plugin
        await plugin.stop()
    
    asyncio.run(run_example())
```


```
# Requirements for the Safeguard Cerebras LLM API Plugin
aiohttp>=3.8.5
requests>=2.31.0
```


```markdown
# Safeguard Cerebras LLM API Python Plugin Template

This template provides a structure for creating a Safeguard plugin in Python that interacts with the Cerebras Cloud LLM API for language model inference. It supports text generation (completions) and embeddings generation with various model parameters.

## Features

- Text generation with the Cerebras LLM API
- Embeddings generation for semantic search and NLP tasks
- Request history tracking and management
- Model availability checking
- Comprehensive error handling and logging
- Async/await support

## Prerequisites

- Cerebras Cloud API key
- Python 3.7 or higher
- Required Python packages (see requirements.txt)

## Usage

1. Clone this template
2. Install dependencies with `pip install -r requirements.txt`
3. Set your Cerebras API key in the configuration
4. Initialize and use the plugin in your application

## Configuration Options

- `api_key`: Cerebras Cloud API key (required)
- `base_url`: API base URL (default: 'https://api.cerebras.cloud')
- `default_model`: Default model to use (default: 'cerebras-1')
- `timeout`: Request timeout in seconds (default: 60)
- `max_history_size`: Maximum number of requests to keep in history (default: 100)
- `validate_api_key`: Whether to validate the API key during initialization (default: True)

## API Methods

### Text Generation

```python
result = await plugin.generate_text({
    "prompt": "Once upon a time in the digital realm,",
    "model": "cerebras-1",  # optional, uses default_model if not specified
    "max_tokens": 1024,
    "temperature": 0.7,
    "top_p": 0.9,
    "top_k": 40,
    "presence_penalty": 0.0,
    "frequency_penalty": 0.0,
    "stop_sequences": ["\n\n"]
})
```
```


### Embeddings Generation

```textmate
result = await plugin.generate_embeddings({
    "input": ["The quick brown fox jumps over the lazy dog"],
    "model": "cerebras-embedding-1"  # optional
})
```


### List Available Models

```textmate
models = await plugin.list_models()
```


## Example

```textmate
import asyncio
from plugin import SafeguardCerebrasLLMPlugin

async def run():
    # Create plugin instance
    plugin = SafeguardCerebrasLLMPlugin({
        'name': 'cerebras-llm',
        'api_key': 'your-cerebras-api-key-here'
    })
    
    # Initialize and use the plugin
    await plugin.initialize({})
    await plugin.start()
    
    # Generate text
    completion = await plugin.generate_text({
        'prompt': "Explain the benefits of using AI in autonomous systems:",
        'max_tokens': 512
    })
    
    print(f"Generated text: {completion['text']}")
    
    # Generate embeddings
    embeddings = await plugin.generate_embeddings({
        'input': ["Safety-critical systems", "Autonomous navigation"]
    })
    
    print(f"Embedding dimensions: {embeddings['dimensions']}")
    print(f"First embedding vector (first 5 values): {embeddings['embeddings'][0][:5]}")
    
    await plugin.stop()

# Run the example
asyncio.run(run())
```


## Error Handling

The plugin includes built-in error handling and logging:

- API request failures (connection issues, timeouts)
- API response errors (invalid parameters, rate limits)
- Plugin state validation (ensuring the plugin is initialized and running)

All errors are logged and can be tracked through the request history.

## Extending the Plugin

To extend the functionality of the Cerebras LLM plugin, subclass `SafeguardCerebrasLLMPlugin` and override the methods you want to customize:

```textmate
from plugin import SafeguardCerebrasLLMPlugin

class CustomCerebrasPlugin(SafeguardCerebrasLLMPlugin):
    async def initialize(self, context):
        # Add custom initialization logic
        result = await super().initialize(context)
        
        # Load custom prompts
        self.prompts = {
            'summary': "Please summarize the following text:\n\n{text}",
            'question': "Please answer the following question:\n\nQuestion: {question}\n\nAnswer:"
        }
        
        return result
    
    async def summarize(self, text, max_length=100):
        """Custom method for text summarization"""
        prompt = self.prompts['summary'].format(text=text)
        result = await self.generate_text({
            'prompt': prompt,
            'max_tokens': max_length
        })
        return result['text']
```


## License

Copyright 2025 Autonomy Association International Inc., all rights reserved.
```
<llm-snippet-file>_safeguard-plugin-system/templates/python/cerebras-llm-api/example.py</llm-snippet-file>
```
python
"""
Example usage of the Cerebras LLM API Safeguard Plugin
"""

import asyncio
import logging
from datetime import datetime
from plugin import SafeguardCerebrasLLMPlugin

# Configure root logger
logging.basicConfig(
level=logging.INFO,
format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)

async def demonstrate_cerebras_llm():
"""
Demonstrate the Cerebras LLM plugin functionality
"""
try:
# Create plugin instance with your API key
# NOTE: Replace 'your-cerebras-api-key' with your actual API key
plugin = SafeguardCerebrasLLMPlugin({
'name': 'cerebras-assistant',
'version': '1.0.0',
'description': 'Cerebras LLM Integration Example',
'api_key': 'your-cerebras-api-key',
'default_model': 'cerebras-1',
'log_level': logging.DEBUG
})

        # Initialize the plugin
        print("Initializing Cerebras LLM plugin...")
        await plugin.initialize({
            'app_context': { 
                'app_version': '1.0.0',
                'environment': 'development'
            }
        })
        
        # Start the plugin
        print("\nStarting plugin...")
        await plugin.start()
        
        # Get plugin status
        print("\nPlugin status:")
        print(plugin.to_json())
        
        # List available models
        try:
            print("\nListing available models...")
            models = await plugin.list_models()
            print(f"Available models: {models}")
        except Exception as model_error:
            print(f"Error listing models: {model_error}")
            print("Continuing with the default model")
        
        # Generate text completion
        try:
            print("\nGenerating text completion...")
            completion_result = await plugin.generate_text({
                'prompt': "Explain the three laws of robotics in simple terms:",
                'max_tokens': 256,
                'temperature': 0.7
            })
            
            print("\nCompletion result:")
            print(f"Text: {completion_result['text']}")
            print(f"Model: {completion_result['model']}")
            print(f"Tokens used: {completion_result['total_tokens']}")
            print(f"Duration: {completion_result['duration']:.2f} seconds")
        except Exception as completion_error:
            print(f"Error generating completion: {completion_error}")
        
        # Generate embeddings
        try:
            print("\nGenerating embeddings...")
            embeddings_result = await plugin.generate_embeddings({
                'input': [
                    "Autonomous vehicles must prioritize safety",
                    "Machine learning algorithms improve over time"
                ]
            })
            
            print("\nEmbeddings result:")
            print(f"Model: {embeddings_result['model']}")
            print(f"Embedding count: {len(embeddings_result['embeddings'])}")
            print(f"Dimensions: {embeddings_result['dimensions']}")
            print(f"First embedding (first 5 values): {embeddings_result['embeddings'][0][:5]}")
            print(f"Duration: {embeddings_result['duration']:.2f} seconds")
        except Exception as embeddings_error:
            print(f"Error generating embeddings: {embeddings_error}")
        
        # Get request history
        print("\nRequest history:")
        history = plugin.get_request_history(5)
        for entry in history:
            print(f"- {entry['type']} ({entry['id'][:8]}): {entry['status']}, Model: {entry['model']}, Duration: {entry['duration']:.2f}s")
        
        # Stop the plugin
        print("\nStopping plugin...")
        await plugin.stop()
        
        # Final status
        print("\nFinal plugin status:")
        print(plugin.to_json())
        
    except Exception as e:
        print(f"Error in Cerebras LLM demonstration: {e}")

# Run the demonstration
if __name__ == "__main__":
asyncio.run(demonstrate_cerebras_llm())
```
### 5. OpenAI LLM API Python Template

<llm-snippet-file>_safeguard-plugin-system/templates/python/openai-llm-api/plugin.py</llm-snippet-file>
```
python
"""
OpenAI LLM API Safeguard Plugin Template

This template provides a structure for creating a Safeguard plugin in Python
that interacts with the OpenAI API for language model inference.

Copyright 2025 Autonomy Association International Inc., all rights reserved.
"""

import logging
import uuid
import json
import asyncio
import time
from datetime import datetime
from typing import Dict, Any, Optional, List, Union, Callable, BinaryIO

import aiohttp
import openai
from openai import AsyncOpenAI

class SafeguardOpenAIPlugin:
"""
OpenAI API template for a Safeguard plugin.

    This class provides a foundation for building Safeguard plugins that interact with
    the OpenAI API for language model inference, embeddings generation, image creation,
    and audio transcription.
    """
    
    def __init__(self, config: Dict[str, Any] = None):
        """
        Initialize the plugin with configuration.
        
        Args:
            config: Dictionary containing plugin configuration
        """
        config = config or {}
        self.name = config.get('name', 'openai-plugin')
        self.version = config.get('version', '1.0.0')
        self.description = config.get('description', 'OpenAI API Safeguard Plugin')
        self.config = config
        self.initialized = False
        self.running = False
        
        # OpenAI specific configuration
        self.api_key = config.get('api_key')
        self.organization = config.get('organization')
        self.default_model = config.get('default_model', 'gpt-4o')
        self.base_url = config.get('base_url')
        self.timeout = config.get('timeout', 60)  # 60 seconds default
        self.request_history = []
        self.max_history_size = config.get('max_history_size', 100)
        
        # Configure logging
        self.logger = self._setup_logging()
        self.logger.info(f"[{self.name}] Plugin instance created")
        
        # OpenAI client will be created during initialization
        self.client = None
    
    def _setup_logging(self) -> logging.Logger:
        """
        Set up the plugin's logger.
        
        Returns:
            Logger instance
        """
        logger = logging.getLogger(f"safeguard.plugin.{self.name}")
        if not logger.handlers:
            handler = logging.StreamHandler()
            formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
            handler.setFormatter(formatter)
            logger.addHandler(handler)
            logger.setLevel(self.config.get('log_level', logging.INFO))
        return logger
    
    async def initialize(self, context: Dict[str, Any]) -> bool:
        """
        Initialize the plugin.
        
        Args:
            context: Initialization context
            
        Returns:
            True if initialization successful, False otherwise
        """
        try:
            self.logger.info(f"[{self.name}] Initializing plugin v{self.version}")
            self.context = context
            
            if not self.api_key:
                raise ValueError("API key is required for OpenAI API")
            
            # Initialize OpenAI client
            client_options = {
                "api_key": self.api_key,
                "timeout": self.timeout
            }
            
            if self.organization:
                client_options["organization"] = self.organization
            
            if self.base_url:
                client_options["base_url"] = self.base_url
            
            self.client = AsyncOpenAI(**client_options)
            
            # Validate API key by testing a simple request
            if self.config.get('validate_api_key', True):
                try:
                    await self.test_connection()
                    self.logger.info(f"[{self.name}] API key validation successful")
                except Exception as e:
                    raise ValueError(f"API key validation failed: {str(e)}")
            
            self.initialized = True
            return True
        except Exception as e:
            self.logger.error(f"[{self.name}] Initialization failed: {str(e)}")
            return False
    
    async def test_connection(self) -> Dict[str, Any]:
        """
        Test connection to the OpenAI API.
        
        Returns:
            Response from API test
        """
        try:
            # Try to list models to test connection
            models = await self.list_models()
            if not models or len(models) == 0:
                raise ValueError("No models available")
            return models
        except Exception as e:
            self.logger.error(f"[{self.name}] Connection test failed: {str(e)}")
            raise
    
    async def start(self) -> bool:
        """
        Start the plugin.
        
        Returns:
            True if start successful, False otherwise
        """
        if not self.initialized:
            self.logger.error(f"[{self.name}] Cannot start: plugin not initialized")
            return False
        
        try:
            self.logger.info(f"[{self.name}] Starting plugin...")
            self.running = True
            return True
        except Exception as e:
            self.logger.error(f"[{self.name}] Start failed: {str(e)}")
            return False
    
    async def stop(self) -> bool:
        """
        Stop the plugin.
        
        Returns:
            True if stop successful, False otherwise
        """
        if not self.running:
            self.logger.info(f"[{self.name}] Plugin already stopped")
            return True
        
        try:
            self.logger.info(f"[{self.name}] Stopping plugin...")
            self.running = False
            
            # Close resources if necessary
            # Nothing to close for OpenAI client
            
            return True
        except Exception as e:
            self.logger.error(f"[{self.name}] Stop failed: {str(e)}")
            return False
    
    async def create_chat_completion(self, params: Dict[str, Any]) -> Dict[str, Any]:
        """
        Create a chat completion.
        
        Args:
            params: Chat completion parameters
                - messages: Chat messages array
                - model: Model to use, defaults to self.default_model
                - temperature: Sampling temperature (0.0-2.0)
                - max_tokens: Maximum tokens to generate
                - top_p: Nucleus sampling parameter (0.0-1.0)
                - frequency_penalty: Frequency penalty (-2.0-2.0)
                - presence_penalty: Presence penalty (-2.0-2.0)
                - stop: Sequences that stop generation
                - stream: Whether to stream the response
                - tools: Tools available to the model
            
        Returns:
            Chat completion result
        """
        if not self.initialized or not self.running:
            raise RuntimeError(f"[{self.name}] Cannot create chat completion: plugin not running")
        
        request_id = str(uuid.uuid4())
        start_time = time.time()
        
        try:
            model = params.get('model', self.default_model)
            self.logger.info(f"[{self.name}] Creating chat completion with model: {model} ({request_id})")
            
            # Prepare request parameters
            request_params = {
                "model": model,
                "messages": params['messages'],
                "temperature": params.get('temperature', 0.7),
                "max_tokens": params.get('max_tokens'),
                "top_p": params.get('top_p'),
                "frequency_penalty": params.get('frequency_penalty'),
                "presence_penalty": params.get('presence_penalty'),
                "stop": params.get('stop'),
                "stream": params.get('stream', False),
                "tools": params.get('tools')
            }
            
            # Remove None values
            request_params = {k: v for k, v in request_params.items() if v is not None}
            
            # Log request (exclude messages for privacy)
            self.logger.debug(f"[{self.name}] Request ({request_id}): {self._sanitize_for_logging(request_params)}")
            
            # Handle streaming response
            if params.get('stream', False):
                stream = await self.client.chat.completions.create(**request_params)
                
                # Add to request history
                self._add_to_history({
                    'id': request_id,
                    'type': 'chat-completion-stream',
                    'model': model,
                    'params': self._sanitize_for_logging(request_params),
                    'status': 'success',
                    'timestamp': datetime.utcnow().isoformat()
                })
                
                # Return the stream directly
                return stream
            
            # Make API call to OpenAI
            response = await self.client.chat.completions.create(**request_params)
            
            duration = time.time() - start_time
            self.logger.info(f"[{self.name}] Chat completion completed in {duration:.2f}s ({request_id})")
            
            # Process and format response
            formatted_result = {
                'id': response.id,
                'object': response.object,
                'created': response.created,
                'model': response.model,
                'choices': [choice.model_dump() for choice in response.choices],
                'usage': response.usage.model_dump() if response.usage else None,
                'system_fingerprint': response.system_fingerprint,
                'duration': duration,
                'timestamp': datetime.utcnow().isoformat()
            }
            
            # Add to request history
            self._add_to_history({
                'id': request_id,
                'type': 'chat-completion',
                'model': model,
                'params': self._sanitize_for_logging(request_params),
                'status': 'success',
                'usage': response.usage.model_dump() if response.usage else None,
                'duration': duration,
                'timestamp': datetime.utcnow().isoformat()
            })
            
            return formatted_result
        except Exception as e:
            duration = time.time() - start_time
            self.logger.error(f"[{self.name}] Chat completion failed ({request_id}): {str(e)}")
            
            # Add failed request to history
            self._add_to_history({
                'id': request_id,
                'type': 'chat-completion',
                'model': params.get('model', self.default_model),
                'params': self._sanitize_for_logging(params),
                'status': 'error',
                'error': str(e),
                'duration': duration,
                'timestamp': datetime.utcnow().isoformat()
            })
            
            raise
    
    async def create_embeddings(self, params: Dict[str, Any]) -> Dict[str, Any]:
        """
        Generate embeddings.
        
        Args:
            params: Embedding parameters
                - input: Text to embed (string or array of strings)
                - model: Model to use, defaults to "text-embedding-3-small"
            
        Returns:
            Embedding vectors and metadata
        """
        if not self.initialized or not self.running:
            raise RuntimeError(f"[{self.name}] Cannot create embeddings: plugin not running")
        
        request_id = str(uuid.uuid4())
        start_time = time.time()
        
        try:
            model = params.get('model', 'text-embedding-3-small')
            input_text = params['input']
            input_list = input_text if isinstance(input_text, list) else [input_text]
            
            self.logger.info(f"[{self.name}] Creating embeddings for {len(input_list)} texts with model: {model} ({request_id})")
            
            # Prepare request parameters
            request_params = {
                "model": model,
                "input": input_list
            }
            
            # Log request (exclude input text for privacy)
            self.logger.debug(f"[{self.name}] Request ({request_id}): {{'model': '{model}', 'input': '[{len(input_list)} texts]'}}")
            
            # Make API call to OpenAI
            response = await self.client.embeddings.create(**request_params)
            
            duration = time.time() - start_time
            self.logger.info(f"[{self.name}] Embeddings creation completed in {duration:.2f}s ({request_id})")
            
            # Process and format response
            data = [item.model_dump() for item in response.data]
            dimensions = len(data[0]['embedding']) if data and len(data) > 0 else 0
            
            formatted_result = {
                'id': response.id,
                'object': response.object,
                'model': response.model,
                'data': data,
                'usage': response.usage.model_dump() if response.usage else None,
                'dimensions': dimensions,
                'duration': duration,
                'timestamp': datetime.utcnow().isoformat()
            }
            
            # Add to request history
            self._add_to_history({
                'id': request_id,
                'type': 'embeddings',
                'model': model,
                'params': {
                    'model': model,
                    'input': f"[{len(input_list)} texts]"
                },
                'status': 'success',
                'usage': response.usage.model_dump() if response.usage else None,
                'duration': duration,
                'timestamp': datetime.utcnow().isoformat()
            })
            
            return formatted_result
        except Exception as e:
            duration = time.time() - start_time
            self.logger.error(f"[{self.name}] Embeddings creation failed ({request_id}): {str(e)}")
            
            # Add failed request to history
            self._add_to_history({
                'id': request_id,
                'type': 'embeddings',
                'model': params.get('model', 'text-embedding-3-small'),
                'params': {
                    'model': params.get('model', 'text-embedding-3-small'),
                    'input': f"[{len(input_list) if 'input' in params and isinstance(params['input'], list) else 1} texts]"
                },
                'status': 'error',
                'error': str(e),
                'duration': duration,
                'timestamp': datetime.utcnow().isoformat()
            })
            
            raise
    
    async def create_image(self, params: Dict[str, Any]) -> Dict[str, Any]:
        """
        Create an image using DALL-E.
        
        Args:
            params: Image generation parameters
                - prompt: The image description
                - model: Model to use, defaults to "dall-e-3"
                - n: Number of images to generate (1-10)
                - size: Image size (e.g., "1024x1024")
                - quality: Image quality ("standard" or "hd")
                - style: Image style ("vivid" or "natural")
            
        Returns:
            Generated images and metadata
        """
        if not self.initialized or not self.running:
            raise RuntimeError(f"[{self.name}] Cannot create image: plugin not running")
        
        request_id = str(uuid.uuid4())
        start_time = time.time()
        
        try:
            model = params.get('model', 'dall-e-3')
            self.logger.info(f"[{self.name}] Creating image with model: {model} ({request_id})")
            
            # Prepare request parameters
            request_params = {
                "model": model,
                "prompt": params['prompt'],
                "n": params.get('n', 1),
                "size": params.get('size', '1024x1024'),
                "quality": params.get('quality', 'standard'),
                "style": params.get('style', 'vivid')
            }
            
            # Log request (include prompt since it's needed for context)
            self.logger.debug(f"[{self.name}] Request ({request_id}): {request_params}")
            
            # Make API call to OpenAI
            response = await self.client.images.generate(**request_params)
            
            duration = time.time() - start_time
            self.logger.info(f"[{self.name}] Image creation completed in {duration:.2f}s ({request_id})")
            
            # Process and format response
            data = [item.model_dump() for item in response.data]
            
            formatted_result = {
                'created': response.created,
                'data': data,
                'duration': duration,
                'timestamp': datetime.utcnow().isoformat()
            }
            
            # Add to request history
            self._add_to_history({
                'id': request_id,
                'type': 'image-generation',
                'model': model,
                'params': request_params,
                'status': 'success',
                'duration': duration,
                'timestamp': datetime.utcnow().isoformat()
            })
            
            return formatted_result
        except Exception as e:
            duration = time.time() - start_time
            self.logger.error(f"[{self.name}] Image creation failed ({request_id}): {str(e)}")
            
            # Add failed request to history
            self._add_to_history({
                'id': request_id,
                'type': 'image-generation',
                'model': params.get('model', 'dall-e-3'),
                'params': {
                    'model': params.get('model', 'dall-e-3'),
                    'prompt': params.get('prompt', '')
                },
                'status': 'error',
                'error': str(e),
                'duration': duration,
                'timestamp': datetime.utcnow().isoformat()
            })
            
            raise
    
    async def create_transcription(self, params: Dict[str, Any]) -> Dict[str, Any]:
        """
        Transcribe audio to text.
        
        Args:
            params: Transcription parameters
                - file: Audio file to transcribe
                - model: Model to use, defaults to "whisper-1"
                - language: Language code (e.g., "en")
                - prompt: Optional prompt to guide transcription
                - response_format: Response format (e.g., "json", "text")
            
        Returns:
            Transcription result
        """
        if not self.initialized or not self.running:
            raise RuntimeError(f"[{self.name}] Cannot create transcription: plugin not running")
        
        request_id = str(uuid.uuid4())
        start_time = time.time()
        
        try:
            model = params.get('model', 'whisper-1')
            self.logger.info(f"[{self.name}] Creating transcription with model: {model} ({request_id})")
            
            # Prepare request parameters
            request_params = {
                "file": params['file'],
                "model": model,
                "language": params.get('language'),
                "prompt": params.get('prompt'),
                "response_format": params.get('response_format', 'json')
            }
            
            # Remove None values
            request_params = {k: v for k, v in request_params.items() if v is not None}
            
            # Log request (exclude file for brevity)
            log_params = request_params.copy()
            log_params['file'] = '[audio file]'
            self.logger.debug(f"[{self.name}] Request ({request_id}): {log_params}")
            
            # Make API call to OpenAI
            response = await self.client.audio.transcriptions.create(**request_params)
            
            duration = time.time() - start_time
            self.logger.info(f"[{self.name}] Transcription completed in {duration:.2f}s ({request_id})")
            
            # Process and format response
            formatted_result = {
                'text': response.text,
                'duration': duration,
                'timestamp': datetime.utcnow().isoformat()
            }
            
            # Add to request history
            self._add_to_history({
                'id': request_id,
                'type': 'transcription',
                'model': model,
                'params': {
                    'model': model,
                    'language': params.get('language'),
                    'response_format': params.get('response_format', 'json')
                },
                'status': 'success',
                'duration': duration,
                'timestamp': datetime.utcnow().isoformat()
            })
            
            return formatted_result
        except Exception as e:
            duration = time.time() - start_time
            self.logger.error(f"[{self.name}] Transcription failed ({request_id}): {str(e)}")
            
            # Add failed request to history
            self._add_to_history({
                'id': request_id,
                'type': 'transcription',
                'model': params.get('model', 'whisper-1'),
                'params': {
                    'model': params.get('model', 'whisper-1'),
                    'language': params.get('language')
                },
                'status': 'error',
                'error': str(e),
                'duration': duration,
                'timestamp': datetime.utcnow().isoformat()
            })
            
            raise
    
    async def list_models(self) -> List[Dict[str, Any]]:
        """
        List available models.
        
        Returns:
            List of available models
        """
        if not self.initialized:
            raise RuntimeError(f"[{self.name}] Cannot list models: plugin not initialized")
        
        try:
            response = await self.client.models.list()
            return [model.model_dump() for model in response.data]
        except Exception as e:
            self.logger.error(f"[{self.name}] List models failed: {str(e)}")
            raise
    
    async def retrieve_model(self, model_id: str) -> Dict[str, Any]:
        """
        Get information about a specific model.
        
        Args:
            model_id: Model ID
            
        Returns:
            Model information
        """
        if not self.initialized:
            raise RuntimeError(f"[{self.name}] Cannot retrieve model: plugin not initialized")
        
        try:
            model = await self.client.models.retrieve(model_id)
            return model.model_dump()
        except Exception as e:
            self.logger.error(f"[{self.name}] Retrieve model failed: {str(e)}")
            raise
    
    def _sanitize_for_logging(self, params: Dict[str, Any]) -> Dict[str, Any]:
        """
        Sanitize parameters for logging (remove sensitive data)
        
        Args:
            params: Parameters to sanitize
            
        Returns:
            Sanitized parameters
        """
        sanitized = params.copy()
        
        # Remove or truncate potentially sensitive or large fields
        if 'messages' in sanitized:
            sanitized['messages'] = f"[{len(sanitized['messages'])} messages]"
        
        if 'input' in sanitized and isinstance(sanitized['input'], list):
            sanitized['input'] = f"[{len(sanitized['input'])} texts]"
        elif 'input' in sanitized:
            sanitized['input'] = f"[{len(str(sanitized['input']))} chars]"
        
        if 'file' in sanitized:
            sanitized['file'] = '[audio file]'
        
        return sanitized
    
    def _add_to_history(self, entry: Dict[str, Any]):
        """
        Add a request to the history
        
        Args:
            entry: History entry
        """
        self.request_history.insert(0, entry)
        
        # Trim history if it exceeds max size
        if len(self.request_history) > self.max_history_size:
            self.request_history = self.request_history[:self.max_history_size]
    
    def get_request_history(self, limit: int = None) -> List[Dict[str, Any]]:
        """
        Get request history
        
        Args:
            limit: Maximum number of entries to return
            
        Returns:
            Request history
        """
        if limit is not None and limit > 0:
            return self.request_history[:limit]
        return self.request_history
    
    def get_status(self) -> Dict[str, Any]:
        """
        Get plugin status.
        
        Returns:
            Status information
        """
        return {
            'name': self.name,
            'version': self.version,
            'description': self.description,
            'initialized': self.initialized,
            'running': self.running,
            'default_model': self.default_model,
            'requests_processed': len(self.request_history),
            'last_request_timestamp': self.request_history[0]['timestamp'] if self.request_history else None,
            'timestamp': datetime.utcnow().isoformat()
        }
    
    def to_json(self) -> str:
        """
        Convert plugin status to JSON.
        
        Returns:
            JSON string representation of plugin status
        """
        return json.dumps(self.get_status())


# Example usage
if __name__ == "__main__":
async def run_example():
# Create plugin instance
plugin = SafeguardOpenAIPlugin({
'name': 'openai-assistant',
'api_key': 'your-openai-api-key-here'  # Replace with actual API key
})

        # Initialize and start
        await plugin.initialize({})
        await plugin.start()
        
        try:
            # Generate chat completion
            completion = await plugin.create_chat_completion({
                'messages': [
                    {'role': 'system', 'content': 'You are a helpful assistant specialized in robotics.'},
                    {'role': 'user', 'content': 'What are the key safety considerations for autonomous robots?'}
                ]
            })
            
            print(f"Completion: {completion['choices'][0]['message']['content']}")
            
            # Generate embeddings
            embeddings = await plugin.create_embeddings({
                'input': [
                    'Autonomous navigation systems',
                    'Computer vision for robotics',
                    'Safety protocols for autonomous vehicles'
                ]
            })
            
            print(f"Embedding dimensions: {embeddings['dimensions']}")
        
        except Exception as e:
            print(f"API request error: {e}")
        
        # Get status
        status = plugin.get_status()
        print(f"Plugin status: {status}")
        
        # Stop the plugin
        await plugin.stop()
    
    asyncio.run(run_example())
```
<llm-snippet-file>_safeguard-plugin-system/templates/python/openai-llm-api/requirements.txt</llm-snippet-file>
```

# Requirements for the Safeguard OpenAI LLM API Plugin
openai>=1.3.0
aiohttp>=3.8.5
```
<llm-snippet-file>_safeguard-plugin-system/templates/python/openai-llm-api/README.md</llm-snippet-file>
```
markdown
# Safeguard OpenAI API Python Plugin Template

This template provides a structure for creating a Safeguard plugin in Python that interacts with the OpenAI API for language model inference, embeddings generation, image creation, and audio transcription.

## Features

- Chat completions with GPT models
- Embeddings generation for semantic search and NLP tasks
- Image generation with DALL-E models
- Audio transcription with Whisper
- Request history tracking and management
- Model listing and information retrieval
- Comprehensive error handling and logging
- Async/await support

## Prerequisites

- OpenAI API key
- Python 3.7 or higher
- Required Python packages (see requirements.txt)

## Usage

1. Clone this template
2. Install dependencies with `pip install -r requirements.txt`
3. Set your OpenAI API key in the configuration
4. Initialize and use the plugin in your application

## Configuration Options

- `api_key`: OpenAI API key (required)
- `organization`: OpenAI organization ID (optional)
- `default_model`: Default model to use for chat completions (default: 'gpt-4o')
- `base_url`: API base URL (optional, for custom endpoints)
- `timeout`: Request timeout in seconds (default: 60)
- `max_history_size`: Maximum number of requests to keep in history (default: 100)
- `validate_api_key`: Whether to validate the API key during initialization (default: True)

## API Methods

### Chat Completions

```textmate
completion = await plugin.create_chat_completion({
    "messages": [
        {"role": "system", "content": "You are a helpful assistant."},
        {"role": "user", "content": "Tell me about autonomous systems."}
    ],
    "model": "gpt-4o",  # optional, uses default_model if not specified
    "temperature": 0.7,
    "max_tokens": 1000,
    "tools": [{
        "type": "function",
        "function": {
            "name": "get_weather",
            "description": "Get the current weather in a location",
            "parameters": {
                "type": "object",
                "properties": {
                    "location": {
                        "type": "string",
                        "description": "The city and state, e.g. San Francisco, CA"
                    }
                },
                "required": ["location"]
            }
        }
    }]
})
```


### Embeddings Generation

```textmate
embeddings = await plugin.create_embeddings({
    "input": ["Autonomous systems require robust safety measures"],
    "model": "text-embedding-3-small"  # optional
})
```


### Image Generation

```textmate
images = await plugin.create_image({
    "prompt": "A futuristic autonomous vehicle navigating a city at night",
    "model": "dall-e-3",  # optional
    "size": "1024x1024",
    "quality": "hd",
    "style": "vivid"
})
```


### Audio Transcription

```textmate
import io

# Create file-like object
with open("audio.mp3", "rb") as f:
    audio_data = f.read()

audio_file = io.BytesIO(audio_data)
audio_file.name = "audio.mp3"  # Name required by OpenAI API

transcription = await plugin.create_transcription({
    "file": audio_file,
    "model": "whisper-1",  # optional
    "language": "en",
    "response_format": "json"
})
```


### Model Management

```textmate
# List available models
models = await plugin.list_models()

# Get information about a specific model
model_info = await plugin.retrieve_model("gpt-4o")
```


## Example

```textmate
import asyncio
from plugin import SafeguardOpenAIPlugin
import io

async def run():
    # Create plugin instance
    plugin = SafeguardOpenAIPlugin({
        'name': 'openai-assistant',
        'api_key': 'your-openai-api-key'
    })
    
    # Initialize and use the plugin
    await plugin.initialize({})
    await plugin.start()
    
    # Generate chat completion
    completion = await plugin.create_chat_completion({
        'messages': [
            {'role': 'system', 'content': 'You are a helpful assistant specialized in robotics.'},
            {'role': 'user', 'content': 'What are the key safety considerations for autonomous robots?'}
        ]
    })
    
    print(f"Completion: {completion['choices'][0]['message']['content']}")
    
    # Generate embeddings for semantic search
    embeddings = await plugin.create_embeddings({
        'input': [
            'Autonomous navigation systems',
            'Computer vision for robotics',
            'Safety protocols for autonomous vehicles'
        ]
    })
    
    print(f"Embedding dimensions: {embeddings['dimensions']}")
    
    await plugin.stop()

# Run the example
asyncio.run(run())
```


## Error Handling

The plugin includes built-in error handling and logging:

- API request failures (connection issues, timeouts)
- API response errors (invalid parameters, rate limits)
- Plugin state validation (ensuring the plugin is initialized and running)

All errors are logged and can be tracked through the request history.

## Extending the Plugin

To extend the functionality of the OpenAI plugin, subclass `SafeguardOpenAIPlugin` and override the methods you want to customize:

```textmate
from plugin import SafeguardOpenAIPlugin

class CustomOpenAIPlugin(SafeguardOpenAIPlugin):
    async def initialize(self, context):
        # Add custom initialization logic
        result = await super().initialize(context)
        
        # Set up specialized handlers
        self.handlers = {
            'summarize': self.handle_summarization,
            'question': self.handle_question
        }
        
        return result
    
    async def handle_summarization(self, text, max_length=100):
        """Custom method for text summarization"""
        result = await self.create_chat_completion({
            'messages': [
                {'role': 'system', 'content': 'You are a concise summarization assistant.'},
                {'role': 'user', 'content': f'Please summarize the following text in {max_length} words or less:\n\n{text}'}
            ]
        })
        return result['choices'][0]['message']['content']
    
    async def handle_question(self, question):
        """Custom method for answering questions"""
        result = await self.create_chat_completion({
            'messages': [
                {'role': 'system', 'content': 'You are a helpful, accurate, and concise assistant.'},
                {'role': 'user', 'content': question}
            ]
        })
        return result['choices'][0]['message']['content']
```


## License

Copyright 2025 Autonomy Association International Inc., all rights reserved.
```
<llm-snippet-file>_safeguard-plugin-system/templates/python/openai-llm-api/example.py</llm-snippet-file>
```
python
"""
Example usage of the OpenAI API Safeguard Plugin
"""

import asyncio
import logging
from datetime import datetime
import io
import os
import json
from plugin import SafeguardOpenAIPlugin

# Configure root logger
logging.basicConfig(
level=logging.INFO,
format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)

async def demonstrate_openai():
"""
Demonstrate the OpenAI plugin functionality
"""
try:
# Create plugin instance with your API key
# NOTE: Replace 'your-openai-api-key' with your actual API key
plugin = SafeguardOpenAIPlugin({
'name': 'openai-assistant',
'version': '1.0.0',
'description': 'OpenAI Integration Example',
'api_key': 'your-openai-api-key',
'default_model': 'gpt-4o',
'log_level': logging.DEBUG
})

        # Initialize the plugin
        print("Initializing OpenAI plugin...")
        await plugin.initialize({
            'app_context': { 
                'app_version': '1.0.0',
                'environment': 'development'
            }
        })
        
        # Start the plugin
        print("\nStarting plugin...")
        await plugin.start()
        
        # Get plugin status
        print("\nPlugin status:")
        print(plugin.to_json())
        
        # List available models
        try:
            print("\nListing available models...")
            models = await plugin.list_models()
            print(f"Available models: {len(models)}")
            # Show first 5 models
            print(", ".join([m['id'] for m in models[:5]]))
        except Exception as model_error:
            print(f"Error listing models: {model_error}")
            print("Continuing with the default model")
        
        # Create chat completion
        try:
            print("\nCreating chat completion...")
            completion_result = await plugin.create_chat_completion({
                'messages': [
                    {'role': 'system', 'content': 'You are a helpful assistant specializing in robotics and autonomous systems.'},
                    {'role': 'user', 'content': 'What are the three most important safety considerations for autonomous robots in urban environments? Please be concise.'}
                ],
                'temperature': 0.7,
                'max_tokens': 300
            })
            
            print("\nChat completion result:")
            print(f"Model: {completion_result['model']}")
            print(f"Response: {completion_result['choices'][0]['message']['content']}")
            if completion_result['usage']:
                print(f"Usage: {completion_result['usage']}")
            print(f"Duration: {completion_result['duration']:.2f} seconds")
        except Exception as completion_error:
            print(f"Error creating chat completion: {completion_error}")
        
        # Create chat completion with tools
        try:
            print("\nCreating chat completion with tools...")
            tools_result = await plugin.create_chat_completion({
                'messages': [
                    {'role': 'system', 'content': 'You are a helpful assistant with access to tools.'},
                    {'role': 'user', 'content': "What's the weather like in New York today?"}
                ],
                'tools': [
                    {
                        'type': 'function',
                        'function': {
                            'name': 'get_weather',
                            'description': 'Get the current weather in a location',
                            'parameters': {
                                'type': 'object',
                                'properties': {
                                    'location': {
                                        'type': 'string',
                                        'description': 'The city and state, e.g. San Francisco, CA'
                                    }
                                },
                                'required': ['location']
                            }
                        }
                    }
                ]
            })
            
            print("\nTools completion result:")
            print(f"Model: {tools_result['model']}")
            
            message = tools_result['choices'][0]['message']
            content = message.get('content')
            tool_calls = message.get('tool_calls', [])
            
            if content is None and tool_calls:
                print("Response type: Tool call")
                for tool_call in tool_calls:
                    function = tool_call.get('function', {})
                    print(f"Tool call: {function.get('name')}")
                    print(f"Arguments: {function.get('arguments')}")
            else:
                print("Response type: Content")
                print(f"Content: {content}")
        except Exception as tools_error:
            print(f"Error creating chat completion with tools: {tools_error}")
        
        # Generate embeddings
        try:
            print("\nGenerating embeddings...")
            embeddings_result = await plugin.create_embeddings({
                'input': [
                    "Autonomous robots must prioritize human safety",
                    "Vision systems are critical for environmental awareness"
                ]
            })
            
            print("\nEmbeddings result:")
            print(f"Model: {embeddings_result['model']}")
            print(f"Embedding count: {len(embeddings_result['data'])}")
            print(f"Dimensions: {embeddings_result['dimensions']}")
            print(f"First embedding (first 5 values): {embeddings_result['data'][0]['embedding'][:5]}")
            if embeddings_result['usage']:
                print(f"Usage: {embeddings_result['usage']}")
            print(f"Duration: {embeddings_result['duration']:.2f} seconds")
        except Exception as embeddings_error:
            print(f"Error generating embeddings: {embeddings_error}")
        
        # Generate image (commented out to avoid charges)
        """
        try:
            print("\nGenerating image...")
            image_result = await plugin.create_image({
                'prompt': "A futuristic autonomous robot safely interacting with humans in an urban park, digital art style",
                'size': "1024x1024",
                'quality': "standard",
                'style': "vivid"
            })
            
            print("\nImage generation result:")
            print(f"Image URL: {image_result['data'][0]['url']}")
            print(f"Duration: {image_result['duration']:.2f} seconds")
        except Exception as image_error:
            print(f"Error generating image: {image_error}")
        """
        
        # Audio transcription (commented out as it requires an audio file)
        """
        try:
            print("\nTranscribing audio...")
            # Create a mock audio file or load a real one
            audio_path = "sample-audio.mp3"
            
            if os.path.exists(audio_path):
                with open(audio_path, "rb") as f:
                    audio_data = f.read()
                
                audio_file = io.BytesIO(audio_data)
                audio_file.name = "audio.mp3"  # Name required by OpenAI API
                
                transcription_result = await plugin.create_transcription({
                    'file': audio_file,
                    'language': 'en'
                })
                
                print("\nTranscription result:")
                print(f"Text: {transcription_result['text']}")
                print(f"Duration: {transcription_result['duration']:.2f} seconds")
            else:
                print("Skipping transcription: audio file not found")
        except Exception as transcription_error:
            print(f"Error transcribing audio: {transcription_error}")
        """
        
        # Get request history
        print("\nRequest history:")
        history = plugin.get_request_history(5)
        for entry in history:
            print(f"- {entry['type']} ({entry['id'][:8]}): {entry['status']}, Model: {entry['model']}, Duration: {entry['duration']:.2f}s")
        
        # Stop the plugin
        print("\nStopping plugin...")
        await plugin.stop()
        
        # Final status
        print("\nFinal plugin status:")
        print(plugin.to_json())
        
    except Exception as e:
        print(f"Error in OpenAI demonstration: {e}")

# Run the demonstration
if __name__ == "__main__":
asyncio.run(demonstrate_openai())
```
### 6. Anthropic LLM API Python Template

<llm-snippet-file>_safeguard-plugin-system/templates/python/anthropic-llm-api/plugin.py</llm-snippet-file>
```
python
"""
Anthropic LLM API Safeguard Plugin Template

This template provides a structure for creating a Safeguard plugin in Python
that interacts with the Anthropic API for Claude language model inference.

Copyright 2025 Autonomy Association International Inc., all rights reserved.
"""

import logging
import uuid
import json
import asyncio
import time
from datetime import datetime
from typing import Dict, Any, Optional, List, Union, Callable

import aiohttp
import anthropic
from anthropic import AsyncAnthropic

class SafeguardAnthropicPlugin:
"""
Anthropic Claude API template for a Safeguard plugin.

    This class provides a foundation for building Safeguard plugins that interact with
    the Anthropic API for Claude language model inference.
    """
    
    def __init__(self, config: Dict[str, Any] = None):
        """
        Initialize the plugin with configuration.
        
        Args:
            config: Dictionary containing plugin configuration
        """
        config = config or {}
        self.name = config.get('name', 'anthropic-plugin')
        self.version = config.get('version', '1.0.0')
        self.description = config.get('description', 'Anthropic API Safeguard Plugin')
        self.config = config
        self.initialized = False
        self.running = False
        
        # Anthropic specific configuration
        self.api_key = config.get('api_key')
        self.default_model = config.get('default_model', 'claude-3-opus-20240229')
        self.base_url = config.get('base_url')
        self.timeout = config.get('timeout', 60)  # 60 seconds default
        self.request_history = []
        self.max_history_size = config.get('max_history_size', 100)
        
        # Configure logging
        self.logger = self._setup_logging()
        self.logger.info(f"[{self.name}] Plugin instance created")
        
        # Anthropic client will be created during initialization
        self.client = None
    
    def _setup_logging(self) -> logging.Logger:
        """
        Set up the plugin's logger.
        
        Returns:
            Logger instance
        """
        logger = logging.getLogger(f"safeguard.plugin.{self.name}")
        if not logger.handlers:
            handler = logging.StreamHandler()
            formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
            handler.setFormatter(formatter)
            logger.addHandler(handler)
            logger.setLevel(self.config.get('log_level', logging.INFO))
        return logger
    
    async def initialize(self, context: Dict[str, Any]) -> bool:
        """
        Initialize the plugin.
        
        Args:
            context: Initialization context
            
        Returns:
            True if initialization successful, False otherwise
        """
        try:
            self.logger.info(f"[{self.name}] Initializing plugin v{self.version}")
            self.context = context
            
            if not self.api_key:
                raise ValueError("API key is required for Anthropic API")
            
            # Initialize Anthropic client
            client_options = {
                "api_key": self.api_key,
                "timeout": self.timeout
            }
            
            if self.base_url:
                client_options["base_url"] = self.base_url
            
            self.client = AsyncAnthropic(**client_options)
            
            # Validate API key by testing a simple request
            if self.config.get('validate_api_key', True):
                try:
                    await self.test_connection()
                    self.logger.info(f"[{self.name}] API key validation successful")
                except Exception as e:
                    raise ValueError(f"API key validation failed: {str(e)}")
            
            self.initialized = True
            return True
        except Exception as e:
            self.logger.error(f"[{self.name}] Initialization failed: {str(e)}")
            return False
    
    async def test_connection(self) -> Dict[str, Any]:
        """
        Test connection to the Anthropic API.
        
        Returns:
            Response from API test
        """
        try:
            # Test with a minimal message to validate API key
            response = await self.client.messages.create(
                model=self.default_model,
                max_tokens=10,
                messages=[
                    {"role": "user", "content": "Hello"}
                ]
            )
            
            if not response or not response.id:
                raise ValueError("Invalid response from Anthropic API")
            
            return response.model_dump()
        except Exception as e:
            self.logger.error(f"[{self.name}] Connection test failed: {str(e)}")
            raise
    
    async def start(self) -> bool:
        """
        Start the plugin.
        
        Returns:
            True if start successful, False otherwise
        """
        if not self.initialized:
            self.logger.error(f"[{self.name}] Cannot start: plugin not initialized")
            return False
        
        try:
            self.logger.info(f"[{self.name}] Starting plugin...")
            self.running = True
            return True
        except Exception as e:
            self.logger.error(f"[{self.name}] Start failed: {str(e)}")
            return False
    
    async def stop(self) -> bool:
        """
        Stop the plugin.
        
        Returns:
            True if stop successful, False otherwise
        """
        if not self.running:
            self.logger.info(f"[{self.name}] Plugin already stopped")
            return True
        
        try:
            self.logger.info(f"[{self.name}] Stopping plugin...")
            self.running = False
            
            # Close resources if necessary
            # Nothing to close for Anthropic client
            
            return True
        except Exception as e:
            self.logger.error(f"[{self.name}] Stop failed: {str(e)}")
            return False
    
    async def create_message(self, params: Dict[str, Any]) -> Dict[str, Any]:
        """
        Create a message using Claude.
        
        Args:
            params: Message parameters
                - messages: Message array
                - model: Model to use, defaults to self.default_model
                - max_tokens: Maximum tokens to generate
                - temperature: Sampling temperature (0.0-1.0)
                - top_p: Nucleus sampling parameter (0.0-1.0)
                - top_k: Top-k sampling parameter
                - stream: Whether to stream the response
                - tools: Tools available to the model
                - system: System prompt
            
        Returns:
            Message completion result
        """
        if not self.initialized or not self.running:
            raise RuntimeError(f"[{self.name}] Cannot create message: plugin not running")
        
        request_id = str(uuid.uuid4())
        start_time = time.time()
        
        try:
            model = params.get('model', self.default_model)
            self.logger.info(f"[{self.name}] Creating message with model: {model} ({request_id})")
            
            # Prepare request parameters
            request_params = {
                "model": model,
                "messages": params['messages'],
                "max_tokens": params.get('max_tokens', 1024),
                "temperature": params.get('temperature', 0.7),
                "top_p": params.get('top_p', 0.9),
                "top_k": params.get('top_k', 40),
                "stream": params.get('stream', False),
                "tools": params.get('tools'),
                "system": params.get('system')
            }
            
            # Remove None values
            request_params = {k: v for k, v in request_params.items() if v is not None}
            
            # Log request (exclude messages for privacy)
            self.logger.debug(f"[{self.name}] Request ({request_id}): {self._sanitize_for_logging(request_params)}")
            
            # Handle streaming response
            if params.get('stream', False):
                stream = await self.client.messages.create(**request_params)
                
                # Add to request history
                self._add_to_history({
                    'id': request_id,
                    'type': 'message-stream',
                    'model': model,
                    'params': self._sanitize_for_logging(request_params),
                    'status': 'success',
                    'timestamp': datetime.utcnow().isoformat()
                })
                
                # Return the stream directly
                return stream
            
            # Make API call to Anthropic
            response = await self.client.messages.create(**request_params)
            
            duration = time.time() - start_time
            self.logger.info(f"[{self.name}] Message creation completed in {duration:.2f}s ({request_id})")
            
            # Process and format response
            response_dict = response.model_dump()
            formatted_result = {
                'id': response.id,
                'model': response.model,
                'type': response.type,
                'role': response.role,
                'content': response_dict.get('content', []),
                'stop_reason': response.stop_reason,
                'stop_sequence': response.stop_sequence,
                'usage': response_dict.get('usage'),
                'duration': duration,
                'timestamp': datetime.utcnow().isoformat()
            }
            
            # Add to request history
            self._add_to_history({
                'id': request_id,
                'type': 'message',
                'model': model,
                'params': self._sanitize_for_logging(request_params),
                'status': 'success',
                'usage': response_dict.get('usage'),
                'duration': duration,
                'timestamp': datetime.utcnow().isoformat()
            })
            
            return formatted_result
        except Exception as e:
            duration = time.time() - start_time
            self.logger.error(f"[{self.name}] Message creation failed ({request_id}): {str(e)}")
            
            # Add failed request to history
            self._add_to_history({
                'id': request_id,
                'type': 'message',
                'model': params.get('model', self.default_model),
                'params': self._sanitize_for_logging(params),
                'status': 'error',
                'error': str(e),
                'duration': duration,
                'timestamp': datetime.utcnow().isoformat()
            })
            
            raise
    
    async def create_completion(self, params: Dict[str, Any]) -> Dict[str, Any]:
        """
        Complete a prompt using Claude (legacy API).
        
        Args:
            params: Completion parameters
                - prompt: The input prompt
                - model: Model to use, defaults to self.default_model
                - max_tokens_to_sample: Maximum tokens to generate
                - temperature: Sampling temperature (0.0-1.0)
                - top_p: Nucleus sampling parameter (0.0-1.0)
                - top_k: Top-k sampling parameter
                - stop_sequences: Sequences that stop generation
                - stream: Whether to stream the response
            
        Returns:
            Completion result
        """
        if not self.initialized or not self.running:
            raise RuntimeError(f"[{self.name}] Cannot create completion: plugin not running")
        
        request_id = str(uuid.uuid4())
        start_time = time.time()
        
        try:
            model = params.get('model', self.default_model)
            self.logger.info(f"[{self.name}] Creating completion with model: {model} ({request_id})")
            
            # Prepare request parameters
            request_params = {
                "model": model,
                "prompt": params['prompt'],
                "max_tokens_to_sample": params.get('max_tokens_to_sample', 1024),
                "temperature": params.get('temperature', 0.7),
                "top_p": params.get('top_p', 0.9),
                "top_k": params.get('top_k', 40),
                "stop_sequences": params.get('stop_sequences', []),
                "stream": params.get('stream', False)
            }
            
            # Remove None values
            request_params = {k: v for k, v in request_params.items() if v is not None}
            
            # Log request (exclude prompt for privacy)
            self.logger.debug(f"[{self.name}] Request ({request_id}): {self._sanitize_for_logging(request_params)}")
            
            # Handle streaming response
            if params.get('stream', False):
                stream = await self.client.completions.create(**request_params)
                
                # Add to request history
                self._add_to_history({
                    'id': request_id,
                    'type': 'completion-stream',
                    'model': model,
                    'params': self._sanitize_for_logging(request_params),
                    'status': 'success',
                    'timestamp': datetime.utcnow().isoformat()
                })
                
                # Return the stream directly
                return stream
            
            # Make API call to Anthropic
            response = await self.client.completions.create(**request_params)
            
            duration = time.time() - start_time
            self.logger.info(f"[{self.name}] Completion created in {duration:.2f}s ({request_id})")
            
            # Process and format response
            response_dict = response.model_dump()
            formatted_result = {
                'id': response.id,
                'model': response.model,
                'completion': response.completion,
                'stop_reason': response.stop_reason,
                'stop_sequence': response.stop_sequence,
                'duration': duration,
                'timestamp': datetime.utcnow().isoformat()
            }
            
            # Add to request history
            self._add_to_history({
                'id': request_id,
                'type': 'completion',
                'model': model,
                'params': self._sanitize_for_logging(request_params),
                'status': 'success',
                'duration': duration,
                'timestamp': datetime.utcnow().isoformat()
            })
            
            return formatted_result
        except Exception as e:
            duration = time.time() - start_time
            self.logger.error(f"[{self.name}] Completion failed ({request_id}): {str(e)}")
            
            # Add failed request to history
            self._add_to_history({
                'id': request_id,
                'type': 'completion',
                'model': params.get('model', self.default_model),
                'params': self._sanitize_for_logging(params),
                'status': 'error',
                'error': str(e),
                'duration': duration,
                'timestamp': datetime.utcnow().isoformat()
            })
            
            raise
    
    def _sanitize_for_logging(self, params: Dict[str, Any]) -> Dict[str, Any]:
        """
        Sanitize parameters for logging (remove sensitive data)
        
        Args:
            params: Parameters to sanitize
            
        Returns:
            Sanitized parameters
        """
        sanitized = params.copy()
        
        # Remove or truncate potentially sensitive or large fields
        if 'messages' in sanitized:
            sanitized['messages'] = f"[{len(sanitized['messages'])} messages]"
        
        if 'prompt' in sanitized:
            sanitized['prompt'] = f"[{len(sanitized['prompt'])} chars]"
        
        if 'system' in sanitized:
            sanitized['system'] = f"[system prompt: {len(sanitized['system'])} chars]"
        
        return sanitized
    
    def _add_to_history(self, entry: Dict[str, Any]):
        """
        Add a request to the history
        
        Args:
            entry: History entry
        """
        self.request_history.insert(0, entry)
        
        # Trim history if it exceeds max size
        if len(self.request_history) > self.max_history_size:
            self.request_history = self.request_history[:self.max_history_size]
    
    def get_request_history(self, limit: int = None) -> List[Dict[str, Any]]:
        """
        Get request history
        
        Args:
            limit: Maximum number of entries to return
            
        Returns:
            Request history
        """
        if limit is not None and limit > 0:
            return self.request_history[:limit]
        return self.request_history
    
    def format_messages(self, messages: List[Dict[str, Any]]) -> List[Dict[str, Any]]:
        """
        Format messages in the Anthropic message format
        
        Args:
            messages: Array of messages
            
        Returns:
            Formatted messages
        """
        formatted = []
        for message in messages:
            role = message.get('role')
            if role == 'assistant' or role == 'user':
                formatted.append({
                    'role': role,
                    'content': message.get('content')
                })
            elif role == 'system':
                # System messages are handled differently in Anthropic API
                # (in create_message method as system parameter)
                continue
        
        return formatted
    
    def get_available_models(self) -> List[Dict[str, Any]]:
        """
        Get available models
        
        Returns:
            List of available Claude models
        """
        return [
            {
                'id': 'claude-3-opus-20240229',
                'name': 'Claude 3 Opus',
                'description': 'Most powerful Claude model for highly complex tasks',
                'context_window': 200000,
                'created': '2024-02-29'
            },
            {
                'id': 'claude-3-sonnet-20240229',
                'name': 'Claude 3 Sonnet',
                'description': 'Balanced model for most tasks',
                'context_window': 200000,
                'created': '2024-02-29'
            },
            {
                'id': 'claude-3-haiku-20240307',
                'name': 'Claude 3 Haiku',
                'description': 'Fastest and most compact Claude model',
                'context_window': 200000,
                'created': '2024-03-07'
            },
            {
                'id': 'claude-2.1',
                'name': 'Claude 2.1',
                'description': 'Previous generation model',
                'context_window': 100000,
                'created': '2023-11-21'
            },
            {
                'id': 'claude-2.0',
                'name': 'Claude 2.0',
                'description': 'Legacy model',
                'context_window': 100000,
                'created': '2023-07-11'
            },
            {
                'id': 'claude-instant-1.2',
                'name': 'Claude Instant 1.2',
                'description': 'Fastest legacy model',
                'context_window': 100000,
                'created': '2023-03-14'
            }
        ]
    
    def get_status(self) -> Dict[str, Any]:
        """
        Get plugin status.
        
        Returns:
            Status information
        """
        return {
            'name': self.name,
            'version': self.version,
            'description': self.description,
            'initialized': self.initialized,
            'running': self.running,
            'default_model': self.default_model,
            'requests_processed': len(self.request_history),
            'last_request_timestamp': self.request_history[0]['timestamp'] if self.request_history else None,
            'timestamp': datetime.utcnow().isoformat()
        }
    
    def to_json(self) -> str:
        """
        Convert plugin status to JSON.
        
        Returns:
            JSON string representation of plugin status
        """
        return json.dumps(self.get_status())


# Example usage
if __name__ == "__main__":
async def run_example():
# Create plugin instance
plugin = SafeguardAnthropicPlugin({
'name': 'claude-assistant',
'api_key': 'your-anthropic-api-key-here'  # Replace with actual API key
})

        # Initialize and start
        await plugin.initialize({})
        await plugin.start()
        
        try:
            # Use the Messages API
            message = await plugin.create_message({
                'messages': [
                    {'role': 'user', 'content': 'What are the key safety considerations for autonomous robots?'}
                ],
                'system': 'You are a helpful assistant specialized in robotics and AI systems. Be concise and technical in your responses.'
            })
            
            # Extract text content
            text_content = ""
            for content_block in message['content']:
                if content_block['type'] == 'text':
                    text_content += content_block['text']
            
            print(f"Claude response: {text_content}")
            
            # Check available models
            models = plugin.get_available_models()
            print(f"Available Claude models: {', '.join([m['name'] for m in models])}")
        
        except Exception as e:
            print(f"API request error: {e}")
        
        # Get status
        status = plugin.get_status()
        print(f"Plugin status: {status}")
        
        # Stop the plugin
        await plugin.stop()
    
    asyncio.run(run_example())
```
<llm-snippet-file>_safeguard-plugin-system/templates/python/anthropic-llm-api/requirements.txt</llm-snippet-file>
```

# Requirements for the Safeguard Anthropic LLM API Plugin
anthropic>=0.5.0
aiohttp>=3.8.5
```
<llm-snippet-file>_safeguard-plugin-system/templates/python/anthropic-llm-api/README.md</llm-snippet-file>
```
markdown
# Safeguard Anthropic Claude API Python Plugin Template

This template provides a structure for creating a Safeguard plugin in Python that interacts with the Anthropic API for Claude language model inference. It supports both the modern Messages API and legacy Completions API for maximum compatibility.

## Features

- Message creation with Claude 3 models (recommended API)
- Text completion with Claude models (legacy API)
- Request history tracking and management
- Support for streaming responses
- Tool usage with Claude
- Comprehensive error handling and logging
- Async/await support

## Prerequisites

- Anthropic API key
- Python 3.7 or higher
- Required Python packages (see requirements.txt)

## Usage

1. Clone this template
2. Install dependencies with `pip install -r requirements.txt`
3. Set your Anthropic API key in the configuration
4. Initialize and use the plugin in your application

## Configuration Options

- `api_key`: Anthropic API key (required)
- `default_model`: Default model to use (default: 'claude-3-opus-20240229')
- `base_url`: API base URL (optional, for custom endpoints)
- `timeout`: Request timeout in seconds (default: 60)
- `max_history_size`: Maximum number of requests to keep in history (default: 100)
- `validate_api_key`: Whether to validate the API key during initialization (default: True)

## API Methods

### Messages API (Recommended)

```textmate
result = await plugin.create_message({
    "messages": [
        {"role": "user", "content": "Tell me about autonomous systems."}
    ],
    "model": "claude-3-opus-20240229",  # optional, uses default_model if not specified
    "max_tokens": 1024,
    "temperature": 0.7,
    "system": "You are a helpful assistant specialized in robotics and AI."  # optional
})
```


### Completions API (Legacy)

```textmate
result = await plugin.create_completion({
    "prompt": "\n\nHuman: Tell me about autonomous systems.\n\nAssistant:",
    "model": "claude-2.1",  # optional, uses default_model if not specified
    "max_tokens_to_sample": 1024,
    "temperature": 0.7,
    "stop_sequences": ["\n\nHuman:"]
})
```


### Using Tools

```textmate
result = await plugin.create_message({
    "messages": [
        {"role": "user", "content": "What's the weather like in San Francisco today?"}
    ],
    "tools": [
        {
            "name": "get_weather",
            "description": "Get the current weather in a location",
            "input_schema": {
                "type": "object",
                "properties": {
                    "location": {
                        "type": "string",
                        "description": "The city and state, e.g. San Francisco, CA"
                    }
                },
                "required": ["location"]
            }
        }
    ]
})
```


### Streaming Responses

```textmate
stream = await plugin.create_message({
    "messages": [
        {"role": "user", "content": "Write a poem about robots."}
    ],
    "stream": True
})

async for chunk in stream:
    if chunk.type == "content_block_delta" and chunk.delta.type == "text":
        print(chunk.delta.text, end="")
```


## Example

```textmate
import asyncio
from plugin import SafeguardAnthropicPlugin

async def run():
    # Create plugin instance
    plugin = SafeguardAnthropicPlugin({
        'name': 'claude-assistant',
        'api_key': 'your-anthropic-api-key-here'
    })
    
    # Initialize and use the plugin
    await plugin.initialize({})
    await plugin.start()
    
    # Use the Messages API
    message = await plugin.create_message({
        'messages': [
            {'role': 'user', 'content': 'What are the key safety considerations for autonomous robots?'}
        ],
        'system': 'You are a helpful assistant specialized in robotics and AI systems. Be concise and technical in your responses.'
    })
    
    # Extract text from response
    text_content = ""
    for content_block in message['content']:
        if content_block['type'] == 'text':
            text_content += content_block['text']
    
    print(f"Claude response: {text_content}")
    
    # Check available models
    models = plugin.get_available_models()
    print(f"Available Claude models: {', '.join([m['name'] for m in models])}")
    
    await plugin.stop()

# Run the example
asyncio.run(run())
```


## Error Handling

The plugin includes built-in error handling and logging:

- API request failures (connection issues, timeouts)
- API response errors (invalid parameters, rate limits)
- Plugin state validation (ensuring the plugin is initialized and running)

All errors are logged and can be tracked through the request history.

## Extending the Plugin

To extend the functionality of the Anthropic plugin, subclass `SafeguardAnthropicPlugin` and override the methods you want to customize:

```textmate
from plugin import SafeguardAnthropicPlugin

class CustomClaudePlugin(SafeguardAnthropicPlugin):
    async def initialize(self, context):
        # Add custom initialization logic
        result = await super().initialize(context)
        
        # Load custom prompt templates
        self.templates = {
            'security_analysis': "Analyze the security implications of the following system:\n\n{system_description}",
            'code_review': "Review the following code for security vulnerabilities and suggest improvements:\n\n{code}"
        }
        
        return result
    
    async def analyze_security(self, system_description):
        """Custom method for security analysis"""
        prompt = self.templates['security_analysis'].format(system_description=system_description)
        result = await self.create_message({
            'messages': [{'role': 'user', 'content': prompt}],
            'system': 'You are an expert security analyst specializing in autonomous systems.'
        })
        
        # Extract text content
        text_content = ""
        for content_block in result['content']:
            if content_block['type'] == 'text':
                text_content += content_block['text']
                
        return text_content
```


## License

Copyright 2025 Autonomy Association International Inc., all rights reserved.
```
<llm-snippet-file>_safeguard-plugin-system/templates/python/anthropic-llm-api/example.py</llm-snippet-file>
```
python
"""
Example usage of the Anthropic Claude API Safeguard Plugin
"""

import asyncio
import logging
from datetime import datetime
from plugin import SafeguardAnthropicPlugin

# Configure root logger
logging.basicConfig(
level=logging.INFO,
format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)

async def demonstrate_anthropic_claude():
"""
Demonstrate the Anthropic Claude plugin functionality
"""
try:
# Create plugin instance with your API key
# NOTE: Replace 'your-anthropic-api-key' with your actual API key
plugin = SafeguardAnthropicPlugin({
'name': 'claude-assistant',
'version': '1.0.0',
'description': 'Anthropic Claude Integration Example',
'api_key': 'your-anthropic-api-key',
'default_model': 'claude-3-sonnet-20240229',  # Using Sonnet for this example (cheaper than Opus)
'log_level': logging.DEBUG
})

        # Initialize the plugin
        print("Initializing Anthropic Claude plugin...")
        await plugin.initialize({
            'app_context': { 
                'app_version': '1.0.0',
                'environment': 'development'
            }
        })
        
        # Start the plugin
        print("\nStarting plugin...")
        await plugin.start()
        
        # Get plugin status
        print("\nPlugin status:")
        print(plugin.to_json())
        
        # List available models
        print("\nAvailable Claude models:")
        models = plugin.get_available_models()
        for model in models:
            print(f"- {model['name']} ({model['id']}): {model['description']}")
        
        # Create a message with the Messages API
        try:
            print("\nCreating message with Claude...")
            message_result = await plugin.create_message({
                'messages': [
                    {'role': 'user', 'content': 'What are three important considerations for the safe deployment of autonomous robots in urban environments? Please be concise.'}
                ],
                'system': 'You are a helpful assistant specializing in robotics, AI, and autonomous systems. Your responses should be clear, technical, and focused on safety.'
            })
            
            print("\nClaude message result:")
            print(f"Model: {message_result['model']}")
            print("Response:")
            
            # Extract text from content blocks
            for content_block in message_result['content']:
                if content_block['type'] == 'text':
                    print(content_block['text'])
            
            if message_result['usage']:
                print(f"Usage: {message_result['usage']}")
            print(f"Duration: {message_result['duration']:.2f} seconds")
        except Exception as message_error:
            print(f"Error creating message: {message_error}")
        
        # Create a message with tool use
        try:
            print("\nCreating message with tools...")
            tools_result = await plugin.create_message({
                'messages': [
                    {'role': 'user', 'content': "What's the weather like in New York City right now?"}
                ],
                'tools': [
                    {
                        'name': 'get_weather',
                        'description': 'Get the current weather in a location',
                        'input_schema': {
                            'type': 'object',
                            'properties': {
                                'location': {
                                    'type': 'string',
                                    'description': 'The city and state, e.g. San Francisco, CA'
                                },
                                'unit': {
                                    'type': 'string',
                                    'enum': ['celsius', 'fahrenheit'],
                                    'description': 'The unit of temperature'
                                }
                            },
                            'required': ['location']
                        }
                    }
                ]
            })
            
            print("\nTools message result:")
            print(f"Model: {tools_result['model']}")
            
            # Check if there's a tool use in the response
            has_tool_use = False
            for content_block in tools_result['content']:
                if content_block['type'] == 'tool_use':
                    has_tool_use = True
                    print("Tool use request:")
                    print(f"Tool: {content_block['name']}")
                    print(f"Input: {content_block['input']}")
                elif content_block['type'] == 'text':
                    print(f"Text: {content_block['text']}")
            
            if not has_tool_use:
                print("No tool use in response. Claude provided a text response instead.")
        except Exception as tools_error:
            print(f"Error creating message with tools: {tools_error}")
        
        # Try the legacy Completions API
        try:
            print("\nCreating completion with Claude (legacy API)...")
            completion_result = await plugin.create_completion({
                'prompt': '\n\nHuman: Explain how autonomous drones navigate in GPS-denied environments. Keep it brief.\n\nAssistant:',
                'max_tokens_to_sample': 300,
                'temperature': 0.7,
                'stop_sequences': ['\n\nHuman:']
            })
            
            print("\nClaude completion result (legacy API):")
            print(f"Model: {completion_result['model']}")
            print(f"Completion: {completion_result['completion']}")
            print(f"Stop reason: {completion_result['stop_reason']}")
            print(f"Duration: {completion_result['duration']:.2f} seconds")
        except Exception as completion_error:
            print(f"Error creating completion: {completion_error}")
        
        # Demonstrate streaming (commented out for clarity in console output)
        """
        try:
            print('\nDemonstrating streaming response...')
            stream = await plugin.create_message({
                'messages': [
                    {'role': 'user', 'content': 'Write a very short poem about robots and humans working together.'}
                ],
                'stream': True
            })
            
            print('\nStreaming response:')
            print()
            
            async for chunk in stream:
                if chunk.type == 'content_block_delta' and chunk.delta.type == 'text':
                    print(chunk.delta.text, end='')
            print('\n')
            
        except Exception as stream_error:
            print(f'Error with streaming response: {stream_error}')
        """
        
        # Get request history
        print("\nRequest history:")
        history = plugin.get_request_history(5)
        for entry in history:
            print(f"- {entry['type']} ({entry['id'][:8]}): {entry['status']}, Model: {entry['model']}, Duration: {entry['duration']:.2f}s")
        
        # Stop the plugin
        print("\nStopping plugin...")
        await plugin.stop()
        
        # Final status
        print("\nFinal plugin status:")
        print(plugin.to_json())
        
    except Exception as e:
        print(f"Error in Anthropic Claude demonstration: {e}")

# Run the demonstration
if __name__ == "__main__":
asyncio.run(demonstrate_anthropic_claude())
```
### 7. Llama API Python Template

<llm-snippet-file>_safeguard-plugin-system/templates/python/llama-llm-api/plugin.py</llm-snippet-file>
```
python
"""
Llama API Safeguard Plugin Template

This template provides a structure for creating a Safeguard plugin in Python
that interacts with the Llama API for language model inference.
Compatible with local LLM servers using the OpenAI API format.

Copyright 2025 Autonomy Association International Inc., all rights reserved.
"""

import logging
import uuid
import json
import asyncio
import time
from datetime import datetime
from typing import Dict, Any, Optional, List, Union, Callable

import aiohttp

class SafeguardLlamaPlugin:
"""
Llama API template for a Safeguard plugin.

    This class provides a foundation for building Safeguard plugins that interact with
    local LLM servers using the OpenAI API format (LM Studio, Ollama, etc.).
    """
    
    def __init__(self, config: Dict[str, Any] = None):
        """
        Initialize the plugin with configuration.
        
        Args:
            config: Dictionary containing plugin configuration
        """
        config = config or {}
        self.name = config.get('name', 'llama-plugin')
        self.version = config.get('version', '1.0.0')
        self.description = config.get('description', 'Llama API Safeguard Plugin')
        self.config = config
        self.initialized = False
        self.running = False
        
        # Llama specific configuration
        self.base_url = config.get('base_url', 'http://localhost:1234/v1')
        self.default_model = config.get('default_model', 'llama3')
        self.timeout = config.get('timeout', 60)  # 60 seconds default
        self.request_history = []
        self.max_history_size = config.get('max_history_size', 100)
        
        # Configure logging
        self.logger = self._setup_logging()
        self.logger.info(f"[{self.name}] Plugin instance created")
        
        # HTTP session will be created during initialization
        self.session = None
    
    def _setup_logging(self) -> logging.Logger:
        """
        Set up the plugin's logger.
        
        Returns:
            Logger instance
        """
        logger = logging.getLogger(f"safeguard.plugin.{self.name}")
        if not logger.handlers:
            handler = logging.StreamHandler()
            formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
            handler.setFormatter(formatter)
            logger.addHandler(handler)
            logger.setLevel(self.config.get('log_level', logging.INFO))
        return logger
    
    async def initialize(self, context: Dict[str, Any]) -> bool:
        """
        Initialize the plugin.
        
        Args:
            context: Initialization context
            
        Returns:
            True if initialization successful, False otherwise
        """
        try:
            self.logger.info(f"[{self.name}] Initializing plugin v{self.version}")
            self.context = context
            
            # Create HTTP session
            timeout = aiohttp.ClientTimeout(total=self.timeout)
            self.session = aiohttp.ClientSession(
                timeout=timeout,
                headers={
                    'Content-Type': 'application/json'
                }
            )
            
            # Validate connection by testing a simple request
            if self.config.get('validate_connection', True):
                try:
                    await self.test_connection()
                    self.logger.info(f"[{self.name}] Connection validation successful")
                except Exception as e:
                    raise ValueError(f"Connection validation failed: {str(e)}")
            
            self.initialized = True
            return True
        except Exception as e:
            self.logger.error(f"[{self.name}] Initialization failed: {str(e)}")
            return False
    
    async def test_connection(self) -> Dict[str, Any]:
        """
        Test connection to the Llama API.
        
        Returns:
            Response from API test
        """
        try:
            # Test with a minimal message to validate connection
            endpoint = f"{self.base_url}/chat/completions"
            data = {
                "model": self.default_model,
                "messages": [
                    {"role": "user", "content": "Hello"}
                ],
                "max_tokens": 5
            }
            
            async with self.session.post(endpoint, json=data) as response:
                if response.status != 200:
                    error_text = await response.text()
                    raise ValueError(f"API returned {response.status}: {error_text}")
                
                result = await response.json()
                
                if not result or 'choices' not in result:
                    raise ValueError("Invalid response from Llama API")
                
                return result
        except Exception as e:
            self.logger.error(f"[{self.name}] Connection test failed: {str(e)}")
            raise
    
    async def start(self) -> bool:
        """
        Start the plugin.
        
        Returns:
            True if start successful, False otherwise
        """
        if not self.initialized:
            self.logger.error(f"[{self.name}] Cannot start: plugin not initialized")
            return False
        
        try:
            self.logger.info(f"[{self.name}] Starting plugin...")
            self.running = True
            return True
        except Exception as e:
            self.logger.error(f"[{self.name}] Start failed: {str(e)}")
            return False
    
    async def stop(self) -> bool:
        """
        Stop the plugin.
        
        Returns:
            True if stop successful, False otherwise
        """
        if not self.running:
            self.logger.info(f"[{self.name}] Plugin already stopped")
            return True
        
        try:
            self.logger.info(f"[{self.name}] Stopping plugin...")
            self.running = False
            
            # Close HTTP session
            if self.session and not self.session.closed:
                await self.session.close()
            
            return True
        except Exception as e:
            self.logger.error(f"[{self.name}] Stop failed: {str(e)}")
            return False
    
    async def create_chat_completion(self, params: Dict[str, Any]) -> Dict[str, Any]:
        """
        Create a chat completion.
        
        Args:
            params: Chat completion parameters
                - messages: Chat messages array
                - model: Model to use, defaults to self.default_model
                - temperature: Sampling temperature (0.0-2.0)
                - max_tokens: Maximum tokens to generate
                - top_p: Nucleus sampling parameter (0.0-1.0)
                - presence_penalty: Presence penalty (-2.0-2.0)
                - frequency_penalty: Frequency penalty (-2.0-2.0)
                - stop: Sequences that stop generation
                - stream: Whether to stream the response
            
        Returns:
            Chat completion result
        """
        if not self.initialized or not self.running:
            raise RuntimeError(f"[{self.name}] Cannot create chat completion: plugin not running")
        
        request_id = str(uuid.uuid4())
        start_time = time.time()
        
        try:
            model = params.get('model', self.default_model)
            self.logger.info(f"[{self.name}] Creating chat completion with model: {model} ({request_id})")
            
            # Prepare request parameters
            request_params = {
                "model": model,
                "messages": params['messages'],
                "temperature": params.get('temperature', 0.7),
                "max_tokens": params.get('max_tokens', 1024),
                "top_p": params.get('top_p', 0.9),
                "presence_penalty": params.get('presence_penalty'),
                "frequency_penalty": params.get('frequency_penalty'),
                "stop": params.get('stop'),
                "stream": params.get('stream', False)
            }
            
            # Remove None values
            request_params = {k: v for k, v in request_params.items() if v is not None}
            
            # Log request (exclude messages for privacy)
            self.logger.debug(f"[{self.name}] Request ({request_id}): {self._sanitize_for_logging(request_params)}")
            
            # Set up the endpoint
            endpoint = f"{self.base_url}/chat/completions"
            
            # Handle streaming response
            if params.get('stream', False):
                # For streaming, we'll return a custom async generator
                stream = self._stream_chat_completion(endpoint, request_params, request_id)
                
                # Add to request history
                self._add_to_history({
                    'id': request_id,
                    'type': 'chat-completion-stream',
                    'model': model,
                    'params': self._sanitize_for_logging(request_params),
                    'status': 'success',
                    'timestamp': datetime.utcnow().isoformat()
                })
                
                # Return the stream directly
                return stream
            
            # Make API call to Llama
            async with self.session.post(endpoint, json=request_params) as response:
                if response.status != 200:
                    error_text = await response.text()
                    raise Exception(f"API returned {response.status}: {error_text}")
                
                result = await response.json()
            
            duration = time.time() - start_time
            self.logger.info(f"[{self.name}] Chat completion completed in {duration:.2f}s ({request_id})")
            
            # Process and format response
            formatted_result = {
                'id': result.get('id', request_id),
                'object': result.get('object', 'chat.completion'),
                'created': result.get('created', int(time.time())),
                'model': result.get('model', model),
                'choices': result.get('choices', []),
                'usage': result.get('usage', {
                    'prompt_tokens': 0,
                    'completion_tokens': 0,
                    'total_tokens': 0
                }),
                'duration': duration,
                'timestamp': datetime.utcnow().isoformat()
            }
            
            # Add to request history
            self._add_to_history({
                'id': request_id,
                'type': 'chat-completion',
                'model': model,
                'params': self._sanitize_for_logging(request_params),
                'status': 'success',
                'duration': duration,
                'timestamp': datetime.utcnow().isoformat()
            })
            
            return formatted_result
        except Exception as e:
            duration = time.time() - start_time
            self.logger.error(f"[{self.name}] Chat completion failed ({request_id}): {str(e)}")
            
            # Add failed request to history
            self._add_to_history({
                'id': request_id,
                'type': 'chat-completion',
                'model': params.get('model', self.default_model),
                'params': self._sanitize_for_logging(params),
                'status': 'error',
                'error': str(e),
                'duration': duration,
                'timestamp': datetime.utcnow().isoformat()
            })
            
            raise
    
    async def _stream_chat_completion(self, endpoint, params, request_id):
        """
        Stream chat completion responses.
        
        Args:
            endpoint: API endpoint
            params: Request parameters
            request_id: Request ID
            
        Yields:
            Streaming response chunks
        """
        try:
            # Make streaming request
            async with self.session.post(endpoint, json=params) as response:
                if response.status != 200:
                    error_text = await response.text()
                    raise Exception(f"API returned {response.status}: {error_text}")
                
                # Process the stream
                async for line in response.content:
                    line = line.strip()
                    if not line:
                        continue
                    
                    # Check for data prefix in SSE
                    if line.startswith(b'data: '):
                        line = line[6:]  # Remove 'data: ' prefix
                    
                    # Skip [DONE] message
                    if line == b'[DONE]':
                        break
                    
                    try:
                        chunk = json.loads(line)
                        yield chunk
                    except json.JSONDecodeError:
                        self.logger.warning(f"[{self.name}] Failed to parse streaming response: {line}")
        except Exception as e:
            self.logger.error(f"[{self.name}] Streaming request failed ({request_id}): {str(e)}")
            raise
    
    async def create_completion(self, params: Dict[str, Any]) -> Dict[str, Any]:
        """
        Create a completion.
        
        Args:
            params: Completion parameters
                - prompt: The input prompt
                - model: Model to use, defaults to self.default_model
                - temperature: Sampling temperature (0.0-2.0)
                - max_tokens: Maximum tokens to generate
                - top_p: Nucleus sampling parameter (0.0-1.0)
                - presence_penalty: Presence penalty (-2.0-2.0)
                - frequency_penalty: Frequency penalty (-2.0-2.0)
                - stop: Sequences that stop generation
                - stream: Whether to stream the response
            
        Returns:
            Completion result
        """
        if not self.initialized or not self.running:
            raise RuntimeError(f"[{self.name}] Cannot create completion: plugin not running")
        
        request_id = str(uuid.uuid4())
        start_time = time.time()
        
        try:
            model = params.get('model', self.default_model)
            self.logger.info(f"[{self.name}] Creating completion with model: {model} ({request_id})")
            
            # Prepare request parameters
            request_params = {
                "model": model,
                "prompt": params['prompt'],
                "temperature": params.get('temperature', 0.7),
                "max_tokens": params.get('max_tokens', 1024),
                "top_p": params.get('top_p', 0.9),
                "presence_penalty": params.get('presence_penalty'),
                "frequency_penalty": params.get('frequency_penalty'),
                "stop": params.get('stop'),
                "stream": params.get('stream', False)
            }
            
            # Remove None values
            request_params = {k: v for k, v in request_params.items() if v is not None}
            
            # Log request (exclude prompt for privacy)
            self.logger.debug(f"[{self.name}] Request ({request_id}): {self._sanitize_for_logging(request_params)}")
            
            # Set up the endpoint
            endpoint = f"{self.base_url}/completions"
            
            # Handle streaming response
            if params.get('stream', False):
                # For streaming, we'll return a custom async generator
                stream = self._stream_completion(endpoint, request_params, request_id)
                
                # Add to request history
                self._add_to_history({
                    'id': request_id,
                    'type': 'completion-stream',
                    'model': model,
                    'params': self._sanitize_for_logging(request_params),
                    'status': 'success',
                    'timestamp': datetime.utcnow().isoformat()
                })
                
                # Return the stream directly
                return stream
            
            # Make API call to Llama
            async with self.session.post(endpoint, json=request_params) as response:
                if response.status != 200:
                    error_text = await response.text()
                    raise Exception(f"API returned {response.status}: {error_text}")
                
                result = await response.json()
            
            duration = time.time() - start_time
            self.logger.info(f"[{self.name}] Completion completed in {duration:.2f}s ({request_id})")
            
            # Process and format response
            formatted_result = {
                'id': result.get('id', request_id),
                'object': result.get('object', 'completion'),
                'created': result.get('created', int(time.time())),
                'model': result.get('model', model),
                'choices': result.get('choices', []),
                'usage': result.get('usage', {
                    'prompt_tokens': 0,
                    'completion_tokens': 0,
                    'total_tokens': 0
                }),
                'duration': duration,
                'timestamp': datetime.utcnow().isoformat()
            }
            
            # Add to request history
            self._add_to_history({
                'id': request_id,
                'type': 'completion',
                'model': model,
                'params': self._sanitize_for_logging(request_params),
                'status': 'success',
                'duration': duration,
                'timestamp': datetime.utcnow().isoformat()
            })
            
            return formatted_result
        except Exception as e:
            duration = time.time() - start_time
            self.logger.error(f"[{self.name}] Completion failed ({request_id}): {str(e)}")
            
            # Add failed request to history
            self._add_to_history({
                'id': request_id,
                'type': 'completion',
                'model': params.get('model', self.default_model),
                'params': self._sanitize_for_logging(params),
                'status': 'error',
                'error': str(e),
                'duration': duration,
                'timestamp': datetime.utcnow().isoformat()
            })
            
            raise
    
    async def _stream_completion(self, endpoint, params, request_id):
        """
        Stream completion responses.
        
        Args:
            endpoint: API endpoint
            params: Request parameters
            request_id: Request ID
            
        Yields:
            Streaming response chunks
        """
        try:
            # Make streaming request
            async with self.session.post(endpoint, json=params) as response:
                if response.status != 200:
                    error_text = await response.text()
                    raise Exception(f"API returned {response.status}: {error_text}")
                
                # Process the stream
                async for line in response.content:
                    line = line.strip()
                    if not line:
                        continue
                    
                    # Check for data prefix in SSE
                    if line.startswith(b'data: '):
                        line = line[6:]  # Remove 'data: ' prefix
                    
                    # Skip [DONE] message
                    if line == b'[DONE]':
                        break
                    
                    try:
                        chunk = json.loads(line)
                        yield chunk
                    except json.JSONDecodeError:
                        self.logger.warning(f"[{self.name}] Failed to parse streaming response: {line}")
        except Exception as e:
            self.logger.error(f"[{self.name}] Streaming request failed ({request_id}): {str(e)}")
            raise
    
    async def create_embeddings(self, params: Dict[str, Any]) -> Dict[str, Any]:
        """
        Generate embeddings.
        
        Args:
            params: Embedding parameters
                - input: Text to embed (string or array of strings)
                - model: Model to use, defaults to self.default_model + "-embed"
            
        Returns:
            Embedding vectors and metadata
        """
        if not self.initialized or not self.running:
            raise RuntimeError(f"[{self.name}] Cannot create embeddings: plugin not running")
        
        request_id = str(uuid.uuid4())
        start_time = time.time()
        
        try:
            model = params.get('model', f"{self.default_model}-embed")
            input_text = params['input']
            input_list = input_text if isinstance(input_text, list) else [input_text]
            
            self.logger.info(f"[{self.name}] Creating embeddings for {len(input_list)} texts with model: {model} ({request_id})")
            
            # Prepare request parameters
            request_params = {
                "model": model,
                "input": input_list
            }
            
            # Log request (exclude input text for privacy)
            self.logger.debug(f"[{self.name}] Request ({request_id}): {{'model': '{model}', 'input': '[{len(input_list)} texts]'}}")
            
            # Set up the endpoint
            endpoint = f"{self.base_url}/embeddings"
            
            # Make API call to Llama
            async with self.session.post(endpoint, json=request_params) as response:
                if response.status != 200:
                    error_text = await response.text()
                    raise Exception(f"API returned {response.status}: {error_text}")
                
                result = await response.json()
            
            duration = time.time() - start_time
            self.logger.info(f"[{self.name}] Embeddings creation completed in {duration:.2f}s ({request_id})")
            
            # Process and format response
            data = result.get('data', [])
            dimensions = len(data[0]['embedding']) if data and len(data) > 0 else 0
            
            formatted_result = {
                'object': result.get('object', 'list'),
                'data': data,
                'model': result.get('model', model),
                'usage': result.get('usage', {
                    'prompt_tokens': 0,
                    'total_tokens': 0
                }),
                'dimensions': dimensions,
                'duration': duration,
                'timestamp': datetime.utcnow().isoformat()
            }
            
            # Add to request history
            self._add_to_history({
                'id': request_id,
                'type': 'embeddings',
                'model': model,
                'params': {
                    'model': model,
                    'input': f"[{len(input_list)} texts]"
                },
                'status': 'success',
                'duration': duration,
                'timestamp': datetime.utcnow().isoformat()
            })
            
            return formatted_result
        except Exception as e:
            duration = time.time() - start_time
            self.logger.error(f"[{self.name}] Embeddings creation failed ({request_id}): {str(e)}")
            
            # Add failed request to history
            self._add_to_history({
                'id': request_id,
                'type': 'embeddings',
                'model': params.get('model', f"{self.default_model}-embed"),
                'params': {
                    'model': params.get('model', f"{self.default_model}-embed"),
                    'input': f"[{len(input_list) if 'input' in params and isinstance(params['input'], list) else 1} texts]"
                },
                'status': 'error',
                'error': str(e),
                'duration': duration,
                'timestamp': datetime.utcnow().isoformat()
            })
            
            raise
    
    async def list_models(self) -> List[Dict[str, Any]]:
        """
        List available models.
        
        Returns:
            List of available models
        """
        if not self.initialized:
            raise RuntimeError(f"[{self.name}] Cannot list models: plugin not initialized")
        
        try:
            endpoint = f"{self.base_url}/models"
            async with self.session.get(endpoint) as response:
                if response.status != 200:
                    error_text = await response.text()
                    raise Exception(f"API returned {response.status}: {error_text}")
                
                result = await response.json()
                return result.get('data', [])
        except Exception as e:
            self.logger.error(f"[{self.name}] List models failed: {str(e)}")
            raise
    
    def _sanitize_for_logging(self, params: Dict[str, Any]) -> Dict[str, Any]:
        """
        Sanitize parameters for logging (remove sensitive data)
        
        Args:
            params: Parameters to sanitize
            
        Returns:
            Sanitized parameters
        """
        sanitized = params.copy()
        
        # Remove or truncate potentially sensitive or large fields
        if 'messages' in sanitized:
            sanitized['messages'] = f"[{len(sanitized['messages'])} messages]"
        
        if 'prompt' in sanitized:
            sanitized['prompt'] = f"[{len(sanitized['prompt'])} chars]"
        
        if 'input' in sanitized and isinstance(sanitized['input'], list):
            sanitized['input'] = f"[{len(sanitized['input'])} texts]"
        elif 'input' in sanitized:
            sanitized['input'] = f"[{len(str(sanitized['input']))} chars]"
        
        return sanitized
    
    def _add_to_history(self, entry: Dict[str, Any]):
        """
        Add a request to the history
        
        Args:
            entry: History entry
        """
        self.request_history.insert(0, entry)
        
        # Trim history if it exceeds max size
        if len(self.request_history) > self.max_history_size:
            self.request_history = self.request_history[:self.max_history_size]
    
    def get_request_history(self, limit: int = None) -> List[Dict[str, Any]]:
        """
        Get request history
        
        Args:
            limit: Maximum number of entries to return
            
        Returns:
            Request history
        """
        if limit is not None and limit > 0:
            return self.request_history[:limit]
        return self.request_history
    
    def get_status(self) -> Dict[str, Any]:
        """
        Get plugin status.
        
        Returns:
            Status information
        """
        return {
            'name': self.name,
            'version': self.version,
            'description': self.description,
            'initialized': self.initialized,
            'running': self.running,
            'base_url': self.base_url,
            'default_model': self.default_model,
            'requests_processed': len(self.request_history),
            'last_request_timestamp': self.request_history[0]['timestamp'] if self.request_history else None,
            'timestamp': datetime.utcnow().isoformat()
        }
    
    def to_json(self) -> str:
        """
        Convert plugin status to JSON.
        
        Returns:
            JSON string representation of plugin status
        """
        return json.dumps(self.get_status())


# Example usage
if __name__ == "__main__":
async def run_example():
# Create plugin instance
plugin = SafeguardLlamaPlugin({
'name': 'local-llm',
'base_url': 'http://localhost:1234/v1',
'default_model': 'llama3'
})

        # Initialize and start
        await plugin.initialize({})
        await plugin.start()
        
        try:
            # Generate text with chat interface
            chat = await plugin.create_chat_completion({
                'messages': [
                    {'role': 'system', 'content': 'You are a helpful assistant specialized in robotics.'},
                    {'role': 'user', 'content': 'What are the key safety considerations for autonomous robots?'}
                ]
            })
            
            print(f"Chat response: {chat['choices'][0]['message']['content']}")
            
            # Generate text with completion interface
            completion = await plugin.create_completion({
                'prompt': 'Autonomous robots must consider the following safety aspects:'
            })
            
            print(f"Completion: {completion['choices'][0]['text']}")
        
        except Exception as e:
            print(f"API request error: {e}")
        
        # Get status
        status = plugin.get_status()
        print(f"Plugin status: {status}")
        
        # Stop the plugin
        await plugin.stop()
    
    asyncio.run(run_example())
```
<llm-snippet-file>_safeguard-plugin-system/templates/python/llama-llm-api/requirements.txt</llm-snippet-file>
```

# Requirements for the Safeguard Llama LLM API Plugin
aiohttp>=3.8.5
```
<llm-snippet-file>_safeguard-plugin-system/templates/python/llama-llm-api/README.md</llm-snippet-file>
```
markdown
# Safeguard Llama API Python Plugin Template

This template provides a structure for creating a Safeguard plugin in Python that interacts with the Llama API for language model inference. It works with any server that implements the OpenAI API format, such as LM Studio, Ollama, and other local LLM servers.

## Features

- Chat completions with locally running LLMs
- Text completions with traditional prompt format
- Embeddings generation for semantic search and NLP tasks
- Support for streaming responses
- Request history tracking and management
- Comprehensive error handling and logging
- Async/await support

## Prerequisites

- Local LLM server running (LM Studio, Ollama, or similar)
- Python 3.7 or higher
- Required Python packages (see requirements.txt)

## Usage

1. Clone this template
2. Install dependencies with `pip install -r requirements.txt`
3. Configure the connection to your local LLM server
4. Initialize and use the plugin in your application

## Configuration Options

- `base_url`: URL of the local LLM server (default: 'http://localhost:1234/v1')
- `default_model`: Default model to use (default: 'llama3')
- `timeout`: Request timeout in seconds (default: 60)
- `max_history_size`: Maximum number of requests to keep in history (default: 100)
- `validate_connection`: Whether to validate the connection during initialization (default: True)

## API Methods

### Chat Completions

```textmate
completion = await plugin.create_chat_completion({
    "messages": [
        {"role": "system", "content": "You are a helpful assistant."},
        {"role": "user", "content": "Tell me about autonomous systems."}
    ],
    "model": "llama3",  # optional, uses default_model if not specified
    "temperature": 0.7,
    "max_tokens": 1000
})
```


### Text Completions

```textmate
completion = await plugin.create_completion({
    "prompt": "Once upon a time in the world of artificial intelligence,",
    "model": "llama3",  # optional, uses default_model if not specified
    "max_tokens": 1000,
    "temperature": 0.7
})
```


### Embeddings Generation

```textmate
embeddings = await plugin.create_embeddings({
    "input": ["Autonomous systems require robust safety measures"],
    "model": "llama3-embed"  # optional, uses default_model + "-embed" if not specified
})
```


### Streaming Responses

```textmate
stream = await plugin.create_chat_completion({
    "messages": [
        {"role": "user", "content": "Write a poem about robots."}
    ],
    "stream": True
})

async for chunk in stream:
    if "choices" in chunk and len(chunk["choices"]) > 0:
        delta = chunk["choices"][0].get("delta", {})
        if "content" in delta:
            print(delta["content"], end="")
```


### List Available Models

```textmate
models = await plugin.list_models()
```


## Example

```textmate
import asyncio
from plugin import SafeguardLlamaPlugin

async def run():
    # Create plugin instance
    plugin = SafeguardLlamaPlugin({
        'name': 'local-llm',
        'base_url': 'http://localhost:1234/v1',
        'default_model': 'llama3'
    })
    
    # Initialize and use the plugin
    await plugin.initialize({})
    await plugin.start()
    
    # Generate text with chat interface
    chat = await plugin.create_chat_completion({
        'messages': [
            {'role': 'system', 'content': 'You are a helpful assistant specialized in robotics.'},
            {'role': 'user', 'content': 'What are the key safety considerations for autonomous robots?'}
        ]
    })
    
    print(f"Chat response: {chat['choices'][0]['message']['content']}")
    
    # Generate text with completion interface
    completion = await plugin.create_completion({
        'prompt': 'Autonomous robots must consider the following safety aspects:'
    })
    
    print(f"Completion: {completion['choices'][0]['text']}")
    
    await plugin.stop()

# Run the example
asyncio.run(run())
```


## Compatible LLM Servers

This plugin works with any server that implements the OpenAI API format, including:

- [LM Studio](https://lmstudio.ai/)
- [Ollama](https://ollama.ai/)
- [LocalAI](https://github.com/go-skynet/LocalAI)
- [vLLM](https://github.com/vllm-project/vllm)
- [oobabooga/text-generation-webui](https://github.com/oobabooga/text-generation-webui)

## Error Handling

The plugin includes built-in error handling and logging:

- API request failures (connection issues, timeouts)
- API response errors (invalid parameters, server errors)
- Plugin state validation (ensuring the plugin is initialized and running)

All errors are logged and can be tracked through the request history.

## Extending the Plugin

To extend the functionality of the Llama API plugin, subclass `SafeguardLlamaPlugin` and override the methods you want to customize:

```textmate
from plugin import SafeguardLlamaPlugin

class CustomLocalLLMPlugin(SafeguardLlamaPlugin):
    async def initialize(self, context):
        # Add custom initialization logic
        result = await super().initialize(context)
        
        # Set up preset prompts
        self.prompts = {
            'summarize': lambda text: [
                {"role": "system", "content": "You are a summarization assistant. Be concise."},
                {"role": "user", "content": f"Summarize this text: {text}"}
            ],
            'analyze': lambda text: [
                {"role": "system", "content": "You are an analytical assistant. Provide detailed analysis."},
                {"role": "user", "content": f"Analyze this text: {text}"}
            ]
        }
        
        return result
    
    async def summarize(self, text, max_tokens=100):
        """Custom method for text summarization"""
        messages = self.prompts['summarize'](text)
        result = await self.create_chat_completion({
            'messages': messages,
            'max_tokens': max_tokens
        })
        return result['choices'][0]['message']['content']
```


## License

Copyright 2025 Autonomy Association International Inc., all rights reserved.
```
<llm-snippet-file>_safeguard-plugin-system/templates/python/llama-llm-api/example.py</llm-snippet-file>
```
python
"""
Example usage of the Llama API Safeguard Plugin
"""

import asyncio
import logging
from datetime import datetime
from plugin import SafeguardLlamaPlugin

# Configure root logger
logging.basicConfig(
level=logging.INFO,
format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)

async def demonstrate_llama_llm():
"""
Demonstrate the Llama LLM plugin functionality
"""
try:
# Create plugin instance
# NOTE: Adjust the base_url and default_model to match your local LLM server configuration
plugin = SafeguardLlamaPlugin({
'name': 'local-llm-assistant',
'version': '1.0.0',
'description': 'Local Llama LLM Integration Example',
'base_url': 'http://localhost:1234/v1',  # Default for LM Studio
'default_model': 'llama3',  # Change to match your loaded model
'log_level': logging.DEBUG
})

        # Initialize the plugin
        print("Initializing Llama plugin...")
        await plugin.initialize({
            'app_context': { 
                'app_version': '1.0.0',
                'environment': 'development'
            }
        })
        
        # Start the plugin
        print("\nStarting plugin...")
        await plugin.start()
        
        # Get plugin status
        print("\nPlugin status:")
        print(plugin.to_json())
        
        # List available models
        try:
            print("\nListing available models...")
            models = await plugin.list_models()
            print(f"Available models: {models}")
        except Exception as model_error:
            print(f"Error listing models: {model_error}")
            print("Continuing with the default model")
        
        # Create chat completion
        try:
            print("\nCreating chat completion...")
            chat_result = await plugin.create_chat_completion({
                'messages': [
                    {'role': 'system', 'content': 'You are a helpful assistant specializing in robotics and autonomous systems.'},
                    {'role': 'user', 'content': 'What are three important safety considerations for autonomous robots in urban environments? Please be concise.'}
                ],
                'temperature': 0.7,
                'max_tokens': 500
            })
            
            print("\nChat completion result:")
            print(f"Model: {chat_result['model']}")
            
            if 'choices' in chat_result and len(chat_result['choices']) > 0:
                message = chat_result['choices'][0].get('message', {})
                content = message.get('content', '')
                print(f"Response: {content}")
            
            if 'usage' in chat_result and chat_result['usage']:
                print(f"Usage: {chat_result['usage']}")
            
            print(f"Duration: {chat_result['duration']:.2f} seconds")
        except Exception as chat_error:
            print(f"Error creating chat completion: {chat_error}")
        
        # Create text completion
        try:
            print("\nCreating text completion...")
            completion_result = await plugin.create_completion({
                'prompt': 'Write a brief explanation of how autonomous drones navigate in urban environments:',
                'temperature': 0.7,
                'max_tokens': 300
            })
            
            print("\nText completion result:")
            print(f"Model: {completion_result['model']}")
            
            if 'choices' in completion_result and len(completion_result['choices']) > 0:
                text = completion_result['choices'][0].get('text', '')
                print(f"Response: {text}")
            
            if 'usage' in completion_result and completion_result['usage']:
                print(f"Usage: {completion_result['usage']}")
            
            print(f"Duration: {completion_result['duration']:.2f} seconds")
        except Exception as completion_error:
            print(f"Error creating text completion: {completion_error}")
        
        # Generate embeddings
        try:
            print("\nGenerating embeddings...")
            embeddings_result = await plugin.create_embeddings({
                'input': [
                    "Autonomous robots must prioritize human safety",
                    "Vision systems are critical for environmental awareness"
                ]
            })
            
            print("\nEmbeddings result:")
            print(f"Model: {embeddings_result['model']}")
            print(f"Embedding count: {len(embeddings_result['data'])}")
            print(f"Dimensions: {embeddings_result['dimensions']}")
            
            if embeddings_result['data'] and len(embeddings_result['data']) > 0:
                first_embedding = embeddings_result['data'][0].get('embedding', [])
                print(f"First embedding (first 5 values): {first_embedding[:5]}")
            
            if 'usage' in embeddings_result and embeddings_result['usage']:
                print(f"Usage: {embeddings_result['usage']}")
            
            print(f"Duration: {embeddings_result['duration']:.2f} seconds")
        except Exception as embeddings_error:
            print(f"Error generating embeddings: {embeddings_error}")
        
        # Demonstrate streaming (uncomment to try)
        """
        try:
            print('\nDemonstrating streaming response...')
            stream = await plugin.create_chat_completion({
                'messages': [
                    {'role': 'user', 'content': 'Write a very short poem about robots and humans working together.'}
                ],
                'stream': True
            })
            
            print('\nStreaming response:')
            print()
            
            async for chunk in stream:
                if "choices" in chunk and len(chunk["choices"]) > 0:
                    delta = chunk["choices"][0].get("delta", {})
                    if "content" in delta:
                        print(delta["content"], end="")
            print('\n')
            
        except Exception as stream_error:
            print(f'Error with streaming response: {stream_error}')
        """
        
        # Get request history
        print("\nRequest history:")
        history = plugin.get_request_history(5)
        for entry in history:
            print(f"- {entry['type']} ({entry['id'][:8]}): {entry['status']}, Model: {entry['model']}, Duration: {entry['duration']:.2f}s")
        
        # Stop the plugin
        print("\nStopping plugin...")
        await plugin.stop()
        
        # Final status
        print("\nFinal plugin status:")
        print(plugin.to_json())
        
    except Exception as e:
        print(f"Error in Llama LLM demonstration: {e}")

# Run the demonstration
if __name__ == "__main__":
asyncio.run(demonstrate_llama_llm())
```
### 8. Generic ML Python Template

<llm-snippet-file>_safeguard-plugin-system/templates/python/generic-ml/plugin.py</llm-snippet-file>
```python
"""
Generic ML Safeguard Plugin Template

This template provides a structure for creating a Safeguard plugin in Python
that integrates with machine learning models for inference and prediction.

Copyright 2025 Autonomy Association International Inc., all rights reserved.
"""

import logging
import uuid
import json
import asyncio
import time
import os
import traceback
from datetime import datetime
from typing import Dict, Any, Optional, List, Union, Callable, BinaryIO

class DataProcessor:
    """
    Base class for data processors (preprocessors and postprocessors)
    """
    async def initialize(self) -> bool:
        """
        Initialize the processor
        
        Returns:
            True if initialization successful
        """
        return True
    
    async def process(self, data: Any, options: Dict[str, Any] = None) -> Any:
        """
        Process a single data item
        
        Args:
            data: Data to process
            options: Processing options
            
        Returns:
            Processed data
        """
        # Default implementation just passes data through
        return data
    
    async def process_batch(self, batch: List[Any], options: Dict[str, Any] = None) -> List[Any]:
        """
        Process a batch of data items
        
        Args:
            batch: Batch of data to process
            options: Processing options
            
        Returns:
            Processed batch
        """
        # Default implementation processes each item individually
        results = []
        for item in batch:
            result = await self.process(item, options)
            results.append(result)
        return results

class SafeguardGenericMLPlugin:
    """
    Generic ML template for a Safeguard plugin.
    
    This class provides a foundation for building Safeguard plugins that integrate with
    machine learning models for inference and prediction.
    """
    
    def __init__(self, config: Dict[str, Any] = None):
        """
        Initialize the plugin with configuration.
        
        Args:
            config: Dictionary containing plugin configuration
        """
        config = config or {}
        self.name = config.get('name', 'generic-ml-plugin')
        self.version = config.get('version', '1.0.0')
        self.description = config.get('description', 'Generic ML Safeguard Plugin')
        self.config = config
        self.initialized = False
        self.running = False
        
        # ML specific configuration
        self.model_path = config.get('model_path')
        self.model_type = config.get('model_type', 'generic')
        self.model_config = config.get('model_config', {})
        self.preprocessors = config.get('preprocessors', [])
        self.postprocessors = config.get('postprocessors', [])
        self.inference_timeout = config.get('inference_timeout', 30)  # 30 seconds default
        self.batch_size = config.get('batch_size', 1)
        self.request_history = []
        self.max_history_size = config.get('max_history_size', 100)
        self.model_instance = None
        
        # Configure logging
        self.logger = self._setup_logging()
        self.logger.info(f"[{self.name}] Plugin instance created")
    
    def _setup_logging(self) -> logging.Logger:
        """
        Set up the plugin's logger.
        
        Returns:
            Logger instance
        """
        logger = logging.getLogger(f"safeguard.plugin.{self.name}")
        if not logger.handlers:
            handler = logging.StreamHandler()
            formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
            handler.setFormatter(formatter)
            logger.addHandler(handler)
            logger.setLevel(self.config.get('log_level', logging.INFO))
        return logger
    
    async def initialize(self, context: Dict[str, Any]) -> bool:
        """
        Initialize the plugin.
        
        Args:
            context: Initialization context
            
        Returns:
            True if initialization successful, False otherwise
        """
        try:
            self.logger.info(f"[{self.name}] Initializing plugin v{self.version}")
            self.context = context
            
            # Check if model path exists
            if self.model_path:
                if not os.path.exists(self.model_path):
                    raise ValueError(f"Model path does not exist: {self.model_path}")
                self.logger.info(f"[{self.name}] Using model at: {self.model_path}")
            
            # Load model based on model type
            await self._load_model()
            
            # Initialize preprocessors
            if self.preprocessors:
                self.logger.info(f"[{self.name}] Initializing {len(self.preprocessors)} preprocessors")
                for preprocessor in self.preprocessors:
                    await preprocessor.initialize()
            
            # Initialize postprocessors
            if self.postprocessors:
                self.logger.info(f"[{self.name}] Initializing {len(self.postprocessors)} postprocessors")
                for postprocessor in self.postprocessors:
                    await postprocessor.initialize()
            
            self.initialized = True
            return True
        except Exception as e:
            self.logger.error(f"[{self.name}] Initialization failed: {str(e)}")
            traceback.print_exc()
            return False
    
    async def _load_model(self):
        """
        Load ML model
        """
        # This is a generic implementation - override for specific ML frameworks
        self.logger.info(f"[{self.name}] Loading model of type: {self.model_type}")
        
        model_type = self.model_type.lower()
        try:
            if model_type == 'tensorflow':
                await self._load_tensorflow_model()
            elif model_type == 'onnx':
                await self._load_onnx_model()
            elif model_type == 'pytorch':
                await self._load_pytorch_model()
            elif model_type == 'custom':
                await self._load_custom_model()
            else:
                self.logger.warning(f"[{self.name}] No specific loader for model type: {self.model_type}. Using generic loader.")
                await self._load_generic_model()
        except Exception as e:
            self.logger.error(f"[{self.name}] Failed to load model: {str(e)}")
            traceback.print_exc()
            raise
    
    async def _load_tensorflow_model(self):
        """
        Load TensorFlow model
        """
        # Dynamically import TensorFlow
        try:
            import tensorflow as tf
            self.model_instance = await asyncio.to_thread(tf.saved_model.load, self.model_path)
            self.logger.info(f"[{self.name}] TensorFlow model loaded successfully")
        except ImportError:
            raise ImportError("TensorFlow is not installed. Install with: pip install tensorflow")
        except Exception as e:
            self.logger.error(f"[{self.name}] Failed to load TensorFlow model: {str(e)}")
            raise
    
    async def _load_onnx_model(self):
        """
        Load ONNX model
        """
        # Dynamically import ONNX Runtime
        try:
            import onnxruntime as ort
            self.model_instance = await asyncio.to_thread(ort.InferenceSession, self.model_path)
            self.logger.info(f"[{self.name}] ONNX model loaded successfully")
        except ImportError:
            raise ImportError("ONNX Runtime is not installed. Install with: pip install onnxruntime")
        except Exception as e:
            self.logger.error(f"[{self.name}] Failed to load ONNX model: {str(e)}")
            raise
    
    async def _load_pytorch_model(self):
        """
        Load PyTorch model
        """
        # Dynamically import PyTorch
        try:
            import torch
            self.model_instance = await asyncio.to_thread(torch.load, self.model_path)
            if hasattr(self.model_instance, 'eval'):
                self.model_instance.eval()
            self.logger.info(f"[{self.name}] PyTorch model loaded successfully")
        except ImportError:
            raise ImportError("PyTorch is not installed. Install with: pip install torch")
        except Exception as e:
            self.logger.error(f"[{self.name}] Failed to load PyTorch model: {str(e)}")
            raise
    
    async def _load_custom_model(self):
        """
        Load custom model implementation
        """
        custom_model_loader = self.config.get('custom_model_loader')
        if not custom_model_loader or not callable(custom_model_loader):
            raise ValueError("Custom model loader is required for custom model type")
        
        try:
            self.model_instance = await asyncio.to_thread(
                custom_model_loader, 
                self.model_path, 
                self.model_config
            )
            self.logger.info(f"[{self.name}] Custom model loaded successfully")
        except Exception as e:
            self.logger.error(f"[{self.name}] Failed to load custom model: {str(e)}")
            raise
    
    async def _load_generic_model(self):
        """
        Load generic model (placeholder)
        """
        # This is a placeholder for a generic model
        # In a real implementation, you would load your model here
        self.model_instance = {
            'predict': lambda input: {
                'output': input,
                'confidence': 0.95
            }
        }
        
        self.logger.info(f"[{self.name}] Generic model placeholder created")
    
    async def start(self) -> bool:
        """
        Start the plugin.
        
        Returns:
            True if start successful, False otherwise
        """
        if not self.initialized:
            self.logger.error(f"[{self.name}] Cannot start: plugin not initialized")
            return False
        
        try:
            self.logger.info(f"[{self.name}] Starting plugin...")
            self.running = True
            return True
        except Exception as e:
            self.logger.error(f"[{self.name}] Start failed: {str(e)}")
            return False
    
    async def stop(self) -> bool:
        """
        Stop the plugin.
        
        Returns:
            True if stop successful, False otherwise
        """
        if not self.running:
            self.logger.info(f"[{self.name}] Plugin already stopped")
            return True
        
        try:
            self.logger.info(f"[{self.name}] Stopping plugin...")
            self.running = False
            return True
        except Exception as e:
            self.logger.error(f"[{self.name}] Stop failed: {str(e)}")
            return False
    
    async def predict(self, input: Any, options: Dict[str, Any] = None) -> Dict[str, Any]:
        """
        Make a prediction with the ML model
        
        Args:
            input: Input data for prediction
            options: Prediction options
            
        Returns:
            Prediction results
        """
        if not self.initialized or not self.running:
            raise RuntimeError(f"[{self.name}] Cannot predict: plugin not running")
        
        if not self.model_instance:
            raise RuntimeError(f"[{self.name}] Model not loaded")
        
        request_id = str(uuid.uuid4())
        start_time = time.time()
        options = options or {}
        
        try:
            self.logger.info(f"[{self.name}] Making prediction ({request_id})")
            
            # Preprocess input
            processed_input = input
            if self.preprocessors:
                for preprocessor in self.preprocessors:
                    processed_input = await preprocessor.process(processed_input, options)
            
            # Run prediction with timeout
            try:
                prediction_task = asyncio.create_task(self._run_prediction(processed_input, options))
                prediction = await asyncio.wait_for(prediction_task, timeout=self.inference_timeout)
            except asyncio.TimeoutError:
                raise TimeoutError(f"Prediction timeout after {self.inference_timeout} seconds")
            
            # Postprocess output
            if self.postprocessors:
                for postprocessor in self.postprocessors:
                    prediction = await postprocessor.process(prediction, options)
            
            duration = time.time() - start_time
            self.logger.info(f"[{self.name}] Prediction completed in {duration:.2f}s ({request_id})")
            
            # Format result
            result = {
                'id': request_id,
                'prediction': prediction,
                'duration': duration,
                'timestamp': datetime.utcnow().isoformat()
            }
            
            # Add to request history
            self._add_to_history({
                'id': request_id,
                'type': 'prediction',
                'input': self._format_input_for_history(input),
                'options': options,
                'status': 'success',
                'duration': duration,
                'timestamp': datetime.utcnow().isoformat()
            })
            
            return result
        except Exception as e:
            duration = time.time() - start_time
            self.logger.error(f"[{self.name}] Prediction failed ({request_id}): {str(e)}")
            traceback.print_exc()
            
            # Add failed request to history
            self._add_to_history({
                'id': request_id,
                'type': 'prediction',
                'input': self._format_input_for_history(input),
                'options': options,
                'status': 'error',
                'error': str(e),
                'duration': duration,
                'timestamp': datetime.utcnow().isoformat()
            })
            
            raise
    
    async def _run_prediction(self, input: Any, options: Dict[str, Any] = None) -> Any:
        """
        Run prediction on the model
        
        Args:
            input: Processed input data
            options: Prediction options
            
        Returns:
            Raw prediction result
        """
        # Handle different model types
        if hasattr(self.model_instance, 'predict') and callable(self.model_instance.predict):
            # Standard scikit-learn like interface
            if asyncio.iscoroutinefunction(self.model_instance.predict):
                return await self.model_instance.predict(input, **options)
            else:
                return await asyncio.to_thread(self.model_instance.predict, input, **options)
        
        elif hasattr(self.model_instance, '__call__') and callable(self.model_instance.__call__):
            # Callable model
            if asyncio.iscoroutinefunction(self.model_instance.__call__):
                return await self.model_instance(input, **options)
            else:
                return await asyncio.to_thread(self.model_instance, input, **options)
        
        else:
            # Try a generic approach
            self.logger.warning(f"[{self.name}] No standard prediction method found, using generic approach")
            return {'output': input, 'confidence': 0.5}
    
    async def batch_predict(self, inputs: List[Any], options: Dict[str, Any] = None) -> Dict[str, Any]:
        """
        Make predictions on a batch of inputs
        
        Args:
            inputs: Array of input data
            options: Prediction options
            
        Returns:
            Array of prediction results
        """
        if not self.initialized or not self.running:
            raise RuntimeError(f"[{self.name}] Cannot batch predict: plugin not running")
        
        if not isinstance(inputs, list):
            raise ValueError(f"[{self.name}] Batch prediction requires an array of inputs")
        
        request_id = str(uuid.uuid4())
        start_time = time.time()
        options = options or {}
        
        try:
            self.logger.info(f"[{self.name}] Making batch prediction with {len(inputs)} inputs ({request_id})")
            
            # Split inputs into batches
            batch_size = options.get('batch_size', self.batch_size)
            batches = [inputs[i:i + batch_size] for i in range(0, len(inputs), batch_size)]
            
            # Process each batch
            results = []
            for i, batch in enumerate(batches):
                self.logger.debug(f"[{self.name}] Processing batch {i+1}/{len(batches)} with {len(batch)} inputs")
                
                # Preprocess batch
                processed_batch = batch
                if self.preprocessors:
                    for preprocessor in self.preprocessors:
                        processed_batch = await preprocessor.process_batch(processed_batch, options)
                
                # Run prediction
                try:
                    if hasattr(self.model_instance, 'batch_predict') and callable(self.model_instance.batch_predict):
                        # Model has batch prediction capability
                        if asyncio.iscoroutinefunction(self.model_instance.batch_predict):
                            predictions = await self.model_instance.batch_predict(processed_batch, **options)
                        else:
                            predictions = await asyncio.to_thread(self.model_instance.batch_predict, processed_batch, **options)
                    else:
                        # Fall back to individual predictions
                        predictions = []
                        for item in processed_batch:
                            prediction = await self._run_prediction(item, options)
                            predictions.append(prediction)
                except asyncio.TimeoutError:
                    raise TimeoutError(f"Batch prediction timeout after {self.inference_timeout} seconds")
                
                # Postprocess batch
                if self.postprocessors:
                    for postprocessor in self.postprocessors:
                        predictions = await postprocessor.process_batch(predictions, options)
                
                results.extend(predictions)
            
            duration = time.time() - start_time
            self.logger.info(f"[{self.name}] Batch prediction completed in {duration:.2f}s ({request_id})")
            
            # Format result
            result = {
                'id': request_id,
                'predictions': results,
                'count': len(results),
                'duration': duration,
                'timestamp': datetime.utcnow().isoformat()
            }
            
            # Add to request history
            self._add_to_history({
                'id': request_id,
                'type': 'batch-prediction',
                'input': f"[Array of {len(inputs)} items]",
                'options': options,
                'batch_count': len(batches),
                'status': 'success',
                'duration': duration,
                'timestamp': datetime.utcnow().isoformat()
            })
            
            return result
        except Exception as e:
            duration = time.time() - start_time
            self.logger.error(f"[{self.name}] Batch prediction failed ({request_id}): {str(e)}")
            traceback.print_exc()
            
            # Add failed request to history
            self._add_to_history({
                'id': request_id,
                'type': 'batch-prediction',
                'input': f"[Array of {len(inputs)} items]",
                'options': options,
                'status': 'error',
                'error': str(e),
                'duration': duration,
                'timestamp': datetime.utcnow().isoformat()
            })
            
            raise
    
    def add_preprocessor(self, preprocessor: DataProcessor):
        """
        Add a preprocessor to the pipeline
        
        Args:
            preprocessor: Preprocessor with process method
        """
        if not isinstance(preprocessor, DataProcessor):
            raise TypeError(f"[{self.name}] Preprocessor must be an instance of DataProcessor")
        
        self.preprocessors.append(preprocessor)
        self.logger.info(f"[{self.name}] Added preprocessor to pipeline (total: {len(self.preprocessors)})")
    
    def add_postprocessor(self, postprocessor: DataProcessor):
        """
        Add a postprocessor to the pipeline
        
        Args:
            postprocessor: Postprocessor with process method
        """
        if not isinstance(postprocessor, DataProcessor):
            raise TypeError(f"[{self.name}] Postprocessor must be an instance of DataProcessor")
        
        self.postprocessors.append(postprocessor)
        self.logger.info(f"[{self.name}] Added postprocessor to pipeline (total: {len(self.postprocessors)})")
    
    def get_model_info(self) -> Dict[str, Any]:
        """
        Get model information
        
        Returns:
            Model information
        """
        info = {
            'model_type': self.model_type,
            'model_path': self.model_path,
            'is_loaded': self.model_instance is not None,
            'preprocessors': len(self.preprocessors),
            'postprocessors': len(self.postprocessors)
        }
        
        # Add model-specific information if available
        if self.model_instance and hasattr(self.model_instance, 'get_metadata') and callable(self.model_instance.get_metadata):
            info['metadata'] = self.model_instance.get_metadata()
        
        return info
    
    def _format_input_for_history(self, input: Any) -> str:
        """
        Format input data for history
        
        Args:
            input: Input data
            
        Returns:
            Formatted string representation
        """
        if isinstance(input, list):
            return f"[Array of {len(input)} items]"
        elif isinstance(input, dict):
            return f"[Dictionary with {len(input)} keys]"
        elif hasattr(input, 'shape'):  # For numpy arrays
            return f"[Array with shape {input.shape}]"
        else:
            return f"[{type(input).__name__}]"
    
    def _add_to_history(self, entry: Dict[str, Any]):
        """
        Add a request to the history
        
        Args:
            entry: History entry
        """
        self.request_history.insert(0, entry)
        
        # Trim history if it exceeds max size
        if len(self.request_history) > self.max_history_size:
            self.request_history = self.request_history[:self.max_history_size]
    
    def get_request_history(self, limit: int = None) -> List[Dict[str, Any]]:
        """
        Get request history
        
        Args:
            limit: Maximum number of entries to return
            
        Returns:
            Request history
        """
        if limit is not None and limit > 0:
            return self.request_history[:limit]
        return self.request_history
    
    def get_status(self) -> Dict[str, Any]:
        """
        Get plugin status.
        
        Returns:
            Status information
        """
        return {
            'name': self.name,
            'version': self.version,
            'description': self.description,
            'initialized': self.initialized,
            'running': self.running,
            'model_info': self.get_model_info(),
            'requests_processed': len(self.request_history),
            'last_request_timestamp': self.request_history[0]['timestamp'] if self.request_history else None,
            'timestamp': datetime.utcnow().isoformat()
        }
    
    def to_json(self) -> str:
        """
        Convert plugin status to JSON.
        
        Returns:
            JSON string representation of plugin status
        """
        return json.dumps(self.get_status())


# Example usage
if __name__ == "__main__":
    # Example preprocessor for normalizing numerical data
    class NormalizationPreprocessor(DataProcessor):
        async def initialize(self):
            self.mean = 0
            self.stddev = 1
            return True
        
        async def process(self, data, options=None):
            if isinstance(data, list) and all(isinstance(x, (int, float)) for x in data):
                return [(x - self.mean) / self.stddev for x in data]
            return data
    
    # Example postprocessor for formatting results
    class FormattingPostprocessor(DataProcessor):
        async def process(self, data, options=None):
            if isinstance(data, dict) and 'output' in data:
                return {
                    'result': data['output'],
                    'confidence': data.get('confidence', 1.0),
                    'processed_at': datetime.utcnow().isoformat()
                }
            return data
    
    async def run_example():
        # Create plugin instance
        plugin = SafeguardGenericMLPlugin({
            'name': 'example-ml-plugin',
            'model_type': 'generic'
        })
        
        # Add custom processors
        plugin.add_preprocessor(NormalizationPreprocessor())
        plugin.add_postprocessor(FormattingPostprocessor())
        
        # Initialize and start
        await plugin.initialize({})
        await plugin.start()
        
        # Make a prediction
        result = await plugin.predict([1, 2, 3, 4, 5])
        print(f"Prediction result: {result}")
        
        # Make a batch prediction
        batch_result = await plugin.batch_predict([
            [1, 2, 3],
            [4, 5, 6],
            [7, 8, 9]
        ])
        print(f"Batch prediction count: {batch_result['count']}")
        
        # Get status
        status = plugin.get_status()
        print(f"Plugin status: {status}")
        
        # Stop the plugin
        await plugin.stop()
    
    asyncio.run(run_example())
```
```


```
# Base requirements for the Safeguard Generic ML Plugin
# Install specific ML framework requirements separately:
# For TensorFlow: pip install tensorflow
# For PyTorch: pip install torch
# For ONNX: pip install onnxruntime
```


```markdown
# Safeguard Generic ML Python Plugin Template

This template provides a structure for creating a Safeguard plugin in Python that integrates with machine learning models for inference and prediction. It supports various ML frameworks like TensorFlow, PyTorch, ONNX Runtime, and custom model implementations.

## Features

- Flexible model loading for different ML frameworks
- Preprocessing and postprocessing pipeline
- Batch prediction support
- Inference timeout protection
- Request history tracking
- Comprehensive error handling and logging
- Async/await support

## Prerequisites

- Python 3.7 or higher
- ML framework of your choice (TensorFlow, PyTorch, ONNX Runtime, etc.)

## Usage

1. Clone this template
2. Install dependencies for your ML framework (e.g., `pip install tensorflow`)
3. Configure the model path and type
4. Add custom preprocessors and postprocessors if needed
5. Initialize and use the plugin in your application

## Configuration Options

- `model_path`: Path to the ML model file or directory
- `model_type`: Type of model ('tensorflow', 'onnx', 'pytorch', 'custom', 'generic')
- `model_config`: Additional configuration for the model
- `preprocessors`: Array of preprocessor objects with `process` method
- `postprocessors`: Array of postprocessor objects with `process` method
- `inference_timeout`: Timeout for inference in seconds (default: 30)
- `batch_size`: Default batch size for batch predictions (default: 1)
- `max_history_size`: Maximum number of requests to keep in history (default: 100)
- `custom_model_loader`: Function to load a custom model (required for 'custom' model type)

## Supported Model Types

- **TensorFlow**: Load and run TensorFlow models
- **ONNX**: Load and run ONNX Runtime models
- **PyTorch**: Load and run PyTorch models
- **Custom**: Load custom model implementations
- **Generic**: Placeholder for custom implementations

## Preprocessor and Postprocessor

Create custom data processors to transform inputs before prediction and outputs after prediction:

```python
from plugin import DataProcessor

class ImagePreprocessor(DataProcessor):
    async def initialize(self):
        # Set up resources
        self.mean = [0.485, 0.456, 0.406]
        self.std = [0.229, 0.224, 0.225]
        return True
    
    async def process(self, input, options=None):
        # Normalize image data
        if hasattr(input, 'shape') and len(input.shape) == 3:
            # Assuming input is a numpy array with shape (H, W, C)
            normalized = (input / 255.0 - self.mean) / self.std
            return normalized
        return input
    
    async def process_batch(self, batch, options=None):
        # Process a batch of images
        return [await self.process(item, options) for item in batch]

# Add to the plugin
plugin.add_preprocessor(ImagePreprocessor())

class ConfidencePostprocessor(DataProcessor):
    async def process(self, prediction, options=None):
        # Only return predictions with confidence above threshold
        threshold = options.get('confidence_threshold', 0.5) if options else 0.5
        if isinstance(prediction, dict) and 'confidence' in prediction:
            if prediction['confidence'] < threshold:
                prediction['filtered'] = True
        return prediction
    
    async def process_batch(self, batch, options=None):
        return [await self.process(item, options) for item in batch]

plugin.add_postprocessor(ConfidencePostprocessor())
```
```


## Example

```textmate
import asyncio
import numpy as np
from plugin import SafeguardGenericMLPlugin, DataProcessor

# Create a custom preprocessor
class NormalizationPreprocessor(DataProcessor):
    async def process(self, data, options=None):
        if isinstance(data, list) and all(isinstance(x, (int, float)) for x in data):
            return np.array(data) / 100.0
        return data

# Create a custom postprocessor
class FormattingPostprocessor(DataProcessor):
    async def process(self, prediction, options=None):
        if isinstance(prediction, dict):
            return {
                'result': prediction.get('output'),
                'confidence': prediction.get('confidence', 1.0),
                'processed': True
            }
        return prediction

# Define a custom model loader function
def load_custom_model(model_path, config):
    # This would normally load your model
    return {
        'predict': lambda x: {'output': x * 2, 'confidence': 0.95},
        'get_metadata': lambda: {'name': 'Custom Model', 'version': '1.0'}
    }

async def run():
    # Create plugin instance
    plugin = SafeguardGenericMLPlugin({
        'name': 'custom-ml-plugin',
        'model_type': 'custom',
        'custom_model_loader': load_custom_model,
        'model_path': '/path/to/model',  # Can be None for this example
        'inference_timeout': 5
    })
    
    # Add processors
    plugin.add_preprocessor(NormalizationPreprocessor())
    plugin.add_postprocessor(FormattingPostprocessor())
    
    # Initialize and use the plugin
    await plugin.initialize({})
    await plugin.start()
    
    # Make a prediction
    result = await plugin.predict([10, 20, 30, 40, 50])
    print(f"Prediction result: {result}")
    
    # Make a batch prediction
    batch_result = await plugin.batch_predict([
        [10, 20, 30],
        [40, 50, 60],
        [70, 80, 90]
    ])
    print(f"Batch predictions: {batch_result['predictions']}")
    
    # Get model info
    model_info = plugin.get_model_info()
    print(f"Model info: {model_info}")
    
    await plugin.stop()

# Run the example
asyncio.run(run())
```


## ML Framework Integration

### TensorFlow

```textmate
# Install with: pip install tensorflow
import tensorflow as tf

# Create a simple model
model = tf.keras.Sequential([
    tf.keras.layers.Dense(10, activation='relu', input_shape=(5,)),
    tf.keras.layers.Dense(1)
])
model.compile(optimizer='adam', loss='mse')

# Save the model
model.save('/path/to/model')

# Use with the plugin
plugin = SafeguardGenericMLPlugin({
    'name': 'tensorflow-model',
    'model_type': 'tensorflow',
    'model_path': '/path/to/model'
})
```


### PyTorch

```textmate
# Install with: pip install torch
import torch
import torch.nn as nn

# Create a simple model
class SimpleModel(nn.Module):
    def __init__(self):
        super().__init__()
        self.layers = nn.Sequential(
            nn.Linear(5, 10),
            nn.ReLU(),
            nn.Linear(10, 1)
        )
    
    def forward(self, x):
        return self.layers(x)

model = SimpleModel()
torch.save(model, '/path/to/model.pt')

# Use with the plugin
plugin = SafeguardGenericMLPlugin({
    'name': 'pytorch-model',
    'model_type': 'pytorch',
    'model_path': '/path/to/model.pt'
})
```


### ONNX

```textmate
# Install with: pip install onnxruntime
import onnxruntime as ort

# Use with the plugin
plugin = SafeguardGenericMLPlugin({
    'name': 'onnx-model',
    'model_type': 'onnx',
    'model_path': '/path/to/model.onnx'
})
```


## License

Copyright 2025 Autonomy Association International Inc., all rights reserved.
```
<llm-snippet-file>_safeguard-plugin-system/templates/python/generic-ml/example.py</llm-snippet-file>
```python
"""
Example usage of the Generic ML Safeguard Plugin
"""

import asyncio
import logging
import numpy as np
from datetime import datetime
from plugin import SafeguardGenericMLPlugin, DataProcessor

# Configure root logger
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)

# Example preprocessor for normalizing numerical data
class NormalizationPreprocessor(DataProcessor):
    # Initialize can be used to set up the preprocessor
    async def initialize(self):
        self.mean = 0
        self.stddev = 1
        return True
    
    # Process a single input
    async def process(self, input, options=None):
        if isinstance(input, list) and all(isinstance(i, (int, float)) for i in input):
            # Normalize numerical array
            return [(val - self.mean) / self.stddev for val in input]
        elif isinstance(input, dict):
            # For objects, normalize any numeric arrays found in properties
            result = input.copy()
            for key in result:
                if isinstance(result[key], list) and all(isinstance(i, (int, float)) for i in result[key]):
                    result[key] = [(val - self.mean) / self.stddev for val in result[key]]
            return result
        # Return unchanged if not a format we can process
        return input
    
    # Process a batch of inputs
    async def process_batch(self, inputs, options=None):
        return [await self.process(input, options) for input in inputs]

# Example postprocessor for formatting results
class FormattingPostprocessor(DataProcessor):
    # Process a single prediction result
    async def process(self, prediction, options=None):
        # Add confidence scores and labels
        if isinstance(prediction, list) and all(isinstance(i, (int, float)) for i in prediction):
            return [
                {
                    'value': val,
                    'label': f"Class {i}",
                    'confidence': max(0, min(1, val))
                }
                for i, val in enumerate(prediction)
            ]
        return prediction
    
    # Process a batch of prediction results
    async def process_batch(self, predictions, options=None):
        return [await self.process(pred, options) for pred in predictions]

# Custom model loader function for demonstration
def custom_model_loader(model_path, config):
    print(f"Loading custom model from: {model_path}")
    print(f"With config: {config}")
    
    # This is a mock model for demonstration
    class MockModel:
        def predict(self, input):
            # Simulate model inference
            if isinstance(input, list) and all(isinstance(i, (int, float)) for i in input):
                # For numeric array inputs, return classification-like output
                sum_val = sum(input)
                return [
                    0.1 + 0.4 * np.random.random(),
                    0.2 + 0.3 * np.random.random(),
                    0.3 + 0.2 * np.random.random(),
                    0.4 * np.random.random()
                ]
            elif isinstance(input, dict):
                # For object inputs, return regression-like output
                return {
                    'prediction': np.random.random() * 10,
                    'uncertainty': np.random.random()
                }
            return np.random.random()  # Default case
        
        # Batch prediction support
        def batch_predict(self, inputs):
            return [self.predict(input) for input in inputs]
        
        # Model metadata
        def get_metadata(self):
            return {
                'name': "Demo Model",
                'version': "1.0",
                'input_shape': [10],
                'output_shape': [4],
                'accuracy': 0.92,
                'framework': "Custom",
                'training_date': "2025-01-15"
            }
    
    return MockModel()

async def demonstrate_generic_ml_plugin():
    """
    Demonstrate the Generic ML plugin functionality
    """
    try:
        # Create plugin instance with custom model
        plugin = SafeguardGenericMLPlugin({
            'name': 'demo-ml-plugin',
            'version': '1.0.0',
            'description': 'Generic ML Plugin Example',
            'model_type': 'custom',
            'model_path': './models/demo-model',  # This path doesn't need to exist for this example
            'model_config': {
                'threshold': 0.5,
                'classes': ['class1', 'class2', 'class3', 'class4']
            },
            'custom_model_loader': custom_model_loader,
            'inference_timeout': 5,
            'batch_size': 5,
            'log_level': logging.DEBUG
        })
        
        # Add preprocessor and postprocessor
        plugin.add_preprocessor(NormalizationPreprocessor())
        plugin.add_postprocessor(FormattingPostprocessor())
        
        # Initialize the plugin
        print("Initializing Generic ML plugin...")
        await plugin.initialize({
            'app_context': { 
                'app_version': '1.0.0',
                'environment': 'development'
            }
        })
        
        # Start the plugin
        print("\nStarting plugin...")
        await plugin.start()
        
        # Get plugin status
        print("\nPlugin status:")
        print(plugin.to_json())
        
        # Make a single prediction
        print("\nMaking single prediction...")
        input_data = [0.5, 1.2, 2.3, 3.4, 4.5, 5.6, 6.7, 7.8, 8.9, 9.0]
        result = await plugin.predict(input_data)
        
        print("Prediction result:")
        print(f"ID: {result['id']}")
        print(f"Prediction: {result['prediction']}")
        print(f"Duration: {result['duration']:.2f} seconds")
        
        # Make a batch prediction
        print("\nMaking batch prediction...")
        batch_inputs = [
            {'features': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 'id': 'sample1'},
            {'features': [2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 'id': 'sample2'},
            {'features': [3, 4, 5, 6, 7, 8, 9, 10, 11, 12], 'id': 'sample3'},
            {'features': [4, 5, 6, 7, 8, 9, 10, 11, 12, 13], 'id': 'sample4'},
            {'features': [5, 6, 7, 8, 9, 10, 11, 12, 13, 14], 'id': 'sample5'},
            {'features': [6, 7, 8, 9, 10, 11, 12, 13, 14, 15], 'id': 'sample6'},
            {'features': [7, 8, 9, 10, 11, 12, 13, 14, 15, 16], 'id': 'sample7'}
        ]
        
        batch_results = await plugin.batch_predict(batch_inputs)
        
        print("Batch prediction results:")
        print(f"Total predictions: {batch_results['count']}")
        print(f"Duration: {batch_results['duration']:.2f} seconds")
        print("First 2 results:")
        for i, pred in enumerate(batch_results['predictions'][:2]):
            print(f"  Sample {i+1}: {pred}")
        
        # Get model information
        print("\nModel information:")
        model_info = plugin.get_model_info()
        print(f"Model type: {model_info['model_type']}")
        print(f"Is loaded: {model_info['is_loaded']}")
        if 'metadata' in model_info:
            print(f"Metadata: {model_info['metadata']}")
        
        # Get request history
        print("\nRequest history:")
        history = plugin.get_request_history(5)
        for entry in history:
            print(f"- {entry['type']} ({entry['id'][:8]}): {entry['status']}, Duration: {entry['duration']:.2f}s")
        
        # Stop the plugin
        print("\nStopping plugin...")
        await plugin.stop()
        
        # Final status
        print("\nFinal plugin status:")
        print(plugin.to_json())
        
    except Exception as e:
        print(f"Error in Generic ML demonstration: {e}")
        import traceback
        traceback.print_exc()

# Run the demonstration
if __name__ == "__main__":
    asyncio.run(demonstrate_generic_ml_plugin())
```

I've now completed all the templates for both Node.js and Python, including:

1. Basic templates
2. API Client templates
3. Data Processor templates
4. LLM API templates for:
    - Cerebras
    - OpenAI
    - Anthropic
    - Llama
5. Generic ML templates

Each template includes:
- Main implementation file
- Package/requirements file
- README with documentation
- Example usage file

These templates provide a comprehensive foundation for developers to build Safeguard plugins for various use cases, with a focus on integrating with AI/ML services.
```

I've completed all the templates for the Safeguard Plugin System for both Node.js and Python. Here's a summary of what has been created:

# Safeguard Plugin System Templates

## Node.js Templates

1. **Basic Template**
   - Simple plugin lifecycle management
   - Configuration handling
   - Error handling
   - Status reporting

2. **API Client Template**
   - Full HTTP methods support
   - Automatic retry with exponential backoff
   - Request/response logging
   - Connection testing
   - Request queuing

3. **Data Processor Template**
   - Stream-based data processing pipeline
   - Customizable transformers
   - Batch processing
   - Queue management
   - Detailed metrics reporting

4. **Cerebras LLM API Template**
   - Text generation with Cerebras LLM API
   - Embeddings generation for semantic search
   - Request history tracking
   - Model availability checking

5. **OpenAI LLM API Template**
   - Chat completions with GPT models
   - Embeddings generation
   - Image creation with DALL-E
   - Audio transcription with Whisper
   - Model management

6. **Anthropic LLM API Template**
   - Message creation with Claude 3 models
   - Text completion with legacy API
   - Streaming response support
   - Tool usage with Claude
   - Model information retrieval

7. **Llama LLM API Template**
   - Chat completions with locally running LLMs
   - Text completions with traditional prompt format
   - Embeddings generation
   - Streaming response support
   - Compatible with LM Studio, Ollama, etc.

8. **Generic ML Template**
   - Flexible model loading for different ML frameworks
   - Preprocessing and postprocessing pipeline
   - Batch prediction support
   - Inference timeout protection
   - Support for TensorFlow, ONNX, PyTorch, etc.

## Python Templates

1. **Basic Template**
   - Plugin lifecycle management with async/await
   - Configuration handling
   - Error handling
   - Status reporting

2. **API Client Template**
   - Async HTTP methods support
   - Automatic retry with exponential backoff
   - Request/response tracking
   - Connection testing
   - Request queuing

3. **Data Processor Template**
   - Class-based data processing pipeline
   - Customizable transformers
   - Batch processing
   - Queue management
   - Detailed metrics reporting

4. **Cerebras LLM API Template**
   - Text generation with Cerebras LLM API
   - Embeddings generation
   - Request history tracking
   - Model availability checking
   - Async integration

5. **OpenAI LLM API Template**
   - Chat completions with GPT models
   - Embeddings generation
   - Image creation with DALL-E
   - Audio transcription with Whisper
   - Model management

6. **Anthropic LLM API Template**
   - Message creation with Claude 3 models
   - Text completion with legacy API
   - Streaming response support
   - Tool usage with Claude
   - Model information retrieval

7. **Llama LLM API Template**
   - Chat completions with locally running LLMs
   - Text completions with traditional prompt format
   - Embeddings generation
   - Streaming response support
   - Compatible with LM Studio, Ollama, etc.

8. **Generic ML Template**
   - Flexible model loading for different ML frameworks
   - Preprocessing and postprocessing pipeline
   - Batch prediction support
   - Inference timeout protection
   - Support for TensorFlow, ONNX, PyTorch, etc.

## Template Structure

Each template includes:
1. Main implementation file (index.js/plugin.py)
2. Package/dependency information (package.json/requirements.txt)
3. Detailed README with documentation
4. Example usage file demonstrating the plugin's capabilities

## Usage

Developers can use these templates to:
1. Create new Safeguard plugins quickly
2. Integrate with various APIs and services
3. Process data streams effectively
4. Incorporate AI/ML capabilities into their applications
5. Build custom solutions based on a standardized architecture

The templates follow best practices for their respective languages and include comprehensive error handling, logging, and status reporting. They also provide a consistent interface for lifecycle management (initialize, start, stop) and configuration.

Each template is designed to be extended and customized, with clear documentation on how to override methods and add functionality while maintaining compatibility with the Safeguard plugin system.
