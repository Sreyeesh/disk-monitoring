#!/bin/bash

# Navigate to project root (optional: update this path if needed)
PROJECT_DIR="$(dirname "$(realpath "$0")")"
cd "$PROJECT_DIR"

echo ""
echo "📁 Project Structure (Disk Monitoring)"
echo "---------------------------------------"

# Show tree up to 4 levels deep, ignore hidden files
tree -I '.*' -L 4

echo ""
echo "✅ Structure displayed (hidden files excluded)"
