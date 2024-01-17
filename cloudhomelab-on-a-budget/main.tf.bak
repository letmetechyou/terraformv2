terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.68.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Configure Resource Group

resource "azurerm_resource_group" "homelabrg" {
  name = "homelab-rg"
  location = "centralus"
}

# create virtual network

resource "azurerm_virtual_network" "homelabvirtualnetwork" {
  name                = "homelab-vnet"
  location            = azurerm_resource_group.homelabrg.location
  resource_group_name = azurerm_resource_group.homelabrg.name
  address_space       = ["10.0.0.0/16"]

#   subnet {
#     name           = "rghomelabsubnet"
#     address_prefix = "10.0.1.0/24"
#     security_group = azurerm_network_security_group.homelabnsg.id
#   }

  tags = {
    environment = "Production"
  }
}

resource "azurerm_subnet" "homelabsubnet" {
  name                 = "homelab-subnet"
  resource_group_name  = azurerm_resource_group.homelabrg.name
  virtual_network_name = azurerm_virtual_network.homelabvirtualnetwork.name
  address_prefixes     = ["10.0.1.0/24"]
}

#associate nsg with subnet
resource "azurerm_subnet_network_security_group_association" "homelabnsgassocation" {
  subnet_id                 = azurerm_subnet.homelabsubnet.id
  network_security_group_id = azurerm_network_security_group.homelabnsg.id
}

#create a network security group

resource "azurerm_network_security_group" "homelabnsg" {
  name                = "allow-access-from-home"
  location            = azurerm_resource_group.homelabrg.location
  resource_group_name = azurerm_resource_group.homelabrg.name

  security_rule {
    name                       = "allowrdp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*" #<----- set this to your home ip
    destination_address_prefix = "*"
  }
}

# create a network interface 

resource "azurerm_network_interface" "homelabnic" {
  name                = "example-nic"
  location            = azurerm_resource_group.homelabrg.location
  resource_group_name = azurerm_resource_group.homelabrg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.homelabsubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.homelabpip.id
  }
}

resource "azurerm_public_ip" "homelabpip" {
    name                = "homelabpip"
  resource_group_name = azurerm_resource_group.homelabrg.name
  location            = azurerm_resource_group.homelabrg.location
  allocation_method   = "Static"
}


#create a windows virtual machine

resource "azurerm_windows_virtual_machine" "homelabvm" {
  name                = "homelab-machine"
  resource_group_name = azurerm_resource_group.homelabrg.name
  location            = azurerm_resource_group.homelabrg.location
  size                = "Standard_F2" #<----- make this whatever size you want to build
  admin_username      = "adminuser"
  admin_password      = ""
  network_interface_ids = [
    azurerm_network_interface.homelabnic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter" #<----- change this to whatever os azure supports for windows
    version   = "latest"
  }
}

