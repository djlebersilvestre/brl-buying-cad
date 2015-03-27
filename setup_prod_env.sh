#!/bin/bash

set -e
cd "$(dirname "$0")"

APP_DIR=/var/www/brl-buying-cad


echo "Installing PostgreSQL lib for the driver and git for deployment"
apt-get update && apt-get upgrade -y && apt-get install -y libpq-dev git daemontools

echo "Configuring app under /var/www"
mkdir -p $APP_DIR
git clone https://github.com/djlebersilvestre/brl-buying-cad.git $APP_DIR
mkdir -p $APP_DIR/tmp/pids

echo "Vendorizing gems"
cd $APP_DIR
source /usr/local/rvm/scripts/rvm
bundle install --path vendor/bundle --without development test

echo "Configuring daemontools to auto start the app (unicorn and sidekiq)"
SERVICE_DIR=/etc/service

mkdir -p $SERVICE_DIR/unicorn/log
RUN_UNICORN=$SERVICE_DIR/unicorn/run
echo -e '#!/bin/bash\ncd '$APP_DIR' && bundle exec dotenv unicorn -c config/unicorn.rb' > $RUN_UNICORN
chmod +x $RUN_UNICORN
RUN_UNICORN_LOG=$SERVICE_DIR/unicorn/log/run
echo -e '#!/bin/bash\nexec 2>&1\nexec multilog t s10485760 n5 ./main' > $RUN_UNICORN_LOG
chmod +x $RUN_UNICORN_LOG

mkdir -p $SERVICE_DIR/sidekiq/log
RUN_SIDEKIQ=$SERVICE_DIR/sidekiq/run
echo -e '#!/bin/bash\ncd '$APP_DIR' && bundle exec dotenv sidekiq' > $RUN_SIDEKIQ
chmod +x $RUN_SIDEKIQ
RUN_SIDEKIQ_LOG=$SERVICE_DIR/sidekiq/log/run
echo -e '#!/bin/bash\nexec 2>&1\nexec multilog t s10485760 n5 ./main' > $RUN_SIDEKIQ_LOG
chmod +x $RUN_SIDEKIQ_LOG

if grep -q "svscanboot" /etc/inittab; then
  echo "Svscanboot already configured to be loaded on startup. Skipping this step."
else
  echo -e '\n# Svscanboot will load on startup and launch everyone under /etc/service' >> /etc/inittab
  echo -e 'SV:123456:respawn:/usr/bin/svscanboot' >> /etc/inittab
fi

echo "******************************************************************************"
echo "Don't forget to set the production passwords, URLs and others in $APP_DIR/.env"
echo "******************************************************************************"
