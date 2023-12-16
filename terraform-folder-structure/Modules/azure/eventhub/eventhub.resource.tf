resource "azurerm_eventhub" "eventhub" {
  for_each = { for key, value in var.eventhub_data : key => value if value.enabled }

  # Required Arguments
  namespace_name      = each.value.namespace_name
  message_retention   = each.value.message_retention
  resource_group_name = each.value.resource_group_name
  name                = each.value.name
  partition_count     = each.value.partition_count


  # Required Blocks 



  # Optional Arguments
  status = each.value.status


  # Optional Dynamic Blocks
  dynamic "capture_description" {

    for_each = each.value.capture_description != null ? [1] : []

    content {
      # Required
	destination {
		# Required
		archive_name_format = each.value.capture_description.destination.archive_name_format
		blob_container_name = each.value.capture_description.destination.blob_container_name
		name                = each.value.capture_description.destination.name
		storage_account_id  = each.value.capture_description.destination.storage_account_id
		# Optional
	}
      enabled     = each.value.capture_description[capture_description.key].enabled
      encoding    = each.value.capture_description[capture_description.key].encoding

      # Optional
      skip_empty_archives = each.value.capture_description[capture_description.key].skip_empty_archives
      size_limit_in_bytes = each.value.capture_description[capture_description.key].size_limit_in_bytes
      interval_in_seconds = each.value.capture_description[capture_description.key].interval_in_seconds
    }
  }



  lifecycle {
    prevent_destroy = false
  }
}
