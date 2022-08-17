variable "rg_spoke_name" {
  description = "Name of the resource group of Spoke"
  type        = string
}

variable "location" {
  description = "Azure location where the resources are deployed to"
  type        = string
  default     = "westeurope"
}

variable "product" {
  description = "Name of the product"
  type        = string

  validation {
    condition     = length(var.product) < 15
    error_message = "Project name value must not be longer than 15 characters."
  }
}

variable "environment" {
  description = "Name of the environment"
  type        = string

  validation {
    condition     = length(var.environment) < 15
    error_message = "Environment name value must not be longer than 15 characters."
  }
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "snet_address_prefixes" {
  description = "Address prefixes to use for the subnet"
  type        = list(string)
}

variable "route_table_name" {
  description = "Name of the Route Table"
  type        = string
}

variable "global_acr_id" {
  description = "ID of the existing centralised acr"
  type = string
  default = null
}

variable "kubernetes_version" {
  description = "Version of Kubernetes specified when creating the AKS managed cluster"
  type        = string
  default     = null
}

variable "sku_tier" {
  description = "SKU Tier that should be used for this Kubernetes Cluster"
  type        = string
  default     = "Free"
}

variable "service_cidr" {
  description = "Network Range used by the Kubernetes service"
  type        = string
  default     = "192.168.0.0/16"
}

variable "dns_service_ip" {
  description = "IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns)"
  type        = string
  default     = "192.168.0.100"
}

variable "docker_bridge_cidr" {
  description = "IP address (in CIDR notation) used as the Docker bridge IP address on nodes"
  type        = string
  default     = "172.17.0.1/16"
}

variable "system_pool_node_count" {
  description = "Initial number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000 and between min_count and max_count"
  type        = number
}

variable "system_pool_max_pods" {
  description = "Maximum number of pods that can run on each agent"
  type        = number
  default     = 110
}

variable "system_pool_vm_size" {
  description = "Size of the Virtual Machine (e.g: Standard_DS2_v2)"
  type        = string
}

variable "system_pool_availability_zones" {
  description = "List of Availability Zones across which the Node Pool should be spread"
  type        = list(string)
  default     = ["1", "2", "3"]
}

variable "user_pool_vm_size" {
  description = "Size of the Virtual Machine (e.g: Standard_DS2_v2)"
  type        = string
}

variable "user_pool_max_count" {
  description = "Maximum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000"
  type        = number
}

variable "user_pool_min_count" {
  description = "Minimum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000"
  type        = number
}

variable "user_pool_availability_zones" {
  description = "List of Availability Zones across which the Node Pool should be spread"
  type        = list(string)
  default     = ["1", "2", "3"]
}

variable "log_sku" {
  description = "Specifies the SKU of the Log Analytics Workspace"
  type        = string
  default     = "PerGB2018"
}

variable "log_retention" {
  description = "Workspace data retention in days. Possible values are either 7 (Free Tier only) or range between 30 and 730"
  type        = number
}

variable "tags" {
  description = "This Object is used to store information about the running deployment. Resources will be tagged with it"
  type        = map(string)
  default     = {}
}
