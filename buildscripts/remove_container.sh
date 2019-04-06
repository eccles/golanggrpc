#!/bin/sh
#
. ./buildscripts/docker-check.sh

# Remove containers
${DOCKER} down --remove-orphans

remove() {
	local name="${IMGNAME}${1}"
	for img in `docker images --all --quiet ${name}`
	do
		docker rmi -f $img
	done
	rm -f .${OS}${1}_container
}

remove
for tag in $*
do
	remove $tag
done
