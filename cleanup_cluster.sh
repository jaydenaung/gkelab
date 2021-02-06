#!/bin/bash
# Author: Jayden Kyaw Htet Aung

PROJECT_ID="helloworld041019"

#First we need to look for K8s services 
command2=$(kubectl get services | awk 'NR ==2 {print $1;exist}')
export service=$(echo $command2)

#If serivices found, we'll start deleting
echo "Looking for services..."
if [ -z "$service" ]
then
    echo "You don't have a service. Nothing to delete."
    
else 
    echo "Your have a k8s service called $service"
    echo "Deleting service: $service"
    kubectl delete service $service
    echo "$service has been deleted"
fi

command1=$(gcloud container clusters list | awk 'NR ==2 {print $1;exist}')
export clustername=$(echo $command1)

echo "Looking for clusters..."
if [ -z "$clustername" ]
then
    echo "You don't have a k8s cluster. Nothing to delete."
else 
    echo "Your have a GKE cluster called $clustername"
    echo "Deleting GKE Cluster: $clustername"
    gcloud container clusters delete $clustername
    echo "$clustername has been deleted"
    echo ".............................."
    echo Deletion completed on `date`
fi
