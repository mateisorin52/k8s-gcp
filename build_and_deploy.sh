#!/bin/bash

# Build Docker image
docker build -t tf-app:v2 .

# Tag the image with version
docker tag tf-app:v2 sorinmatei/tf-app

# Push the image to Docker Hub
docker push sorinmatei/tf-app

# Apply Kubernetes deployment using Terraform
cd CI
terraform apply -auto-approve
