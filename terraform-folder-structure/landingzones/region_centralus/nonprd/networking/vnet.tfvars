virtual_network_data = {
    vnet--nonprd-centralus-01 = {
    enabled             = true    
    name                = "test-vnet-nonprd"
	resource_group_name = "test-vnet-rg"
	address_space       = ["10.0.0.0/24"]
	location            = "Centralus"
    }
}