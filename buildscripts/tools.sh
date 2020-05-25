#!/bin/sh
# 
# install additional tools
# 
. ./buildscripts/_run_in_container_if_necessary

# install tools
cd source
go get -u \
    github.com/golang/protobuf/protoc-gen-go@v${PROTOBUF_VERSION}  \
    golang.org/x/tools/cmd/goimports

#GRPC_GATEWAY_VERSION=1.11.1
#go get \
#	github.com/grpc-ecosystem/grpc-gateway@v${GRPC_GATEWAY_VERSION} \
#	github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway@v${GRPC_GATEWAY_VERSION} \
#	github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger@v${GRPC_GATEWAY_VERSION} \

# Fill cache
go mod download

