resource "azurerm_virtual_machine_data_disk_attachment" "virtual_machine_data_disk_attachment" {
  for_each = { for key, value in var.virtual_machine_data_disk_attachment_data : key => value if value.enabled }

  # Required Arguments
  managed_disk_id    = coalesce(
	try(each.value.managed_disk_id, null),
	try(var.managed_disk_output["${each.value.managed_disk_name}"].id, null),
	try(var.managed_disk_output["${each.value.managed_disk_key}"].id, null)
  )
  lun                = each.value.lun
  virtual_machine_id = coalesce(
	try(each.value.virtual_machine_id, null),
	try(var.virtual_machine_output["${each.value.virtual_machine_name}"].id, null),
	try(var.virtual_machine_output["${each.value.virtual_machine_key}"].id, null)
  )
  caching            = each.value.caching


  # Required Blocks 



  # Optional Arguments
  create_option             = each.value.create_option
  write_accelerator_enabled = each.value.write_accelerator_enabled


  # Optional Dynamic Blocks


  lifecycle {
    prevent_destroy = false
  }
}
