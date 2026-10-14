variable "region" {
    default = "ca-central-1"
  
}

variable "iam_users" {
    type = list(string)
  
}

variable "vpc1_cidr_block" {
    default = "10.1.0.0/16"
    type = string
  
}

variable "vpc1_enable_dns" {
    type = bool
    default = true
  
}

variable "vpc1_web_subnet" {
    type = string
    default = "10.1.1.0/24"
  
}
variable "instance_type" {
    type = string
    default = "t3.micro"
}

