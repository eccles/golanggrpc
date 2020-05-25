#!/bin/sh
# 
# Compile all the code
#
. ./buildscripts/_run_in_container_if_necessary

cd source
go install ./...
