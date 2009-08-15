#!/bin/bash
if [[ $# -lt 2 ]] ;then
	echo usage: $0 src destination
	echo WARNING: /mnt/iso will be used to mount the iso as loop
	exit -1
fi
modprobe loop
mkdir -p /mnt/iso
mount -o loop $1 /mnt/iso
mkdir -p $2
cp -a /mnt/iso/. $2
umount /mnt/iso
exit 0
