#!/bin/sh
#
# Remove container
#
. ./buildscripts/_do_not_run_in_container
. ./buildscripts/docker-check

set -e
remove() {
	local name="${REPO_NAME}_${1}"
	for img in `docker images --all --quiet ${name}`
	do
		docker rmi -f $img
	done
}

for tag in $*
do
	remove $tag
done

