
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

# イメージID取得 (保存イメージからボリュームを作成する場合に利用)
# data "openstack_images_image_v2" "image" {
#   name        = var.private_image_name
#   most_recent = true
# }

# 追加用ボリューム(追加ディスク)作成
# https://doc.conoha.jp/api-vps3/volume-create_vol-v3
# https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/blockstorage_volume_v3
resource "openstack_blockstorage_volume_v3" "additional_volume" {
  name = var.additional_volume_name
  size = 200 # 200, 500, 1000, 5000, 10000 から選択
  # image_id = data.openstack_images_image_v2.image.id # 保存イメージからボリュームを作成する場合に指定
  volume_type = var.additional_volume_type_name
}
