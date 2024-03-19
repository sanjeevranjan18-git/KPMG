resource "azurerm_resource_group" "kpmgappresourcegroup" {
  for_each = var.kpmg
  name     = each.key
  location = each.value.location
}
