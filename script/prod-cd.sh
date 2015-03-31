#!/bin/bash
set -e
DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "$DIR"/prod-vars.sh

add_cron() {
  if grep -q "continuous-delivery" /etc/crontab; then
    echo "Continuous delivery already configured in cron. Skipping this step."
  else
    local logfile="$APP_DIR"/log/deploy.log
    local script="$APP_DIR"/script/continuous-delivery.sh

    local cron_cmd="date +'\%Y-\%m-\%d \%H:\%M:\%S' >> $logfile 2>&1"
    local cron_cmd="$cron_cmd && $script deploy >> $logfile 2>&1"
    local cron_line="*/10 * * * *    root    $cron_cmd"

    echo "$cron_line" >> /etc/crontab
  fi
}

reload_cron() {
  service cron reload
}

echo 'Configuring continuous delivery script in cron'
add_cron
reload_cron
