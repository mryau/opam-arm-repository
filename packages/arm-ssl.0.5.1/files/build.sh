#!/bin/sh -e

PREFIX=$1

ARCH=`uname | tr A-Z a-z`
EXEC_PREFIX=arm-oe-linux-gnueabi-
INCLUDE=$PREFIX/arm-oe-linux-gnueabi/include
#CC="$TOOLCHAIN/${EXEC_PREFIX}gcc --sysroot $SYSROOT -I $INCLUDE"

CPPFLAGS=" -I$PREFIX/arm-oe-linux-gnueabi/include"
CFLAGS="-march=armv7-a -mfpu=vfpv3 -mfloat-abi=softfp --sysroot=/home/ssp/build/tmp-glibc/sysroots/wolverine_v1"
LDFLAGS="-L$PREFIX/arm-oe-linux-gnueabi/lib --sysroot=/home/ssp/build/tmp-glibc/sysroots/wolverine_v1"
PATH="$PREFIX/bin/arm-oe-linux-gnueabi:$TOOLCHAIN:$PATH"

export CPPFLAGS LDFLAGS PATH

./bootstrap

./configure --host arm-oe-linux-gnueabi OCAMLFIND="$PREFIX/bin/ocamlfind -toolchain arm" LIBS="-lcrypto "

make CLIBS="ssl crypto"
make install
