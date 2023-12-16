resource "azurerm_lb_backend_address_pool_address" "lb_backend_address_pool_address" {
  for_each = { for key, value in var.lb_backend_address_pool_address_data : key => value if value.enabled }

  # Required Arguments
  name                    = each.value.name
  backend_address_pool_id = each.value.backend_address_pool_id


  # Required Blocks 



  # Optional Arguments
  backend_address_ip_configuration_id = each.value.backend_address_ip_configuration_id
  ip_address                          = each.value.ip_address
  virtual_network_id                  = each.value.virtual_network_id


  # Optional Dynamic Blocks


  lifecycle {
    prevent_destroy = false
  }
}
