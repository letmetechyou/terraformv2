# Public IP for PAN mgmt Intf
resource "azurerm_public_ip" "public_ip" {
	for_each = merge([for vm,data in (merge([for k, v in var.fw_data : {for i in range(v.qty) : "${v.name_prefix}${format("%02d", v.start+i)}" => v if v.build}]...)) : { for nic in keys(data.network_configuration) : "${vm}-${nic}" => data if lookup(data.network_configuration,nic).public_ip}]...)

/*
	for_each = merge([for k,v in var.fw_data :
        { for nic in keys(v.network_configuration) : "${v.name}-${nic}" => v if lookup(v.network_configuration,nic).public_ip}]...)
*/        
	name                	= "${each.key}-pubip"
	resource_group_name 	= each.value.resource_group_name
	location            	= each.value.location

	sku 			= "Standard"
    	allocation_method   	= "Static"
	domain_name_label	= each.value.network_configuration["${strrev(split("-", strrev("${each.key}"))[0])}"].dns == false ? null : each.key
	#(lookup(each.value.network_configuration,split("-",each.key)[1]).dns) == false ? null : each.key #each.value.network_configuration..domain_name_label
	
	public_ip_prefix_id	= try(
		try(var.public_ip_prefix_output["${each.value.network_configuration["${strrev(split("-", strrev("${each.key}"))[0])}"].public_ip_prefix}"].id, null),
		null) 
	#can(lookup(each.value.network_configuration,split("-",each.key)[1]).public_ip_prefix_name) == false ? null : (element(var.public_ip_prefix_output[*],index(var.public_ip_prefix_output[*].name,(lookup(each.value.network_configuration,split("-",each.key)[1]).public_ip_prefix_name)))).id #var.public_ip_prefix_output.prefix["${(lookup(each.value.network_configuration,split("-",each.key)[1]).public_ip_prefix_name)}"].id

	tags = each.value.tags

	lifecycle {
		prevent_destroy = false
	}
}