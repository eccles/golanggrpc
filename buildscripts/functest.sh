#!/bin/sh
#
# Runs functional tests as a package
#
. ./buildscripts/docker-check
set -e

export GOLANGGRPC_HOST="localhost"
export GOLANGGRPC_PORT="8080"
${DOCKER} up -d api

CLIENT="bin/client"
echo "----> Test no arguments"
${CLIENT} 2> /tmp/no_arguments
cat /tmp/no_arguments
if [ $? -ne 0 ]
then
	echo "Show usage failure"
fi

${DOCKER} down --remove-orphans
