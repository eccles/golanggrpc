#!/bin/sh
#
. ./buildscripts/docker-check

# Add containers
${DOCKER} build ${1}
touch .${1}_container
