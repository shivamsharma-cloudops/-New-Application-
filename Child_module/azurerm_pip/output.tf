output "pip_id" {
  description = "The ID of the public IP"
  value       = azurerm_public_ip.pip1.id
}