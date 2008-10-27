#!/bin/sh

# This script is based on instructions from USAGE.txt in the official
# zlib DLL distribution.  It suggests to use the name "zdll" for the
# import library's base name, however, using "z.dll" seems to be more in
# line with MinGW's naming conventions and does not require build
# scripts to be modified to link "-lzdll" instead of "-lz".

. mingw-environment.sh

set -x

PREFIX="$MINGW_PREFIX"

dll=zlib1.dll
def=lib/zlib.def
imp=lib/libz.dll.a

$TARGET-dlltool -D $(basename $dll) -d $def -l $imp

install -d $PREFIX/include $PREFIX/lib $PREFIX/bin
install include/zlib.h include/zconf.h $PREFIX/include
install $imp $PREFIX/lib
install $dll $PREFIX/bin

