#!/bin/bash

# set -euo pipefail
IFS=$'\n\t'

declare -r GITRATINGSAPIURI="https://github.com/MicrosoftDocs/mslearn-aks-workshop-ratings-api.git"
declare -r GITRATINGSAPIDIR="mslearn-aks-workshop-ratings-api"
declare -r GITRATINGSWEBURI="https://github.com/MicrosoftDocs/mslearn-aks-workshop-ratings-web.git"
declare -r GITRATINGSWEBDIR="mslearn-aks-workshop-ratings-web"
declare -r MONGO_USER="demouser"
declare -r MONGO_PASSWORD="demopassword1"
declare -r MONGO_HOST="ratings-mongodb.svc.cluster.local"

declare -r USAGESTRING="Usage: deploy.sh -l <REGION_NAME> [-r <RESOURCE_GROUP> -u <USERNAME> -p <PASSWORD>]"

CURRENT_RANDOM=$RANDOM

REGION_NAME="eastus"
RESOURCE_GROUP="akschallenge$CURRENT_RANDOM"
SUBNET_NAME="aks-subnet"
VNET_NAME="aks-vnet"
ACR_NAME="acr$CURRENT_RANDOM"

# Initialize parameters specified from command line
while getopts ":l:r:" arg; do
    case "${arg}" in
        l) # Process -l (Location)
            REGION_NAME=${OPTARG}
        ;;
        r) # Process -s (Suffix)
            RESOURCE_GROUP=${OPTARG}
        ;;
        u) # Process -u (Username)
            AZURE_USERNAME=${OPTARG}
        ;;
        p) # Process -p (Password)
            AZURE_PASSWORD=${OPTARG} 
        ;;
        \?)
            echo "Invalid options found: -$OPTARG."
            echo $USAGESTRING 2>&1; exit 1; 
        ;;
    esac
done
shift $((OPTIND-1))

# Check for programs
if ! [ -x "$(command -v az)" ]; then
  echo "Error: az is not installed." 2>&1
  exit 1
elif ! [ -x "$(command -v git)" ]; then
  echo "Error: git is not installed." 2>&1
  exit 1
elif ! [ -x "$(command -v helm)" ]; then
  echo "Error: git is not installed." 2>&1
  exit 1
elif ! [ -x "$(command -v sed)" ]; then
  echo "Error: git is not installed." 2>&1
  exit 1
fi

