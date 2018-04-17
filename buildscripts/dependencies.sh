#!/bin/sh -e
# 
# get dependencies
#
NAME=$( cat name  )

# generate code from proto definition
( cd src/${NAME}/api && make )
( cd python && make dependencies )

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
