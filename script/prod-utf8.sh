#!/bin/bash
set -e

localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
if grep -q "export LANG=en_US.utf8" /etc/profile; then
  echo "Locale already set for UTF8"
else
  echo "export LANG=en_US.utf8" >> /etc/profile
  source /etc/profile
fi
