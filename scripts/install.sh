#!/bin/bash

export LFS=/mnt/lfs
export LFS_DISK=/dev/sda

if ! grep -q "$LFS" /proc/mounts; then
	source ./setupdisk.sh "$LFS_DISK"
	sudo mkdir -pv $LFS
	sudo mount -v -t ext4 "${LFS_DISK}2" "$LFS"
fi

sudo mkdir -pv $LFS/sources
sudo mkdir -pv $LFS/tools
sudo mkdir -pv $LFS/etc
sudo mkdir -pv $LFS/var
sudo mkdir -pv $LFS/usr/bin
sudo mkdir -pv $LFS/usr/lib
sudo mkdir -pv $LFS/usr/sbin

for i in bin lib sbin; do
	ln -sv usr/$i $LFS/$i
done

case $(uname -m) in
x86_64) mkdir -pv $LFS/lib64 ;;
esac

sudo chmod -v a+wt $LFS/sources

cp -v ./* $LFS/sources
cd $LFS/sources || exit
source ./download.sh
