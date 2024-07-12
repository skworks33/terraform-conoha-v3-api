
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

# SSHキーペア作成
resource "openstack_compute_keypair_v2" "keypair" {
  name = var.ssh_keypair_name
  public_key = var.ssh_keypair_public_key
}

# フレーバー取得
data "openstack_compute_flavor_v2" "flavor" {
  name = var.flavor_name
}

# イメージID取得
data "openstack_images_image_v2" "image" {
  name        = var.image_name
  most_recent = true
}

# 既存のブートボリュームを取得
# 注意: ConoHaでは同一名で複数のボリュームを作成できますが terraform-provider-openstack では名前で一意に特定するため、同一名のボリュームが複数ある場合はエラーになります
data "openstack_blockstorage_volume_v3" "existing_boot_volume" {
  name = var.boot_volume_name
}

# ユーザーデータ取得
data "template_file" "user_data" {
  template = file("${path.module}/../../files/user_data.tpl")
  vars = {
    hostname = var.instance_name
  }
}

# インスタンス作成
# https://doc.conoha.jp/api-vps3/compute-create_vm-v3/
# https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/compute_instance_v2
resource "openstack_compute_instance_v2" "instance" {
  name = var.instance_name
  flavor_id = data.openstack_compute_flavor_v2.flavor.id
  key_pair = openstack_compute_keypair_v2.keypair.name
  security_groups = [
    var.default_security_group
  ]
  admin_pass = var.instance_root_password # 未指定時はランダムパスワードが設定される
  metadata = {
    instance_name_tag = var.instance_name # コントロールパネルで表示されるインスタンス名
  }
  user_data = data.template_file.user_data.rendered

  block_device {
    uuid = data.openstack_blockstorage_volume_v3.existing_boot_volume.id
    source_type = "volume"
    destination_type = "volume"
    # boot_index は ConoHa 側で自動設定される
  }

  depends_on = [
    openstack_compute_keypair_v2.keypair
  ]
}
