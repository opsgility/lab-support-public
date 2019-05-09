export DEBIAN_FRONTEND=noninteractive
apt-get update -y
apt-get update -y && sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get install curl python-software-properties -y
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
apt-get update -y && sudo apt install docker-ce nodejs mongodb-clients -y
apt-get upgrade -y
curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
npm install -g bower --config.interactive=false
usermod -aG docker $USER

