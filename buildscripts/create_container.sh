#!/bin/sh
#
. ./buildscripts/docker-check

if [ -z "$CONTAINER_NAME" ]
then
	# Add containers
	${DOCKER} build ${1}
fi
