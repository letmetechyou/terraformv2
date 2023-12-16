output "public_ip_output" {
	value = values(azurerm_public_ip.public_ip)[*]
}