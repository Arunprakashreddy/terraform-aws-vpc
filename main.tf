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