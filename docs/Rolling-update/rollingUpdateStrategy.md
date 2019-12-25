# Rolling update strategies

## Master Nodes

As per kubernetes guidelines 3 master nodes should be there. To ensure the uptime and reduce chances of failures configuring 3 master nodes is advisable. 

## Worker Nodes

Worker nodes can be node pools or just a single node running pods for the services. When node update is ongoing it drains the node then updates it. To ensure the uptime it is needed that >1 pod is running for a specific site/service. 
