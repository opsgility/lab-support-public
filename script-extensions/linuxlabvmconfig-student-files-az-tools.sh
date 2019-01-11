export DEBIAN_FRONTEND=noninteractive
DOWNLOADURL=$1


apt-get update -y
apt-get upgrade -y

#Install LXDE lxde.org and xrdp - (make sure to open 3389 on the NSG of the azure vm)
apt-get install lxde -y
apt-get install xrdp -y
/etc/init.d/xrdp start

#Prepare XWindows System
sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config
wget https://opsgilityweb.blob.core.windows.net/test/xsession
mv xsession /home/demouser/.xsession


#avoid annoying popup
sudo apt-get remove clipit -y

if [ -z "${DOWNLOADURL}" ]; then
  echo "no download url for lab"
else
  apt-get install unzip -y
  echo "setting up student files"
  mkdir /usr/opsgilitytraining
  wget -P /usr/opsgilitytraining $DOWNLOADURL
  unzip /usr/opsgilitytraining/StudentFiles.zip -d /usr/opsgilitytraining
  chmod -R 775 /usr/opsgilitytraining
  chown -R demouser /usr/opsgilitytraining
fi


#installing visual studio code which can be launched from accessories
wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb

sudo add-apt-repository universe 
sudo apt-get install apt-transport-https -y

sudo apt-get update -y
sudo apt-get install dotnet-sdk-2.2 -y

sudo mkdir /usr/share/storageexplorer
sudo wget https://go.microsoft.com/fwlink/?LinkId=722418 -O /usr/share/storageexplorer/StorageExplorer.tar.gz
sudo tar -xvzf /usr/share/storageexplorer/StorageExplorer.tar.gz -C /usr/share/storageexplorer
sudo wget https://raw.githubusercontent.com/opsgility/lab-support-public/master/script-extensions/storageexplorer.desktop -O /usr/share/applications/storageexplorer.desktop
sudo chmod a+x /usr/share/applications/storageexplorer.desktop