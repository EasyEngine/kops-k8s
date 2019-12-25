# Grafana

Grafana provides dashboard to monitor all the kubernetes resources. It also queries Loki for logs.

Grafana service is used to expose grafana to public domain via ingress nginx.

You can change the URL on which grafana will be accessible with changing `host` in the [service file](../monitoring/grafana/grafana-service.yaml).

```yaml
  - host: "grafana.example.com"
```

Then deploy using the following commands:

```bash
kubectl apply -f monitoring/grafana/grafana-configmap.yaml -n kube-system
kubectl apply -f monitoring/grafana/grafana-deployment.yaml -n kube-system
kubectl apply -f monitoring/grafana/grafana-job.yaml -n kube-system
kubectl apply -f monitoring/grafana/grafana-service.yaml -n kube-system
```
