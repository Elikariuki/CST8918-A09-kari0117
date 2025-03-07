# Azure Provider configuration
provider "azurerm" {
  features {}
  # Add subscription_id, tenant_id if needed for production
}

# Create a resource group to contain the storage account
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "East US"
  tags = {
    environment = "dev"
  }
}

# Create an Azure Storage Account
resource "azurerm_storage_account" "example" {
  name                     = "kari0117-store" # Storage account name must be globally unique
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"  # Choose between Standard and Premium
  account_replication_type = "LRS"       # LRS = Locally redundant storage
}

# Output the storage account primary access key
output "storage_account_primary_access_key" {
  value       = azurerm_storage_account.example.primary_access_key
  description = "The primary access key for the storage account"
  sensitive   = true # Marks this output as sensitive
}