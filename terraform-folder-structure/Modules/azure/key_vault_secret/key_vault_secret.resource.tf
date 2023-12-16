resource "azurerm_key_vault_secret" "key_vault_secret" {
  for_each = { for key, value in var.key_vault_secret_data : key => value if value.enabled }

  # Required Arguments
  name         = each.value.name
  value        = each.value.value
  key_vault_id = each.value.key_vault_id


  # Required Blocks 



  # Optional Arguments
  tags            = each.value.tags
  content_type    = each.value.content_type
  not_before_date = each.value.not_before_date
  expiration_date = each.value.expiration_date


  # Optional Dynamic Blocks


  lifecycle {
    prevent_destroy = false
  }
}
