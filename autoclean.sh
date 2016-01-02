#!/bin/sh
[ -f Makefile ] && make clean
rm -rf autom4te.cache
rm -f  Makefile.in Makefile src/Makefile.in src/Makefile
rm -f config.status
rm -f configure
rm -f stamp*
rm -f aclocal.m4
rm -f missing
rm -f install-sh
rm -f config.log