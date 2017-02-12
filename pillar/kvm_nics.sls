virt.nic:
  default:
    eth0:
      bridge: br0
      model: virtio
  dual:
    eth0:
      bridge: br0
    eth1:
      bridge: virbr1
  triple:
    eth0:
      bridge: br0
    eth1:
      bridge: virbr1
    eth2:
      bridge: virbr2
