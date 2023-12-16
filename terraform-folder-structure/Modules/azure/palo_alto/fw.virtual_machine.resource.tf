# Create the firewall VM
resource "azurerm_virtual_machine" "virtual_machine" {
	for_each = merge([for k, v in var.fw_data : 
	{ for i in range(v.qty) : "${v.name_prefix}${format("%02d", v.start+i)}" => v if v.build}]...)

	name                  = each.key
	location              = each.value.location
	resource_group_name   = each.value.resource_group_name
	vm_size               = each.value.vm_size
	
	dynamic "boot_diagnostics" {

		for_each = each.value.boot_diagnostics != null ? [1] : []

		content {

			enabled = each.value.boot_diagnostics.enabled
			storage_uri = each.value.boot_diagnostics.storage_uri
		}
	}

	availability_set_id   = can(each.value.availability_set_name) ? var.availability_set_output["${each.value.availability_set_name}"].id : null
  
	plan {
		name      = each.value.plan.name
		publisher = each.value.plan.publisher
		product   = each.value.plan.product
	}

	storage_image_reference {

		publisher	= lookup(each.value.storage_image_reference, "publisher", null)
		offer		= lookup(each.value.storage_image_reference, "offer", null)
		sku		= lookup(each.value.storage_image_reference, "sku", null)
		version		= lookup(each.value.storage_image_reference, "version", null)
		id		= lookup(each.value.storage_image_reference, "id", null)
	}
        delete_os_disk_on_termination = each.value.delete_os_disk_on_termination

	storage_os_disk {
		name          = "${each.key}-osDisk"
		caching       = each.value.storage_os_disk.caching
		create_option = each.value.storage_os_disk.create_option
	}

	os_profile {
		computer_name  = each.key
		admin_username = each.value.os_profile.admin_username
		admin_password = try(each.value.os_profile.admin_password,null)

		custom_data = base64encode(each.value.os_profile.custom_data)
	}
  # 1st = mgmt, 2nd = Ethernet1/1, 3rd = Ethernet1/2 
  # [FOR] NETWORK CONFIGURATION - REQUIRES ALPHABETIC ORDER OF KEYS
  	primary_network_interface_id = azurerm_network_interface.network_interface[join("-",[each.key,keys(each.value.network_configuration)[0]])].id
	network_interface_ids = [for nic in keys(each.value.network_configuration) : azurerm_network_interface.network_interface[join("-",[each.key,nic])].id ]

/*   INDIVIDUAL
	network_interface_ids = [azurerm_network_interface.avd_fw_nic[join("-",[each.value.name,keys(each.value.network_configuration)[0]])].id,
				azurerm_network_interface.avd_fw_nic[join("-",[each.value.name,keys(each.value.network_configuration)[1]])].id,
			   	azurerm_network_interface.avd_fw_nic[join("-",[each.value.name,keys(each.value.network_configuration)[2]])].id ]
 */
	
  dynamic "os_profile_linux_config" {

    for_each = each.value.os_profile_linux_config != null ? [1] : []

    content {
      # Required
      disable_password_authentication = each.value.os_profile_linux_config.disable_password_authentication

      # Optional
      dynamic "ssh_keys" {

        for_each = each.value.os_profile_linux_config.ssh_keys != null ? [1] : []

        content {
          # Required
          key_data = coalesce(
		try(each.value.os_profile_linux_config.ssh_keys.key_data, null),
		try(var.ssh_public_key_output["${each.value.os_profile_linux_config.ssh_keys.key_name}"].public_key, null)
	  )
          path     = each.value.os_profile_linux_config.ssh_keys.path

          # Optional
        }
      }

    }
  }

	depends_on = [
    		#azurerm_availability_set.as,
		#azurerm_marketplace_agreement.paloalto
	]
	
	tags = each.value.tags


	lifecycle {
		prevent_destroy = false
		ignore_changes = [ os_profile_linux_config ]
	}
}