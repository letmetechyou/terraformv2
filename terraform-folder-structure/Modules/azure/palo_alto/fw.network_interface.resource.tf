resource "azurerm_network_interface" "network_interface" {

	for_each = merge([for vm,data in (merge([for k, v in var.fw_data : {for i in range(v.qty) : "${v.name_prefix}${format("%02d", v.start+i)}" => v if v.build}]...)) : { for nic in keys(data.network_configuration) : "${vm}-${nic}" => data }]...)
/* 	for_each = merge([for k,v in var.fw_data :
        { for nic in keys(v.network_configuration) : "${v.name}-${nic}" => v }]...)
 */
	name                = "${each.key}-nic"
	resource_group_name = each.value.resource_group_name
	location            = each.value.location

	enable_ip_forwarding		= each.value.network_configuration["${strrev(split("-", strrev("${each.key}"))[0])}"].enable_ip_forwarding #lookup(each.value.network_configuration,split("-",each.key)[1]).enable_ip_forwarding
	enable_accelerated_networking 	= each.value.network_configuration["${strrev(split("-", strrev("${each.key}"))[0])}"].enable_accelerated_networking #lookup(each.value.network_configuration,split("-",each.key)[1]).enable_ip_forwarding
	
	ip_configuration {
		name				= "${each.key}_ip_config"
		subnet_id			= var.subnet_output["${each.value.network_configuration["${strrev(split("-", strrev("${each.key}"))[0])}"].subnet}"].id #lookup(each.value.network_configuration,split("-",each.key)[1]).subnet_id
		private_ip_address_allocation	= each.value.network_configuration["${strrev(split("-", strrev("${each.key}"))[0])}"].private_ip_address_allocation #lookup(each.value.network_configuration,split("-",each.key)[1]).private_ip_address_allocation
                private_ip_address		= each.value.network_configuration["${strrev(split("-", strrev("${each.key}"))[0])}"].private_ip_address_allocation == "dynamic" ? null : each.value.network_configuration["${strrev(split("-", strrev("${each.key}"))[0])}"].private_ip_address #(lookup(each.value.network_configuration,split("-",each.key)[1]).private_ip_address_allocation) == "dynamic" ? null : lookup(each.value.network_configuration,split("-",each.key)[1]).private_ip_address
                public_ip_address_id		= each.value.network_configuration["${strrev(split("-", strrev("${each.key}"))[0])}"].public_ip == false ? null : azurerm_public_ip.public_ip[each.key].id #(lookup(each.value.network_configuration,split("-",each.key)[1]).public_ip) == false ? null : azurerm_public_ip.public_ip[each.key].id
	}

	depends_on = [
		#azurerm_resource_group.rg
	]

	lifecycle {
		prevent_destroy = false
	}
}