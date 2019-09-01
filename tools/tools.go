// Makes sure that build tools are kept as correct dependency when using
// go modules.
//
// https://github.com/go-modules-by-example/index/blob/master/010_tools/README.md
//
// +build tools

package tools

import (
	_ "github.com/fullstorydev/grpcurl/cmd/grpcurl"
	_ "github.com/go-delve/delve/cmd/dlv"

	//	_ "github.com/golang/protobuf/protoc-gen-go"
	_ "github.com/grpc-ecosystem/grpc-gateway"
	_ "github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway"
	_ "github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger"
	_ "github.com/rakyll/statik"
	_ "github.com/spf13/cobra"
	_ "golang.org/x/tools/cmd/goimports"
)
