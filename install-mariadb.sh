#!/bin/bash
echo ">>> Installing MariaDB"


# default version
MARIADB_VERSION='10.4'
ROOT_PASS='root'
export LC_ALL="en_US.UTF-8"

# Import repo key
sudo apt-get install -y software-properties-common dirmngr
sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xF1656F24C74CD1D8
sudo add-apt-repository "deb [arch=amd64,i386,ppc64el] http://download.nus.edu.sg/mirror/mariadb/repo/$MARIADB_VERSION/debian stretch main"

# Update
sudo apt-get update

# Install MariaDB without password prompt
sudo debconf-set-selections <<< "maria-db-$MARIADB_VERSION mysql-server/root_password password $ROOT_PASS"
sudo debconf-set-selections <<< "maria-db-$MARIADB_VERSION mysql-server/root_password_again password $ROOT_PASS"

# Install MariaDB
# -qq implies -y --force-yes
sudo DEBIAN_FRONTEND=noninteractive apt-get install -qq mariadb-server

# Make Maria connectable from outside world without SSH tunnel
# enable remote access
# setting the mysql bind-address to allow connections from everywhere
sudo sed -i "s/bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

sudo sed -i 's,^#max_connections.*$,max_connections = 300M\ninnodb_buffer_pool_size = 4G\ninnodb_log_file_size = 1G,' /etc/mysql/mariadb.conf.d/50-server.cnf

sudo sed -i "s/^#slow_query_log_file/slow_query_log_file/" /etc/mysql/mariadb.conf.d/50-server.cnf
sudo sed -i "s/^#long_query_time/long_query_time/" /etc/mysql/mariadb.conf.d/50-server.cnf
sudo sed -i "s/^query_cache_limit.*/query_cache_limit = 16M/" /etc/mysql/mariadb.conf.d/50-server.cnf
sudo sed -i "s/^query_cache_size.*/query_cache_size = 512M/" /etc/mysql/mariadb.conf.d/50-server.cnf


#slow_query_log_file    = /var/log/mysql/mariadb-slow.log
#long_query_time = 10


# adding grant privileges to mysql root user from everywhere
# thx to http://stackoverflow.com/questions/7528967/how-to-grant-mysql-privileges-in-a-bash-script for this
MYSQL=`which mysql`

Q1="GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$ROOT_PASS' WITH GRANT OPTION;"
Q2="FLUSH PRIVILEGES;"
SQL="${Q1}${Q2}"

sudo $MYSQL -uroot -p$ROOT_PASS -e "$SQL"

sudo service mysql restart