#!/bin/bash

set -e
cd "$(dirname "$0")"

echo "Installing PostgreSQL lib - for the driver"
sudo apt-get update && sudo apt-get install -y libpq-dev

echo "Loading RVM - it must be installed as user mode"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
rvm install ruby-2.2.1
rvm use 2.2.1@brl-buying-cad --create

echo "Vendorizing gems"
cp .env.example .env
bundle install --path vendor/bundle

echo "Adding base gems to gemset"
gem install rubocop
gem install rubycritic
gem install overcommit
gem install scss-lint

echo "Installing dependencies for overcommit gem"
sudo apt-get install -y npm shellcheck scss-lint
sudo npm install -g eslint jscs jshint

echo "Configuring overcommit (to apply git hooks - quality threshold)"
overcommit --install
overcommit --sign pre-commit
mv .git/hooks/post-checkout .git/hooks/post-checkout.sample

source <(curl https://raw.githubusercontent.com/djlebersilvestre/linux-scripts/master/dkr-commands.sh)
if ! which docker > /dev/null; then
  echo "Setting up docker environment to provide dependencies for the application"
  dkr_install
else
  echo "Docker already installed. Skipping"
fi
dkr_setup

echo "Setting up Postgres over docker"
source <(curl https://raw.githubusercontent.com/djlebersilvestre/docker-postgres-debian74/master/dkr-commands.sh)
pg_start
bundle exec rake db:setup

echo "Setting up Redis over docker"
source <(curl https://raw.githubusercontent.com/djlebersilvestre/docker-redis-debian74/master/dkr-commands.sh)
redis_start

echo "Finally, testing for the first time"
cp .env.example .env
bundle exec spring rspec

echo "Running everything attached to overcommit (specs too)  ;)"
overcommit -r
