output "lb_backend_address_pool_address_output" {
  value = zipmap(values(azurerm_lb_backend_address_pool_address.lb_backend_address_pool_address)[*].name, values(azurerm_lb_backend_address_pool_address.lb_backend_address_pool_address)[*])
}

output "lb_backend_address_pool_address_output_names" {
  value = { for key, value in azurerm_lb_backend_address_pool_address.lb_backend_address_pool_address : value.name => value }
}
