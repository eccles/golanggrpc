#!/bin/sh
# 
# returns repo to pristine state
#
. ./buildscripts/_run_in_container_if_necessary

set -e
go clean -modcache
git clean -fdX
