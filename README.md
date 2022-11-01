# Linux from scratch

## Indice

1. [Particionado de disco](#particionado_de_disco)
	1. [Tablas de particiones](#tablas_de_particiones)
2. [Variable de entorno $LFS](#variable_de_entorno)
3. [Montar las particiones y activar swap](#montar_las_particiones_y_activar_el_swap)
4. [Paquetes y parches](#paquetes_y_parches) 
	1. [Descargar todos los paquetes](#descargar_todos_los_paquetes)
	2. [Lista de paquetes a la fecha 23/09/2022](#lista_de_paquetes)
	3. [Lista de parches a la fecha 23/09/2022](#lista_de_parches)
5. [Últimos detalles](#ultimos_detalles)
	1. [Creación de directorios dentro de $LFS](#creacion_de_directorios)
		1. [Estructura de directorios creados](#estructura_de_directorios_creados)_
	2. [Directorio para los archivos compilados](#directorio_para_los_archivos_compilados)
	3. [Usuario LFS](#usuario)
	4. [Seteando el ambiente de trabajo](#seteando_el_ambiente_de_trabajo)
6. [Compilando el cross-toolchain](#compilando_el_cross_toolchain)
	1. [Binutils-2.39 - Pass 1](#binutils_2.39_pass_1)
	2. [GCC-12.2.0 - Pass 1](#gcc_12_2_0_pass_1)
	3. [Linux-5.19-11 API Headers](#linux_5_19_11_api_headers)
	4. [Glibc-2.36](#glibc_2_36)
	5. [Libstdc++](#libstdc++)
7. [Compilando herramientas temporales](#compilando_herramientas_temporales)
	1. [M4-1.4.19](#m4_1_4_19)
	2. [Ncurses-6.3](#ncurses_6_3)
	3. [Bash-5.1.16](#bash_5_1_16) 
	4. [Coreutils-9.1](#coreutils_9_1)
	5. [Diffutils-3.8](#diffutils_3_8)
	6. [File-5.42](#file_5_42)
	7. [Findutils-4.9.0](#findutils_4_9_0)
	8. [Gawk-5.1.1](#gawk_5_1_1)
	9. [Grep-3.7](#grep_3_7)
	10. [Gzip-1.12](#gzip_1_12)
	11. [Make-4.3](#make_4_3)
	12. [Patch-2.7.6](#patch_2_7_6)
	13. [Sed-4.8](#sed_4_8)
	14. [Tar-1.34](#tar_1_34)
	15. [Xz-5.2.6](#xz_5_2_6)
	16. [Binutils-2.39 Pass 2](#binutils_2_39_pass_2)
	17. [GCC-12.2.0 Pass 2](#gcc_12_2_0_pass_2)

## Particionado de disco <a name=particionado_de_disco></a>

-   Se necesita como mínimo 10 GB de espacio para almacenar todos los paquetes y compilarlos, pero si se quieren instalar mas programas se necesita al menos 30 GB de espacio libre.

### Tabla de particiones <a name=tablas_de_particiones></a>

| Dispositivo | Inicio | Comienzo   | Final      | Sectores   | Tamaño | Id  | Tipo                 |
| ----------- | ------ | ---------- | ---------- | ---------- | ------ | --- | -------------------- |
| /dev/sdb1   |        | 2.048      | 1.026.047  | 1.024.000  | 500M   | ef  | EFI (FAT-12/16/32)   |
| /dev/sdb2   |        | 1.026.048  | 21.997.567 | 20.971.520 | 10G    | 83  | Linux                |
| /dev/sdb3   |        | 21.997.568 | 56.600.575 | 34.603.008 | 16,5G  | 83  | Linux                |
| /dev/sdb4   |        | 56.600.576 | 62.914.559 | 6.313.984  | 3G     | 82  | Linux swap / Solaris |

## Variable de entorno *$LFS* <a name=variable_de_entorno></a>

```bash
$ export LFS=/mnt/lfs
```

## Montar las particiones y activar el swap <a name=montar_las_particiones_y_activar_el_swap></a>

```bash
$ mkdir -pv $LFS
$ mount -v -t ext4 /dev/sdb2 $LFS

$ mkdir -v $LFS/home
$ mount -v -t ext4 /dev/sdb3 $LFS/home

$ /sbin/swapon -v /dev/sdb4
```

## Paquetes y parches <a name=paquetes_y_parches></a>

```bash
$ mkdir -v $LFS/sources
$ chmod -v a+wt $LFS/sources
```

### Descargar todos los paquetes <a name=descargar_todos_los_paquetes></a>

En el fichero *listsysv* se encuentran todos los paquetes y en el fichero *md5sums* se encuentra la comprobación para cada paquete. En un futuro verificar la versión de los paquetes.

### Lista de paquetes a la fecha 23/09/2022 <a name=lista_de_paquetes></a>

-	**Acl (2.3.1)** - 348 KB </br>
	[Homepage](https://savannah.nongnu.org/projects/acl) </br>
    [Download](https://download.savannah.gnu.org/releases/acl/acl-2.3.1.tar.xz) </br>
    **MD5 sum:** 95ce715fe09acca7c12d3306d0f076b2

-	**Attr (2.5.1)** - 456 KB </br>
    [Homepage](https://savannah.nongnu.org/projects/attr) </br>
    [Download](https://download.savannah.gnu.org/releases/attr/attr-2.5.1.tar.gz) </br>
    **MD5 sum:** ac1c5a7a084f0f83b8cace34211f64d8

-	**Autoconf (2.71)** - 1,263 KB </br>
    [Homepage](https://www.gnu.org/software/autoconf/) </br>
    [Download](https://ftp.gnu.org/gnu/autoconf/autoconf-2.71.tar.xz) </br>
    **MD5 sum:** 12cfa1687ffa2606337efe1a64416106

-	**Automake (1.16.5)** - 1,565 KB </br>
    [Homepage](https://www.gnu.org/software/automake/) </br>
	[Download](https://ftp.gnu.org/gnu/automake/automake-1.16.5.tar.xz) </br>
    **MD5 sum:** 4017e96f89fca45ca946f1c5db6be714 </br>
    **SHA256 sum:** 80facc09885a57e6d49d06972c0ae1089c5fa8f4d4c7cfe5baea58e5085f136d

-	**Bash (5.1.16)** - 10,277 KB </br>
    [Homepage](https://www.gnu.org/software/bash/) </br>
    [Download](https://ftp.gnu.org/gnu/bash/bash-5.1.16.tar.gz) </br>
    **MD5 sum:** c17b20a09fc38d67fb303aeb6c130b4e

-	**Bc (6.0.1)** - 441 KB </br>
    [Homepage](https://git.yzena.com/gavin/bc) </br>
    [Download](https://github.com/gavinhoward/bc/releases/download/6.0.1/bc-6.0.1.tar.xz) </br>
    **MD5 sum:** 4c8b8d51eb52ee66f5bcf6a6a1ca576e

-	**Binutils (2.39)** - 24,578 KB </br>
    [Homepage](https://www.gnu.org/software/binutils/) </br>
    [Download](https://ftp.gnu.org/gnu/binutils/binutils-2.39.tar.xz) </br>
	**MD5 sum:** f7e986ae9ff06405cafb2e585ee36d27

-	**Bison (3.8.2)** - 2,752 KB </br>
    [Homepage](https://www.gnu.org/software/bison/) </br>
    [Download](https://ftp.gnu.org/gnu/bison/bison-3.8.2.tar.xz) </br>
    **MD5 sum:** c28f119f405a2304ff0a7ccdcc629713

-	**Bzip2 (1.0.8)** - 792 KB </br>
    [Download](https://www.sourceware.org/pub/bzip2/bzip2-1.0.8.tar.gz) </br>
    **MD5 sum:** 67e051268d0c475ea773822f7500d0e5

-	**Check (0.15.2)** - 760 KB </br>
    [Homepage](https://libcheck.github.io/check) </br>
    [Download](https://github.com/libcheck/check/releases/download/0.15.2/check-0.15.2.tar.gz) </br>
    **MD5 sum:** 50fcafcecde5a380415b12e9c574e0b2

-	**Coreutils (9.1)** - 5,570 KB </br>
    [Homepage](https://www.gnu.org/software/coreutils/) </br>
    [Download](https://ftp.gnu.org/gnu/coreutils/coreutils-9.1.tar.xz) </br>
    **MD5 sum:** 8b1ca4e018a7dce9bb937faec6618671

-	**DejaGNU (1.6.3)** - 608 KB </br>
    [Homepage](https://www.gnu.org/software/dejagnu/) </br>
    [Download](https://ftp.gnu.org/gnu/dejagnu/dejagnu-1.6.3.tar.gz) </br>
    **MD5 sum:** 68c5208c58236eba447d7d6d1326b821

-	**Diffutils (3.8)** - 1,548 KB </br>
    [Homepage](https://www.gnu.org/software/diffutils/) </br>
    [Download](https://ftp.gnu.org/gnu/diffutils/diffutils-3.8.tar.xz) </br>
    **MD5 sum:** 6a6b0fdc72acfe3f2829aab477876fbc

-	**E2fsprogs (1.46.5)** - 9,307 KB </br>
    [Homepage](http://e2fsprogs.sourceforge.net/) </br>
    [Download](https://downloads.sourceforge.net/project/e2fsprogs/e2fsprogs/v1.46.5/e2fsprogs-1.46.5.tar.gz) </br>
    **MD5 sum:** 3da91854c960ad8a819b48b2a404eb43

-	**Elfutils (0.187)** - 9,024 KB </br>
    [Homepage](https://sourceware.org/elfutils/) </br>
    [Download](https://sourceware.org/ftp/elfutils/0.187/elfutils-0.187.tar.bz2) </br>
    **MD5 sum:** cc04f07b53a71616b22553c0a458cf4b

-	**Eudev (3.2.11)** - 2,075 KB </br>
    [Download](https://github.com/eudev-project/eudev/releases/download/v3.2.11/eudev-3.2.11.tar.gz) </br>
    **MD5 sum:** 417ba948335736d4d81874fba47a30f7

-	**Expat (2.4.8)** - 444 KB </br>
    [Homepage](https://libexpat.github.io/) </br>
    [Download](https://prdownloads.sourceforge.net/expat/expat-2.4.8.tar.xz) </br>
    **MD5 sum:** 0584a7318a4c007f7ec94778799d72fe </br>
    La versión 2.4.8 tiene un problema de seguridad, por lo tanto descargué la 2.4.9.

-	**Expect (5.45.4)** - 618 KB </br>
    [Homepage](https://core.tcl.tk/expect/) </br>
    [Download](https://prdownloads.sourceforge.net/expect/expect5.45.4.tar.gz) </br>
    **MD5 sum:** 00fce8de158422f5ccd2666512329bd2

-	**File (5.42)** - 1,080 KB </br>
    [Homepage](https://www.darwinsys.com/file/) </br>
    [Download](https://astron.com/pub/file/file-5.42.tar.gz) </br>
    **MD5 sum:** 4d4f70c3b08a8a70d8baf67f085d7e92

-	**Findutils (4.9.0)** - 1,999 KB </br>
    [Homepage](https://www.gnu.org/software/findutils/) </br>
    [Download](https://ftp.gnu.org/gnu/findutils/findutils-4.9.0.tar.xz) </br>
    **MD5 sum:** 4a4a547e888a944b2f3af31d789a1137

-	**Flex (2.6.4)** - 1,386 KB </br>
    [Homepage](https://github.com/westes/flex) </br>
    [Download](https://github.com/westes/flex/releases/download/v2.6.4/flex-2.6.4.tar.gz) </br>
    **MD5 sum:** 2882e3179748cc9f9c23ec593d6adc8d

-	**Gawk (5.1.1)** - 3,075 KB </br>
    [Homepage](https://www.gnu.org/software/gawk/) </br>
    [Download](https://ftp.gnu.org/gnu/gawk/gawk-5.1.1.tar.xz) </br>
    **MD5 sum:** 83650aa943ff2fd519b2abedf8506ace

-	**GCC (12.2.0)** - 82,662 KB </br>
    [Homepage](https://gcc.gnu.org/) </br>
    [Download](https://ftp.gnu.org/gnu/gcc/gcc-12.2.0/gcc-12.2.0.tar.xz) </br>
    **MD5 sum:** 73bafd0af874439dcdb9fc063b6fb069

-	**GDBM (1.23)** - 1,092 KB </br>
    [Homepage](https://www.gnu.org/software/gdbm/) </br>
    [Download](https://ftp.gnu.org/gnu/gdbm/gdbm-1.23.tar.gz) </br>
    **MD5 sum:** 8551961e36bf8c70b7500d255d3658ec

-	**Gettext (0.21)** - 9,487 KB </br>
    [Homepage](https://www.gnu.org/software/gettext/) </br>
    [Download](https://ftp.gnu.org/gnu/gettext/gettext-0.21.tar.xz) </br>
    **MD5 sum:** 40996bbaf7d1356d3c22e33a8b255b31

-	**Glibc (2.36)** - 18,175 KB </br>
    [Homepage](https://www.gnu.org/software/libc/) </br>
    [Download](https://ftp.gnu.org/gnu/glibc/glibc-2.36.tar.xz) </br>
    **MD5 sum:** 00e9b89e043340f688bc93ec03239b57

-	**GMP (6.2.1)** - 1,980 KB </br>
    [Homepage](https://www.gnu.org/software/gmp/) </br>
    [Download](https://ftp.gnu.org/gnu/gmp/gmp-6.2.1.tar.xz) </br>
    **MD5 sum:** 0b82665c4a92fd2ade7440c13fcaa42b

-	**Gperf (3.1)** - 1,188 KB </br>
    [Homepage](https://www.gnu.org/software/gperf/) </br>
    [Download]( https://ftp.gnu.org/gnu/gperf/gperf-3.1.tar.gz) </br>
	**MD5 sum:** 9e251c0a618ad0824b51117d5d9db87e

-	**Grep (3.7)** - 1,603 KB </br>
    [Homepage](https://www.gnu.org/software/grep/) </br>
    [Download](https://ftp.gnu.org/gnu/grep/grep-3.7.tar.xz) </br>
    **MD5 sum:** 7c9cca97fa18670a21e72638c3e1dabf

-	**Groff (1.22.4)** - 4,044 KB </br>
    [Homepage](https://www.gnu.org/software/groff/) </br>
    [Download](https://ftp.gnu.org/gnu/groff/groff-1.22.4.tar.gz) </br>
    **MD5 sum:** 08fb04335e2f5e73f23ea4c3adbf0c5f

-	**GRUB (2.06)** - 6,428 KB </br>
    [Homepage](https://www.gnu.org/software/grub/) </br>
    [Download](https://ftp.gnu.org/gnu/grub/grub-2.06.tar.xz) </br>
    **MD5 sum:** cf0fd928b1e5479c8108ee52cb114363

-	**Gzip (1.12)** - 807 KB </br>
    [Homepage](https://www.gnu.org/software/gzip/) </br>
    [Download](https://ftp.gnu.org/gnu/gzip/gzip-1.12.tar.xz) </br>
    **MD5 sum:** 9608e4ac5f061b2a6479dc44e917a5db

-	**Iana-Etc (20220812)** - 584 KB </br>
	[Homepage](https://www.iana.org/protocols) </br>
    [Download](https://github.com/Mic92/iana-etc/releases/download/20220812/iana-etc-20220812.tar.gz) </br>
    **MD5 sum:** 851a53efd53c77d0ad7b3d2b68d8a3fc

-	**Inetutils (2.3)** - 1,518 KB </br>
    [Homepage](https://www.gnu.org/software/inetutils/) </br>
    [Download](https://ftp.gnu.org/gnu/inetutils/inetutils-2.3.tar.xz) </br>
    **MD5 sum:** e73e2ed42d73ceb47616b20131236036

-	**Intltool (0.51.0)** - 159 KB </br>
    [Homepage](https://freedesktop.org/wiki/Software/intltool) </br>
    [Download](https://launchpad.net/intltool/trunk/0.51.0/+download/intltool-0.51.0.tar.gz) </br>
    **MD5 sum:** 12e517cac2b57a0121cda351570f1e63

-	**IPRoute2 (5.19.0)** - 872 KB </br>
    [Homepage](https://www.kernel.org/pub/linux/utils/net/iproute2/) </br>
    [Download](https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-5.19.0.tar.xz) </br>
    **MD5 sum:** 415bd9eeb8515a585e245809d2fe45a6

-	**Kbd (2.5.1)** - 1,457 KB </br>
    [Homepage](https://kbd-project.org/) </br>
    [Download](https://www.kernel.org/pub/linux/utils/kbd/kbd-2.5.1.tar.xz) </br>
    **MD5 sum:** 10f10c0a9d897807733f2e2419814abb

-	**Kmod (30)** - 555 KB </br>
    [Download](https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-30.tar.xz) </br>
    **MD5 sum:** 85202f0740a75eb52f2163c776f9b564

-	**Less (590)** - 348 KB </br>
    [Homepage](https://www.greenwoodsoftware.com/less/) </br>
    [Download](https://www.greenwoodsoftware.com/less/less-590.tar.gz) </br>
    **MD5 sum** f029087448357812fba450091a1172ab

-	**LFS-Bootscripts (20220723)** - 33 KB </br>
    [Download](https://www.linuxfromscratch.org/lfs/downloads/11.2/lfs-bootscripts-20220723.tar.xz) </br>
    **MD5 sum:** 74884d0d91616f843599c99a333666da

-	**Libcap (2.65)** - 176 KB </br>
    [Homepage](https://sites.google.com/site/fullycapable/) </br>
    [Download](https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-2.65.tar.xz) </br>
    **MD5 sum:** 3543e753dd941255c4def6cc67a462bb

-	**Libffi (3.4.2)** - 1,320 KB </br>
    [Homepage](https://sourceware.org/libffi/) </br>
    [Download](https://github.com/libffi/libffi/releases/download/v3.4.2/libffi-3.4.2.tar.gz) </br>
    **MD5 sum:** 294b921e6cf9ab0fbaea4b639f8fdbe8

-	**Libpipeline (1.5.6)** - 954 KB </br>
    [Homepage](http://libpipeline.nongnu.org/) </br>
    [Download](https://download.savannah.gnu.org/releases/libpipeline/libpipeline-1.5.6.tar.gz) </br>
    **MD5 sum:** 829c9ba46382b0b3e12dd11fcbc1bb27

-	**Libtool (2.4.7)** - 996 KB </br>
    [Homepage](https://www.gnu.org/software/libtool/) </br>
    [Download](https://ftp.gnu.org/gnu/libtool/libtool-2.4.7.tar.xz) </br>
    **MD5 sum:** 2fc0b6ddcd66a89ed6e45db28fa44232

-	**Linux (5.19.2)** - 128,553 KB </br>
    [Homepage](https://www.kernel.org/) </br>
    [Download](https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.19.2.tar.xz) </br>
    **MD5 sum:** 391274e2e49a881403b0ff2e0712bf82 </br>
    Se descarga la ultima versión estable hasta la fecha: 5.19.11

-	**M4 (1.4.19)** - 1,617 KB </br>
    [Homepage](https://www.gnu.org/software/m4/) </br>
    [Download]( https://ftp.gnu.org/gnu/m4/m4-1.4.19.tar.xz) </br>
    **MD5 sum:** 0d90823e1426f1da2fd872df0311298d

-	**Make (4.3)** - 2,263 KB </br>
    [Homepage](https://www.gnu.org/software/make/) </br>
    [Download](https://ftp.gnu.org/gnu/make/make-4.3.tar.gz) </br>
    **MD5 sum:** fc7a67ea86ace13195b0bce683fd4469

-	**Man-DB (2.10.2)** - 1,860 KB </br>
    [Homepage](https://www.nongnu.org/man-db/) </br>
    [Download](https://download.savannah.gnu.org/releases/man-db/man-db-2.10.2.tar.xz) </br>
    **MD5 sum:** e327f7af3786d15e5851658ae7ef47ed

-	**Man-pages (5.13)** - 1,752 KB </br>
    [Homepage](https://www.kernel.org/doc/man-pages/) </br>
    [Download](https://www.kernel.org/pub/linux/docs/man-pages/man-pages-5.13.tar.xz) </br>
    **MD5 sum:** 3ac24e8c6fae26b801cb87ceb63c0a30

-	**Meson (0.63.1)** - 2,016 KB </br>
    [Homepage](https://mesonbuild.com) </br>
    [Download](https://github.com/mesonbuild/meson/releases/download/0.63.1/meson-0.63.1.tar.gz) </br>
    **MD5 sum:** 078e59d11a72b74c3bd78cb8205e9ed7

-	**MPC (1.2.1)** - 820 KB </br>
    [Homepage](http://www.multiprecision.org/) </br>
    [Download](https://ftp.gnu.org/gnu/mpc/mpc-1.2.1.tar.gz) </br>
    **MD5 sum:** 9f16c976c25bb0f76b50be749cd7a3a8

-	**MPFR (4.1.0)** - 1,490 KB </br>
    [Homepage](https://www.mpfr.org/) </br>
    [Download](https://ftp.gnu.org/gnu/mpfr/mpfr-4.1.0.tar.xz) </br>
    **MD5 sum:** bdd3d5efba9c17da8d83a35ec552baef

-	**Ncurses (6.3)** - 3,500 KB </br>
    [Homepage](https://www.gnu.org/software/ncurses/) </br>
    [Download](https://invisible-mirror.net/archives/ncurses/ncurses-6.3.tar.gz) </br>
    **MD5 sum:** a2736befde5fee7d2b7eb45eb281cdbe

-	**Ninja (1.11.0)** - 228 KB </br>
    [Homepage](https://ninja-build.org/) </br>
    [Download](https://github.com/ninja-build/ninja/archive/v1.11.0/ninja-1.11.0.tar.gz) </br>
    **MD5 sum:** 7d1a1a2f5cdc06795b3054df5c17d5ef

-	**OpenSSL (3.0.5)** - 14,722 KB </br>
    [Homepage](https://www.openssl.org/) </br>
    [Download](https://www.openssl.org/source/openssl-3.0.5.tar.gz) </br>
    **MD5 sum:** 163bb3e58c143793d1dc6a6ec7d185d5

-	**Patch (2.7.6)** - 766 KB </br>
    [Homepage](https://savannah.gnu.org/projects/patch/) </br>
    [Download](https://ftp.gnu.org/gnu/patch/patch-2.7.6.tar.xz) </br>
    **MD5 sum:** 78ad9937e4caadcba1526ef1853730d5

-	**Perl (5.36.0)** - 12,746 KB </br>
    [Homepage](https://www.perl.org/) </br>
    [Download](https://www.cpan.org/src/5.0/perl-5.36.0.tar.xz) </br>
    **MD5 sum:** 826e42da130011699172fd655e49cfa2

-	**Pkg-config (0.29.2)** - 1,970 KB </br>
    [Homepage](https://www.freedesktop.org/wiki/Software/pkg-config) </br>
    [Download](https://pkg-config.freedesktop.org/releases/pkg-config-0.29.2.tar.gz) </br>
    **MD5 sum:** f6e931e319531b736fadc017f470e68a

-	**Procps (4.0.0)** - 979 KB </br>
    [Homepage](https://sourceforge.net/projects/procps-ng) </br>
    [Download](https://sourceforge.net/projects/procps-ng/files/Production/procps-ng-4.0.0.tar.xz) </br>
    **MD5 sum:** eedf93f2f6083afb7abf72188018e1e5

-	**Psmisc (23.5)** - 395 KB </br>
    [Homepage](https://gitlab.com/psmisc/psmisc) </br>
    [Download](https://sourceforge.net/projects/psmisc/files/psmisc/psmisc-23.5.tar.xz) </br>
    **MD5 sum:** 014f0b5d5ab32478a2c57812ad01e1fb

-	**Python (3.10.6)** - 19,142 KB </br>
    [Homepage](https://www.python.org/) </br>
    [Download](https://www.python.org/ftp/python/3.10.6/Python-3.10.6.tar.xz) </br>
    **MD5 sum:** afc7e14f7118d10d1ba95ae8e2134bf0 </br>
    La versión 3.10.6 tiene un problema de seguridad, por lo tanto descargué la 3.10.7 con su documentación correspondiente.

-	**Python Documentation (3.10.6)** - 7,321 KB </br>
    [Download](https://www.python.org/ftp/python/doc/3.10.6/python-3.10.6-docs-html.tar.bz2) </br>
    **MD5 sum:** 8f32c4f4f0b18ec56e8b3822bbaeb017

-	**Readline (8.1.2)** - 2,923 KB </br>
    [Homepage](https://tiswww.case.edu/php/chet/readline/rltop.html) </br>
    [Download](https://ftp.gnu.org/gnu/readline/readline-8.1.2.tar.gz) </br>
    **MD5 sum:** 12819fa739a78a6172400f399ab34f81

-	**Sed (4.8) - 1,317 KB** </br>
    [Homepage](https://www.gnu.org/software/sed/) </br>
    [Download](https://ftp.gnu.org/gnu/sed/sed-4.8.tar.xz) </br>
    **MD5 sum:** 6d906edfdb3202304059233f51f9a71d

-	**Shadow (4.12.2)** - 1,706 KB </br>
    [Homepage](https://shadow-maint.github.io/shadow/) </br>
    [Download](https://github.com/shadow-maint/shadow/releases/download/4.12.2/shadow-4.12.2.tar.xz) </br>
    **MD5 sum:** 52637cb34c357acf85c617cf95da34a6

-	**Sysklogd (1.5.1)** - 88 KB </br>
    [Homepage](https://www.infodrom.org/projects/sysklogd/) </br>
    [Download](https://www.infodrom.org/projects/sysklogd/download/sysklogd-1.5.1.tar.gz) </br>
    **MD5 sum:** c70599ab0d037fde724f7210c2c8d7f8

-	**Sysvinit (3.04)** - 216 KB </br>
    [Homepage](https://savannah.nongnu.org/projects/sysvinit) </br>
    [Download](https://download.savannah.gnu.org/releases/sysvinit/sysvinit-3.04.tar.xz) </br>
    **MD5 sum:** 9a00e5f15dd2f038f10feee50677ebff

-	**Tar (1.34)** - 2,174 KB </br>
    [Homepage](https://www.gnu.org/software/tar/) </br>
    [Download](https://ftp.gnu.org/gnu/tar/tar-1.34.tar.xz) </br>
    **MD5 sum:** 9a08d29a9ac4727130b5708347c0f5cf

-	**Tcl (8.6.12)** - 10,112 KB </br>
    [Homepage](http://tcl.sourceforge.net/) </br>
    [Download](https://downloads.sourceforge.net/tcl/tcl8.6.12-src.tar.gz) </br>
    **MD5 sum:** 87ea890821d2221f2ab5157bc5eb885f

-	**Tcl Documentation (8.6.12)** - 1,176 KB </br>
    [Download](https://downloads.sourceforge.net/tcl/tcl8.6.12-html.tar.gz) </br>
    **MD5 sum:** a0d1a5b60bbb68f2f0bd3066a19c527a

-	**Texinfo (6.8)** - 4,848 KB </br>
    [Homepage](https://www.gnu.org/software/texinfo/) </br>
    [Download](https://ftp.gnu.org/gnu/texinfo/texinfo-6.8.tar.xz) </br>
    **MD5 sum:** a91b404e30561a5df803e6eb3a53be71

-	**Time Zone Data (2022c)** - 423 KB </br>
    [Homepage](https://www.iana.org/time-zones) </br>
    [Download](https://www.iana.org/time-zones/repository/releases/tzdata2022c.tar.gz) </br>
    **MD5 sum:** 4e3b2369b68e713ba5d3f7456f20bfdb

-	**Udev-lfs Tarball (udev-lfs-20171102)** - 11 KB </br>
    [Download](https://anduin.linuxfromscratch.org/LFS/udev-lfs-20171102.tar.xz) </br>
    **MD5 sum:** 27cd82f9a61422e186b9d6759ddf1634

-	**Util-linux (2.38.1)** - 7,321 KB </br>
    [Homepage](https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/) </br>
    [Download](https://www.kernel.org/pub/linux/utils/util-linux/v2.38/util-linux-2.38.1.tar.xz) </br>
    **MD5 sum:** cd11456f4ddd31f7fbfdd9488c0c0d02

-	**Vim (9.0.0228)** - 16,372 KB </br>
    [Homepage](https://www.vim.org) </br>
    [Download](https://anduin.linuxfromscratch.org/LFS/vim-9.0.0228.tar.gz) </br>
    **MD5 sum:** bc7e0a4829d94bb4c03a7a6b4ad6a8cf </br>
    Se ha actualizado Vim a la versión 9.0.0565

-	**Wheel (0.37.1)** - 65 KB </br>
    [Homepage](https://pypi.org/project/wheel/) </br>
    [Download](https://anduin.linuxfromscratch.org/LFS/wheel-0.37.1.tar.gz) </br>
    **MD5 sum:** f490f1399e5903706cb1d4fbed9ecb28

-	**XML::Parser (2.46)** - 249 KB </br>
    [Homepage](https://github.com/chorny/XML-Parser) </br>
    [Download](https://cpan.metacpan.org/authors/id/T/TO/TODDR/XML-Parser-2.46.tar.gz) </br>
    **MD5 sum:** 80bb18a8e6240fcf7ec2f7b57601c170

-	**Xz Utils (5.2.6)** - 1,234 KB </br>
    [Homepage](https://tukaani.org/xz) </br>
    [Download](https://tukaani.org/xz/xz-5.2.6.tar.xz) </br>
    **MD5 sum:** d9cd5698e1ec06cf638c0d2d645e8175

-	**Zlib (1.2.12)** - 1259 KB </br>
    [Homepage](https://www.zlib.net/) </br>
    [Download](https://zlib.net/zlib-1.2.12.tar.xz) </br>
    **MD5 sum:** 28687d676c04e7103bb6ff2b9694c471

-	**Zstd (1.5.2)** - 1,892 KB </br>
    [Homepage](https://facebook.github.io/zstd/) </br>
    [Download](https://github.com/facebook/zstd/releases/download/v1.5.2/zstd-1.5.2.tar.gz) </br>
    **MD5 sum:** 072b10f71f5820c24761a65f31f43e73 </br>

**Total size of these packages: about 461 MB**

### Lista de parches a la fecha 23/09/2022 <a name=lista_de_parches></a>

-	**Bzip2 Documentation Patch** - 1.6 KB </br>
    [Download](https://www.linuxfromscratch.org/patches/lfs/11.2/bzip2-1.0.8-install_docs-1.patch) </br>
    **MD5 sum:** 6a5ac7e89b791aae556de0f745916f7f

-	**Coreutils Internationalization Fixes Patch** - 166 KB </br>
    [Download](https://www.linuxfromscratch.org/patches/lfs/11.2/coreutils-9.1-i18n-1.patch) </br>
    **MD5 sum:** c1ac7edf095027460716577633da9fc5

-	**Glibc FHS Patch - 2.8 KB** </br>
    [Download](https://www.linuxfromscratch.org/patches/lfs/11.2/glibc-2.36-fhs-1.patch) </br>
    **MD5 sum:** 9a5997c3452909b1769918c759eff8a2

-	**Kbd Backspace/Delete Fix Patch** - 12 KB </br>
    [Download](https://www.linuxfromscratch.org/patches/lfs/11.2/kbd-2.5.1-backspace-1.patch) </br>
    **MD5 sum:** f75cca16a38da6caa7d52151f7136895

-	**Sysvinit Consolidated Patch** - 2.4 KB </br>
    [Download](https://www.linuxfromscratch.org/patches/lfs/11.2/sysvinit-3.04-consolidated-1.patch) </br>
    **MD5 sum:** 4900322141d493e74020c9cf437b2cdc

-	**Zstd Upstream Fixes Patch** - 4 KB </br>
    [Download](https://www.linuxfromscratch.org/patches/lfs/11.2/zstd-1.5.2-upstream_fixes-1.patch) \
    **MD5 sum:** a7e576e3f87415fdf388392b257cdcf3 </br>

**Total size of these patches: about 188.8 KB**

---

```bash
$ wget --input-file=wget-listsysv --continue --directory-prefix=$LFS/sources

$ pushd $LFS/sources
$ md5sum -c md5sums
$ <F12>popd
```

---

## Últimos detalles <a name=ultimos_detalles></a>

### Creación de directorios dentro de $LFS <a name=creacion_de_directorios></a>

```bash
$ mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib,sbin}

$ for i in bin lib sbin; do
$ 	ln -sv usr/$i $LFS/$i
$ done

$ case $(uname -m) in
$ 	x86_64) mkdir -pv $LFS/lib64 ;;
$ esac
```

#### Estructura de directorios creados <a name=estructura_de_directorios_creados></a>

-	/
	-	bin -> usr/bin
	-	etc
	-	home
	-	lib -> usr/lib
	-	lib64
	-	sbin -> usr/sbin
	-	usr
		-	bin
		-	lib
		-	sbin
	-	var

### Directorio para los archivos compilados <a name=directorio_para_los_archivos_compilados></a>

```bash
$ mkdir -pv $LFS/tools
```

### Usuario LFS <a name=usuario></a>

```bash
$ groupadd lfs
$ useradd -s /bin/bash -g lfs -m -k /dev/null lfs
$ passwd lfs
$ chown -v lfs $LFS/{usr{,/*},lib,var,etc,bin,sbin,tools}
$ case $(uname -m) in
$ 	x86_64) chown -v lfs $LFS/lib64 ;;
$ esac
$ su - lfs
```

### Seteando el ambiente de trabajo <a name=seteando_el_ambiente_de_trabajo></a>

```bash
$ cat > ~/.bash_profile << "EOF"
$ exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
$ EOF
$
$ cat > ~/.bashrc << "EOF"
$ set +h
$ umask 022
$ LFS=/mnt/lfs
$ LC_ALL=POSIX
$ LFS_TGT=$(uname -m)-lfs-linux-gnu
$ PATH=/usr/bin
$ if [ ! -L /bin ]; then PATH=/bin:/PATH; fi
$ PATH=$LFS/tools/bin:$PATH
$ CONFIG_SITE=$LFS/usr/share/config.site
$ export LFS LC_ALL LFS_TGT PATH CONFIG_SITE
$ EOF
$
$ [ ! -e /etc/bash.bashrc ] || mv -v /etc/bash.bashrc /etc/bash.bashrc.NOUSE
$
$ source ~/.bash_profile
```

## Compilando el cross-toolchain <a name=compilando_el_cross_toolchain></a>

### Binutils-2.39 - Pass 1 <a name=binutils_2.39_pass_1></a>

-	**Assembler y Linker:**
	-	$LFS/tools/bin
	-	$LFS/tools/$LFS_TGT/bin

**Approximate build time:** 1 SBU </br>
**Real time:** 3m5.928s </br>
**Required disk space:** 629 MB </br>

Descomprimir el paquete: <br>

```bash
$ tar -xvf $LFS/sources/binutils-2.39.tar.xz
$ cd $LFS/sources/binutils-2.39
```

Crear el directorio build: </br>

```bash
$ mkdir $LFS/sources/binutils-2.39/build
$ cd $LFS/sources/binutils-2.39/build
```

Compilar el paquete: </br>

```bash
$ time { ../configure	--prefix=$LFS/tools	\
$                      	--with-sysroot=$LFS	\
$                      	--target=$LFS_TGT	\
$                      	--disable-nls		\
$                      	--enable-gprofng=no	\
$                      	--disable-werror &&	\
$ 		make && make install }
```

Eliminar el directorio descomprimido: </br>

```bash
$ rm -rv $LFS/sources/binutils-2.39
```

### GCC-12.2.0 - Pass 1 <a name=gcc_12_2_0_pass_1></a>

**Approximate build time:** 12 SBU </br>
**Required disk space:** 1.4 GB </br>

Descomprimir los paquetes: </br>

```bash
$ tar -xvf $LFS/sources/gcc-12.2.0.tar.xz
$ cd $LFS/sources/gcc-12.2.0
$ tar -xf ../mpfr-4.1.0.tar.xz
$ tar -xf ../gmp-6.2.1.tar.xz
$ tar -xf ../mpc-1.2.1.tar.xz
$
$ mv -v mpfr-4.1.0 mpfr
$ mv -v gmp-6.2.1.tar.xz gmp
$ mv -v mpc-1.2.1.tar.xz mpc
```
En computadoras de 64 bits configurar el directorio de librerias de 64 bits como *lib*: </br>

```bash
$ case $(uname -m) in
$ 	x86_64)
$ 	sed -e '/m64=/s/lib64/lib/' \
$ 		-i.orig gcc/config/i386/t-linux64
$	;;
$ esac
```

Crear el directorio build: </br>

```bash
$ mkdir $LFS/sources/gcc-12.2.0/build
$ cd $LFS/sources/gcc-12.2.0/build
```

Compilar el paquete: </br>

```bash
$ ../configure								\
$ 				--target=$LFS_TGT			\
$ 				--prefix=$LFS/tools			\
$ 				--with-glibc-version=2.36	\
$ 				--with-sysroot=$LFS			\
$ 				--with-newlib				\
$ 				--without-headers			\
$				--disable-nls				\
$ 				--disable-shared			\
$ 				--disable-multilib			\
$ 				--disable-decimal-float		\
$ 				--disable-threats			\
$ 				--disable-libatomic			\
$ 				--disable-libgomp			\
$ 				--disable-libquadmath		\
$ 				--disable-libssp			\
$ 				--disable-libvtv			\
$ 				--disable-libstdcxx			\
$				--enable-languages=c,c++
$
$ make
$
$ make install
```

Crear los headers: </br>

```bash
$ cd ..
$ cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
$   `dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/install-tools/include/limits.h
```

Eliminar el directorio descomprimido: </br>

```bash
$ rm -rv $LFS/sources/gcc-12.2.0
```

### Linux-5.19.11 API Headers <a name=linux_5_19_11_api_headers></a>

**Approximate build time:** 0.1 SBU </br>
**Required disk space:** 1.4 GB </br>

Descomprimir el paquete: </br>

```bash
$ tar -xvf $LFS/sources/linux-5.19.11.tar.xz
$ cd $LFS/sources/linux-5.19.11
```

Sanitizar los headers: </br>

```bash
$ make mrproper
$ make headers
$ find usr/include -type f ! -name '*.h' -delete
$ cp -rv usr/include $LFS/usr
```

Eliminar el directorio descomprimido: </br>

```bash
$ rm -rv $LFS/sources/linux-5.19.11
```

### Glibc 2.36 <a name=glibc_2_36></a>

**Approximate build time:** 4.4 SBU </br>
**Required disk space:** 821 MB </br>

Descomprimir el paquete: </br>

```bash
$ tar -xvf $LFS/sources/glibc-2.36.tar.xz
$ cd $LFS/sources/glibc-2.36
$
$ case $(uname -m) in
$ 	i?86)	ln -sfv ld-linux.so.2 $LFS/lib/ld-lsb.so.3
$	;;
$	x86_64)	ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64
$			ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64/ld-lsb-x86-64.so.3
$	;;
$ esac
```

Aplicamos el patch: </br>

```bash
$ patch -Np1 -i ../glibc-2.36-fhs-1.patch
```

Crear el directorio build: </br>

```bash
$ mkdir $LFS/sources/glibc-2.36/build
$ cd $LFS/sources/glibc-2.36/build
$
$ echo "rootsbindir=/usr/sbin" > configparms
```

Compilar el paquete: </br>

```bash
$ ../configure										\
$ 				--prefix=/usr						\
$ 				--host=$LFS_TGT						\
$ 				--build=$(../scripts/config.guess)	\
$ 				--enable-kernel=3.2					\
$ 				--with-headers=$LFS/usr/include		\
$ 				libc_cv_slibdir=/usr/lib
$
$ make
$ 
$ make DESTDIR==$LFS install
$
$ sed '/RTLDLIST=/s@/usr@@g' -i $LFS/usr/bin/ldd
$ 
$ LFS/tools/libexec/gcc/$LFS_TGT/12.2.0/install-tools/mkheaders
```

Eliminar el directorio descomprimido: </br>

```bash
$ rm -rv $LFS/sources/glibc-2.36
```

### Libstdc++ <a name=libstdc++></a>

**Approximate build time:** 0.4 SBU </br>
**Real time:** 0m53.912s </br>
**Required disk space:** 1.1 GB </br>

Descomprimir el paquete: </br>

```bash
$ tar -xvf $LFS/sources/gcc12.2.0.tar.xz
$ cd $LFS/sources/gcc12.2.0
```

Crear el directorio build: </br>

```bash
$ mkdir $LFS/sources/gcc-12.2.0/build
$ cd $LFS/sources/gcc-12.2.0/build
```

Compilar el paquete: </br>

```bash
$ ../libstdc++-v3/configure											\
$ 		--host=$LFS_TGT												\
$ 		--build=$(..config.guess)									\
$ 		--prefix=/usr												\
$ 		--disable-multilib											\
$ 		-disable-nls												\
$ 		--disable-libstdcxx-pch										\
$ 		--with-gxx-include-dir=/tools/$LFS_TGT/include/c++/12.2.0	\
$
$ time make
$ 
$ make DESTDIR=$LFS install
```

Eliminar los archivos *libtool* porque son peligrosos para la compilación cruzada: </br>

```bash
$ rm -v $LFS/usr/lib/lib{stdc++,stdc++fs,supc++}.la
```

Eliminar el directorio descomprimido: </br>

```bash
$ rm -rv $LFS/sources/gcc.12.2.0
```

## Compilando herramientas temporales <a name=compilando_herramientas_temporales></a>

### M4-1.4.19 <a name=m4_1_4_19></a>

**Approximate build time:** 0.2 SBU </br>
**Real time:** 0m18.235s </br>
**Required disk space:** 32 MB </br>

Descomprimir el paquete: </br>

```bash
$ tar -xvf $LFS/sources/m4-1.4.19
$ cd $LFS/sources/m4-1.4.19
```

Compilar el paquete: </br>

```bash
$ ./configure							\
$ 	--prefix=/usr						\
$ 	--host=$LFS_TGT						\
$ 	--build=$(build-aux/config.guess)	\
$
$ time make
$
$ make DESTDIR=$LFS install
```

Eliminar el directorio descomprimido: </br>

```bash
$ rm -rv $LFS/sources/m4-1.4.19
```

### Ncurses-6.3 <a name=ncurses_6_3></a>

**Approximate build time:** 0.7 SBU </br>
**Real time:** 0m48.261s </br>
**Required disk space:** 50 MB </br>

Descomprimir el paquete: </br>

```bash
$ tar -xvf $LFS/sources/ncurses-6.3
$ cd $LFS/sources/ncurses-6.3
```

Verificar que *gawk* esta instalado: </br>

```bash
$ sed -i s/mawk// configure
$
$ mkdir build
$ pushd build
$ ../configure
$ make -C include
$ make -C progs tic
$ popd
```

Compilar el paquete: </br>

```bash
$ ./configure							\
$ 		--prefix=/usr					\
$ 		--host=$LFS_TGT					\
$ 		--build=$(./config.guess)		\
$ 		--mandir=/usr/share/man			\
$ 		--with-manpage-format=normal	\
$ 		--with-shared					\
$ 		--without-normal				\
$ 		--with-cxx-shared				\
$ 		--without-debug					\
$ 		--without-ada					\
$ 		--disable-stripping				\
$ 		--enable-widec
$
$ time make
$
$ make DESTDIR=$LFS TIC_PATH=$(pwd)/build/progs/tic install
$ echo "INPUT(-lncursesw)" > $LFS/usr/lib/libcurses.so
```

Eliminar el directorio descomprimido: </br>

```bash
$ rm -rv $LFS/sources/ncurses-6.3
```

### Bash-5.1.16 <a name=bash_5_1_16></a>

**Approximate build time:** 0.5 SBU </br>
**Real time:** 0m39.372s </br>
**Required disk space:** 64 MB </br>

Descomprimir el paquete: </br>

```bash
$ tar -xvf $LFS/sources/bash-5.1.16.tar.gz
$ cd $LFS/sources/bash-5.16
```

Compilar el paquete: </br>

```bash
$ ./configure							\
$  		--prefix=/usr					\
$ 		--host=$LFS_TGT					\
$ 		--build=$(support/config.guess)	\
$ 		--without-bash-malloc
$
$ time make
$
$ make DESTDIR=$LFS install
```

Hacer un *link* para los programas que utilizan *sh*: </br>

```bash
$ ln -sv bash $LFS/bin/sh
```

Eliminar el directorio descomprimido: </br>

```bash
$ rm -rv $LFS/sources/bash-5-1-16
```

### Coreutils-9.1 <a name=coreutils_9_1></a>

**Approximate build time:** 0.6 SBU </br>
**Real time:** 1m9.184s </br>
**Required disk space:** 163 MB </br>

Descomprimir el paquete: </br>

```bash
$ tar -xvf $LFS/sources/coreutils-9.1.tar.xz
$ cd $LFS/sources/coreutils-9.1
```

Compilar el paquete: </br>

```bash
$ ./configure										\
$ 		--prefix=/usr								\
$ 		--host=$LFS_TGT								\
$ 		--build=$(build-aux/config.guess)			\
$ 		--enable-install-program=hostname			\
$ 		--enable-no-install-program=kill, uptime
$
$ time make
$
$ make DESTDIR=$LFS install
```

Mover los programas a sus ubicaciones finales: </br>

```bash
$ mv -v $LFS/usr/bin/chroot $LFS/usr/sbin
$ mkdir -pv $LFS/usr/share/man/man8
$ mv -v $LFS/usr/share/man/man1/chroot.1 $LFS/usr/share/man/man8/chroot.8
$ sed -i 's/"1"/"8"/' $LFS/usr/share/man/man8/chroot.8
```

Eliminar el directorio descomprimido: </br>

```bash
$ rm -rv $LFS/sources/coreutils-9.1
```

### Diffutils-3.8 <a name=diffutils_3_8></a>

**Approximate build time:** 0.2 SBU </br>
**Real time:** 0m12.474s </br>
**Required disk space:** 26 MB </br>

Descomprimir el paquete: </br>

```bash
$ tar -xvf $LFS/sources/diffutils-3.8.tar.xz
$ cd $LFS/sources/diffutils-3.8
```

Compilar el paquete: </br>

```bash
$ ./configure			\
$ 		--prefix=/usr	\
$ 		--host=$LFS_TGT
$ 
$ time make
$
$ make DESTDIR=$LFS install
```

Eliminar el directorio descomprimido: </br>

```bash
$ rm -rfv $LFS/sources/diffutils-3.8
```

### File-5.42 <a name=file_5_42></a>

**Approximate build time:** 0.2 SBU </br>
**Real time:** 0m6.349s - 0m6.835s </br>
**Required disk space:** 34 MB </br>

Descomprimir el paquete: </br>

```bash
$ tar -xvf $LFS/sources/file-5.42.tar.gz
$ cd $LFS/sources/file-5.42
```

Compilar el paquete: </br>

```bash
$ mkdir build
$ pushd build
$ ../configure --disable-bzlib --disable-libseccomp --disable-xzlib --disable-zlib
$ time make
$ popd
$ ./configure --prefix=/usr --host=$LFS_TGT --buid=$(./config.guess)
$ time make FILE_COMPILE=$(pwd)/build/src/file
$ make DESTDIR=$LFS install
```

Eliminar el directorio descomprimido: </br>

```bash
$ rm -v $LFS/usr/lib/libmagic.la
$ rm -rfv $LFS/sources/file-5.42
```

### Findutils-4.9.0 <a name=findutils_4_9_0></a>

**Approximate build time:** 0.2 SBU </br>
**Real time:** 0m20.037s </br>
**Required disk space:** 42 MB </br>

Descomprimir el paquete: </br>

```bash
$ tar -xvf $LFS/sources/findutils-4.9.0.tar.gz
$ cd $LFS/sources/findutils-4.9.0
```

Compilar el paquete: </br>

```bash
$ ./configure								\
$ 		--prefix=/usr						\
$ 		--localstatedir=/var/lib/locate		\
$ 		--host=$LFS_TGT						\
$ 		--build=$(build-aux/config.guess) 
$
$ time make
$
$ make DESTDIR=$LFS install
```

Eliminar el directorio descomprimido: </br>

```bash
$ rm -rfv $LFS/sources/findutils-4.9.0
```

### Gawk-5.1.1 <a name=gawk_5_1_1></a>

**Approximate build time:** 0.2 SBU </br>
**Real time:** 0m22.567s </br>
**Required disk space:** 45 MB </br>

Descomprimir el paquete: </br>

```bash
$ tar -xvf $LFS/sources/gawk-5.1.1.tar.gz
$ cd $ÑFS/sources/gawk-5.1.1
```

Asegurarse que no esten instalados paquetes innecesarios: </br>

```bash
$ sed -i 's/extras//' Makefile.in
```

Compilar el paquete: </br>

```bash
$ ./configure								\ 
$ 		--prefix=/usr						\
$ 		--host=$LFS_TGT						\
$ 		--build=$(build-aux/config.guess) 
$
$ time make
$
$ make DESTDIR=$LFS install
```

Eliminar el directorio descomprimido: </br>

```bash
$ rm -rfv $LFS/sources/gawk-5.1.1
```

### Grep-3.7 <a name=grep_3_7></a>

**Approximate build time:** 0.2 SBU </br>
**Real time:** 0m11.162s </br>
**Required disk space:** 25 MB </br>

Descomprimir el paquete: </br>

```bash
$ tar -xvf $LFS/sources/grep-3.7.tar.gz
$ cd $LFS/sources/grep-3.7
```

Compilar el paquete: </br>

```bash
$ ./configure --prefix=/usr --host=$LFS_TGT					
$ time make
$ make DESTDIR=$LFS install
```

Eliminar el directorio descomprimido: </br>

```bash
$ rm -rfv $LFS/sources/grep-3.7
```

### Gzip-1.12 <a name=gzip_1_12></a>

**Approximate build time:** 0.1 SBU </br>
**Real time:** 0m5.932s </br>
**Required disk space:** 11 MB </br>

Descomprimir el paquete: </br>

```bash
$ tar -xvf $LFS/sources/gzip-1.12.tar.gz
$ cd $LFS/sources/gzip-1.12
```

Compilar el paquete: </br>

```bash
$ ./configure --prefix=/usr --host=$LFS_TGT					
$ time make
$ make DESTDIR=$LFS install
```

Eliminar el directorio descomprimido: </br>

```bash
$ rm -rfv $LFS/sources/gzip-1.12
```
### Make-4.3 <a name=make_4_3></a>

**Approximate build time:** 0.1 SBU </br>
**Real time:** 0m7.536s </br>
**Required disk space:** 15 MB </br>

Descomprimir el paquete: </br>

```bash
$ tar -xvf $LFS/sources/make-4.3.tar.gz
$ cd $LFS/sources/make-4.3
```

Compilar el paquete: </br>

```bash
$ ./configure 								\
$ 		--prefix=/usr						\
$ 		--without-guile						\
$		--host=$LFS_TGT						\
$ 		--build=$(build-aux/config.guess)
$ time make
$ make DESTDIR=$LFS install
```

Eliminar el directorio descomprimido: </br>

```bash
$ rm -rfv $LFS/sources/make-4.3
```
### Patch-2.7.6 <a name=patch_2_7_6></a>

**Approximate build time:** 0.1 SBU </br>
**Real time:** 0m9.869s </br>
**Required disk space:** 12 MB </br>

Descomprimir el paquete: </br>

```bash
$ tar -xvf $LFS/sources/patch-2.7.6.tar.gz
$ cd $LFS/sources/patch-2.7.6
```

Compilar el paquete: </br>

```bash
$ ./configure								\
$ 		--prefix=/usr						\
$ 		--host=$LFS_TGT						\
$ 		--build=$(build-aux/config.guess)
$ time make
$ make DESTDIR=$LFS install
```

Eliminar el directorio descomprimido: </br>

```bash
$ rm -rfv $LFS/sources/patch-2.7.6
```
### Sed-4.8 <a name=sed_4_8></a>

**Approximate build time:** 0.1 SBU </br>
**Real time:** 0m10.756s </br>
**Required disk space:** 20 MB </br>

Descomprimir el paquete: </br>

```bash
$ tar -xvf $LFS/sources/sed-4.8.tar.gz
$ cd $LFS/sources/sed-4.8
```

Compilar el paquete: </br>

```bash
$ ./configure --prefix=/usr --host=$LFS_TGT					
$ time make
$ make DESTDIR=$LFS install
```

Eliminar el directorio descomprimido: </br>

```bash
$ rm -rfv $LFS/sources/sed-4.8
```

### Tar-1.34 <a name=tar_1_34></a>

**Approximate build time:** 0.2 SBU </br>
**Real time:** 0m25.176s </br>
**Required disk space:** 38 MB </br>

Descomprimir el paquete: </br>

```bash
$ tar -xvf $LFS/sources/tar-1.34.tar.gz
$ cd $LFS/sources/tar-1.34
```

Compilar el paquete: </br>

```bash
$ ./configure								\
$ 		--prefix=/usr						\
$ 		--host=$LFS_TGT						\
$ 		--build=$(build-aux/config.guess)
$ time make
$ make DESTDIR=$LFS install
```

Eliminar el directorio descomprimido: </br>

```bash
$ rm -rfv $LFS/sources/tar-1.34
```
### Xz-5.2.6 <a name=xz_5_2_6></a>

**Approximate build time:** 0.1 SBU </br>
**Real time:** 0m16.795s </br>
**Required disk space:** 16 MB </br>

Descomprimir el paquete: </br>

```bash
$ tar -xvf $LFS/sources/xz-5.2.6.tar.gz
$ cd $LFS/sources/xz-5.2.6
```

Compilar el paquete: </br>

```bash
$ ./configure								\
$ 		--prefix=/usr						\
$ 		--host=$LFS_TGT						\
$ 		--build=$(build-aux/config.guess)	\
$ 		--disable-static					\
$ 		--docdir=/usr/share/doc/xz-5.2.6
$ time make
$ make DESTDIR=$LFS install
```

Eliminar el archivo *libtool* y el directorio descomprimido: </br>

```bash
$ rm -v $LFS/usr/lib/liblzma.la
$ rm -rfv $LFS/sources/xz-5.2.6
```
### Binutils-2.39 Pass 2 <a name=binutils_2_39_pass_2></a>

**Approximate build time:** 1.4 SBU </br>
**Real time:** 3m31.728s </br>
**Required disk space:** 514 MB </br>

Descomprimir el paquete: </br>

```bash
$ tar -xvf $LFS/sources/binutils-2.39.tar.gz
$ cd $LFS/sources/binutils-2.39
```

```bash
$ sed '6009s/$add_dir//' -i ltmain.sh
```

Crear el directorio build: </br>

```bash
$ mkdir -v build
$ cd build
```

Compilar el paquete: </br>

```bash
$ ../configure						\
$ 		--prefix=/usr				\
$		--build=$(../config.guess)	\
$ 		--host=$LFS_TGT				\
$ 		--disable-nls				\
$ 		--enable-shared				\
$		--enable-gprofng=no			\
$ 		--disable-werror			\
$ 		--enable-64-bit-bfd
$ time make
$ make DESTDIR=$LFS install
```

Eliminar el archivo *libtool*, librerias estaticas innecesarias y el directorio descomprimido: </br>

```bash
$ rm -v $LFS/usr/lib/lib{bfd,ctf,ctf-nobfd,opcodes}.{a,la}
$ rm -rfv $LFS/sources/gzip-1.12.tar.gz
```
### GCC-12.2.0 Pass 2 <a name=gcc_12_2_0_pass_2></a>

**Approximate build time:** 15 SBU </br>
**Real time:** 49m28.073s </br>
**Required disk space:** 4.5 GB </br>

Descomprimir el paquete: </br>

```bash
$ tar -xvf $LFS/sources/gcc-12.2.0.tar.gz
$ cd $LFS/sources/gcc-12.2.0
$ tar -xvf ../mpfr-4.1.0.tar.xz
$ tar -xvf ../gmp-6.2.1.tar.xz
$ tar -xvf ../mpc-1.2.1.tar.xz

$ mv -v mpfr-4.1.0 mpfr
$ mv -v gmp-6.2.1 gmp
$ mv -v mpc-6.2.1 mpc
```

En computadoras de 64 bits configurar el directorio de librerias de 64 bits como *lib*: </br>

```bash
$ case $(uname -m) in
$ 	x86_64)
$ 	sed -e '/m64=/s/lib64/lib/' \
$ 		-i.orig gcc/config/i386/t-linux64
$	;;
$ esac
```

Sobreescribir la regla de escritura de las cabecerdas *libgcc* y *libstdc++* </br>

```bash
$ sed '/thread_header =/s/@.*@/gthr-posix.h/' \
$ 	-i libgcc/Makefile.in libstdc++-vr/include/Makefile.in
```

Crear el directorio build: </br>

```bash
$ mkdir $LFS/sources/gcc-12.2.0/build
$ cd $LFS/sources/gcc-12.2.0/build
```

Compilar el paquete: </br>

```bash
$ ../configure												\
$				--build=$(../config.guess)					\
$				--host=$LFS_TGT								\
$ 				--target=$LFS_TGT							\
$				LDFLAGS_FOR_TARGET=-L$PWD/$LFS_TGT/libgcc	\
$ 				--prefix=/usr								\
$ 				--with-build-sysroot=$LFS					\
$				--enable-initfini-array						\
$				--disable-nls								\
$ 				--disable-multilib							\
$ 				--disable-decimal-float						\
$ 				--disable-libatomic							\
$ 				--disable-libgomp							\
$ 				--disable-libquadmath						\
$ 				--disable-libssp							\
$ 				--disable-libvtv							\
$				--enable-languages=c,c++
$
$ time make
$
$ make DESTDIR=$LFS install
```

Crear un enlace simbolico: </br>

```bash
$ ln -sv gcc $LFS/usr/bin/cc
```

Eliminar el directorio descomprimido: </br>

```bash
$ rm -rfv $LFS/sources/gcc-12.2.0
```
