#!/bin/bash

# Stop and remove existing container if it exists
echo "Cleaning up existing container..."
docker stop hash-forge-container 2>/dev/null || true
docker rm hash-forge-container 2>/dev/null || true

# Build Docker image
echo "Building Docker image..."
if docker build -t hash-forge .; then
    echo "✅ Docker image built successfully!"
else
    echo "❌ Docker build failed!"
    exit 1
fi

# Run the container
echo "Starting container on port 3000..."
if docker run -p 3000:80 --name hash-forge-container hash-forge; then
    echo "✅ Container started successfully!"
    echo "🌐 Visit http://localhost:3000 to see your app"
else
    echo "❌ Failed to start container!"
    exit 1
fi

# Commands to manage the container:
# To stop: docker stop hash-forge-container
# To remove: docker rm hash-forge-container
# To rebuild: ./docker-build.sh
