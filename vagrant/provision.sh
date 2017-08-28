#!/bin/bash

# Variables
DBHOST=localhost
DBNAME=vagrant
DBUSER=vagrant
DBPASSWD=test123

# Update packages
apt-get update
echo "Updated Packages"

# Install Node JS
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
apt-get install -y nodejs
echo "Installed Node JS"

# Install NPM packages
npm install -g nodemon
echo "Installed Nodemon"

# Install MySQL
debconf-set-selections <<< "mysql-server mysql-server/root_password password $DBPASSWD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $DBPASSWD"
apt-get install -y mysql-server
mysql -uroot -p$DBPASSWD -e "CREATE DATABASE $DBNAME"
mysql -uroot -p$DBPASSWD -e "CREATE USER '$DBUSER'@'localhost' IDENTIFIED BY '$DBPASSWD'"
mysql -uroot -p$DBPASSWD -e "GRANT ALL PRIVILEGES ON $DBNAME.* TO '$DBUSER'@'localhost'"
mysql -uroot -p$DBPASSWD -e "CREATE USER '$DBUSER'@'10.0.2.2' IDENTIFIED BY '$DBPASSWD'"
mysql -uroot -p$DBPASSWD -e "GRANT ALL PRIVILEGES ON $DBNAME.* TO '$DBUSER'@'10.0.2.2'"
sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/my.cnf
service mysql restart
echo "Installed MySQL"

# Install Nginx
apt-get install -y nginx
cp /home/vagrant/www/vagrant/nginx /etc/nginx/sites-available/default
service nginx restart
echo "Installed Nginx"

echo "All done"
echo "Node version: " `node -v`
echo "NPM version: " `npm -v`
echo "MySQL Version: " `mysql --version`
echo "Nginx Version: " `nginx -v`