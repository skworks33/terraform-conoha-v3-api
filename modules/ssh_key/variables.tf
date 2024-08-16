variable "ssh_keypair_name" {
  description = "The name of the SSH key pair"
  type        = string
}

variable "ssh_keypair_public_key" {
  description = "The public key to associate with the key pair"
  type        = string
}
