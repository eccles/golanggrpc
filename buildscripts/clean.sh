#!/bin/sh
# 
# returns repo to pristine state
#
set -e
set -x
git clean -fdX
