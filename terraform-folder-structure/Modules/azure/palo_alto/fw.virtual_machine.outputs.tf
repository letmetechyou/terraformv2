output "virtual_machine_output" {
	value = zipmap(values(azurerm_virtual_machine.virtual_machine)[*].name, values(azurerm_virtual_machine.virtual_machine)[*])

}