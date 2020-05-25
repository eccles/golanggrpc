#!/bin/sh
# 
# Makes python client wheel
#
. ./buildscripts/_run_in_container_if_necessary

set -e
. ./buildscripts/env
(cd python && make )
