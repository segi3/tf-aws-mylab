#! /bin/bash

# update
sudo yum update -y

# ansible user config
sudo useradd ansadmin
sudo echo "ansibleadmin" | sudo passwd --stdin ansadmin

# modify sudoers, add entry
sudo echo "ansadmin ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers
sudo echo "ec2-user ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers

# modify sshd config
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo service sshd restart

# install Docker
sudo yum install docker -y

# start docker service
sudo service docker start

# add ansadmin to docker group so docker commands doesn't need sudo
sudo usermod -a -G docker ansadmin