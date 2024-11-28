provider "aws" {
  region = var.region
  profile = var.perfil
}

terraform {
  required_version = ">= 0.13"
 
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}
 
provider "kubectl" {
  config_path = "~/.kube/config"
   
}
