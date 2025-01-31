provider "azurerm" {
  features {}
  subscription_id = "aab300ef-5c07-4cc8-a9df-951c157bb99d"
  tenant_id = "0a28eb69-0ec3-4155-8484-ece820ce95d4"
}

# Define Variables
variable "resource_group_name" {
  default = "my-webapp-rg"
}

variable "location" {
  default = "Central US"
}

variable "app_service_plan_name" {
  default = "my-appservice-plan"
}

variable "web_app_name" {
 
default = "uniquewebappnamerabbani"
}

variable "runtime_stack" {
  default = "DOTNETCORE:8.0" # Change to "DOTNETCORE:6.0" for .NET 6
}

# Create Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Create App Service Plan
resource "azurerm_app_service_plan" "app_service_plan" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Basic"
    size = "B1"
  }
}

# Create Web App
resource "azurerm_app_service" "web_app" {
  name                = var.web_app_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id

  site_config {
    linux_fx_version = var.runtime_stack
  }
}

output "web_app_url" {
  value = "https://${azurerm_app_service.web_app.default_site_hostname}"
}
