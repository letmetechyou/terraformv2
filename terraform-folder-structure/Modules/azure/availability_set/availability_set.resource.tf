resource "azurerm_availability_set" "availability_set" {
  for_each = { for key, value in var.availability_set_data : key => value if value.enabled }

  # Required Arguments
  resource_group_name = each.value.resource_group_name
  name                = each.value.name
  location            = each.value.location


  # Required Blocks 



  # Optional Arguments
  managed                      = each.value.managed
  tags                         = each.value.tags
  platform_update_domain_count = each.value.platform_update_domain_count
  platform_fault_domain_count  = each.value.platform_fault_domain_count
  proximity_placement_group_id = each.value.proximity_placement_group_id


  # Optional Dynamic Blocks


  lifecycle {
    prevent_destroy = false
  }
}
