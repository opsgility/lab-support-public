#!/bin/bash
#Install LXDE lxde.org and xrdp - (make sure to open 3389 on the NSG of the azure vm)
apt-get update
apt-get install lxde -y
apt-get install xrdp -y
echo startlxde > ~/.xsession
/etc/init.d/xrdp start
#install docker which will then allow for running the az cli from an container
#to run the cli container open terminal and use sudo docker run -it azuresdk/azure-cli-python:latest
apt-get update
apt-get install -y docker.io
#installing visual studio code which can be launched from accessories
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sed -i 's/BIG-REQUESTS/_IG-REQUESTS/' /usr/lib/x86_64-linux-gnu/libxcb.so.1
apt-get update
apt-get install code