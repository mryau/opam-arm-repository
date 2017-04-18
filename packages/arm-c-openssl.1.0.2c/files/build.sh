#!/bin/sh -e

PREFIX=$1

ARCH=`uname | tr A-Z a-z`
EXEC_PREFIX=arm-oe-linux-gnueabi-

export CROSS_COMPILE=/usr/bin/$EXEC_PREFIX

./Configure -no-ssl3 --prefix="$PREFIX/arm-oe-linux-gnueabi" shared linux-armv4 -mfpu=vfpv3 -mfloat-abi=softfp -D_NDK_MATH_NO_SOFTFP=1 -Wl,--fix-cortex-a8 -Wl,--no-warn-mismatch --sysroot=/home/ssp/build/tmp-glibc/sysroots/wolverine_v1

make all
make install_sw
