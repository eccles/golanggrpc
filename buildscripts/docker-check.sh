#
. ./buildscripts/log
which docker-compose
if [ $? -ne 0 ]
then
	log 'docker-compose not installed. Exiting.'
	exit 1
fi
docker-compose --version

which docker
if [ $? -ne 0 ]
then
	log 'docker not installed. Exiting.'
	exit 1
fi
docker --version

if [ -z "${DOCKER}" ]
then
	log "DOCKER not set"
	exit 1
fi

if [ -z "${IMGNAME}" ]
then
	log "IMGNAME not set"
	exit 1
fi

if [ -z "${BUILDER}" ]
then
	log "BUILDER not set"
	exit 1
fi