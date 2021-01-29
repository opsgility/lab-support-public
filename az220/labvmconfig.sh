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
