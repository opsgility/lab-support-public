#!/bin/bash

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password demo@pass123'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password demo@pass123'
sudo apt-get install -y lamp-server^
MYSQL=`which mysql`
Q1="CREATE DATABASE IF NOT EXISTS osticket;"
Q2="GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;"
Q3="CREATE USER 'osticket'@'%' IDENTIFIED BY 'demo@pass123';"
Q4="GRANT ALL PRIVILEGES ON *.* TO 'osticket'@'%' WITH GRANT OPTION;"
SQL="${Q1}${Q2}${Q3}${Q4}"
$MYSQL -u root --password=demo@pass123 -e "$SQL"
sudo wget https://raw.githubusercontent.com/opsgility/lab-support-public/master/linux-lift-shift/onprem/osticket.sql
sudo mysql -uosticket -pdemo@pass123  osticket < osticket.sql
sudo apt-get install unzip -y
sudo apt-get update -y
sudo wget https://github.com/opsgility/lab-support-public/raw/master/linux-lift-shift/onprem/osticket.zip
sudo unzip osticket.zip -d /var/www/html
sudo chown -R demouser:www-data /var/www/html
sudo mv /var/www/html/index.html /var/www/html/index.html.org
sudo systemctl restart apache2
