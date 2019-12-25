# Horizontal pod auto-scaling (HPA)

If Pods starts to use more Memory or CPU than defined in the HPA, Auto-scaling action will trigger and it will add another replica of the same deployment to balance the load.

## Prerequisites

To make HPA work we need CPU and memory utilised by the pods. For this [metrics server](../Monitoring/metricsServer.md) must be deployed.

## Configuration

**File: clutser.yaml**

Add the following in cluster `spec`.

These lines will inform the kube controller manager not to use `Rest` based endpoints to gather metrics.

```yaml
  kubeControllerManager:
    horizontalPodAutoscalerUseRestClients: false
```

**File: site/dep.yaml**

1. Add container usage limit. Metrics server will be tracking this usage limits. Eg. 50% of the requested resources.

   ```yaml
         containers:
         - name: php-fpm
           image: superuser/php:v1.0.8
           resources:
             limits:
               cpu: "0.2"
               memory: 100Mi
             requests:
               cpu: 10m
               memory: 64Mi
   ```

2. Add an HPA block same as example :

   ```yaml
   apiVersion: autoscaling/v2beta1
   kind: HorizontalPodAutoscaler
   metadata:
     name: test-aws-k8s-master
   spec:
     scaleTargetRef:
       apiVersion: apps/v1
       kind: Deployment
       name: test-aws-k8s-master #name of deployment
     minReplicas: 3 #maximum limit pods can replicate to
     maxReplicas: 1 #minimum number of replicas: >=1
     metrics:
     - type: Resource
       resource:
         name: memory #target resource
         targetAverageUtilization: 50 #trigger if utilization is >=50%
     - type: Resource
       resource:
         name: cpu
         targetAverageUtilization: 50
   ```



## Limits

If Pod/Node affinities are there then HPA behaviour will depend on it.

1. If pod afinity is there and 2 nodes are available. If auto scaling triggers then maximum 2 numbers of replicas can be created.

2. If node afinity is there and only 2 nodes are available in the node pool then numer of replicas are depended on the resources are available in the nodepool.

3. If Pod and Node afinities are configured at a same time then both limits 1 and 2 will be applied. 
