#! /bin/bash

# install java
yum install java-11-openjdk.x86_64 -y

# download and install jenkins
yum update -y
yum install wget -y
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum install jenkins -y

# start jenkins on reboot
chkconfig jenkins on

# start jenkins
systemctl start jenkins

# enable jenkins with systemctl
systemctl enable jenkins

# install git
yum install git -y