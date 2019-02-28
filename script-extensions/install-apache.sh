#!/bin/bash
#install-apache.sh
apt-get update
apt-get -y install apache2 php7.0 libapache2-mod-php7.0
apt-get -y install php-mysql
sudo a2enmod php7.0
apachectl restart
