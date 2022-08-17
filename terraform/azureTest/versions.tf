terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
    
    oebbnc = {
      source = "terraform.oebb.cloud/bcc/oebbnc"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

