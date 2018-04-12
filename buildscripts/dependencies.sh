#!/bin/sh -e
# 
# get dependencies
#
NAME=$( cat name  )

for m in `find src/${NAME} -path src/${NAME}/vendor -prune -o -name Makefile -print`
do
	d=$( dirname $m )
	( cd $d && make )
done

# make dependencies
cd src/${NAME}
if [ ! -d vendor \
  -o ! -s Gopkg.toml ]
then
	rm -rf Gopkg.*
	dep init 
fi
dep ensure
dep status 
cd -
