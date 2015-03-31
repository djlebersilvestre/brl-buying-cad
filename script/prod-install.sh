#!/bin/bash
set -e
# TODO: use prov-vars
APP_DIR=/var/www/brl-buying-cad

echo "Configuring app under $APP_DIR"
mkdir -p "$APP_DIR"
git clone https://github.com/djlebersilvestre/brl-buying-cad.git "$APP_DIR"
mkdir -p "$APP_DIR"/tmp/pids

echo "Vendorizing gems"
cd "$APP_DIR"
source /usr/local/rvm/scripts/rvm
bundle install --path vendor/bundle --without development test
