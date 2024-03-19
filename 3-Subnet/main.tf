resource "azurerm_subnet" "kpmgappsubnetwork" {
  for_each             = var.kpmg
  name                 = each.key
  resource_group_name  = each.value.rg
  virtual_network_name = each.value.vnet
  address_prefixes     = each.value.addsbnt

}