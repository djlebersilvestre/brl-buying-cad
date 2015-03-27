#!/bin/bash
set -e
MYDIR="$(dirname "$(readlink -f "$0")")"
source "$MYDIR"/prod-vars.sh

echo "Configuring app under $APP_DIR"
mkdir -p "$APP_DIR"
git clone https://github.com/djlebersilvestre/brl-buying-cad.git "$APP_DIR"
mkdir -p "$APP_DIR"/tmp/pids

echo "Vendorizing gems"
cd "$APP_DIR"
source /usr/local/rvm/scripts/rvm
bundle install --path vendor/bundle --without development test
