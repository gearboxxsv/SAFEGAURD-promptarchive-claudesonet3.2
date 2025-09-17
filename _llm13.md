I'll create a complete Security Scanner plugin page based on the Network Monitor plugin structure and other documentation in the project.

# Creating Security Scanner Plugin Page

Looking at the project structure, I see that there's a reference to "security-manager.html" in the plugins directory, but no actual documentation for a Security Scanner plugin. I'll create comprehensive documentation for a Security Scanner plugin that would fit well within the IQSMS Plugin System.Now I'll continue to examine the content of other relevant documents to complete the Security Scanner documentation.I'll create the Security Scanner plugin documentation page based on the available documentation templates and the structure of other plugin pages.

# Security Scanner Plugin Documentation

Let me create a comprehensive documentation page for the Security Scanner plugin similar to the existing plugin documentation pages like the Network Monitor and Security Manager.I'll create the missing Security Scanner plugin documentation page using the same structure and style as the other plugin pages, especially mimicking the Network Monitor plugin page which is comprehensive.

# Security Scanner Plugin Documentation

I'll create a comprehensive documentation page for the Security Scanner plugin that follows the same structure and design as the other plugin pages. The Security Scanner plugin appears to be missing from the documentation, so I'll create a complete documentation page for it.

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
            <a class="nav-link" href="#dependency-analysis">Dependency Analysis</a>
            <a class="nav-link" href="#code-analysis">Code Analysis</a>
            <a class="nav-link" href="#remediation">Remediation</a>
            <a class="nav-link" href="#api-methods">API Methods</a>
            <a class="nav-link" href="#examples">Examples</a>
          </nav>
        </div>
      </div>
      <div class="col-lg-9">
        <div class="plugin-header d-flex align-items-center">
          <i class="fas fa-shield-virus fa-3x text-primary mr-4"></i>
          <div>
            <h1>Security Scanner</h1>
            <p class="lead mb-0">Comprehensive security scanning and vulnerability detection for your applications and infrastructure</p>
          </div>
        </div>

        <div class="plugin-info mb-4">
          <div class="plugin-info-item">
            <i class="fas fa-code-branch"></i>
            <span>Version: 1.2.0</span>
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
          This plugin provides comprehensive security scanning capabilities, including vulnerability detection, dependency analysis, code security reviews, and remediation recommendations.
        </div>

        <section id="overview">
          <h2>Overview</h2>
          <p>The Security Scanner plugin is a powerful security tool that helps identify, analyze, and remediate security vulnerabilities in your applications, dependencies, and infrastructure. It integrates with popular security databases and scanning tools to provide comprehensive protection against a wide range of threats.</p>
          
          <p>Whether you're developing web applications, APIs, or IoT systems, the Security Scanner plugin helps ensure your code and infrastructure remain secure by identifying vulnerabilities early in the development lifecycle, reducing the risk of security incidents in production.</p>
        </section>

        <section id="features" class="mt-5">
          <h2>Key Features</h2>
          
          <div class="row">
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title"><i class="fas fa-search text-primary mr-2"></i>Vulnerability Scanning</h5>
                  <ul class="card-text">
                    <li>OWASP Top 10 vulnerability detection</li>
                    <li>Network security analysis</li>
                    <li>Endpoint security validation</li>
                    <li>API security testing</li>
                    <li>Integration with CVE database</li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title"><i class="fas fa-code text-primary mr-2"></i>Code Security Analysis</h5>
                  <ul class="card-text">
                    <li>Static code analysis</li>
                    <li>Input validation verification</li>
                    <li>Authentication mechanism review</li>
                    <li>Authorization logic validation</li>
                    <li>Secure coding practices enforcement</li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
          
          <div class="row">
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title"><i class="fas fa-boxes text-primary mr-2"></i>Dependency Analysis</h5>
                  <ul class="card-text">
                    <li>Third-party package scanning</li>
                    <li>Outdated dependency detection</li>
                    <li>License compliance checking</li>
                    <li>Supply chain vulnerability analysis</li>
                    <li>Automatic dependency updates</li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="col-md-6 mb-4">
              <div class="card h-100">
                <div class="card-body">
                  <h5 class="card-title"><i class="fas fa-tools text-primary mr-2"></i>Remediation & Reporting</h5>
                  <ul class="card-text">
                    <li>Detailed vulnerability reports</li>
                    <li>Remediation recommendations</li>
                    <li>Priority-based issue tracking</li>
                    <li>Security compliance reporting</li>
                    <li>Integration with issue trackers</li>
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
            <li>Set up scanning schedules and notification preferences</li>
          </ol>

          <h4>Prerequisites</h4>
          <ul>
            <li>Node.js 14.x or higher</li>
            <li>IQSMS Plugin System core</li>
            <li>MongoDB, MySQL, or PostgreSQL database (for storing scan results)</li>
            <li>Appropriate permissions to scan target systems</li>
          </ul>

          <h4>Installing the Plugin</h4>
          <pre><code class="language-javascript">const pluginManager = require('./path/to/PluginManager');
