export DEBIAN_FRONTEND=noninteractive
#Install LXDE lxde.org and vnc - (make sure to open 5901 on the NSG of the azure vm)
apt-get update 
apt-get install lxde -y
apt-get install -y lxde tightvncserver


#Install RDP (make sure to open 3389 on the NSG of the azure vm)
apt-get update 
apt-get install xrdp -y


#installing visual studio code which can be launched from accessories
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sed -i 's/BIG-REQUESTS/_IG-REQUESTS/' /usr/lib/x86_64-linux-gnu/libxcb.so.1
apt-get update
apt-get install code

#Prepare XWindows System
wget https://raw.githubusercontent.com/opsgility/lab-support-public/master/script-extensions/xsession
mv xsession /home/demouser/.xsession

#install the Azure CLI using instructions from Azure.com
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | \
     sudo tee /etc/apt/sources.list.d/azure-cli.list
apt-key adv --keyserver packages.microsoft.com --recv-keys 417A0893
apt-get install apt-transport-https -y
apt-get update && sudo apt-get install azure-cli -y

#install docker
#to run the az cli container open terminal and use 'sudo docker run -it azuresdk/azure-cli-python:latest'
apt-get update 
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"
apt-get update
apt-get install -y docker-ce

#download, extract, and create shorcut for Azure Storage Explorer
mkdir /usr/share/storageexplorer
wget https://go.microsoft.com/fwlink/?LinkId=722418 -O /usr/share/storageexplorer/StorageExplorer.tar.gz
tar -xvzf /usr/share/storageexplorer/StorageExplorer.tar.gz -C /usr/share/storageexplorer
wget https://raw.githubusercontent.com/opsgility/lab-support-public/master/script-extensions/storageexplorer.desktop -O /usr/share/applications/storageexplorer.desktop
chmod a+x /usr/share/applications/storageexplorer.desktop

apt-get update 
apt-get install expect -y

# Setup VNC 
#/usr/bin/expect <<EOF
#spawn su demouser -c "sudo /usr/bin/vncserver"
#expect "Password:"
#send "$1\r"
#expect "Verify:"
#send "$1\r"
#expect "(y/n?"
#send "n\r"
#expect eof
#EOF
#vncserver -kill :1

# Enable copy & paste
apt-get update 
apt-get install autocutsel -y
#autocutsel -fork

# Setup VNC start environment 
#wget https://raw.githubusercontent.com/opsgility/lab-support-public/master/script-extensions/xstartup
#mv xstartup /home/demouser/.vnc/xstartup
#chmod 0755 /home/demouser/.vnc/xstartup


# Setup VNC in the user's profile 
echo "/usr/bin/expect <<EOF" >> /home/demouser/.profile
echo "spawn vncserver" >> /home/demouser/.profile
echo "expect \"Password:\"" >> /home/demouser/.profile
echo "send \"$1\r\"" >> /home/demouser/.profile
echo "expect \"Verify:\"" >> /home/demouser/.profile
echo "send \"$1\r\"" >> /home/demouser/.profile
echo "expect \"(y/n?\"" >> /home/demouser/.profile
echo "send \"n\r\"" >> /home/demouser/.profile
echo "expect eof" >> /home/demouser/.profile
echo "EOF" >> /home/demouser/.profile
echo "rm /home/demouser/.vnc/xstartup" >> /home/demouser/.profile
echo "vncserver -kill :1" >> /home/demouser/.profile
echo "wget https://raw.githubusercontent.com/opsgility/lab-support-public/master/script-extensions/xstartup" >> /home/demouser/.profile
echo "mv xstartup /home/demouser/.vnc/xstartup" >> /home/demouser/.profile
echo "chmod 0755 /home/demouser/.vnc/xstartup" >> /home/demouser/.profile
echo "vncserver" >> /home/demouser/.profile
echo "autocutsel -fork" >> /home/demouser/.profile


