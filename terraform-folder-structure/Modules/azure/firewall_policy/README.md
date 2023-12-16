# AZURE_FIREWALL_POLICY VALUES EXAMPLE
firewall_policy_data = [
  {
    "policy1" = {
      enabled = true
      location = "East US"
      name = "my-firewall-policy"
      resource_group_name = "my-resource-group"
      base_policy_id = "base-policy-id-1"

      dns = {
        proxy_enabled = false
        servers       = ["8.8.8.8", "8.8.4.4"]
      }

      identity = {
        type         = "UserAssigned"
        identity_ids = ["identity-id-1", "identity-id-2"]
      }

      insights = {
        enabled                       = true
        default_log_analytics_workspace_id = "log-analytics-workspace-id-1"
        retention_in_days             = 30
        log_analytics_workspace = [
          {
            id               = "log-analytics-workspace-id-1"
            firewall_location = "East US"
          },
          {
            id               = "log-analytics-workspace-id-2"
            firewall_location = "West US"
          }
        ]
      }

      intrusion_detection = {
        mode = "Alert"

        signature_overrides = [
          {
            id    = "signature-id-1"
            state = "Alert"
          },
          {
            id    = "signature-id-2"
            state = "Deny"
          }
        ]

        traffic_bypass = [
          {
            name       = "bypass-rule-1"
            protocol   = "TCP"
            description = "Bypass TCP traffic"
          },
          {
            name       = "bypass-rule-2"
            protocol   = "UDP"
          }
        ]

        private_ranges = ["192.168.1.0/24", "10.0.0.0/16"]
      }

      private_ip_ranges = ["10.0.0.0/24", "172.16.0.0/24"]
      auto_learn_private_ranges_enabled = true
      sku = "Standard"

      tags = {
        environment = "Production"
        owner       = "John Doe"
      }

      threat_intelligence_allowlist = {
        fqdns        = ["example.com", "example.org"]
        ip_addresses = ["192.0.2.1", "203.0.113.0/24"]
      }

      threat_intelligence_mode = "Alert"

      tls_certificate = [
        {
          key_vault_secret_id = "key-vault-secret-id-1"
          name               = "certificate-1"
        },
        {
          key_vault_secret_id = "key-vault-secret-id-2"
          name               = "certificate-2"
        }
      ]

      sql_redirect_allowed = true

      explicit_proxy = {
        enabled         = true
        http_port       = 8080
        https_port      = 8443
        enable_pac_file = true
        pac_file_port   = 8888
        pac_file        = "https://example.com/proxy.pac"
      }
    }
  },
  {
    "policy2" = {
      # Define the configuration for another firewall policy if needed.
    }
  }
]


# AZURE_FIREWALL_POLICY MODULE REFERENCE
module "azure_firewall_policy" {
  source = "../../Landing Zone Modules/azure_firewall_policy"

  firewall_policy_data = var.firewall_policy_data[0]
}

# AZURE_FIREWALL_POLICY VARIABLE
variable "firewall_policy_data" {
  type = list(map(object({
    # Required
    location             = string
    name                 = string
    resource_group_name  = string

    # Optional
    base_policy_id       = string

    dns = optional(object({
      proxy_enabled = bool
      servers       = list(string)
    }))

    identity = optional(object({
      type         = string
      identity_ids = list(string)
    }))

    insights = optional(object({
      enabled                       = bool
      default_log_analytics_workspace_id = string
      retention_in_days             = number
      log_analytics_workspace = optional(list(object({
        id               = string
        firewall_location = string
      })))
    }))

    intrusion_detection = optional(object({
      mode                = string
      signature_overrides = optional(list(object({
        id    = string
        state = string
      })))
      traffic_bypass      = optional(list(object({
        name                  = string
        protocol              = string
        description           = optional(string)
        destination_addresses = optional(list(string))
        destination_ip_groups = optional(list(string))
        destination_ports     = optional(list(string))
        source_addresses      = optional(list(string))
        source_ip_groups      = optional(list(string))
      })))
      private_ranges       = optional(list(string))
    }))

    private_ip_ranges = optional(list(string))
    auto_learn_private_ranges_enabled = optional(bool)
    sku               = optional(string)
    tags              = optional(map(string))

    threat_intelligence_allowlist = optional(object({
      fqdns        = optional(list(string))
      ip_addresses = optional(list(string))
    }))

    threat_intelligence_mode = optional(string)
    tls_certificate         = optional(list(object({
      key_vault_secret_id = string
      name               = string
    })))

    sql_redirect_allowed = optional(bool)
    explicit_proxy       = optional(object({
      enabled          = bool
      http_port        = optional(number)
      https_port       = optional(number)
      enable_pac_file  = optional(bool)
      pac_file_port    = optional(number)
      pac_file         = optional(string)
    }))
  })))
}



