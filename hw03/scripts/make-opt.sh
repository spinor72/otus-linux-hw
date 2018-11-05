#!/bin/bash
set -e -x
# Создать раздел для opt на ZFS c RAID  и проверить работу снапшотов
yum install http://download.zfsonlinux.org/epel/zfs-release.el7_5.noarch.rpm
yum install "kernel-devel-$(uname -r)" zfs
dkms status
dkms install -j(nproc) spl/0.7.11
dkms install -j(nproc) zfs/0.7.11
dkms status
modprobe zfs

lvremove -y /dev/vg_root/lv_root
vgrename vg_root vg_zfs

lvcreate -y -n lv_zfs1 -l +30%VG /dev/vg_zfs
lvcreate -y -n lv_zfs2 -l +30%VG /dev/vg_zfs
lvcreate -y -n lv_zfs3 -l +30%VG /dev/vg_zfs
lvcreate -y -n lv_zfscache -l +100%FREE /dev/vg_zfs

lsblk

zpool create -o ashift=12 -m /mnt optpool raidz1 /dev/vg_zfs/lv_zfs1 /dev/vg_zfs/lv_zfs2  /dev/vg_zfs/lv_zfs3    cache /dev/vg_zfs/lv_zfscache 
zpool list
zpool status
df -h
touch /opt/file1
cp -aR /opt/* /mnt/
rm -rf /opt/*
zfs set mountpoint=/opt optpool
zfs snapshot optpool@snap
touch /opt/file2
ll /opt
zfs rollback optpool@snap
ll /opt
