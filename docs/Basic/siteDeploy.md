# Deploy site in cluster

## Simple site setup

1. Create and switch namespace
```bash
k create ns simple-wp
kubens simple-wp
```

2. Deploy

```bash
# Update `kops.example.com` domain with domain of your choice in: simple/dep.yaml
kubectl apply -f simple/dep.yaml
```
