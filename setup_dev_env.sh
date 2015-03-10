#!/bin/bash

set -e

# Vendorizing gems
bundle install --path vendor/bundle

# Adding base gems to gemset
gem install rubocop
gem install overcommit

# Configuring overcommit
overcommit --install
overcommit --sign pre-commit
mv .git/hooks/post-checkout .git/hooks/post-checkout.sample
sudo apt-get install shellcheck
