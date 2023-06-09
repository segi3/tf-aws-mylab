terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~>3.0"
      }
    }
}

# configure aws provider
provider "aws" {
  region = "ap-southeast-1"
  shared_credentials_file = "C:/Users/Rafi_118407/.aws/credentials"
  # access_key
  # secret_key
}

# create vpc
resource "aws_vpc" "mylab-vpc" {
  cidr_block = var.cidr-block[0]

  tags = {
    Name = "mylab-vpc"
  }
}

# create subnet (public)
resource "aws_subnet" "mylab-subnet-1" {
  vpc_id = aws_vpc.mylab-vpc.id
  cidr_block = var.cidr-block[1]

  tags = {
    Name = "mylab-subnet-1"
  }
}

# create internet gateway
resource "aws_internet_gateway" "mylab-igw" {
  vpc_id = aws_vpc.mylab-vpc.id

  tags = {
    Name = "mylab-igw"
  }
}

# create security group
resource "aws_security_group" "mylab-security-group" {
  name = "mylab security group"
  description = "allow inbound and outbound traffics"
  vpc_id = aws_vpc.mylab-vpc.id

  ingress = [ {
    description = "ssh port"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    from_port = 22
    to_port = 22
    protocol = "tcp"
    prefix_list_ids = []
    security_groups = []
    self = false
  }, {
    description = "JENKINS"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    prefix_list_ids = []
    security_groups = []
    self = false
  } ]

  egress = [ {
    description = "out"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
    prefix_list_ids = []
    security_groups = []
    self = false
  } ]

  tags = {
    Name = "mylab-security-group-allow-traffic"
  }
}

# create route table
resource "aws_route_table" "mylab-route-table" {
  vpc_id = aws_vpc.mylab-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mylab-igw.id
  }

  tags = {
    Name = "mylab-route-table"
  }
  
}

# create route table association
resource "aws_route_table_association" "mylab-route-table-association" {
  subnet_id = aws_subnet.mylab-subnet-1.id
  route_table_id = aws_route_table.mylab-route-table.id
}

# create ec2
resource "aws_instance" "mylab-jenkins-server" {
  ami = var.ami-red-hat
  instance_type = var.instance_type
  key_name = "mylab-key"
  vpc_security_group_ids = [ aws_security_group.mylab-security-group.id ]
  subnet_id = aws_subnet.mylab-subnet-1.id
  associate_public_ip_address = true
  user_data = file("./scripts/installJenkins.sh")

  tags = {
    Name = "mylab-jenkins-server"
  }
}