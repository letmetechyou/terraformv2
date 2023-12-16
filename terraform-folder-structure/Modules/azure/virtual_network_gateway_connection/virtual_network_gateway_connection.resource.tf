resource "azurerm_virtual_network_gateway_connection" "virtual_network_gateway_connection" {
  for_each = { for key, value in var.virtual_network_gateway_connection_data : key => value if value.enabled }

  # Required Arguments
  virtual_network_gateway_id = each.value.virtual_network_gateway_id
  type                       = each.value.type
  resource_group_name        = each.value.resource_group_name
  name                       = each.value.name
  location                   = each.value.location
  authorization_key          = each.value.type == "ExpressRoute" ? null : var.express_route_circuit_authorization_output["each.value.authorization_key_name"].authorization_key


  # Required Blocks 



  # Optional Arguments
  connection_protocol             = each.value.connection_protocol
  local_azure_ip_address_enabled  = each.value.local_azure_ip_address_enabled
  shared_key                      = each.value.shared_key
  routing_weight                  = each.value.routing_weight
  express_route_gateway_bypass    = each.value.express_route_gateway_bypass
  enable_bgp                      = each.value.enable_bgp
  peer_virtual_network_gateway_id = each.value.peer_virtual_network_gateway_id
  tags                            = each.value.tags
  dpd_timeout_seconds             = each.value.dpd_timeout_seconds
  express_route_circuit_id        = each.value.express_route_circuit_id
  ingress_nat_rule_ids            = each.value.ingress_nat_rule_ids
  connection_mode                 = each.value.connection_mode
  egress_nat_rule_ids             = each.value.egress_nat_rule_ids
  local_network_gateway_id        = each.value.local_network_gateway_id


  # Optional Dynamic Blocks
  dynamic "ipsec_policy" {

    for_each = each.value.ipsec_policy != null ? range(length(each.value.ipsec_policy)) : []

    content {
      # Required
      ipsec_encryption = each.value.ipsec_policy[ipsec_policy.key].ipsec_encryption
      pfs_group        = each.value.ipsec_policy[ipsec_policy.key].pfs_group
      ipsec_integrity  = each.value.ipsec_policy[ipsec_policy.key].ipsec_integrity
      ike_encryption   = each.value.ipsec_policy[ipsec_policy.key].ike_encryption
      ike_integrity    = each.value.ipsec_policy[ipsec_policy.key].ike_integrity
      dh_group         = each.value.ipsec_policy[ipsec_policy.key].dh_group

      # Optional
      sa_lifetime = each.value.ipsec_policy[ipsec_policy.key].sa_lifetime
      sa_datasize = each.value.ipsec_policy[ipsec_policy.key].sa_datasize
    }
  }

  dynamic "traffic_selector_policy" {

    for_each = each.value.traffic_selector_policy != null ? range(length(each.value.traffic_selector_policy)) : []

    content {
      # Required
      remote_address_cidrs = each.value.traffic_selector_policy[traffic_selector_policy.key].remote_address_cidrs
      local_address_cidrs  = each.value.traffic_selector_policy[traffic_selector_policy.key].local_address_cidrs

      # Optional
    }
  }

  dynamic "custom_bgp_addresses" {

    for_each = each.value.custom_bgp_addresses != null ? range(length(each.value.custom_bgp_addresses)) : []

    content {
      # Required
      primary = each.value.custom_bgp_addresses[custom_bgp_addresses.key].primary

      # Optional
      secondary = each.value.custom_bgp_addresses[custom_bgp_addresses.key].secondary
    }
  }



  lifecycle {
    prevent_destroy = false
  }
}
