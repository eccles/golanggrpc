#!/bin/sh
#
# Executes a command inside the builder container
#
. ./buildscripts/env
#set -x
NAME=$( basename $0 )
if [ ! -d "${HOME}/go" ]
then
	mkdir ${HOME}/go
fi
docker run \
    --rm -it \
    -v $(pwd):${HOME}/src \
    -v ${HOME}/go:${HOME}/go \
    -u ${USERID} \
    ${REPO}_builder \
    "$@"
