variable "instance_name" {
  description = "Name of the instance"
  type        = string
}

variable "flavor_id" {
  description = "The ID of the flavor to use for the instance"
  type        = string
}

variable "key_pair" {
  description = "The name of the SSH key pair"
  type        = string
}

variable "security_groups" {
  description = "List of security groups to assign to the instance"
  type        = list(string)
}

variable "admin_pass" {
  description = "Password for the instance"
  type        = string
}

variable "metadata" {
  description = "Metadata key-value pairs"
  type        = map(string)
}

variable "user_data" {
  description = "User data script to run on instance initialization"
  type        = string
}

variable "volume_id" {
  description = "The ID of the boot volume"
  type        = string
}
