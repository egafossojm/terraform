terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.42.0"
    }
  }
}


resource "aws_iam_user" "users" { 
  for_each = toset(var.iam_users)
  name = each.key
  path = "/systems/"
}