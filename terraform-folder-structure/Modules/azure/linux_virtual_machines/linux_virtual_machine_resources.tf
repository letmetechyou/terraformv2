resource "random_id" "id" {
  for_each = { for key, value in var.linux_virtual_machine_data : key => value if value.enabled }
  byte_length = 4
}

data "azurerm_resource_group" "main" {
  for_each = { for key, value in var.linux_virtual_machine_data : key => value if value.enabled }
  name     = each.value.existing_resource_group_name
}


data "azurerm_subnet" "main" {
  for_each             = { for key, value in var.linux_virtual_machine_data : key => value if value.enabled }
  name                 = each.value.existing_virtual_network_subnet
  virtual_network_name = each.value.existing_virtual_network
  resource_group_name  = each.value.existing_virtual_network_rg
}

resource "tls_private_key" "main" {
    for_each = { for key, value in var.linux_virtual_machine_data : key => value if value.enabled }
    algorithm = "RSA"
    rsa_bits = 4096
    lifecycle {
      ignore_changes = all 
    }
}

# resource "azurerm_key_vault_secret" "main-public" {
#   for_each = { for key, value in var.linux_virtual_machine_data : key => value if value.enabled }
#   name         = "${each.value.computer_name}-public-key"
#   key_vault_id = each.value.existing_key_vault_id
#   value        = tls_private_key.main[each.key].public_key_openssh
#       lifecycle {
#       ignore_changes = [value]
#     }
# }

# resource "azurerm_key_vault_secret" "main-private" {
#   for_each = { for key, value in var.linux_virtual_machine_data : key => value if value.enabled }
#   name         = "${each.value.computer_name}-private-key"
#   key_vault_id = each.value.existing_key_vault_id
#   value        = tls_private_key.main[each.key].private_key_pem
#       lifecycle {
#       ignore_changes = [value]
#     }
# }


resource "azurerm_network_interface" "main" {
  for_each = { for key, value in var.linux_virtual_machine_data : key => value if value.enabled }

  location            = each.value.location
  name                = lower("${each.value.computer_name}-${random_id.id[each.key].hex}-nic")
  resource_group_name = each.value.existing_resource_group_name
  dynamic "ip_configuration" {
    for_each = each.value.ip_configurations

    content {
      name                          = lower("${ip_configuration.value.name}-ip")
      subnet_id                     = data.azurerm_subnet.main[each.key].id
      primary                       = ip_configuration.value.primary
      private_ip_address_allocation = "Dynamic"
    }
  }
}

resource "azurerm_marketplace_agreement" "main" {
  for_each = { for key, value in var.linux_virtual_machine_data : key => value if value.enabled }

  # Required Arguments
  publisher                 = each.value.source_image_reference.publisher
  offer                     = each.value.source_image_reference.offer
  plan                      = each.value.source_image_reference.sku

  # Might be necessary for other linux VMs to be able to sign the agreement?
  /* lifecycle {
    prevent_destroy = false
  } */
}


resource "azurerm_managed_disk" "main" {
  for_each = { for key, value in var.linux_virtual_machine_data : key => value if value.enabled }
  location            = each.value.location
  resource_group_name = each.value.existing_resource_group_name
  name                 = lower("${each.value.computer_name}-${random_id.id[each.key].hex}-datadisk")
  create_option        ="Empty"
  storage_account_type = each.value.data_disk_storage_account_type
  disk_size_gb         = each.value.data_disk_disk_size_gb
  zone = each.value.zone
}

resource "azurerm_virtual_machine_data_disk_attachment" "main" {
  for_each = { for key, value in var.linux_virtual_machine_data : key => value if value.enabled }

  caching                   = each.value.data_disk_caching
  managed_disk_id           = azurerm_managed_disk.main[each.key].id
  virtual_machine_id        = azurerm_linux_virtual_machine.main[each.key].id
  lun = "0"
}

resource "azurerm_linux_virtual_machine" "main" {
  for_each = { for key, value in var.linux_virtual_machine_data : key => value if value.enabled }

  name                  = lower(each.value.computer_name)
  admin_username        = "${each.value.computer_name}-adm"
  disable_password_authentication = true
  location              = each.value.location
  network_interface_ids = [azurerm_network_interface.main[each.key].id]
  resource_group_name   = each.value.existing_resource_group_name
  size                  = each.value.size
  zone                  = each.value.zone
  
  plan {
      publisher  = azurerm_marketplace_agreement.main[each.key].publisher
      product    = azurerm_marketplace_agreement.main[each.key].offer
      name       = azurerm_marketplace_agreement.main[each.key].plan
   } 

  admin_ssh_key {
    username = "${each.value.computer_name}-adm"
    public_key = tls_private_key.main[each.key].public_key_openssh
  }

  os_disk {
    caching              = each.value.os_disk.os_disk_caching
    storage_account_type = each.value.os_disk.os_disk_storage_account_type
    name                 = lower("${each.value.computer_name}-${random_id.id[each.key].hex}-os_disk")
  }

  boot_diagnostics {
    storage_account_uri = null
  }

  identity {
    type = "SystemAssigned"
  }

  source_image_reference {
    offer     = each.value.source_image_reference.offer
    publisher = each.value.source_image_reference.publisher
    sku       = each.value.source_image_reference.sku
    version   = each.value.source_image_reference.version
  }

  lifecycle {
    ignore_changes = all
  }
}



