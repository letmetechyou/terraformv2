output "firewall_output" {
  value = zipmap(values(azurerm_firewall.firewall)[*].name, values(azurerm_firewall.firewall)[*])
}

output "firewall_output_names" {
  value = { for key, value in azurerm_firewall.firewall : value.name => value }
}
