#!/bin/bash
# mdadm demo scirpt
# create RAID5 and write mdadm config
set -e -x

mdadm --zero-superblock --force /dev/sd{b,c,d,e,f}

mdadm --create --verbose /dev/md0 -l 5 -n 5 /dev/sd{b,c,d,e,f}
cat /proc/mdstat
mdadm -D /dev/md0
mdadm --detail --scan --verbose

mkdir /etc/mdadm
echo "DEVICE partitions" > /etc/mdadm/mdadm.conf
mdadm --detail --scan --verbose | awk '/ARRAY/ {print}' >> /etc/mdadm/mdadm.conf
