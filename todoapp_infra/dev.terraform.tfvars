rgs = {
  rg-dev-shree = {
    location = "Central India"
  }
}

vnets_subnets = {
  vnet-shree = {
    location            = "Central India"
    resource_group_name = "rg-dev-shree"
    address_space       = ["10.0.0.0/16"]
    # The AzureBastionSubnet Block is required in subnets if enable_bastion=true 
    # AzureBastionSubnet = {
    #     address_prefix = "10.0.2.0/24"
    # }
    enable_bastion = false
    subnets = {
      frontend-subnet = {
        address_prefix = "10.0.0.0/24"
      }
      backend-subnet = {
        address_prefix = "10.0.1.0/24"
      }
      AzureBastionSubnet = {
        address_prefix = "10.0.2.0/24"
      }
    }
  }
}

vms = {
  "frontendvm" = {
    resource_group_name = "rg-dev-shree"
    location            = "Central India"
    vnet_name           = "vnet-shree"
    subnet_name         = "frontend-subnet"
    size                = "Standard_DS1_v2"
    admin_username      = "devopsadmin"
    admin_password      = "P@ssw01rd@123"
    inbound_open_ports  = [22, 80]
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-focal"
      sku       = "20_04-lts"
      version   = "latest"
    }
    enable_public_ip = false
  }
  "backendvm" = {
    resource_group_name = "rg-dev-shree"
    location            = "Central India"
    vnet_name           = "vnet-shree"
    subnet_name         = "backend-subnet"
    size                = "Standard_DS1_v2"
    admin_username      = "devopsadmin"
    admin_password      = "P@ssw01rd@123"
    inbound_open_ports  = [22, 80]
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-focal"
      sku       = "20_04-lts"
      version   = "latest"
    }
    enable_public_ip = true
  }
}

loadbalancers = {
  lb-shree = {
    location                       = "Central India"
    resource_group_name            = "rg-dev-shree"
    frontend_ip_configuration_name = "PublicIPAddress"
    sku                            = "Standard"
  }
}

backend_pools = {
  frontend-pool = {
    port        = 80
    lb_name     = "lb-shree"
    backend_vms = ["frontendvm1", "frontendvm2"]
  }
}

servers_dbs = {
  "devopsinssrv1" = {
    resource_group_name          = "rg-dev-shree"
    location                     = "Central India"
    version                      = "12.0"
    administrator_login          = "devopsadmin"
    administrator_login_password = "P@ssw01rd@123"
    dbs                          = ["todoappdb"]
  }
}
