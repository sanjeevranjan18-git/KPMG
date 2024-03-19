data "azurerm_subnet" "subnet" {
  for_each = var.kpmg
  name                 = each.value.sub
  virtual_network_name = each.value.vnet
  resource_group_name  = each.value.rg
}

resource "azurerm_public_ip" "kpmgapppublicip" {
  for_each            = var.kpmg
  name                = each.value.pip
  resource_group_name = each.value.rg
  location            = each.value.location
  allocation_method   = "Static"

}
resource "azurerm_network_interface" "kpmgappinterface" {
  for_each            = var.kpmg
  name                = each.value.ni
  location            = each.value.location
  resource_group_name = each.value.rg

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet[each.key].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.kpmgapppublicip[each.key].id
  }
}

resource "azurerm_linux_virtual_machine" "kpmgappvirtualmachine" {
  for_each                        = var.kpmg
  name                            = each.key
  resource_group_name             = each.value.rg
  location                        = each.value.location
  size                            = "Standard_F2"
  admin_username                  = each.value.usr
  admin_password                  = each.value.pass
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.kpmgappinterface[each.key].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
