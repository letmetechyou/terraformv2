# resource "azurerm_firewall_policy" "firewall_policy" {
# 	for_each = { for key, value in var.firewall_policy_data : key => value if value.enabled }

# 	name                = each.value.name
# 	location            = each.value.location
# 	resource_group_name = each.value.resource_group_name

# 	threat_intel_mode = each.value.threat_intel_mode

# 	tags = each.value.tags
# }


resource "azurerm_firewall_policy" "firewall_policy" {
  for_each = { for key, value in var.firewall_policy_data : key => value if value.enabled }

  # Required Arguments
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  # Optional Arguments
  base_policy_id            = each.value.base_policy_id
  auto_learn_private_ranges_enabled = each.value.auto_learn_private_ranges_enabled
  sku                       = each.value.sku
  threat_intelligence_mode = each.value.threat_intelligence_mode

  dynamic "dns" {
    for_each = each.value.dns != null ? [each.value.dns] : []
    content {
      proxy_enabled = dns.value.proxy_enabled
      servers       = dns.value.servers
    }
  }

  dynamic "identity" {
    for_each = each.value.identity != null ? [each.value.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  dynamic "insights" {
    for_each = each.value.insights != null ? [each.value.insights] : []
    content {
      enabled                       = insights.value.enabled
      default_log_analytics_workspace_id = insights.value.default_log_analytics_workspace_id
      retention_in_days             = insights.value.retention_in_days

      dynamic "log_analytics_workspace" {
        for_each = insights.value.log_analytics_workspace
        content {
          id               = log_analytics_workspace.value.id
          firewall_location = log_analytics_workspace.value.firewall_location
        }
      }
    }
  }

  dynamic "intrusion_detection" {
    for_each = each.value.intrusion_detection != null ? [each.value.intrusion_detection] : []
    content {
      mode                = intrusion_detection.value.mode

      dynamic "signature_overrides" {
        for_each = intrusion_detection.value.signature_overrides
        content {
          id    = signature_overrides.value.id
          state = signature_overrides.value.state
        }
      }

      dynamic "traffic_bypass" {
        for_each = intrusion_detection.value.traffic_bypass
        content {
          name       = traffic_bypass.value.name
          protocol   = traffic_bypass.value.protocol
          description = lookup(traffic_bypass.value, "description", null)
          destination_addresses = lookup(traffic_bypass.value, "destination_addresses", null)
          destination_ip_groups = lookup(traffic_bypass.value, "destination_ip_groups", null)
          destination_ports     = lookup(traffic_bypass.value, "destination_ports", null)
          source_addresses      = lookup(traffic_bypass.value, "source_addresses", null)
          source_ip_groups      = lookup(traffic_bypass.value, "source_ip_groups", null)
        }
      }

      private_ranges = intrusion_detection.value.private_ranges
    }
  }

  private_ip_ranges = each.value.private_ip_ranges

  dynamic "tls_certificate" {
    for_each = each.value.tls_certificate != null ? each.value.tls_certificate : []
    content {
      key_vault_secret_id = tls_certificate.value.key_vault_secret_id
      name               = tls_certificate.value.name
    }
  }

  sql_redirect_allowed = each.value.sql_redirect_allowed

  dynamic "explicit_proxy" {
    for_each = each.value.explicit_proxy != null ? [each.value.explicit_proxy] : []
    content {
      enabled         = explicit_proxy.value.enabled
      http_port       = lookup(explicit_proxy.value, "http_port", null)
      https_port      = lookup(explicit_proxy.value, "https_port", null)
      enable_pac_file = lookup(explicit_proxy.value, "enable_pac_file", null)
      pac_file_port   = lookup(explicit_proxy.value, "pac_file_port", null)
      pac_file        = lookup(explicit_proxy.value, "pac_file", null)
    }
  }

  dynamic "threat_intelligence_allowlist" {
    for_each = each.value.threat_intelligence_allowlist != null ? [each.value.threat_intelligence_allowlist] : []
    content {
      fqdns        = threat_intelligence_allowlist.value.fqdns
      ip_addresses = threat_intelligence_allowlist.value.ip_addresses
    }
  }

  tags = each.value.tags
}
