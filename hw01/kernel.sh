#!/bin/bash
SRC_PATH=/usr/src
KERNEL_VERSION=4.18.15
yum update -y
yum install ncurses-devel make gcc bc openssl-devel bison flex  elfutils-libelf-devel -y
cd ${SRC_PATH}
curl https://cdn.kernel.org/pub/linux/kernel/v${KERNEL_VERSION%.*.*}.x/linux-${KERNEL_VERSION}.tar.xz | unxz | tar x
ln -s linux-${KERNEL_VERSION}/ linux
cd linux
cp /boot/config-$(uname -r) .config
yes "" | make oldconfig
make -j$(nproc) modules
make -j$(nproc) 
make -j$(nproc) install
make -j$(nproc) modules_install
