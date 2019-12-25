#!/bin/bash
set -ex

[[ -f "/tmp/wp-config/wp-config.php" ]] && ln -s /tmp/wp-config/wp-config.php /var/www/wp-config.php

cd /var/www/htdocs
wp cron event run --due-now --allow-root