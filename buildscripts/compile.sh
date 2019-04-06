#!/bin/sh
# 
# Compile all the code
#
cd src
set -e
NAME=$( cat name )

GOBIN=`pwd`/bin go install ./...
