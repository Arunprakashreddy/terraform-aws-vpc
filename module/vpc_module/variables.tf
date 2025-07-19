#vpc cidr block
variable "aws_vpc_cidr_block" {
  description = "value of vpc cidr block type string"
  type = string
}

#punlic subnet
variable "public_subnet_cidr_block" {
  description = "value of public cidr block type is string"
  type = string
}

variable "public_az" {
  description = "value of public availabilty zone a string type"
  type = string
}

#private subnet
variable "private_subnet_cidr_block" {
  description = "value of private cidr block type is string"
  type = string
}

variable "private_az" {
  description = "value of private availabity zone a string type"
  type = string
}

#public route table
variable "public_route_cidr_block" {
  description = "value of a public route table cidr block a string type"
  type = string
}

#private route table
variable "private_route_cidr_block" {
  description = "value of private route table cidr block a string type"
  type = string
}