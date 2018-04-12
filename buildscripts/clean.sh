#!/bin/sh -e
# 
# returns repo to pristine state
#
NAME=$( cat name )

rm -rf bin/ \
       htmlcov/ \
       pkg/ \
       pkg-build/

for m in `find src/${NAME} -path src/${NAME}/vendor -prune -o -name Makefile -print`
do
	d=$( dirname $m )
	( cd $d && make clean )
done
