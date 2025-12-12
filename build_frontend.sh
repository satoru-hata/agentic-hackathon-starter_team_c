#!/bin/bash

echo "Building frontend dependencies..."

# Run npm install using docker compose run --rm
if docker compose run --rm --no-deps frontend npm install; then
    echo "Frontend dependencies installed successfully!"
else
    echo "Error: Failed to install frontend dependencies"
    exit 1
fi
