variable "resource_group_data" {
  type = map(object({
    #Required
    enabled  = bool
    location = string
    name     = string

    #Optional
    managed_by = optional(string)
    tags       = optional(string)
  }))
  default = {}
}

variable "virtual_network_data" {
  type = map(object({
    # Required
    enabled             = bool
    name                = string
    address_space       = list(string)
    location            = string
    resource_group_name = string

    # Optional
    bgp_community           = optional(string)
    dns_servers             = optional(list(string))
    edge_zone               = optional(string)
    flow_timeout_in_minutes = optional(number)
    ddos_protection_plan = optional(object({
      id     = string
      enable = bool
    }))
    encryption = optional(object({
      enforcement = string
    }))
    subnets = optional(list(object({
      enabled        = bool
      name           = string
      address_prefix = string
      security_group = optional(string)
    })))

    tags = optional(map(string))
  }))
  default = {}
}

variable "network_security_group_data" {
  type = map(object({
    # Required
    enabled             = bool
    name                = string
    resource_group_name = string
    location            = string

    # Optional
    tags = optional(map(string))

    # Optional Dynamic Blocks
    security_rule = optional(list(object({
      # Required
      priority  = number
      direction = string
      protocol  = string
      access    = string
      name      = string

      # Optional
      source_port_ranges                         = optional(list(string))
      destination_port_range                     = optional(string)
      destination_port_ranges                    = optional(list(string))
      destination_application_security_group_ids = optional(list(string))
      source_application_security_group_ids      = optional(list(string))
      description                                = optional(string)
      source_address_prefix                      = optional(string)
      destination_address_prefix                 = optional(string)
      destination_address_prefixes               = optional(list(string))
      source_address_prefixes                    = optional(list(string))
      source_port_range                          = optional(string)
    })))
  }))
  default = {}
}


variable "subnet_data" {
  type = map(object({
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
    service_endpoints                             = optional(list(string))
    service_endpoint_policy_ids                   = optional(list(string))

    # References / Association

    network_security_group_id   = optional(string)
    network_security_group_name = optional(string)
    network_security_group_key  = optional(string)
  }))
  default = {}
}

variable "subnet_network_security_group_association_data" {
  type = map(object({
    # Required
    enabled                     = bool
    subnet_id                   = optional(string)
    subnet_name                 = optional(string)
    subnet_key                  = optional(string)
    network_security_group_id   = optional(string)
    network_security_group_name = optional(string)
    network_security_group_key  = optional(string)

    # Optional

    # Optional Dynamic Blocks
  }))
  default = {}
}

variable "public_ip_data" {
  type = map(object({
    # Required
    name                = string
    resource_group_name = string
    location            = string
    allocation_method   = string

    # Optional
    zones                   = optional(list(string))
    ddos_protection_mode    = optional(string)
    ddos_protection_plan_id = optional(string)
    domain_name_label       = optional(string)
    edge_zone               = optional(string)
    idle_timeout_in_minutes = optional(number)
    ip_tags                 = optional(map(string))
    ip_version              = optional(string)
    public_ip_prefix_id     = optional(string)
    reverse_fqdn            = optional(string)
    sku                     = optional(string)
    sku_tier                = optional(string)

    tags    = optional(map(string))
    enabled = optional(bool)
  }))
  default = {}
}

variable "virtual_network_gateway_data" {
  type = map(object({
    # Required
    enabled             = bool
    name                = string
    resource_group_name = string
    location            = string
    sku                 = string
    type                = string
    # IP Configuration (Required)
    ip_configuration = list(object({
      # Required
      public_ip_address_id   = optional(string)
      subnet_id              = optional(string)
      public_ip_address_name = optional(string)
      subnet_name            = optional(string)

      # Optional
      name                          = optional(string)
      private_ip_address_allocation = optional(string)
    }))


    # Optional
    active_active                    = optional(bool)
    default_local_network_gateway_id = optional(string)
    edge_zone                        = optional(string)
    enable_bgp                       = optional(bool)
    generation                       = optional(string)
    private_ip_address_enabled       = optional(bool)
    tags                             = optional(map(string))

    # BGP Settings (Optional)
    bgp_settings = optional(object({
      asn = number

      peering_addresses = optional(object({
        ip_configuration_name = string
        apipa_addresses       = list(string)
      }))

      peer_weight = number
    }))

    # Custom Routes (Optional)
    custom_route = optional(object({
      address_prefixes = list(string)
    }))

    # VPN Client Configuration (Optional)
    vpn_client_configuration = optional(object({
      # Define your VPN client configuration attributes here if needed.
    }))

    # VPN Type (Optional)
    vpn_type = optional(string)
  }))
  default = {}
}

