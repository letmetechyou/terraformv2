module "resource_group" {
  source = "./Modules/Azure/resource_group"

  resource_group_data = var.resource_group_data

}

module "virtual_network" {
  source = "./Modules/Azure/virtual_network"

  virtual_network_data = var.virtual_network_data
  depends_on           = [module.resource_group]
}

module "network_security_group" {
  source = "./Modules/Azure/network_security_group"

  network_security_group_data = var.network_security_group_data
  depends_on                  = [module.resource_group]
}

module "subnet" {
  source = "./Modules/Azure/subnet"

  subnet_data = var.subnet_data
  depends_on  = [module.resource_group]
}

module "subnet_network_security_group_association" {
  source = "./Modules/Azure/subnet_network_security_group_association"

  subnet_network_security_group_association_data = var.subnet_network_security_group_association_data
  network_security_group_output                  = module.network_security_group.network_security_group_output_names
  subnet_output                                  = module.subnet.subnet_output_names
  depends_on                                     = [module.resource_group]

}

module "windows_virtual_machine" {
  source                       = "./Modules/windows_virtual_machines"
  windows_virtual_machine_data = var.windows_virtual_machine_data
  #depends_on = [ module.resource_group ]
}

module "key_vault" {
  source         = "./Modules/key_vault"
  key_vault_data = var.key_vault_data
  depends_on     = [module.resource_group]
}

module "public_ip" {
  source = "./Modules/Azure/public_ip"

  public_ip_data = var.public_ip_data
}

module "virtual_network_gateway" {
  source = "./Modules/Azure/virtual_network_gateway"

  virtual_network_gateway_data = var.virtual_network_gateway_data
  public_ip_output             = module.public_ip.public_ip_output_names
  subnet_output                = module.subnet.subnet_output_names
}

module "virtual_network_peering" {
  source = "./Modules/Azure/virtual_network_peering"

  virtual_network_peering_data = var.virtual_network_peering_data
}

module "express_route_connection" {
  source = "./Modules/Azure/express_route_connection"

  express_route_connection_data = var.express_route_connection_data
}

module "virtual_network_gateway_connection" {
  source = "./Modules/Azure/virtual_network_gateway_connection"

  virtual_network_gateway_connection_data    = var.virtual_network_gateway_connection_data
  express_route_circuit_authorization_output = module.express_route_circuit_authorization.express_route_circuit_authorization_output_names
}

module "express_route_circuit_authorization" {
  source = "./Modules/Azure/express_route_circuit_authorization"

  express_route_circuit_authorization_data = var.express_route_circuit_authorization_data
}

module "key_vault_access_policy" {
  source = "./Modules/Azure/key_vault_access_policy"

  key_vault_access_policy_data = var.key_vault_access_policy_data
}

module "firewall_policy" {
  source = "./Modules/Azure/firewall_policy"

  firewall_policy_data = var.firewall_policy_data
}

module "firewall_rule_collection_group" {
  source = "./Modules/Azure/firewall_policy_rule_collection_group"

  firewall_policy_rule_collection_group_data = var.firewall_policy_rule_collection_group_data
}

module "firewall" {
  source = "./Modules/Azure/firewall"

  firewall_data    = var.firewall_data
  subnet_output    = module.subnet.subnet_output_names
  public_ip_output = module.public_ip.public_ip_output_names
}

module "linux_virtual_machine" {
  source = "./Modules/Azure/linux_virtual_machines"

  linux_virtual_machine_data = var.linux_virtual_machine_data
}

module "virtual_machine_extension" {
  source                         = "./Modules/virtual_machine_extension"
  virtual_machine_extension_data = var.virtual_machine_extension_data
  virtual_machine_output         = module.linux_virtual_machine.linux_virtual_machine_output_names
}

module "palo_alto" {
  source = "./Modules/Azure/palo_alto"

  fw_data                 = var.palo_alto_data
  availability_set_output = module.availability_set.availability_set_output
  #public_ip_prefix_output = data.terraform_remote_state.remote_state.outputs.public_ip_prefix.public_ip_prefix_output
  subnet_output = module.subnet.subnet_output_names
  depends_on = [ module.marketplace_agreement ]
}

module "availability_set" {
  source = "./Modules/Azure/availability_set"

  availability_set_data = var.availability_set_data
}

module "storage_account" {
  source               = "./Modules/storage_account"
  storage_account_data = var.storage_account_data
}
module "lb" {
  source = "./Modules/Azure/lb"

  lb_data                           = var.lb_data
  lb_frontend_ip_configuration_data = var.lb_frontend_ip_configuration_data
  subnet_output                     = module.subnet.subnet_output_names
}

module "lb_backend_address_pool" {
  source = "./Modules/Azure/lb_backend_address_pool"

  lb_backend_address_pool_data = var.lb_backend_address_pool_data
  lb_output                    = module.lb.lb_output_names
}

module "lb_backend_address_pool_address" {
  source = "./Modules/Azure/lb_backend_address_pool_address"

  lb_backend_address_pool_address_data = var.lb_backend_address_pool_address_data
}

module "lb_probe" {
  source = "./Modules/Azure/lb_probe"

  lb_probe_data = var.lb_probe_data
  lb_output     = module.lb.lb_output_names
}

module "lb_rule" {
  source = "./Modules/Azure/lb_rule"

  lb_rule_data                   = var.lb_rule_data
  lb_output                      = module.lb.lb_output_names
  lb_backend_address_pool_output = module.lb_backend_address_pool.lb_backend_address_pool_output_names
  lb_probe_output                = module.lb_probe.lb_probe_output_names
}

