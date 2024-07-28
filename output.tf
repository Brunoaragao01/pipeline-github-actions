output "vm-azure-ip" {
  description = "Ip da azure vm"
  value       = azurerm_linux_virtual_machine.vm.public_ip_address
}

output "vm-aws-ip" {
  description = "Ip da azure vm"
  value       = aws_instance.vm.public_ip
}