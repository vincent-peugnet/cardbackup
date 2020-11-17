# Configuration / variables section
PREFIX ?= /usr/local

# Identity
NAME         = cardbackup
FILE_VERSION = $(strip $(shell cat VERSION 2>/dev/null))
VERSION     := $(shell git --no-pager describe --always --tags 2>/dev/null || echo $(FILE_VERSION))

# Packaging
PKG_NAME = $(NAME)-$(VERSION)
PKG_FILE = $(PKG_NAME).tar.gz

# Default installation paths
SBINDIR  = $(DESTDIR)$(PREFIX)/sbin
SHAREDIR = $(DESTDIR)$(PREFIX)/share/$(NAME)
DIRS     = $(SBINDIR) $(SHAREDIR)

SBINS       = $(wildcard sbin/*)
SHARES      = $(wildcard share/$(NAME)/*)
INST_SBINS  = $(patsubst sbin/%, $(SBINDIR)/%, $(SBINS))
INST_SHARES = $(patsubst share/$(NAME)/%, $(SHAREDIR)/%, $(SHARES))

all: share/$(NAME)/VERSION

install: all $(DIRS)
	install -D $(SBINS) $(SBINDIR)
	install -D $(SHARES) $(SHAREDIR) -m 644

clean:
	rm -f share/$(NAME)/VERSION

distclean: clean
	rm -f VERSION
	rm cardbackup-*.tar.gz

dist: all $(PKG_FILE)

uninstall:
	-rm -f $(INST_SBINS)
	-rm -f $(INST_SHARES)
	rmdir $(SHAREDIR) || true

$(PKG_FILE): VERSION
	git archive --output=$@ --prefix=$(PKG_NAME)/ HEAD \
		--add-file=VERSION

$(DIRS):
	install -d $@

share/$(NAME)/VERSION: VERSION
	cp $< $@

VERSION: .FORCE
ifneq ($(FILE_VERSION),$(VERSION))
	echo $(VERSION) > $@
endif

# Special (fake) target to always run a target but have Make consider
# this updated if it was actually rewritten (a .PHONY target is always
# considered new).
.FORCE:

.PHONY: all install clean distclean uninstall
