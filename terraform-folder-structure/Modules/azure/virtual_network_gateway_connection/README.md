# AZURE_VIRTUAL_NETWORK_GATEWAY_CONNECTION VALUES EXAMPLE
variable "virtual_network_gateway_connection_data" {
  default = {
    connection1 = {
      enabled                           = true
      virtual_network_gateway_id        = "vnet-gateway-id-1"
      type                              = "IPsec"
      resource_group_name               = "rg-1"
      name                              = "connection-1"
      location                          = "East US"
      authorization_key                 = "secret-key-1"
      connection_protocol              = "IKEv2"
      local_azure_ip_address_enabled    = true
      shared_key                        = "shared-key-1"
      routing_weight                    = 1
      express_route_gateway_bypass      = true
      enable_bgp                        = true
      peer_virtual_network_gateway_id   = "peer-gateway-id-1"
      tags = {
        environment = "Dev"
      }
      dpd_timeout_seconds               = 30
      express_route_circuit_id          = "express-route-circuit-1"
      ingress_nat_rule_ids              = ["nat-rule-id-1", "nat-rule-id-2"]
      connection_mode                   = "PolicyBased"
      egress_nat_rule_ids               = ["egress-nat-rule-id-1"]
      local_network_gateway_id          = "local-gateway-id-1"
      ipsec_policy = [
        {
          ipsec_encryption = "AES256"
          pfs_group        = "None"
          ipsec_integrity  = "SHA1"
          ike_encryption   = "AES256"
          ike_integrity    = "SHA1"
          dh_group         = "Group2"
          sa_lifetime      = "3600"
          sa_datasize      = "102400000"
        },
      ]
      traffic_selector_policy = [
        {
          remote_address_cidrs = ["10.0.0.0/24"]
          local_address_cidrs  = ["192.168.0.0/24"]
        },
      ]
      custom_bgp_addresses = [
        {
          primary   = "192.168.1.1"
          secondary = "192.168.1.2"
        },
      ]
    },
    connection2 = {
      enabled                           = true
      virtual_network_gateway_id        = "vnet-gateway-id-2"
      type                              = "Vnet2Vnet"
      resource_group_name               = "rg-2"
      name                              = "connection-2"
      location                          = "West US"
      authorization_key                 = "secret-key-2"
      connection_protocol              = "IKEv1"
      local_azure_ip_address_enabled    = false
      shared_key                        = "shared-key-2"
      routing_weight                    = 2
      express_route_gateway_bypass      = false
      enable_bgp                        = false
      peer_virtual_network_gateway_id   = "peer-gateway-id-2"
      tags = {
        environment = "Prod"
      }
      dpd_timeout_seconds               = 60
      express_route_circuit_id          = "express-route-circuit-2"
      ingress_nat_rule_ids              = []
      connection_mode                   = "RouteBased"
      egress_nat_rule_ids               = []
      local_network_gateway_id          = "local-gateway-id-2"
      ipsec_policy = [
        {
          ipsec_encryption = "AES128"
          pfs_group        = "PFS1"
          ipsec_integrity  = "SHA256"
          ike_encryption   = "AES128"
          ike_integrity    = "SHA256"
          dh_group         = "Group14"
          sa_lifetime      = "28800"
          sa_datasize      = "204800000"
        },
      ]
      traffic_selector_policy = [
        {
          remote_address_cidrs = ["192.168.2.0/24"]
          local_address_cidrs  = ["10.1.0.0/24"]
        },
      ]
      custom_bgp_addresses = [
        {
          primary   = "192.168.2.1"
          secondary = "192.168.2.2"
        },
      ]
    },
  }
}

# AZURE_VIRTUAL_NETWORK MODULE REFERENCE
module "virtual_network_gateway_connection" {
  source = "./Modules/virtual_network_gateway_connection"

  virtual_network_gateway_connection_data = var.virtual_network_gateway_connection_data
}

# AZURE_VIRTUAL_NETWORK VARIABLE
variable "virtual_network_gateway_connection_data" {
  type = map(object({
    # Required
    enabled                    = bool
    virtual_network_gateway_id = string
    type                       = string
    resource_group_name        = string
    name                       = string
    location                   = string
    authorization_key          = string

    # Optional
    connection_protocol             = optional(string)
    local_azure_ip_address_enabled  = optional(bool)
    shared_key                      = optional(string)
    routing_weight                  = optional(number)
    express_route_gateway_bypass    = optional(bool)
    enable_bgp                      = optional(bool)
    peer_virtual_network_gateway_id = optional(string)
    tags                            = optional(map(string))
    dpd_timeout_seconds             = optional(number)
    express_route_circuit_id        = optional(string)
    ingress_nat_rule_ids            = optional(list(string))
    connection_mode                 = optional(string)
    egress_nat_rule_ids             = optional(list(string))
    local_network_gateway_id        = optional(string)

    # Optional Dynamic Blocks
    ipsec_policy = optional(list(object({
      # Required
      ipsec_encryption = string
      pfs_group        = string
      ipsec_integrity  = string
      ike_encryption   = string
      ike_integrity    = string
      dh_group         = string

      # Optional
      sa_lifetime = optional(string)
      sa_datasize = optional(string)
    })))

    traffic_selector_policy = optional(list(object({
      # Required
      remote_address_cidrs = list(string)
      local_address_cidrs  = list(string)

      # Optional
    })))

    custom_bgp_addresses = optional(list(object({
      # Required
      primary = string

      # Optional
      secondary = optional(string)
    })))
  }))
}
