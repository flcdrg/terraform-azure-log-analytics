resource "azurerm_user_assigned_identity" "user_id" {
  name                = "mi-tfanalytics-australiasoutheast"
  location            = data.azurerm_resource_group.group.location
  resource_group_name = data.azurerm_resource_group.group.name
}