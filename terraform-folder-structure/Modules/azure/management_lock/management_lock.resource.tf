resource "azurerm_management_lock" "management_lock" {
  for_each = { for key, value in var.management_lock_data : key => value if value.enabled }

  # Required Arguments
  lock_level = each.value.lock_level
  scope      = coalesce(
	try(each.value.scope, null),
	try(var.module_output["${each.value.name}"].id, null),
	try(var.module_output["${each.value.key}"].id, null)
  )
  name       = each.value.name


  # Required Blocks 



  # Optional Arguments
  notes = each.value.notes


  # Optional Dynamic Blocks


  lifecycle {
    prevent_destroy = false
  }
}
