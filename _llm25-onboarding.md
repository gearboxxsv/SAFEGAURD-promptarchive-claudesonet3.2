Based on your feedback, I'll modify the solution to include the source code scanning for API methods and events, support for proper Python script detection, and adjust the HTML to use the correct URL. I'll maintain the existing layout for the HTML while improving the bash and PowerShell scripts.

Let me create the updated version of both files:

## 1. HTML Page with Updated URLs and Copy Button

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Safeguard Plugin Onboarding</title>
  <style>
    :root {
      --primary-color: #4363d8;
      --secondary-color: #f6821f;
      --background-color: #f5f7fa;
      --text-color: #333;
      --accent-color: #3cb44b;
      --code-bg: #f8f8f8;
      --code-border: #e1e4e8;
    }
    
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      line-height: 1.6;
      color: var(--text-color);
      background-color: var(--background-color);
      margin: 0;
      padding: 0;
    }
    
    .container {
      max-width: 1200px;
      margin: 0 auto;
      padding: 20px;
    }
    
    header {
      background-color: var(--primary-color);
      color: white;
      padding: 30px 0;
      text-align: center;
    }
    
    h1, h2, h3 {
      margin-top: 0;
    }
    
    .hero {
      text-align: center;
      padding: 50px 0;
      background-color: white;
      border-radius: 5px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
      margin-bottom: 30px;
    }
    
    .hero h2 {
      font-size: 2em;
      margin-bottom: 20px;
    }
    
    .cta-button {
      display: inline-block;
      background-color: var(--secondary-color);
      color: white;
      padding: 12px 24px;
      border-radius: 4px;
      text-decoration: none;
      font-weight: bold;
      margin-top: 20px;
      transition: background-color 0.3s;
    }
    
    .cta-button:hover {
      background-color: #e67300;
    }
    
    .features {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
      gap: 30px;
      margin: 40px 0;
    }
    
    .feature-card {
      background-color: white;
      border-radius: 5px;
      padding: 25px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }
    
    .feature-card h3 {
      color: var(--primary-color);
      margin-bottom: 15px;
    }
    
    .code-block {
      background-color: var(--code-bg);
      border: 1px solid var(--code-border);
      border-radius: 4px;
      padding: 15px;
      overflow-x: auto;
      margin: 20px 0;
      font-family: 'Consolas', 'Monaco', monospace;
    }
    
    .steps {
      counter-reset: step-counter;
      margin: 40px 0;
    }
    
    .step {
      margin-bottom: 30px;
      position: relative;
      padding-left: 50px;
    }
    
    .step::before {
      content: counter(step-counter);
      counter-increment: step-counter;
      position: absolute;
      left: 0;
      top: 0;
      width: 35px;
      height: 35px;
      background-color: var(--primary-color);
      color: white;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      font-weight: bold;
    }
    
    footer {
      background-color: #333;
      color: white;
      text-align: center;
      padding: 20px;
      margin-top: 50px;
    }
    
    @media (max-width: 768px) {
      .features {
        grid-template-columns: 1fr;
      }
    }
    
    #script-box {
      position: relative;
    }
    
    #copy-btn {
      position: absolute;
      top: 10px;
      right: 10px;
      background-color: var(--primary-color);
      color: white;
      border: none;
      border-radius: 4px;
      padding: 5px 10px;
      cursor: pointer;
    }
    
    .tabs {
      display: flex;
      margin-bottom: 0;
    }
    
    .tab {
      padding: 10px 20px;
      background-color: #ddd;
      border-top-left-radius: 5px;
      border-top-right-radius: 5px;
      cursor: pointer;
      margin-right: 5px;
    }
    
    .tab.active {
      background-color: var(--code-bg);
      border: 1px solid var(--code-border);
      border-bottom: none;
    }
    
    .tab-content {
      display: none;
    }
    
    .tab-content.active {
      display: block;
    }
  </style>
