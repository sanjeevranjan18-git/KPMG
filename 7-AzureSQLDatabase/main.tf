resource "azurerm_sql_database" "kpmgsqldatabase" {
  for_each            = var.kpmg
  name                = each.key
  resource_group_name = each.value.rg
  location            = each.value.location
  server_name         = each.value.name

}
