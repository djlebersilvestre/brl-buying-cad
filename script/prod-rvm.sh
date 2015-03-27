#!/bin/bash
set -e
source "${0%/*}"/prod-vars.sh

echo "Installing RVM and Ruby $RUBY_VERSION"
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable --ruby=ruby-${RUBY_VERSION}

echo "source $RVM_HOME/scripts/rvm" >> /etc/bash.bashrc
echo "export PATH=$PATH:$RVM_HOME/bin" >> /etc/profile
source /etc/profile
