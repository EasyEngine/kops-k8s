# k8s-dockerfiles

## Build commands

### PHP Image

```bash
cd site-dockerfiles
docker build -t easyengine/k8s-php:v1.0.0 -f php-fpm/Dockerfile .
```

### PHP Cron Image

```bash
cd site-dockerfiles
docker build -t easyengine/k8s-php-cron:v1.0.0 -f php-cron/Dockerfile .
```

### Nginx Image
```bash
cd site-dockerfiles
docker build -t easyengine/k8s-nginx:v1.0.0 -f nginx/Dockerfile .
```

### Redis Image
```bash
cd redis
docker build -t easyengine/k8s-redis:v1.0.0 .
```