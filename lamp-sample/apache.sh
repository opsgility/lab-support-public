#!/bin/bash

apt-get update
apt-get -y install apache2 php7.0 libapache2-mod-php7.0
apt-get -y install php-mysql
sudo a2enmod php7.0

echo \<center\>\<h1\>My Demo App on `hostname` \</h1\>\<br/\>\</center\> | tee -a /var/www/html/demoapp.php

echo \<\?php | tee -a /var/www/html/demoapp.php
echo \$servername \= \"mysqlvm\"\;  | tee -a /var/www/html/demoapp.php
echo \$username \= \"root\"\;  | tee -a /var/www/html/demoapp.php
echo \$password \= \"mySQLPassw0rd\"\;  | tee -a /var/www/html/demoapp.php
echo try \{  | tee -a /var/www/html/demoapp.php
echo     \$conn \= new PDO\(\"mysql\:host\=\$servername\;dbname\=myDB\"\, \$username\, \$password\)\;  | tee -a /var/www/html/demoapp.php
echo     \$conn\-\>setAttribute\(PDO\:\:ATTR_ERRMODE\, PDO\:\:ERRMODE_EXCEPTION\)\;  | tee -a /var/www/html/demoapp.php
echo    "echo \"Connected successfully\";"  | tee -a /var/www/html/demoapp.php
echo     \}  | tee -a /var/www/html/demoapp.php
echo catch\(PDOException \$e\)  | tee -a /var/www/html/demoapp.php
echo     \{  | tee -a /var/www/html/demoapp.php
echo     "echo \"Connection failed: \" . \$e->getMessage();"  | tee -a /var/www/html/demoapp.php
echo     \}  | tee -a /var/www/html/demoapp.php
echo \?\>  | tee -a /var/www/html/demoapp.php

# restart Apache

apachectl restart
