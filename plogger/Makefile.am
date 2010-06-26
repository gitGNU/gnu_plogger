## Process this file with automake to produce Makefile.in

bin_SCRIPTS = plogger

ploggerscmdir = @GUILE_SITE@/plogger
ploggersqldir = ${prefix}/share/plogger/sql

ploggerscm_DATA = \
	config.scm \
	rdb.scm \
	text.scm \
	phases.scm \
	projects.scm \
	issues.scm \
	issue-types.scm \
	times.scm \
	validations.scm \
	activities.scm \
	interruptions.scm \
	commands.scm

ploggersql_DATA = \
	init.sql

EXTRA_DIST = \
	$(ploggerscm_DATA) \
	$(ploggersql_DATA)

uninstall-local:
	-rm -r $(ploggerscm_DATA) $(ploggersql_DATA)
