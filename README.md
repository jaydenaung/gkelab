# Set up GKE Cluster in 15 minutes
Here is a couple of scripts that automate creating of Kubernetes cluster (GKE) on Google Cloud Platform. You will need to have an account on Google Cloud Platform and should have created a project. 

 1. [gke_setup.sh](#gke_setup.sh) 
 2. [cleanup_cluster.sh](#cleanup_cluster.sh)

### gke_setup.sh

This is the script that builds GKE cluster. The script will create deployments, and services as well.

Before executing the script, please update the following values:

 ``` bash
 #UPDATE THIS with your GCP Project Name
PROJECT_ID="YOUR_PROJECT_NAME"

 #UPDATE THIS with Docker image
IMAGE="gcr.io/$PROJECT_ID/your-docker-image:v1"
 ```
 And basically execute the script:

 ```bash
 ./gke_setup.sh
 ```

 ### Sample Output

 ```bash
$ ./gke_setup.sh 
Enter Your Cluster Name: 
Enter App Name (e.g. cyberave-io): 
Enter GCP Region (e.g. asia-southeast1): 
Enter Your Service Name (e.g. my-service): 
Creating Cluster on GCP in 
WARNING: Warning: basic authentication is deprecated, and will be removed in GKE control plane versions 1.19 and newer. For a list of recommended authentication methods, see: https://cloud.google.com/kubernetes-engine/docs/how-to/api-server-authentication
WARNING: Currently VPC-native is not the default mode during cluster creation. In the future, this will become the default mode and can be disabled using `--no-enable-ip-alias` flag. Use `--[no-]enable-ip-alias` flag to suppress this warning.
WARNING: Newly created clusters and node-pools will have node auto-upgrade enabled by default. This can be disabled using the `--no-enable-autoupgrade` flag.
WARNING: Starting with version 1.18, clusters will have shielded GKE nodes by default.
WARNING: Your Pod address range (`--cluster-ipv4-cidr`) can accommodate at most 1008 node(s). 
Creating cluster chkp in asia-southeast1... Cluster is being health-checked (master is healthy)...done.                                                     
Created [https://container.googleapis.com/v1/projects/helloworld041019/zones/asia-southeast1/clusters/chkp].
To inspect the contents of your cluster, go to: https://console.cloud.google.com/kubernetes/workload_/gcloud/asia-southeast1/chkp?project=helloworld041019
kubeconfig entry generated for chkp.
NAME  LOCATION         MASTER_VERSION   MASTER_IP      MACHINE_TYPE   NODE_VERSION     NUM_NODES  STATUS
chkp  asia-southeast1  1.16.13-gke.401  1.2.3.4  n1-standard-1  1.16.13-gke.401  6          RUNNING
chkp has been created.
Creating deployment..
deployment.apps/cyberave-io created
Scaling deployment to 3 replicas..
deployment.apps/cyberave-io scaled
Configuring autoscaling for the deployment..
horizontalpodautoscaler.autoscaling/cyberave-io autoscaled
Exposing your app via a load balancer..
service/cyberave-svc exposed
Your Kubernetes cluster has been created!
Your load balancer IP is 1.2.3.4

 ```

### cleanup_cluster.sh

This is the script that deletes and cleans up GKE clusters. The script will delete deployments, and services before deleting the cluster itself.

Execute the script:

```bash
./cleanup_cluster.sh
```

### Sample Output

> When it asks whether you want to ***Continue***, Enter "Y".

```bash
$ ./cleanup_k8s.sh 
Now we are gonna do a clean up!
You have a service called cyberave-svc
Now we are gonna delete cyberave-svc ..
service "cyberave-svc" deleted
cyberave-svc has been deleted..
You have a deployment called cyberave-io ..
Now we are gonna delete cyberave-io
deployment.apps "cyberave-io" deleted
cyberave-io has bee deleted..
Now we are gonna delete the GKE clusters..
You have a GKE cluster called chkp..
Now we are gonna delete chkp..
The following clusters will be deleted.
 - [chkp] in [asia-southeast1]

Do you want to continue (Y/n)?  y

Deleting cluster chkp...done.                                                                                                                               
Deleted [https://container.googleapis.com/v1/projects/helloworld041019/zones/asia-southeast1/clusters/chkp].
Clean-up has been completed..

```

Thanks.

Happy DevSecOps-ing,\
Jayden Aung
