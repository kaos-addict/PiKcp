# Go variables...
GOCMD = go build
GOPATH = ${PWD}
GOFLAG = --compiler gccgo
export $(GOPATH)

PACKAGE = kcp
PACKAGEC = pckcp
PACKAGEFLAG = --create-manpage

# Source directories
SRCDIR = ${PWD}/src/kcp
SRCDIRC = ${PWD}/src/pckcp
COMPDIR = ${PWD}/completion
BUILDDIR = ${PWD}/build
MANDIR = ${PWD}/man
ETCDIR = ${PWD}/etc/pckcp

# Base files
BINFILE = $(PACKAGE)
BINFILEC = $(PACKAGEC)
MANFILE = $(PACKAGE).1
GOFILE = $(PACKAGE).go
GOFILEC = $(PACKAGEC).go
BASHFILE = $(PACKAGE).bash
FISHFILE = $(PACKAGE).fish
EXCEPTS = exceptions

# Source files
SRCBINFILE = $(BUILDDIR)/$(BINFILE)
SRCBINFILEC = $(BUILDDIR)/$(BINFILEC)
SRCMANFILE = $(MANDIR)/$(MANFILE)
SRCGOFILE = $(SRCDIR)/$(GOFILE)
SRCGOFILEC = $(SRCDIRC)/$(GOFILEC)
SRCBASHFILE = $(COMPDIR)/$(BASHFILE)
SRCFISHFILE = $(COMPDIR)/$(FISHFILE)
SRCEXCEPTF = $(ETCDIR)/$(EXCEPTS)

# Destination directories
DESTDIR ?=
DESTBIN = $(DESTDIR)/usr/bin
DESTMAN = $(DESTDIR)/usr/share/man/man1
DESTBASH = $(DESTDIR)/etc/bash_completion.d
DESTFISH = $(DESTDIR)/usr/share/fish/vendor_completions.d
DESTEXCEPT = $(DESTDIR)/etc/pckcp

# Destination files
DESTBINFILE = $(DESTBIN)/$(BINFILE)
DESTBINFILEC = $(DESTBIN)/$(BINFILEC)
DESTMANFILE = $(DESTMAN)/$(MANFILE)
DESTBASHFILE = $(DESTBASH)/$(PACKAGE)
DESTFISHFILE = $(DESTFISH)/$(FISHFILE)
DESTEXCEPTF = $(DESTEXCEPT)/$(EXCEPTS)

.PHONY: default build install clean

default: build

build:
	mkdir -p $(BUILDDIR)
	$(GOCMD) -v -o $(SRCBINFILE) $(SRCGOFILE)
	$(GOCMD) -v -o $(SRCBINFILEC) $(SRCGOFILEC)

install:
	mkdir -p $(DESTBIN)
	mkdir -p $(DESTMAN)
	mkdir -p $(DESTBASH)
	mkdir -p $(DESTFISH)
	mkdir -p $(DESTEXCEPT)
	cp $(SRCBINFILE) $(DESTBINFILE)
	cp $(SRCBINFILEC) $(DESTBINFILEC)
	cp $(SRCMANFILE) $(DESTMANFILE)
	cp $(SRCBASHFILE) $(DESTBASHFILE)
	cp $(SRCFISHFILE) $(DESTFISHFILE)
	cp $(SRCEXCEPTF) $(DESTEXCEPTF)

clean:
	rm $(SRCBINFILE)
	rm $(SRCBINFILEC)
	rmdir $(BUILDDIR)
