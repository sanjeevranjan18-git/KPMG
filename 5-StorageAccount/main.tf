resource "azurerm_storage_account" "kpmgappstorageaccount1" {
  for_each                 = var.kpmg
  name                     = each.key
  resource_group_name      = each.value.rg
  location                 = each.value.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

}
