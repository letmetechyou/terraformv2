resource "azurerm_log_analytics_workspace" "main" {
  for_each = { for key, value in var.log_analytics_workspace_data : key => value if value.enabled }

  # Required Arguments
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  name                = each.value.name


  # Required Blocks 



  # Optional Arguments
  internet_query_enabled             = each.value.internet_query_enabled
  reservation_capacity_in_gb_per_day = each.value.reservation_capacity_in_gb_per_day
  sku                                = each.value.sku
  local_authentication_disabled      = each.value.local_authentication_disabled
  allow_resource_only_permissions    = each.value.allow_resource_only_permissions
  cmk_for_query_forced               = each.value.cmk_for_query_forced
  internet_ingestion_enabled         = each.value.internet_ingestion_enabled
  data_collection_rule_id            = each.value.data_collection_rule_id
  retention_in_days                  = each.value.retention_in_days
  tags                               = each.value.tags
  daily_quota_gb                     = each.value.daily_quota_gb


  # Optional Dynamic Blocks


  lifecycle {
    prevent_destroy = false
  }
}
