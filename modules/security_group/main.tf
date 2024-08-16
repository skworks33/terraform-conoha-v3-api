terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "~> 2.0.0"
    }
  }
}

# セキュリティグループ作成
# https://doc.conoha.jp/api-vps3/network-create_secgps-v3/
# https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/networking_secgroup_v2
resource "openstack_networking_secgroup_v2" "secgroup" {
  name        = var.secgroup_name
  description = var.secgroup_description
}

# セキュリティグループルール作成
# https://doc.conoha.jp/api-vps3/network-create_secgprule-v3/
# https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/networking_secgroup_rule_v2
resource "openstack_networking_secgroup_rule_v2" "secgroup_rule" {
  count            = length(var.rules)
  direction        = var.rules[count.index].direction
  ethertype        = var.rules[count.index].ethertype
  protocol         = var.rules[count.index].protocol
  port_range_min   = var.rules[count.index].port_range_min
  port_range_max   = var.rules[count.index].port_range_max
  security_group_id = openstack_networking_secgroup_v2.secgroup.id
}