#!/bin/bash

set -e
cd "$(dirname "$0")"

echo 'Installing PostgreSQL lib - for the driver'
sudo apt-get install -y libpq-dev shellcheck

echo 'Loading RVM - it must be installed as user mode'
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
rvm use 2.2.1@brl-buying-cad --create

echo 'Vendorizing gems'
bundle install --path vendor/bundle

echo 'Adding base gems to gemset'
gem install rubocop
gem install rubycritic
gem install overcommit

echo 'Configuring overcommit (to apply git hooks - quality threshold)'
overcommit --install
overcommit --sign pre-commit
mv .git/hooks/post-checkout .git/hooks/post-checkout.sample

echo 'Setting up docker environment - dependencies of the application'
# TODO: create linux-scripts to auto install and configure docker

echo 'Setting up Postgres over docker'
source <(curl https://raw.githubusercontent.com/djlebersilvestre/docker-postgres/master/commands.sh)
pg-setup
pg-start
bundle exec rake db:setup

echo 'Setting up Redis over docker'
source <(curl https://raw.githubusercontent.com/djlebersilvestre/linux-scripts/master/dkr-redis-commands.sh)
redis-setup
redis-start

echo 'Finally, testing for the first time'
bundle exec spring rspec

echo 'Running everything attached to overcommit (specs too)  ;)'
overcommit -r
