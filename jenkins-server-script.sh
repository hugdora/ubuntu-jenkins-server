#!/bin/bash

# install maven

sudo apt install maven -y

# install jenkins


sudo apt update -y
sudo apt install default-jdk -y

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo gpg --dearmor -o /usr/share/keyrings/jenkins-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/jenkins-archive-keyring.gpg] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update -y
sudo apt install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins

# install git
sudo apt-get install git -y

# install terraform

sudo apt update -y
sudo apt install  software-properties-common gnupg2 curl -y
curl https://apt.releases.hashicorp.com/gpg | gpg --dearmor > hashicorp.gpg
sudo install -o root -g root -m 644 hashicorp.gpg /etc/apt/trusted.gpg.d/
sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt install terraform -y

# Install docker

sudo apt update -y
sudo apt install docker.io -y
## grant Jenkins users and Ubuntu user permission to docker deamon
sudo su - 
usermod -aG docker jenkins
usermod -aG docker ubuntu
systemctl restart docker

# install kubectl

	
sudo apt install apt-transport-https curl -y	
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" >> ~/kubernetes.list
sudo mv ~/kubernetes.list /etc/apt/sources.list.d
sudo apt update -y

sudo apt-get install -y kubelet kubeadm kubectl kubernetes-cni

