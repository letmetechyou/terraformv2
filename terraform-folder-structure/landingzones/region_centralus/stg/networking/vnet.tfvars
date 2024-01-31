virtual_network_data = {
    vnet-stg-centralus-01 = {
    enabled             = true    
    name                = "test-vnet-stg"
	resource_group_name = "test-stg-vnet-rg"
	address_space       = ["10.0.2.0/24"]
	location            = "Centralus"
    }
}