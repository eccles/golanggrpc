#!/bin/sh
# 
# create auto-generated code
#
. ./buildscripts/env

NAME=$0

set -e

if [ "$CONTAINER_NAME" != "${REPO}-base" ]
then
	./buildscripts/builder.sh bash -c "cd ${SRC} && $NAME"
	exit
fi

# generate code from proto definition
( cd api && make )
