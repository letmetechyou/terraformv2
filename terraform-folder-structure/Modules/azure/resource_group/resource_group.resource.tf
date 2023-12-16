resource "azurerm_resource_group" "resource_group" {
	for_each = { for key, value in var.resource_group_data : key => value if value.enabled }

	name                    = each.value.name
	location                = each.value.location

	tags = merge(
		{"region" = each.value.location},
		#var.tag_data
	)
}

resource "azurerm_management_lock" "main" {
	for_each = { for key, value in var.resource_group_data : key => value if value.enabled && value.lock_enabled == true}
	name = "CanNotDelete_Lock"
	scope = azurerm_resource_group.resource_group[each.key].id
	lock_level = each.value.lock_level
}