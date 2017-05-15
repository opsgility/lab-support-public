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

apt-get install default-jre -y 
apt-get install default-jdk -y
apt-get install nodejs -y
groupadd tomcat
useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat
cd /tmp
curl -O http://apache.mirrors.ionfish.org/tomcat/tomcat-8/v8.5.5/bin/apache-tomcat-8.5.5.tar.gz
mkdir /opt/tomcat
tar xzvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1
cd /opt/tomcat
chgrp -R tomcat /opt/tomcat
chmod -R g+r conf
chmod g+x conf
chown -R tomcat webapps/ work/ temp/ logs/

apt-get install maven

curl -o https://www.eclipse.org/downloads/download.php?file=/oomph/epp/neon/R3/eclipse-inst-linux64.tar.gz

tar –xvf eclipse-inst-linux64.tar.gz -C /opt

cat > /home/demouser/Desktop/eclipse.desktop << EOF
[Desktop Entry]
Name=Eclipse
Type=Application
Exec=/opt/eclipse/eclipse
Terminal=false
Icon=/opt/eclipse/icon.xpm
Comment=Integrated Development Environment
NoDisplay=false
Categories=Development;IDE;
Name[en]=eclipse.desktop
EOF
cat /home/demouser/Desktop/eclipse.desktop

