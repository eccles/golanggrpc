#!/bin/sh
#
echo "create_container: $*"
. ./buildscripts/docker-check.sh

# Add containers
${DOCKER} up --force-recreate --build -d ${1}
${DOCKER} logs ${NAME}
touch .${1}_container
