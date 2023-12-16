# LOG_ANALYTICS_WORKSPACE VALUES EXAMPLE
  log_analytics_workspace_data = {
    "workspace1" = {
      enabled                            = true,
      location                           = "East US",
      resource_group_name                = "my-resource-group",
      name                               = "workspace1",
      internet_query_enabled             = true,
      reservation_capacity_in_gb_per_day = 100,
      sku                                = "PerGB2018",
      local_authentication_disabled      = false,
      allow_resource_only_permissions    = true,
      cmk_for_query_forced               = true,
      internet_ingestion_enabled         = true,
      data_collection_rule_id            = "rule1",
      retention_in_days                  = 30,
      tags                               = {
        environment = "dev",
        project     = "my-project",
      },
      daily_quota_gb                     = 50,
    },
    "workspace2" = {
      enabled                            = false,
      location                           = "West US",
      resource_group_name                = "another-resource-group",
      name                               = "workspace2",
      internet_query_enabled             = false,
      reservation_capacity_in_gb_per_day = 50,
      sku                                = "PerGB2019",
      local_authentication_disabled      = true,
      allow_resource_only_permissions    = false,
      cmk_for_query_forced               = false,
      internet_ingestion_enabled         = false,
      data_collection_rule_id            = "rule2",
      retention_in_days                  = 60,
      tags                               = {
        environment = "prod",
        project     = "another-project",
      },
      daily_quota_gb                     = 100,
    },
  }

# LOG_ANALYTICS_WORKSPACE MODULE REFERENCE
module "log_analytics_workspace" {
        source = "./Modules/log_analytics_workspace"

        log_analytics_workspace_data = var.log_analytics_workspace_data
}

# LOG_ANALYTICS_WORKSPACE VARIABLE
variable "log_analytics_workspace_data" {
  description = "A map of Log Analytics workspace data."
  type = map(object({
        # Required
        enabled                            = bool,
        location                           = string,
        resource_group_name                = string,
        name                               = string,

        #Optional
        internet_query_enabled             = optional(bool),
        reservation_capacity_in_gb_per_day = optional(number),
        sku                                = optional(string),
        local_authentication_disabled      = optional(bool),
        allow_resource_only_permissions    = optional(bool),
        cmk_for_query_forced               = optional(bool),
        internet_ingestion_enabled         = optional(bool),
        data_collection_rule_id            = optional(string),
        retention_in_days                  = optional(number),
        tags                               = optional(map(string)),
        daily_quota_gb                     = optional(number),
  }))
  default = {}
}
