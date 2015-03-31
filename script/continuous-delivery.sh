#!/bin/bash
set -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd "$DIR"/..
source .env

TAG_REGEXP='v[0-9]{1,3}(\.[0-9]{1,3}){2}'

current_ip() {
  ifconfig | awk '/inet addr/{print substr($2,6)}' | grep -v 127.0.0.1 | head -n 1
}

current_tag() {
  git branch | head -n 1 | grep -Eo "$TAG_REGEXP"
}

latest_tag() {
  git fetch --tags
  git tag | grep -E "$TAG_REGEXP" | sort -V | head -n 1
}

checkout_tag() {
  git checkout tags/"$1"
}

restart_app() {
  # TODO: move this to an external script and include in this one
  # TODO: no downtime deployment
  echo 'Restarting sidekiq'
  svc -t /etc/service/sidekiq
  echo 'Restarting unicorn'
  svc -t /etc/service/unicorn
}

notify_deploy() {
  options="-u continuous-delivery-$(current_ip)"
  options="$options -r $1"

  echo "Notifying deployment of $BRLCAD_NEWRELIC_APPNAME to NewRelic"
  echo "Version deployed: $1"
  echo "$options"
  bundle exec dotenv newrelic deployments "$options"
}

deploy() {
  local force=$1
  local current_tag=$(current_tag)
  local latest_tag=$(latest_tag)

  if [ "$force" == "-f" ] || [ "$current_tag" != "$latest_tag" ]; then
    echo "Found new version. Updating current version ($current_tag) with the new one ($latest_tag)"
    set -v
    checkout_tag "$latest_tag"
    restart_app
    notify_deploy "$latest_tag"
    set +v
    # TODO: How to handle migrations?
    # TODO: How to handle new env vars?
  else
    echo "No new versions were found. Running the latest release ($current_tag)"
  fi
}

"$@"
