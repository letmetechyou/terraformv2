output "storage_share_output" {
  value = zipmap(values(azurerm_storage_share.storage_share)[*].name, values(azurerm_storage_share.storage_share)[*])
}

output "storage_share_output_names" {
  value = { for key, value in azurerm_storage_share.storage_share : value.name => value }
}
