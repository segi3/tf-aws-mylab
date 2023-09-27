#! /bin/bash

# update
sudo yum update -y
sudo yum install wget -y

# install java
sudo dnf install java-11-amazon-corretto -y

# download jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade -y

# install jenkins
sudo yum install jenkins -y

# start jenkins
sudo systemctl start jenkins

# start jenkins on boot
sudo systemctl enable jenkins

# start jenkins on restart
sudo chkconfig jenkins on

# install git
sudo yum install git -y