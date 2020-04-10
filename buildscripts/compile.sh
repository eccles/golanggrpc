#!/bin/sh
# 
# Compile all the code
#
. ./buildscripts/env
. ./buildscripts/_run_in_container_if_necessary

GOBIN=`pwd`/bin go install ./...
