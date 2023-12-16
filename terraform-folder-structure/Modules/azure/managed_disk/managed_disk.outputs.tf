output "managed_disk_output" {
  value = zipmap(values(azurerm_managed_disk.managed_disk)[*].name, values(azurerm_managed_disk.managed_disk)[*])
}

output "managed_disk_output_names" {
  value = { for key, value in azurerm_managed_disk.managed_disk : value.name => value }
}
