terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.42.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.region
}

module "iam_users" {
    source = "../modules/iam-users"
    iam_users = var.iam_users
}

module "vpc1" {
    source = "../modules/vpc"
    vpc_cidr_block = var.vpc1_cidr_block
    web_subnet = var.vpc1_web_subnet
    enable_dns = var.vpc1_enable_dns
}

module "my_vm" {
    source = "../modules/ec2"
    instance_type = var.instance_type
    vpc_subnet_id = module.vpc1.subnet_id
    security_group_id = module.vpc1.default_sg_id
}

