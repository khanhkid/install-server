#!/bin/bash
sudo apt-get install -y git

wget -O - https://raw.githubusercontent.com/khanhkid/install-server/master/install-php71.sh | bash
wget -O - https://raw.githubusercontent.com/khanhkid/install-server/master/install-nginx.sh | bash
wget -O - https://raw.githubusercontent.com/khanhkid/install-server/master/install-mariadb.sh | bash