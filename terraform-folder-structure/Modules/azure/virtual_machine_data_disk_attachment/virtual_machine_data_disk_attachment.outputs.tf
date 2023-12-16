output "virtual_machine_data_disk_attachment_output" {
  value = values(azurerm_virtual_machine_data_disk_attachment.virtual_machine_data_disk_attachment)[*]
}