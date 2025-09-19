#!/bin/bash
# generate-safeguard-html.sh
# This script generates HTML documentation from the markdown query-response pairs

# Set script to exit on error
set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print banner
echo -e "${BLUE}╔════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║       Safeguard LLM Response HTML Generator        ║${NC}"
echo -e "${BLUE}║      Copyright 2025 Safeguard System               ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════╝${NC}"
echo

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo -e "${RED}Error: Node.js is not installed${NC}"
    echo -e "${YELLOW}Please install Node.js first: https://nodejs.org/${NC}"
    exit 1
fi

# Check for required files
if [ ! -f "SafeguardLLMResponseGenerator.js" ]; then
    echo -e "${RED}Error: SafeguardLLMResponseGenerator.js not found in the current directory${NC}"
    echo -e "${YELLOW}Make sure you're running this script from the correct directory${NC}"
    exit 1
fi

# Check for markdown files
QUERY_FILES=$(ls *_Query*.md 2>/dev/null | wc -l)
RESPONSE_FILES=$(ls *_LLM*.md 2>/dev/null | wc -l)

if [ "$QUERY_FILES" -eq 0 ] || [ "$RESPONSE_FILES" -eq 0 ]; then
    echo -e "${YELLOW}Warning: No markdown files found matching the expected patterns${NC}"
    echo -e "${YELLOW}Expected files: *_Query*.md for queries and *_LLM*.md for responses${NC}"
    echo -e "${YELLOW}Current directory contents:${NC}"
    ls -la
    echo
    read -p "Continue anyway? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Install dependencies if needed
echo -e "${BLUE}Checking for required dependencies...${NC}"
if [ ! -d "node_modules" ]; then
    echo -e "${YELLOW}No node_modules found. Installing required packages...${NC}"
    npm init -y >/dev/null 2>&1
    npm install --silent fs path
    echo -e "${GREEN}Dependencies installed${NC}"
else
    echo -e "${GREEN}Dependencies found${NC}"
fi

# Generate HTML files
echo -e "${BLUE}Generating HTML files...${NC}"
node generate-safeguard-html.sh

# Check if index.html was created
if [ -f "index.html" ]; then
    PAIRS=$(ls pair*.html 2>/dev/null | wc -l)
    echo -e "${GREEN}Success! Generated index.html and $PAIRS pair HTML files${NC}"
    echo -e "${GREEN}You can now open index.html in your browser to view the documentation${NC}"
else
    echo -e "${RED}Error: Failed to generate index.html${NC}"
    echo -e "${YELLOW}Check the JavaScript file for errors and try again${NC}"
    exit 1
fi

echo
echo -e "${BLUE}Generated files:${NC}"
ls -la *.html

exit 0
