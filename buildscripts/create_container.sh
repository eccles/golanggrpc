#!/bin/sh
#
. ./buildscripts/_do_not_run_in_container

. ./buildscripts/docker-check
# Add containers
${DOCKER} build ${1}
