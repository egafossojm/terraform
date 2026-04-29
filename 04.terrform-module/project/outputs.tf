output "my_vm_public_ip" {
  value = module.my_vm.public_ip
}
output "vpc1_id" {
    value = module.vpc1.vpc_id
}