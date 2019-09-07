#!/bin/sh
# 
# Compile all the code
#
. ./buildscripts/env

NAME=$0

#set -x
set -e
if [ "$CONTAINER_NAME" != "${REPO}-base" ]
then
	./buildscripts/builder.sh bash -c "cd ${SRC} && $NAME"
	exit
fi
GOBIN=`pwd`/bin go install ./...
