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

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.user_id.id]
  }
}

resource "azurerm_storage_account_network_rules" "storage" {
  storage_account_id = azurerm_storage_account.storage.id
  default_action     = "Deny"
  bypass             = ["AzureServices", "Logging", "Metrics"]
}

resource "azurerm_private_endpoint" "pe_storage_blob" {
  name                = "pe-${azurerm_storage_account.storage.name}"
  location            = azurerm_storage_account.storage.location
  resource_group_name = azurerm_storage_account.storage.resource_group_name
  subnet_id           = azurerm_subnet.subnet.id

  # private connection details
  private_service_connection {
    name                           = "psc-${azurerm_storage_account.storage.name}"
    private_connection_resource_id = azurerm_storage_account.storage.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }
}
