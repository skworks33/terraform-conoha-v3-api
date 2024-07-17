variable "conoha_v3_auth_url" {
  description = "The authentication URL for ConoHa VPS V3."
  default     = "https://identity.c3j1.conoha.io/v3"
}

variable "conoha_v3_tenant_name" {
  description = "The tenant name (project name) for ConoHa VPS V3."
}

variable "conoha_v3_user_name" {
  description = "The user name for ConoHa VPS V3."
}

variable "conoha_v3_password" {
  description = "The password for ConoHa VPS V3."
}

variable "ssh_keypair_name" {
  description = "The name of the SSH key pair to be used for the instance."
  default     = "your-terraform-keypair-name"
}

variable "ssh_keypair_public_key" {
  description = "The public key of the SSH key pair to be used for the instance."
}

variable "default_security_group" {
  description = "The name of the default security group to be used for the instance."
  default     = "default"
}

variable "flavor_name" {
  description = "The name of the flavor to be used for the instance."
  default     = "g2l-t-c2m1" # 2vCPU, 1GB RAM, 100GB Disk
}

variable "image_name" {
  description = "The name of the image to be used for the instance."
  default     = "vmi-ubuntu-22.04-amd64"
}

variable "boot_volume_type_name" {
  description = "The name of the boot volume type to be used for the instance. Documented at https://doc.conoha.jp/api-vps3/volume-get_types_list-v3/"
  default     = "c3j1-ds02-boot"
}

variable "instance_name" {
  description = "The name of the instance to be created."
  default = "your-terraform-instance-name"
}

variable "instance_root_password" {
  description = "The root password of the instance to be created."
}

variable "boot_volume_name" {
  description = "The name of the existing boot volume to be used for the instance."
}