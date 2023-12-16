resource "azurerm_storage_share_directory" "storage_share_directory" {
  for_each = { for key, value in var.storage_share_directory_data : key => value if value.enabled }

  # Required Arguments
  name                 = each.value.name
  share_name           = each.value.share_name
  storage_account_name = each.value.storage_account_name


  # Required Blocks 



  # Optional Arguments
  metadata = each.value.metadata


  # Optional Dynamic Blocks


  lifecycle {
    prevent_destroy = false
  }
}
