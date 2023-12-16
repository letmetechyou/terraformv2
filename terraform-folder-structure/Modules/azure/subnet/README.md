# AZURE_SUBNET VALUES EXAMPLE
subnet_data = [
  {
    enabled              = true
    name                 = "subnet-1"
    resource_group_name  = "my-rg"
    virtual_network_name = "my-vnet"
    address_prefixes     = ["10.0.1.0/24"]

    delegation = {
      name = "delegation-1"
      service_delegation = {
        name    = "Microsoft.Storage/storageAccounts"
        actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
      }
    }

    private_endpoint_network_policies_enabled     = true
    private_link_service_network_policies_enabled = true
    service_endpoints                            = ["Microsoft.Sql", "Microsoft.Storage"]
    service_endpoint_policy_ids                  = ["policy-1", "policy-2"]

    tags = {
      environment = "dev"
      owner       = "John Doe"
    }
  },
  {
    enabled              = true
    name                 = "subnet-2"
    resource_group_name  = "my-rg"
    virtual_network_name = "my-vnet"
    address_prefixes     = ["10.0.2.0/24"]

    private_endpoint_network_policies_enabled     = false
    private_link_service_network_policies_enabled = false
    service_endpoints                            = []
    service_endpoint_policy_ids                  = []
    location                                     = "West US"

    tags = {
      environment = "prod"
      owner       = "Jane Smith"
    }
  }
]


# AZURE_SUBNET MODULE REFERENCE
module "azure_subnet" {
  source = "../../Landing Zone Modules/azure_subnet"

  subnet_data = var.subnet_data[0]
}

# AZURE_SUBNET VARIABLE
variable "subnet_data" {
  type = list(map(object({
    # Required
    enabled              = bool
    name                 = string
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = list(string)

    # Optional
    delegation = optional(object({
      name = string
      service_delegation = object({
        name    = string
        actions = list(string)
      })
    }))
    private_endpoint_network_policies_enabled     = optional(bool)
    private_link_service_network_policies_enabled = optional(bool)
    service_endpoints                            = optional(list(string))
    service_endpoint_policy_ids                  = optional(list(string))
    location                                     = optional(string)

    tags = optional(map(string))
  })))
}
