export DEBIAN_FRONTEND=noninteractive

#install docker
#to run the az cli container open terminal and use 'sudo docker run -it azuresdk/azure-cli-python:latest'
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"
apt-get update
apt-get install -y docker-ce


#position the files
mkdir StudentFiles
cd StudentFiles
#Get the student files
wget --no-check-certificate --content-disposition https://github.com/opsgilitybrian/AZ-220-Microsoft-Azure-IoT-Developer/blob/master/Allfiles/Labs/13-Develop%2C%20Deploy%20and%20debug%20a%20custom%20module%20on%20Azure%20IoT%20Edge%20with%20VS%20Code/Setup/lab13-setup.azcli
