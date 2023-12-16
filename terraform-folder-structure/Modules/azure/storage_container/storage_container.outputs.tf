output "storage_container_output" {
  value = zipmap(values(azurerm_storage_container.storage_container)[*].name, values(azurerm_storage_container.storage_container)[*])
}

output "storage_container_output_names" {
  value = { for key, value in azurerm_storage_container.storage_container : value.name => value }
}
