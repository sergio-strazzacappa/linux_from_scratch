#!/bin/bash

# Simple script to list version numbers of critical developments tools
export LC_ALL=C

# Bash-3.2 (/bin/sh should be a symbolic or hard link to bash)
bash --version | head -n1 | cut -d" " -f2-4
MYSH=$(readlink -f /bin/sh)
echo "/bin/sh -> $MYSH"
echo "$MYSH" | grep -q bash || echo "ERROR: /bin/sh does not point to bash"
unset MYSH

# Binutils-2.13.1 (Versions greater than 2.39 are not recommended as they have not been tested)
echo -n "Binutils: "
ld --version | head -n1 | cut -d" " -f3-

# Bison-2.7 (/usr/bin/yacc should be a link to bison or small script that executes bison)
bison --version | head -n1

if [ -h /usr/bin/yacc ]; then
    echo "/usr/bin/yacc -> $(readlink -f /usr/bin/yacc)"
elif [ -x /usr/bin/yacc ]; then
    echo "yacc is $(/usr/bin/yacc --version | head -n1)"
else
    echo "yacc not found"
fi

# Coreutils-6.9
echo -n "Coreutils: "
chown --version | head -n1 | cut -d")" -f2

# Diffutils-2.8.1
diff --version | head -n1

# Findutils-4.2.31
find . --version | head -n1

# Gawk-4.0.1 (/usr/bin/awk should be a link to gawk)
gawk --version | head -n1

if [ -h /usr/bin/awk ]; then
    echo "/usr/bin/awk -> $(readlink -f /usr/bin/awk)"
elif [ -x /usr/bin/awk ]; then
    echo "awk is $(/usr/bin/awk --version | head -n1)"
else
    echo "awk not found"
fi

# GCC-4.8 including the C++ compiler, g++ (Versions greater than 12.2.0 are not recommended as they have not been tested). C and C++ standard libraries (with headers) must also be present so the C++ compiler can build hosted programs
gcc --version | head -n1
g++ --version | head -n1

# Grep-2.5.1a
grep --version | head -n1

# Gzip-1.3.12
gzip --version | head -n1

# Linux Kernel-3.2
# The reason for the kernel version requirement is that we specify that version when building glibc in Chapter 5 and Chapter 8, at the recommendation of the developers. It is also required by udev. If the host kernel is earlier than 3.2 you will need to replace the kernel with a more up to date version. There are two ways you can go about this. First, see if your Linux vendor provides a 3.2 or later kernel package. If so, you may wish to install it. If your vendor doesn't offer an acceptable kernel package, or you would prefer not to install it, you can compile a kernel yourself. Instructions for compiling the kernel and configuring the boot loader (assuming the host uses GRUB) are located in Chapter 10.
cat /proc/version

# M4-1.4.10
m4 --version | head -n1

# Make-4.0
make --version | head -n1

# Patch-2.5.4
patch --version | head -n1

# Perl-5.8.8
echo Perl "$(perl -V:version)"

# Python-3.4
python3 --version

# Sed-4.1.5
sed --version | head -n1

# Tar-1.22
tar --version | head -n1

# Texinfo-4.7
makeinfo --version | head -n1

# Xz-5.0.0
xz --version | head -n1

echo 'int main() {}' >dummy.c && g++ -o dummy dummy.c

if [ -x dummy ]; then
    echo "g++ compilation OK"
else echo "g++ compilation failed"; fi
rm -f dummy.c dummy
