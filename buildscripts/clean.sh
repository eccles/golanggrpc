#!/bin/sh -e
# 
# returns repo to pristine state
#
NAME=$( cat name )

rm -rf bin/ \
       htmlcov/ \
       pkg/ \
       pkg-build/

( cd src/${NAME}/api && make clean )
( cd python && make clean )
