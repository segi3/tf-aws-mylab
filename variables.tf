variable "cidr-block" {
  type = list(string)
default = [ "172.20.0.0/16", "172.20.10.0/24" ]
}

variable "ami-red-hat" {
  type = string
  default = "ami-02acda7aaa1f944e5"
}

variable "ami-ubuntu" {
  type = string
  default = "ami-082b1f4237bd816a1"
}

variable "ami-amazon-linux" {
  type = string
  default = "ami-0eeadc4ab092fef70"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}