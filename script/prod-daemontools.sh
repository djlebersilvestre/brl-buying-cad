#!/bin/bash
set -e
# TODO: use prov-vars
APP_DIR=/var/www/brl-buying-cad
SERVICE_DIR=/etc/service

setup_service() {
  mkdir -p "$SERVICE_DIR"/"$1"/log
  RUN="$SERVICE_DIR"/"$1"/run
  echo -e '#!/bin/bash\nexec 2>&1\nsource /usr/local/rvm/scripts/rvm\ncd '"$APP_DIR"' && exec bundle exec dotenv '"$1" "$2" > "$RUN"
  chmod +x "$RUN"
}

setup_log() {
  LOG="$SERVICE_DIR"/"$1"/log/run
  echo -e '#!/bin/bash\nexec 2>&1\nexec multilog t s10485760 n5 ./main' > "$LOG"
  chmod +x "$LOG"
}

init_svscanboot() {
  if grep -q "svscanboot" /etc/inittab; then
    echo "Svscanboot already configured to be loaded on startup. Skipping this step."
  else
    echo -e '\n# Svscanboot will load on startup and launch everyone under /etc/service' >> /etc/inittab
    echo -e 'SV:123456:respawn:/usr/bin/svscanboot' >> /etc/inittab
  fi
}

echo "Configuring daemontools to auto start the app (unicorn and sidekiq)"
setup_service 'unicorn' '-c config/unicorn.rb'
setup_log 'unicorn'

setup_service 'sidekiq'
setup_log 'sidekiq'

init_svscanboot
