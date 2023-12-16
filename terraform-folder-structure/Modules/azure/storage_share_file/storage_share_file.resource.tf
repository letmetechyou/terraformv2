resource "azurerm_storage_share_file" "storage_share_file" {
  for_each = { for key, value in var.storage_share_file_data : key => value if value.enabled }

  # Required Arguments
  storage_share_id = each.value.storage_share_id
  name             = each.value.name


  # Required Blocks 



  # Optional Arguments
  content_type        = each.value.content_type
  path                = each.value.path
  content_md5         = each.value.content_md5
  metadata            = each.value.metadata
  content_disposition = each.value.content_disposition
  source              = each.value.source
  content_encoding    = each.value.content_encoding


  # Optional Dynamic Blocks


  lifecycle {
    prevent_destroy = false
  }
}
