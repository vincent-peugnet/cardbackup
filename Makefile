PREFIX ?= /usr/local

BINDIR = sbin
INSDIR = $(DESTDIR)$(PREFIX)/sbin

BINARIES  = $(wildcard $(BINDIR)/*)
INSTALLED = $(patsubst $(BINDIR)/%, $(INSDIR)/%, $(BINARIES))

all:

install:
	install -d $(BINDIR) $(INSDIR)

clean:
# remove all latex related tmp files
	rm -f *.aux *.pdf *.log *.fdb_latexmk *.fls *.synctex.gz

distclean: clean

uninstall:
	-rm -f $(INSTALLED)

.PHONY: all install clean distclean uninstall
