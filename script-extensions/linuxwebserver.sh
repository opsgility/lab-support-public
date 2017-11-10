export DEBIAN_FRONTEND=noninteractive
#Install LXDE lxde.org and xrdp - (make sure to open 3389 on the NSG of the azure vm)
apt-get update -y
apt-get install apache2 -y