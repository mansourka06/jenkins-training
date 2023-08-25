#!/bin/bash

IP=$(hostname -I | awk '{print $2}')

echo "START - install jenkins - "$IP

sudo yum update -y

#Install required dependencies for the jenkins package
sudo yum install java-1.8.0-openjdk-devel

# install docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
sudo usermod -aG docker vagrant
sudo systemctl enable docker
sudo systemctl start docker
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

#Install jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

sudo yum upgrade

sudo yum -y install jenkins
sudo usermod -aG docker jenkins
sudo systemctl daemon-reload

#Start Jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins

echo "END - install jenkins"

#Access Jenkins
echo "Jenkins will be accessible to : http://$IP:8080"

echo "the initial admin password is : $(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)"