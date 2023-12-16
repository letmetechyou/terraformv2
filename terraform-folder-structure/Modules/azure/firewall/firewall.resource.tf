resource "azurerm_firewall" "firewall" {
  for_each = { for key, value in var.firewall_data : key => value if value.enabled }

  # Required Arguments
  sku_name            = each.value.sku_name
  sku_tier            = each.value.sku_tier
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  name                = each.value.name


  # Required Blocks 



  # Optional Arguments
  firewall_policy_id = each.value.firewall_policy_id
  zones              = each.value.zones
  tags               = each.value.tags
  private_ip_ranges  = each.value.private_ip_ranges
  dns_servers        = each.value.dns_servers
  threat_intel_mode  = each.value.threat_intel_mode


  # Optional Dynamic Blocks
  dynamic "ip_configuration" {

    for_each = each.value.ip_configuration != null ? range(length(each.value.ip_configuration)) : []

    content {
      # Required
      name = each.value.ip_configuration[ip_configuration.key].name

      # Optional
      public_ip_address_id = each.value.ip_configuration[ip_configuration.key].public_ip_address_id
      subnet_id            = coalesce(
				try(each.value.ip_configuration[ip_configuration.key].subnet_id, null),
				try(var.subnet_output["${each.value.ip_configuration[ip_configuration.key].subnet_name}"].id, null),
				try(var.subnet_output["${each.value.ip_configuration[ip_configuration.key].subnet_key}"].id, null)
      )
    }
  }

  dynamic "virtual_hub" {

    for_each = each.value.virtual_hub != null ? range(length(each.value.virtual_hub)) : []

    content {
      # Required
      virtual_hub_id = each.value.virtual_hub[virtual_hub.key].virtual_hub_id

      # Optional
      public_ip_count = each.value.virtual_hub[virtual_hub.key].public_ip_count
    }
  }

  dynamic "management_ip_configuration" {

    for_each = each.value.management_ip_configuration != null ? range(length(each.value.management_ip_configuration)) : []

    content {
      # Required
      public_ip_address_id = coalesce(
		try(each.value.management_ip_configuration[management_ip_configuration.key].public_ip_address_id, null),
		try(var.public_ip_output["${each.value.management_ip_configuration[management_ip_configuration.key].public_ip_address_name}"].id, null),
		try(var.public_ip_output["${each.value.management_ip_configuration[management_ip_configuration.key].public_ip_address_key}"].id, null)
	)
      subnet_id	= coalesce(
		try(each.value.management_ip_configuration[management_ip_configuration.key].subnet_id, null),
		try(var.subnet_output["${each.value.management_ip_configuration[management_ip_configuration.key].subnet_name}"].id, null),
		try(var.subnet_output["${each.value.management_ip_configuration[management_ip_configuration.key].subnet_key}"].id, null)
      )
      name = each.value.management_ip_configuration[management_ip_configuration.key].name

      # Optional
    }
  }



  lifecycle {
    prevent_destroy = false
  }
}
