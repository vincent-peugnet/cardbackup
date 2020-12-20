# Copyright (C) 2020  Nicolas Peugnet

# This file is part of cardbackup

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

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
BINDIR   = $(DESTDIR)$(PREFIX)/bin
SHAREDIR = $(DESTDIR)$(PREFIX)/share/$(NAME)
DIRS     = $(BINDIR) $(SHAREDIR)

BINS        = $(wildcard bin/*)
SHARES      = $(wildcard share/$(NAME)/*)
INST_SBINS  = $(patsubst bin/%, $(BINDIR)/%, $(BINS))
INST_SHARES = $(patsubst share/$(NAME)/%, $(SHAREDIR)/%, $(SHARES))

all: share/$(NAME)/VERSION

install: all | $(DIRS)
	install -D $(BINS) $(BINDIR)
	install -D $(SHARES) $(SHAREDIR) -m 644

clean:
	rm -f share/$(NAME)/VERSION

distclean: clean
	rm -f VERSION
	rm -f cardbackup-*.tar.gz

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
