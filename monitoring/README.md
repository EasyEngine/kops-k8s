# Prometheus

Prometheus is currently scraping services and nodes which are giving information about CPU, Network, Memory and FS majorly.
Prometheus is depended on these services : state-matrics, node-exporter and blackbox.

# Grafana

Grafana queries prometheus.
Grafana is depended on Prometheus primarily.
For logging it is depeneded on Loki and Promtail.

In case of Grafana pod is restarted we have to run a job to load dashboard back.
```bash
krm -f grafana-job.yaml 
ka grafana-job.yaml
```

