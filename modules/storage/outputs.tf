output "storage_account_id" { value = azurerm_storage_account.sa.id }
output "storage_account_name" { value = azurerm_storage_account.sa.name }
output "private_endpoint_ip" { value = azurerm_private_endpoint.pe_blob.private_service_connection[0].private_ip_address }
