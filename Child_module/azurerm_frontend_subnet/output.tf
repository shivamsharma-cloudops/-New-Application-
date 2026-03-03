output "subnet_id" {
  description = "The ID of the frontend subnet"
  value       = azurerm_subnet.subnet1.id
}