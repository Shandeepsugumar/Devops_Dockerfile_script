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

# Minikube Deployment
# Step 1: Start Minikube (if not already running)
minikube start

# Step 2: Create a Kubernetes deployment YAML file
cat <<EOF > deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
spec:
  replicas: 1
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
      - name: my-app
        image: shandeep04/docker_jenkins_task2:latest
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: my-app
spec:
  type: NodePort
  ports:
  - port: 80
    targetPort: 80
    nodePort: 30000
  selector:
    app: my-app
EOF

# Step 3: Apply the deployment and service to the Minikube cluster
kubectl apply -f deployment.yaml

# Step 4: Verify the deployment
echo "Waiting for the deployment to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/my-app

# Step 5: Get the Minikube service URL
minikube service my-app --url
