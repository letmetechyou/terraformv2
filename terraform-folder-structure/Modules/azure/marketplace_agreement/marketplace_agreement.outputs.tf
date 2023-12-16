output "marketplace_agreement_output" {
  value = values(azurerm_marketplace_agreement.marketplace_agreement)[*]
}
