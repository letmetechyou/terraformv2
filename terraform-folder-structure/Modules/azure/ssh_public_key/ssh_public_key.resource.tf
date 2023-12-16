resource "azurerm_ssh_public_key" "ssh_public_key" {
  for_each = { for key, value in var.ssh_public_key_data : key => value if value.enabled }

  # Required Arguments
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  name                = each.value.name
  public_key          = each.value.public_key


  # Required Blocks 



  # Optional Arguments
  tags = each.value.tags


  # Optional Dynamic Blocks


  lifecycle {
    prevent_destroy = false
  }
}
