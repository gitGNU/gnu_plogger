## Process this file with automake to produce Makefile.in

SUBDIRS = plogger #po

ploggerdocdir = ${prefix}/doc/plogger
ploggerdoc_DATA = \
	README\
	COPYING\
	AUTHORS\
	ChangeLog\
	INSTALL\
	NEWS

#ploggerscm_DATA = src/sqlite.scm

#INTLTOOL_FILES = intltool-extract.in \
	intltool-merge.in \
	intltool-update.in

EXTRA_DIST = $(ploggerdoc_DATA) 
##
##	$(INTLTOOL_FILES)

#DISTCLEANFILES = intltool-extract \
	intltool-merge \
	intltool-update \
	po/.intltool-merge-cache

# Remove doc directory on uninstall
uninstall-local:
	-rm -r $(ploggerdocdir)
