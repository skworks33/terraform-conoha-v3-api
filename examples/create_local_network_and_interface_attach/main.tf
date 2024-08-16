terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "~> 2.0.0"
    }
  }
}

provider "openstack" {
  domain_name = "gnc" # ConoHa VPS の場合は gnc 固定
  auth_url    = var.conoha_v3_auth_url
  tenant_name = var.conoha_v3_tenant_name
  user_name   = var.conoha_v3_user_name
  password    = var.conoha_v3_password
}

# ローカルネットワーク作成
# https://doc.conoha.jp/api-vps3/network-add_nw_vlan-v3/
resource "openstack_networking_network_v2" "local_network" {}

# ローカルサブネット作成
# https://doc.conoha.jp/api-vps3/network-add_subnet_vlan-v3/
resource "openstack_networking_subnet_v2" "local_subnet" {
  network_id = openstack_networking_network_v2.local_network.id
  cidr       = var.subnet_cidr
  depends_on = [
    openstack_networking_network_v2.local_network
  ]
}

# ポート作成
# https://doc.conoha.jp/api-vps3/network-add_port_vlan-v3/
resource "openstack_networking_port_v2" "local_port" {
  network_id  = openstack_networking_network_v2.local_network.id
  depends_on  = [
    openstack_networking_subnet_v2.local_subnet
  ]
}

# 既存サーバにネットワークインターフェイスを接続
# https://doc.conoha.jp/api-vps3/compute-attach_port-v3/
resource "openstack_compute_interface_attach_v2" "interface_attach" {
  instance_id = var.instance_id
  port_id     = openstack_networking_port_v2.local_port.id
  depends_on  = [
    openstack_networking_port_v2.local_port
  ]
}


