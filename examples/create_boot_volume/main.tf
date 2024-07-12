
terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "~> 2.0.0"
    }
  }
}

provider "openstack" {
  domain_name = "gnc" # ConoHa VPS は gnc 固定
  auth_url    = var.conoha_v3_auth_url
  tenant_name = var.conoha_v3_tenant_name
  user_name   = var.conoha_v3_user_name
  password    = var.conoha_v3_password
}

# イメージID取得
data "openstack_images_image_v2" "image" {
  name        = var.image_name
  most_recent = true
}

# ブートボリューム作成
# https://doc.conoha.jp/api-vps3/volume-create_vol-v3
# https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/blockstorage_volume_v3
resource "openstack_blockstorage_volume_v3" "boot_volume" {
  name = var.boot_volume_name
  size = 100 # 1GBプラン以上は100GB, 512MBプランは30GB固定
  image_id = data.openstack_images_image_v2.image.id
  volume_type = var.boot_volume_type_name
}
