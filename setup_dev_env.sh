#!/bin/bash

set -e
cd "$(dirname "$0")"

# Dependency for overcommit
sudo apt-get install shellcheck

echo 'Using RVM (loading from .bash_profile)'
source $HOME/.bash_profile
rvm use 2.2.1@brl-buying-cad --create

echo 'Vendorizing gems'
bundle install --path vendor/bundle

echo 'Adding base gems to gemset'
gem install rubocop
gem install overcommit

echo 'Configuring overcommit (to apply git hooks - quality threshold)'
overcommit --install
overcommit --sign pre-commit
mv .git/hooks/post-checkout .git/hooks/post-checkout.sample

echo 'Running specs for the first time  ;)'
bundle exec spring rspec
