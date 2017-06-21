#Install LXDE lxde.org and xrdp - (make sure to open 3389 on the NSG of the azure vm)
apt-get update
apt-get install lxde -y
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
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"
apt-get update
apt-get install -y docker-ce

##download and install the Java JDK
#add-apt-repository ppa:webupd8team/java
#apt-get update
#echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | \
#    /usr/bin/debconf-set-selections
#apt-get install -y oracle-java8-installer
#apt-get install -y oracle-java8-set-default
#
##download and install maven
#apt-get update
#apt-get install -y maven

#download, extract, and create shorcut for Azure Storage Explorer
mkdir /usr/share/storageexplorer
wget https://go.microsoft.com/fwlink/?LinkId=722418 -O /usr/share/storageexplorer/StorageExplorer.tar.gz
tar -xvzf /usr/share/storageexplorer/StorageExplorer.tar.gz -C /usr/share/storageexplorer
wget https://raw.githubusercontent.com/opsgility/lab-support-public/master/script-extensions/storageexplorer.desktop -O /usr/share/applications/storageexplorer.desktop
chmod a+x /usr/share/applications/storageexplorer.desktop

#download and intsall DotNet Core 1.0.1 package source and keys (dependency of service fabric)
sh -c 'echo "deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/dotnet-release/ xenial main" > /etc/apt/sources.list.d/dotnetdev.list'
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 417A0893
apt-get update

#download and install Azure Service Fabric and DotNet Core tools
sh -c 'echo "deb [arch=amd64] http://apt-mo.trafficmanager.net/repos/servicefabric/ trusty main" > /etc/apt/sources.list.d/servicefabric.list'
apt-key adv --keyserver apt-mo.trafficmanager.net --recv-keys 417A0893
apt-get update
echo "servicefabric servicefabric/accepted-eula-v1 select true" | debconf-set-selections
echo "servicefabricsdkcommon servicefabricsdkcommon/accepted-eula-v1 select true" | debconf-set-selections
apt-get install -y servicefabricsdkcommon
/opt/microsoft/sdk/servicefabric/common/sdkcommonsetup.sh
/opt/microsoft/sdk/servicefabric/common/clustersetup/devclustersetup.sh
echo "servicefabricsdkjava servicefabricsdkjava/accepted-eula-v1 select true" | debconf-set-selections
apt-get install -y servicefabricsdkjava
/opt/microsoft/sdk/servicefabric/java/sdkjavasetup.sh
echo "servicefabricsdkcsharp servicefabricsdkcsharp/accepted-eula-v1 select true" | debconf-set-selections
apt-get install -y servicefabricsdkcsharp
/opt/microsoft/sdk/servicefabric/csharp/sdkcsharpsetup.sh

#download service fabric certificate helper scripts
mkdir /usr/share/SFScripts
git clone https://github.com/ChackDan/Service-Fabric.git /usr/share/SFScripts
#chmod a+x /usr/share/SFScripts/Scripts/CertUpload4Linux/cert_helper.py
#chmod a+x /usr/share/SFScripts/Scripts/CertUpload4Linux/servicefabric.py
chmod -R a+rwxX /usr/share/SFScripts/Scripts/CertUpload4Linux/

#install the legacy azure cli for use with the SSL python helper scripts
npm install azure-cli -g

#copy the student files to the VM
mkdir /usr/share/labfiles
wget https://opsbitly.blob.core.windows.net/public/LinuxSslTemplate.zip -O /usr/share/labfiles/LinuxSslTemplate.zip
unzip /usr/share/labfiles/LinuxSslTemplate.zip -d /usr/share/labfiles
chmod -R a+rwxX /usr/share/labfiles/

#clone the service-fabric-java-getting-started repo into the labfiles dir
git clone https://github.com/Azure-Samples/service-fabric-java-getting-started.git /usr/share/labfiles/java-Samples
chmod -R a+rwxX /usr/share/labfiles/

