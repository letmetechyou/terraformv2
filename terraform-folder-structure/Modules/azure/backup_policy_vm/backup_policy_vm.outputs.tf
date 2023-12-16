output "backup_policy_vm_output" {
  value = zipmap(values(azurerm_backup_policy_vm.backup_policy_vm)[*].name, values(azurerm_backup_policy_vm.backup_policy_vm)[*])
}

output "backup_policy_vm_names" {
  value = { for key, value in azurerm_backup_policy_vm.backup_policy_vm : value.name => value }
}