#!/bin/bash

set -e

sudo apt-get install shellcheck

bundle install --path vendor/bundle

gem install rubocop
gem install overcommit

mv .git/hooks/post-checkout .git/hooks/post-checkout.sample
