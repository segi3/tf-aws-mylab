output "jenkins_instance_ip" {
    value = aws_instance.mylab-jenkins-server.public_ip
}

output "ansible_control_instance_ip" {
    value = aws_instance.mylab-ansible-control-server.public_ip
}

output "ansible_apache_tomcat_instance_ip" {
    value = aws_instance.mylab-ansible-managed-node1-server.public_ip
}