#!/bin/bash
# mdadm demo scirpt
# imitate failed disk, remove and add disk again.
set -e -x

mdadm /dev/md0 --fail /dev/sde
cat /proc/mdstat
mdadm -D /dev/md0
mdadm /dev/md0 --remove /dev/sde

mdadm /dev/md0 --add /dev/sde
cat /proc/mdstat
mdadm -D /dev/md0
