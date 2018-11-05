#!/bin/bash
set -e -x
# LVM utils
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
# LVM Resizing
set +e
dd if=/dev/zero of=/data/test.log bs=1M count=8000 status=progress
set -e
df -Th /data/
lvextend -l+80%FREE /dev/otus/test
lvs /dev/otus/test
df -Th /data
resize2fs /dev/otus/test
df -Th /data
umount /dev/otus/test
# e2fsck -f  /dev/otus/test
# resize2fs /dev/otus/test 10G
# e2fsck -f /dev/otus/test
lvreduce -r /dev/otus/test -L 10G
mount /dev/otus/test /data/
df -Th /data/
# LVM Snapshots
lvcreate -L 500M -s -n test-snap /dev/otus/test
vgs -o +lv_size,lv_name | grep test
vgs -o +lv_size,lv_name 
lsblk
mkdir /data-snap
mount /dev/otus/test-snap /data-snap/
ll /data-snap/
umount /dev/otus/test-snap
ll /data
rm  /data/test.log
ll /data
umount /data
lvconvert --merge /dev/otus/test-snap
mount /dev/otus/test /data
ll /data
# LVM Mirroring
pvcreate /dev/sd{d,e}
vgcreate vg0 /dev/sd{d,e}
lvcreate -l+80%FREE -m1 -n mirror vg0
lvs
