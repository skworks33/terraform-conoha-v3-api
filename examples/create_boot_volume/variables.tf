variable "conoha_v3_auth_url" {
  description = "The authentication URL for ConoHa."
}

variable "conoha_v3_tenant_name" {
  description = "The tenant name for ConoHa."
}

variable "conoha_v3_user_name" {
  description = "The user name for ConoHa."
}

variable "conoha_v3_password" {
  description = "The password for ConoHa."
}

variable "image_name" {
  description = "The name of the image to be used for the instance."
  default     = "vmi-ubuntu-22.04-amd64"
}

variable "boot_volume_name" {
  description = "The name of the boot volume to be used for the instance."
  default     = "your-terraform-boot-volume-name"
}

variable "boot_volume_type_name" {
  description = "The name of the boot volume type to be used for the instance. Documented at https://doc.conoha.jp/api-vps3/volume-get_types_list-v3/"
  default     = "c3j1-ds02-boot"
}