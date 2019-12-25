# Stateless Deployments

## Code

Code is uploaded in the form of docker containers. That is every time deployment triggers a new docker container will be built and upload this docker container to a private docker repository. When updating the site deployment in kubernetes new docker container will be passed to the yaml file.

## Configurations

With this stateless setup it is imporatant that we keep site specific configurations somewhere. To overcome this all the Nginx,PHP and Redis configurations are being added to the repository itself.

## S3 Bucket

As WordPress uploads have to be stateful we cannot afford to keep them on the kubernetes cluster. Also `readWriteMany` is not a good options for disks. To avoid this we are using AWS S3 service with [S3-Uploads](https://github.com/humanmade/S3-Uploads) plugin.

## RDS

To ensure high availability and high performance we are using RDS. It also ensures point in time restore and backup services. For other configurations like readOnly database we are using [HyperDB](https://wordpress.org/plugins/hyperdb/) plugin.