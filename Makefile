# These variables override the corresponding variables in the
# mingw-environment.sh script.

# MinGW prefix (/opt/mingw, ~/mingw, etc.)
# This is where 'mingw-make install' installs to.
MINGW_PREFIX := ~/dev/mingw

# If a project needs to use some of its own functionality during the
# build, it can use the WINE variable in build scripts.  If none of
# the projects you're interested in do this and you don't have Wine
# installed, just ignore this.
WINE := /usr/lib/wine/wine.bin

# The "canonical system name" of your system.  See
# mingw-environment.sh for more info.
BUILD := i686-linux-gnu

# The exact prefix of the MinGW cross binaries, sans hyphen.
TARGET := i586-mingw32msvc

# Usual Makefile stuff

# Installation prefix
# This is where this Makefile installs to.
PREFIX := $(HOME)
BINDIR := $(PREFIX)/bin

ENV_SCRIPT := mingw-environment.sh
SCRIPTS := \
	$(ENV_SCRIPT)    \
	mingw-make       \
	mingw-configure  \
	mingw-list-dlls  \
	mingw-strip-dlls

all:

clean:

install:
	sed -e 's,^MINGW_PREFIX=.*$$,MINGW_PREFIX=$(MINGW_PREFIX),' \
	    -e 's,^WINE=.*$$,WINE=$(WINE),' \
	    -e 's,^BUILD=.*$$,BUILD=$(BUILD),' \
	    -e 's,^TARGET=.*$$,TARGET=$(TARGET),' \
	    < $(ENV_SCRIPT) > $(ENV_SCRIPT).mod
	mv -f $(ENV_SCRIPT).mod $(ENV_SCRIPT)

	install -d $(BINDIR)
	install $(SCRIPTS) $(BINDIR)

uninstall:
	$(RM) $(addprefix $(BINDIR)/,$(SCRIPTS))

