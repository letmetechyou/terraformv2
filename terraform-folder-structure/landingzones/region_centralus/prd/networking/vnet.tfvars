virtual_network_data = {
    vnet--nonprd-centralus-01 = {
    enabled             = true    
    name                = "test-vnet-prd"
	resource_group_name = "test-prd-vnet-rg"
	address_space       = ["10.0.1.0/24"]
	location            = "Centralus"
    }
}