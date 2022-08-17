resource "oebbnc_azure" "this" {
  product     = var.product
  environment = var.environment
  basename    = "aks"
}

# Take existing routetable of the spoke/landing zone/produktumgebung
data "azurerm_route_table" "rt" {
  name                = var.route_table_name
  resource_group_name = var.rg_spoke_name
}

# Create a new subnet only for the aks cluster
resource "azurerm_subnet" "snet" {
  name                 = oebbnc_azure.this.names_no_seq["azurerm_subnet"]
  resource_group_name  = var.rg_spoke_name
  virtual_network_name = var.vnet_name
  address_prefixes     = var.snet_address_prefixes
  enforce_private_link_endpoint_network_policies = true

  lifecycle {
    ignore_changes = [
      name
    ]
  }
}

resource "azurerm_subnet_route_table_association" "aks_subnet_association" {
  subnet_id      = azurerm_subnet.snet.id
  route_table_id = data.azurerm_route_table.rt.id
}

# Data source to get Latest Azure AKS latest Version
data "azurerm_kubernetes_service_versions" "current" {
  location        = var.location
  include_preview = false  
}

# Create resource group for AKS
resource "azurerm_resource_group" "rg" {
  name     = oebbnc_azure.this.names_no_seq["azurerm_resource_group"]
  location = var.location
  tags     = var.tags
  
  lifecycle {
    ignore_changes = [
      name
    ]
  }
}

# Create container registry
resource "azurerm_container_registry" "acr" {
  count                          = var.global_acr_id == null ? 1 : 0
  name                           = oebbnc_azure.this.names_no_seq["azurerm_container_registry"]
  resource_group_name            = azurerm_resource_group.rg.name
  location                       = var.location
  sku                            = "Premium"
  admin_enabled                  = false
  public_network_access_enabled  = false
  export_policy_enabled          = false
  
  identity {
    type = "SystemAssigned"
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [
      name
    ]
  }
}

# Create private endpoint for container registry
resource "azurerm_private_endpoint" "pep" {
  count               = var.global_acr_id == null ? 1 : 0
  name                = oebbnc_azure.this.names_no_seq["azurerm_private_endpoint"]
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  subnet_id           = azurerm_subnet.snet.id

  private_service_connection {
    name                           = "${var.product}-${var.environment}-privateserviceconnection"
    private_connection_resource_id = azurerm_container_registry.acr[0].id
    is_manual_connection           = false
    subresource_names              = ["registry"] 
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [
      name
    ]
  }
}

# Create user identity
resource "azurerm_user_assigned_identity" "id" {
  name                = oebbnc_azure.this.names_no_seq["azurerm_user_assigned_identity"]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags

  lifecycle {
    ignore_changes = [
      name
    ]
  }
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                                = oebbnc_azure.this.names_no_seq["azurerm_kubernetes_cluster"]
  location                            = var.location
  resource_group_name                 = azurerm_resource_group.rg.name
  kubernetes_version                  = var.kubernetes_version != null ? var.kubernetes_version : data.azurerm_kubernetes_service_versions.current.latest_version
  sku_tier                            = var.sku_tier
  dns_prefix                          = "${var.product}${var.environment}aks"
  private_cluster_enabled             = true
  private_cluster_public_fqdn_enabled = false 

  network_profile {
    network_plugin     = "azure"
    service_cidr       = var.service_cidr
    dns_service_ip     = var.dns_service_ip
    docker_bridge_cidr = var.docker_bridge_cidr
    outbound_type      = "userDefinedRouting"
  }

  default_node_pool {
    name                = "defaultpool"
    node_count          = var.system_pool_node_count
    max_pods            = var.system_pool_max_pods
    vm_size             = var.system_pool_vm_size
    vnet_subnet_id      = azurerm_subnet.snet.id
    zones               = var.system_pool_availability_zones
  }
  
  identity {
    type          = "UserAssigned"
    identity_ids  = [azurerm_user_assigned_identity.id.id]
  }

  role_based_access_control_enabled = true
  azure_policy_enabled              = false
  http_application_routing_enabled  = false
  
  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.logs.id
  } 

  depends_on = [
    azurerm_user_assigned_identity.id,
    azurerm_log_analytics_workspace.logs,
    azurerm_container_registry.acr
  ]  

  tags = var.tags

  lifecycle {
    ignore_changes = [
      name
    ]
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "user_pool" {
  name                   = "userpool"
  kubernetes_cluster_id  = azurerm_kubernetes_cluster.aks.id
  vm_size                = var.user_pool_vm_size
  vnet_subnet_id         = azurerm_subnet.snet.id
  enable_auto_scaling    = true
  max_count              = var.user_pool_max_count
  min_count              = var.user_pool_min_count
  enable_node_public_ip  = false
  zones                  = var.user_pool_availability_zones

  depends_on = [
    azurerm_kubernetes_cluster.aks
  ]

  tags = var.tags

  lifecycle {
    ignore_changes = [
      name
    ]
  }
}  

# Grant AKS cluster access to Pull ACR
resource "azurerm_role_assignment" "aks_to_acr_role" {
    principal_id                     = azurerm_user_assigned_identity.id.principal_id
    role_definition_name             = "AcrPull"
    scope                            = var.global_acr_id == null ? azurerm_container_registry.acr[0].id : var.global_acr_id
    skip_service_principal_aad_check = true
    
    depends_on = [
      azurerm_container_registry.acr,
      azurerm_kubernetes_cluster.aks
  ]
}

resource "azurerm_log_analytics_workspace" "logs" {
  name                = oebbnc_azure.this.names_no_seq["azurerm_log_analytics_workspace"]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = var.log_sku
  retention_in_days   = var.log_retention
  tags                = var.tags

  lifecycle {
    ignore_changes = [
      name
    ]
  }
}
