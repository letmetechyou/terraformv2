resource "azurerm_network_security_group" "network_security_group" {
  for_each = { for key, value in var.network_security_group_data : key => value if value.enabled }

  # Required Arguments
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location


  # Required Blocks 



  # Optional Arguments
  tags = each.value.tags


  # Optional Dynamic Blocks
  dynamic "security_rule" {

    for_each = each.value.security_rule != null ? range(length(each.value.security_rule)) : []

    content {
      # Required
      priority  = each.value.security_rule[security_rule.key].priority
      direction = each.value.security_rule[security_rule.key].direction
      protocol  = each.value.security_rule[security_rule.key].protocol
      access    = each.value.security_rule[security_rule.key].access
      name      = each.value.security_rule[security_rule.key].name

      # Optional
      source_port_ranges                         = each.value.security_rule[security_rule.key].source_port_ranges
      destination_port_range                     = each.value.security_rule[security_rule.key].destination_port_range
      destination_port_ranges                    = each.value.security_rule[security_rule.key].destination_port_ranges
      destination_application_security_group_ids = each.value.security_rule[security_rule.key].destination_application_security_group_ids
      source_application_security_group_ids      = each.value.security_rule[security_rule.key].source_application_security_group_ids
      description                                = each.value.security_rule[security_rule.key].description
      source_address_prefix                      = each.value.security_rule[security_rule.key].source_address_prefix
      destination_address_prefix                 = each.value.security_rule[security_rule.key].destination_address_prefix
      destination_address_prefixes               = each.value.security_rule[security_rule.key].destination_address_prefixes
      source_address_prefixes                    = each.value.security_rule[security_rule.key].source_address_prefixes
      source_port_range                          = each.value.security_rule[security_rule.key].source_port_range
    }
  }



  lifecycle {
    prevent_destroy = false
  }
}
