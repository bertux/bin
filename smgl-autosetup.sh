#!/bin/bash
echo Commands will be done unattended by this install script
echo ________________Disk-partition step________________
dd if=/dev/zero of=/dev/hda bs=512 count=2
sync
fdisk /dev/hda <<EOF
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
mkfs.ext3 /dev/hda1
mkswap /dev/hda2
mkfs.ext3 /dev/hda3

echo disk-mount step
mount /dev/hda3 /mnt/root
mkdir /mnt/root/boot
mount /dev/hda1 /mnt/root/boot
swapon /dev/hda2

echo copy-base step
tar -xjf /system.tar.bz2 -C /mnt/root

echo edit-confs step
cat > /mnt/root/etc/fstab <<EOF
proc /proc proc defaults 0 0
devpts /dev/pts devpts defaults 0 0
sysfs /sys sysfs defaults 0 0

/dev/hda3 / ext3 defaults 0 1
/dev/hda1 /boot ext3 defaults 0 2
/dev/hda2 swap swap defaults 0 0
EOF
cat > /mnt/root/etc/network/interfaces <<EOF
auto lo
iface lo inet loopback
auto eth0
iface eth0 inet dhcp
EOF
sed -i -e 's/KEYMAP=.*$/KEYMAP=fr-latin1/' /mnt/root/etc/sysconfig/keymap
sed -i -e 's/PCMCIA=.*$/PCMCIA=no/' /mnt/root/etc/sysconfig/pcmcia

echo boot-loader step
cat > /mnt/root/boot/grub/menu.lst <<EOF
timeout 5
default 0
fallback 1

title Source Mage Linux
kernel (hd0,0)/vmlinuz root=/dev/hda3 ro

title Source Mage Linux Fallback
kernel (hd0,0)/vmlinuz.safe root=/dev/hda3 ro
EOF
ln -sf /proc/mounts /mnt/root/etc/mtab
smgl-chroot /sbin/grub-install --no-floppy /dev/hda
rm -f /mnt/root/etc/mtab

echo user-setup step
cat > /mnt/root/etc/securetty <<EOF
/dev/tty1
/dev/tty2
/dev/tty3
/dev/tty4
/dev/tty5
/dev/tty6
EOF
sed -i -e 's/root:x:/root::/' /mnt/root/etc/passwd

echo shut-down step
umount /mnt/root/boot
umount /mnt/root
swapoff /dev/hda2
shutdown -h now "install finished"
exit 0
