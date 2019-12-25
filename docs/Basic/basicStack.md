# Basic stack Installation

## Services

### Nginx-Ingress

```bash
kubectl apply -f services/ingress/mandatory.yaml
kubectl apply -f services/ingress/service-l4.yaml
kubectl apply -f services/ingress/patch-configmap-l4.yaml
```

### MariaDB

```
kubectl apply -f services/mariadb/mariadb.yaml
```

### Redis

```
kubectl apply -f services/redis/redis.yaml
```

