variable "environment" {
  default     = "dev"
  type        = string
  description = "Environment"
}


variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-terraform"
}

variable "resource_group_location" {
  description = "Location of the resource group"
  type        = string
  default     = "westus2"
}

variable "team" {
  type        = string
  description = "Team name"
  default     = "support"
}

variable "vnet_name" {
  description = "The name of the Virtual Network"
  type        = string
  default     = "vnet-terraform"
}

variable "address_space" {
  description = "The address space for the Virtual Network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "other_vnet_name" {
  description = "The name of the Virtual Network"
  type        = string
  default     = "vnet-terraform-2"
}

variable "other_address_space" {
  description = "The address space for the Virtual Network"
  type        = list(string)
  default     = ["10.1.0.0/16"]
}
