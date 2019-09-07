#!/bin/sh
# 
# Unit tests the code and record the coverage
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
rm -rf htmlcov
mkdir htmlcov
go test ./... -coverprofile /tmp/c.out
if [ -s /tmp/c.out ]
then
	go tool cover -html=/tmp/c.out -o htmlcov/all.html
	rm -f /tmp/c.out
fi

CGO_ENABLED=1 go test --race ./...
