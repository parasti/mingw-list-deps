#!/bin/sh

source mingw-environment.sh

set -x

test "$1" && test "$2" || {
    echo "Usage: $0 <binarchive> <libarchive>"
    exit 1
}

binarchive="$1"
libarchive="$2"

unzip "$binarchive" bin/jpeg62.dll -d "$MINGW_PREFIX"
unzip "$libarchive" 'include/*.h' lib/libjpeg.dll.a -d "$MINGW_PREFIX"

