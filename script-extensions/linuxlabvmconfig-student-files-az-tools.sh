export DEBIAN_FRONTEND=noninteractive
DOWNLOADURL=$1

sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu/ bionic main restricted"
sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu/ bionic-updates main restricted"
sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu/ bionic universe"
sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu/ bionic-updates universe"
#sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu/ bionic multiverse"
#sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu/ bionic-updates multiverse"
#sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu/ bionic-backports main restricted universe multiverse"
#sudo add-apt-repository "deb http://security.ubuntu.com/ubuntu bionic-security main restricted"
#sudo add-apt-repository "deb http://security.ubuntu.com/ubuntu bionic-security universe"
#sudo add-apt-repository "deb http://security.ubuntu.com/ubuntu bionic-security multiverse"
apt-get update

#Install LXDE lxde.org and xrdp - (make sure to open 3389 on the NSG of the azure vm)
apt-get install lxde -y
apt-get install xrdp -y
/etc/init.d/xrdp start

#Prepare XWindows System
sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config
wget https://opsgilityweb.blob.core.windows.net/test/xsession
mv xsession /home/demouser/.xsession

apt-get install zip unzip -y

#avoid annoying popup
sudo apt-get remove clipit -y

if [ -z "${DOWNLOADURL}" ]; then
  echo "no download url for lab"
else
  echo "setting up student files"
  mkdir /usr/opsgilitytraining
  wget -P /usr/opsgilitytraining $DOWNLOADURL
  unzip /usr/opsgilitytraining/StudentFiles.zip -d /usr/opsgilitytraining
  chmod -R 775 /usr/opsgilitytraining
  chown -R demouser /usr/opsgilitytraining
fi


#installing visual studio code which can be launched from accessories
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sed -i 's/BIG-REQUESTS/_IG-REQUESTS/' /usr/lib/x86_64-linux-gnu/libxcb.so.1
apt-get update
apt-get install code

#download, extract, and create shorcut for Azure Storage Explorer
mkdir /usr/share/storageexplorer
wget https://go.microsoft.com/fwlink/?LinkId=722418 -O /usr/share/storageexplorer/StorageExplorer.tar.gz
tar -xvzf /usr/share/storageexplorer/StorageExplorer.tar.gz -C /usr/share/storageexplorer
wget https://raw.githubusercontent.com/opsgility/lab-support-public/master/script-extensions/storageexplorer.desktop -O /usr/share/applications/storageexplorer.desktop
chmod a+x /usr/share/applications/storageexplorer.desktop