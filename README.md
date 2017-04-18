# opam-arm-repository


This OPAM repository contains an OCaml cross-compiler for ARM, as well
as a few OCaml libraries and programs adapted to be compiled for yocto/bitbake cross-compilation distro.

Note that most of the recipes found here are just adaptations from
[whirm's opam-arm-repository](https://github.com/whirm/opam-arm-repository).

I'll be adapting the ones I need but I'll gladly accept PRs.

The following notes are adapted from the original repo too:

Installation notes
------------------

Use the following command to add this repository to the list of
repositories used by OPAM:
```
opam repo add arm https://github.com/mryau/opam-arm-repository.git
```

The following command will list the available packages:
```
opam list | grep arm
```

On a 64bit Debian or Ubuntu installation, you need to install package
`gcc-multilib` and `lib32z1`, as we have to build 32 bit OCaml
binaries when targeting 32 bit architectures.

Directory structure
-------------------

Cross-compilation tools use the `arm-oe-linux-gnueabi-` prefix (for
instance, `arm-oe-linux-gnueabi-ocamlc`) to differentiate them from
standard OCaml tools. For convenience, unprefixed binaries are also
available in directory `%{bin}%/arm-linux-gnueabihf/`, where `%{bin}%`
is the directory where OPAM normally puts binaries (typically,
`~/.opam/4.02.1/bin/` for OCaml 4.02.1). Since this repo targeted for programs
will be finally packaged by bitbake, I prefer to use OPAMROOT
environment variable to setup all packages into Yocto image.

Ocamlfind can be invoked as either:
- `ocamlfind -toolchain arm`,
- `arm-oe-linux-gnueabi-ocamlfind`,
- `%{bin}%/arm-oe-linux-gnueabi/ocamlfind`.

The C compiler is called with the right options when invoked through
the OCaml compilers, so this location only matters if you need to
invoke the compiler directly. See the build script for package
`android-c-openssh` for an example of how to do it.

linux-arm libraries and binaries are placed in directory
`%{prefix}%/arm-oe-linux-gnueabi`, where `%{prefix}%` is the
directory under which OPAM normally puts libraries and libraries
(typically, `~/.opam/4.00.1/` for OCaml 4.00.1). For instance,
the path of the unison binary is:
```
%{prefix}/arm-oe-linux-gnueabi/bin/unison
```

Bytecode programs
-----------------

There are a few pitfalls regarding bytecode programs. First, if you
link them without the `-custom` directive, you will need to use
`ocamlrun` explicitly to run them. Second, the `ocamlmklib` command
produces shared libraries `dll*.so` which are not usable. Thus, you
need to use the `-custom` directive to successfully link bytecode
programs that uses libraries with mixed C / OCaml code. Shared
libraries should eventually be disabled, but at the moment, the
`ocamlbuild` plugin of `oasis` requires them to be created.

Acknowledgements
----------------

Many thanks to Elric Milon and Jerome Vouillon for their OCaml 4.x cross-compiler suites anr OPAM repositories.

<!-- Local Variables: -->
<!-- fill-column: 70 -->
<!-- End: -->
