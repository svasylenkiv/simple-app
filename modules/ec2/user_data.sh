#!/bin/bash
set -e

sudo dnf update -y
sudo dnf install -y docker
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker ec2-user

# Wait for docker daemon (dnf update can take several minutes)
sleep 60
sudo docker run -d -p 80:80 --name nginx --restart unless-stopped nginx:alpine
