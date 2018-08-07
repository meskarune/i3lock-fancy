PRGM = i3lock-fancy
PREFIX ?= /usr
SHRDIR ?= $(PREFIX)/share
BINDIR ?= $(PREFIX)/bin

install:
	@install -Dm755 i3lock-fancy  -t $(DESTDIR)$(BINDIR)
	@install -Dm755 doc/i3lock-fancy.1  -t $(DESTDIR)$(SHRDIR)/man/man1
	@install -Dm755 LICENSE      -t $(DESTDIR)$(SHRDIR)/licenses/$(PRGM)
        @install -Dm644 LICENSE      -t $(DESTDIR)$(SHRDIR)/licenses/$(PRGM)
