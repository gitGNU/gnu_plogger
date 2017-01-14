## Process this file with automake to produce Makefile.in

bin_SCRIPTS = plogger

ploggerscmdir = @GUILE_SITE@/plogger
ploggersqldir = ${prefix}/share/plogger/sql

ploggerscm_DATA = \
	config.scm \
	db.scm \
	models.scm \
	text.scm \
	phases.scm \
	projects.scm \
	tasks.scm \
	task-types.scm \
	times.scm \
	validations.scm \
	activities.scm \
	interruptions.scm \
	commands.scm

EXTRA_DIST = \
	$(ploggerscm_DATA)

uninstall-local:
	-rm -r $(ploggerscm_DATA)

