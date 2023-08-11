resource "azurerm_log_analytics_workspace" "log_analytics" {
  name                       = "log-tfanalytics-australiasoutheast"
  resource_group_name        = data.azurerm_resource_group.group.name
  location                   = data.azurerm_resource_group.group.location
  sku                        = "PerGB2018"
  retention_in_days          = 120
  internet_ingestion_enabled = true
  internet_query_enabled     = true
}

resource "azurerm_log_analytics_linked_storage_account" "diagnostics" {
  data_source_type      = "CustomLogs"
  resource_group_name   = data.azurerm_resource_group.group.name
  workspace_resource_id = azurerm_log_analytics_workspace.log_analytics.id
  storage_account_ids   = [azurerm_storage_account.storage.id]
}
