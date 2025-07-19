module "vpc" {
  source = "./module/vpc_module"
  aws_vpc_cidr_block = var.aws_vpc_cidr_block
  public_subnet_cidr_block = var.public_subnet_cidr_block
  public_az = var.public_az
  private_subnet_cidr_block = var.private_subnet_cidr_block
  private_az = var.private_az
  public_route_cidr_block = var.public_route_cidr_block
  private_route_cidr_block = var.private_route_cidr_block
}

module "ec2_instance" {
  source = "./module/ec2_instance"
  ami_public = var.ami_public
  instance_type_public = var.instance_type_public
  subnet_id_public = module.vpc.public_subnet_id
  security_groups_id = module.security_groups.security_group_chandu_id
}

module "security_groups" {
  source = "./module/security_module"
  vpc_id = module.vpc.vpc_id
  chandu_sg_ssh_cidr_block = var.chandu_sg_ssh_cidr_block
  chandu_sg_http_cidr_block = var.chandu_sg_http_cidr_block
  chandu_sg_egress = var.chandu_sg_egress
}