#!/bin/bash

# set -euo pipefail
IFS=$'\n\t'

declare AZURE_USERNAME=""
declare AZURE_PASSWORD=""
declare AZURE_SUBSCRIPTIONID=""
declare REGION_NAME="eastus"
declare -r GITRATINGSAPIURI="https://github.com/opsgility/challenge-aks-operations-ratings-api.git"
declare -r GITRATINGSAPIDIR="challenge-aks-operations-ratings-api"
declare -r GITRATINGSWEBURI="https://github.com/opsgility/challenge-aks-operations-ratings-web.git"
declare -r GITRATINGSWEBDIR="challenge-aks-operations-ratings-web"
declare -r MONGO_USER="demouser"
declare -r MONGO_PASSWORD="demopassword1"
declare -r MONGO_HOST="ratings-mongodb.default.svc.cluster.local"
declare -r GITRATINGSAPIYAMLDEPLOY="https://raw.githubusercontent.com/opsgility/lab-support-public/master/akschallenge/ratingsapp/ratings-api-deployment.yaml"
declare -r GITRATINGSAPIYAMLSERVICE="https://raw.githubusercontent.com/opsgility/lab-support-public/master/akschallenge/ratingsapp/ratings-api-service.yaml"
declare -r GITRATINGSWEBYAMLDEPLOY="https://raw.githubusercontent.com/opsgility/lab-support-public/master/akschallenge/ratingsapp/ratings-web-deployment.yaml"
declare -r GITRATINGSWEBYAMLSERVICE="https://raw.githubusercontent.com/opsgility/lab-support-public/master/akschallenge/ratingsapp/ratings-web-service.yaml"
declare -r USAGESTRING="Usage: deploy.sh -l <REGION_NAME> [-r <RESOURCE_GROUP> -u <USERNAME> -p <PASSWORD> -s <SUBSCRIPTIONID>]"

# Initialize parameters specified from command line
while getopts ":l:r:u:p:s:" arg; do
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
        s) # Process -s (SubscriptionId)
            AZURE_SUBSCRIPTIONID=${OPTARG} 
        ;;
        \?)
            echo "Invalid options found: -$OPTARG."
            echo $USAGESTRING 2>&1; exit 1; 
        ;;
    esac
done
shift $((OPTIND-1))

echo "Checking for programs..."
if ! [ -x "$(command -v az)" ]; then
    echo "az is not installed. Installing Azure CLI..."
    curl -sL https://aka.ms/InstallAzureCLIDeb | bash
fi 

if ! [ -x "$(command -v git)" ]; then
    echo "git is not installed. Installing git..."
    apt-get update && apt-get -y install git
fi

if ! [ -x "$(command -v helm)" ]; then
    echo "helm is not installed. Installing helm..."
    curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
fi

if ! [ -x "$(command -v kubectl)" ]; then
    echo "Error: kubectl is not installed. Installing kubectl..."
    apt-get update && apt-get install -y apt-transport-https gnupg2
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
    apt-get update && apt-get install -y kubectl
fi

if ! [ -x "$(command -v jq)" ]; then
    echo "Error: jq is not installed. Installing jq..."
    apt-get update && apt-get install -y jq
fi

if ! [ -x "$(command -v sed)" ]; then
  echo "Error: sed is not installed." 2>&1
  exit 1
fi

# Random suffix. Fix to 4 digits, avoids risk of ACR provisioning failure since ACR requires at least 5 digits in the resource name
CURRENT_RANDOM=$(($RANDOM%9000+1000))

RESOURCE_GROUP="akschallengeRG"
VNET_NAME="aks$CURRENT_RANDOM-vnet"
SUBNET_NAME="aks-subnet"
ACR_NAME="acr$CURRENT_RANDOM"
AKS_CLUSTER_NAME="aks$CURRENT_RANDOM"
COSMOS_NAME="cosmos$CURRENT_RANDOM"
RATINGS_WEB_DNS_NAME="ratingsweb$CURRENT_RANDOM"

EXPORTS="/etc/profile.d/lab-data.sh"

echo "RESOURCE_GROUP: ${RESOURCE_GROUP}"
echo "VNET_NAME: ${VNET_NAME}"
echo "SUBNET_NAME: ${SUBNET_NAME}"
echo "ACR_NAME: ${ACR_NAME}"
echo "AKS_CLUSTER_NAME: ${AKS_CLUSTER_NAME}"
echo "COSMOS_NAME: ${COSMOS_NAME}"
echo "RATINGS_WEB_DNS_NAME: ${RATINGS_WEB_DNS_NAME}"

