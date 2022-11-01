#! /bin/bash

LFS=/mnt/lfs
LFS_DISK=/dev/sda

sudo umount -v "${LFS_DISK}"2
sudo rm -rvf $LFS

sudo fdisk "$LFS_DISK" << EOF
o
p
w
q
EOF