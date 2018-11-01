#!/bin/bash
set -x
lsblk
lvmdiskscan
pvcreate /dev/sdb
vgcreate otus /dev/sdb
lvcreate -l+80%FREE -n test otus
vgdisplay otus
vgdisplay -v otus | grep 'PV Name'
vgdisplay -v otus 
vgdisplay -v otus | grep 'PV Name'
lvdisplay /dev/otus/test
pvdisplay 
vgs
lvs
lvcreate -L100M -n small otus
lvs
mkfs.ext4 /dev/otus/test
mkdir /data
mount /dev/otus/test /data/
mount | grep /data
pvcreate /dev/sdc
vgextend otus /dev/sdc
vgdisplay -v otus | grep 'PV Name'
vgs
dd if=/dev/zero of=/data/test.log bs=1M count=8000 status=progress
df -Th /data/
lvextend -l+80%FREE /dev/otus/test
lvs /dev/otus/test
df -Th /data
resize2fs /dev/otus/test
df -Th /data
umount /dev/otus/test
resize2fs /dev/otus/test 9.9G
lvreduce /dev/otus/test -L 10G
mount /dev/otus/test /data/
df -Th /data/
lvcreate -L 500M -s -n test-snap /dev/otus/test
vgs -o +lv_size,lv_name | grep test
vgs -o +lv_size,lv_name 
lsblk
mkdir /data-snap
mount /dev/otus/test-snap /data-snap/