</head>
<body>
  <header>
    <div class="container">
      <h1>Safeguard Plugin System</h1>
      <p>Create, package, and deploy plugins for the Safeguard platform</p>
    </div>
  </header>
  
  <div class="container">
    <section class="hero">
      <h2>Get Started with Onboarding a Plugin Today</h2>
      <p>Transform your Node.js or Python application into a Safeguard plugin with our simple onboarding process.</p>
      <p>Open a shell on your machine within the directory of your plugin, paste the script, and run it.</p>
      <a href="#setup-script" class="cta-button">Click here to copy the script</a>
    </section>
    
    <section class="features">
      <div class="feature-card">
        <h3>Multi-Runtime Support</h3>
        <p>Package Node.js or Python applications as plugins with automatic dependency detection and management.</p>
      </div>
      <div class="feature-card">
        <h3>Containerization</h3>
        <p>Automatically generate Dockerfiles or use your existing container configuration for secure deployment.</p>
      </div>
      <div class="feature-card">
        <h3>API Contracts</h3>
        <p>Define methods, events, and permissions with our guided setup process to integrate with the Safeguard ecosystem.</p>
      </div>
      <div class="feature-card">
        <h3>Flexible Billing</h3>
        <p>Set up one-time payments, subscriptions, or token-based billing models for your plugin.</p>
      </div>
      <div class="feature-card">
        <h3>Cross-Platform</h3>
        <p>Our setup scripts work on Windows, macOS, and Linux to ensure a consistent developer experience.</p>
      </div>
      <div class="feature-card">
        <h3>Visual Customization</h3>
        <p>Define icons, colors, and categories to make your plugin stand out in the marketplace.</p>
      </div>
    </section>
    
    <section id="setup-script">
      <h2>Plugin Setup Script</h2>
      <p>Copy the script below and run it in your project directory:</p>
      
      <div class="tabs">
        <div class="tab active" data-tab="bash">Bash (macOS/Linux)</div>
        <div class="tab" data-tab="powershell">PowerShell (Windows)</div>
      </div>
      
      <div id="script-box">
        <div class="tab-content active" data-tab="bash">
          <div class="code-block">
            <button id="copy-btn" onclick="copyBashScript()">Copy</button>
            <pre><code>curl -fsSL https://safeguard.iqsms.com/plugin-onboarding.sh | bash</code></pre>
          </div>
        </div>
        
        <div class="tab-content" data-tab="powershell">
          <div class="code-block">
            <button id="copy-btn" onclick="copyPowershellScript()">Copy</button>
            <pre><code>Invoke-Expression (Invoke-WebRequest -Uri https://safeguard.iqsms.com/plugin-onboarding.ps1 -UseBasicParsing).Content</code></pre>
          </div>
        </div>
      </div>
    </section>
    
    <section class="steps">
      <h2>How to Onboard Your Plugin</h2>
      
      <div class="step">
        <h3>Prepare Your Project</h3>
        <p>Ensure your Node.js or Python project is ready for packaging. Make sure you have the correct dependencies in your package.json or requirements.txt file.</p>
      </div>
      
      <div class="step">
        <h3>Run the Setup Script</h3>
        <p>Open a terminal or PowerShell in your project directory and run the onboarding script:</p>
        <p><strong>For macOS/Linux:</strong></p>
        <div class="code-block">
          <pre><code>curl -fsSL https://safeguard.iqsms.com/plugin-onboarding.sh | bash</code></pre>
        </div>
        <p><strong>For Windows:</strong></p>
        <div class="code-block">
          <pre><code>Invoke-Expression (Invoke-WebRequest -Uri https://safeguard.iqsms.com/plugin-onboarding.ps1 -UseBasicParsing).Content</code></pre>
        </div>
      </div>
      
      <div class="step">
        <h3>Follow the Wizard</h3>
        <p>The script will guide you through the configuration process, detecting your project type, dependencies, and helping you set up the plugin metadata.</p>
      </div>
      
      <div class="step">
        <h3>Review and Confirm</h3>
        <p>Review the generated configuration to ensure it matches your plugin's requirements, then confirm to proceed with the packaging.</p>
      </div>
      
      <div class="step">
        <h3>Submit Your Plugin</h3>
        <p>Once packaged, you can submit your plugin to the Safeguard repository or maintain it in your own Git repository for continuous development.</p>
      </div>
    </section>
    
    <section>
      <h2>Learn More</h2>
      <p>For more detailed information about the Safeguard plugin architecture and development best practices, check out our documentation:</p>
      <ul>
        <li><a href="#">Plugin Architecture Overview</a></li>
        <li><a href="#">API Reference</a></li>
        <li><a href="#">Development Best Practices</a></li>
        <li><a href="#">Plugin Security Guidelines</a></li>
      </ul>
    </section>
  </div>
  
  <footer>
    <p>Copyright 2025 Autonomy Association International Inc., all rights reserved.</p>
    <p>Safeguard patent license from National Aeronautics and Space Administration (NASA).</p>
  </footer>
  
  <script>
    function copyBashScript() {
      const scriptText = document.querySelector('.tab-content[data-tab="bash"] pre code').textContent;
      navigator.clipboard.writeText(scriptText);
      document.getElementById('copy-btn').textContent = 'Copied!';
      setTimeout(() => {
        document.getElementById('copy-btn').textContent = 'Copy';
      }, 2000);
    }
    
    function copyPowershellScript() {
      const scriptText = document.querySelector('.tab-content[data-tab="powershell"] pre code').textContent;
      navigator.clipboard.writeText(scriptText);
      document.getElementById('copy-btn').textContent = 'Copied!';
      setTimeout(() => {
        document.getElementById('copy-btn').textContent = 'Copy';
      }, 2000);
    }
    
    document.querySelectorAll('.tab').forEach(tab => {
      tab.addEventListener('click', () => {
        // Remove active class from all tabs
        document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
        // Add active class to clicked tab
        tab.classList.add('active');
        
        // Hide all content
        document.querySelectorAll('.tab-content').forEach(content => content.classList.remove('active'));
        // Show corresponding content
        document.querySelector(`.tab-content[data-tab="${tab.dataset.tab}"]`).classList.add('active');
      });
    });
  </script>
</body>
</html>
```


## 2. Updated README.md for Git Repository

```markdown
# Safeguard Plugin System

## Overview

The Safeguard Plugin System enables developers to extend the Safeguard platform with custom functionality through a secure and standardized plugin architecture. This repository contains tools and documentation to help you create, package, and deploy plugins for the Safeguard ecosystem.

## Quick Start

To quickly onboard your Node.js or Python application as a Safeguard plugin, run our setup script in your project directory:

**For macOS/Linux:**
```
bash
curl -fsSL https://safeguard.iqsms.com/plugin-onboarding.sh | bash
```
**For Windows (PowerShell):**
```
powershell
Invoke-Expression (Invoke-WebRequest -Uri https://safeguard.iqsms.com/plugin-onboarding.ps1 -UseBasicParsing).Content
```
The script will guide you through the process of configuring your plugin, generating necessary files, and packaging it for distribution.

## Plugin Architecture

Safeguard plugins follow a standardized architecture with these key components:

### 1. Configuration File

Each plugin requires a `config.json` file that defines:

- **Metadata**: ID, name, version, description, author, license, etc.
- **API**: Methods and events the plugin exposes
- **Dependencies**: Other plugins required for operation
- **UI Elements**: Icon, color, and category for display
- **Billing**: Pricing model and usage metrics

Example:
```
json
{
"id": "my-plugin-1.0.0",
"version": "1.0.0",
"name": "My Plugin",
"description": "A sample plugin for Safeguard",
"author": "Your Company",
"license": "MIT",
"copyright": "Copyright 2025 Your Company, all rights reserved.",
"type": "utility",
"entryPoint": "index.js",
"billing": {
"tokenCost": 0,
"freeQuota": {
"enabled": true,
"limit": "unlimited"
}
},
"permissions": [
"files:read"
],
"dependencies": [],
"configuration": {
"logLevel": {
"type": "string",
"default": "info",
"description": "Log level (debug, info, warn, error)"
}
},
"api": {
"methods": [
{
"name": "exampleMethod",
"description": "An example method",
"parameters": ["param1", "param2"],
"returns": "Object"
}
],
"events": [
{
"name": "exampleEvent",
"description": "An example event"
}
]
},
"ui": {
"icon": "puzzle-piece",
"color": "#4363d8",
"category": "Utility"
}
}
```
### 2. Entry Point

Your plugin must have a main entry point file (e.g., `index.js` for Node.js or `app.py` for Python) that exports a `registerPlugin` function:
```
javascript
/**
* Register the plugin with the Safeguard system
* @param {Object} system - Safeguard system
* @param {Object} options - Plugin options
* @returns {Promise<Object>} - Plugin instance
  */
  async function registerPlugin(system, options = {}) {
  // Initialize and register plugin
  // ...

return pluginInstance;
}

module.exports = { registerPlugin };
```
### 3. Containerization

Plugins are deployed as containers for security and isolation. You can provide your own Dockerfile or let the onboarding script generate one for you.

## Plugin Categories

Safeguard plugins can belong to these categories:

- **Artificial Intelligence (AI)**
- **Machine Learning (ML)**
- **Networking**
- **Data Management**
- **Development Frameworks**
- **Automation**
- **Cybersecurity**
- **Cloud Computing**

## Billing Models

Plugins can use various billing models:

1. **Free**: No cost to use
2. **One-time payment**: Single payment for access
3. **Subscription**: Recurring payment (minutes, hours, days, months)
4. **Token-based**: Pay per use with tokens (1 token = $0.01)

## Development Process

1. **Create your application**: Develop your Node.js or Python application
2. **Run the onboarding script**: Configure your plugin metadata
3. **Implement API methods**: Add functionality exposed through your plugin's API
4. **Test locally**: Verify your plugin works as expected
5. **Package and deploy**: Submit your plugin to the Safeguard repository

## Plugin Security

Safeguard enforces strict security measures for plugins:

- Containerized execution environment
- Permission-based access control
- Dependency validation
- Code scanning for vulnerabilities

## Best Practices

- Keep dependencies minimal and up-to-date
- Use semantic versioning for your plugin
- Document your API methods and events clearly
- Implement proper error handling
- Add comprehensive logging
- Use the configuration system for user-configurable options
- Follow the principle of least privilege for permissions

## Testing

Before submitting your plugin, test it thoroughly:

1. Verify all API methods work as documented
2. Test error conditions and edge cases
3. Ensure proper cleanup on shutdown
4. Check performance under load
5. Validate container security

## Support

If you need assistance with plugin development, please contact us at:

- Email: plugins@safeguard.iqsms.com
- Discord: [Safeguard Developer Community](https://discord.gg/safeguard-dev)
- GitHub Issues: [Report Issues](https://github.com/safeguard/plugin-system/issues)

## License

Copyright 2025 Autonomy Association International Inc., all rights reserved.
Safeguard patent license from National Aeronautics and Space Administration (NASA).
```


## 3. Shell Script with Enhanced Features (plugin-onboarding.sh)

Now I'll create the Bash script with code analysis and method extraction capabilities:

```shell script
#!/bin/bash
# Safeguard Plugin Onboarding Script
# Copyright 2025 Autonomy Association International Inc., all rights reserved.
# Version 1.0.0

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
RESET='\033[0m'

# Display header
echo -e "${BLUE}┌───────────────────────────────────────────────┐${RESET}"
echo -e "${BLUE}│       SAFEGUARD PLUGIN ONBOARDING WIZARD      │${RESET}"
echo -e "${BLUE}├───────────────────────────────────────────────┤${RESET}"
echo -e "${BLUE}│ Copyright 2025 Autonomy Association Int'l Inc.│${RESET}"
echo -e "${BLUE}└───────────────────────────────────────────────┘${RESET}"
echo ""

# Check for required commands
check_dependencies() {
  local missing_deps=false
  
  for cmd in "jq" "zip" "git"; do
    if ! command -v $cmd &> /dev/null; then
      echo -e "${YELLOW}Warning: $cmd is not installed. Some features may not work.${RESET}"
      missing_deps=true
    fi
  done
  
  if [ "$missing_deps" = true ]; then
    echo -e "${YELLOW}Consider installing the missing dependencies for full functionality.${RESET}"
    echo ""
  fi
}

check_dependencies

# Help function
show_help() {
  echo -e "${CYAN}SAFEGUARD PLUGIN ONBOARDING HELP${RESET}"
  echo -e "${CYAN}=================================${RESET}"
  echo ""
  echo -e "This wizard guides you through the process of creating a Safeguard plugin from your existing Node.js or Python project."
  echo ""
  echo -e "${GREEN}The wizard will:${RESET}"
  echo "1. Detect your project type (Node.js or Python)"
  echo "2. Parse your dependencies"
  echo "3. Set up Docker containerization"
  echo "4. Create a plugin configuration file"
  echo "5. Package your plugin for distribution"
  echo "6. Help you set up a Git repository"
  echo ""
  echo -e "${YELLOW}Navigation:${RESET}"
  echo "- Use arrow keys to navigate menus"
  echo "- Press Enter to select an option"
  echo "- Type 'exit' at any prompt to quit"
  echo "- Type 'help' at any prompt to show this help"
  echo ""
  echo -e "${BLUE}Copyright 2025 Autonomy Association International Inc., all rights reserved.${RESET}"
  echo "Safeguard patent license from National Aeronautics and Space Administration (NASA)."
  echo ""
}

# Detect runtime
detect_runtime() {
  echo -e "${CYAN}Detecting project runtime...${RESET}"
  
  # Check for package.json (Node.js)
  if [ -f "package.json" ]; then
    echo -e "${GREEN}Found Node.js project (package.json)${RESET}"
    runtime="nodejs"
    config_file="package.json"
  # Check for Python files and environments
  elif [ -f "requirements.txt" ]; then
    echo -e "${GREEN}Found Python project (requirements.txt)${RESET}"
    runtime="python"
    config_file="requirements.txt"
  # Check for setup.py
  elif [ -f "setup.py" ]; then
    echo -e "${GREEN}Found Python project (setup.py)${RESET}"
    runtime="python"
    config_file="setup.py"
  # Check for Pipfile
  elif [ -f "Pipfile" ]; then
    echo -e "${GREEN}Found Python project (Pipfile)${RESET}"
    runtime="python"
    config_file="Pipfile"
  # Check for Python virtual environments
  elif [ -d "venv" ] || [ -d ".venv" ] || [ -d "env" ] || [ -d ".env" ] || [ -d "virtualenv" ]; then
    echo -e "${GREEN}Found Python virtual environment${RESET}"
    runtime="python"
    
    # Look for Python files in the directory
    python_files=$(find . -maxdepth 1 -name "*.py" | sort)
    if [ -z "$python_files" ]; then
      echo -e "${YELLOW}No Python files found in the root directory.${RESET}"
      python_files=$(find . -name "*.py" | sort)
    fi
    
    if [ -n "$python_files" ]; then
      # Use first Python file as a fallback
      config_file=$(echo "$python_files" | head -n 1)
      echo -e "${YELLOW}Using Python file: ${config_file}${RESET}"
    else
      echo -e "${RED}No Python files found.${RESET}"
      config_file=""
    fi
  else
    echo -e "${YELLOW}Could not automatically detect project type.${RESET}"
    echo -e "Please select your project type:"
    select rt in "Node.js" "Python" "Exit"; do
      case $rt in
        "Node.js")
          runtime="nodejs"
          echo -e "${YELLOW}Please select the configuration file:${RESET}"
          select_file "package.json"
          break
          ;;
        "Python")
          runtime="python"
          echo -e "${YELLOW}Please select the configuration file:${RESET}"
          select_file "requirements.txt"
          break
          ;;
        "Exit")
          echo -e "${RED}Exiting...${RESET}"
          exit 0
          ;;
      esac
    done
  fi
  
  echo -e "Is ${CYAN}$config_file${RESET} the correct configuration file? (y/n)"
  read -r confirm
  
  if [[ $confirm != "y" && $confirm != "Y" ]]; then
    select_file
  fi
  
  return 0
}

# Function to display a selectable file list
select_file() {
  local default=$1
  local files=($(find . -type f -name "*.json" -o -name "*.txt" -o -name "*.py" -o -name "*.js" | sort))
  files+=("Exit")
  
  echo "Select configuration file:"
  select file in "${files[@]}"; do
    if [ "$file" == "Exit" ]; then
      echo -e "${RED}Exiting...${RESET}"
      exit 0
    elif [ -n "$file" ]; then
      config_file="${file:2}" # Remove ./ from the beginning
      echo -e "Selected: ${CYAN}$config_file${RESET}"
      break
    fi
  done
}

# Parse dependencies
parse_dependencies() {
  echo -e "${CYAN}Parsing dependencies from $config_file...${RESET}"
  
  if [ "$runtime" == "nodejs" ]; then
    # For Node.js projects
    if command -v jq &> /dev/null; then
      dependencies=$(jq -r '.dependencies | keys | .[]' "$config_file" 2>/dev/null)
      if [ $? -ne 0 ]; then
        echo -e "${YELLOW}Warning: Could not parse dependencies with jq.${RESET}"
        dependencies=""
      fi
    else
      echo -e "${YELLOW}Warning: jq is not installed. Cannot parse dependencies.${RESET}"
      dependencies=""
    fi
  elif [ "$runtime" == "python" ]; then
    # For Python projects
    if [ -f "requirements.txt" ]; then
      dependencies=$(cat "requirements.txt" | grep -v '^\s*#' | grep -v '^\s*$')
    elif [ -f "setup.py" ]; then
      # Extract install_requires from setup.py
      dependencies=$(grep -A 20 "install_requires" setup.py | grep -oP "(?<=').*?(?=')" | grep -v "^$")
    elif [ -f "Pipfile" ]; then
      # Extract packages from Pipfile
      dependencies=$(grep -A 100 "\[packages\]" Pipfile | grep -B 100 "\[dev-packages\]" | grep "=" | cut -d' ' -f1)
    fi
  fi
  
  echo -e "${GREEN}Detected dependencies:${RESET}"
  if [ -z "$dependencies" ]; then
    echo "None found"
  else
    echo "$dependencies"
  fi
  echo ""
}

# Check for Dockerfile
check_dockerfile() {
  if [ -f "Dockerfile" ]; then
    echo -e "${GREEN}Found existing Dockerfile${RESET}"
    has_dockerfile=true
    
    echo "Would you like to use this Dockerfile? (y/n)"
    read -r use_existing
    
    if [[ $use_existing != "y" && $use_existing != "Y" ]]; then
      create_dockerfile
    else
      # Parse Dockerfile to determine image and entrypoint
      dockerfile_image=$(grep -i "^FROM" Dockerfile | head -1 | cut -d' ' -f2-)
      dockerfile_entrypoint=$(grep -i "^ENTRYPOINT\|^CMD" Dockerfile | head -1)
      
      echo -e "${GREEN}Using existing Dockerfile:${RESET}"
      echo -e "  Base image: ${YELLOW}${dockerfile_image}${RESET}"
      if [ -n "$dockerfile_entrypoint" ]; then
        echo -e "  Entrypoint: ${YELLOW}${dockerfile_entrypoint}${RESET}"
      fi
    fi
  else
    echo -e "${YELLOW}No Dockerfile found${RESET}"
    has_dockerfile=false
    
    echo "Would you like to create a Dockerfile? (y/n)"
    read -r create_df
    
    if [[ $create_df == "y" || $create_df == "Y" ]]; then
      create_dockerfile
    fi
  fi
}

# Create Dockerfile
create_dockerfile() {
  echo -e "${CYAN}Creating Dockerfile...${RESET}"
  
  if [ "$runtime" == "nodejs" ]; then
    # For Node.js projects
    echo "Select a base image:"
    select base in "node:18-alpine" "node:18" "node:20-alpine" "node:20" "Custom"; do
      if [ "$base" == "Custom" ]; then
        echo "Enter custom base image:"
        read -r base_image
      else
        base_image=$base
      fi
      break
    done
    
    # Find entry point
    if [ -f "index.js" ]; then
      entry_file="index.js"
    elif [ -f "app.js" ]; then
      entry_file="app.js"
    elif [ -f "server.js" ]; then
      entry_file="server.js"
    else
      # Search for a suitable entry file
      entry_file=$(find . -maxdepth 1 -name "*.js" | head -1)
      if [ -z "$entry_file" ]; then
        entry_file="index.js"
      else
        entry_file=$(basename "$entry_file")
      fi
    fi
    
    cat > Dockerfile << EOL
FROM $base_image

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

CMD ["node", "$entry_file"]
EOL
  elif [ "$runtime" == "python" ]; then
    # For Python projects
    echo "Select a base image:"
    select base in "python:3.9-slim" "python:3.11-slim" "python:3.12-slim" "python:3.9" "python:3.11" "python:3.12" "Custom"; do
      if [ "$base" == "Custom" ]; then
        echo "Enter custom base image:"
        read -r base_image
      else
        base_image=$base
      fi
      break
    done
    
    # Find entry point
    if [ -f "app.py" ]; then
      entry_file="app.py"
    elif [ -f "main.py" ]; then
      entry_file="main.py"
    elif [ -f "run.py" ]; then
      entry_file="run.py"
    else
      # Search for a suitable entry file
      entry_file=$(find . -maxdepth 2 -name "*.py" -not -path "*/\.*" | head -1)
      if [ -z "$entry_file" ]; then
        entry_file="app.py"
      else
        entry_file=$(basename "$entry_file")
      fi
    fi
    
    # Determine requirements location
    if [ -f "requirements.txt" ]; then
      req_file="requirements.txt"
    elif [ -f "Pipfile" ]; then
      req_file="Pipfile"
      # Include pipenv install in the Dockerfile
      pip_install="RUN pip install pipenv && pipenv install --system --deploy"
    else
      req_file=""
      pip_install="# No requirements file found"
    fi
    
    if [ -n "$req_file" ]; then
      if [ "$req_file" == "requirements.txt" ]; then
        pip_install="RUN pip install --no-cache-dir -r requirements.txt"
      fi
      
      cat > Dockerfile << EOL
FROM $base_image

WORKDIR /app

COPY $req_file .
$pip_install

COPY . .

CMD ["python", "$entry_file"]
EOL
    else
      cat > Dockerfile << EOL
FROM $base_image

WORKDIR /app

COPY . .

CMD ["python", "$entry_file"]
EOL
    fi
  fi
  
  echo -e "${GREEN}Dockerfile created successfully${RESET}"
  has_dockerfile=true
}

# Function to scan a JavaScript file for methods
scan_js_for_methods() {
  local file=$1
  local methods=()
  local events=()
  
  echo -e "${CYAN}Scanning $file for API methods and events...${RESET}"
  
  # Look for method definitions
  # Pattern: function methodName(...) or methodName: function(...) or methodName(...) {
  local found_methods=$(grep -o -E "(async\s+)?function\s+[a-zA-Z0-9_]+\s*\([^)]*\)|[a-zA-Z0-9_]+\s*:\s*(async\s+)?function\s*\([^)]*\)|[a-zA-Z0-9_]+\s*\([^)]*\)\s*{" "$file" | sed -E 's/(async\s+)?function\s+//g' | sed -E 's/\s*:\s*(async\s+)?function//g' | sed -E 's/\s*{//g')
  
  # Also look for class methods
  local class_methods=$(grep -o -E "(async\s+)?[a-zA-Z0-9_]+\s*\([^)]*\)\s*{" "$file" | sed -E 's/(async\s+)?//g' | sed -E 's/\s*{//g')
  
  # Combine and uniquify the methods
  found_methods=$(echo -e "$found_methods\n$class_methods" | sort | uniq)
  
  if [ -n "$found_methods" ]; then
    # Parse JSDoc comments for each method
    while IFS= read -r method; do
      method_name=$(echo "$method" | cut -d'(' -f1 | xargs)
      
      # Skip if method name is a reserved word or common internal methods
      if [[ "$method_name" =~ ^(if|for|while|switch|constructor|catch|function)$ ]]; then
        continue
      fi
      
      # Get parameters
      params=$(echo "$method" | sed -E 's/.*\((.*)\).*/\1/' | tr ',' '\n' | sed 's/^ *//' | sed 's/ *$//' | grep -v '^$')
      
      # Look for JSDoc comment above the method
      line_num=$(grep -n -E "(function\s+$method_name|$method_name\s*:|$method_name\s*\()" "$file" | head -1 | cut -d':' -f1)
      if [ -n "$line_num" ]; then
        # Extract comments above the method (up to 10 lines)
        start_line=$((line_num - 10))
        if [ $start_line -lt 1 ]; then
          start_line=1
        fi
        
        jsdoc=$(sed -n "${start_line},${line_num}p" "$file" | grep -B 20 -E "(function\s+$method_name|$method_name\s*:|$method_name\s*\()" | grep -E "^\s*\*\s+")
        
        # Extract description and return type from JSDoc
        description=$(echo "$jsdoc" | grep -v "@" | sed -E 's/^\s*\*\s*//' | tr '\n' ' ' | xargs)
        return_type=$(echo "$jsdoc" | grep "@returns" | sed -E 's/.*@returns\s*\{([^}]*)\}.*/\1/' | xargs)
        
        if [ -z "$description" ]; then
          description="$method_name method"
        fi
        
        if [ -z "$return_type" ]; then
          return_type="any"
        fi
        
        # Convert parameters to JSON array format
        param_array=""
        if [ -n "$params" ]; then
          param_array=$(echo "$params" | tr '\n' ',' | sed 's/,$//')
        fi
        
        methods+=("{\"name\":\"$method_name\",\"description\":\"$description\",\"parameters\":[$param_array],\"returns\":\"$return_type\"}")
      fi
    done <<< "$found_methods"
  fi
  
  # Look for emitted events
  # Pattern: emit('eventName' or this.emit('eventName'
  local found_events=$(grep -o -E "(this\.)?emit\s*\(\s*['\"][a-zA-Z0-9_:]+['\"]" "$file" | sed -E "s/(this\.)?emit\s*\(\s*['\"]//g" | sed -E "s/['\"]//g" | sort | uniq)
  
  if [ -n "$found_events" ]; then
    while IFS= read -r event; do
      events+=("{\"name\":\"$event\",\"description\":\"$event event\"}")
    done <<< "$found_events"
  fi
  
  echo -e "${GREEN}Found $(echo "${methods[@]}" | wc -w) methods and $(echo "${events[@]}" | wc -w) events in $file${RESET}"
  
  # Return the results
  echo "METHODS:${methods[*]}"
  echo "EVENTS:${events[*]}"
}

# Function to scan a Python file for methods
scan_py_for_methods() {
  local file=$1
  local methods=()
  local events=()
  
  echo -e "${CYAN}Scanning $file for API methods and events...${RESET}"
  
  # Look for method and function definitions
  # Pattern: def method_name(...): or async def method_name(...):
  local found_methods=$(grep -o -E "(async\s+)?def\s+[a-zA-Z0-9_]+\s*\([^)]*\)" "$file" | sed -E 's/(async\s+)?def\s+//g')
  
  if [ -n "$found_methods" ]; then
    # Parse docstrings for each method
    while IFS= read -r method; do
      method_name=$(echo "$method" | cut -d'(' -f1 | xargs)
      
      # Skip if method name starts with underscore (private methods)
      if [[ "$method_name" == _* ]]; then
        continue
      fi
      
      # Get parameters
      params=$(echo "$method" | sed -E 's/.*\((.*)\).*/\1/' | tr ',' '\n' | sed 's/^ *//' | sed 's/ *$//' | grep -v '^$' | grep -v 'self')
      
      # Look for docstring below the method
      line_num=$(grep -n -E "def\s+$method_name" "$file" | head -1 | cut -d':' -f1)
      if [ -n "$line_num" ]; then
        # Extract docstring below the method (up to 20 lines)
        end_line=$((line_num + 20))
        
        docstring=$(sed -n "${line_num},${end_line}p" "$file" | grep -A 20 -E "def\s+$method_name" | grep -E '^\s*"""' -A 20 | grep -B 20 -E '^\s*"""$' | grep -v '^\s*"""$')
        
        # Extract description and return type from docstring
        description=$(echo "$docstring" | grep -v "Args:" | grep -v "Returns:" | sed -E 's/^\s*"""?//' | tr '\n' ' ' | xargs)
        return_type=$(echo "$docstring" | grep -A 5 "Returns:" | sed -E 's/.*Returns://' | tr '\n' ' ' | xargs)
        
        if [ -z "$description" ]; then
          description="$method_name method"
        fi
        
        if [ -z "$return_type" ]; then
          return_type="any"
        fi
        
        # Convert parameters to JSON array format
        param_array=""
        if [ -n "$params" ]; then
          param_array=$(echo "$params" | tr '\n' ',' | sed 's/,$//')
        fi
        
        methods+=("{\"name\":\"$method_name\",\"description\":\"$description\",\"parameters\":[$param_array],\"returns\":\"$return_type\"}")
      fi
    done <<< "$found_methods"
  fi
  
  # Look for emitted events
  # Pattern: emit('eventName' or self.emit('eventName'
  local found_events=$(grep -o -E "(self\.)?emit\s*\(\s*['\"][a-zA-Z0-9_:]+['\"]" "$file" | sed -E "s/(self\.)?emit\s*\(\s*['\"]//g" | sed -E "s/['\"]//g" | sort | uniq)
  
  if [ -n "$found_events" ]; then
    while IFS= read -r event; do
      events+=("{\"name\":\"$event\",\"description\":\"$event event\"}")
    done <<< "$found_events"
  fi
  
  echo -e "${GREEN}Found $(echo "${methods[@]}" | wc -w) methods and $(echo "${events[@]}" | wc -w) events in $file${RESET}"
  
  # Return the results
  echo "METHODS:${methods[*]}"
  echo "EVENTS:${events[*]}"
}

# Function to auto-detect API methods and events from source files
auto_detect_api() {
  local all_methods=()
  local all_events=()
  
  echo -e "${CYAN}Auto-detecting API methods and events...${RESET}"
  
  if [ "$runtime" == "nodejs" ]; then
    # Find entry point and other important JS files
    if [ -z "$entry_point" ]; then
      if [ -f "index.js" ]; then
        entry_point="index.js"
      elif [ -f "app.js" ]; then
        entry_point="app.js"
      elif [ -f "server.js" ]; then
        entry_point="server.js"
      else
        entry_point=$(find . -maxdepth 1 -name "*.js" | head -1)
        if [ -n "$entry_point" ]; then
          entry_point=$(basename "$entry_point")
        fi
      fi
    fi
    
    # Scan entry point first
    if [ -n "$entry_point" ] && [ -f "$entry_point" ]; then
      local scan_result=$(scan_js_for_methods "$entry_point")
      local methods_part=$(echo "$scan_result" | grep "^METHODS:" | sed 's/^METHODS://')
      local events_part=$(echo "$scan_result" | grep "^EVENTS:" | sed 's/^EVENTS://')
      
      if [ -n "$methods_part" ]; then
        all_methods+=($methods_part)
      fi
      
      if [ -n "$events_part" ]; then
        all_events+=($events_part)
      fi
    fi
    
    # Scan other JS files (limit to 5 to avoid too much processing)
    local other_js_files=$(find . -maxdepth 2 -name "*.js" -not -path "./node_modules/*" | grep -v "$entry_point" | head -5)
    for js_file in $other_js_files; do
      local scan_result=$(scan_js_for_methods "$js_file")
      local methods_part=$(echo "$scan_result" | grep "^METHODS:" | sed 's/^METHODS://')
      local events_part=$(echo "$scan_result" | grep "^EVENTS:" | sed 's/^EVENTS://')
      
      if [ -n "$methods_part" ]; then
        all_methods+=($methods_part)
      fi
      
      if [ -n "$events_part" ]; then
        all_events+=($events_part)
      fi
    done
  elif [ "$runtime" == "python" ]; then
    # Find entry point and other important Python files
    if [ -z "$entry_point" ]; then
      if [ -f "app.py" ]; then
        entry_point="app.py"
      elif [ -f "main.py" ]; then
        entry_point="main.py"
      elif [ -f "run.py" ]; then
        entry_point="run.py"
      else
        entry_point=$(find . -maxdepth 2 -name "*.py" -not -path "*/\.*" | head -1)
        if [ -n "$entry_point" ]; then
          entry_point=$(basename "$entry_point")
        fi
      fi
    fi
    
    # Scan entry point first
    if [ -n "$entry_point" ] && [ -f "$entry_point" ]; then
      local scan_result=$(scan_py_for_methods "$entry_point")
      local methods_part=$(echo "$scan_result" | grep "^METHODS:" | sed 's/^METHODS://')
      local events_part=$(echo "$scan_result" | grep "^EVENTS:" | sed 's/^EVENTS://')
      
      if [ -n "$methods_part" ]; then
        all_methods+=($methods_part)
      fi
      
      if [ -n "$events_part" ]; then
        all_events+=($events_part)
      fi
    fi
    
    # Scan other Python files (limit to 5 to avoid too much processing)
    local other_py_files=$(find . -maxdepth 2 -name "*.py" -not -path "*/\.*" -not -path "*/__pycache__/*" | grep -v "$entry_point" | head -5)
    for py_file in $other_py_files; do
      local scan_result=$(scan_py_for_methods "$py_file")
      local methods_part=$(echo "$scan_result" | grep "^METHODS:" | sed 's/^METHODS://')
      local events_part=$(echo "$scan_result" | grep "^EVENTS:" | sed 's/^EVENTS://')
      
      if [ -n "$methods_part" ]; then
        all_methods+=($methods_part)
      fi
      
      if [ -n "$events_part" ]; then
        all_events+=($events_part)
      fi
    done
  fi
  
  echo -e "${GREEN}Auto-detection complete. Found ${#all_methods[@]} methods and ${#all_events[@]} events.${RESET}"
  
  # Return the results
  methods="${all_methods[*]}"
  events="${all_events[*]}"
}

# Function to help users define API methods
generate_api_methods() {
  echo -e "${CYAN}API Methods Configuration${RESET}"
  echo -e "${CYAN}========================${RESET}"
  
  local methods=()
  
  # First, try to auto-detect methods
  auto_detect_api
  
  if [ -n "$methods" ]; then
    echo -e "${GREEN}Automatically detected methods:${RESET}"
    local i=1
    for method in $methods; do
      # Pretty print the method
      local name=$(echo "$method" | grep -o '"name":"[^"]*"' | cut -d'"' -f4)
      local desc=$(echo "$method" | grep -o '"description":"[^"]*"' | cut -d'"' -f4)
      echo -e "${YELLOW}$i. $name${RESET} - $desc"
      i=$((i+1))
    done
    
    echo -e "Would you like to use these detected methods? (y/n)"
    read -r use_detected
    
    if [[ $use_detected == "y" || $use_detected == "Y" ]]; then
      # Use the auto-detected methods
      auto_detected_methods=$methods
      return
    fi
  fi
  
  # Manual entry if auto-detection fails or is declined
  while true; do
    echo -e "${YELLOW}Add a new API method? (y/n)${RESET}"
    read -r add_method
    
    if [[ $add_method != "y" && $add_method != "Y" ]]; then
      break
    fi
    
    echo -e "${YELLOW}Enter method name:${RESET}"
    read -r method_name
    
    echo -e "${YELLOW}Enter method description:${RESET}"
    read -r method_description
    
    echo -e "${YELLOW}Enter parameters (comma-separated, leave empty for none):${RESET}"
    read -r method_params_raw
    IFS=',' read -ra method_params <<< "$method_params_raw"
    
    echo -e "${YELLOW}Enter return type:${RESET}"
    read -r method_return
    
    methods+=("{\"name\":\"$method_name\",\"description\":\"$method_description\",\"parameters\":[$(for param in "${method_params[@]}"; do echo "\"$param\""; done | tr '\n' ',' | sed 's/,$//' | sed 's/,/, /g')],\"returns\":\"$method_return\"}")
  }
  
  echo -e "${GREEN}API methods added: ${#methods[@]}${RESET}"
  auto_detected_methods="${methods[*]}"
}

