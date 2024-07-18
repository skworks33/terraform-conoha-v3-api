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

variable "private_image_name" {
  description = "The name of the private image to be used for the additional volume."
  default     = "your-private-additional-volume-image-name"
}

variable "additional_volume_name" {
  description = "The name of the additional volume to be created."
  default     = "your-terraform-additional-volume-name"
}

variable "additional_volume_type_name" {
  description = "The name of the additional volume type to be used for the instance. Documented at https://doc.conoha.jp/api-vps3/volume-get_types_list-v3/"
  default     = "c3j1-ds02-add"
}