resource "azurerm_marketplace_agreement" "marketplace_agreement" {
  for_each = { for key, value in var.marketplace_agreement_data : key => value if value.enabled }

  # Required Arguments
  plan      = each.value.plan
  offer     = each.value.offer
  publisher = each.value.publisher


  # Required Blocks 



  # Optional Arguments


  # Optional Dynamic Blocks


  lifecycle {
    prevent_destroy = false
  }
}
