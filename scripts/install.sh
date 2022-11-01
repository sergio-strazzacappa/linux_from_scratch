#!/bin/bash

export LFS=/mnt/lfs
export LFS_DISK=/dev/sda

#sleep 1
#chmod +x requisitos.sh
#./requisitos.sh
	
if ! grep -q "$LFS" /proc/mounts; then
	source setupdisk.sh "$LFS_DISK"
fi
