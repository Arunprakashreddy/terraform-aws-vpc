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

module "security_groups" {
  source = "./module/security_module"
  vpc_id = module.vpc.vpc_id
  chandu_sg_ssh_cidr_block = var.chandu_sg_ssh_cidr_block
  chandu_sg_http_cidr_block = var.chandu_sg_http_cidr_block
  chandu_sg_egress = var.chandu_sg_egress

  #private
  chandu_private_egress_block = var.chandu_private_egress_block
}

module "ec2_instance" {
  #### public instance ###########
  source = "./module/ec2_instance"
  ami_public = var.ami_public
  instance_type_public = var.instance_type_public
  subnet_id_public = module.vpc.public_subnet_id
  public_security_groups_id = module.security_groups.security_group_chandu_id
  script_path = "${path.module}"
  ##### private instance #######
  ami_private = var.ami_private
  instance_type_private = var.instance_type_private
  subnet_id_private = module.vpc.private_subnet_id
  private_security_group_id = module.security_groups.security_group_chandu_private_id
}