variable "firewall_policy_data" {
  type = map(object({
    # Required
    enabled             = bool
    location            = string
    name                = string
    resource_group_name = string

    # Optional
    base_policy_id = optional(string)

    dns = optional(object({
      proxy_enabled = bool
      servers       = list(string)
    }))

    identity = optional(object({
      type         = string
      identity_ids = list(string)
    }))

    insights = optional(object({
      enabled                            = bool
      default_log_analytics_workspace_id = string
      retention_in_days                  = number
      log_analytics_workspace = optional(list(object({
        id                = string
        firewall_location = string
      })))
    }))

    intrusion_detection = optional(object({
      mode = string
      signature_overrides = optional(list(object({
        id    = string
        state = string
      })))
      traffic_bypass = optional(list(object({
        name                  = string
        protocol              = string
        description           = optional(string)
        destination_addresses = optional(list(string))
        destination_ip_groups = optional(list(string))
        destination_ports     = optional(list(string))
        source_addresses      = optional(list(string))
        source_ip_groups      = optional(list(string))
      })))
      private_ranges = optional(list(string))
    }))

    private_ip_ranges                 = optional(list(string))
    auto_learn_private_ranges_enabled = optional(bool)
    sku                               = optional(string)
    tags                              = optional(map(string))

    threat_intelligence_allowlist = optional(object({
      fqdns        = optional(list(string))
      ip_addresses = optional(list(string))
    }))

    threat_intelligence_mode = optional(string)
    tls_certificate = optional(list(object({
      key_vault_secret_id = string
      name                = string
    })))

    sql_redirect_allowed = optional(bool)
    explicit_proxy = optional(object({
      enabled         = bool
      http_port       = optional(number)
      https_port      = optional(number)
      enable_pac_file = optional(bool)
      pac_file_port   = optional(number)
      pac_file        = optional(string)
    }))
  }))
  default = {}
}

variable "firewall_policy_rule_collection_group_data" {
  description = "Configuration for Azure Firewall Policy Rule Collection Group."

  type = map(object({
    # Required
    enabled            = bool
    name               = string
    firewall_policy_id = string
    priority           = number

    # Optional
    application_rule_collection = optional(object({
      name     = string
      action   = string
      priority = number

      rule = object({
        name                  = string
        description           = optional(string)
        protocols             = list(string)
        source_addresses      = optional(list(string))
        source_ip_groups      = optional(list(string))
        destination_addresses = optional(list(string))
        destination_urls      = optional(list(string))
        destination_fqdns     = optional(list(string))
        destination_fqdn_tags = optional(list(string))
        terminate_tls         = optional(bool)
        web_categories        = optional(list(string))
      })
    }))

    nat_rule_collection = optional(object({
      name     = string
      action   = string
      priority = number

      rule = object({
        name                = string
        protocols           = list(string)
        source_addresses    = optional(list(string))
        source_ip_groups    = optional(list(string))
        destination_address = optional(string)
        destination_ports   = list(string)
        translated_address  = optional(string)
        translated_fqdn     = optional(string)
        translated_port     = number
      })
    }))

    network_rule_collection = optional(object({
      name     = string
      action   = string
      priority = number

      rules = list(object({
        enabled               = bool
        name                  = string
        protocols             = list(string)
        destination_ports     = list(string)
        source_addresses      = optional(list(string))
        source_ip_groups      = optional(list(string))
        destination_addresses = optional(list(string))
        destination_ip_groups = optional(list(string))
        destination_fqdns     = optional(list(string))
      }))
    }))
  }))
  default = {}
}

