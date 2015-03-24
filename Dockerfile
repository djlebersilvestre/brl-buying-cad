###############################################################
## Dockerfile to build a production replica image for this   ##
## ruby project. Here we can simulate the final environment. ##
###############################################################

# Pull base image
FROM djlebersilvestre/ruby:2.2.1
MAINTAINER Daniel Silvestre (djlebersilvestre@github.com)

# Launches the installation script
COPY setup_prod_env.sh /setup_prod_env.sh
RUN ./setup_prod_env.sh

WORKDIR /var/www/brl-buying-cad

#TODO: nginx, daemon tools
