output "lb_backend_address_pool_output" {
  value = zipmap(values(azurerm_lb_backend_address_pool.lb_backend_address_pool)[*].name, values(azurerm_lb_backend_address_pool.lb_backend_address_pool)[*])
}

output "lb_backend_address_pool_output_names" {
  value = { for key, value in azurerm_lb_backend_address_pool.lb_backend_address_pool : value.name => value }
}
