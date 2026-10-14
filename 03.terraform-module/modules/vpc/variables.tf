variable "vpc_cidr_block" {
    default = "10.1.0.0/16"
    type = string
  
}

variable "enable_dns" {
    type = bool
    default = true
  
}

variable "web_subnet" {
    type = string
    default = "10.1.1.0/24"
  
}

variable "ingress_ports" {
    type = list(number)
    default = [ 80, 443 ]
  
}