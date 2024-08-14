output "gpu_server_01_id" {
  description = "The ID of the created instance."
  value       = openstack_compute_instance_v2.gpu_server_01.id
}

output "gpu_server_01_access_ip_v4" {
  description = "The IP address of the created instance."
  value       = openstack_compute_instance_v2.gpu_server_01.access_ip_v4
}
