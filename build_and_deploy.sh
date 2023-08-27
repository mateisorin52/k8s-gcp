#!/bin/bash

# Build Docker image
docker build -t tf-app:latest .

# Tag the image with version
docker tag tf-app:latest sorinmatei/tf-app

# Push the image to Docker Hub
docker push sorinmatei/tf-app

# Apply Kubernetes deployment using Terraform
cd CI
kubectl get pods