# Function to help users define API events
generate_api_events() {
  echo -e "${CYAN}API Events Configuration${RESET}"
  echo -e "${CYAN}=======================${RESET}"
  
  local events=()
  
  # Check if we have auto-detected events
  if [ -n "$events" ]; then
    echo -e "${GREEN}Automatically detected events:${RESET}"
    local i=1
    for event in $events; do
      # Pretty print the event
      local name=$(echo "$event" | grep -o '"name":"[^"]*"' | cut -d'"' -f4)
      local desc=$(echo "$event" | grep -o '"description":"[^"]*"' | cut -d'"' -f4)
      echo -e "${YELLOW}$i. $name${RESET} - $desc"
      i=$((i+1))
    done
    
    echo -e "Would you like to use these detected events? (y/n)"
    read -r use_detected
    
    if [[ $use_detected == "y" || $use_detected == "Y" ]]; then
      # Use the auto-detected events
      auto_detected_events=$events
      return
    fi
  fi
  
  # Manual entry if auto-detection fails or is declined
  while true; do
    echo -e "${YELLOW}Add a new API event? (y/n)${RESET}"
    read -r add_event
    
    if [[ $add_event != "y" && $add_event != "Y" ]]; then
      break
    fi
    
    echo -e "${YELLOW}Enter event name:${RESET}"
    read -r event_name
    
    echo -e "${YELLOW}Enter event description:${RESET}"
    read -r event_description
    
    events+=("{\"name\":\"$event_name\",\"description\":\"$event_description\"}")
  }
  
  echo -e "${GREEN}API events added: ${#events[@]}${RESET}"
  auto_detected_events="${events[*]}"
}

