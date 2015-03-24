#!/bin/bash

set -e
cd "$(dirname "$0")"

APP_DIR=/var/www/brl-buying-cad

echo "Installing PostgreSQL lib for the driver and git for deployment"
apt-get update && apt-get upgrade -y && apt-get install -y libpq-dev git

echo "Configuring app under /var/www"
mkdir -p $APP_DIR
git clone https://github.com/djlebersilvestre/brl-buying-cad.git $APP_DIR
mkdir -p $APP_DIR/tmp/pids
cat $APP_DIR/.env >> /etc/bash.bashrc && rm $APP_DIR/.env

echo "Vendorizing gems"
cd $APP_DIR
source /usr/local/rvm/scripts/rvm
bundle install --path vendor/bundle --without development test

echo "*********************************************************************************"
echo "Don't forget to set the production passwords, URLs and others in /etc/environment"
echo "*********************************************************************************"
