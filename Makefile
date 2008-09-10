# MinGW prefix (/opt/mingw, ~/mingw, etc.)
# This is where 'mingw-make install' installs to.
MINGW_PREFIX := ~/dev/mingw

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
	sed 's,^MINGW_PREFIX=.*$$,MINGW_PREFIX=$(MINGW_PREFIX),' \
		< $(ENV_SCRIPT) > $(ENV_SCRIPT).mod
	mv -f $(ENV_SCRIPT).mod $(ENV_SCRIPT)

	install -d $(BINDIR)
	install $(SCRIPTS) $(BINDIR)

uninstall:
	$(RM) $(addprefix $(BINDIR)/,$(SCRIPTS))

