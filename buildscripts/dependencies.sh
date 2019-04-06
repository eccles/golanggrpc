#!/bin/sh -e
# 
# get dependencies
#
cd src
NAME=$( cat name  )

# generate code from proto definition
( cd ${NAME}/api && make )
