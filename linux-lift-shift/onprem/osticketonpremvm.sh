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
sudo apt-get install unzip -y
sudo apt-get update -y
sudo wget https://github.com/osTicket/osTicket/releases/download/v1.10.1/osTicket-v1.10.1.zip
sudo unzip osTicket-v1.10.1.zip
sudo cp -rv ~/upload/* /var/www/html
sudo cp /var/www/html/include/ost-sampleconfig.php /var/www/html/include/ost-config.php
sudo chown -R demouser:www-data /var/www/html
mv /var/www/html/index.html /var/www/html/index.html.org
chmod 666 /var/www/html/include/ost-config.php
sudo systemctl restart apache2
