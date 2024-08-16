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

variable "instance_id" {
  description = "The ID of the existing instance to which the network will be attached."
}

variable "subnet_cidr" {
  description = "The CIDR block for the subnet to be created."
  default     = "10.0.0.0/24"
}
