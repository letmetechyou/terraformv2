output "linux_virtual_machine_output" {
  value = zipmap(keys(azurerm_linux_virtual_machine.main), values(azurerm_linux_virtual_machine.main)[*])
}

output "linux_virtual_machine_output_names" {
  value = { for key, value in azurerm_linux_virtual_machine.main : value.computer_name => value }
}