# Get plugin information
get_plugin_info() {
  echo -e "${CYAN}Plugin Configuration${RESET}"
  echo -e "${CYAN}===================${RESET}"
  
  # Get plugin name
  echo -e "${YELLOW}Enter plugin name:${RESET}"
  read -r plugin_name
  
  # Get plugin description
  echo -e "${YELLOW}Enter plugin description:${RESET}"
  read -r plugin_description
  
  # Get plugin author
  echo -e "${YELLOW}Enter author name (company or individual):${RESET}"
  read -r plugin_author
  
  # Get license
  echo -e "${YELLOW}Select license type:${RESET}"
  select license in "MIT" "Apache 2.0" "GPL v3" "BSD" "Proprietary" "NASA Patent License"; do
    plugin_license=$license
    break
  done
  
  if [ "$plugin_license" == "Proprietary" ]; then
    echo -e "${YELLOW}Enter proprietary license name:${RESET}"
    read -r plugin_license
  fi
  
  # Get copyright notice
  echo -e "${YELLOW}Enter copyright notice (or press Enter for default):${RESET}"
  read -r copyright_notice
  
  if [ -z "$copyright_notice" ]; then
    copyright_notice="Copyright 2025 $plugin_author, all rights reserved."
  fi
  
  # Get entry point
  if [ "$runtime" == "nodejs" ]; then
    default_entry="index.js"
    if [ -f "app.js" ]; then
      default_entry="app.js"
    elif [ -f "server.js" ]; then
      default_entry="server.js"
    fi
  else
    default_entry="app.py"
    if [ -f "main.py" ]; then
      default_entry="main.py"
    elif [ -f "run.py" ]; then
      default_entry="run.py"
    fi
  fi
  
  echo -e "${YELLOW}Enter entry point (default: $default_entry):${RESET}"
  read -r entry_point
  
  if [ -z "$entry_point" ]; then
    entry_point=$default_entry
  fi
  
  # Get version or generate from git
  if [ -d ".git" ] && command -v git &> /dev/null; then
    git_version=$(git describe --tags --always 2>/dev/null || git rev-parse --short HEAD)
    echo -e "${YELLOW}Use Git version '$git_version'? (y/n)${RESET}"
    read -r use_git_version
    
    if [[ $use_git_version == "y" || $use_git_version == "Y" ]]; then
      plugin_version=$git_version
    else
      echo -e "${YELLOW}Enter plugin version:${RESET}"
      read -r plugin_version
    fi
  else
    echo -e "${YELLOW}Enter plugin version:${RESET}"
    read -r plugin_version
  fi
  
  if [ -z "$plugin_version" ]; then
    plugin_version="1.0.0"
  fi
  
  # Generate plugin ID
  plugin_id=$(echo "$plugin_name" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')-$plugin_version
}

# Configure billing
configure_billing() {
  echo -e "${CYAN}Billing Configuration${RESET}"
  echo -e "${CYAN}====================${RESET}"
  
  echo -e "${YELLOW}Select billing model:${RESET}"
  select billing_model in "Free" "One-time payment" "Subscription" "Token-based"; do
    case $billing_model in
      "Free")
        token_cost=0
        free_quota_enabled=true
        free_quota_limit="unlimited"
        break
        ;;
      "One-time payment")
        echo -e "${YELLOW}Enter one-time cost in USD:${RESET}"
        read -r cost_usd
        token_cost=$(echo "$cost_usd / 0.01" | bc)
        free_quota_enabled=false
        break
        ;;
      "Subscription")
        echo -e "${YELLOW}Select subscription period:${RESET}"
        select period in "minutes" "hours" "days" "months"; do
          subscription_period=$period
          break
        done
        
        echo -e "${YELLOW}Enter subscription cost in USD per $subscription_period:${RESET}"
        read -r cost_usd
        token_cost=$(echo "$cost_usd / 0.01" | bc)
        free_quota_enabled=false
        
        echo -e "${YELLOW}Enter free trial period (0 for none):${RESET}"
        read -r free_trial
        
        if [ "$free_trial" -gt 0 ]; then
          free_quota_enabled=true
          free_quota_limit="$free_trial $subscription_period"
        fi
        break
        ;;
      "Token-based")
        echo -e "${YELLOW}Enter cost per use in tokens:${RESET}"
        read -r token_cost
        
        echo -e "${YELLOW}Enter free usage quota (0 for none):${RESET}"
        read -r free_usage
        
        if [ "$free_usage" -gt 0 ]; then
          free_quota_enabled=true
          free_quota_limit=$free_usage
        else
          free_quota_enabled=false
        fi
        break
        ;;
    esac
  done
}

