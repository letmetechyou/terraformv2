# AZURE_PRIVATE_DNS_RESOLVER_OUTBOUND_ENDPOINT VALUES EXAMPLE
private_dns_resolver_outbound_endpoint_data = {
  endpoint1 = {
    enabled                 = true
    name                    = "endpoint-1"
    location                = "eastus"
    private_dns_resolver_id = "resolver-1"
    subnet_id               = "subnet-1"
  },
  endpoint2 = {
    enabled                 = true
    name                    = "endpoint-2"
    location                = "westus"
    private_dns_resolver_id = "resolver-2"
    subnet_id               = "subnet-2"
  },
  # Add more endpoints as needed
}


# AZURE_PRIVATE_DNS_RESOLVER_OUTBOUND_ENDPOINT MODULE REFERENCE
module "private_dns_resolver_outbound_endpoint" {
        source = "./Modules/private_dns_resolver_outbound_endpoint"

        private_dns_resolver_outbound_endpoint_data = var.private_dns_resolver_outbound_endpoint_data
        private_dns_resolver_output = module.private_dns_resolver_output.private_dns_resolver_output_names
        subnet_output = module.subnet.subnet_output_names
}

# AZURE_PRIVATE_DNS_RESOLVER_OUTBOUND_ENDPOINT VARIABLE
variable "private_dns_resolver_outbound_endpoint_data" {
  type = map(object({
    # Required
    enabled                   = bool
    name                      = string
    location                  = string
    private_dns_resolver_id   = optional(string)
    private_dns_resolver_name = optional(string)
    private_dns_resolver_key = optional(string)
    subnet_id                 = optional(string)
    subnet_name               = optional(string)
    subnet_key                = optional(string)

    # Optional
    tags = optional(list(string))
    # Add optional attributes if needed
  }))
}

