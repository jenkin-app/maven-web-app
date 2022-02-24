#!/bin/bash

sudo yum update -y
sudo yum install docker -y
sudo usermod -aG docker ec2-user
sudo chmod 666 /var/run/docker.sock
sudo systemctl enable docker 
sudo systemctl start docker

docker run -u 0 --privileged --name jenkins -p 8080:8080 -p 50000:50000 -it -d -v /home/jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock -v $(which docker):/usr/bin/docker jenkins/jenkins:latest