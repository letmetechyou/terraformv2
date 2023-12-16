output "private_dns_resolver_output" {
  value = zipmap(values(azurerm_private_dns_resolver.private_dns_resolver)[*].name, values(azurerm_private_dns_resolver.private_dns_resolver)[*])
}

output "private_dns_resolver_output_names" {
  value = { for key, value in azurerm_private_dns_resolver.private_dns_resolver : value.name => value }
}
