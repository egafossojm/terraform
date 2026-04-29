output "vpc_id" {
    value = aws_vpc.vpc.id
  
}
output "subnet_id" {
    value = aws_subnet.web.id
  
}
output "default_sg_id" {
    value = aws_default_security_group.default_sg.id
  
}

