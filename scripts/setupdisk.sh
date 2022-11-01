#!/bin/bash

LFS_DISK=$1

sudo fdisk "$LFS_DISK" << EOF
o
n
p
1

+100M
a
n
p
2


p
w
q
EOF

sudo mkfs -v -t ext2 ${LFS_DISK}1
sudo mkfs -v -t ext4 ${LFS_DISK}2
