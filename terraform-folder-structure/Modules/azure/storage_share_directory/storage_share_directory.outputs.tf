output "storage_share_directory_output" {
  value = zipmap(values(azurerm_storage_share_directory.storage_share_directory)[*].name, values(azurerm_storage_share_directory.storage_share_directory)[*])
}

output "storage_share_directory_output_names" {
  value = { for key, value in azurerm_storage_share_directory.storage_share_directory : value.name => value }
}
