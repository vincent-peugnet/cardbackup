# Configuration / variables section
PREFIX ?= /usr/local

# Identity
NAME         = cardbackup
VERSION      = $(strip $(shell cat VERSION 2>/dev/null))
GIT_VERSION := $(shell git --no-pager describe --always --tags 2>/dev/null || echo $(VERSION))

# Default installation paths
SBINDIR  = $(DESTDIR)$(PREFIX)/sbin
SHAREDIR = $(DESTDIR)$(PREFIX)/share/$(NAME)

SBINS       = $(wildcard sbin/*)
SHARES      = $(wildcard share/$(NAME)/*)
INST_SBINS  = $(patsubst sbin/%, $(SBINDIR)/%, $(SBINS))
INST_SHARES = $(patsubst share/$(NAME)/%, $(SHAREDIR)/%, $(SHARES))

all: VERSION

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

VERSION: .FORCE
ifneq ($(VERSION),$(GIT_VERSION))
	echo $(GIT_VERSION) > $@
endif

# Special (fake) target to always run a target but have Make consider
# this updated if it was actually rewritten (a .PHONY target is always
# considered new).
.FORCE:

.PHONY: all install clean distclean uninstall
