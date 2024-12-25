#!/bin/bash

# Variables
MODULE_DIR="01-helm"
IMAGE_NAME="demo-helm-app"
CONTAINER_NAME="demo-helm-app"
CHART_NAME="demo-helm-chart"
RELEASE_NAME="demo-helm"

# Function to check if Minikube is already running
function check_minikube() {
    if minikube status >/dev/null 2>&1; then
        echo "Minikube is already running."
    else
        echo "Starting Minikube..."
        minikube start --driver=docker
    fi
}

# Function to configure Docker to use Minikube's Docker daemon
function configure_docker() {
    echo "Configuring Docker to use Minikube's Docker daemon..."
    eval $(minikube docker-env)
}

# Function to build Docker image
function build_docker_image() {
    echo "Building Docker image..."
    if docker images | grep -q "${IMAGE_NAME}"; then
        echo "Docker image '${IMAGE_NAME}' already exists."
    else
        docker build -f ${MODULE_DIR}/Dockerfile --build-arg MODULE_DIR=${MODULE_DIR} -t ${IMAGE_NAME} .
    fi
}

# Function to stop and remove any existing container
function cleanup_existing_container() {
    if docker ps -aq -f name=${CONTAINER_NAME} >/dev/null; then
        echo "Stopping and removing existing container '${CONTAINER_NAME}'..."
        docker stop ${CONTAINER_NAME} >/dev/null 2>&1 || true
        docker rm ${CONTAINER_NAME} >/dev/null 2>&1 || true
    fi
}

# Function to deploy using Helm
function deploy_helm_chart() {
    echo "Deploying application with Helm..."
    if helm list -q | grep -q "${RELEASE_NAME}"; then
        echo "Helm release '${RELEASE_NAME}' already exists. Upgrading..."
        helm upgrade ${RELEASE_NAME} ${CHART_NAME}/
    else
        helm install ${RELEASE_NAME} ${CHART_NAME}/
    fi
}

# Function to retrieve and display the service URL
function display_service_url() {
    echo "Retrieving service details..."
    NODE_IP=$(minikube ip)
    SERVICE_INFO=$(kubectl get service | grep ${CHART_NAME}-service | awk '{print $4 ":" $5}')
    NODE_PORT=$(echo ${SERVICE_INFO} | cut -d: -f2)

    if [[ -n "$NODE_IP" && -n "$NODE_PORT" ]]; then
        echo "Application is available at: http://${NODE_IP}:${NODE_PORT}"
        echo "Opening the application in your browser..."
        minikube service ${CHART_NAME}-service --url
    else
        echo "Failed to retrieve service URL. Please check the service status."
    fi
}

# Main script execution
echo "Starting deployment process..."
cd "$(dirname "$0")"/..

check_minikube
configure_docker
cleanup_existing_container
build_docker_image
deploy_helm_chart
display_service_url
