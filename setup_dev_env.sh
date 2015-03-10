#!/bin/bash

set -e
cd "$(dirname "$0")"

sudo echo

echo 'Vendorizing gems'
bundle install --path vendor/bundle

echo 'Adding base gems to gemset'
gem install rubocop
gem install overcommit

echo 'Configuring overcommit'
overcommit --install
overcommit --sign pre-commit
mv .git/hooks/post-checkout .git/hooks/post-checkout.sample
sudo apt-get install shellcheck

echo 'Running specs for the first time'
bundle exec spring rspec
