!#/bin/bash

sudo yum update -y
sudo yum install docker -y
sudo usermod -aG docker ec2-user
sudo chmod 666 /var/run/docker.sock
sudo systemctl enable docker 
sudo systemctl start docker