# Configure UI
configure_ui() {
  echo -e "${CYAN}UI Configuration${RESET}"
  echo -e "${CYAN}================${RESET}"
  
  # Select category
  echo -e "${YELLOW}Select plugin category:${RESET}"
  select category in "Artificial Intelligence (AI)" "Machine Learning (ML)" "Deep Learning" "Natural Language Processing (NLP)" "Computer Vision" "Networking" "Network Security" "Cloud Networking" "Software-Defined Networking (SDN)" "Data Management" "Database Management Systems (DBMS)" "Data Analytics" "Big Data Technologies" "Development Frameworks" "Web Development Frameworks" "Mobile Development Frameworks" "Low-Code/No-Code Platforms" "Automation" "Robotic Process Automation (RPA)" "Workflow Automation" "Cybersecurity" "Intrusion Detection Systems (IDS)" "Endpoint Security" "Cloud Computing" "Infrastructure as a Service (IaaS)" "Platform as a Service (PaaS)"; do
    plugin_category=$category
    break
  done
  
  # Simplified category for config
  simple_category=$(echo "$plugin_category" | cut -d ' ' -f 1)
  
  # Select icon - show top 50 FontAwesome icons
  echo -e "${YELLOW}Select icon (FontAwesome) or enter your own:${RESET}"
  echo -e "${YELLOW}View full icon list at: https://fontawesome.com/v5/search${RESET}"
  select icon in "user" "home" "cog" "wrench" "chart-bar" "database" "server" "cloud" "shield-alt" "key" "lock" "unlock" "user-shield" "file" "file-code" "file-alt" "folder" "folder-open" "search" "envelope" "bell" "calendar" "image" "video" "music" "map" "map-marker" "globe" "link" "eye" "eye-slash" "edit" "pen" "trash" "download" "upload" "sync" "history" "clock" "save" "print" "camera" "phone" "mobile" "tablet" "laptop" "desktop" "tv" "plug" "wifi" "custom"; do
    if [ "$icon" == "custom" ]; then
      echo -e "${YELLOW}Enter custom icon name (e.g., 'rocket'):${RESET}"
      read -r plugin_icon
    else
      plugin_icon=$icon
    fi
    break
  done
  
  if [ -z "$plugin_icon" ]; then
    plugin_icon="puzzle-piece"
  fi
  
  # Select color
  echo -e "${YELLOW}Select color:${RESET}"
  select color in "Red - #e6194b" "Green - #3cb44b" "Yellow - #ffe119" "Blue - #4363d8" "Orange - #f58231" "Purple - #911eb4" "Cyan - #46f0f0" "Magenta - #f032e6" "Lime - #bcf60c" "Pink - #fabebe" "Teal - #008080" "Lavender - #e6beff" "Brown - #9a6324" "Cream - #fffac8" "Maroon - #800000" "Mint - #aaffc3" "Olive - #808000" "Peach - #ffd8b1" "Navy - #000075" "Gray - #808080" "Custom"; do
    if [ "$color" == "Custom" ]; then
      echo -e "${YELLOW}Enter hex color code (e.g., #ff5500):${RESET}"
      read -r plugin_color
    else
      plugin_color=$(echo "$color" | sed 's/.*- //')
    fi
    break
  done
  
  # Check for logo
  if [ -d "images" ] && (ls images/*.png &>/dev/null || ls images/*.jpg &>/dev/null || ls images/*.svg &>/dev/null); then
    echo -e "${GREEN}Found images directory${RESET}"
    
    # List images
    logo_files=($(find images -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.svg" \)))
    
    if [ ${#logo_files[@]} -gt 0 ]; then
      echo -e "${YELLOW}Select logo file:${RESET}"
      select logo in "${logo_files[@]}" "None" "Create new"; do
        if [ "$logo" == "None" ]; then
          plugin_logo=""
          break
        elif [ "$logo" == "Create new" ]; then
          create_logo_dir
          break
        else
          plugin_logo=$logo
          break
        fi
      done
    else
      create_logo_dir
    fi
  else
    create_logo_dir
  fi
}

# Create logo directory
create_logo_dir() {
  echo -e "${YELLOW}No suitable logo found. Create images directory? (y/n)${RESET}"
  read -r create_dir
  
  if [[ $create_dir == "y" || $create_dir == "Y" ]]; then
    mkdir -p images
    echo -e "${GREEN}Created images directory${RESET}"
    echo -e "${YELLOW}Please place a logo.png file (max 100x100px) in the images directory later${RESET}"
    plugin_logo="images/logo.png"
  else
    plugin_logo=""
  fi
}

# Generate config.json
generate_config() {
  echo -e "${CYAN}Generating config.json...${RESET}"
  
  # Scan for API methods and events if not already done
  if [ -z "$auto_detected_methods" ] || [ -z "$auto_detected_events" ]; then
    generate_api_methods
    generate_api_events
  fi
  
  # Format API methods
  methods_json="[]"
  if [ -n "$auto_detected_methods" ]; then
    methods_json="[$auto_detected_methods]"
  fi
  
  # Format API events
  events_json="[]"
  if [ -n "$auto_detected_events" ]; then
    events_json="[$auto_detected_events]"
  fi
  
  # Create config structure
  cat > config.json << EOL
{
  "id": "$plugin_id",
  "version": "$plugin_version",
  "name": "$plugin_name",
  "description": "$plugin_description",
  "author": "$plugin_author",
  "license": "$plugin_license",
  "copyright": "$copyright_notice",
  "type": "$(echo "$simple_category" | tr '[:upper:]' '[:lower:]')",
  "entryPoint": "$entry_point",
  "billing": {
    "tokenCost": $token_cost,
    "freeQuota": {
      "enabled": $free_quota_enabled,
      "limit": "$([ -z "$free_quota_limit" ] && echo "0" || echo "$free_quota_limit")"
    }
  },
  "permissions": [
    "files:read"
  ],
  "dependencies": [],
  "configuration": {
    "logLevel": {
      "type": "string",
      "default": "info",
      "description": "Log level (debug, info, warn, error)"
    }
  },
  "api": {
    "methods": $methods_json,
    "events": $events_json
  },
  "ui": {
    "icon": "$plugin_icon",
    "color": "$plugin_color",
    "category": "$plugin_category"
  }
}
EOL
  
  echo -e "${GREEN}config.json generated successfully${RESET}"
}

# Package plugin
package_plugin() {
  echo -e "${CYAN}Packaging plugin...${RESET}"
  
  # Create a clean directory for packaging
  mkdir -p .safeguard-package
  
  # Copy files
  if [ "$runtime" == "nodejs" ]; then
    # For Node.js projects
    cp -r package.json .safeguard-package/
    cp -r package-lock.json .safeguard-package/ 2>/dev/null || :
    cp -r yarn.lock .safeguard-package/ 2>/dev/null || :
    cp -r node_modules .safeguard-package/ 2>/dev/null || :
    cp -r src .safeguard-package/ 2>/dev/null || :
    cp -r lib .safeguard-package/ 2>/dev/null || :
    cp -r dist .safeguard-package/ 2>/dev/null || :
    cp -r images .safeguard-package/ 2>/dev/null || :
    cp -r *.js .safeguard-package/ 2>/dev/null || :
  elif [ "$runtime" == "python" ]; then
    # For Python projects
    cp -r requirements.txt .safeguard-package/ 2>/dev/null || :
    cp -r setup.py .safeguard-package/ 2>/dev/null || :
    cp -r Pipfile .safeguard-package/ 2>/dev/null || :
    cp -r Pipfile.lock .safeguard-package/ 2>/dev/null || :
    cp -r *.py .safeguard-package/ 2>/dev/null || :
    cp -r src .safeguard-package/ 2>/dev/null || :
    cp -r lib .safeguard-package/ 2>/dev/null || :
    cp -r images .safeguard-package/ 2>/dev/null || :
  fi
  
  # Copy common files
  cp -r config.json .safeguard-package/
  cp -r Dockerfile .safeguard-package/ 2>/dev/null || :
  cp -r docker-compose.yml .safeguard-package/ 2>/dev/null || :
  cp -r README.md .safeguard-package/ 2>/dev/null || :
  cp -r LICENSE .safeguard-package/ 2>/dev/null || :
  
  # Create package
  package_name="${plugin_id}.zip"
  
  if command -v zip &> /dev/null; then
    (cd .safeguard-package && zip -r "../$package_name" .)
    echo -e "${GREEN}Plugin packaged successfully: $package_name${RESET}"
  else
    echo -e "${YELLOW}Warning: zip is not installed. Could not create package.${RESET}"
    echo -e "${YELLOW}Please manually compress the .safeguard-package directory.${RESET}"
  fi
  
  # Clean up
  rm -rf .safeguard-package
}

# Setup Git repository
setup_git_repo() {
  echo -e "${YELLOW}Would you like to set up a Git repository? (y/n)${RESET}"
  read -r setup_git
  
  if [[ $setup_git == "y" || $setup_git == "Y" ]]; then
    if [ -d ".git" ]; then
      echo -e "${GREEN}Git repository already exists${RESET}"
    else
      echo -e "${CYAN}Initializing Git repository...${RESET}"
      git init
      
      # Create .gitignore
      cat > .gitignore << EOL
node_modules/
__pycache__/
*.pyc
*.pyo
*.pyd
.Python
env/
venv/
ENV/
dist/
build/
*.egg-info/
.coverage
htmlcov/
.tox/
.nox/
.hypothesis/
.pytest_cache/
EOL
      
      # Initial commit
      git add .
      git commit -m "Initial commit for Safeguard plugin: $plugin_name"
      
      echo -e "${GREEN}Git repository initialized${RESET}"
    fi
    
    echo -e "${YELLOW}Enter Git repository URL (leave empty if none):${RESET}"
    read -r repo_url
    
    if [ -n "$repo_url" ]; then
      echo -e "${CYAN}Adding remote repository...${RESET}"
      git remote add origin "$repo_url"
      
      echo -e "${YELLOW}Push to remote repository? (y/n)${RESET}"
      read -r push_repo
      
      if [[ $push_repo == "y" || $push_repo == "Y" ]]; then
        git push -u origin master 2>/dev/null || git push -u origin main
      fi
    fi
  fi
}

# Show summary
show_summary() {
  echo -e "${CYAN}Plugin Configuration Summary${RESET}"
  echo -e "${CYAN}==========================${RESET}"
  echo -e "Name: ${GREEN}$plugin_name${RESET}"
  echo -e "ID: ${GREEN}$plugin_id${RESET}"
  echo -e "Version: ${GREEN}$plugin_version${RESET}"
  echo -e "Description: ${GREEN}$plugin_description${RESET}"
  echo -e "Author: ${GREEN}$plugin_author${RESET}"
  echo -e "License: ${GREEN}$plugin_license${RESET}"
  echo -e "Entry Point: ${GREEN}$entry_point${RESET}"
  echo -e "Runtime: ${GREEN}$runtime${RESET}"
  echo -e "Dockerfile: ${GREEN}$([ "$has_dockerfile" = true ] && echo "Yes" || echo "No")${RESET}"
  echo -e "UI: ${GREEN}$plugin_category / $plugin_icon / $plugin_color${RESET}"
  
  echo -e "${YELLOW}Proceed with this configuration? (y/n)${RESET}"
  read -r confirm
  
  if [[ $confirm != "y" && $confirm != "Y" ]]; then
    echo -e "${RED}Restarting wizard...${RESET}"
    main
    return
  fi
}

# Main function
main() {
  if [ "$1" == "help" ]; then
    show_help
    exit 0
  fi
  
  detect_runtime
  parse_dependencies
  check_dockerfile
  get_plugin_info
  configure_billing
  configure_ui
  generate_config
  show_summary
  package_plugin
  setup_git_repo
  
  echo -e "${GREEN}Plugin setup complete!${RESET}"
  echo -e "Your plugin has been configured with Safeguard-compatible settings."
  echo -e "Package: ${CYAN}$package_name${RESET}"
  echo -e ""
  echo -e "${YELLOW}Next steps:${RESET}"
  echo -e "1. Review the generated config.json file"
  echo -e "2. Implement the API methods defined in your plugin"
  echo -e "3. Add your plugin to the Safeguard system"
  echo -e ""
  echo -e "${BLUE}Thank you for using the Safeguard Plugin Onboarding Wizard!${RESET}"
}

# Run the main function
main "$@"
```


## 4. PowerShell Script with Enhanced Features (plugin-onboarding.ps1)

```textmate
# Safeguard Plugin Onboarding Script for Windows
# Copyright 2025 Autonomy Association International Inc., all rights reserved.
# Version 1.0.0

# Display header
Write-Host "┌───────────────────────────────────────────────┐" -ForegroundColor Blue
Write-Host "│       SAFEGUARD PLUGIN ONBOARDING WIZARD      │" -ForegroundColor Blue
Write-Host "├───────────────────────────────────────────────┤" -ForegroundColor Blue
Write-Host "│ Copyright 2025 Autonomy Association Int'l Inc.│" -ForegroundColor Blue
Write-Host "└───────────────────────────────────────────────┘" -ForegroundColor Blue
Write-Host ""

# Check for required modules
function Check-Dependencies {
    $missingDeps = $false
    
    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
        Write-Host "Warning: git is not installed. Some features may not work." -ForegroundColor Yellow
        $missingDeps = $true
    }
    
    if (-not (Get-Command npm -ErrorAction SilentlyContinue) -and -not (Get-Command node -ErrorAction SilentlyContinue)) {
        Write-Host "Warning: Node.js is not installed. This may be needed for Node.js projects." -ForegroundColor Yellow
    }
    
    if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
        Write-Host "Warning: Python is not installed. This may be needed for Python projects." -ForegroundColor Yellow
    }
    
    if ($missingDeps) {
        Write-Host "Consider installing the missing dependencies for full functionality." -ForegroundColor Yellow
        Write-Host ""
    }
}

Check-Dependencies

# Help function
function Show-Help {
    Write-Host "SAFEGUARD PLUGIN ONBOARDING HELP" -ForegroundColor Cyan
    Write-Host "=================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "This wizard guides you through the process of creating a Safeguard plugin from your existing Node.js or Python project."
    Write-Host ""
    Write-Host "The wizard will:" -ForegroundColor Green
    Write-Host "1. Detect your project type (Node.js or Python)"
    Write-Host "2. Parse your dependencies"
    Write-Host "3. Set up Docker containerization"
    Write-Host "4. Create a plugin configuration file"
    Write-Host "5. Package your plugin for distribution"
    Write-Host "6. Help you set up a Git repository"
    Write-Host ""
    Write-Host "Navigation:" -ForegroundColor Yellow
    Write-Host "- Use arrow keys to navigate menus when available"
    Write-Host "- Type your choices when prompted"
    Write-Host "- Type 'exit' at any prompt to quit"
    Write-Host "- Type 'help' at any prompt to show this help"
    Write-Host ""
    Write-Host "Copyright 2025 Autonomy Association International Inc., all rights reserved." -ForegroundColor Blue
    Write-Host "Safeguard patent license from National Aeronautics and Space Administration (NASA)."
    Write-Host ""
}

# Detect runtime
function Detect-Runtime {
    Write-Host "Detecting project runtime..." -ForegroundColor Cyan
    
    $runtime = $null
    $config_file = $null
    
    # Check for package.json (Node.js)
    if (Test-Path "package.json") {
        Write-Host "Found Node.js project (package.json)" -ForegroundColor Green
        $runtime = "nodejs"
        $config_file = "package.json"
    }
    # Check for Python files and environments
    elseif (Test-Path "requirements.txt") {
        Write-Host "Found Python project (requirements.txt)" -ForegroundColor Green
        $runtime = "python"
        $config_file = "requirements.txt"
    }
    # Check for setup.py
    elseif (Test-Path "setup.py") {
        Write-Host "Found Python project (setup.py)" -ForegroundColor Green
        $runtime = "python"
        $config_file = "setup.py"
    }
    # Check for Pipfile
    elseif (Test-Path "Pipfile") {
        Write-Host "Found Python project (Pipfile)" -ForegroundColor Green
        $runtime = "python"
        $config_file = "Pipfile"
    }
    # Check for Python virtual environments
    elseif (Test-Path "venv" -PathType Container -or 
            Test-Path ".venv" -PathType Container -or 
            Test-Path "env" -PathType Container -or 
            Test-Path ".env" -PathType Container -or 
            Test-Path "virtualenv" -PathType Container) {
        
        Write-Host "Found Python virtual environment" -ForegroundColor Green
        $runtime = "python"
        
        # Look for Python files in the directory
        $pythonFiles = Get-ChildItem -Path "." -Filter "*.py" -File | Select-Object -ExpandProperty FullName
        
        if (-not $pythonFiles) {
            Write-Host "No Python files found in the root directory." -ForegroundColor Yellow
            $pythonFiles = Get-ChildItem -Path "." -Filter "*.py" -File -Recurse | Select-Object -ExpandProperty FullName
        }
        
        if ($pythonFiles) {
            # Use first Python file as a fallback
            $config_file = $pythonFiles[0]
            Write-Host "Using Python file: $config_file" -ForegroundColor Yellow
        } else {
            Write-Host "No Python files found." -ForegroundColor Red
            $config_file = $null
        }
    }
    else {
        Write-Host "Could not automatically detect project type." -ForegroundColor Yellow
        Write-Host "Please select your project type:" -ForegroundColor Yellow
        
        $options = @("Node.js", "Python", "Exit")
        $selection = Show-Menu -Options $options -Title "Select Project Type"
        
        switch ($selection) {
            "Node.js" {
                $runtime = "nodejs"
                Write-Host "Please select the configuration file:" -ForegroundColor Yellow
                $config_file = Select-File -Filter "package.json"
            }
            "Python" {
                $runtime = "python"
                Write-Host "Please select the configuration file:" -ForegroundColor Yellow
                $config_file = Select-File -Filter "requirements.txt"
            }
            "Exit" {
                Write-Host "Exiting..." -ForegroundColor Red
                exit 0
            }
        }
    }
    
    Write-Host "Is $config_file the correct configuration file? (y/n)" -ForegroundColor Cyan
    $confirm = Read-Host
    
    if ($confirm -ne "y" -and $confirm -ne "Y") {
        $config_file = Select-File
    }
    
    return @{
        Runtime = $runtime
        ConfigFile = $config_file
    }
}

# Function to display a menu
function Show-Menu {
    param (
        [string[]]$Options,
        [string]$Title = "Select an option"
    )
    
    Write-Host $Title -ForegroundColor Yellow
    
    for ($i = 0; $i -lt $Options.Length; $i++) {
        Write-Host "[$($i+1)] $($Options[$i])"
    }
    
    $selection = Read-Host "Enter selection"
    
    if ($selection -eq "exit") {
        Write-Host "Exiting..." -ForegroundColor Red
        exit 0
    }
    elseif ($selection -eq "help") {
        Show-Help
        return Show-Menu -Options $Options -Title $Title
    }
    
    try {
        $index = [int]$selection - 1
        if ($index -ge 0 -and $index -lt $Options.Length) {
            return $Options[$index]
        }
        else {
            Write-Host "Invalid selection. Please try again." -ForegroundColor Red
            return Show-Menu -Options $Options -Title $Title
        }
    }
    catch {
        Write-Host "Invalid input. Please enter a number." -ForegroundColor Red
        return Show-Menu -Options $Options -Title $Title
    }
}

# Function to select a file
function Select-File {
    param (
        [string]$Filter = "*.*"
    )
    
    $files = Get-ChildItem -Recurse -File | Where-Object { $_.Name -like $Filter } | Select-Object -ExpandProperty FullName
    
    if ($files.Count -eq 0) {
        $files = Get-ChildItem -Recurse -File | Select-Object -ExpandProperty FullName
    }
    
    $files += "Exit"
    
    Write-Host "Select configuration file:" -ForegroundColor Yellow
    $file = Show-Menu -Options $files -Title "Select File"
    
    if ($file -eq "Exit") {
        Write-Host "Exiting..." -ForegroundColor Red
        exit 0
    }
    
    Write-Host "Selected: $file" -ForegroundColor Cyan
    return $file
}

# Parse dependencies
function Parse-Dependencies {
    param (
        [string]$Runtime,
        [string]$ConfigFile
    )
    
    Write-Host "Parsing dependencies from $ConfigFile..." -ForegroundColor Cyan
    
    $dependencies = @()
    
    if ($Runtime -eq "nodejs") {
        # For Node.js projects
        try {
            $packageJson = Get-Content $ConfigFile -Raw | ConvertFrom-Json
            $dependencies = $packageJson.dependencies.PSObject.Properties.Name
        }
        catch {
            Write-Host "Warning: Could not parse dependencies from package.json." -ForegroundColor Yellow
            $dependencies = @()
        }
    }
    elseif ($Runtime -eq "python") {
        # For Python projects
        try {
            if (Test-Path "requirements.txt") {
                $dependencies = Get-Content "requirements.txt" | Where-Object { $_ -match '\S' -and $_ -notmatch '^\s*#' }
            }
            elseif (Test-Path "setup.py") {
                # Try to extract install_requires from setup.py
                $setupPyContent = Get-Content "setup.py" -Raw
                if ($setupPyContent -match "install_requires\s*=\s*\[(.*?)\]") {
                    $dependencies = $matches[1] -split ',' | ForEach-Object { 
                        if ($_ -match "'([^']+)'") {
                            $matches[1]
                        }
                    }
                }
            }
            elseif (Test-Path "Pipfile") {
                # Extract packages from Pipfile
                $inPackagesSection = $false
                $dependencies = @()
                
                foreach ($line in (Get-Content "Pipfile")) {
                    if ($line -match "\[packages\]") {
                        $inPackagesSection = $true
                        continue
                    }
                    
                    if ($inPackagesSection -and $line -match "\[") {
                        $inPackagesSection = $false
                        continue
                    }
                    
                    if ($inPackagesSection -and $line -match "^\s*([a-zA-Z0-9_\-]+)\s*=") {
                        $dependencies += $matches[1]
                    }
                }
            }
        }
        catch {
            Write-Host "Warning: Could not parse dependencies from Python files." -ForegroundColor Yellow
            $dependencies = @()
        }
    }
    
    Write-Host "Detected dependencies:" -ForegroundColor Green
    if ($dependencies.Count -eq 0) {
        Write-Host "None found"
    }
    else {
        $dependencies | ForEach-Object { Write-Host $_ }
    }
    Write-Host ""
    
    return $dependencies
}

# Check for Dockerfile
function Check-Dockerfile {
    param (
        [string]$Runtime
    )
    
    if (Test-Path "Dockerfile") {
        Write-Host "Found existing Dockerfile" -ForegroundColor Green
        $has_dockerfile = $true
        
        Write-Host "Would you like to use this Dockerfile? (y/n)" -ForegroundColor Yellow
        $use_existing = Read-Host
        
        if ($use_existing -ne "y" -and $use_existing -ne "Y") {
            $has_dockerfile = Create-Dockerfile -Runtime $Runtime
        }
        else {
            # Parse Dockerfile to determine image and entrypoint
            $dockerfileContent = Get-Content "Dockerfile" -Raw
            $dockerfileImage = if ($dockerfileContent -match "FROM\s+(.+?)(\s|$)") { $matches[1] } else { "unknown" }
            $dockerfileEntrypoint = if ($dockerfileContent -match "ENTRYPOINT|CMD") { $matches[0] } else { "unknown" }
            
            Write-Host "Using existing Dockerfile:" -ForegroundColor Green
            Write-Host "  Base image: $dockerfileImage" -ForegroundColor Yellow
            if ($dockerfileEntrypoint -ne "unknown") {
                Write-Host "  Entrypoint: $dockerfileEntrypoint" -ForegroundColor Yellow
            }
        }
    }
    else {
        Write-Host "No Dockerfile found" -ForegroundColor Yellow
        $has_dockerfile = $false
        
        Write-Host "Would you like to create a Dockerfile? (y/n)" -ForegroundColor Yellow
        $create_df = Read-Host
        
        if ($create_df -eq "y" -or $create_df -eq "Y") {
            $has_dockerfile = Create-Dockerfile -Runtime $Runtime
        }
    }
    
    return $has_dockerfile
}

# Create Dockerfile
function Create-Dockerfile {
    param (
        [string]$Runtime
    )
    
    Write-Host "Creating Dockerfile..." -ForegroundColor Cyan
    
    if ($Runtime -eq "nodejs") {
        # For Node.js projects
        $options = @("node:18-alpine", "node:18", "node:20-alpine", "node:20", "Custom")
        $base = Show-Menu -Options $options -Title "Select a base image"
        
        if ($base -eq "Custom") {
            Write-Host "Enter custom base image:" -ForegroundColor Yellow
            $base_image = Read-Host
        }
        else {
            $base_image = $base
        }
        
        # Find entry point
        $entryPoint = if (Test-Path "index.js") { 
            "index.js" 
        } elseif (Test-Path "app.js") { 
            "app.js" 
        } elseif (Test-Path "server.js") { 
            "server.js" 
        } else {
            # Search for a suitable entry file
            $entryFile = Get-ChildItem -Path "." -Filter "*.js" -File | Select-Object -First 1 -ExpandProperty Name
            if ($entryFile) { $entryFile } else { "index.js" }
        }
        
        $dockerfileContent = @"
FROM $base_image

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

CMD ["node", "$entryPoint"]
"@
    }
    elseif ($Runtime -eq "python") {
        # For Python projects
        $options = @("python:3.9-slim", "python:3.11-slim", "python:3.12-slim", "python:3.9", "python:3.11", "python:3.12", "Custom")
        $base = Show-Menu -Options $options -Title "Select a base image"
        
        if ($base -eq "Custom") {
            Write-Host "Enter custom base image:" -ForegroundColor Yellow
            $base_image = Read-Host
        }
        else {
            $base_image = $base
        }
        
        # Find entry point
        $entryPoint = if (Test-Path "app.py") { 
            "app.py" 
        } elseif (Test-Path "main.py") { 
            "main.py" 
        } elseif (Test-Path "run.py") { 
            "run.py" 
        } else {
            # Search for a suitable entry file
            $entryFile = Get-ChildItem -Path "." -Filter "*.py" -File -Exclude "setup.py" | Select-Object -First 1 -ExpandProperty Name
            if ($entryFile) { $entryFile } else { "app.py" }
        }
        
        # Determine requirements location
        $reqFile = ""
        $pipInstall = ""
        
        if (Test-Path "requirements.txt") {
            $reqFile = "requirements.txt"
            $pipInstall = "RUN pip install --no-cache-dir -r requirements.txt"
        }
        elseif (Test-Path "Pipfile") {
            $reqFile = "Pipfile"
            $pipInstall = "RUN pip install pipenv && pipenv install --system --deploy"
        }
        
        if ($reqFile) {
            $dockerfileContent = @"
FROM $base_image

WORKDIR /app

COPY $reqFile .
$pipInstall

COPY . .

CMD ["python", "$entryPoint"]
"@
        }
        else {
            $dockerfileContent = @"
FROM $base_image

WORKDIR /app

COPY . .

CMD ["python", "$entryPoint"]
"@
        }
    }
    
    Set-Content -Path "Dockerfile" -Value $dockerfileContent
    
    Write-Host "Dockerfile created successfully" -ForegroundColor Green
    return $true
}

# Function to scan a JavaScript file for methods
function Scan-JsForMethods {
    param (
        [string]$FilePath
    )
    
    Write-Host "Scanning $FilePath for API methods and events..." -ForegroundColor Cyan
    
    $methods = @()
    $events = @()
    
    # Get file content
    $fileContent = Get-Content -Path $FilePath -Raw
    
    # Look for method definitions using regex
    # Pattern: function methodName(...) or methodName: function(...) or methodName(...) {
    $methodMatches = [regex]::Matches($fileContent, '(async\s+)?function\s+([a-zA-Z0-9_]+)\s*\(([^)]*)\)|([a-zA-Z0-9_]+)\s*:\s*(async\s+)?function\s*\(([^)]*)\)|([a-zA-Z0-9_]+)\s*\(([^)]*)\)\s*{')
    
    # Also look for class methods
    $classMethodMatches = [regex]::Matches($fileContent, '(async\s+)?([a-zA-Z0-9_]+)\s*\(([^)]*)\)\s*{')
    
    # Process method matches
    foreach ($match in ($methodMatches + $classMethodMatches)) {
        $methodName = if ($match.Groups[2].Success) { 
            $match.Groups[2].Value 
        } elseif ($match.Groups[4].Success) { 
            $match.Groups[4].Value 
        } elseif ($match.Groups[7].Success) { 
            $match.Groups[7].Value 
        } else {
            $match.Groups[2].Value
        }
        
        # Skip if method name is a reserved word or common internal methods
        if ($methodName -match '^(if|for|while|switch|constructor|catch|function)$') {
            continue
        }
        
        # Get parameters from match groups
        $params = if ($match.Groups[3].Success) { 
            $match.Groups[3].Value 
        } elseif ($match.Groups[6].Success) { 
            $match.Groups[6].Value 
        } elseif ($match.Groups[8].Success) { 
            $match.Groups[8].Value 
        } else { 
            "" 
        }
        
        $paramList = $params -split ',' | ForEach-Object { $_.Trim() } | Where-Object { $_ }
        
        # Look for JSDoc comment above the method
        $methodPosition = $match.Index
        $precedingContent = $fileContent.Substring(0, $methodPosition)
        $lastCommentEndPos = $precedingContent.LastIndexOf('*/')
        
        $description = "$methodName method"
        $returnType = "any"
        
        if ($lastCommentEndPos -gt 0) {
            $lastCommentStartPos = $precedingContent.LastIndexOf('/**', $lastCommentEndPos)
            
            if ($lastCommentStartPos -gt 0) {
                $comment = $precedingContent.Substring($lastCommentStartPos, $lastCommentEndPos - $lastCommentStartPos + 2)
                
                # Extract description (first line after /** that doesn't start with @)
                if ($comment -match '/\*\*\s*\r?\n\s*\*\s*([^\r\n@]+)') {
                    $description = $matches[1].Trim()
                }
                
                # Extract return type
                if ($comment -match '@returns?\s*\{([^}]+)\}') {
                    $returnType = $matches[1].Trim()
                }
            }
        }
        
        $methods += @{
            name = $methodName
            description = $description
            parameters = $paramList
            returns = $returnType
        }
    }
    
    # Look for emitted events
    # Pattern: emit('eventName' or this.emit('eventName'
    $eventMatches = [regex]::Matches($fileContent, '(this\.)?emit\s*\(\s*[''"]([a-zA-Z0-9_:]+)[''"]')
    
    foreach ($match in $eventMatches) {
        $eventName = $match.Groups[2].Value
        
        $events += @{
            name = $eventName
            description = "$eventName event"
        }
    }
    
    Write-Host "Found $($methods.Count) methods and $($events.Count) events in $FilePath" -ForegroundColor Green
    
    return @{
        Methods = $methods
        Events = $events
    }
}

