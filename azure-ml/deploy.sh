export DEBIAN_FRONTEND=noninteractive
AZUREUSERNAME=$1
AZUREPASSWORD=$2
SUBID=$3
LOCATION=$4
RGNAME="azureml"
WORKSPACE="AMLWorkspace"

apt-get update -y
apt-get upgrade -y

apt-get install ca-certificates curl apt-transport-https lsb-release gnupg

curl -sL https://packages.microsoft.com/keys/microsoft.asc | 
    gpg --dearmor | 
    tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null

AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | 
    tee /etc/apt/sources.list.d/azure-cli.list

apt-get update -y

apt-get install azure-cli -y

apt-get update -y


az login -u $AZUREUSERNAME -p $AZUREPASSWORD

az extension add -n azure-cli-ml -y
sleep 180
az extension update -n azure-cli-ml

sleep 180

az extension list

az group create -n $RGNAME -l $LOCATION

az ml workspace create -w $WORKSPACE -g $rgname

az ml computetarget create amlcompute -n cpu --min-nodes 1 --max-nodes 2 -s STANDARD_D2S_V3
