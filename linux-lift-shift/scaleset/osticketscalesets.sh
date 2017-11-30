#!/bin/bash
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password demo@pass123'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password demo@pass123'
sudo apt-get install -y lamp-server^
sudo apt-get install unzip -y
sudo apt-get update -y
sudo wget https://github.com/opsgility/lab-support-public/raw/master/linux-lift-shift/scaleset/osticket.zip
sudo unzip osticket.zip -d /var/www/html
sudo chown -R demouser:www-data /var/www/html
sudo mv /var/www/html/index.html /var/www/html/index.html.org
sudo systemctl restart apache2
