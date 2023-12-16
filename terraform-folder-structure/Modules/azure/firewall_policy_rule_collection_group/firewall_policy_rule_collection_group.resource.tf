resource "azurerm_firewall_policy_rule_collection_group" "firewall_policy_rule_collection_group" {
  for_each = { for key, value in var.firewall_policy_rule_collection_group_data : key => value if value.enabled }

  # Required Arguments
  name                = each.value.name
  priority            = each.value.priority
  firewall_policy_id  = each.value.firewall_policy_id

  # Optional Arguments
  dynamic "application_rule_collection" {
    for_each = each.value.application_rule_collection != null ? [each.value.application_rule_collection] : []

    content {
      name    = application_rule_collection.value.name
      action  = application_rule_collection.value.action
      priority = application_rule_collection.value.priority

      dynamic "rule" {
        for_each = application_rule_collection.value.rule

        content {
          name                  = rule.value.name
          description           = rule.value.description
          terminate_tls         = rule.value.terminate_tls
          protocols {
            type = rule.value.protocols.type
            port = rule.value.protocols.port
          }
          source_addresses      = rule.value.source_addresses
          source_ip_groups      = rule.value.source_ip_groups
          destination_addresses = rule.value.destination_addresses
          destination_urls      = rule.value.destination_urls
          destination_fqdns     = rule.value.destination_fqdns
          destination_fqdn_tags = rule.value.destination_fqdn_tags
          web_categories        = rule.value.web_categories
        }
      }
    }
  }

  dynamic "nat_rule_collection" {
    for_each = each.value.nat_rule_collection != null ? [each.value.nat_rule_collection] : []

    content {
      name     = nat_rule_collection.value.name
      action   = nat_rule_collection.value.action
      priority = nat_rule_collection.value.priority

      dynamic "rule" {
        for_each = nat_rule_collection.value.rule

        content {
          name               = rule.value.name
          protocols		= rule.value.protocols
          source_addresses   = rule.value.source_addresses
          source_ip_groups   = rule.value.source_ip_groups
          destination_address = rule.value.destination_address
          destination_ports  = rule.value.destination_ports
          translated_address = rule.value.translated_address
          translated_fqdn    = rule.value.translated_fqdn
          translated_port    = rule.value.translated_port
        }
      }
    }
  }

  dynamic "network_rule_collection" {
    for_each = each.value.network_rule_collection != null ? [each.value.network_rule_collection] : []

    content {
      name     = network_rule_collection.value.name
      action   = network_rule_collection.value.action
      priority = network_rule_collection.value.priority

      dynamic "rule" {
        for_each = { for key, value in network_rule_collection.value.rules : key => value if value.enabled}

        content {
          name                  = rule.value.name
          protocols             = rule.value.protocols
          source_addresses      = rule.value.source_addresses
          source_ip_groups      = rule.value.source_ip_groups
          destination_ip_groups = rule.value.destination_ip_groups
          destination_addresses = rule.value.destination_addresses
          destination_ports     = rule.value.destination_ports
	  destination_fqdns 	= rule.value.destination_fqdns
	}
      }
    }
  }
}
