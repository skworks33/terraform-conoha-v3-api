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

# SSHキーペアのモジュール
module "ssh_key" {
  source = "../../modules/ssh_key"
  ssh_keypair_name       = var.ssh_keypair_name
  ssh_keypair_public_key = var.ssh_keypair_public_key
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

# ブートボリュームのモジュール
module "boot_volume" {
  source           = "../../modules/boot_volume"
  boot_volume_name = var.boot_volume_name
  size             = 100 # 1GBプラン以上は100GB, 512MBプランは30GB固定
  image_id         = data.openstack_images_image_v2.image.id
  volume_type      = var.boot_volume_type_name
}

# セキュリティグループのモジュール
# tcp 80番ポートのingressを許可するセキュリティグループを作成する例
module "secgroup" {
  source = "../../modules/security_group"
  secgroup_name        = "test-secgroup"
  secgroup_description = "Test security group"
  rules = [
    {
      direction      = "ingress"
      ethertype      = "IPv4"
      protocol       = "tcp"
      port_range_min = 80
      port_range_max = 80
    }
  ]
}

# ユーザーデータ取得
data "template_file" "user_data" {
  template = file("${path.module}/../../files/user_data/set_hostname.tpl")
  vars = {
    hostname = var.instance_name
  }
}

# インスタンス作成のモジュール
module "compute_instance" {
  source = "../../modules/compute_instance"
  instance_name   = var.instance_name
  flavor_id       = data.openstack_compute_flavor_v2.flavor.id
  key_pair        = module.ssh_key.keypair_name
  security_groups = [
    var.default_security_group, # 既存のセキュリティグループを参照する例 (ConoHa側で用意されているセキュリティグループを利用する場合など)
    module.secgroup.secgroup_name # 本スクリプトで作成したセキュリティグループを参照する例
  ]
  admin_pass = var.instance_root_password
  metadata = {
    instance_name_tag = var.instance_name # コントロールパネルで表示されるインスタンス名
  }
  user_data = data.template_file.user_data.rendered
  volume_id = module.boot_volume.volume_id
}
