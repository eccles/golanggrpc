#!/bin/sh
# 
# Makes python client wheel
#
set -e
. ./buildscripts/env
(cd ${SRC}/python && make )
