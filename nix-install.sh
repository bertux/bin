#!/bin/bash
loadkeys fr
echo Commands will be done unattended by this install script
echo  ________________Disk-partition step________________
#dd if=/dev/zero of=/dev/vda bs=512 count=2
sync
fdisk /dev/vda <<EOF
n
p
1

+64M
n
p
2

+512M
n
p
3


a
1
t
2
82
w
EOF
sync

echo ________________Disk-format step________________
mkfs.ext3 /dev/vda1
mkswap /dev/vda2
mkfs.ext3 -L nix /dev/vda3


