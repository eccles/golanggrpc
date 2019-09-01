#!/bin/sh
# 
# create auto-generated code
#
. ./buildscripts/env

NAME=$0

#set -x
set -e
if [ "$CONTAINER_NAME" != "${REPO}-base" ]
then
	./buildscripts/builder.sh bash -c "cd src && $NAME"
	exit
fi
# generate code from proto definition
( cd api && make )
