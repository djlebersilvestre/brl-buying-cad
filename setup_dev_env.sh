#!/bin/bash

sudo apt-get install shellcheck

bundle install --path vendor/bundle

gem install rubocop
gem install overcommit
