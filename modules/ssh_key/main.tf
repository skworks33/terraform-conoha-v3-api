terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "~> 2.0.0"
    }
  }
}

# SSHキーペア作成
resource "openstack_compute_keypair_v2" "keypair" {
  name       = var.ssh_keypair_name
  public_key = var.ssh_keypair_public_key
}