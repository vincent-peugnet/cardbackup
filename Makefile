# Configuration / variables section
PREFIX ?= /usr/local

# Identity
NAME = cardbackup

# Default installation paths
SBINDIR  = $(DESTDIR)$(PREFIX)/sbin
SHAREDIR = $(DESTDIR)$(PREFIX)/share/$(NAME)

SBINS       = $(wildcard sbin/*)
SHARES      = $(wildcard share/$(NAME)/*)
INST_SBINS  = $(patsubst sbin/%, $(SBINDIR)/%, $(SBINS))
INST_SHARES = $(patsubst share/$(NAME)/%, $(SHAREDIR)/%, $(SHARES))

all:

install: all
	install -d $(SBINDIR)
	install -d $(SHAREDIR)
	install -D $(SBINS) $(SBINDIR)
	install -D $(SHARES) $(SHAREDIR) -m 644

clean:
# remove all latex related tmp files
	rm -f *.aux *.pdf *.log *.fdb_latexmk *.fls *.synctex.gz

distclean: clean

uninstall:
	-rm -f $(INST_SBINS)
	-rm -f $(INST_SHARES)
	rmdir $(SHAREDIR) || true

.PHONY: all install clean distclean uninstall
