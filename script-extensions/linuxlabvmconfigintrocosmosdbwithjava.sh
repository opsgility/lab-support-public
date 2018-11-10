export DEBIAN_FRONTEND=noninteractive
#Install LXDE lxde.org and xrdp - (make sure to open 3389 on the NSG of the azure vm)
apt-get update
# install LXDE
apt-get install lxde -y

# update apt repo source to be able to get latest XRDP version
add-apt-repository ppa:hermlnx/xrdp -y

# install XRDP
apt-get update
apt-get install xrdp -y
/etc/init.d/xrdp start


#installing visual studio code which can be launched from accessories
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sed -i 's/BIG-REQUESTS/_IG-REQUESTS/' /usr/lib/x86_64-linux-gnu/libxcb.so.1
apt-get update
apt-get install code

#Prepare XWindows System
wget https://opsgilityweb.blob.core.windows.net/test/xsession
mv xsession /home/demouser/.xsession

#install the Azure CLI using instructions from Azure.com
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | \
     sudo tee /etc/apt/sources.list.d/azure-cli.list
apt-key adv --keyserver packages.microsoft.com --recv-keys 417A0893
apt-get install apt-transport-https -y
apt-get update && sudo apt-get install azure-cli -y

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

#download and install the Java JDK
add-apt-repository ppa:webupd8team/java
apt-get update
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | \
    /usr/bin/debconf-set-selections
apt-get install -y oracle-java8-installer
apt-get install -y oracle-java8-set-default

#download and install maven
apt-get update
apt-get install -y maven

#install NetBeans
apt-get update
apt-get install netbeans -y
#add NetBeans to accessories menu
wget https://raw.githubusercontent.com/opsgility/lab-support-public/master/script-extensions/netbeans.desktop -O /usr/share/applications/netbeans.desktop
chmod a+x /usr/share/applications/netbeans.desktop

#install .net 2.0 to properly support storage explorer, the below actually just installs the whole .NET SDK which includes the runtime
wget -q https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt-get update
sudo apt-get install dotnet-hosting-2.0.9 -y

#download, extract, and create shorcut for Azure Storage Explorer
mkdir /usr/share/storageexplorer
wget https://go.microsoft.com/fwlink/?LinkId=722418 -O /usr/share/storageexplorer/StorageExplorer.tar.gz
tar -xvzf /usr/share/storageexplorer/StorageExplorer.tar.gz -C /usr/share/storageexplorer
wget https://raw.githubusercontent.com/opsgility/lab-support-public/master/script-extensions/storageexplorer.desktop -O /usr/share/applications/storageexplorer.desktop
chmod a+x /usr/share/applications/storageexplorer.desktop

#copy the student files to the VM
mkdir /usr/share/labfiles
wget http://opsgilitylabs.blob.core.windows.net/online-labs/introduction-to-azure-cosmosdb-sql-api-using-java/StudentFiles.zip -O /usr/share/labfiles/StudentFiles.zip
#extract the .zip files into directories
unzip /usr/share/labfiles/StudentFiles.zip -d /usr/share/labfiles
#clean up .zip files
rm /usr/share/labfiles/StudentFiles.zip
#set permissions on the labfiles directory
chmod -R a+rwxX /usr/share/labfiles/