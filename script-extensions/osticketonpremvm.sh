sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password demo@pass123'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password demo@pass123'
sudo apt-get install -y lamp-server^
sudo apt-get install unzip -y
sudo apt-get update -y
sudo wget https://github.com/osTicket/osTicket/releases/download/v1.10.1/osTicket-v1.10.1.zip
sudo unzip osTicket-v1.10.1.zip
sudo mkdir /var/www/html/support
sudo cp -rv ~/upload/* /var/www/html/support
sudo cp /var/www/html/support/include/ost-sampleconfig.php /var/www/html/support/include/ost-config.php
sudo chown -R demouser:www-data /var/www/html
chmod 666 /var/www/html/support/include/ost-config.php
