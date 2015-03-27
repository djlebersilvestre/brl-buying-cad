###############################################################
## Dockerfile to build a production replica image for this   ##
## ruby project. Here we can simulate the final environment. ##
###############################################################

# Pull base image
FROM djlebersilvestre/ruby:2.2.1
MAINTAINER Daniel Silvestre (djlebersilvestre@github.com)

# Install basic packages
COPY script/prod-packages.sh /script/prod-packages.sh
RUN /script/prod-packages.sh

# Install the app and vendorize
COPY script/prod-install.sh /script/prod-install.sh
RUN /script/prod-install.sh

# Configure the service
COPY script/prod-daemontools.sh /script/prod-daemontools.sh
RUN /script/prod-daemontools.sh

# Remove this ASAP
COPY ../prod-brl-buying-cad/.env /var/www/brl-buying-cad/.env

WORKDIR /var/www/brl-buying-cad

EXPOSE 3000
CMD [ "svscanboot" ]
