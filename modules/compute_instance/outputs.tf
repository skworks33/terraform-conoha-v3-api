output "instance_id" {
  value       = openstack_compute_instance_v2.instance.id
}

output "instance_ip" {
  value       = openstack_compute_instance_v2.instance.access_ip_v4
}
