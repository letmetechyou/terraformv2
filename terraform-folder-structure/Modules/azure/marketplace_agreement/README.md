# MARKETPLACE_AGREEMENT VALUES EXAMPLE
marketplace_agreement_data = {
  agreement1 = {
    enabled   = true
    plan      = "plan-1"
    offer     = "offer-1"
    publisher = "publisher-1"
  },
  agreement2 = {
    enabled   = true
    plan      = "plan-2"
    offer     = "offer-2"
    publisher = "publisher-2"
  },
}

# MARKETPLACE_AGREEMENT MODULE REFERENCE
module "marketplace_agreement" {
        source = "./Modules/marketplace_agreement"

        marketplace_agreement_data = var.marketplace_agreement_data
}

# MARKETPLACE_AGREEMENT VARIABLE
variable "marketplace_agreement_data" {
  type = map(object({
    # Required
    enabled   = bool
    plan      = string
    offer     = string
    publisher = string

    # Optional

    # Optional Dynamic Blocks
  }))
  default = {}
}
