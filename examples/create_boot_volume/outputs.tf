output "boot_volume_id" {
  description = "The ID of the boot volume."
  value = openstack_blockstorage_volume_v3.boot_volume.id
}

output "boot_volume_name" {
  description = "The name of the boot volume."
  value = openstack_blockstorage_volume_v3.boot_volume.name
}