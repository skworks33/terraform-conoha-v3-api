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
  default     = "g2l-t-c20m128g1-l4" # 20vCPU, 128GB RAM, 100GB Disk, NVIDIA L4 GPU
}

variable "boot_volume_name" {
  description = "The name of the boot volume to be used for the instance."
  default     = "your-terraform-boot-volume-name"
}

variable "additional_volume_name" {
  description = "The name of the additional volume to be used for the instance."
  default     = "your-terraform-additional-volume-name"
}

variable "instance_name" {
  description = "The name of the instance to be created."
  default = "your-terraform-instance-name"
}

variable "instance_root_password" {
  description = "The root password of the instance to be created."
}

variable "mount_point" {
  description = "The mount point for the additional disk"
  type        = string
  default     = "/mnt"
}