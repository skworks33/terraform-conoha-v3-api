#cloud-config
merge_how:
  - name: list
    settings: [append]
  - name: dict
    settings: [no_replace, recurse_list]
runcmd:
  - |
    hostnamectl set-hostname ${hostname} --static
    hostnamectl set-hostname ${hostname} --transient