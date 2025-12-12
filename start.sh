#!/bin/bash

echo "Starting development environment..."

# Build and start Rails backend with Docker
echo "Building and starting Rails API backend with PostgreSQL..."
docker-compose down
docker-compose build backend
docker-compose up -d db backend

# Wait for services to be ready
echo "Waiting for services to be ready..."
sleep 10

# Run database setup
echo "Setting up database..."
docker-compose exec backend rails db:create 2>/dev/null || true
docker-compose exec backend rails db:migrate

# Start React frontend
echo "Starting React frontend on port 3001..."
cd frontend
npm install
npm start &

echo ""
echo "================================"
echo "Development environment is running!"
echo "Rails API: http://localhost:3000/api/v1/welcome"
echo "React App: http://localhost:3001"
echo "================================"
echo ""
echo "To stop all services, run: docker-compose down"