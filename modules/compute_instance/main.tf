terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "~> 2.0.0"
    }
  }
}

# インスタンス作成
# https://doc.conoha.jp/api-vps3/compute-create_vm-v3/
# https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/compute_instance_v2
resource "openstack_compute_instance_v2" "instance" {
  name            = var.instance_name
  flavor_id       = var.flavor_id
  key_pair        = var.key_pair
  security_groups = var.security_groups
  admin_pass      = var.admin_pass
  metadata        = var.metadata
  user_data       = var.user_data

  block_device {
    uuid             = var.volume_id
    source_type      = "volume"
    destination_type = "volume"
    # boot_index は ConoHa 側で自動設定される
  }
}
