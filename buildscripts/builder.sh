#!/bin/sh
#
# Executes a command inside the builder container
#
. ./buildscripts/_do_not_run_in_container

# Cache go dependencies externally
# mounted in ${GODIR} inside builder container
if [ ! -d "${TMPGODIR}" ]
then
	mkdir -p ${TMPGODIR}
fi

docker run \
	--rm -it \
	-v $(pwd):${REPO_PATH} \
	-v ${TMPGODIR}:${GODIR} \
	-u ${UUID}:${GUID} \
	${REPO_NAME}_builder \
	"$@"
