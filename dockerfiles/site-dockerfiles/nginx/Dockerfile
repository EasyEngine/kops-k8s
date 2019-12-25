FROM mrrobot47/openresty:v1.0.0

RUN mkdir -p /etc/nginx{/lua,/common,/conf/custom}
COPY ./nginx/resty /etc/nginx/lua/resty
COPY ./nginx/conf/ /etc/nginx/
COPY ./nginx/custom/ /etc/nginx/custom/
COPY ./nginx/conf.d/ /etc/nginx/conf.d/
COPY ./nginx/entrypoint.sh /etc/nginx

COPY --chown=www-data:www-data ./htdocs /var/www/htdocs

RUN ln -s /dev/stdout /var/log/nginx/access.log && \
    ln -s /dev/stderr /var/log/nginx/error.log

COPY ./nginx/redis_conf /etc/nginx

EXPOSE 80
CMD ["/etc/nginx/entrypoint.sh", "-g", "daemon off;"]

# Use SIGQUIT instead of default SIGTERM to cleanly drain requests
# See https://github.com/openresty/docker-openresty/blob/master/README.md#tips--pitfalls
#STOPSIGNAL SIGQUIT

# RUN mkdir -p /etc/nginx{,/lua,/common}
# COPY ./nginx/resty /etc/nginx/lua/resty
# COPY ./nginx/conf/nginx.conf /etc/nginx/nginx.conf
# COPY ./nginx/conf/mime.types /etc/nginx/mime.types
# COPY ./nginx/conf/fastcgi_params /etc/nginx/fastcgi_params
# COPY ./nginx/conf/fastcgi.conf /etc/nginx/fastcgi.conf
# COPY ./nginx/common/acl.conf /etc/nginx/common/acl.conf
# COPY ./nginx/main.conf /etc/nginx/conf.d/main.conf
# # COPY ./nginx/default /etc/nginx/conf.d/main.conf
# # COPY ./nginx/default-redis /etc/nginx/default-redis
# # COPY ./nginx/subdir /etc/nginx/subdir
# # COPY ./nginx/subdom /etc/nginx/subdom
# COPY ./nginx/htpasswd-ee /etc/nginx/htpasswd-ee
# COPY ./nginx/entrypoint.sh /etc/nginx

# COPY --chown=www-data:www-data ./htdocs /var/www/htdocs

# EXPOSE 80
# CMD ["/etc/nginx/entrypoint.sh", "-g", "daemon off;"]