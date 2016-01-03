#!/bin/bash

# temp. start mysql to do all the install stuff
/usr/bin/mysqld_safe > /dev/null 2>&1 &

# ensure mysql is running properly
sleep 20 

# install pimcore if needed
if [ ! -d /var/www/pimcore ]; then
  # download & extract
  cd /var/www
  rm -r /var/www/*
  sudo -u www-data wget https://www.pimcore.org/download/pimcore-build.zip -O /tmp/pimcore.zip 
  sudo -u www-data unzip /tmp/pimcore.zip -d /var/www/
  rm /tmp/pimcore.zip 
  
  # create demo mysql user
  mysql -u root -e "CREATE DATABASE pimcore_dev charset=utf8;"
  mysql -u root -e "CREATE USER 'pimcore_dev'@'%' IDENTIFIED BY 'pimcore_dev_password';"
  mysql -u root -e "GRANT ALL PRIVILEGES ON pimcore_dev.* TO 'pimcore_dev'@'%';"
  
  sudo -u www-data cp /tmp/system.xml /var/www/website/var/config/system.xml
  sudo -u www-data cp /tmp/cache.xml /var/www/website/var/config/cache.xml
  
  ##wait a few seconds to ensure files are copied
  sleep 5
  
  ##run the php cli installer and delete
  sudo -u www-data cp /tmp/cli-install.php /var/www/pimcore/cli/cli-install.php
  sudo php /var/www/pimcore/cli/cli-install.php
  sudo rm /var/www/pimcore/cli/cli-install.php
  
fi

# stop temp. mysql service
mysqladmin -uroot shutdown

exec supervisord -n
