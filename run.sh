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
  mysql -u root -e "CREATE USER 'pimcore_dev'@'%' IDENTIFIED BY 'pimcore_dev_password';"
  mysql -u root -e "GRANT ALL PRIVILEGES ON pimcore_dev.* TO 'pimcore_dev'@'%';"
  
  # setup database 
  mysql -u pimcore_demo -ppimcore_dev_password -e "CREATE DATABASE pimcore_dev charset=utf8;"; 
  mysql -u pimcore_demo -ppimcore_dev_password pimcore_dev < /var/www/pimcore/modules/install/mysql/install.sql
  
  # 'admin' password is 'Dev_password123' 
  mysql -u pimcore_demo -ppimcore_dev_password -D pimcore_dev -e "UPDATE users SET password = '$2y$10$pmKv/oVgnclHMUfLAp4kbOlYTTfKgsaU77hdcfQN2RaypbP.RaO8q' WHERE name = 'admin'"  
  mysql -u pimcore_demo -ppimcore_dev_password -D pimcore_dev -e "UPDATE users SET id = '0' WHERE name = 'system'"
  
  sudo -u www-data mv /tmp/system.xml /var/www/website/var/config/system.xml
  sudo -u www-data cp /tmp/cache.xml /var/www/website/var/config/cache.xml
fi

# stop temp. mysql service
mysqladmin -uroot shutdown

exec supervisord -n