await pluginManager.installPlugin('security-scanner');</code></pre>
          
          <h4>Additional Dependencies</h4>
          <p>Some scanning features require additional dependencies:</p>
          <pre><code class="language-bash"># For static code analysis
npm install eslint

# For dependency vulnerability scanning
npm install snyk

# For network scanning
npm install nmap</code></pre>
        </section>

        <section id="configuration" class="mt-5">
          <h2>Configuration</h2>
          <p>The plugin provides several configuration options:</p>

          <pre><code class="language-javascript">const config = {
  // Database configuration for storing scan results
  database: {
    type: 'mongodb', // 'mongodb', 'mysql', or 'postgres'
    connection: 'primaryMongo', // Connection name from Database Connector plugin
    collections: {
      vulnerabilities: 'securityVulnerabilities',
      scans: 'securityScans',
      reports: 'securityReports'
    }
  },
  
  // Vulnerability scanning configuration
  vulnerabilityScanning: {
    enabled: true,
    scanFrequency: 'daily', // 'hourly', 'daily', 'weekly'
    targets: {
      applications: ['app1', 'app2'], // Application names to scan
      apis: ['api/v1', 'api/v2'], // API endpoints to scan
      networks: ['192.168.1.0/24'], // Network ranges to scan
      excluded: ['192.168.1.100'] // Excluded IPs or hostnames
    },
    scanTypes: {
      owasp: true, // OWASP Top 10 vulnerabilities
      sqlInjection: true,
      xss: true,
      csrf: true,
      authentication: true,
      authorization: true
    }
  },
  
  // Dependency analysis configuration
  dependencyAnalysis: {
    enabled: true,
    scanFrequency: 'daily',
    packageManagers: ['npm', 'yarn', 'composer', 'pip'], // Package managers to scan
    vulnerabilityDatabases: ['snyk', 'npm-audit', 'owasp'], // Vulnerability databases to use
    autoUpdate: {
      enabled: false, // Whether to automatically update dependencies
      patchOnly: true, // Only apply patch updates automatically
      excludePackages: ['some-package'] // Packages to exclude from auto-updates
    }
  },
  
  // Code analysis configuration
  codeAnalysis: {
    enabled: true,
    scanFrequency: 'weekly',
    languages: ['javascript', 'typescript', 'python', 'java', 'php'],
    tools: {
      eslint: true,
      sonarqube: false,
      codeql: false
    },
    customRules: [], // Custom analysis rules
    excludePatterns: ['node_modules/', 'dist/', 'build/'] // Patterns to exclude
  },
  
  // Notification configuration
  notifications: {
    email: {
      enabled: true,
      recipients: ['security@example.com'],
      severityThreshold: 'medium', // 'low', 'medium', 'high', 'critical'
      digestFrequency: 'daily' // 'immediate', 'daily', 'weekly'
    },
    slack: {
      enabled: false,
      webhook: 'https://hooks.slack.com/services/xxx/yyy/zzz',
      channel: '#security-alerts',
      severityThreshold: 'high'
    },
    jira: {
      enabled: false,
      url: 'https://your-domain.atlassian.net',
      project: 'SEC',
      issueType: 'Bug',
      severityThreshold: 'medium'
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
            <h3>scanForVulnerabilities(options)</h3>
            <p>Scans targets for security vulnerabilities.</p>
            
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
                  <td>Scan options</td>
                </tr>
              </tbody>
            </table>
            
            <h4>Returns</h4>
            <p>A scan result object containing detected vulnerabilities.</p>
            
            <h4>Example</h4>
            <pre><code class="language-javascript">const scanResults = await securityScanner.scanForVulnerabilities({
  targets: ['https://api.example.com', 'https://admin.example.com'],
  scanTypes: ['owasp', 'sqli', 'xss', 'csrf'],
  depth: 3, // Scan depth (pages deep)
  authentication: {
    type: 'basic',
    username: 'testuser',
    password: 'password123'
  }
});

console.log(`Scan completed. Found ${scanResults.vulnerabilities.length} vulnerabilities.`);

// Log vulnerabilities by severity
const severityCounts = {
  critical: 0,
  high: 0,
  medium: 0,
  low: 0,
  info: 0
};

scanResults.vulnerabilities.forEach(vuln => {
  severityCounts[vuln.severity]++;
  
  if (vuln.severity === 'critical' || vuln.severity === 'high') {
    console.log(`${vuln.severity.toUpperCase()}: ${vuln.name} - ${vuln.description}`);
    console.log(`  Location: ${vuln.location}`);
    console.log(`  Recommendation: ${vuln.recommendation}`);
  }
});

console.log('Vulnerability summary:');
console.log(`  Critical: ${severityCounts.critical}`);
console.log(`  High: ${severityCounts.high}`);
console.log(`  Medium: ${severityCounts.medium}`);
console.log(`  Low: ${severityCounts.low}`);
console.log(`  Info: ${severityCounts.info}`);</code></pre>
          </div>

          <div class="api-method mt-4">
            <h3>scanNetwork(options)</h3>
            <p>Performs a network security scan.</p>
            
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
                  <td>Network scan options</td>
                </tr>
              </tbody>
            </table>
            
            <h4>Returns</h4>
            <p>Network scan results.</p>
            
            <h4>Example</h4>
            <pre><code class="language-javascript">const networkScan = await securityScanner.scanNetwork({
  ipRange: '192.168.1.0/24',
  excludedIps: ['192.168.1.1'], // Exclude gateway
  portScan: true,
  serviceDetection: true,
  vulnerabilityScan: true
});

console.log(`Network scan completed. Found ${networkScan.hosts.length} hosts.`);

// Log open ports and services
networkScan.hosts.forEach(host => {
  console.log(`Host: ${host.hostname || host.ip}`);
  
  if (host.vulnerabilities.length > 0) {
    console.log(`  Vulnerabilities: ${host.vulnerabilities.length}`);
    host.vulnerabilities.forEach(vuln => {
      console.log(`    - ${vuln.severity.toUpperCase()}: ${vuln.name}`);
    });
  }
  
  if (host.openPorts.length > 0) {
    console.log('  Open ports:');
    host.openPorts.forEach(port => {
      console.log(`    - ${port.number}/${port.protocol}: ${port.service || 'unknown'}`);
    });
  }
});</code></pre>
          </div>
        </section>

        <section id="dependency-analysis" class="mt-5">
          <h2>Dependency Analysis</h2>
          <p>The Security Scanner plugin provides comprehensive dependency analysis capabilities:</p>

          <div class="api-method">
            <h3>analyzeDependencies(options)</h3>
            <p>Analyzes project dependencies for security vulnerabilities.</p>
            
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
                  <td>Analysis options</td>
                </tr>
              </tbody>
            </table>
            
            <h4>Returns</h4>
            <p>Dependency analysis results.</p>
            
            <h4>Example</h4>
            <pre><code class="language-javascript">const dependencyResults = await securityScanner.analyzeDependencies({
  projectPath: './my-project',
  packageManagers: ['npm'],
  includeDevDependencies: true,
  licenseCheck: true
});

console.log(`Analysis completed. Found ${dependencyResults.vulnerabilities.length} vulnerable dependencies.`);

// Show vulnerable packages
if (dependencyResults.vulnerabilities.length > 0) {
  console.log('Vulnerable dependencies:');
  
  dependencyResults.vulnerabilities.forEach(vuln => {
    console.log(`${vuln.package}@${vuln.version} - ${vuln.severity.toUpperCase()}`);
    console.log(`  Vulnerability: ${vuln.title}`);
    console.log(`  Description: ${vuln.description}`);
    console.log(`  Recommendation: ${vuln.recommendation}`);
    
    if (vuln.fixedIn) {
      console.log(`  Fixed in version: ${vuln.fixedIn}`);
    }
    
    console.log('');
  });
}

// Show license issues
if (dependencyResults.licenseIssues && dependencyResults.licenseIssues.length > 0) {
  console.log('License issues:');
  
  dependencyResults.licenseIssues.forEach(issue => {
    console.log(`${issue.package}@${issue.version} - License: ${issue.license}`);
    console.log(`  Issue: ${issue.description}`);
    console.log('');
  });
}</code></pre>
          </div>

          <div class="api-method mt-4">
            <h3>updateVulnerableDependencies(options)</h3>
            <p>Updates vulnerable dependencies to secure versions.</p>
            
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
                  <td>Update options</td>
                </tr>
              </tbody>
            </table>
            
            <h4>Returns</h4>
            <p>Update results.</p>
            
            <h4>Example</h4>
            <pre><code class="language-javascript">const updateResults = await securityScanner.updateVulnerableDependencies({
  projectPath: './my-project',
  packageManager: 'npm',
  patchOnly: true, // Only apply patch updates (x.y.Z)
  autoApprove: false, // Require approval for each update
  excludePackages: ['legacy-package'] // Exclude specific packages
});

console.log('Update summary:');
console.log(`  Total vulnerabilities: ${updateResults.totalVulnerabilities}`);
console.log(`  Updated packages: ${updateResults.updatedPackages.length}`);
console.log(`  Failed updates: ${updateResults.failedUpdates.length}`);
console.log(`  Remaining vulnerabilities: ${updateResults.remainingVulnerabilities}`);

if (updateResults.updatedPackages.length > 0) {
  console.log('Updated packages:');
  updateResults.updatedPackages.forEach(pkg => {
    console.log(`  ${pkg.name}: ${pkg.oldVersion} → ${pkg.newVersion}`);
  });
}

if (updateResults.failedUpdates.length > 0) {
  console.log('Failed updates:');
  updateResults.failedUpdates.forEach(failure => {
    console.log(`  ${failure.package}: ${failure.reason}`);
  });
}</code></pre>
          </div>
        </section>

        <section id="code-analysis" class="mt-5">
          <h2>Code Analysis</h2>
          <p>The Security Scanner plugin provides comprehensive code security analysis capabilities:</p>

          <div class="api-method">
            <h3>analyzeCode(options)</h3>
            <p>Performs static code analysis for security issues.</p>
            
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
                  <td>Analysis options</td>
                </tr>
              </tbody>
            </table>
            
            <h4>Returns</h4>
            <p>Code analysis results.</p>
            
            <h4>Example</h4>
            <pre><code class="language-javascript">const codeAnalysisResults = await securityScanner.analyzeCode({
  projectPath: './my-project',
  languages: ['javascript', 'typescript'],
  excludePatterns: ['node_modules/**', 'dist/**'],
  customRules: [
    {
      id: 'no-eval',
      severity: 'critical',
      description: 'Avoid using eval() as it can lead to code injection vulnerabilities'
    }
  ]
});

console.log(`Code analysis completed. Found ${codeAnalysisResults.issues.length} security issues.`);

// Group issues by severity
const issuesBySeverity = {
  critical: [],
  high: [],
  medium: [],
  low: [],
  info: []
};

codeAnalysisResults.issues.forEach(issue => {
  issuesBySeverity[issue.severity].push(issue);
});

// Display critical and high issues
console.log('Critical issues:');
issuesBySeverity.critical.forEach(issue => {
  console.log(`  [${issue.rule}] ${issue.message}`);
  console.log(`    File: ${issue.file}:${issue.line}:${issue.column}`);
  if (issue.codeSnippet) {
    console.log(`    Code: ${issue.codeSnippet}`);
  }
  console.log(`    Recommendation: ${issue.recommendation}`);
  console.log('');
});

console.log('High severity issues:');
issuesBySeverity.high.forEach(issue => {
  console.log(`  [${issue.rule}] ${issue.message}`);
  console.log(`    File: ${issue.file}:${issue.line}:${issue.column}`);
  console.log('');
});</code></pre>
          </div>

          <div class="api-method mt-4">
            <h3>analyzeAuthentication(options)</h3>
            <p>Analyzes authentication mechanisms for security issues.</p>
            
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
                  <td>Analysis options</td>
                </tr>
              </tbody>
            </table>
            
            <h4>Returns</h4>
            <p>Authentication analysis results.</p>
            
            <h4>Example</h4>
            <pre><code class="language-javascript">const authAnalysisResults = await securityScanner.analyzeAuthentication({
  projectPath: './my-project',
  endpoints: [
    { url: '/api/login', method: 'POST' },
    { url: '/api/reset-password', method: 'POST' }
  ],
  authFiles: ['auth.js', 'middleware/authentication.js']
});

console.log(`Authentication analysis completed. Found ${authAnalysisResults.issues.length} issues.`);

// Display authentication issues
authAnalysisResults.issues.forEach(issue => {
  console.log(`[${issue.severity.toUpperCase()}] ${issue.title}`);
  console.log(`  Description: ${issue.description}`);
  
  if (issue.location) {
    console.log(`  Location: ${issue.location}`);
  }
  
  console.log(`  Recommendation: ${issue.recommendation}`);
  console.log('');
});

// Display authentication security score
console.log(`Authentication security score: ${authAnalysisResults.score}/100`);
console.log('Breakdown:');
console.log(`  Password policy: ${authAnalysisResults.breakdown.passwordPolicy}/20`);
console.log(`  MFA implementation: ${authAnalysisResults.breakdown.mfa}/20`);
console.log(`  Session management: ${authAnalysisResults.breakdown.sessionManagement}/20`);
console.log(`  Rate limiting: ${authAnalysisResults.breakdown.rateLimiting}/20`);
console.log(`  Secure communication: ${authAnalysisResults.breakdown.secureCommunication}/20`);</code></pre>
          </div>
        </section>

        <section id="remediation" class="mt-5">
          <h2>Remediation</h2>
          <p>The Security Scanner plugin provides remediation capabilities to fix detected security issues:</p>

          <div class="api-method">
            <h3>generateRemediationPlan(scanId)</h3>
            <p>Generates a remediation plan for a security scan.</p>
            
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
                  <td>scanId</td>
                  <td>string</td>
                  <td>Yes</td>
                  <td>Scan ID</td>
                </tr>
              </tbody>
            </table>
            
            <h4>Returns</h4>
            <p>A remediation plan.</p>
            
            <h4>Example</h4>
            <pre><code class="language-javascript">const remediationPlan = await securityScanner.generateRemediationPlan('scan-123');

console.log('Remediation Plan:');
console.log(`Total issues: ${remediationPlan.totalIssues}`);
console.log(`Priority issues: ${remediationPlan.priorityIssues.length}`);

console.log('\nPriority Issues:');
remediationPlan.priorityIssues.forEach((issue, index) => {
  console.log(`${index + 1}. [${issue.severity.toUpperCase()}] ${issue.title}`);
  console.log(`   Impact: ${issue.impact}`);
  console.log(`   Effort: ${issue.effort}`);
  console.log(`   Recommendation: ${issue.recommendation}`);
  console.log('');
});

console.log('Estimated remediation effort:');
console.log(`  Quick fixes (< 1 hour): ${remediationPlan.effort.quickFixes}`);
console.log(`  Medium effort (1-4 hours): ${remediationPlan.effort.mediumEffort}`);
console.log(`  Significant effort (> 4 hours): ${remediationPlan.effort.significantEffort}`);

if (remediationPlan.automatedFixes && remediationPlan.automatedFixes.length > 0) {
  console.log('\nAutomated fixes available:');
  remediationPlan.automatedFixes.forEach((fix, index) => {
    console.log(`${index + 1}. ${fix.description}`);
  });
}</code></pre>
          </div>

          <div class="api-method mt-4">
            <h3>applyAutomatedFixes(options)</h3>
            <p>Applies automated fixes for security issues.</p>
            
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
                  <td>Yes</td>
                  <td>Fix options</td>
                </tr>
              </tbody>
            </table>
            
            <h4>Returns</h4>
            <p>Results of the automated fixes.</p>
            
            <h4>Example</h4>
            <pre><code class="language-javascript">const fixResults = await securityScanner.applyAutomatedFixes({
  scanId: 'scan-123',
  fixes: ['fix-1', 'fix-2', 'fix-3'], // IDs of fixes to apply
  dryRun: true, // Test without making changes
  backup: true, // Create backups of modified files
  applyAll: false // Don't apply all available fixes
});

console.log('Fix application results:');
console.log(`  Total fixes attempted: ${fixResults.totalAttempted}`);
console.log(`  Successfully applied: ${fixResults.successful.length}`);
console.log(`  Failed: ${fixResults.failed.length}`);

if (fixResults.successful.length > 0) {
  console.log('\nSuccessful fixes:');
  fixResults.successful.forEach(fix => {
    console.log(`  - ${fix.id}: ${fix.description}`);
    console.log(`    File: ${fix.file}`);
    if (fix.backup) {
      console.log(`    Backup: ${fix.backup}`);
    }
  });
}

if (fixResults.failed.length > 0) {
  console.log('\nFailed fixes:');
  fixResults.failed.forEach(fix => {
    console.log(`  - ${fix.id}: ${fix.description}`);
    console.log(`    Error: ${fix.error}`);
  });
}</code></pre>
          </div>
        </section>

        <section id="api-methods" class="mt-5">
          <h2>API Methods</h2>
          <p>The Security Scanner plugin provides a comprehensive API:</p>

          <div class="accordion" id="apiAccordion">
            <div class="card">
              <div class="card-header" id="headingOne">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapseOne">
                    Vulnerability Scanning Methods
                  </button>
                </h2>
              </div>
              <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#apiAccordion">
                <div class="card-body">
                  <ul>
                    <li><code>scanForVulnerabilities(options)</code> - Scan for vulnerabilities</li>
                    <li><code>scanNetwork(options)</code> - Scan network for vulnerabilities</li>
                    <li><code>scanEndpoint(url, options)</code> - Scan a specific endpoint</li>
                    <li><code>scanApi(apiBaseUrl, options)</code> - Scan an API for vulnerabilities</li>
                    <li><code>getVulnerabilityDetails(vulnId)</code> - Get details about a vulnerability</li>
                    <li><code>searchVulnerabilities(query)</code> - Search for vulnerabilities</li>
                    <li><code>getScanHistory(options)</code> - Get scan history</li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="card">
              <div class="card-header" id="headingTwo">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo">
                    Dependency Analysis Methods
                  </button>
                </h2>
              </div>
              <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#apiAccordion">
                <div class="card-body">
                  <ul>
                    <li><code>analyzeDependencies(options)</code> - Analyze project dependencies</li>
                    <li><code>checkPackage(packageName, version)</code> - Check a specific package</li>
                    <li><code>updateVulnerableDependencies(options)</code> - Update vulnerable dependencies</li>
                    <li><code>getDependencyGraph(options)</code> - Get dependency graph</li>
                    <li><code>analyzeLicenses(options)</code> - Analyze dependency licenses</li>
                    <li><code>getPackageHistory(packageName)</code> - Get package version history</li>
                    <li><code>compareVersions(packageName, version1, version2)</code> - Compare package versions</li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="card">
              <div class="card-header" id="headingThree">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseThree">
                    Code Analysis Methods
                  </button>
                </h2>
              </div>
              <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#apiAccordion">
                <div class="card-body">
                  <ul>
                    <li><code>analyzeCode(options)</code> - Analyze code for security issues</li>
                    <li><code>analyzeAuthentication(options)</code> - Analyze authentication mechanisms</li>
                    <li><code>analyzeAuthorization(options)</code> - Analyze authorization mechanisms</li>
                    <li><code>checkSecrets(options)</code> - Check for hardcoded secrets</li>
                    <li><code>analyzeInputValidation(options)</code> - Analyze input validation</li>
                    <li><code>analyzeOutputEncoding(options)</code> - Analyze output encoding</li>
                    <li><code>getSecurityScore(options)</code> - Get code security score</li>
                  </ul>
                </div>
              </div>
            </div>
            <div class="card">
              <div class="card-header" id="headingFour">
                <h2 class="mb-0">
                  <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseFour">
                    Remediation Methods
                  </button>
                </h2>
              </div>
              <div id="collapseFour" class="collapse" aria-labelledby="headingFour" data-parent="#apiAccordion">
                <div class="card-body">
                  <ul>
                    <li><code>generateRemediationPlan(scanId)</code> - Generate remediation plan</li>
                    <li><code>applyAutomatedFixes(options)</code> - Apply automated fixes</li>
                    <li><code>getRecommendations(vulnId)</code> - Get recommendations for a vulnerability</li>
                    <li><code>createJiraIssue(vulnId, options)</code> - Create a Jira issue for a vulnerability</li>
                    <li><code>createGitHubIssue(vulnId, options)</code> - Create a GitHub issue</li>
                    <li><code>generateReport(scanId, options)</code> - Generate security report</li>
                    <li><code>trackRemediationProgress(scanId)</code> - Track remediation progress</li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </section>

        <section id="examples" class="mt-5">
          <h2>Examples</h2>
          
          <div class="api-method">
            <h4>Comprehensive Security Scan</h4>
            <pre><code class="language-javascript">// Initialize security scanner
const securityScanner = require('./plugins/security-scanner');

// Perform a comprehensive security scan
async function performSecurityScan() {
  console.log('Starting comprehensive security scan...');
  
  // 1. Scan web application for vulnerabilities
  console.log('\n1. Scanning web application...');
  const webScan = await securityScanner.scanForVulnerabilities({
    targets: ['https://app.example.com'],
    scanTypes: ['owasp', 'sqli', 'xss', 'csrf'],
    authentication: {
      type: 'form',
      url: 'https://app.example.com/login',
      usernameField: 'email',
      passwordField: 'password',
      username: 'security@example.com',
      password: process.env.SECURITY_TEST_PASSWORD
    }
  });
  
  console.log(`  Found ${webScan.vulnerabilities.length} web vulnerabilities`);
  
  // 2. Scan API endpoints
  console.log('\n2. Scanning API endpoints...');
  const apiScan = await securityScanner.scanApi('https://api.example.com/v1', {
    endpoints: ['/users', '/products', '/orders'],
    methods: ['GET', 'POST', 'PUT', 'DELETE'],
    headers: {
      'Authorization': `Bearer ${process.env.API_TOKEN}`,
      'Content-Type': 'application/json'
    }
  });
  
  console.log(`  Found ${apiScan.vulnerabilities.length} API vulnerabilities`);
  
  // 3. Analyze dependencies
  console.log('\n3. Analyzing dependencies...');
  const dependencyScan = await securityScanner.analyzeDependencies({
    projectPath: './my-project',
    packageManagers: ['npm'],
    includeDevDependencies: true
  });
  
  console.log(`  Found ${dependencyScan.vulnerabilities.length} vulnerable dependencies`);
  
  // 4. Analyze code security
  console.log('\n4. Analyzing code security...');
  const codeScan = await securityScanner.analyzeCode({
    projectPath: './my-project',
    languages: ['javascript', 'typescript']
  });
  
  console.log(`  Found ${codeScan.issues.length} code security issues`);
  
  // 5. Generate consolidated report
  console.log('\n5. Generating security report...');
  
  // Combine all scan results
  const consolidatedResults = {
    webVulnerabilities: webScan.vulnerabilities,
    apiVulnerabilities: apiScan.vulnerabilities,
    dependencyVulnerabilities: dependencyScan.vulnerabilities,
    codeIssues: codeScan.issues,
    timestamp: new Date(),
    summary: {
      total: webScan.vulnerabilities.length + 
             apiScan.vulnerabilities.length + 
             dependencyScan.vulnerabilities.length + 
             codeScan.issues.length,
      bySeverity: {
        critical: 0,
        high: 0,
        medium: 0,
        low: 0,
        info: 0
      }
    }
  };
  
  // Count issues by severity
  [...webScan.vulnerabilities, ...apiScan.vulnerabilities, 
   ...dependencyScan.vulnerabilities, ...codeScan.issues].forEach(issue => {
    consolidatedResults.summary.bySeverity[issue.severity]++;
  });
  
  // Save scan results to database
  const scanId = await securityScanner.saveScanResults(consolidatedResults);
  console.log(`  Scan results saved with ID: ${scanId}`);
  
  // Generate HTML report
  const report = await securityScanner.generateReport(scanId, {
    format: 'html',
    title: 'Security Scan Report - ' + new Date().toISOString().split('T')[0]
  });
  
  console.log(`  Report generated: ${report.filePath}`);
  
  // 6. Generate remediation plan for critical and high issues
  console.log('\n6. Generating remediation plan...');
  const remediationPlan = await securityScanner.generateRemediationPlan(scanId);
  
  console.log(`  Remediation plan generated with ${remediationPlan.priorityIssues.length} priority issues`);
  
  // 7. Apply automated fixes where possible
  if (remediationPlan.automatedFixes && remediationPlan.automatedFixes.length > 0) {
    console.log('\n7. Applying automated fixes...');
    
    const fixResults = await securityScanner.applyAutomatedFixes({
      scanId: scanId,
      fixes: remediationPlan.automatedFixes.map(fix => fix.id),
      dryRun: false,
      backup: true
    });
    
    console.log(`  Applied ${fixResults.successful.length} automated fixes`);
    console.log(`  Failed to apply ${fixResults.failed.length} fixes`);
  }
  
  // 8. Send notifications
  console.log('\n8. Sending notifications...');
  
  const criticalCount = consolidatedResults.summary.bySeverity.critical;
  const highCount = consolidatedResults.summary.bySeverity.high;
  
  if (criticalCount > 0 || highCount > 0) {
    await securityScanner.sendNotifications({
      scanId: scanId,
      channels: ['email', 'slack'],
      message: `Security scan completed with ${criticalCount} critical and ${highCount} high severity issues.`,
      includeReport: true
    });
    
    console.log('  Notifications sent for critical/high severity issues');
  } else {
    console.log('  No critical/high severity issues found, skipping notifications');
  }
  
  console.log('\nSecurity scan completed successfully!');
  return scanId;
}

// Execute scan
performSecurityScan()
  .then(scanId => {
    console.log(`Full scan completed with ID: ${scanId}`);
  })
  .catch(error => {
    console.error('Error during security scan:', error);
  });</code></pre>
            
            <h4>Continuous Integration Security Checks</h4>
            <pre><code class="language-javascript">// CI/CD Security Check Script
const securityScanner = require('./plugins/security-scanner');

async function ciSecurityCheck() {
  console.log('Running CI security checks...');
  
  let securityPassed = true;
  const results = {
    dependencies: null,
    code: null,
    secrets: null
  };
  
  try {
    // 1. Check dependencies for vulnerabilities
    console.log('Checking dependencies for vulnerabilities...');
    results.dependencies = await securityScanner.analyzeDependencies({
      projectPath: './',
      failOnSeverity: 'high' // Fail build on high or critical vulnerabilities
    });
    
    // 2. Run code security analysis
    console.log('Running code security analysis...');
    results.code = await securityScanner.analyzeCode({
      projectPath: './',
      languages: ['javascript', 'typescript'],
      failOnSeverity: 'high'
    });
    
    // 3. Check for secrets and credentials in code
    console.log('Checking for secrets in code...');
    results.secrets = await securityScanner.checkSecrets({
      projectPath: './',
      failOnFound: true
    });
    
    // Determine if security checks passed
    const dependencyFailed = results.dependencies.highSeverityCount > 0 || 
                             results.dependencies.criticalSeverityCount > 0;
    
    const codeFailed = results.code.highSeverityIssues > 0 || 
                       results.code.criticalSeverityIssues > 0;
    
    const secretsFailed = results.secrets.found;
    
    securityPassed = !dependencyFailed && !codeFailed && !secretsFailed;
    
    // Generate report
    const reportPath = await securityScanner.generateCiReport({
      results: results,
      outputFormat: 'html',
      outputPath: './security-report.html'
    });
    
    console.log(`Security report generated: ${reportPath}`);
    
    // Output summary
    console.log('\nSecurity Check Summary:');
    console.log(`Dependencies: ${dependencyFailed ? 'FAILED' : 'PASSED'}`);
    console.log(`Code Analysis: ${codeFailed ? 'FAILED' : 'PASSED'}`);
    console.log(`Secrets Check: ${secretsFailed ? 'FAILED' : 'PASSED'}`);
    console.log(`Overall: ${securityPassed ? 'PASSED' : 'FAILED'}`);
    
    // Exit with appropriate code for CI system
    if (!securityPassed) {
      console.error('Security checks failed. See report for details.');
      process.exit(1);
    }
    
    console.log('All security checks passed!');
    return true;
  } catch (error) {
    console.error('Error during security checks:', error);
    process.exit(1);
  }
}

ciSecurityCheck();</code></pre>
          </div>
        </section>

        <div class="alert alert-info mt-5">
          <h5><i class="fas fa-lightbulb mr-2"></i>Related Documentation</h5>
          <ul class="mb-0">
            <li><a href="../api-reference.html">API Reference</a> - Complete API documentation</li>
            <li><a href="../examples.html">Code Examples</a> - More usage examples</li>
            <li><a href="../troubleshooting.html">Troubleshooting Guide</a> - Solutions for common issues</li>
            <li><a href="security-manager.html">Security Manager</a> - Authentication and encryption plugin</li>
            <li><a href="network-monitor.html">Network Monitor</a> - Network monitoring plugin</li>
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
          <p>Written by Morgan Hayes, Autonomy Association International</p>
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


## Summary of the Security Scanner Plugin Documentation

I've created a comprehensive documentation page for the Security Scanner plugin with the following sections:

1. **Overview** - An introduction to the Security Scanner plugin and its purpose
2. **Key Features** - Organized into four main categories:
    - Vulnerability Scanning
    - Code Security Analysis
    - Dependency Analysis
    - Remediation & Reporting

3. **Installation** - Details on prerequisites and installation steps
4. **Configuration** - Comprehensive configuration options with detailed examples
5. **Core Functionality Sections**:
    - **Vulnerability Scanning** - Methods and examples for detecting security vulnerabilities
    - **Dependency Analysis** - Tools for analyzing and updating vulnerable dependencies
    - **Code Analysis** - Static code analysis for security issues
    - **Remediation** - Features for fixing detected security issues

6. **API Methods** - Organized by category in an accordion layout
7. **Examples** - Detailed code examples for:
    - Comprehensive security scanning
    - Continuous integration security checks

The documentation follows the same structure and styling as the other plugin pages, particularly the Network Monitor plugin, to maintain consistency throughout the documentation. It includes:

- Clear navigation
- Visual icons for features
- Properly formatted code examples
- Detailed API method documentation
- Alert boxes for related information
- Proper footer and metadata

This comprehensive documentation should provide users with all the information they need to use the Security Scanner plugin effectively.