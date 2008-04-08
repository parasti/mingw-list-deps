# This file is in the public domain for what it's worth.
# Written by Jānis Rūcis <parasti@gmail.com>
# Last updated in April, 2008.

# README:
#
#   * If  the date  above seems too  far back in  the past,  the stuff
#   below is likely horribly outdated  and only of historic relevance.
#   Don't use it.
#
#   * Some  of the variables  below will have  to be modified  for the
#   script to  be useful on  your system. These  include MINGW_PREFIX,
#   BUILD and TARGET.
#
#   * The script is deliberately  minimalistic. Its primary purpose is
#   to provide  a proper  cross-compilation environment  for Neverball
#   and  its dependencies,  so  you  will probably  need  to add  more
#   variables to get your own software to compile.
#
#   * This  script is designed  to be  as transparent as  possible, so
#   that no changes  are necessary to a build system.  However, due to
#   there being  no way to inform  GCC of a non-standard  library path
#   when cross-compiling, a build system still has support the LDFLAGS
#   environment variable.

MINGW_PREFIX=~/dev/mingw
export MINGW_PREFIX

# This isn't plain 'wine' because in Debian the Wine in PATH is actually the
# Winelauncher script, which is a bit too slow and too helpful for our tastes.

# Useful for builds that use their own functionality half-way through.
WINE=/usr/lib/wine/wine.bin
export WINE

# Some  rationale for  why  some of  the variables  below  have to  be
# specified: it  appears that configure scripts  use different methods
# to determine  whether cross-compilation is  in effect. Some  rely on
# the specified compiler, some require  that --host be specified, some
# only work properly when both  --build and --host are provided (which
# is strange  considering that  most of  them are  able to  detect the
# build system automatically).

# config.guess is available in the autotools-dev package on Debian and
# in most autotools-based packages. You can probably use the script if
# you need some flexibility.

#BUILD=$(sh /usr/share/misc/config.guess)
BUILD=i686-linux-gnu
# TARGET is the exact prefix of the cross binaries sans hyphen.
TARGET=i586-mingw32msvc
HOST=$TARGET

# The variables above do not need to be exported.
# No exports here, move along!

CC=$TARGET-gcc
export CC

# Appears to be used by libtool, although I haven't (yet) run into any
# trouble without it.

CC_FOR_BUILD=cc
export CC_FOR_BUILD

# When a  project that uses  libtool does  not inform libtool  that it
# has  been  ported  to  build  native  Windows  DLLs  (by  using  the
# AC_LIBTOOL_WIN32_DLL macro in configure.in  or, since this macro has
# been  deprecated  recently,  some  other  equivalent  way),  dynamic
# libraries fail to build. Although libtool documentation does mention
# this  requirement,  libtool itself  does  not  seem to  handle  this
# cleanly and  fails in  obscure ways.  Explicitly setting  OBJDUMP is
# (sometimes)  a sufficient  work-around. (Note  that this  might have
# been fixed to some extent in recent libtool versions.)

# This is an incomplete list of binary utilies.  Expand as needed.

OBJDUMP=$TARGET-objdump
export OBJDUMP

RANLIB=$TARGET-ranlib
export RANLIB

NM=$TARGET-nm
export NM

# CFLAGS and CPPFLAGS aren't always  the best place for setting these.
# Instead, we inform GCC directly.

CPATH="$MINGW_PREFIX/include:$CPATH"
export CPATH

# The LIBRARY_PATH  environment variable would  be the perfect  way of
# letting GCC  know in  which directories to  look for  libraries, but
# unfortunately it  is not used  when cross compiling. The  reason for
# this remains a mystery.

LDFLAGS="-L$MINGW_PREFIX/lib $LDFLAGS"
export LDFLAGS

# This  particular PATH  setting is  seen often  in cross  compilation
# scripts, but  I have only  experienced problems with it  and haven't
# yet come across a setup where it's actually necessary.

#PATH="$MINGW_PREFIX/bin:/usr/$TARGET/bin:$PATH" # Bad idea.
PATH="$MINGW_PREFIX/bin:$PATH"                   # Good idea.
export PATH

# If configure picks up build  system's pkg-config, we politely ask it
# to  look  in all  the  right  places. Might  not  work  with an  old
# pkg-config.

PKG_CONFIG_LIBDIR="$MINGW_PREFIX/lib/pkgconfig"
export PKG_CONFIG_LIBDIR

