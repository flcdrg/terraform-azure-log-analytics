resource "azurerm_storage_account" "storage" {
  name                            = "sttfanalyticsausse"
  location                        = data.azurerm_resource_group.group.location
  resource_group_name             = data.azurerm_resource_group.group.name
  access_tier                     = "Cool"
  account_kind                    = "StorageV2"
  account_replication_type        = "LRS"
  account_tier                    = "Standard"
  allow_nested_items_to_be_public = false
  enable_https_traffic_only       = true
  min_tls_version                 = "TLS1_2"
  public_network_access_enabled   = false

  blob_properties {
    delete_retention_policy {
      days = 7
    }
    versioning_enabled = true
    container_delete_retention_policy {
      days = 31
    }
  }
}