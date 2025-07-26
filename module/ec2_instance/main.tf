resource "aws_instance" "chandu_public_server" {
  ami = var.ami_public
  instance_type = var.instance_type_public
  key_name = "chandu_keys"  #generate aws key manually and then apply
  subnet_id = var.subnet_id_public
  security_groups = [var.public_security_groups_id]
  associate_public_ip_address = true
  user_data = file("${var.script_path}/scripts/setup_scripts.sh")

  tags = {
    name = "public_instance"
  }
}

resource "aws_instance" "chandu_private_server" {
  ami = var.ami_private
  instance_type = var.instance_type_private
  subnet_id = var.subnet_id_private
  security_groups = [ var.private_security_group_id ]
  associate_public_ip_address = false

  tags = {
    name = "private_intance"
  }
}