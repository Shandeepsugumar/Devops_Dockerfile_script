#!/bin/bash

# Print a message
echo hi123

# Make the build script executable and run it
chmod +x build.sh
./build.sh

# Log in to Docker Hub
docker login -u shandeep04 -p shandeep-4621

# Tag the Docker image
docker tag test shandeep04/docker_jenkins_task2

# Push the Docker image to Docker Hub
docker push shandeep04/docker_jenkins_task2

# Step 1: Start Minikube (if not already running)
kubectl create deployment shandeep --image=shandeep04/docker_jenkins_task2 --port=80

kubectl expose deployment shandeep --type=NodePort --port=80
