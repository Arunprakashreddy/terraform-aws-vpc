resource "aws_instance" "chandu_public_server" {
  ami = var.ami_public
  instance_type = var.instance_type_public
  key_name = "chandu_keys"  #generate aws key manually and then apply
  subnet_id = var.subnet_id_public
  security_groups = [var.security_groups_id]
}
