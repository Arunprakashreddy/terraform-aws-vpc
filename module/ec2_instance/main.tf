resource "aws_instance" "chandu_public_server" {
  ami = var.ami_public
  instance_type = var.instance_type_public
  key_name = "chandu_keys"  #generate aws key manually and then apply
  subnet_id = var.subnet_id_public
  security_groups = [var.security_groups_id]

  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = file("C:/Users/chand/Downloads/chandu_keys.pem") #path has to be updated every time we create key
    host = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y httpd",
      "sudo systemctl enable httpd",
      "sudo systemctl start httpd"
    ]
  }
}

resource "aws_instance" "chandu_private_server" {
  ami = var.ami_private
  instance_type = var.instance_type_private
  subnet_id = var.subnet_id_private
  security_groups = [ var.security_groups_id ]
}