#!/bin/bash

# Main build script
set -e

echo "Starting full build process..."

# Call backend build
echo "Building backend..."
./build_backend.sh

# Call frontend build
echo "Building frontend..."
./build_frontend.sh

echo "Full build completed successfully!"