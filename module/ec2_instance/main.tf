resource "aws_instance" "chandu_public_server" {
  ami = var.ami_public
  instance_type = var.instance_type_public
  key_name = "chandu_keys"  #generate aws key manually and then apply
  subnet_id = var.subnet_id_public
  security_groups = [var.security_groups_id]
  associate_public_ip_address = true

  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = file("C:/Users/chand/Downloads/chandu_keys.pem") #path has to be updated every time we create key
    host = self.public_ip
  }

  provisioner "file" {
    source = "C:/workarea/arun/cloud/terraform-aws-vpc/setup_scripts.sh"
    destination = "/tmp/setup_scripts.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sleep 30",
      "chmod +x /tmp/setup_scripts.sh",
      "sudo /tmp/setup.sh"
    ]
  }

  timeouts {
    create = "10m"
  }
}

resource "aws_instance" "chandu_private_server" {
  ami = var.ami_private
  instance_type = var.instance_type_private
  subnet_id = var.subnet_id_private
  security_groups = [ var.security_groups_id ]
}