variable "windows_virtual_machine_data" {
  type = map(object({
    enabled = bool
    existing_key_vault_id = optional(string)
    license_type                    = optional(string, "Windows_Server")
    location                        = string
    computer_name                   = string
    existing_resource_group_name    = string
    size                            = string
    secure_boot_enabled             = optional(string, false)
    existing_virtual_network        = string
    existing_virtual_network_rg     = string
    existing_virtual_network_subnet = string
    zone                            = optional(number, 1)
    os_disk = object({
      os_disk_caching              = string
      os_disk_storage_account_type = string
    })
    data_disk_storage_account_type = string
    data_disk_caching              = string
    data_disk_disk_size_gb         = number
    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
    ip_configurations = list(object({
      name    = string
      primary = bool
    }))
  }))
  default = {}
}

variable "key_vault_data" {
  type = map(object({
    enabled                      = bool
    key_vault_name               = string
    existing_resource_group_name = string
    allowed_ip_rules             = optional(list(string), null)
    allowed_subnet_ids           = optional(list(string), null)
  }))
  default = {}
}

variable "virtual_network_peering_data" {
  type = map(object({
    # Required
    enabled                   = bool
    resource_group_name       = string
    remote_virtual_network_id = string
    name                      = string
    virtual_network_name      = string

    # Optional
    allow_gateway_transit        = optional(bool)
    allow_virtual_network_access = optional(bool)
    allow_forwarded_traffic      = optional(bool)
    triggers                     = optional(map(any))
    use_remote_gateways          = optional(bool)
  }))
  default = {}
}

variable "express_route_connection_data" {
  type = map(object({
    # Required
    enabled                          = bool
    express_route_gateway_id         = string
    express_route_circuit_peering_id = string
    name                             = string

    # Optional
    express_route_gateway_bypass_enabled = optional(bool)
    routing_weight                       = optional(number)
    authorization_key                    = optional(string)
    enable_internet_security             = optional(bool)

    # Optional Dynamic Block
    routing = optional(list(object({
      # Required

      # Optional
      outbound_route_map_id     = optional(string)
      inbound_route_map_id      = optional(string)
      associated_route_table_id = optional(string)
      #block - propagated_route_table    = optional(string)
    })))
  }))
  default = {}
}

