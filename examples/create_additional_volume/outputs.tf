output "additional_volume_id" {
  description = "The ID of the additional volume."
  value = openstack_blockstorage_volume_v3.additional_volume.id
}

output "additional_volume_name" {
  description = "The name of the additional volume."
  value = openstack_blockstorage_volume_v3.additional_volume.name
}