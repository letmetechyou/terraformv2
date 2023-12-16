# PRIVATE_DNS_RESOLVER_VIRTUAL_NETWORK_LINK VALUES EXAMPLE
private_dns_resolver_virtual_network_link_data = {
  link1 = {
    enabled                   = true
    name                      = "link-1"
    virtual_network_id        = "/subscriptions/subscription-id/resourceGroups/rg-1/providers/Microsoft.Network/virtualNetworks/vnet-1"
    dns_forwarding_ruleset_id = "/subscriptions/subscription-id/resourceGroups/rg-1/providers/Microsoft.Network/privateDnsZones/dns-zone-1/forwardingRulesets/ruleset-1"
  }

  link2 = {
    enabled                   = true
    name                      = "link-2"
    virtual_network_name      = "vnet-2"
    forwarding_ruleset_key    = "ruleset-2"
  }
}


# PRIVATE_DNS_RESOLVER_VIRTUAL_NETWORK_LINK MODULE REFERENCE
module "private_dns_resolver_virtual_network_link" {
        source = "./Modules/private_dns_resolver_virtual_network_link"

        private_dns_resolver_virtual_network_link_data = var.private_dns_resolver_virtual_network_link_data
        virtual_network_output = module.virtual_network.virtual_network_output_names
        private_dns_resolver_dns_forwarding_ruleset_output = module.private_dns_resolver_dns_forwarding_ruleset.private_dns_resolver_dns_forwarding_ruleset_output_names
}

# PRIVATE_DNS_RESOLVER_VIRTUAL_NETWORK_LINK VARIABLE
variable "private_dns_resolver_virtual_network_link_data" {
  type = map(object({
    # Required
    enabled                   = bool
    name                      = string
    virtual_network_id        = optional(string)
    virtual_network_name      = optional(string)
    virtual_network_key       = optional(string)
    dns_forwarding_ruleset_id = optional(string)
    dns_forwarding_ruleset_name = optional(string)
    dns_forwarding_ruleset_key = optional(string)

    # Optional
    metadata = optional(string)
  }))
  default = {}
}
