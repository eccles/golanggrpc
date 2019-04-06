#!/bin/sh
# 
# Unit tests the code and record the coverage
#
cd src
set -e
rm -rf htmlcov
mkdir htmlcov
go test ./... -coverprofile /tmp/c.out
if [ -s /tmp/c.out ]
then
	go tool cover -html=/tmp/c.out -o htmlcov/all.html
	rm -f /tmp/c.out
fi

# go test --race ./...
