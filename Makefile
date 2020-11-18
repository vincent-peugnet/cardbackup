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
