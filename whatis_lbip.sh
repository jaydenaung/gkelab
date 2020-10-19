#!/bin/bash

echo "Your Kubernetes cluster has been created!"
export lb_ip=$(kubectl get services | awk 'NR ==2 {print $4;exist}')
echo "Your load balancer IP is $lb_ip"
