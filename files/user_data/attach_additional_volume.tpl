#cloud-config
merge_how:
  - name: list
    settings: [append]
  - name: dict
    settings: [no_replace, recurse_list]
mounts:
  - ["/dev/vdb", "${mount_point}", "ext4", "defaults", 0, 0]
runcmd:
  - mkfs.ext4 /dev/vdb
  - mount /dev/vdb ${mount_point}