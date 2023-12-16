output "public_ip_output" {
  value = zipmap(keys(azurerm_public_ip.public_ip), values(azurerm_public_ip.public_ip)[*])
}

output "public_ip_output_names" {
  value = { for key, value in azurerm_public_ip.public_ip : value.name => value }
}