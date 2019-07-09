#!/bin/bash
echo ">>> Installing PHP7.1-FPM"

sudo apt-get install -y software-properties-common

#add sources list
sudo apt install -y apt-transport-https lsb-release ca-certificates
sudo wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
sudo sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
sudo apt update

#install php7.1
sudo apt-get install -y php7.1 php7.1-cli php7.1-common php7.1-gd php7.1-json php7.1-opcache php7.1-mysql php7.1-mbstring php7.1-mcrypt php7.1-zip php7.1-fpm

#modify configurate
sudo sed -i 's,^post_max_size =.*$,post_max_size = 50M,' /etc/php/7.1/fpm/php.ini 
sudo sed -i 's,^upload_max_filesize =.*$,upload_max_filesize = 50M,' /etc/php/7.1/fpm/php.ini 
sudo sed -i 's,^memory_limit =.*$,memory_limit = 50M,' /etc/php/7.1/fpm/php.ini

sudo sed -i 's,^user =.*$,user = wwsokayama,' /etc/php/7.1/fpm/pool.d/www.conf 
sudo sed -i 's,^group =.*$,group = wwsokayama,' /etc/php/7.1/fpm/pool.d/www.conf
sudo sed -i 's,^listen.owner =.*$,listen.owner = wwsokayama,' /etc/php/7.1/fpm/pool.d/www.conf
sudo sed -i 's,^listen.group =.*$,listen.group = wwsokayama,' /etc/php/7.1/fpm/pool.d/www.conf

sudo sed -i 's,^pm.max_children =.*$,pm.max_children = 50,' /etc/php/7.1/fpm/pool.d/www.conf
sudo sed -i 's,^pm.start_servers =.*$,pm.start_servers = 4,' /etc/php/7.1/fpm/pool.d/www.conf
sudo sed -i 's,^pm.min_spare_servers =.*$,pm.min_spare_servers = 4,' /etc/php/7.1/fpm/pool.d/www.conf
sudo sed -i 's,^pm.max_spare_servers =.*$,pm.max_spare_servers = 32,' /etc/php/7.1/fpm/pool.d/www.conf
sudo sed -i 's,^;pm.max_requests =.*$,pm.max_requests = 200,' /etc/php/7.1/fpm/pool.d/www.conf

sudo service php7.1-fpm restart