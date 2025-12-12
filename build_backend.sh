#!/bin/bash

# Backend build script using docker compose
set -e

echo "Starting backend build with Docker..."

# Build backend service
docker compose build backend

# Run database migrations
echo "Running database migrations..."
docker compose run --rm backend rails db:migrate

echo "Backend build completed successfully!"