variable "virtual_network_gateway_connection_data" {
  type = map(object({
    # Required
    enabled                    = bool
    virtual_network_gateway_id = string
    type                       = string
    resource_group_name        = string
    name                       = string
    location                   = string
    authorization_key_name     = optional(string)

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
  default = {}
}

variable "express_route_circuit_authorization_data" {
  type = map(object({
    # Required
    enabled                    = bool
    express_route_circuit_name = string
    resource_group_name        = string
    name                       = string

    # Optional

    # Optional Dynamic Blocks
  }))
  default = {}
}

variable "key_vault_access_policy_data" {
  type = map(object({
    enabled                 = bool
    existing_key_vault_id   = string
    obj_id                  = optional(string)
    user_id                 = optional(string)
    group_id                = optional(string)
    service_principal_id    = optional(string)
    certificate_permissions = optional(list(string))
    key_permissions         = optional(list(string))
    secret_permissions      = optional(list(string))
    storage_permissions     = optional(list(string))
  }))
  default = {}
}

variable "linux_virtual_machine_data" {
  type = map(object({
    enabled                         = bool
    existing_key_vault_id           = string
    location                        = string
    computer_name                   = string
    existing_resource_group_name    = string
    size                            = string
    secure_boot_enabled             = optional(string, false)
    existing_virtual_network        = string
    existing_virtual_network_rg     = string
    existing_virtual_network_subnet = string
    zone                            = optional(number, 1)
    os_disk = object({
      os_disk_caching              = string
      os_disk_storage_account_type = string
    })
    data_disk_storage_account_type = string
    data_disk_caching              = string
    data_disk_disk_size_gb         = number
    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
    ip_configurations = list(object({
      name    = string
      primary = bool
    }))
  }))
  default = {}
}

variable "firewall_data" {
  type = map(object({
    # Required
    enabled             = bool
    sku_name            = string
    sku_tier            = string
    location            = string
    resource_group_name = string
    name                = string

    # Optional
    firewall_policy_id = optional(string)
    zones              = optional(list(string))
    tags               = optional(map(string))
    private_ip_ranges  = optional(list(string))
    dns_servers        = optional(list(string))
    threat_intel_mode  = optional(string)

    # Optional Dynamic Blocks
    ip_configuration = optional(list(object({
      # Required
      name = string

      # Optional
      public_ip_address_id   = optional(string)
      public_ip_address_name = optional(string)
      public_ip_address_key  = optional(string)
      subnet_id              = optional(string)
      subnet_name            = optional(string)
      subnet_key             = optional(string)
    })))

    virtual_hub = optional(list(object({
      # Required
      virtual_hub_id = string

      # Optional
      public_ip_count = optional(number)
    })))

    management_ip_configuration = optional(list(object({
      # Required
      public_ip_address_id   = optional(string)
      public_ip_address_name = optional(string)
      public_ip_address_key  = optional(string)
      subnet_id              = optional(string)
      subnet_name            = optional(string)
      subnet_key             = optional(string)
      name                   = string

      # Optional
    })))
  }))
  default = {}
}

variable "virtual_machine_extension_data" {
  type = map(object({
    # Required - Marked as optional for interpolation of possible entries (id, name, key)
    enabled              = bool
    type_handler_version = string
    type                 = string
    publisher            = string
    virtual_machine_id   = optional(string)
    virtual_machine_name = optional(string)
    virtual_machine_key  = optional(string)
    name                 = string

    # Optional

    # Optional Dynamic Blocks
    protected_settings_from_key_vault = optional(list(object({
      # Required
      source_vault_id = string
      secret_url      = string

      # Optional
    })))
  }))
  default = {}
}

variable "palo_alto_data" {
  default = {}
}

variable "availability_set_data" {
  type = map(object({
    # Required
    enabled             = bool
    resource_group_name = string
    name                = string
    location            = string

    # Optional
    managed                      = optional(bool)
    tags                         = optional(map(string))
    platform_update_domain_count = optional(number)
    platform_fault_domain_count  = optional(number)
    proximity_placement_group_id = optional(string)

    # Optional Dynamic Blocks
  }))
  default = {}
}

variable "lb_data" {
  type = map(object({
    # Required
    enabled             = bool
    resource_group_name = string
    name                = string
    location            = string

    # Optional
    sku       = optional(string)
    sku_tier  = optional(string)
    edge_zone = optional(string)
    tags      = optional(map(string))

    # Separate variable for frontend_ip_configuration
    frontend_ip_configuration_data = optional(list(object({
      # Required
      name    = string
      lb_name = string

      # Optional
      zones                                              = optional(list(string))
      subnet_id                                          = optional(string)
      gateway_load_balancer_frontend_ip_configuration_id = optional(string)
      private_ip_address                                 = optional(string)
      private_ip_address_allocation                      = optional(string)
      private_ip_address_version                         = optional(string)
      public_ip_address_id                               = optional(string)
      public_ip_prefix_id                                = optional(string)
      public_ip_address_name                             = optional(string)
      public_ip_prefix_name                              = optional(string)
      public_ip_address_key                              = optional(string)
      public_ip_prefix_key                               = optional(string)
    })))
  }))
  default = {}
}

# FRONTEND CONFIGURATION VARIABLE
variable "lb_frontend_ip_configuration_data" {
  description = "Frontend IP Configuration data"

  type = map(object({
    # Required
    name    = string
    lb_name = string

    # Optional
    zones                                              = optional(list(string))
    subnet_id                                          = optional(string)
    subnet_name                                        = optional(string)
    subnet_key                                         = optional(string)
    gateway_load_balancer_frontend_ip_configuration_id = optional(string)
    private_ip_address                                 = optional(string)
    private_ip_address_allocation                      = optional(string)
    private_ip_address_version                         = optional(string)
    public_ip_address_id                               = optional(string)
    public_ip_address_name                             = optional(string)
    public_ip_address_key                              = optional(string)

  }))
  default = {}
}

variable "lb_backend_address_pool_data" {
  type = map(object({
    # Required
    enabled           = bool
    name              = string
    loadbalancer_id   = optional(string)
    loadbalancer_name = optional(string)
    loadbalancer_key  = optional(string)

    # Optional
    virtual_network_id = optional(string)

    # Optional Dynamic Blocks
    tunnel_interface = optional(list(object({
      # Required
      port       = number
      identifier = string
      protocol   = string
      type       = string

      # Optional
    })))
  }))
  default = {}
}

variable "lb_backend_address_pool_address_data" {
  type = map(object({
    # Required
    enabled                 = bool
    name                    = string
    backend_address_pool_id = string

    # Optional
    backend_address_ip_configuration_id = optional(string)
    ip_address                          = optional(string)
    virtual_network_id                  = optional(string)

    # Optional Dynamic Blocks
  }))
  default = {}
}

variable "lb_probe_data" {
  type = map(object({
    # Required
    enabled           = bool
    port              = number
    loadbalancer_id   = optional(string)
    loadbalancer_name = optional(string)
    loadbalancer_key  = optional(string)
    name              = string

    # Optional
    interval_in_seconds = optional(number)
    request_path        = optional(string)
    protocol            = optional(string)
    probe_threshold     = optional(number)
    number_of_probes    = optional(number)

    # Optional Dynamic Blocks
  }))
  default = {}
}

variable "lb_rule_data" {
  type = map(object({
    # Required
    enabled                        = bool
    name                           = string
    frontend_port                  = number
    protocol                       = string
    loadbalancer_id                = optional(string)
    loadbalancer_name              = optional(string)
    loadbalancer_key               = optional(string)
    frontend_ip_configuration_name = string
    backend_port                   = number

    # Optional
    probe_id                   = optional(string)
    probe_name                 = optional(string)
    probe_key                  = optional(string)
    disable_outbound_snat      = optional(bool)
    idle_timeout_in_minutes    = optional(number)
    load_distribution          = optional(string)
    backend_address_pool_ids   = optional(list(string))
    backend_address_pool_names = optional(list(string))
    backend_address_pool_keys  = optional(list(string))
    enable_tcp_reset           = optional(bool)
    enable_floating_ip         = optional(bool)

    # Optional Dynamic Blocks
  }))
  default = {}
}

variable "network_interface_backend_address_pool_association_data" {
  type = map(object({
    # Required
    enabled                   = bool
    ip_configuration_name     = string
    network_interface_id      = optional(string)
    network_interface_name    = optional(string)
    network_interface_key     = optional(string)
    backend_address_pool_id   = optional(string)
    backend_address_pool_name = optional(string)
    backend_address_pool_key  = optional(string)

    # Optional
    # Add optional attributes if needed
  }))
  default = {}
}

variable "api_management_data" {
  type = map(object({
    enabled                             = string
    name                                = string
    env                                 = string
    location                            = string
    proxy_hostname                      = string
    resource_group_name                 = string
    publisher_email                     = string
    publisher_name                      = string
    sku_name                            = string
    existing_key_vault_id               = optional(string)
    existing_key_vault_certificate_name = optional(string)
    virtual_network_type                = string
    existing_virtual_network_subnet_id  = string
    dnsdomain                           = string
  }))
  default = {}
}


variable "route_table_data" {
  description = "A map of subnet associations with route tables"
  type = map(object({
    enabled                       = bool
    name                          = string
    location                      = string
    existing_resource_group_name  = string
    disable_bgp_route_propagation = bool
    routes = optional(list(object({
      name                   = string
      address_prefix         = string
      next_hop_type          = string
      next_hop_in_ip_address = string
    })))
  }))
  default = {}
}

variable "subnet_route_table_association_data" {
  type = map(object({
    enabled          = bool
    route_table_name = optional(string)
    route_table_key  = optional(string)
    subnet_id        = string
    route_table_id   = string
  }))
  default = {}
}

variable "private_dns_resolver_data" {
  description = "Map of private DNS resolver configurations."

  type = map(object({

    # Required
    enabled             = bool
    resource_group_name = string
    name                = string
    location            = string

    # Required, but set as optional for interpolation of different values (id, name, key)
    virtual_network_id   = optional(string)
    virtual_network_name = optional(string)
    virtual_network_key  = optional(string)
  }))
  default = {}
}

variable "private_dns_resolver_outbound_endpoint_data" {
  type = map(object({
    # Required
    enabled                   = bool
    name                      = string
    location                  = string
    private_dns_resolver_id   = optional(string)
    private_dns_resolver_name = optional(string)
    private_dns_resolver_key  = optional(string)
    subnet_id                 = optional(string)
    subnet_name               = optional(string)
    subnet_key                = optional(string)

    # Optional
    tags = optional(list(string))
  }))
  default = {}
}

variable "private_dns_resolver_dns_forwarding_ruleset_data" {
  type = map(object({
    # Required
    enabled                                      = bool
    private_dns_resolver_outbound_endpoint_ids   = optional(list(string))
    private_dns_resolver_outbound_endpoint_names = optional(list(string))
    private_dns_resolver_outbound_endpoint_keys  = optional(list(string))
    resource_group_name                          = string
    name                                         = string
    location                                     = string

    # Optional
    tags = optional(map(string))
  }))
  default = {}
}

variable "private_dns_resolver_forwarding_rule_data" {
  type = map(object({
    enabled                     = bool
    name                        = string
    domain_name                 = string
    dns_forwarding_ruleset_id   = optional(string)
    dns_forwarding_ruleset_name = optional(string)
    dns_forwarding_ruleset_key  = optional(string)

    target_dns_servers = object({
      ip_address = string
      port       = optional(number)
    })

    metadata = optional(map(string))
  }))
  default = {}
}

variable "private_dns_resolver_virtual_network_link_data" {
  type = map(object({
    # Required
    enabled                     = bool
    name                        = string
    virtual_network_id          = optional(string)
    virtual_network_name        = optional(string)
    virtual_network_key         = optional(string)
    dns_forwarding_ruleset_id   = optional(string)
    dns_forwarding_ruleset_name = optional(string)
    dns_forwarding_ruleset_key  = optional(string)

    # Optional
    metadata = optional(string)
  }))
  default = {}
}

variable "log_analytics_workspace_data" {
  description = "A map of Log Analytics workspace data."
  type = map(object({
    # Required
    enabled             = bool,
    location            = string,
    resource_group_name = string,
    name                = string,

    #Optional
    internet_query_enabled             = optional(bool),
    reservation_capacity_in_gb_per_day = optional(number),
    sku                                = optional(string),
    local_authentication_disabled      = optional(bool),
    allow_resource_only_permissions    = optional(bool),
    cmk_for_query_forced               = optional(bool),
    internet_ingestion_enabled         = optional(bool),
    data_collection_rule_id            = optional(string),
    retention_in_days                  = optional(number),
    tags                               = optional(map(string)),
    daily_quota_gb                     = optional(number),
  }))
  default = {}
}

variable "internalservices_api_management_custom_domain_data" {
  type = map(object({
    enabled           = bool
    api_management_id = string

    developer_portal = optional(list(object({
      host_name    = string
      certificate  = string
      key_vault_id = string
    })))

    management = optional(list(object({
      host_name    = string
      certificate  = string
      key_vault_id = string
    })))

    gateway = optional(list(object({
      host_name           = string
      certificate         = string
      key_vault_id        = string
      default_ssl_binding = bool
    })))

  }))
  default = {}
}

variable "storage_account_data" {
  type = map(object({
    # Required
    enabled                  = bool
    name                     = string
    account_replication_type = string
    account_tier             = string
    location                 = string
    resource_group_name      = string

    # Optional
    queue_encryption_key_type         = optional(string)
    sftp_enabled                      = optional(bool)
    public_network_access_enabled     = optional(bool)
    table_encryption_key_type         = optional(string)
    edge_zone                         = optional(string)
    default_to_oauth_authentication   = optional(bool)
    shared_access_key_enabled         = optional(bool)
    large_file_share_enabled          = optional(bool)
    nfsv3_enabled                     = optional(bool)
    allow_nested_items_to_be_public   = optional(bool)
    enable_https_traffic_only         = optional(bool)
    allowed_copy_scope                = optional(string)
    infrastructure_encryption_enabled = optional(bool)
    cross_tenant_replication_enabled  = optional(bool)
    min_tls_version                   = optional(string)
    access_tier                       = optional(string)
    tags                              = optional(map(string))
    is_hns_enabled                    = optional(bool)
    account_kind                      = optional(string)

    # Optional Dynamic Blocks
    network_rules = optional(object({
      default_action = string
      private_link_access = optional(list(object({
        id   = string
        name = string
      })))
      virtual_network_subnet_ids = optional(list(string))
      ip_rules                   = optional(list(string))
      bypass                     = optional(list(string))
    }))
    azure_files_authentication = optional(object({
      directory_type = string
      active_directory = optional(object({
        domain_guid         = string
        forest_name         = string
        domain_name         = string
        netbios_domain_name = string
      }))
    }))
    static_website = optional(object({
      index_document     = string
      error_404_document = string
    }))
    queue_properties = optional(object({
      hour_metrics = optional(object({
        enabled               = bool
        include_apis          = optional(bool)
        retention_policy_days = optional(number)
        version               = optional(string)
      }))
      logging = optional(object({
        delete                = optional(bool)
        read                  = optional(bool)
        write                 = optional(bool)
        retention_policy_days = optional(number)
        version               = optional(string)
      }))
      minute_metrics = optional(object({
        enabled               = bool
        include_apis          = optional(bool)
        retention_policy_days = optional(number)
        version               = optional(string)
      }))
      cors_rule = optional(list(object({
        allowed_headers    = list(string)
        allowed_methods    = list(string)
        allowed_origins    = list(string)
        exposed_headers    = list(string)
        max_age_in_seconds = number
      })))
    }))
    blob_properties = optional(object({
      change_feed_retention_in_days = optional(number)
      delete_retention_policy = optional(object({
        days    = number
        enabled = bool
      }))
      change_feed_enabled = optional(bool)
      cors_rule = optional(list(object({
        allowed_headers    = list(string)
        allowed_methods    = list(string)
        allowed_origins    = list(string)
        exposed_headers    = list(string)
        max_age_in_seconds = number
      })))
      restore_policy = optional(object({
        days    = number
        enabled = bool
      }))
      versioning_enabled      = optional(bool)
      default_service_version = optional(string)
      container_delete_retention_policy = optional(object({
        days    = number
        enabled = bool
      }))
      last_access_time_enabled = optional(bool)
    }))
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    immutability_policy = optional(object({
      period_since_creation_in_days = number
      state                         = string
      allow_protected_append_writes = optional(bool)
    }))
    sas_policy = optional(object({
      expiration_period = string
      expiration_action = optional(string)
    }))
    custom_domain = optional(object({
      name          = string
      use_subdomain = optional(bool)
    }))
    share_properties = optional(object({
      smb = optional(object({
        enabled              = bool
        authentication_types = optional(list(string))
      }))
      cors_rule = optional(list(object({
        allowed_headers    = list(string)
        allowed_methods    = list(string)
        allowed_origins    = list(string)
        exposed_headers    = list(string)
        max_age_in_seconds = number
      })))
      retention_policy = optional(object({
        days    = number
        enabled = bool
      }))
    }))
    routing = optional(object({
      choice                      = string
      publish_internet_endpoints  = optional(bool)
      publish_microsoft_endpoints = optional(bool)
    }))
    customer_managed_key = optional(object({
      user_assigned_identity_id = string
      key_vault_key_id          = string
    }))
  }))
  default = {}
}

variable "storage_share_data" {
  type = map(object({
	# Required
    	enabled           = bool
    	name              = string
    	quota             = number
    	storage_account_name = string

	# Optional
    	metadata          = optional(map(string))
    	access_tier       = optional(string)
    	enabled_protocol  = optional(string)
    	acl               = optional(list(object({
      		id            = string
      		access_policy = optional(object({
        		permissions = string
        		start       = optional(string)
        		expiry      = optional(string)
      		}))
    	})))
  }))
  default = {}
}

variable "storage_share_directory_data" {
  type = map(object({
    enabled              = bool
    name                 = string
    share_name           = string
    storage_account_name = string
    metadata             = optional(map(string))
  }))
  default = {}
}

variable "storage_share_file_data" {
  type = map(object({
    # Required
    enabled        = bool
    storage_share_id = string
    name           = string

    # Optional
    content_type        = optional(string)
    path                = optional(string)
    content_md5         = optional(string)
    metadata            = optional(map(string))
    content_disposition = optional(string)
    source              = optional(string)
    content_encoding    = optional(string)

    # Optional Dynamic Blocks
  }))
  default = {}
}

variable "mssql_server_data" {
  type = map(object({
    enabled                                      = bool
    name                                         = string
    version                                      = string
    location                                     = string
    resource_group_name                          = string
    existing_key_vault_id                        = optional(string)
    connection_policy                            = optional(string)
    transparent_data_encryption_key_vault_key_id = optional(string)
    tags                                         = optional(map(string))
    public_network_access_enabled                = optional(bool)
    primary_user_assigned_identity_id            = optional(string)
    outbound_network_restriction_enabled         = optional(bool)
    minimum_tls_version                          = optional(number)
    administrator_login_password                 = optional(string)
    administrator_login                          = optional(string)
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))
    azuread_administrator = optional(object({
      login_username              = string
      object_id                   = string
      tenant_id                   = optional(string)
      azuread_authentication_only = optional(bool)

    }))
  }))
  default = {}
}

variable "mssql_server_extended_auditing_policy_data" {
  type = map(object({
    enabled_policy                          = bool
    mssql_server_id                         = optional(string)
    mssql_server_name                       = optional(string)
    mssql_server_key                        = optional(string)
    storage_account_access_key              = optional(string)
    retention_in_days                       = optional(number)
    storage_account_subscription_id         = optional(string)
    log_monitoring_enabled                  = optional(bool)
    enabled                                 = optional(bool)
    storage_account_access_key_is_secondary = optional(string)
    storage_endpoint                        = optional(string)
  }))
  default = {}
}

variable "mssql_virtual_network_rule_data" {
  type = map(object({
    enabled                              = bool
    name                                 = string
    subnet_id                            = string
    mssql_server_id                      = optional(string)
    mssql_server_name                    = optional(string)
    mssql_server_key                     = optional(string)
    ignore_missing_vnet_service_endpoint = optional(bool)
  }))
    default = {}
}

variable "mssql_firewall_rule_data" {
  type = map(object({
    enabled = bool
    name = string
    mssql_server_id                      = optional(string)
    mssql_server_name                    = optional(string)
    mssql_server_key                     = optional(string)
    start_ip_address = string
    end_ip_address = string
  }))
    default = {}
}

variable "mssql_server_security_alert_policy_data" {
  type = map(object({
    enabled = bool
    resource_group_name                  = string
    mssql_server_name                    = optional(string)
    mssql_server_key                     = optional(string)
    state = string
    email_addresses            = optional(set(string))
    email_account_admins       = optional(bool)
    storage_account_access_key = optional(string)
    retention_days             = optional(number)
    storage_endpoint           = optional(string)
    disabled_alerts            = optional(set(string))
  }))
    default = {}
}

variable "mssql_server_vulnerability_assessment_data" {
  type = map(object({
    enabled = bool
    storage_container_name = optional(string)
    storage_account_name = optional(string)
    storage_account_access_key = optional(string)
    storage_container_sas_key = optional(string)
    recurring_scans = optional(object({
      enabled = optional(bool)
      email_subscription_admins = optional(bool)
      email = optional(list(string))
    }))

  }))
    default = {}
}

variable "storage_container_data" {
  type = map(object({
    # Required
    enabled             = bool
    storage_account_name = string
    name                = string

    # Optional
    container_access_type = optional(string)
    metadata              = optional(map(string))

    # Optional Dynamic Blocks
  }))
  default = {}
}


variable "private_endpoint_data" {
  type = map(object({
    enabled = bool
    name = string
    resource_group_name = string
    location = string
    subnet_id = string
    custom_network_interface_name = optional(string)
    private_dns_zone_group = optional(object({
      name = string
      private_dns_zone_ids = list(string)
    }))
    private_service_connection = object({
      name = string
      is_manual_connection = bool
      private_connection_resource_id = optional(string)
      private_connection_resource_alias = optional(string)
      subresource_names = optional(list(string))
    })
    
  }))
  default = {}
}

variable "role_assignment_data" {
  type = map(object({
    # Required
    enabled                           = bool
    principal_id                      = string
    scope                             = string

    # Optional
    role_definition_name              = optional(string)
    condition                         = optional(string)
    description                       = optional(string)
    skip_service_principal_aad_check  = optional(bool)
    condition_version                 = optional(string)
    role_definition_id                = optional(string)
    delegated_managed_identity_resource_id = optional(string)
    name                              = optional(string)

    # Optional Dynamic Blocks
  }))
  default = {}
}

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

variable "management_lock_data" {
  type = map(object({
    # Required
    enabled   = bool
    lock_level = string
    scope      = optional(string)
    name       = optional(string)
    key        = optional(string)

    # Optional
    notes     = optional(string)

    # Optional Dynamic Blocks
  }))
  default = {}
}
