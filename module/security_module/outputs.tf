output "security_group_chandu_id" {
  value = aws_security_group.chandu_sg_security.id
}

output "security_group_chandu_private_id" {
  value = aws_security_group.chandu_private_sg_security.id
}