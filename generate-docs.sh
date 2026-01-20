#!/bin/bash

# Documentation Generation Script for FluentCards
# This script generates both HTML and Markdown documentation from C# XML comments

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔧 FluentCards Documentation Generator${NC}"
echo "=================================="

# Check if docfx is available
if ! command -v docfx &> /dev/null; then
    echo -e "${YELLOW}⚠️  DocFX not found in PATH, trying to add dotnet tools path...${NC}"
    export PATH="$PATH:/Users/ridomin/.dotnet/tools"
    
    if ! command -v docfx &> /dev/null; then
        echo -e "${RED}❌ DocFX not found. Installing...${NC}"
        dotnet tool install --global docfx
        export PATH="$PATH:/Users/ridomin/.dotnet/tools"
    fi
fi

echo -e "${GREEN}✅ DocFX found${NC}"

# Build the project first to ensure XML documentation is up to date
echo -e "${BLUE}🏗️  Building project...${NC}"
dotnet build src/FluentCards/FluentCards.csproj

# Generate HTML documentation
echo -e "${BLUE}📚 Generating HTML documentation...${NC}"
docfx docfx.json --output _site

# Create Markdown version (simplified)
echo -e "${BLUE}📝 Generating Markdown documentation...${NC}"
mkdir -p docs/md

# Copy the API documentation in Markdown format
if [ -d "_site/api" ]; then
    cp -r _site/api docs/md/
    echo -e "${GREEN}✅ Markdown API docs copied to docs/md/${NC}"
fi

# Copy the index page
cp index.md docs/md/ 2>/dev/null || true

echo -e "${GREEN}🎉 Documentation generation complete!${NC}"
echo
echo "Available formats:"
echo "  📄 HTML: Open docs/_site/index.html in your browser"
echo "  📝 Markdown: See docs/md/ directory"
echo
echo "To serve HTML documentation locally:"
echo "  docfx docfx.json --serve"
echo "  Then visit http://localhost:8080"