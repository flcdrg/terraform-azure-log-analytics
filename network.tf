resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-tfanalytics-australiasoutheast"
  address_space       = ["10.1.0.0/16"]
  location            = data.azurerm_resource_group.group.location
  resource_group_name = data.azurerm_resource_group.group.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet-tfanalytics-australiasoutheast"
  resource_group_name  = data.azurerm_resource_group.group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.1.0.0/24"]
}