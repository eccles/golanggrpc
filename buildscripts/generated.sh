#!/bin/sh
# 
# create auto-generated code
#
. ./buildscripts/env
. ./buildscripts/_run_in_container_if_necessary

# generate code from proto definition
( cd api && make )