# Function to scan a Python file for methods
function Scan-PyForMethods {
    param (
        [string]$FilePath
    )
    
    Write-Host "Scanning $FilePath for API methods and events..." -ForegroundColor Cyan
    
    $methods = @()
    $events = @()
    
    # Get file content
    $fileContent = Get-Content -Path $FilePath -Raw
    
    # Look for method and function definitions
    # Pattern: def method_name(...): or async def method_name(...):
    $methodMatches = [regex]::Matches($fileContent, '(async\s+)?def\s+([a-zA-Z0-9_]+)\s*\(([^)]*)\)')
    
    # Process method matches
    foreach ($match in $methodMatches) {
        $methodName = $match.Groups[2].Value
        
        # Skip if method name starts with underscore (private methods)
        if ($methodName -match '^_') {
            continue
        }
        
        # Get parameters
        $params = $match.Groups[3].Value
        $paramList = $params -split ',' | ForEach-Object { $_.Trim() } | Where-Object { $_ -and $_ -ne 'self' }
        
        # Look for docstring below the method
        $methodPosition = $match.Index + $match.Length
        $followingContent = $fileContent.Substring($methodPosition)
        
        $description = "$methodName method"
        $returnType = "any"
        
        if ($followingContent -match '^\s*:?\s*"""(.+?)"""' -or $followingContent -match "^\s*:?\s*'''(.+?)'''") {
            $docstring = $matches[1]
            
            # Extract description (first line that doesn't mention Args or Returns)
            if ($docstring -match '([^\r\n]+)') {
                $description = $matches[1].Trim()
            }
            
            # Extract return type
            if ($docstring -match 'Returns:\s*(.+?)(\r?\n|$)') {
                $returnType = $matches[1].Trim()
            }
        }
        
        $methods += @{
            name = $methodName
            description = $description
            parameters = $paramList
            returns = $returnType
        }
    }
    
    # Look for emitted events
    # Pattern: emit('eventName' or self.emit('eventName'
    $eventMatches = [regex]::Matches($fileContent, '(self\.)?emit\s*\(\s*[''"]([a-zA-Z0-9_:]+)[''"]')
    
    foreach ($match in $eventMatches) {
        $eventName = $match.Groups[2].Value
        
        $events += @{
            name = $eventName
            description = "$eventName event"
        }
    }
    
    Write-Host "Found $($methods.Count) methods and $($events.Count) events in $FilePath" -ForegroundColor Green
    
    return @{
        Methods = $methods
        Events = $events
    }
}

# Function to auto-detect API methods and events from source files
function Auto-DetectApi {
    param (
        [string]$Runtime,
        [string]$EntryPoint
    )
    
    Write-Host "Auto-detecting API methods and events..." -ForegroundColor Cyan
    
    $allMethods = @()
    $allEvents = @()
    
    if ($Runtime -eq "nodejs") {
        # Find entry point and other important JS files
        $entryPointFile = if ($EntryPoint) { 
            $EntryPoint 
        } elseif (Test-Path "index.js") { 
            "index.js" 
        } elseif (Test-Path "app.js") { 
            "app.js" 
        } elseif (Test-Path "server.js") { 
            "server.js" 
        } else {
            (Get-ChildItem -Path "." -Filter "*.js" -File | Select-Object -First 1).Name
        }
        
        # Scan entry point first
        if ($entryPointFile -and (Test-Path $entryPointFile)) {
            $scanResult = Scan-JsForMethods -FilePath $entryPointFile
            $allMethods += $scanResult.Methods
            $allEvents += $scanResult.Events
        }
        
        # Scan other JS files (limit to 5 to avoid too much processing)
        $otherJsFiles = Get-ChildItem -Path "." -Filter "*.js" -File -Exclude $entryPointFile,"node_modules" | 
                        Select-Object -First 5 -ExpandProperty FullName
        
        foreach ($jsFile in $otherJsFiles) {
            $scanResult = Scan-JsForMethods -FilePath $jsFile
            $allMethods += $scanResult.Methods
            $allEvents += $scanResult.Events
        }
    }
    elseif ($Runtime -eq "python") {
        # Find entry point and other important Python files
        $entryPointFile = if ($EntryPoint) { 
            $EntryPoint 
        } elseif (Test-Path "app.py") { 
            "app.py" 
        } elseif (Test-Path "main.py") { 
            "main.py" 
        } elseif (Test-Path "run.py") { 
            "run.py" 
        } else {
            (Get-ChildItem -Path "." -Filter "*.py" -File -Exclude "setup.py" | Select-Object -First 1).Name
        }
        
        # Scan entry point first
        if ($entryPointFile -and (Test-Path $entryPointFile)) {
            $scanResult = Scan-PyForMethods -FilePath $entryPointFile
            $allMethods += $scanResult.Methods
            $allEvents += $scanResult.Events
        }
        
        # Scan other Python files (limit to 5 to avoid too much processing)
        $otherPyFiles = Get-ChildItem -Path "." -Filter "*.py" -File -Exclude $entryPointFile,"__pycache__" | 
                        Select-Object -First 5 -ExpandProperty FullName
        
        foreach ($pyFile in $otherPyFiles) {
            $scanResult = Scan-PyForMethods -FilePath $pyFile
            $allMethods += $scanResult.Methods
            $allEvents += $scanResult.Events
        }
    }
    
    Write-Host "Auto-detection complete. Found $($allMethods.Count) methods and $($allEvents.Count) events." -ForegroundColor Green
    
    return @{
        Methods = $allMethods
        Events = $allEvents
    }
}

