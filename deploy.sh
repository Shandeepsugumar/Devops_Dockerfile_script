#!/bin/bash

# Existing code
echo hi123
sh 'chmod +x build.sh'
sh './build.sh'
docker login -u shandeep04 -p shandeep-4621
docker tag test shandeep04/docker_jenkins_task2
docker push shandeep04/docker_jenkins_task2

# New code for Minikube deployment
# Start Minikube if it's not already running
minikube start

# Create a deployment YAML file
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
        image: shandeep04/docker_jenkins_task2
        ports:
        - containerPort: 8080  # Change this to the port your app listens on
EOF

# Apply the deployment
kubectl apply -f deployment.yaml

# Expose the deployment as a service
kubectl expose deployment my-app --type=NodePort --port=8080  # Change this to the port your app listens on

# Get the URL to access the service
minikube service my-app --url
