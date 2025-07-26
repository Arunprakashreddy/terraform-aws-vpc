############### Public_instance_security_group #################
resource "aws_security_group" "chandu_sg_security" {
  vpc_id = var.vpc_id

  ingress {
    description = "allowing ssh"
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_blocks = var.chandu_sg_ssh_cidr_block
  }

  ingress {
    description = "allowing http"
    protocol = "tcp"
    from_port = 80
    to_port = 80
    cidr_blocks = var.chandu_sg_http_cidr_block
  }

  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = var.chandu_sg_egress
  }
  tags = {
    name = "public_sg"
  }
}
################ Private_security_group_instance ################
resource "aws_security_group" "chandu_private_sg_security" {
  vpc_id     = var.vpc_id
  depends_on = [ aws_security_group.chandu_sg_security ]

  ingress {
    description     = "allowing ssh"
    protocol        = "tcp"
    from_port       = 22
    to_port         = 22
    security_groups = [aws_security_group.chandu_sg_security.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = [var.chandu_private_egress_block]
  }
  tags = {
    name = "private_sg"
  }
}
