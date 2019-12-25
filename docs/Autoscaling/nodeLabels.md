# Node Labels

**File:** `ig.yaml`

To add node label to a specific node or node pool you have to add a `nodeLabel` in the node spec.

By this the node will have specific name or label to identify with.

The NodeLabels are helful in defining `affinity`.

**Example:**

```
spec:
  nodeLabels:
    kubernetes.io/instancegroup: prod-node
```
