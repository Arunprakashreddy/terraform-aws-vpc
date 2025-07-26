variable "vpc_id" {
    description = "value of an vpc to be fetced from vpc module"
    type = string
}

variable "chandu_sg_ssh_cidr_block" {
  type = list(string)
}

variable "chandu_sg_http_cidr_block" {
  type = list(string)
}

variable "chandu_sg_egress" {
  type = list(string)
}
variable "chandu_private_egress_block" {
  type = string
}