module "network_interface_backend_address_pool_association" {
  source = "./Modules/Azure/network_interface_backend_address_pool_association"

  network_interface_backend_address_pool_association_data = var.network_interface_backend_address_pool_association_data
  network_interface_output                                = module.palo_alto.network_interface_output_names
  lb_backend_address_pool_output                          = module.lb_backend_address_pool.lb_backend_address_pool_output_names
}

module "api_management" {

  source              = "./Modules/api_management"
  api_management_data = var.api_management_data
}

module "route_table" {
  source           = "./Modules/route_table"
  route_table_data = var.route_table_data
}

module "subnet_route_table_association_data" {
  source                              = "./Modules/subnet_route_table_association"
  subnet_route_table_association_data = var.subnet_route_table_association_data
  subnet_output                       = module.subnet.subnet_output_names
  route_table_output                  = module.route_table.route_table_output_names
}

module "private_dns_resolver" {
  source = "./Modules/Azure/private_dns_resolver"

  private_dns_resolver_data = var.private_dns_resolver_data
  virtual_network_output    = module.virtual_network.virtual_network_output_names
}

module "private_dns_resolver_outbound_endpoint" {
  source = "./Modules/Azure/private_dns_resolver_outbound_endpoint"

  private_dns_resolver_outbound_endpoint_data = var.private_dns_resolver_outbound_endpoint_data
  private_dns_resolver_output                 = module.private_dns_resolver.private_dns_resolver_output_names
  subnet_output                               = module.subnet.subnet_output_names
}

module "private_dns_resolver_dns_forwarding_ruleset" {
  source = "./Modules/Azure/private_dns_resolver_dns_forwarding_ruleset"

  private_dns_resolver_dns_forwarding_ruleset_data = var.private_dns_resolver_dns_forwarding_ruleset_data
  private_dns_resolver_outbound_endpoint_output    = module.private_dns_resolver_outbound_endpoint.private_dns_resolver_outbound_endpoint_output_names
}

module "private_dns_resolver_forwarding_rule" {
  source = "./Modules/Azure/private_dns_resolver_forwarding_rule"

  private_dns_resolver_forwarding_rule_data         = var.private_dns_resolver_forwarding_rule_data
  private_dns_resolver_dns_forwarding_ruleset_ouput = module.private_dns_resolver_dns_forwarding_ruleset.private_dns_resolver_dns_forwarding_ruleset_output_names
}

module "private_dns_resolver_virtual_network_link" {
  source = "./Modules/Azure/private_dns_resolver_virtual_network_link"

  private_dns_resolver_virtual_network_link_data     = var.private_dns_resolver_virtual_network_link_data
  virtual_network_output                             = module.virtual_network.virtual_network_output_names
  private_dns_resolver_dns_forwarding_ruleset_output = module.private_dns_resolver_dns_forwarding_ruleset.private_dns_resolver_dns_forwarding_ruleset_output_names
}

module "log_analytics_workspace" {
  source                       = "./Modules/log_analytics_workspace"
  log_analytics_workspace_data = var.log_analytics_workspace_data
}

module "mssql_server" {
  source            = "./Modules/mssql_server"
  mssql_server_data = var.mssql_server_data
}

module "mssql_server_extended_auditing_policy" {
  source                                     = "./Modules/mssql_server_extended_auditing_policy"
  mssql_server_extended_auditing_policy_data = var.mssql_server_extended_auditing_policy_data
  mssql_server_output                        = module.mssql_server.mssql_server_output_names
}

module "mssql_virtual_network_rule" {
  source                          = "./Modules/mssql_virtual_network_rule"
  mssql_virtual_network_rule_data = var.mssql_virtual_network_rule_data
  mssql_server_output             = module.mssql_server.mssql_server_output_names

}

module "mssql_firewall_rule" {
  source = "./Modules/Azure/mssql_firewall_rule"
  mssql_firewall_rule_data = var.mssql_firewall_rule_data
  mssql_server_output             = module.mssql_server.mssql_server_output_names
}

module "mssql_server_security_alert_policy" {
  source = "./Modules/Azure/mssql_server_security_alert_policy"
  mssql_server_security_alert_policy_data = var.mssql_server_security_alert_policy_data
  mssql_server_output             = module.mssql_server.mssql_server_output_names
}

module "storage_container" {
  source = "./Modules/Azure/storage_container"
  storage_container_data = var.storage_container_data
}

module "storage_share" {
        source = "./Modules/Azure/storage_share"

        storage_share_data = var.storage_share_data
}

module "storage_share_directory" {
        source = "./Modules/Azure/storage_share_directory"

        storage_share_directory_data = var.storage_share_directory_data
}

module "private_endpoint" {
  source = "./Modules/Azure/private_endpoint"
  private_endpoint_data = var.private_endpoint_data
  mssql_server_output             = module.mssql_server.mssql_server_output_names
  storage_account_output = module.storage_account.storage_account_output_names
  key_vault_output = module.key_vault.key_vault_output_output_names
}

module "role_assignment" {
        source = "./Modules/Azure/role_assignment"

        role_assignment_data = var.role_assignment_data
}

module "marketplace_agreement" {
        source = "./Modules/Azure/marketplace_agreement"

        marketplace_agreement_data = var.marketplace_agreement_data
}

module "management_lock" {
        source = "./Modules/Azure/management_lock"

        management_lock_data = var.management_lock_data
}
