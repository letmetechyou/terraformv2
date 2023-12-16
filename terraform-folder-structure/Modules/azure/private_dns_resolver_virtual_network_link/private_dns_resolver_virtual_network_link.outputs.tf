output "private_dns_resolver_virtual_network_link_output" {
  value = zipmap(values(azurerm_private_dns_resolver_virtual_network_link.private_dns_resolver_virtual_network_link)[*].name, values(azurerm_private_dns_resolver_virtual_network_link.private_dns_resolver_virtual_network_link)[*])
}

output "private_dns_resolver_virtual_network_link_output_names" {
  value = { for key, value in azurerm_private_dns_resolver_virtual_network_link.private_dns_resolver_virtual_network_link : value.name => value }
}
