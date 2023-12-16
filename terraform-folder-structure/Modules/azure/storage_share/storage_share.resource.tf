resource "azurerm_storage_share" "storage_share" {
  for_each = { for key, value in var.storage_share_data : key => value if value.enabled }

  # Required Arguments
  name                 = each.value.name
  quota                = each.value.quota
  storage_account_name = each.value.storage_account_name


  # Required Blocks 



  # Optional Arguments
  metadata         = each.value.metadata
  access_tier      = each.value.access_tier
  enabled_protocol = each.value.enabled_protocol


  # Optional Dynamic Blocks
  dynamic "acl" {

    for_each = each.value.acl != null ? range(length(each.value.acl)) : []

    content {
      # Required
      id = each.value.acl[acl.key].id

      # Optional

      # Optional Dynamic Blocks
      dynamic "access_policy" {

        for_each = each.value.acl[acl.key].access_policy != null ? [1] : []

        content {
          # Required
          permissions = each.value.acl[acl.key].access_policy.permissions

          # Optional
          start  = each.value.acl[acl.key].access_policy.start
          expiry = each.value.acl[acl.key].access_policy.expiry
        }
      }
    }
  }



  lifecycle {
    prevent_destroy = false
  }
}
