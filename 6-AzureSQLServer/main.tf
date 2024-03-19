resource "azurerm_sql_server" "kpmgsqlserver" {
  for_each                     = var.kpmg
  name                         = each.key
  resource_group_name          = each.value.rg
  location                     = each.value.location
  version                      = "12.0"
  administrator_login          = each.value.login
  administrator_login_password = each.value.pass

}
