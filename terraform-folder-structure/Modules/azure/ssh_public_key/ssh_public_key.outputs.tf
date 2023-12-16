output "ssh_public_key_output" {
  value = zipmap(values(azurerm_ssh_public_key.ssh_public_key)[*].name, values(azurerm_ssh_public_key.ssh_public_key)[*])
}

output "ssh_public_key_output_names" {
  value = { for key, value in azurerm_ssh_public_key.ssh_public_key : value.name => value }
}
