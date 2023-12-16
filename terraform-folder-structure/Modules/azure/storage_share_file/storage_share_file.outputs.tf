output "storage_share_file_output" {
  value = zipmap(values(azurerm_storage_share_file.storage_share_file)[*].name, values(azurerm_storage_share_file.storage_share_file)[*])
}

output "storage_share_file_output_names" {
  value = { for key, value in azurerm_storage_share_file.storage_share_file : value.name => value }
}
