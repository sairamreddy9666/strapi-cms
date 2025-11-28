#!/bin/bash
dnf update -y
dnf install docker -y
systemctl enable docker
systemctl start docker
usermod -aG docker ec2-user
docker run -d --name strapi --restart unless-stopped -p 1337:1337 -e DATABASE_CLIENT=sqlite -e DATABASE_FILENAME=/data/data.db -v strapi-data:/data strapi/strapi