# Function to help users define API methods
function Generate-ApiMethods {
    param (
        [string]$Runtime,
        [string]$EntryPoint
    )
    
    Write-Host "API Methods Configuration" -ForegroundColor Cyan
    Write-Host "========================" -ForegroundColor Cyan
    
    $methods = @()
    
    # First, try to auto-detect methods
    $autoDetectResult = Auto-DetectApi -Runtime $Runtime -EntryPoint $EntryPoint
    
    if ($autoDetectResult.Methods.Count -gt 0) {
        Write-Host "Automatically detected methods:" -ForegroundColor Green
        
        for ($i = 0; $i -lt $autoDetectResult.Methods.Count; $i++) {
            $method = $autoDetectResult.Methods[$i]
            Write-Host "$($i+1). $($method.name)" -ForegroundColor Yellow -NoNewline
            Write-Host " - $($method.description)"
        }
        
        Write-Host "Would you like to use these detected methods? (y/n)" -ForegroundColor Yellow
        $use_detected = Read-Host
        
        if ($use_detected -eq "y" -or $use_detected -eq "Y") {
            return $autoDetectResult.Methods
        }
    }
    
    # Manual entry if auto-detection fails or is declined
    while ($true) {
        Write-Host "Add a new API method? (y/n)" -ForegroundColor Yellow
        $add_method = Read-Host
        
        if ($add_method -ne "y" -and $add_method -ne "Y") {
            break
        }
        
        Write-Host "Enter method name:" -ForegroundColor Yellow
        $method_name = Read-Host
        
        Write-Host "Enter method description:" -ForegroundColor Yellow
        $method_description = Read-Host
        
        Write-Host "Enter parameters (comma-separated, leave empty for none):" -ForegroundColor Yellow
        $method_params_raw = Read-Host
        $method_params = $method_params_raw -split ',' | ForEach-Object { $_.Trim() } | Where-Object { $_ }
        
        Write-Host "Enter return type:" -ForegroundColor Yellow
        $method_return = Read-Host
        
        $methods += @{
            name = $method_name
            description = $method_description
            parameters = $method_params
            returns = $method_return
        }
    }
    
    Write-Host "API methods added: $($methods.Count)" -ForegroundColor Green
    return $methods
}

# Function to help users define API events
function Generate-ApiEvents {
    param (
        [string]$Runtime,
        [string]$EntryPoint
    )
    
    Write-Host "API Events Configuration" -ForegroundColor Cyan
    Write-Host "=======================" -ForegroundColor Cyan
    
    $events = @()
    
    # Check if we have auto-detected events
    $autoDetectResult = Auto-DetectApi -Runtime $Runtime -EntryPoint $EntryPoint
    
    if ($autoDetectResult.Events.Count -gt 0) {
        Write-Host "Automatically detected events:" -ForegroundColor Green
        
        for ($i = 0; $i -lt $autoDetectResult.Events.Count; $i++) {
            $event = $autoDetectResult.Events[$i]
            Write-Host "$($i+1). $($event.name)" -ForegroundColor Yellow -NoNewline
            Write-Host " - $($event.description)"
        }
        
        Write-Host "Would you like to use these detected events? (y/n)" -ForegroundColor Yellow
        $use_detected = Read-Host
        
        if ($use_detected -eq "y" -or $use_detected -eq "Y") {
            return $autoDetectResult.Events
        }
    }
    
    # Manual entry if auto-detection fails or is declined
    while ($true) {
        Write-Host "Add a new API event? (y/n)" -ForegroundColor Yellow
        $add_event = Read-Host
        
        if ($add_event -ne "y" -and $add_event -ne "Y") {
            break
        }
        
        Write-Host "Enter event name:" -ForegroundColor Yellow
        $event_name = Read-Host
        
        Write-Host "Enter event description:" -ForegroundColor Yellow
        $event_description = Read-Host
        
        $events += @{
            name = $event_name
            description = $event_description
        }
    }
    
    Write-Host "API events added: $($events.Count)" -ForegroundColor Green
    return $events
}

# Get plugin information
function Get-PluginInfo {
    param (
        [string]$Runtime
    )
    
    Write-Host "Plugin Configuration" -ForegroundColor Cyan
    Write-Host "===================" -ForegroundColor Cyan
    
    # Get plugin name
    Write-Host "Enter plugin name:" -ForegroundColor Yellow
    $plugin_name = Read-Host
    
    # Get plugin description
    Write-Host "Enter plugin description:" -ForegroundColor Yellow
    $plugin_description = Read-Host
    
    # Get plugin author
    Write-Host "Enter author name (company or individual):" -ForegroundColor Yellow
    $plugin_author = Read-Host
    
    # Get license
    $licenseOptions = @("MIT", "Apache 2.0", "GPL v3", "BSD", "Proprietary", "NASA Patent License")
    $plugin_license = Show-Menu -Options $licenseOptions -Title "Select license type"
    
    if ($plugin_license -eq "Proprietary") {
        Write-Host "Enter proprietary license name:" -ForegroundColor Yellow
        $plugin_license = Read-Host
    }
    
    # Get copyright notice
    Write-Host "Enter copyright notice (or press Enter for default):" -ForegroundColor Yellow
    $copyright_notice = Read-Host
    
    if ([string]::IsNullOrEmpty($copyright_notice)) {
        $copyright_notice = "Copyright 2025 $plugin_author, all rights reserved."
    }
    
    # Get entry point
    if ($Runtime -eq "nodejs") {
        $default_entry = "index.js"
        if (Test-Path "app.js") {
            $default_entry = "app.js"
        }
        elseif (Test-Path "server.js") {
            $default_entry = "server.js"
        }
    }
    else {
        $default_entry = "app.py"
        if (Test-Path "main.py") {
            $default_entry = "main.py"
        }
        elseif (Test-Path "run.py") {
            $default_entry = "run.py"
        }
    }
    
    Write-Host "Enter entry point (default: $default_entry):" -ForegroundColor Yellow
    $entry_point = Read-Host
    
    if ([string]::IsNullOrEmpty($entry_point)) {
        $entry_point = $default_entry
    }
    
    # Get version or generate from git
    if (Test-Path ".git" -PathType Container) {
        try {
            $git_version = git describe --tags --always 2>$null
            if ([string]::IsNullOrEmpty($git_version)) {
                $git_version = git rev-parse --short HEAD
            }
            
            Write-Host "Use Git version '$git_version'? (y/n)" -ForegroundColor Yellow
            $use_git_version = Read-Host
            
            if ($use_git_version -eq "y" -or $use_git_version -eq "Y") {
                $plugin_version = $git_version
            }
            else {
                Write-Host "Enter plugin version:" -ForegroundColor Yellow
                $plugin_version = Read-Host
            }
        }
        catch {
            Write-Host "Enter plugin version:" -ForegroundColor Yellow
            $plugin_version = Read-Host
        }
    }
    else {
        Write-Host "Enter plugin version:" -ForegroundColor Yellow
        $plugin_version = Read-Host
    }
    
    if ([string]::IsNullOrEmpty($plugin_version)) {
        $plugin_version = "1.0.0"
    }
    
    # Generate plugin ID
    $plugin_id = "$($plugin_name.ToLower() -replace '\s+','-')-$plugin_version"
    
    return @{
        Name = $plugin_name
        Description = $plugin_description
        Author = $plugin_author
        License = $plugin_license
        Copyright = $copyright_notice
        EntryPoint = $entry_point
        Version = $plugin_version
        Id = $plugin_id
    }
}

# Configure billing
function Configure-Billing {
    Write-Host "Billing Configuration" -ForegroundColor Cyan
    Write-Host "====================" -ForegroundColor Cyan
    
    $billingOptions = @("Free", "One-time payment", "Subscription", "Token-based")
    $billing_model = Show-Menu -Options $billingOptions -Title "Select billing model"
    
    $token_cost = 0
    $free_quota_enabled = $true
    $free_quota_limit = "unlimited"
    
    switch ($billing_model) {
        "Free" {
            $token_cost = 0
            $free_quota_enabled = $true
            $free_quota_limit = "unlimited"
        }
        "One-time payment" {
            Write-Host "Enter one-time cost in USD:" -ForegroundColor Yellow
            $cost_usd = Read-Host
            $token_cost = [math]::Round([double]$cost_usd / 0.01)
            $free_quota_enabled = $false
        }
        "Subscription" {
            $periodOptions = @("minutes", "hours", "days", "months")
            $subscription_period = Show-Menu -Options $periodOptions -Title "Select subscription period"
            
            Write-Host "Enter subscription cost in USD per $subscription_period:" -ForegroundColor Yellow
            $cost_usd = Read-Host
            $token_cost = [math]::Round([double]$cost_usd / 0.01)
            $free_quota_enabled = $false
            
            Write-Host "Enter free trial period (0 for none):" -ForegroundColor Yellow
            $free_trial = Read-Host
            
            if ([int]$free_trial -gt 0) {
                $free_quota_enabled = $true
                $free_quota_limit = "$free_trial $subscription_period"
            }
        }
        "Token-based" {
            Write-Host "Enter cost per use in tokens:" -ForegroundColor Yellow
            $token_cost = Read-Host
            
            Write-Host "Enter free usage quota (0 for none):" -ForegroundColor Yellow
            $free_usage = Read-Host
            
            if ([int]$free_usage -gt 0) {
                $free_quota_enabled = $true
                $free_quota_limit = $free_usage
            }
            else {
                $free_quota_enabled = $false
            }
        }
    }
    
    return @{
        TokenCost = $token_cost
        FreeQuotaEnabled = $free_quota_enabled
        FreeQuotaLimit = $free_quota_limit
    }
}

# Configure UI
function Configure-UI {
    Write-Host "UI Configuration" -ForegroundColor Cyan
    Write-Host "================" -ForegroundColor Cyan
    
    # Select category
    $categoryOptions = @(
        "Artificial Intelligence (AI)",
        "Machine Learning (ML)",
        "Deep Learning",
        "Natural Language Processing (NLP)",
        "Computer Vision",
        "Networking",
        "Network Security",
        "Cloud Networking",
        "Software-Defined Networking (SDN)",
        "Data Management",
        "Database Management Systems (DBMS)",
        "Data Analytics",
        "Big Data Technologies",
        "Development Frameworks",
        "Web Development Frameworks",
        "Mobile Development Frameworks",
        "Low-Code/No-Code Platforms",
        "Automation",
        "Robotic Process Automation (RPA)",
        "Workflow Automation",
        "Cybersecurity",
        "Intrusion Detection Systems (IDS)",
        "Endpoint Security",
        "Cloud Computing",
        "Infrastructure as a Service (IaaS)",
        "Platform as a Service (PaaS)"
    )
    
    $plugin_category = Show-Menu -Options $categoryOptions -Title "Select plugin category"
    
    # Simplified category for config
    $simple_category = ($plugin_category -split ' ')[0]
    
    # Select icon - show top 50 FontAwesome icons
    Write-Host "Select icon (FontAwesome) or enter your own:" -ForegroundColor Yellow
    Write-Host "View full icon list at: https://fontawesome.com/v5/search" -ForegroundColor Yellow
    
    $iconOptions = @(
        "user", "home", "cog", "wrench", "chart-bar", "database", "server", "cloud", 
        "shield-alt", "key", "lock", "unlock", "user-shield", "file", "file-code", 
        "file-alt", "folder", "folder-open", "search", "envelope", "bell", "calendar", 
        "image", "video", "music", "map", "map-marker", "globe", "link", "eye", 
        "eye-slash", "edit", "pen", "trash", "download", "upload", "sync", "history", 
        "clock", "save", "print", "camera", "phone", "mobile", "tablet", "laptop", 
        "desktop", "tv", "plug", "wifi", "custom"
    )
    
    $iconChoice = Show-Menu -Options $iconOptions -Title "Select icon"
    
    if ($iconChoice -eq "custom") {
        Write-Host "Enter custom icon name (e.g., 'rocket'):" -ForegroundColor Yellow
        $plugin_icon = Read-Host
    }
    else {
        $plugin_icon = $iconChoice
    }
    
    if ([string]::IsNullOrEmpty($plugin_icon)) {
        $plugin_icon = "puzzle-piece"
    }
    
    # Select color
    $colorOptions = @(
        "Red - #e6194b",
        "Green - #3cb44b",
        "Yellow - #ffe119",
        "Blue - #4363d8",
        "Orange - #f58231",
        "Purple - #911eb4",
        "Cyan - #46f0f0",
        "Magenta - #f032e6",
        "Lime - #bcf60c",
        "Pink - #fabebe",
        "Teal - #008080",
        "Lavender - #e6beff",
        "Brown - #9a6324",
        "Cream - #fffac8",
        "Maroon - #800000",
        "Mint - #aaffc3",
        "Olive - #808000",
        "Peach - #ffd8b1",
        "Navy - #000075",
        "Gray - #808080",
        "Custom"
    )
    
    $color = Show-Menu -Options $colorOptions -Title "Select color"
    
    if ($color -eq "Custom") {
        Write-Host "Enter hex color code (e.g., #ff5500):" -ForegroundColor Yellow
        $plugin_color = Read-Host
    }
    else {
        $plugin_color = ($color -split ' - ')[1]
    }
    
    # Check for logo
    $plugin_logo = ""
    
    if (Test-Path "images" -PathType Container) {
        $logo_files = Get-ChildItem -Path "images" -Filter "*.png" -Recurse
        $logo_files += Get-ChildItem -Path "images" -Filter "*.jpg" -Recurse
        $logo_files += Get-ChildItem -Path "images" -Filter "*.svg" -Recurse
        
        if ($logo_files.Count -gt 0) {
            $logoOptions = $logo_files.FullName + @("None", "Create new")
            $logo = Show-Menu -Options $logoOptions -Title "Select logo file"
            
            if ($logo -eq "None") {
                $plugin_logo = ""
            }
            elseif ($logo -eq "Create new") {
                $plugin_logo = Create-LogoDir
            }
            else {
                $plugin_logo = $logo
            }
        }
        else {
            $plugin_logo = Create-LogoDir
        }
    }
    else {
        $plugin_logo = Create-LogoDir
    }
    
    return @{
        Category = $plugin_category
        SimpleCategory = $simple_category
        Icon = $plugin_icon
        Color = $plugin_color
        Logo = $plugin_logo
    }
}

