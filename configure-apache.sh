#!/usr/bin/env bash
set -e

printf "Installing apache modules and configurations...\n"

# Installing pagespeed module
wget https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_amd64.deb
sudo dpkg -i mod-pagespeed-*.deb
sudo apt-get -f -y install
sudo service apache2 reload

# installing security modules
sudo apt-get install -y libapache2-modsecurity

#installing Spamhaus
sudo apt-get install -y libapache2-mod-spamhaus

# Installing mode-evasive and fail 2ban
sudo apt-get install -y libapache2-mod-evasive
sudo apt-get install -y fail2ban

# Installing mod-qos
sudo apt-get install -y libapache2-mod-qos

# Enabling some vital Apache Modules
sudo a2enmod rewrite
sudo a2enmod headers
sudo a2enmod mod-security
sudo a2enmod mod-spamhaus

