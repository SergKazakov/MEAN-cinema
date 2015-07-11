#!/usr/bin/env bash

# MongoDB
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
sudo apt-get update
sudo apt-get install -y mongodb-org

# NodeJS
sudo apt-get install -y g++ curl libssl-dev apache2-utils git-core python-software-properties
sudo apt-add-repository ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install -y nodejs

# Fix npm permissions
mkdir /home/vagrant/.npm
sudo chmod 777 -R /home/vagrant/.npm

# Fir 255 char limit on Windows
mkdir ~/node_modules
ln -sf ~/node_modules /vagrant

sudo npm i -g gulp bower nodemon coffee-script npm-check-updates bower-update
