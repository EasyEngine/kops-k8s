# Loki

Loki connects Promtail with grafana. By this we can get container logs in grafana. It includes error and access logs.

## Deployments

### Loki

```bash
kubectl apply -f monitoring/loki/loki-rolebinding.yaml -n kube-system
kubectl apply -f monitoring/loki/loki-secret.yaml -n kube-system
kubectl apply -f monitoring/loki/loki-serviceaccount.yaml -n kube-system
kubectl apply -f monitoring/loki/loki-service.yaml -n kube-system
kubectl apply -f monitoring/loki/loki-stateful.yaml -n kube-system
```

### Promtail

```bash
kubectl apply -f monitoring/loki/clusterrolebinding.yaml -n kube-system
kubectl apply -f monitoring/loki/clusterrole.yaml -n kube-system
kubectl apply -f monitoring/loki/configmap.yaml -n kube-system
kubectl apply -f monitoring/loki/podsecuritypolicy.yaml -n kube-system
kubectl apply -f monitoring/loki/rolebinding.yaml -n kube-system
kubectl apply -f monitoring/loki/role.yaml -n kube-system
kubectl apply -f monitoring/loki/serviceaccount.yaml -n kube-system
kubectl apply -f monitoring/loki/daemonset.yaml -n kube-system
```
