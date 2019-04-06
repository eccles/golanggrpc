#!/bin/sh
# 
# Statically check the code
#
set -e
cd src
NAME=$( cat name )
gofmt -s -w .
goimports -w .
golangci-lint run ./...
go vet ./...
