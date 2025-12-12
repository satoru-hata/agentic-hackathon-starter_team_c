#!/bin/bash

# Frontend build script using docker compose
set -e

echo "Starting frontend build with Docker..."

# Run build inside Docker container
docker compose run --rm frontend npm run build

echo "Frontend build completed successfully!"