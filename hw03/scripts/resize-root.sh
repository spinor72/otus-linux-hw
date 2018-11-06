#!/bin/bash
set -e -x
lsblk
lvremove -y /dev/VolGroup00/LogVol00
lvcreate -y  -n VolGroup00/LogVol00 -L 8G /dev/VolGroup00
mkfs.xfs /dev/VolGroup00/LogVol00
mount /dev/VolGroup00/LogVol00 /mnt
xfsdump -J - /dev/vg_root/lv_root | xfsrestore -J - /mnt
ls /mnt
for i in /proc/ /sys/ /dev/ /run/ /boot/; do mount --bind $i /mnt$i; done
chroot /mnt/ ./vagrant/restore-boot-original.sh
