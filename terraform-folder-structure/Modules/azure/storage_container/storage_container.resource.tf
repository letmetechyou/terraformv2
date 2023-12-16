resource "azurerm_storage_container" "storage_container" {
  for_each = { for key, value in var.storage_container_data : key => value if value.enabled }

  # Required Arguments
  storage_account_name = each.value.storage_account_name
  name                 = each.value.name


  # Required Blocks 



  # Optional Arguments
  container_access_type = each.value.container_access_type
  metadata              = each.value.metadata


  # Optional Dynamic Blocks


  lifecycle {
    prevent_destroy = false
  }
}
