<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_oebbnc"></a> [oebbnc](#provider\_oebbnc) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_container_registry.acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) | resource |
| [azurerm_kubernetes_cluster_node_pool.user_pool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool) | resource |
| [azurerm_log_analytics_workspace.logs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_private_endpoint.pep](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.aks_to_acr_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_subnet.snet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_route_table_association.aks_subnet_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |
| [azurerm_user_assigned_identity.id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| oebbnc_azure.this | resource |
| [azurerm_kubernetes_service_versions.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_service_versions) | data source |
| [azurerm_route_table.rt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/route_table) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dns_service_ip"></a> [dns\_service\_ip](#input\_dns\_service\_ip) | IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns) | `string` | `"192.168.0.100"` | no |
| <a name="input_docker_bridge_cidr"></a> [docker\_bridge\_cidr](#input\_docker\_bridge\_cidr) | IP address (in CIDR notation) used as the Docker bridge IP address on nodes | `string` | `"172.17.0.1/16"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Name of the environment | `string` | n/a | yes |
| <a name="input_global_acr_id"></a> [global\_acr\_id](#input\_global\_acr\_id) | ID of the existing centralised acr | `string` | `null` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Version of Kubernetes specified when creating the AKS managed cluster | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure location where the resources are deployed to | `string` | `"westeurope"` | no |
| <a name="input_log_retention"></a> [log\_retention](#input\_log\_retention) | Workspace data retention in days. Possible values are either 7 (Free Tier only) or range between 30 and 730 | `number` | n/a | yes |
| <a name="input_log_sku"></a> [log\_sku](#input\_log\_sku) | Specifies the SKU of the Log Analytics Workspace | `string` | `"PerGB2018"` | no |
| <a name="input_product"></a> [product](#input\_product) | Name of the product | `string` | n/a | yes |
| <a name="input_rg_spoke_name"></a> [rg\_spoke\_name](#input\_rg\_spoke\_name) | Name of the resource group of Spoke | `string` | n/a | yes |
| <a name="input_route_table_name"></a> [route\_table\_name](#input\_route\_table\_name) | Name of the Route Table | `string` | n/a | yes |
| <a name="input_service_cidr"></a> [service\_cidr](#input\_service\_cidr) | Network Range used by the Kubernetes service | `string` | `"192.168.0.0/16"` | no |
| <a name="input_sku_tier"></a> [sku\_tier](#input\_sku\_tier) | SKU Tier that should be used for this Kubernetes Cluster | `string` | `"Free"` | no |
| <a name="input_snet_address_prefixes"></a> [snet\_address\_prefixes](#input\_snet\_address\_prefixes) | Address prefixes to use for the subnet | `list(string)` | n/a | yes |
| <a name="input_system_pool_availability_zones"></a> [system\_pool\_availability\_zones](#input\_system\_pool\_availability\_zones) | List of Availability Zones across which the Node Pool should be spread | `list(string)` | <pre>[<br>  "1",<br>  "2",<br>  "3"<br>]</pre> | no |
| <a name="input_system_pool_max_pods"></a> [system\_pool\_max\_pods](#input\_system\_pool\_max\_pods) | Maximum number of pods that can run on each agent | `number` | `110` | no |
| <a name="input_system_pool_node_count"></a> [system\_pool\_node\_count](#input\_system\_pool\_node\_count) | Initial number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000 and between min\_count and max\_count | `number` | n/a | yes |
| <a name="input_system_pool_vm_size"></a> [system\_pool\_vm\_size](#input\_system\_pool\_vm\_size) | Size of the Virtual Machine (e.g: Standard\_DS2\_v2) | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | This Object is used to store information about the running deployment. Resources will be tagged with it | `map(string)` | `{}` | no |
| <a name="input_user_pool_availability_zones"></a> [user\_pool\_availability\_zones](#input\_user\_pool\_availability\_zones) | List of Availability Zones across which the Node Pool should be spread | `list(string)` | <pre>[<br>  "1",<br>  "2",<br>  "3"<br>]</pre> | no |
| <a name="input_user_pool_max_count"></a> [user\_pool\_max\_count](#input\_user\_pool\_max\_count) | Maximum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000 | `number` | n/a | yes |
| <a name="input_user_pool_min_count"></a> [user\_pool\_min\_count](#input\_user\_pool\_min\_count) | Minimum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000 | `number` | n/a | yes |
| <a name="input_user_pool_vm_size"></a> [user\_pool\_vm\_size](#input\_user\_pool\_vm\_size) | Size of the Virtual Machine (e.g: Standard\_DS2\_v2) | `string` | n/a | yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Name of the virtual network | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azurerm_container_registry"></a> [azurerm\_container\_registry](#output\_azurerm\_container\_registry) | Ouputs the container registry attributes |
| <a name="output_azurerm_kubernetes_cluster"></a> [azurerm\_kubernetes\_cluster](#output\_azurerm\_kubernetes\_cluster) | Ouputs the Kubernetes cluster attributes |
| <a name="output_azurerm_kubernetes_cluster_kube_config"></a> [azurerm\_kubernetes\_cluster\_kube\_config](#output\_azurerm\_kubernetes\_cluster\_kube\_config) | Outputs the raw Kubernetes config to be used by kubectl and other compatible tools |
| <a name="output_azurerm_kubernetes_cluster_node_pool"></a> [azurerm\_kubernetes\_cluster\_node\_pool](#output\_azurerm\_kubernetes\_cluster\_node\_pool) | Ouputs the Kubernetes cluster user node pool attributes |
| <a name="output_azurerm_log_analytics_workspace"></a> [azurerm\_log\_analytics\_workspace](#output\_azurerm\_log\_analytics\_workspace) | Ouputs the log analytics workspace attributes |
| <a name="output_azurerm_private_endpoint"></a> [azurerm\_private\_endpoint](#output\_azurerm\_private\_endpoint) | Ouputs the azurerm private endpoint attributes |
| <a name="output_azurerm_subnet"></a> [azurerm\_subnet](#output\_azurerm\_subnet) | Ouputs the subnet attributes |
| <a name="output_azurerm_subnet_route_table_association"></a> [azurerm\_subnet\_route\_table\_association](#output\_azurerm\_subnet\_route\_table\_association) | Ouputs the subnet route table association attributes |
| <a name="output_azurerm_user_assigned_identity"></a> [azurerm\_user\_assigned\_identity](#output\_azurerm\_user\_assigned\_identity) | Ouputs the user assigned identity attributes |

## Example Usage

# Create Azure Kubernetes Service with private IP
```tf
locals {  
  tags = {
    Type                      = "Private AKS Cluster"
    Project                   = var.product
    Environment               = var.environment
    Location                  = var.location
    ProvisionEngine           = "Terraform"
  }
}

# Create Azure Kubernetes Service with private IP
module "aks_cluster" {
  source = "./modules/private-aks"

  rg_spoke_name                  = var.rg_spoke_name 
  location                       = var.location
  product                        = var.product
  environment                    = var.environment
  snet_address_prefixes          = var.snet_address_prefixes
  vnet_name                      = var.vnet_name
  route_table_name               = var.route_table_name
  global_acr_id                  = var.global_acr_id
  kubernetes_version             = var.kubernetes_version
  sku_tier                       = var.sku_tier
  service_cidr                   = var.service_cidr
  dns_service_ip                 = var.dns_service_ip
  docker_bridge_cidr             = var.docker_bridge_cidr
  system_pool_node_count         = var.system_pool_node_count
  system_pool_max_pods           = var.system_pool_max_pods
  system_pool_vm_size            = var.system_pool_vm_size
  system_pool_availability_zones = var.system_pool_availability_zones
  user_pool_vm_size              = var.user_pool_vm_size
  user_pool_max_count            = var.user_pool_max_count
  user_pool_min_count            = var.user_pool_min_count
  user_pool_availability_zones   = var.user_pool_availability_zones
  log_sku                        = var.log_sku
  log_retention                  = var.log_retention
  tags                           = local.tags
}
```
<!-- END_TF_DOCS -->
