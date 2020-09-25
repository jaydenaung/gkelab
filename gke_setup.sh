#!/bin/bash

PROJECT_ID="Your-GCP-Project"

read -p "Enter Your Cluster Name: " clustername
read -p "Enter App Name (e.g. myapp): " app
read -p "Enter GCP Region (e.g. asia-southeast1): " region
read -p "Enter Your Service Name (e.g. my-service): " service1

echo "Creating Cluster on GCP in $zone"
gcloud container clusters create $clustername --region $region --node-locations $region-a,$region-b
echo "$clustername has been created."

echo "Creating deployment.."
kubectl create deployment $app --image=gcr.io/$PROJECT_ID/cyberave-io:v1

echo "Scaling deployment to 3 replicas.."
kubectl scale deployment $app --replicas=3

echo "Configuring autoscaling for the deployment.."
kubectl autoscale deployment $app --cpu-percent=80 --min=1 --max=5

echo "Exposing your app via a load balancer.."
kubectl expose deployment $app --name=$service1 --type=LoadBalancer --port 80 --target-port 80

echo "Your Kubernetes cluster has been created!"
lb_ip ="kubectl get services | awk 'NR ==2 {print $4;exist}'"
echo "Your load balancer IP is $lb_ip"
