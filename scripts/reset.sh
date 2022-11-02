#! /bin/bash

LFS=/mnt/lfs
LFS_DISK=/dev/sda

sudo rm -rvf $LFS
sudo umount -v "${LFS_DISK}"2

sudo fdisk "$LFS_DISK" << EOF
d
1
d
o
p
w
q
EOF
