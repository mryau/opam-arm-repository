#!/bin/sh -e

PREFIX=$1

BINS="ocaml ocamlbuild ocamlbuild.byte ocamlc ocamlcp ocamldebug ocamldep ocamldoc ocamllex ocamlmklib ocamlmktop ocamlobjinfo ocamlopt ocamloptp ocamlprof ocamlrun ocamlyacc"

for b in $BINS; do
  rm -f "$PREFIX/bin/arm-oe-linux-gnueabi-$b"
  rm -f "$PREFIX/bin/arm-oe-linux-gnueabi/$b"
done
rm -rf "$PREFIX/arm-oe-linux-gnueabi/lib/ocaml"
rm -f "$PREFIX/arm-oe-linux-gnueabi/bin/ocamlrun"
