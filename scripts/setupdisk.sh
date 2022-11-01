#!/bin/bash

LFS_DISK=$1

sudo fdisk "$LFS_DISK" << EOF
o 		# Make partition table
n		# Create new partition for boot
p		# Primary partition
1		# Partition number 1
		# Initial sector as default
+100M	# Partition's size
a		# Make partition booteable
n		# Make new partition for /
p		# Primary partition
2		# Partition number 2
		# Initial sector as default
		# Last sector as default, meaning the size is the rest of the disk
p		# Print partition table
w		# Write changes to disk
q		# Quit fdisk
EOF
