resource "azurerm_backup_policy_vm" "backup_policy_vm" {
  for_each = { for key, value in var.backup_policy_vm_data : key => value if value.enabled }

  # Required Arguments
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  recovery_vault_name = each.value.recovery_vault_name

  # Required Blocks
  backup {
    frequency = each.value.name
    time      = each.value.time
  }
  # Optional Arguments

  policy_type                    = each.value.policy_type
  timezone                       = each.value.timezone
  instant_restore_retention_days = each.value.instant_restore_retention_days


  # Optional Blocks

  instant_restore_resource_group {
    prefix = each.value.prefix
  }

  retention_daily {
    count = each.value.count
  }

  retention_weekly {
    count    = each.value.count
    weekdays = each.value.weekdays
}

  retention_monthly {
    count = each.value.count
  }

  retention_yearly {
    count  = each.value.count
    months = each.value.months
  }

}
