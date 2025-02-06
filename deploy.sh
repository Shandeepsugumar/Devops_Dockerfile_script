#!/bin/bash

# Exit script on error
set -e

# Print message
echo "Starting deployment on Minikube..."

# Start Minikube
minikube start

# Set Docker to use Minikube's environment
eval $(minikube docker-env)

# Make build script executable and run it
chmod +x build.sh
./build.sh

# Docker login (Not required for Minikube but keeping it for reference)
docker login -u shandeep04 -p shandeep-4621

# Tag and push Docker image
IMAGE_NAME="shandeep04/docker_jenkins_task2"
NEW_TAG="latest"
docker tag test $IMAGE_NAME:$NEW_TAG
docker push $IMAGE_NAME:$NEW_TAG

# Deploy application to Minikube
kubectl apply -f k8s-deployment.yaml

# Wait for deployment to complete
kubectl rollout status deployment/my-app-deployment

# Get Minikube service URL
echo "Application deployed successfully! Access it at:"
minikube service my-app-service --url

