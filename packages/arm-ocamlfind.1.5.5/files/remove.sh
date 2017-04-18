#!/bin/sh -e

PREFIX=$1

MODULES="\
  bigarray camlp4 compiler-libs dbm dynlink graphics num num-top \
  ocamlbuild stdlib str threads unix"

rm -f "$PREFIX/lib/findlib.conf.d/arm.conf"
rm -f "$PREFIX/bin/arm-oe-linux-gnueabi/ocamlfind"
rm -f "$PREFIX/bin/arm-oe-linux-gnueabi-ocamlfind"

for m in $MODULES; do
  rm -rf "$PREFIX/arm-oe-linux-gnueabi/lib/$m"
done
