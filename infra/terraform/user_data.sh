#!/bin/bash
apt update -y
apt install -y docker.io

systemctl start docker
systemctl enable docker

docker run -d -p 5000:5000 nginx