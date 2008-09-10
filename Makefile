PREFIX := $(HOME)
BINDIR := $(PREFIX)/bin

SCRIPTS := \
	mingw-environment.sh \
	mingw-make           \
	mingw-configure      \
	mingw-list-dlls      \
	mingw-strip-dlls

all:

clean:

install:
	install -d $(BINDIR)
	install $(SCRIPTS) $(BINDIR)

uninstall:
	$(RM) $(addprefix $(BINDIR)/,$(SCRIPTS))

