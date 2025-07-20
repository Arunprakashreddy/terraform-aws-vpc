########## public instance ##################
variable "ami_public" {
  description = "value of an ami in string type"
  type = string
}

variable "instance_type_public" {
  description = "value of an instance type in string type"
  type = string
}


variable "subnet_id_public" {
  description = "value of an subnet id which have to be fetched from vpc module"
  type = string
}

variable "security_groups_id" {
  description = "value have to be fetched from security module"
  type = string
}

############## private instance ###################
variable "ami_private" {
  description = "value of a private ami"
  type = string
}

variable "instance_type_private" {
  description = "value of a private instance type"
  type = string
}

variable "subnet_id_private" {
  description = "value of the private subnet is fetched from vpc module"
  type = string
}

variable "security_groups_id_private" {
  description = "value of the security group is fetched from security group module"
  type = string
}