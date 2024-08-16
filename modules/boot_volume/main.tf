terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "~> 2.0.0"
    }
  }
}

# ブートボリューム作成
# https://doc.conoha.jp/api-vps3/volume-create_vol-v3
# https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/blockstorage_volume_v3
resource "openstack_blockstorage_volume_v3" "volume" {
  name        = var.boot_volume_name
  size        = var.size
  image_id    = var.image_id
  volume_type = var.volume_type
}
