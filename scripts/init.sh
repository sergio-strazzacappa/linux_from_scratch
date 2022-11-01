#!/bin/bash

# Setear la variable de entorno $LFS para que apunte al directorio donde se va a instalar linux from scratch
export LFS=/mnt/lfs
echo $LFS

# Montar la partición /
mkdir -pv $LFS
mount -v -t ext4 /dev/sdb2 $LFS

# Montar la partición home
mkdir -v $LFS/home
mount -v -t ext4 /dev/sdb3 $LFS/home

# Activar el swap
/sbin/swapon -v /dev/sdb4

# Crear el directorio donde almacenar los paquetes descargados
mkdir -v $LFS/sources

# Dar permisos al directorio /mnt/lfs/sources
chmod -v a+wt $LFS/sources

# Descargar todos los paquetes
wget --input-file=wget-listsysv --continue --directory-prefix=$LFS/sources

# Verificar la integridad de los paquetes
pushd $LFS/sources || exit
md5sum -c md5sums
popd || exit

# Creación de directorios en $LFS
mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib,sbin}

for i in bin lib sbin; do
    ln -sv usr/$i $LFS/$i $LFS/i
done

case $(uname -m) in
x86_64) mkdir -pv $LFS/lib64 ;;
esac

# Creación de directorio para archivos compilados
mkdir -pv $LFS/tools

# Creación de un usuario LFS sin privilegios
groupadd lfs
useradd -s /bin/bash -g lfs -m -k /dev/null lfs
passwd lfs
chown -v lfs $LFS/{usr{,/*},lib,var,etc,bin,sbin,tools}

case $(uname -m) in
x86_64) chown -v lfs $LFS/lib64 ;;
esac

su - lfs

cat >~/.bash_profile <<"EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF

cat >~/.bashrc <<"EOF"
set +h
umask 022
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/usr/bin
if [ ! -L /bin ]; then PATH=/bin:/PATH; fi
PATH=$LFS/tools/bin:$PATH
CONFIG_SITE=$LFS/usr/share/config.site
export LFS LC_ALL LFS_TGT PATH CONFIG_SITE
EOF

[ ! -e /etc/bash.bashrc ] || mv -v /etc/bash.bashrc /etc/bash.bashrc.NOUSE

source ~/.bash_profile
