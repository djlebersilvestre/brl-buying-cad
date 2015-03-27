#!/bin/bash

set -e

echo "Installing PostgreSQL lib for the driver and git for deployment"
apt-get update && apt-get upgrade -y \
  && apt-get install -y libpq-dev git daemontools
