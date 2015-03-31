#!/bin/bash
set -e

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
scripts="$DIR"/script
rm -rf "$scripts"
mkdir "$scripts"

apt-get update
apt-get install -y curl

github="https://raw.githubusercontent.com/djlebersilvestre/brl-buying-cad/master/script"
curl -sSL "$github/prod-packages.sh"    -o "$scripts"/prod-packages.sh
curl -sSL "$github/prod-utf8.sh"        -o "$scripts"/prod-utf8.sh
curl -sSL "$github/prod-rvm.sh"         -o "$scripts"/prod-rvm.sh
curl -sSL "$github/prod-install.sh"     -o "$scripts"/prod-install.sh
curl -sSL "$github/prod-daemontools.sh" -o "$scripts"/prod-daemontools.sh
chmod +x -R "$scripts"

# Step 1 - packages:
#   installs all basic packages such as Postgres client
#
# Step 2 - utf8:
#   configures utf8 as default locale
#
# Step 3 - rvm:
#   installs rvm and ruby
#
# Step 4 - install:
#   installs the app. It clones the git repo and vendorize
#
# Step 5 - daemontools:
#   setup process monitoring over the app and auto startup on boot
#
# Step 6 - cd:
#   configure continuous delivery script with cron
STEPS_NUM=6
echo "Step 1 / $STEPS_NUM"
. "$scripts"/prod-packages.sh
echo "Step 2 / $STEPS_NUM"
. "$scripts"/prod-utf8.sh
echo "Step 3 / $STEPS_NUM"
. "$scripts"/prod-rvm.sh
echo "Step 4 / $STEPS_NUM"
. "$scripts"/prod-install.sh
echo "Step 5 / $STEPS_NUM"
. "$scripts"/prod-daemontools.sh
echo "Step 6 / $STEPS_NUM"
. "$scripts"/prod-cd.sh
echo "Finished all steps!"
exit 0

# TODO: run vim to edit .env on the fly and restart the server
echo "**********************************************************************************************"
echo "Don't forget to set the production passwords, URLs and others in .env (copy from .env.example)"
echo "**********************************************************************************************"
