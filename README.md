# Experiments with Kubernetes

# [Basic:](docs/Basic)

1. [Cluster creation kops steps](docs/Basic/clusterCreation.md)
2. [Installing basic stack post cluster creation](docs/Basic/basicStack.md)
3. [Deploying sites in the cluster](docs/Basic/siteDeploy.md)

# [Monitoring:](docs/Monitoring)

1. [Metrics server](docs/Monitoring/metricsServer.md)
2. [Prometheus deployment](docs/Monitoring/prometheus.md)
3. [Grafana Deployment](docs/Monitoring/grafana.md)
4. [Loki Deployment](docs/Monitoring/loki.md)

# [Autoscaling:](docs/Autoscaling)

1. [Multi-node setup](docs/Autoscaling/multiNode.md)
   1. [Add node in same instance group](docs/Autoscaling/multiNode.md#add-node-in-same-instance-group)
   2. [Create instance group and add node](docs/Autoscaling/multiNode.md/#create-instance-group-and-add-node)
2. [Node Labels](docs/Autoscaling/nodeLabels.md)
3. [Horizontal autoscaling](docs/Autoscaling/HPA.md)
4. [Vertical autoscaling with the help of HPA](docs/Autoscaling/VA.md)
5. [Pod affinity/anit-affinity, high-availability](docs/Autoscaling/Affinity.md)

# [Dockerfiles:](dockerfiles)

1. [Dockerfiles](dockerfiles/README.md)

# [Rolling update:](docs/Rolling-update)

1. [Setting up rolling update and stateless deployments](docs/Rolling-update/rollingUpdateStrategy.md)
2. [Adjusting rolling updates according project needs](docs/Rolling-update/statelessDeployment.md)
