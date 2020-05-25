#!/bin/sh
# 
# create auto-generated code
#
. ./buildscripts/_run_in_container_if_necessary

# generate code from proto definition
( cd source/api && make )
