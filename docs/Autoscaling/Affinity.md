# Affinity

We are using 2 types of affinities right now. It solves architectural problems such as node selection and pod deployment on nodes.

Need better understanding on this.

## podAntiAffinity

It makes sure that only one pod of deployment statys on a nod. That is only one pod per app can stay on a node. 

Add following lines in deployment:template:spec

```yaml
      affinity:
        podAntiAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchExpressions:
              - key: app
                operator: In
                values:
                - test-aws-k8s-master
            topologyKey: "kubernetes.io/hostname"
```

## nodeAffinity

It makes sure that the deployment goes to the specific instance group.

```yaml
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: kubernetes.io/instancegroup
                operator: In
                values:
                - nodes
```

Here  `kubernetes.io/instancegroup` is key and `nodes` is value.
