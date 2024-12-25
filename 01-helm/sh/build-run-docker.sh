#!/bin/bash

# Variables
MODULE_DIR="01-helm"
IMAGE_NAME="demo-helm-app"
CONTAINER_NAME="demo-helm-app"
HOST_PORT=8080
CONTAINER_PORT=8080

# Navigate to the parent directory of the script
cd "$(dirname "$0")/.." || exit 1

# Build the Docker image
echo "Building the Docker image..."
docker build -f ${MODULE_DIR}/Dockerfile -t ${IMAGE_NAME} .

# Stop and remove any existing container with the same name
if [ "$(docker ps -aq -f name=${CONTAINER_NAME})" ]; then
    echo "Stopping and removing existing container..."
    docker stop ${CONTAINER_NAME} >/dev/null 2>&1 || true
    docker rm ${CONTAINER_NAME} >/dev/null 2>&1 || true
fi

# Run the Docker container
echo "Running the Docker container..."
docker run --name ${CONTAINER_NAME} -p ${HOST_PORT}:${CONTAINER_PORT} ${IMAGE_NAME}
