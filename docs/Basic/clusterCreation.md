# k8s Cluster Setup

1. Install all the pre-requisites using [this script](../../setup.sh).
2. Configure [aws-cli](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html#cli-quick-configuration).
3. Create s3 bucket for the cluster:
```bash
export KOPS_STATE_STORE=dev-kops-cluster-s3

aws s3api create-bucket \
    --bucket $KOPS_STATE_STORE \
    --region us-east-1

aws s3api put-bucket-encryption --bucket $KOPS_STATE_STORE --server-side-encryption-configuration '{"Rules":[{"ApplyServerSideEncryptionByDefault":{"SSEAlgorithm":"AES256"}}]}'
```

3. Add the following in `~/.zshrc`/`~/.bashrc`:
```bash
export NAME=dev-kops.k8s.local
export KOPS_STATE_STORE=s3://dev-kops-cluster-s3
```

4. Add cluster config files to s3 bucket:
```bash
kops create -f dev.cluster.yaml
kops create secret --name ${NAME} sshpublickey admin -i ~/.ssh/id_rsa.pub
kops create -f ig.yaml
kops update cluster $NAME --yes && kops rolling-update cluster $NAME --yes
```
