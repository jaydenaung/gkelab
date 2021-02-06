#!/bin/bash

# ****************************************************
# A simple script to set up a GKE Cluster in 5 minutes 
# Author: Jayden Kyaw Htet Aung 
# See LICENSE and README files
# ****************************************************

#UPDATE THIS
PROJECT_ID="helloworld041019"

#UPDATE THIS
IMAGE="gcr.io/$PROJECT_ID/demo-app:v1"

read -p "Enter Your Cluster Name (Default: my-cluster): " clustername
clustername=${clustername:-my-cluster}

read -p "Enter App Name (Default: demo-app): " app
app=${app:-demo-app}

read -p "Enter GCP Region (Default: asia-southeast1): " region
region=${region:-asia-southeast1}

read -p "Enter Your Service Name (Default: my-service): " service1
service1=${service1:-demo-svc}

echo "Creating Cluster on GCP in $zone"
gcloud container clusters create $clustername --region $region --node-locations $region-a,$region-b
echo "$clustername has been created."

echo "Creating deployment.."
kubectl create deployment $app --image=$IMAGE

echo "Scaling deployment to 3 replicas.."
kubectl scale deployment $app --replicas=3

echo "Configuring autoscaling for the deployment.."
kubectl autoscale deployment $app --cpu-percent=80 --min=1 --max=5

echo "Exposing your app via a load balancer.."
kubectl expose deployment $app --name=$service1 --type=LoadBalancer --port 80 --target-port 80

echo "Your Kubernetes cluster has been created on `date`!"
sleep 60

export lb_ip=$(kubectl get services | awk 'NR ==2 {print $4;exist}')
echo "Your load balancer IP is $lb_ip"  

