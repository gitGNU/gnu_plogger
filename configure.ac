dnl Process this file with autoconf to produce a configure script.

AC_INIT(plogger, 0.1.0)

AM_INIT_AUTOMAKE(AC_PACKAGE_NAME, AC_PACKAGE_VERSION)
dnl AC_CONFIG_HEADERS([config.h])
AM_MAINTAINER_MODE

dnl AC_ISC_POSIX
dnl AC_PROG_CC
dnl AM_PROG_CC_STDC
dnl AC_HEADER_STDC

dnl ***************************************************************************
dnl Internatinalization
dnl ***************************************************************************
dnl GETTEXT_PACKAGE=plogger
dnl AC_SUBST(GETTEXT_PACKAGE)
dnl AC_DEFINE_UNQUOTED(GETTEXT_PACKAGE,"$GETTEXT_PACKAGE", [GETTEXT package name])
dnl AM_GLIB_GNU_GETTEXT
dnl IT_PROG_INTLTOOL([0.35.0])

dnl AM_PROG_LIBTOOL

PKG_CHECK_MODULES([GUILE], [guile-2.0])
PKG_CHECK_MODULES([SQLITE], [sqlite3])

GUILE_FLAGS
GUILE_SITE_DIR

AC_OUTPUT([
Makefile
plogger/Makefile
plogger/config.scm])
#po/Makefile.in])
