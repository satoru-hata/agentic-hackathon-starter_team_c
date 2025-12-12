#!/bin/bash

echo "Building frontend dependencies..."

# Run npm install using docker compose run --rm
docker compose run --rm frontend npm install

echo "Frontend dependencies installed successfully!"
