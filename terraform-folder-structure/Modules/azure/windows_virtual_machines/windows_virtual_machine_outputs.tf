output "network_security_group_output" {
  value = zipmap(keys(azurerm_windows_virtual_machine.main), values(azurerm_windows_virtual_machine.main)[*])
}

output "network_security_group_output_names" {
  value = { for key, value in azurerm_windows_virtual_machine.main : value.name => value }
}