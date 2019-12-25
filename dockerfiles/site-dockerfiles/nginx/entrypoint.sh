#!/bin/bash
set -ex

if [[ "$IS_REDIS" == "redis" ]]; then
    mv /etc/nginx/redis_conf /etc/nginx/conf.d/main.conf
    sed -i 's/REDIS_HOST/'$REDIS_HOST'/g' /etc/nginx/conf.d/main.conf
elif [[ "$MU" == "subdir" ]]; then
    echo ''  
elif [[ "$MU" == "subdom" ]]; then
    echo ''
fi

sed -i 's/REPLACE_ME_WITH_SERVER_NAME/'$SITE_NAME'/g' /etc/nginx/conf.d/main.conf

[[ -f "/tmp/wp-config/wp-config.php" ]] && ln -s /tmp/wp-config/wp-config.php /var/www/wp-config.php

pid=0

# SIGTERM-handler
term_handler() {
  if [ $pid -ne 0 ]; then
    kill -s QUIT "$pid"
    wait "$pid"
  fi
  exit 143; # 128 + 15 -- SIGTERM
}

#trap 'kill ${!}; term_handler' SIGTERM

trap 'cleanup 1' 1
trap 'cleanup 2' 2
trap 'cleanup 3' 3
trap 'cleanup 6' 6
trap 'cleanup 9' 9
trap 'cleanup 14' 14
trap 'cleanup 15' 15

cleanup()
{
  sig=$(($? - 128))
  echo "Caught Signal $sig"
  echo "func call: $1"
  if [ $pid -ne 0 ]; then
    kill -s QUIT "$pid"
    wait "$pid"
    echo 'Nginx shutdown'
  fi
  exit 143;
}

# Start the command in background - so the shell is in foreground and receives signals (otherwise it ignores signals)
/usr/local/openresty/bin/openresty "$@" &
pid="$!"
echo "Nginx started with PID $pid"

# wait forever
while true
do
  tail -f /dev/null & wait ${!}
done
