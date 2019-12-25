#!/bin/bash
set -ex

if [[ "$UPDATE_RUN" == "setup" ]]; then

        extra_php='if ( isset( $_SERVER["HTTP_X_FORWARDED_PROTO"] ) && $_SERVER["HTTP_X_FORWARDED_PROTO"] == "https" ) {     $_SERVER["HTTPS"] = "on";}
                define( "WP_DEBUG", false );
                define( "WP_DEBUG_LOG", false );
                define( "WP_DEBUG_DISPLAY", false );@ini_set( "display_errors", 0 );
                define( "SCRIPT_DEBUG", false );
                ';

        if [[ "$MU" == "subdir" ]] || [[ "$MU" == "subdom" ]]; then
                extra_php+='
                define( "WP_ALLOW_MULTISITE", true );
                define( "MULTISITE", true );
                define( "PATH_CURRENT_SITE", "/" );
                define( "SITE_ID_CURRENT_SITE", 1 );
                define( "BLOG_ID_CURRENT_SITE", 1 );
                define( "COOKIE_DOMAIN", false );
                ';
                extra_php+="define( \"DOMAIN_CURRENT_SITE\", '"$SITE_NAME"' );"
                [[ "$MU" == "subdom" ]] && extra_php+="define( \"SUBDOMAIN_INSTALL\", true );" || extra_php+="define( \"SUBDOMAIN_INSTALL\", false );"
        fi

        wp config create --dbname=$DB_NAME --dbuser="$DB_USER" --dbpass="$DB_PASS" --dbhost="$DB_HOST" --extra-php="$extra_php" --allow-root

        if [[ -z $(mysql -u"$DB_USER" -p"$DB_PASS" -h"$DB_HOST" -e"exit") ]]; then
                echo "MYSQL connected\n\n";
        else
                echo "MYSQL connection failed\n\n";
        fi

        if [[ $(wp db create --allow-root) ]]; then
                echo "Created db";
                if [[ "$MU" == "subdir" ]]; then
                        wp core multisite-install --url="$SITE_NAME" --title="$SITE_TITLE" --admin_user="$WP_USER" --admin_password="$WP_PASS" --admin_email=admin@${SITE_NAME} --allow-root
                elif [[ "$MU" == "subdom" ]]; then
                        wp core multisite-install --url="$SITE_NAME" --title="$SITE_TITLE" --admin_user="$WP_USER" --admin_password="$WP_PASS" --admin_email=admin@${SITE_NAME} --subdomains --allow-root
                else
                        wp core install --url="$SITE_NAME" --title="$SITE_TITLE" --admin_user="$WP_USER" --admin_password="$WP_PASS" --admin_email=admin@${SITE_NAME} --allow-root
                fi
                wp rewrite structure "/%year%/%monthnum%/%day%/%postname%/" --hard --allow-root
        fi

        echo "$IS_REDIS"

        if [[ "$IS_REDIS" == "redis" ]]; then

                page_cache_key_prefix="$SITE_NAME""_page:";
                obj_cache_key_prefix="$SITE_NAME""_obj:";
                # Enable obj cache
                wp config set --type=variable redis_server "array('host'=> '$REDIS_HOST','port'=> 6379,)" --raw --allow-root
                # wp plugin install wp-redis --activate --allow-root
                # wp redis enable --allow-root
                
                # Enable page cache
                # wp plugin install nginx-helper --activate --allow-root
                wp config set RT_WP_NGINX_HELPER_REDIS_HOSTNAME $REDIS_HOST --add=true --type=constant --allow-root
                wp config set RT_WP_NGINX_HELPER_REDIS_PORT 6379 --add=true --type=constant --allow-root
                wp config set RT_WP_NGINX_HELPER_REDIS_PREFIX $page_cache_key_prefix --add=true --type=constant --allow-root
                wp config set WP_CACHE_KEY_SALT $obj_cache_key_prefix --add=true --type=constant --allow-root
                wp config set WP_REDIS_MAXTTL 14400 --add=true --type=constant --allow-root
        fi
        mv /var/www/htdocs/wp-config.php /var/www/wp-config.php
fi


if [[ -z "${NEWRELIC_LICENSE_KEY:-}" ]] || [[ -z "${NEWRELIC_APPNAME:-}" ]]; then
    :
else
    sed -i -e "s/\"REPLACE_WITH_REAL_KEY\"/\"$NEWRELIC_LICENSE_KEY\"/" \
    -e "s/newrelic.appname = \"PHP Application\"/newrelic.appname = \"$NEWRELIC_APPNAME\"/" \
    /usr/local/etc/php/conf.d/newrelic.ini
fi

[[ -f "/tmp/wp-config/wp-config.php" ]] && ln -s /tmp/wp-config/wp-config.php /var/www/wp-config.php
[[ "$IS_REDIS" == "redis" ]] && ls #&& ln -s plugins/wp-redis/object-cache.php wp-content/object-cache.php

exec "$@"
