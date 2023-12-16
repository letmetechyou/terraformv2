# AZURE_PUBLIC_IP VALUES EXAMPLE
public_ip_data = [
  {
    "ip1" = {
      enabled            = true
      name               = "my-public-ip"
      location           = "East US"
      resource_group_name = "my-resource-group"
      allocation_method  = "Dynamic"
      sku_name           = "Basic"

      tags = {
        environment = "Production"
      }
    }
  },
]

# AZURE_PUBLIC_IP MODULE REFERENCE
module "azure_public_ip" {
  source = "../../Landing Zone Modules/azure_public_ip"

  public_ip_data = var.public_ip_data[0]
}

# AZURE_PUBLIC_IP VARIABLE
variable "public_ip_data" {
  type = list(map(object({
    # Required
    name                = string
    resource_group_name = string
    location            = string
    allocation_method   = string

    # Optional
    zones                        = list(string)
    ddos_protection_mode          = string
    ddos_protection_plan_id       = string
    domain_name_label            = string
    edge_zone                    = string
    idle_timeout_in_minutes      = number
    ip_tags                      = map(string)
    ip_version                   = string
    public_ip_prefix_id          = string
    reverse_fqdn                 = string
    sku                          = string
    sku_tier                     = string

    tags                         = map(string)
    enabled                      = bool
  })))
}