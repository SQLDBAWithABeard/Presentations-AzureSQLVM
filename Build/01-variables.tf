variable "presentation" {
    description = "The name of the presentation - used for tagging Azure resources so I know what they belong to"
    default = "__Presentation__"
}

variable "ResourceGroupName" {
  description = "The Prefix used for all resources in this example"
  default     = "__ResourceGroupName__"
}

variable "location" {
  description = "The Azure Region in which the resources in this example should exist"
  default     = "__location__"
}

variable "VNetName" {
  description = "The name of the Virtual Network"
  default     = "__VNetName__"
}

variable "SubNetName" {
  description = "The name of the subnet to put the VM on"
  default     = "__SubNetName__"
}

variable "VMName" {
  description = "The name of the VM"
  default     = "__VMName__"
}
variable "VMSize" {
  description = "The size of the VM such as Standard_DS1_v2"
  default     = "__VMSize__"
}
variable "VMLocalAdmin" {
  description = "Local Admin User"
  default     = "__VMLocalAdmin__"
}
variable "VMLocalAdminPassword" {
  description = "Local Admin User Password"
  default     = "__VMLocalAdminPassword__"
}

variable "VMPublisher" {
  description = "The publisher for the VM - Use Get-AzVMImagePublisher  "
  default     = "__VMPublisher__"
}
variable "VMOffer" {
  description = "The Offer for the VM - Use Get-AzVMImageOffer "
  default     = "__VMOffer__"
}
variable "VMSku" {
  description = "The Sku for the VM - Use Get-AzVMImageSku "
  default     = "__VMSku__"
}
variable "VMVersion" {
  description = "The Version for the VM - Use latest or Get-AzVMImage "
  default     = "__VMVersion__"
}

