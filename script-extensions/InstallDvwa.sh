# Custom Script for Linux
#!/bin/bash
sudo wget https://opsiaastraining.blob.core.windows.net/superhuman/DVWA.zip
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password p@ssw0rd'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password p@ssw0rd'
sudo apt-get install -y apache2 mysql-server php5 unzip php5-mysql php-pear*
sudo rm /var/www/html/index.html
sudo cp DVWA.zip /var/www/html
sudo unzip /var/www/html/DVWA.zip -d /var/www/html
sudo chmod -R 777 /var/www/html/DVWA/hackable/uploads/
sudo apache2ctl restart