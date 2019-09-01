#!/bin/sh
#
# Remove container
#
set -e
#set -x
. ./buildscripts/docker-check

remove() {
	local name="${REPO}_${1}"
	for img in `docker images --all --quiet ${name}`
	do
		docker rmi -f $img
	done
	rm -f .${1}_container
}

for tag in $*
do
	remove $tag
done

