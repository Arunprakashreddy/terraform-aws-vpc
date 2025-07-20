############## vpc block ##################
variable "aws_vpc_cidr_block" {
  type = string
}

variable "public_subnet_cidr_block" {
  type = string
}

variable "public_az" {
  type = string
}

variable "private_subnet_cidr_block" {
  type = string
}

variable "private_az" {
  type = string
}

variable "public_route_cidr_block" {
  type = string
}

variable "private_route_cidr_block" {
  type = string
}

################## ec2 instance block ##################

####### public instance ##############
variable "ami_public" {
  type = string
}

variable "instance_type_public" {
  type = string
}

######## private instance #############
variable "ami_private" {
  type = string
}

variable "instance_type_private" {
  type = string
}

############ security groups #############
variable "chandu_sg_ssh_cidr_block" {
  type = list(string)
}

variable "chandu_sg_http_cidr_block" {
  type = list(string)
}

variable "chandu_sg_egress" {
  type = list(string)
}