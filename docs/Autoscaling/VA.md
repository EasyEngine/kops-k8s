# Vertical Autoscaling 

If number of pods or deployment increases than the capacity to handle them by node then it will trigger vertical auto scaling.

In vertical autoscaling number of node will increase falling in the same instance group (IG).

## Prerequisites

To make HPA work we need CPU and memory utilised by the pods. For this [metrics server](../Monitoring/metricsServer.md) must be deployed.

## Configuration

**File: vauto/cluster-autoscaler.sh**

Update the parameters in the file according to your usage.

Execute bash script.
