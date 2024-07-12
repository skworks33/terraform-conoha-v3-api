output "instance_id" {
  description = "The ID of the created instance."
  value       = openstack_compute_instance_v2.instance.id
}

output "instance_ip" {
  description = "The IP address of the created instance."
  value       = openstack_compute_instance_v2.instance.access_ip_v4
}
