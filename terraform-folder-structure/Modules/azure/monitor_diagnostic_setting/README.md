# MONITOR_DIAGNOSTIC_SETTING VALUES EXAMPLE
monitor_diagnostic_setting_data = {
  setting1 = {
    enabled              = true
    name                 = "setting-1"
    target_resource_id   = "/subscriptions/sub-id-1/resourceGroups/rg-1/providers/Microsoft.Compute/virtualMachines/vm-1"
    log_analytics_workspace_id     = "/subscriptions/sub-id-1/resourceGroups/rg-1/providers/Microsoft.OperationalInsights/workspaces/workspace-1"
    storage_account_id             = "/subscriptions/sub-id-1/resourceGroups/rg-1/providers/Microsoft.Storage/storageAccounts/storage-account-1"
    eventhub_name                  = "eventhub-1"
    eventhub_authorization_rule_id = "/subscriptions/sub-id-1/resourceGroups/rg-1/providers/Microsoft.EventHub/namespaces/namespace-1/eventhubs/eventhub-1/authorizationrules/authorization-rule-1"
    log_analytics_destination_type = "Dedicated"
    partner_solution_id            = "partner-solution-1"
    
    metric = [
      {
        category = "AllMetrics"
        enabled  = true
        retention_policy = {
          enabled = true
          days    = 30
        }
      },
    ]

    enabled_log = [
      {
        category_group = "Operations"
        category       = "Write"
        retention_policy = {
          enabled = true
          days    = 14
        }
      },
    ]

    log = [
      {
        category_group = "Administrative"
        enabled        = true
        category       = "AllLogs"
        retention_policy = {
          enabled = true
          days    = 90
        }
      },
    ]
  },
  setting2 = {
    enabled              = true
    name                 = "setting-2"
    target_resource_id   = "/subscriptions/sub-id-2/resourceGroups/rg-2/providers/Microsoft.Compute/virtualMachines/vm-2"
  },
}

# MONITOR_DIAGNOSTIC_SETTING MODULE REFERENCE
module "monitor_diagnostic_setting" {
        source = "./Modules/monitor_diagnostic_setting"

        monitor_diagnostic_setting_data = var.monitor_diagnostic_setting_data
}

# MONITOR_DIAGNOSTIC_SETTING VARIABLE
variable "monitor_diagnostic_setting_data" {
  type = map(object({
    # Required
    enabled              = bool
    name                 = string
    target_resource_id   = string

    # Optional
    log_analytics_workspace_id     = optional(string)
    storage_account_id             = optional(string)
    eventhub_name                  = optional(string)
    eventhub_authorization_rule_id = optional(string)
    log_analytics_destination_type = optional(string)
    partner_solution_id            = optional(string)

    # Optional Dynamic Blocks
    metric = optional(list(object({
      # Required
      category = string

      # Optional
      enabled          = bool

      # Optional Dynamic Blocks
      retention_policy = optional(object({
        # Required
        enabled = bool

        # Optional
        days = number
      }))
    })))

    enabled_log = optional(list(object({
      # Required
      category_group   = string
      category         = string

      # Optional Dynamic Blocks
      retention_policy = optional(object({
        # Required
        enabled = bool

        # Optional
        days = number
      }))
    })))

    log = optional(list(object({
      # Required
      category_group   = string
      enabled          = bool
      category         = string

      # Optional Blocks
      retention_policy = optional(object({
        # Required
        enabled = bool

        # Optional
        days = number
      }))
    })))
  }))
  default = {}
}
