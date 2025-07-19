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