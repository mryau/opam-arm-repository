#!/bin/sh -e

PREFIX=$1

make -C tools/extract_args

export PATH=$PREFIX/bin/arm-oe-linux-gnueabi:$PATH

./configure -sitelib "$PREFIX/arm-oe-linux-gnueabi/lib" -bindir "./bin" -mandir  "./man" -config "./config"

make all install

mkdir -p "$PREFIX/lib/findlib.conf.d"
cp arm.conf "$PREFIX/lib/findlib.conf.d/"

chmod +x ocamlfind
cp ocamlfind "$PREFIX/bin/arm-oe-linux-gnueabi/ocamlfind"
ln -sf "$PREFIX/bin/arm-oe-linux-gnueabi/ocamlfind" \
     "$PREFIX/bin/arm-oe-linux-gnueabi-ocamlfind"
