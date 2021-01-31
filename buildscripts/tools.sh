#!/bin/sh
# 
# install additional tools
# 
set -x
. ./buildscripts/_run_in_container_if_necessary

# install tools
cd source
go mod tidy -v
go mod verify

# Fill cache
go mod download

