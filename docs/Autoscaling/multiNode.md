# Multi-Node setup

## Add node in same instance group

**File:** `ig.yaml`

Edit ig.yaml file and change number of instances that you need by editing `maxSize`and `minSize` parameters.

To remove the node set `minSize` and `maxSize` to `0`

If `minSize` is `0` and `maxSize` is `>0` then the node will not get removed.

## Create Instance group and add node

**Command:**

```bash
kops create ig testnode --subnet us-east-1b 
```

Editor will open afterwards where you can edit parameter for the nodes in the instance group.

Alternative and suggested way can be adding the instance group with a `yaml` file and adding node with `ig.yaml`.
