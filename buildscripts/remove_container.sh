#!/bin/sh
#
. ./buildscripts/docker-check.sh

NAME=$(cat name )

# Remove containers
${DOCKER} down --remove-orphans

remove() {
	echo $1
	local name="${NAME}_${1}"
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
