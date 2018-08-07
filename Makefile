PRGM = i3lock-fancy-dualmonitor
PREFIX ?= /usr
SHRDIR ?= $(PREFIX)/share
BINDIR ?= $(PREFIX)/bin

install:
	@install -Dm755 i3lock-fancy-dualmonitor  -t $(DESTDIR)$(BINDIR)
	@install -Dm644 lock.png                  -t $(DESTDIR)$(SHRDIR)/$(PRGM)
	@install -Dm644 LICENSE                   -t $(DESTDIR)$(SHRDIR)/licenses/$(PRGM)
