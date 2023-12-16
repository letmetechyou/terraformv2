# PRIVATE_DNS_RESOLVER_DNS_FORWARDING_RULESET VALUES EXAMPLE
private_dns_resolver_dns_forwarding_ruleset_data = {
  ruleset1 = {
    enabled                                = true
    private_dns_resolver_outbound_endpoint_ids = ["endpoint-id-1", "endpoint-id-2"]
    resource_group_name                   = "rg-1"
    name                                  = "ruleset-1"
    location                              = "East US"
    tags                                  = { key1 = "value1", key2 = "value2" }
  }
  ruleset2 = {
    enabled                                = true
    private_dns_resolver_outbound_endpoint_names = ["endpoint-name-3", "endpoint-name-4"]
    resource_group_name                   = "rg-2"
    name                                  = "ruleset-2"
    location                              = "West US"
    tags                                  = { key3 = "value3", key4 = "value4" }
  }
}

# PRIVATE_DNS_RESOLVER_DNS_FORWARDING_RULESET MODULE REFERENCE
module "private_dns_resolver_dns_forwarding_ruleset" {
        source = "./Modules/private_dns_resolver_dns_forwarding_ruleset"

        private_dns_resolver_dns_forwarding_ruleset_data = var.private_dns_resolver_dns_forwarding_ruleset_data
}

# PRIVATE_DNS_RESOLVER_DNS_FORWARDING_RULESET VARIABLE
variable "private_dns_resolver_dns_forwarding_ruleset_data" {
  type    = map(object({
    enabled                                = bool
    private_dns_resolver_outbound_endpoint_ids = optional(list(string))
    private_dns_resolver_outbound_endpoint_names = optional(list(string))
    private_dns_resolver_outbound_endpoint_keys  = optional(list(string))
    resource_group_name                   = string
    name                                  = string
    location                              = string
    tags                                  = map(string)
  }))
  default = {}
}
