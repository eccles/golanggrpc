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
	./buildscripts/builder.sh bash -c "cd ${SRC} && $NAME"
	exit
fi
go mod tidy
go mod verify
gofmt -l -s -w .
goimports -w .
golangci-lint run ./...
go vet ./...
