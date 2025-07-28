resource "aws_eip" "global-eip" {
  domain = "vpc"
}

module "vpc" {
  source = "./module/vpc_module"
  aws_vpc_name = "global-vpc"
  aws_igw_name = "global-igw"
  aws_private_subnet_name = "global-private-subnet"
  aws_public_subnet_name = "global-public-subnet"
  aws_vpc_cidr_block = var.aws_vpc_cidr_block
  public_subnet_cidr_block = var.public_subnet_cidr_block
  public_az = var.public_az
  private_subnet_cidr_block = var.private_subnet_cidr_block
  private_az = var.private_az
  public_route_cidr_block = var.public_route_cidr_block
  private_route_cidr_block = var.private_route_cidr_block
  aws_eip_id = aws_eip.global-eip.id
}

############### Public_instance_security_group #################
resource "aws_security_group" "global_public_sg" {
  vpc_id =  module.vpc.vpc_id

  ingress {
    description = "allowing ssh"
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_blocks = var.global_sg_ssh_cidr_block
  }

  ingress {
    description = "allowing http"
    protocol = "tcp"
    from_port = 80
    to_port = 80
    cidr_blocks = var.global_sg_http_cidr_block
  }

  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = var.global_sg_egress
  }
  tags = {
    Name = "public_sg"
  }
}
################ Private_security_group_instance ################
resource "aws_security_group" "global_private_sg" {
  vpc_id     =  module.vpc.vpc_id

   ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp" # -1 signifies all protocols
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all inbound IPv4 traffic"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp" # -1 signifies all protocols
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all inbound IPv4 traffic"
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = var.global_sg_egress
  }
  tags = {
    Name = "private_sg"
  }
}

resource "aws_security_group_rule" "global_security_rule_ingress" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  security_group_id = aws_security_group.global_private_sg.id
  source_security_group_id = aws_security_group.global_public_sg.id
}



module "ec2_instance" {
  #### public instance ###########
  source = "./module/ec2_instance"
  ami_public = var.ami_public
  instance_type_public = var.instance_type_public
  subnet_id_public = module.vpc.public_subnet_id
  public_security_groups_id = aws_security_group.global_public_sg.id
  script_path = "${path.module}"
  ##### private instance #######
  ami_private = var.ami_private
  instance_type_private = var.instance_type_private
  subnet_id_private = module.vpc.private_subnet_id
  private_security_group_id = aws_security_group.global_private_sg.id
}

