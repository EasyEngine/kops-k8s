FROM redis:5.0

LABEL org.label-schema.schema-version="1.0.0-rc1"
LABEL org.label-schema.vendor="EasyEngine"
LABEL org.label-schema.name="redis"

RUN mkdir -p /var/log/redis; \
	chown -R redis: /var/log/redis
RUN apt update 
RUN apt install -y sysfsutils
RUN echo "kernel/mm/transparent_hugepage/enabled = never" >> /etc/sysfs.conf
RUN cat /etc/sysfs.conf
COPY redis.conf /usr/local/etc/redis/redis.conf
COPY purge_all_cache.lua /data/purge_all_cache.lua
