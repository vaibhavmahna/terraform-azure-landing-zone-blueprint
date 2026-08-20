variable "location" {
  type        = string
  description = "Azure Region for infrastructure deployment"
  default     = "eastus"
}

variable "environment" {
  type        = string
  description = "Deployment Environment (dev, staging, prod)"
  default     = "prod"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the Resource Group"
  default     = "rg-landingzone-prod"
}

variable "vnet_cidr" {
  type        = string
  description = "CIDR block for Virtual Network"
  default     = "10.0.0.0/16"
}
