#!/bin/bash
set -e -x
pvcreate /dev/sdb
vgcreate vg_root /dev/sdb
lvcreate -n lv_root -l +100%FREE /dev/vg_root  # временный раздел
mkfs.xfs /dev/vg_root/lv_root
mount /dev/vg_root/lv_root /mnt
xfsdump -J - /dev/VolGroup00/LogVol00 | xfsrestore -J - /mnt # перенос данных
ls /mnt
for i in /proc/ /sys/ /dev/ /run/ /boot/; do mount --bind $i /mnt$i; done
chroot /mnt/ ./vagrant/set-boot-temp-root.sh
sed -i -e 's/rd.lvm.lv=VolGroup00\/LogVol00/rd.lvm.lv=vg_root\/lv_root/g' /boot/grub2/grub.cfg # загружаться с временного раздела