# Accommodate Cloud Sandbox startup
if [ ${#AZURE_USERNAME} -gt 0 ] && [ ${#AZURE_PASSWORD} -gt 0 ]; then
    echo "Authenticating to Azure with username and password..."
    echo "AZURE_USERNAME: ${AZURE_USERNAME}"
    echo "AZURE_PASSWORD: ${AZURE_PASSWORD}"
    echo "AZURE_SUBSCRIPTIONID: ${AZURE_SUBSCRIPTIONID}"

    az login --username $AZURE_USERNAME --password $AZURE_PASSWORD

    echo "Setting account..."
    az account set -s $AZURE_SUBSCRIPTIONID

    # Persist UN/PW for use by validation scripts
    # Escape ' character if present in password
    PWD_EXPORT=$(echo $AZURE_PASSWORD | sed -r "s/'/'\\\''/g")
    echo "export AZURE_USERNAME=$AZURE_USERNAME" > $EXPORTS
    echo "export AZURE_PASSWORD='$PWD_EXPORT'" >> $EXPORTS
    echo "export AZURE_SUBSCRIPTIONID=$AZURE_SUBSCRIPTIONID" >> $EXPORTS
fi

echo "export AKS_CLUSTER_NAME=$AKS_CLUSTER_NAME" >> $EXPORTS
echo "export RESOURCE_GROUP=$RESOURCE_GROUP" >> $EXPORTS

# Register resource providers
az provider register --namespace 'Microsoft.ContainerRegistry'
az provider register --namespace 'Microsoft.ContainerService'
az provider register --namespace 'Microsoft.ContainerInstance'
az provider register --namespace 'Microsoft.DocumentDB'

RGEXISTS=$(az group show --name $RESOURCE_GROUP --query name)
if [ ${#RGEXISTS} -eq 0 ]; then
    echo "Resource group $RESOURCE_GROUP was not found. Creating resource group..."
    echo "Creating resource group $RESOURCE_GROUP in location $REGION_NAME"

    az group create --name $RESOURCE_GROUP --location $REGION_NAME
else
    echo "Using existing resource group $RESOURCE_GROUP."
fi

echo "Creating VNET ${VNET_NAME}..."
az network vnet create \
    --resource-group $RESOURCE_GROUP \
    --location $REGION_NAME \
    --name $VNET_NAME \
    --address-prefixes 10.0.0.0/8 \
    --subnet-name $SUBNET_NAME \
    --subnet-prefix 10.240.0.0/16

echo "Retrieving subnet ID..."
SUBNET_ID=$(az network vnet subnet show \
    --resource-group $RESOURCE_GROUP \
    --vnet-name $VNET_NAME \
    --name $SUBNET_NAME \
    --query id -o tsv)
echo "SUBNET_ID: $SUBNET_ID"

echo "Determining AKS version..."
VERSION=$(az aks get-versions \
    --location $REGION_NAME \
    --query 'orchestrators[?!isPreview] | [-1].orchestratorVersion' \
    --output tsv)
echo "VERSION: $VERSION"

SPNAME="${AKS_CLUSTER_NAME}_sp"
echo "Creating service principal $SPNAME"

# Add check for az aks create not URI encoding certain characters correctly
CLIENTSECRETVALID=""
while [ -z $CLIENTSECRETVALID ]; do
  echo "Creating new SP and secret..."
  CLIENTSECRET=$(az ad sp create-for-rbac --skip-assignment -n $SPNAME -o json | jq -r .password)
  if [[ $CLIENTSECRET == *"'"* ]]; then
    echo "Found invalid character. Recreating..."
    CLIENTSECRETVALID=""
  elif [[ $CLIENTSECRET == *"\`"* ]]; then
    echo "Found invalid character. Recreating..."
    CLIENTSECRETVALID=""
  else
    echo "Appears valid..."
    CLIENTSECRETVALID="true"
  fi
done
echo "CLIENTSECRET ready: ${CLIENTSECRET}"

SPID=$(az ad sp show --id "http://$SPNAME" -o json | jq -r .appId)
echo "CLIENTSECRET: ${CLIENTSECRET}"
echo "SPID: ${SPID}"

echo "Sleeping for two minutes while SP propagates..."
sleep 120

echo "Creating AKS cluster $AKS_CLUSTER_NAME with verion ${VERSION}..."
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
    --generate-ssh-keys \
    --service-principal "${SPID}" \
    --node-vm-size Standard_DS2_V2 \
    --client-secret "${CLIENTSECRET}"

echo "Get AKS credentials..."
az aks get-credentials \
    --resource-group $RESOURCE_GROUP \
    --name $AKS_CLUSTER_NAME \
    --overwrite-existing

# Check for Cloud Shell
# If not in Cloud Shell we're running in the CSE
if [[ ! -d ~/clouddrive ]]; then 
    # creds stored in $HOME/.kube/config
    # e.g. /root/.kube/config
    echo "Export KUBECONFIG..."
    echo "Current KUBECONFIG: $KUBECONFIG"
    export KUBECONFIG="/$(whoami)/.kube/config"
    KUBECONFIG="/$(whoami)/.kube/config"
    echo "New KUBECONFIG: $KUBECONFIG" 
fi

echo "Get AKS nodes..."
kubectl get nodes 2>&1

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

echo "Update AKS and grant access to ACR..."
az aks update \
    --name $AKS_CLUSTER_NAME \
    --resource-group $RESOURCE_GROUP \
    --attach-acr $ACR_NAME

echo "Deploying Cosmos DB for Mongo..."
az cosmosdb create \
    --name $COSMOS_NAME \
    --resource-group $RESOURCE_GROUP \
    --kind MongoDB

COSMOS_KEY=$(az cosmosdb keys list --type connection-strings --name $COSMOS_NAME --resource-group $RESOURCE_GROUP --query "connectionStrings[0].connectionString" -o tsv | sed -r "s/\?/ratingsdb\?/g")
echo "COSMOS_KEY: ${COSMOS_KEY}"

echo "Creating mongosecret..."
kubectl create secret generic mongosecret \
    --from-literal=MONGOCONNECTION="${COSMOS_KEY}"

echo "Describe secret..."
kubectl describe secret mongosecret

echo "Change to $TEMPDIRNAME..."
cd $FULLTEMPDIRPATH

echo "Downloading YAML defintions..."
wget $GITRATINGSAPIYAMLDEPLOY
wget $GITRATINGSAPIYAMLSERVICE
wget $GITRATINGSWEBYAMLDEPLOY
wget $GITRATINGSWEBYAMLSERVICE

echo "Update ACR_NAME in ratings-api-deployment.yaml..."
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

echo "Update ACR_NAME in ratings-web-deployment.yaml..."
sed -i "s/ACR_NAME/${ACR_NAME}/g" ratings-web-deployment.yaml

echo "Deploying ratings-web..."
kubectl apply \
    -f ratings-web-deployment.yaml

echo "Sleeping for 1 minute..."
sleep 60

kubectl get deployment ratings-web

echo "Update RATINGS_WEB_DNS_NAME in ratings-web-service.yaml..."
sed -i "s/RATINGS_WEB_DNS_NAME/${RATINGS_WEB_DNS_NAME}/g" ratings-web-service.yaml

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

# Create the users and groups that will be used in the challenge
echo "Creating users (and getting ID of lab user)"
DOMAIN=$(az ad signed-in-user show --query userPrincipalName -o tsv  | sed -r "s/.*@//g")
USER1_ID=$(az ad user create --display-name "demo user 1" --password "demo@pass123" --user-principal-name "demouser1@$DOMAIN" --query objectId -o tsv)
USER2_ID=$(az ad user create --display-name "demo user 2" --password "demo@pass123" --user-principal-name "demouser2@$DOMAIN" --query objectId -o tsv)
ADMIN_USER_ID=$(az ad signed-in-user show --query "objectId" -o tsv)

echo "Creating groups"
GROUP1_ID=$(az ad group create --display-name "Fruit Smashers Smooth Devs" --mail-nickname "smoothdevs" --query "objectId" -o tsv) 
GROUP2_ID=$(az ad group create --display-name "Fruit Smashers Better Devs" --mail-nickname "betterdevs" --query "objectId" -o tsv) 
ADMIN_GROUP_ID=$(az ad group create --display-name "AKS Admin Group" --mail-nickname "aksadmin" --query "objectId" -o tsv) 

echo "Assigning users to groups"
az ad group member add --group $GROUP1_ID --member-id $USER1_ID
az ad group member add --group $GROUP2_ID --member-id $USER2_ID
az ad group member add --group $ADMIN_GROUP_ID --member-id $ADMIN_USER_ID

echo "Deployment complete!"