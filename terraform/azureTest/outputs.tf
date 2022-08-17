output "azurerm_kubernetes_cluster" {
  description = "Ouputs the Kubernetes cluster attributes"  
  value = azurerm_kubernetes_cluster.aks
}

output "azurerm_kubernetes_cluster_kube_config" {
  description = "Outputs the raw Kubernetes config to be used by kubectl and other compatible tools"  
  value = azurerm_kubernetes_cluster.aks.kube_config_raw

  sensitive = false
}

output "azurerm_kubernetes_cluster_node_pool" {
  description = "Ouputs the Kubernetes cluster user node pool attributes"  
  value = azurerm_kubernetes_cluster_node_pool.user_pool
}

output "azurerm_container_registry" {
  description = "Ouputs the container registry attributes"  
  value = azurerm_container_registry.acr
}

output "azurerm_private_endpoint" {
  description = "Ouputs the azurerm private endpoint attributes"  
  value = azurerm_private_endpoint.pep
}

output "azurerm_user_assigned_identity" {
  description = "Ouputs the user assigned identity attributes"  
  value = azurerm_user_assigned_identity.id
}

output "azurerm_log_analytics_workspace" {
  description = "Ouputs the log analytics workspace attributes"  
  value = azurerm_log_analytics_workspace.logs
}

output "azurerm_subnet" {
  description = "Ouputs the subnet attributes"  
  value = azurerm_subnet.snet
}

output "azurerm_subnet_route_table_association" {
  description = "Ouputs the subnet route table association attributes"  
  value = azurerm_subnet_route_table_association.aks_subnet_association
}







