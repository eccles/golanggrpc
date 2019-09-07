#!/bin/sh
#
# Executes a command inside the builder container
#
. ./buildscripts/env
NAME=$( basename $0 )

# Cache go dependencies externally
# mounted in ${GODIR} inside builder container
if [ ! -d "${TMPGODIR}" ]
then
	mkdir -p ${TMPGODIR}
fi

docker run \
    --rm -it \
    -v $(pwd):${HOME}/${SRC} \
    -v ${TMPGODIR}:${GODIR} \
    -u ${USERID} \
    ${REPO}_builder \
    "$@"
