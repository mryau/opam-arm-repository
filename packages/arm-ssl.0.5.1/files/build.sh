#!/bin/sh -e

PREFIX=$1

ARCH=`uname | tr A-Z a-z`
EXEC_PREFIX=arm-oe-linux-gnueabi-
INCLUDE=$PREFIX/arm-oe-linux-gnueabi/include
#CC="$TOOLCHAIN/${EXEC_PREFIX}gcc --sysroot $SYSROOT -I $INCLUDE"

export CC="arm-oe-linux-gnueabi-gcc  -march=armv7-a -mfpu=vfpv3  -mfloat-abi=softfp --sysroot=/home/ssp/build/tmp-glibc/sysroots/wolverine_v1"
export LD="arm-oe-linux-gnueabi-ld --sysroot=/home/ssp/build/tmp-glibc/sysroots/wolverine_v1 "
export CPP="arm-oe-linux-gnueabi-gcc -E --sysroot=/home/ssp/build/tmp-glibc/sysroots/wolverine_v1  -march=armv7-a -mfpu=vfpv3  -mfloat-abi=softfp"
CPPFLAGS=" -I$PREFIX/arm-oe-linux-gnueabi/include"
LDFLAGS="-L$PREFIX/arm-oe-linux-gnueabi/lib"
PATH="$PREFIX/bin/arm-oe-linux-gnueabi:$TOOLCHAIN:$PATH"

export CC LD CPP CPPFLAGS LDFLAGS PATH

./bootstrap

./configure --host arm-oe-linux-gnueabi OCAMLFIND="$PREFIX/bin/ocamlfind -toolchain arm" LIBS="-lcrypto "

make CLIBS="ssl crypto"
make install