# Accommodate Cloud Sandbox startup
if [ ${#AZURE_USERNAME} -gt 0 ] && [ ${#AZURE_PASSWORD} -gt 0 ]; then
    echo "Authenticating to Azure with username and password..."
    az login --username $AZURE_USERNAME --password $AZURE_PASSWORD
fi

RGEXISTS=$(az group show --name $RESOURCE_GROUP --query name)
if [ ${#RGEXISTS} -eq 0 ]; then
    echo "Resource group $RESOURCE_GROUP was not found. Creating resource group..."
    echo "Creating resource group $RESOURCE_GROUP in location $REGION_NAME"

    az group create --name $RESOURCE_GROUP --location $REGION_NAME
else
    echo "Using existing resource group $RESOURCE_GROUP."
fi

az network vnet create \
    --resource-group $RESOURCE_GROUP \
    --location $REGION_NAME \
    --name $VNET_NAME \
    --address-prefixes 10.0.0.0/8 \
    --subnet-name $SUBNET_NAME \
    --subnet-prefix 10.240.0.0/16

SUBNET_ID=$(az network vnet subnet show \
    --resource-group $RESOURCE_GROUP \
    --vnet-name $VNET_NAME \
    --name $SUBNET_NAME \
    --query id -o tsv)

VERSION=$(az aks get-versions \
    --location $REGION_NAME \
    --query 'orchestrators[?!isPreview] | [-1].orchestratorVersion' \
    --output tsv)

AKS_CLUSTER_NAME="akschallenge$CURRENT_RANDOM"
echo $AKS_CLUSTER_NAME

echo "Creating AKS cluster $AKS_CLUSTER_NAME..."
az aks create \
    --resource-group $RESOURCE_GROUP \
    --name $AKS_CLUSTER_NAME \
    --vm-set-type VirtualMachineScaleSets \
    --load-balancer-sku standard \
    --location $REGION_NAME \
    --kubernetes-version $VERSION \
    --network-plugin azure \
    --vnet-subnet-id $SUBNET_ID \
    --service-cidr 10.2.0.0/24 \
    --dns-service-ip 10.2.0.10 \
    --docker-bridge-address 172.17.0.1/16 \
    --generate-ssh-keys

az aks get-credentials \
    --resource-group $RESOURCE_GROUP \
    --name $AKS_CLUSTER_NAME

ACR_NAME="acr$CURRENT_RANDOM"

echo "Creating ACR $ACR_NAME..."
az acr create \
    --resource-group $RESOURCE_GROUP \
    --location $REGION_NAME \
    --name $ACR_NAME \
    --sku Standard

# Make a temporary path for cloning from the existing git repos
TEMPDIRNAME="temp$CURRENT_RANDOM"

echo "Creating temporary directory $TEMPDIRNAME..."
mkdir $TEMPDIRNAME

FULLTEMPDIRPATH="$PWD/$TEMPDIRNAME"
FULLCURRENTPATH=$PWD

echo "Full tempoary directory is $FULLTEMPDIRPATH..."
cd $FULLTEMPDIRPATH

git clone $GITRATINGSAPIURI

cd $GITRATINGSAPIDIR

az acr build \
    --registry $ACR_NAME \
    --image ratings-api:v1 .

cd $FULLTEMPDIRPATH

git clone $GITRATINGSWEBURI

cd $GITRATINGSWEBDIR

az acr build \
    --registry $ACR_NAME \
    --image ratings-web:v1 .

cd $FULLCURRENTPATH

echo "Containers built in ACR..."
az acr repository list \
    --name $ACR_NAME \
    --output table

az aks update \
    --name $AKS_CLUSTER_NAME \
    --resource-group $RESOURCE_GROUP \
    --attach-acr $ACR_NAME

echo "Deploying MongoDB..."
helm repo add bitnami https://charts.bitnami.com/bitnami

helm search repo bitnami

helm install ratings bitnami/mongodb \
    --set mongodbUsername=$MONGO_USER,mongodbPassword=$MONGO_PASSWORD,mongodbDatabase=ratingsdb

kubectl create secret generic mongosecret \
    --from-literal=MONGOCONNECTION="mongodb://${MONGO_USER}:${MONGO_PASSWORD}@${MONGO_HOST}:27017/ratingsdb"

kubectl describe secret mongosecret

sed -i "s/ACR_NAME/${ACR_NAME}/g" ratings-api-deployment.yaml

echo "Deploying ratings-api..."
kubectl apply \
    -f ratings-api-deployment.yaml

echo "Sleeping for 1 minute..."
sleep 60

kubectl get deployment ratings-api

echo "Deploying ratings-api service..."
kubectl apply \
    -f ratings-api-service.yaml

kubectl get endpoints ratings-api

sed -i "s/ACR_NAME/${ACR_NAME}/g" ratings-web-deployment.yaml

echo "Deploying ratings-web..."
kubectl apply \
    -f ratings-web-deployment.yaml

echo "Sleeping for 1 minute..."
sleep 60

kubectl get deployment ratings-web

echo "Deploying ratings-web service..."
kubectl apply \
    -f ratings-web-service.yaml

external_ip=""
while [ -z $external_ip ]; do
  echo "Waiting for endpoint..."
  external_ip=$(kubectl get svc "ratings-web" --template="{{range .status.loadBalancer.ingress}}{{.ip}}{{end}}")
  [ -z "$external_ip" ] && sleep 10
done
echo "Endpoint ready: ${external_ip}"

echo "Deployment complete!"