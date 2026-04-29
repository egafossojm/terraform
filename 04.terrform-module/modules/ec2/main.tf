terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.42.0"
    }
  }
}

resource "aws_instance" "server" {
    ami = data.aws_ami.amazon_linux_2023.image_id
    instance_type = var.instance_type
    subnet_id = var.vpc_subnet_id
    vpc_security_group_ids = [var.security_group_id]
}