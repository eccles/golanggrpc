#!/bin/sh
# 
# Statically check the code
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
gofmt -s -w .
goimports -w .
golangci-lint run ./...
go vet ./...
