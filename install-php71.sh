#!/bin/bash
echo ">>> Installing PHP7.1-FPM"

sudo apt-get install -y software-properties-common

sudo add-apt-repository ppa:ondrej/php

sudo apt-get update

sudo apt-get install -y php7.1 php7.1-cli php7.1-common php7.1-json php7.1-opcache php7.1-mysql php7.1-mbstring php7.1-mcrypt php7.1-zip php7.1-fpm

