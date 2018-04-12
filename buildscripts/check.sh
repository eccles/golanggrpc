#!/bin/sh -e
# 
# Statically check the code
#
NAME=$( cat name )

for f in `find src/${NAME} -path src/${NAME}/vendor -prune -o -name '*.go' -print`
do
	go fmt $f
	golint $f
	go tool vet $f
done
