#!/bin/bash
sudo su
yum update -y
yum install docker -y
systemctl start docker
systemctl enable docker
docker run -d  --restart always --log-driver=awslogs  --log-opt awslogs-region=ap-south-1 --log-opt awslogs-group=log-group-task-terra --log-opt awslogs-create-group=true  -p 80:80 akshayakolhe/api-python-task:v1