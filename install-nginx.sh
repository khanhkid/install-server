#!/bin/bash
echo ">>> Installing Nginx"

sudo apt update
sudo apt install -y nginx


#modify configurate
sudo sed -i 's,^user www-data,user wwsokayama,' /etc/nginx/nginx.conf
sudo sed -i 's/# server_tokens/server_tokens/' /etc/nginx/nginx.conf


sudo systemctl restart nginx