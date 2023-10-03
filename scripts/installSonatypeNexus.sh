#! /bin/bash

# update
sudo yum update -y
sudo yum install wget -y

# install java 8
sudo yum install java-1.8.0-amazon-corretto-devel -y

# download nexus
cd /opt/
sudo wget -O nexus.tar.gz https://download.sonatype.com/nexus/3/latest-unix.tar.gz

# unzip nexus tar file
sudo tar -xvf nexus.tar.gz

# rename folder for ease of use
sudo mv nexus-3.* nexus3

# enable permission for ec2-user to work on nexus3 and sonatype-work folders
sudo chown -R ec2-user:ec2-user nexus3/ sonatype-work/

# create a file called nexus.rc and add run as ec2-user
cd /opt/nexus3/bin/

file="nexus.rc"
if [ -f "$file" ] ; then
    rm "$file"
fi

sudo touch nexus.rc
echo 'run_as_user="ec2-user"' | sudo tee -a /opt/nexus3/bin/nexus.rc

# add nexus as a service at boot time
sudo ln -s /opt/nexus3/bin/nexus /etc/init.d/nexus
cd /etc/init.d
sudo chkconfig --add nexus
sudo chkconfig --levels 345 nexus on

# start nexus service
sudo service nexus start