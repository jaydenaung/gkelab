#!/bin/bash

# ****************************************************
# A simple script to clean up GKE Cluster  
# Author: Jayden Kyaw Htet Aung 
# See LICENSE and README files
# ****************************************************

echo "Now we are gonna do a clean up!"

export svc=$(kubectl get services | awk 'NR ==2 {print $1;exist}')
echo "You have a service called $svc"

echo "Now we are gonna delete $svc .."
kubectl delete service $svc 

echo "$svc has been deleted.."

export deployment=$(kubectl get deploy | awk 'NR ==2 {print $1;exist}')
echo "You have a deployment called $deployment .."

echo "Now we are gonna delete $deployment"
kubectl delete deployment $deployment

echo "$deployment has been deleted.."

echo "Now we are gonna delete the GKE clusters.."
export cluster=$(gcloud container clusters list | awk 'NR == 2 {print $1;exist}')
echo "You have a GKE cluster called $cluster.."

echo "Now we are gonna delete $cluster.."
gcloud container clusters delete $cluster --region asia-southeast1

echo "Clean-up has been completed on `date`.."