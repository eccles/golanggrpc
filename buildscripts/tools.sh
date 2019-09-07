#!/bin/sh
# 
# install additional tools
#
. ./buildscripts/env

NAME=$0

#set -x
set -e
if [ "$CONTAINER_NAME" != "${REPO}-base" ]
then
	./buildscripts/builder.sh bash -c "cd ${SRC} && $NAME"
	exit
fi

# install tools
PROTOBUF_VERSION=1.3.1
GRPC_GATEWAY_VERSION=1.11.1
go get \
	golang.org/x/tools/cmd/goimports \
	github.com/golang/protobuf/protoc-gen-go@v${PROTOBUF_VERSION} \
	github.com/grpc-ecosystem/grpc-gateway@v${GRPC_GATEWAY_VERSION} \
	github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway@v${GRPC_GATEWAY_VERSION} \
	github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger@v${GRPC_GATEWAY_VERSION} \
	github.com/rakyll/statik \
	github.com/spf13/cobra

