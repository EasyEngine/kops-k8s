# https://github.com/mrrobot47/dockerfiles/tree/php/7.3
FROM easyengine/php7.3:v4.0.3

USER root

COPY --chown=www-data:www-data ./htdocs /var/www/htdocs

RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
    rsync; \
	rm -rf /var/lib/apt/lists/*;

RUN export NR_VERSION=$(curl -sS https://download.newrelic.com/php_agent/release/ | sed -n 's/.*>\(.*linux\).tar.gz<.*/\1/p'); \
curl -L https://download.newrelic.com/php_agent/release/$NR_VERSION.tar.gz | tar -C /tmp -zx && \
export NR_INSTALL_USE_CP_NOT_LN=1 && \
export NR_INSTALL_SILENT=1 && \
/tmp/newrelic-php5-*/newrelic-install install && \
rm -rf /tmp/newrelic-php5-* /tmp/nrinstall*

ENV NR_PORT=31111

RUN mkdir -p /var/log/php /var/log/newrelic /run/newrelic; \
	chown -R www-data:www-data /var/log/php; \
	chown -R www-data:www-data /var/log/newrelic; \
	chown -R www-data:www-data /usr/local/etc/php/conf.d; \
	touch /var/log/fpm-php.www.log && chmod 777 /var/log/fpm-php.www.log;

COPY ./php-fpm/newrelic.ini /usr/local/etc/php/conf.d/newrelic.ini
COPY ./php-fpm/entrypoint.sh /usr/local/bin/
COPY ./php-fpm/bashrc /root/.bashrc
COPY ./php-fpm/easyengine.conf /usr/local/etc/php-fpm.d/easyengine.conf
COPY ./php-fpm/php.ini /usr/local/etc/php/php.ini
COPY ./php-fpm/custom.ini /usr/local/etc/php/conf.d/custom.ini

ENTRYPOINT ["entrypoint.sh"]
CMD ["php-fpm"]
