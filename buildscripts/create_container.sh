#!/bin/sh
#
if [ -z "$CONTAINER_NAME" ]
then
	. ./buildscripts/docker-check
	# Add containers
	${DOCKER} build ${1}
fi
