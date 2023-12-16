resource "azurerm_virtual_machine_extension" "virtual_machine_extension" {
  for_each = { for key, value in var.virtual_machine_extension_data : "${key}-${value.type}" => value if value.enabled }

  # Required Arguments
  type_handler_version = each.value.type_handler_version
  type                 = each.value.type
  publisher            = each.value.publisher
  virtual_machine_id   = coalesce(
		try(each.value.virtual_machine_id, null),
		try(var.virtual_machine_output["${each.value.virtual_machine_name}"].id, null),
		try(var.virtual_machine_output["${each.value.virtual_machine_key}"].id, null)
	)
  name                 = each.value.name


  # Required Blocks 



  # Optional Arguments


  # Optional Dynamic Blocks
  dynamic "protected_settings_from_key_vault" {

    for_each = each.value.protected_settings_from_key_vault != null ? range(length(each.value.protected_settings_from_key_vault)) : []

    content {
      # Required
      source_vault_id = each.value.protected_settings_from_key_vault[protected_settings_from_key_vault.key].source_vault_id
      secret_url      = each.value.protected_settings_from_key_vault[protected_settings_from_key_vault.key].secret_url

      # Optional
    }
  }



  lifecycle {
    prevent_destroy = false
  }
}
