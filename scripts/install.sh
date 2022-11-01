#!/bin/bash

export LFS=/mnt/lfs
export LFS_DISK=/dev/sda

#sleep 1
#chmod +x requisitos.sh
#./requisitos.sh
	
if ! grep -q "$LFS" /proc/mounts; then
	source setupdisk.sh "$LFS_DISK"
	sudo mkdir -pv $LFS
	sudo mount -v -t ext4 "${LFS_DISK}2" "$LFS"
fi

sudo mkdir -v $LFS/sources
#sudo chmod -v a+wt $LFS/sources
