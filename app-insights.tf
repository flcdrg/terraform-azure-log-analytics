resource "azurerm_application_insights" "app_insights" {
  name                = "appi-tfanalytics-australiasoutheast"
  location            = data.azurerm_resource_group.group.location
  resource_group_name = data.azurerm_resource_group.group.name
  application_type    = "web"
  retention_in_days   = 120
  disable_ip_masking  = true
  workspace_id        = azurerm_log_analytics_workspace.log_analytics.id
}
