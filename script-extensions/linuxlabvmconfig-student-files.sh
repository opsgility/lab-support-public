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

#avoid annoying popup
sudo apt-get remove clipit -y

if [ -z "${DOWNLOADURL}" ]; then
  echo "no download url for lab"
else
  echo "setting up student files"
  mkdir /usr/opsgilitytraining
  wget -P /usr/opsgilitytraining $DOWNLOADURL
  tar -xvf /usr/opsgilitytraining/StudentFiles.zip -C /usr/opsgilitytraining
  chmod -R 775 /usr/opsgilitytraining
  chown -R demouser /usr/opsgilitytraining
fi
