# Monitoring 

## 1. [Metrics Server](metricsServer.md)

Metrics Server is a cluster-wide aggregator of resource usage data. It is required for gathering CPU and Memory data which is further required for Horzontal and Vertical Auto-scaling.

## 2. [Prometheus](prometheus.md)

Prometheus is a systems and service monitoring system. It collects metrics from configured targets at given intervals, evaluates rule expressions, displays the results, and can trigger alerts if some condition is observed to be true.

Prometheus queries kubernetes API to get gather detailed data. Prometheus logs the data on a disk to keep it persistant.

You can get data about services,pods etc. Data will contain network, disk and all other parameters used by cluster.

## 3. [Grafana](grafana.md)

Grafana allows you to query, visualize, alert on and understand your  metrics no matter where they are stored. Create, explore, and share dashboards with your team.

Grafana queries Prometheus to gather the data. Grafana also provides visualisation of Loki.

## 4. [Loki](loki.md)

Loki tails log with Promtail. Loki tails the container logs which are in `stdout` and`stdin`.
