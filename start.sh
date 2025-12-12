#!/bin/bash

echo "Starting development environment..."

# Build and start all services with Docker
echo "Building and starting Rails API backend, PostgreSQL, and React frontend..."
docker-compose down
docker-compose build backend frontend
docker-compose up -d

# Wait for services to be ready
echo "Waiting for services to be ready..."
sleep 10

# Run database setup
echo "Setting up database..."
docker-compose exec backend rails db:create 2>/dev/null || true
docker-compose exec backend rails db:migrate

echo ""
echo "================================"
echo "Development environment is running!"
echo "Rails API: http://localhost:3000/api/v1/welcome"
echo "React App: http://localhost:3001"
echo "================================"
echo ""
echo "To stop all services, run: docker-compose down"