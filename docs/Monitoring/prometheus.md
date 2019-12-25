# Prometheus

Prometheus gathers data from data exporters such as node exporter and blackbox.
Those exporters keep track of services, pods, nodes, disks and network usages.

Prometheus service is used to expose Prometheus to public domain via ingress nginx

You can change the URL on which Prometheus will be accessible with changing `host` in the [service file](../monitoring/prometheus/prometheus-service.yaml).

```yaml
  - host: "prometh.example.com"
```

## Deploy Prometheus

```bash
kubectl apply -f monitoring/prometheus/full-access.yaml -n kube-system
kubectl apply -f monitoring/prometheus/prometheus-0serviceaccount.yaml -n kube-system
kubectl apply -f monitoring/prometheus/prometheus-configmap.yaml -n kube-system
kubectl apply -f monitoring/prometheus/prometheus-service.yaml -n kube-system
kubectl apply -f monitoring/prometheus/prometheus-statefulset.yaml -n kube-system
kubectl apply -f monitoring/prometheus/kube-state-metrics-service.yaml -n kube-system
kubectl apply -f monitoring/prometheus/kube-state-metrics-0serviceaccount.yaml -n kube-system
kubectl apply -f monitoring/prometheus/kube-state-metrics-deployment.yaml -n kube-system
kubectl apply -f monitoring/prometheus/node-exporter-ds.yaml -n kube-system
kubectl apply -f monitoring/prometheus/node-exporter-0serviceaccount.yaml -n kube-system
kubectl apply -f monitoring/prometheus/blackbox-service.yaml -n kube-system
kubectl apply -f monitoring/prometheus/rabbitmq-blackbox-dep.yaml -n kube-system
```
