// Makes sure that build tools are kept as correct dependency when using
// go modules.
//
// https://github.com/go-modules-by-example/index/blob/master/010_tools/README.md
//
//go:generate protoc -I . --go_out=plugins=grpc:. api.proto

package api

import (
	_ "github.com/golang/protobuf/protoc-gen-go"
	_ "github.com/grpc-ecosystem/grpc-gateway"
)
