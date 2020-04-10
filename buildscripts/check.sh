#!/bin/sh
# 
# Statically check the code
#
. ./buildscripts/_run_in_container_if_necessary

set -e
go mod tidy
go mod verify
gofmt -l -s -w .
goimports -w .
golangci-lint run ./...
go vet ./...
