resource "aws_default_security_group" "chandu_sg_security" {
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
}