# Create logo directory
function Create-LogoDir {
    Write-Host "No suitable logo found. Create images directory? (y/n)" -ForegroundColor Yellow
    $create_dir = Read-Host
    
    if ($create_dir -eq "y" -or $create_dir -eq "Y") {
        New-Item -Path "images" -ItemType Directory -Force | Out-Null
        Write-Host "Created images directory" -ForegroundColor Green
        Write-Host "Please place a logo.png file (max 100x100px) in the images directory later" -ForegroundColor Yellow
        return "images/logo.png"
    }
    else {
        return ""
    }
}

# Generate config.json
function Generate-Config {
    param (
        [hashtable]$PluginInfo,
        [hashtable]$BillingInfo,
        [hashtable]$UIInfo,
        [array]$Methods,
        [array]$Events
    )
    
    Write-Host "Generating config.json..." -ForegroundColor Cyan
    
    # Create JSON structure
    $config = @{
        id = $PluginInfo.Id
        version = $PluginInfo.Version
        name = $PluginInfo.Name
        description = $PluginInfo.Description
        author = $PluginInfo.Author
        license = $PluginInfo.License
        copyright = $PluginInfo.Copyright
        type = $UIInfo.SimpleCategory.ToLower()
        entryPoint = $PluginInfo.EntryPoint
        billing = @{
            tokenCost = $BillingInfo.TokenCost
            freeQuota = @{
                enabled = $BillingInfo.FreeQuotaEnabled
                limit = $BillingInfo.FreeQuotaLimit
            }
        }
        permissions = @("files:read")
        dependencies = @()
        configuration = @{
            logLevel = @{
                type = "string"
                default = "info"
                description = "Log level (debug, info, warn, error)"
            }
        }
        api = @{
            methods = $Methods
            events = $Events
        }
        ui = @{
            icon = $UIInfo.Icon
            color = $UIInfo.Color
            category = $UIInfo.Category
        }
    }
    
    # Convert to JSON and save
    $configJson = $config | ConvertTo-Json -Depth 10
    Set-Content -Path "config.json" -Value $configJson
    
    Write-Host "config.json generated successfully" -ForegroundColor Green
}

# Package plugin
function Package-Plugin {
    param (
        [string]$PluginId,
        [string]$Runtime
    )
    
    Write-Host "Packaging plugin..." -ForegroundColor Cyan
    
    # Create a clean directory for packaging
    if (Test-Path ".safeguard-package") {
        Remove-Item -Path ".safeguard-package" -Recurse -Force
    }
    
    New-Item -Path ".safeguard-package" -ItemType Directory -Force | Out-Null
    
    # Copy files
    if ($Runtime -eq "nodejs") {
        # For Node.js projects
        if (Test-Path "package.json") { Copy-Item "package.json" -Destination ".safeguard-package" }
        if (Test-Path "package-lock.json") { Copy-Item "package-lock.json" -Destination ".safeguard-package" }
        if (Test-Path "yarn.lock") { Copy-Item "yarn.lock" -Destination ".safeguard-package" }
        if (Test-Path "node_modules") { Copy-Item "node_modules" -Destination ".safeguard-package" -Recurse }
        if (Test-Path "src") { Copy-Item "src" -Destination ".safeguard-package" -Recurse }
        if (Test-Path "lib") { Copy-Item "lib" -Destination ".safeguard-package" -Recurse }
        if (Test-Path "dist") { Copy-Item "dist" -Destination ".safeguard-package" -Recurse }
        if (Test-Path "images") { Copy-Item "images" -Destination ".safeguard-package" -Recurse }
        
        Get-ChildItem -Path "." -Filter "*.js" | Copy-Item -Destination ".safeguard-package"
    }
    elseif ($Runtime -eq "python") {
        # For Python projects
        if (Test-Path "requirements.txt") { Copy-Item "requirements.txt" -Destination ".safeguard-package" }
        if (Test-Path "setup.py") { Copy-Item "setup.py" -Destination ".safeguard-package" }
        if (Test-Path "Pipfile") { Copy-Item "Pipfile" -Destination ".safeguard-package" }
        if (Test-Path "Pipfile.lock") { Copy-Item "Pipfile.lock" -Destination ".safeguard-package" }
        if (Test-Path "src") { Copy-Item "src" -Destination ".safeguard-package" -Recurse }
        if (Test-Path "lib") { Copy-Item "lib" -Destination ".safeguard-package" -Recurse }
        if (Test-Path "images") { Copy-Item "images" -Destination ".safeguard-package" -Recurse }
        
        Get-ChildItem -Path "." -Filter "*.py" | Copy-Item -Destination ".safeguard-package"
    }
    
    # Copy common files
    if (Test-Path "config.json") { Copy-Item "config.json" -Destination ".safeguard-package" }
    if (Test-Path "Dockerfile") { Copy-Item "Dockerfile" -Destination ".safeguard-package" }
    if (Test-Path "docker-compose.yml") { Copy-Item "docker-compose.yml" -Destination ".safeguard-package" }
    if (Test-Path "README.md") { Copy-Item "README.md" -Destination ".safeguard-package" }
    if (Test-Path "LICENSE") { Copy-Item "LICENSE" -Destination ".safeguard-package" }
    
    # Create package
    $package_name = "$PluginId.zip"
    
    try {
        Add-Type -AssemblyName System.IO.Compression.FileSystem
        [System.IO.Compression.ZipFile]::CreateFromDirectory((Resolve-Path ".safeguard-package"), $package_name)
        Write-Host "Plugin packaged successfully: $package_name" -ForegroundColor Green
    }
    catch {
        Write-Host "Warning: Could not create zip package. Please manually compress the .safeguard-package directory." -ForegroundColor Yellow
    }
    
    # Clean up
    Remove-Item -Path ".safeguard-package" -Recurse -Force
    
    return $package_name
}

# Setup Git repository
function Setup-GitRepo {
    param (
        [hashtable]$PluginInfo
    )
    
    Write-Host "Would you like to set up a Git repository? (y/n)" -ForegroundColor Yellow
    $setup_git = Read-Host
    
    if ($setup_git -eq "y" -or $setup_git -eq "Y") {
        if (Test-Path ".git" -PathType Container) {
            Write-Host "Git repository already exists" -ForegroundColor Green
        }
        else {
            Write-Host "Initializing Git repository..." -ForegroundColor Cyan
            
            try {
                git init
                
                # Create .gitignore
                $gitignoreContent = @"
node_modules/
__pycache__/
*.pyc
*.pyo
*.pyd
.Python
env/
venv/
ENV/
dist/
build/
*.egg-info/
.coverage
htmlcov/
.tox/
.nox/
.hypothesis/
.pytest_cache/
"@
                
                Set-Content -Path ".gitignore" -Value $gitignoreContent
                
                # Initial commit
                git add .
                git commit -m "Initial commit for Safeguard plugin: $($PluginInfo.Name)"
                
                Write-Host "Git repository initialized" -ForegroundColor Green
            }
            catch {
                Write-Host "Error initializing Git repository: $_" -ForegroundColor Red
            }
        }
        
        Write-Host "Enter Git repository URL (leave empty if none):" -ForegroundColor Yellow
        $repo_url = Read-Host
        
        if (-not [string]::IsNullOrEmpty($repo_url)) {
            Write-Host "Adding remote repository..." -ForegroundColor Cyan
            
            try {
                git remote add origin "$repo_url"
                
                Write-Host "Push to remote repository? (y/n)" -ForegroundColor Yellow
                $push_repo = Read-Host
                
                if ($push_repo -eq "y" -or $push_repo -eq "Y") {
                    git push -u origin master 2>$null
                    if ($LASTEXITCODE -ne 0) {
                        git push -u origin main
                    }
                }
            }
            catch {
                Write-Host "Error setting up remote repository: $_" -ForegroundColor Red
            }
        }
    }
}

# Show summary
function Show-Summary {
    param (
        [hashtable]$PluginInfo,
        [string]$Runtime,
        [bool]$HasDockerfile,
        [hashtable]$UIInfo
    )
    
    Write-Host "Plugin Configuration Summary" -ForegroundColor Cyan
    Write-Host "==========================" -ForegroundColor Cyan
    Write-Host "Name: $($PluginInfo.Name)" -ForegroundColor Green
    Write-Host "ID: $($PluginInfo.Id)" -ForegroundColor Green
    Write-Host "Version: $($PluginInfo.Version)" -ForegroundColor Green
    Write-Host "Description: $($PluginInfo.Description)" -ForegroundColor Green
    Write-Host "Author: $($PluginInfo.Author)" -ForegroundColor Green
    Write-Host "License: $($PluginInfo.License)" -ForegroundColor Green
    Write-Host "Entry Point: $($PluginInfo.EntryPoint)" -ForegroundColor Green
    Write-Host "Runtime: $Runtime" -ForegroundColor Green
    Write-Host "Dockerfile: $(if ($HasDockerfile) { 'Yes' } else { 'No' })" -ForegroundColor Green
    Write-Host "UI: $($UIInfo.Category) / $($UIInfo.Icon) / $($UIInfo.Color)" -ForegroundColor Green
    
    Write-Host "Proceed with this configuration? (y/n)" -ForegroundColor Yellow
    $confirm = Read-Host
    
    return ($confirm -eq "y" -or $confirm -eq "Y")
}

# Main function
function Main {
    if ($args[0] -eq "help") {
        Show-Help
        exit 0
    }
    
    $runtimeInfo = Detect-Runtime
    $Runtime = $runtimeInfo.Runtime
    $ConfigFile = $runtimeInfo.ConfigFile
    
    $Dependencies = Parse-Dependencies -Runtime $Runtime -ConfigFile $ConfigFile
    $HasDockerfile = Check-Dockerfile -Runtime $Runtime
    $PluginInfo = Get-PluginInfo -Runtime $Runtime
    $BillingInfo = Configure-Billing
    $UIInfo = Configure-UI
    $Methods = Generate-ApiMethods -Runtime $Runtime -EntryPoint $PluginInfo.EntryPoint
    $Events = Generate-ApiEvents -Runtime $Runtime -EntryPoint $PluginInfo.EntryPoint
    
    Generate-Config -PluginInfo $PluginInfo -BillingInfo $BillingInfo -UIInfo $UIInfo -Methods $Methods -Events $Events
    
    $proceed = Show-Summary -PluginInfo $PluginInfo -Runtime $Runtime -HasDockerfile $HasDockerfile -UIInfo $UIInfo
    
    if (-not $proceed) {
        Write-Host "Restarting wizard..." -ForegroundColor Red
        Main
        return
    }
    
    $package_name = Package-Plugin -PluginId $PluginInfo.Id -Runtime $Runtime
    Setup-GitRepo -PluginInfo $PluginInfo
    
    Write-Host "Plugin setup complete!" -ForegroundColor Green
    Write-Host "Your plugin has been configured with Safeguard-compatible settings."
    Write-Host "Package: $package_name" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Yellow
    Write-Host "1. Review the generated config.json file"
    Write-Host "2. Implement the API methods defined in your plugin"
    Write-Host "3. Add your plugin to the Safeguard system"
    Write-Host ""
    Write-Host "Thank you for using the Safeguard Plugin Onboarding Wizard!" -ForegroundColor Blue
}

# Run the main function
Main $args
```


These updated files include:

1. **HTML with Simplified Copy Options**:
    - Now uses `safeguard.iqsms.com` as the base URL
    - Maintains the original layout while simplifying copy buttons

2. **Bash Script with Enhanced Features**:
    - Adds source code scanning for API methods and events detection
    - Supports multiple Python file patterns (requirements.txt, setup.py, Pipfile)
    - Detects Python virtual environments (venv, .venv, env)
    - Parses method signatures and documentation to extract parameters and return types
    - Detects events by looking for emit() calls

3. **PowerShell Script with Enhanced Features**:
    - Similar improvements to the Bash script
    - PowerShell-compatible code scanning for method detection
    - Better Python support
    - Comprehensive FontAwesome icon selection with link to the full gallery

4. **README.md**:
    - Updated with the correct URLs
    - Improved organization and instructions

The main improvements focus on making the onboarding process more intuitive by automatically detecting methods and events from source code, while still providing manual options when needed. The scripts are now more robust at detecting various project setups, particularly for Python projects with different environment and dependency management approaches.