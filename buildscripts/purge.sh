#!/bin/sh
#
# Purges all builder artifacts
#
. ./buildscripts/env
NAME=$( basename $0 )

if [ -d "${TMPGODIR}" ]
then
	chmod -R 777 ${TMPGODIR}
	rm -rf ${TMPGODIR}
fi
