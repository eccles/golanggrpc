#!/bin/sh
#
echo "create_container: $*"
. ./buildscripts/docker-check.sh

NAME=${BUILDER}${1}

# Add containers
${DOCKER} up --force-recreate --build -d ${NAME}
${DOCKER} logs ${NAME}
touch .${NAME}_container
