#!/bin/bash
set -e

TAG_REGEXP='v[0-9]{1,3}(\.[0-9]{1,3}){2}'

current_ip() {
  ifconfig | awk '/inet addr/{print substr($2,6)}' | grep -v 127.0.0.1 | head -n 1
}

current_tag() {
  git branch | head -n 1 | grep -Eo "$TAG_REGEXP"
}

lastest_tag() {
  git fetch --tags
  git tag | grep -E "$TAG_REGEXP" | sort -V | head -n 1
}

checkout_tag() {
  git checkout tags/"$1"
}

restart_app() {
  # TODO: no downtime deployment
  echo 'Restarting sidekiq'
  svc -t /etc/service/sidekiq
  echo 'Restarting unicorn'
  svc -t /etc/service/unicorn
}

notify_deploy() {
  options="-a $BRLCAD_NEWRELIC_APPNAME"
  options="$options -u continuous-delivery-$(current_ip)"
  options="$options -l $BRLCAD_NEWRELIC_LICENSE"
  options="$options -r $1"

  echo "Notifying deployment of $BRLCAD_NEWRELIC_APPNAME to NewRelic"
  echo "Version deployed: $1"
  bundle exec dotenv newrelic deployments "$options"
}

# Check for new tag (compare with current)
# Checkout new tag
# Restart app

# TODO: How to handle migrations?
# TODO: How to handle new env vars?

"$@"
