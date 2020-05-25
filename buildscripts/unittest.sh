#!/bin/sh
# 
# Unit tests the code and record the coverage
#
. ./buildscripts/_run_in_container_if_necessary
#
set -e
cd source
rm -rf ${HTMLCOV}
mkdir -p ${HTMLCOV}
CGO_ENABLED=1 go test --race ./... -coverprofile ${HTMLCOV}/c.out
if [ -s ${HTMLCOV}/c.out ]
then
	go tool cover -html=${HTMLCOV}/c.out -o ${HTMLCOV}/all.html
fi
