output "resource_group_name" {
  value       = azurerm_resource_group.rg.name
  description = "Created Azure Resource Group Name"
}

output "vnet_id" {
  value       = module.network.vnet_id
  description = "Virtual Network ID"
}

output "storage_account_name" {
  value       = module.storage.storage_account_name
  description = "Enterprise Azure Storage Account Name"
}
