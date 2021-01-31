// Makes sure that build tools are kept as correct dependency when using
// go modules.
//
// https://github.com/go-modules-by-example/index/blob/master/010_tools/README.md
//
// +build tools

package tools

import (
	_ "github.com/AlekSi/gocov-xml"
	_ "github.com/axw/gocov/gocov"
	_ "github.com/envoyproxy/protoc-gen-validate"
	_ "github.com/fullstorydev/grpcurl/cmd/grpcurl"
	_ "github.com/go-delve/delve/cmd/dlv"
	_ "github.com/golang/protobuf/protoc-gen-go"
	_ "github.com/matm/gocov-html"
	_ "github.com/mitchellh/golicense"
	_ "github.com/jondot/goweight"
	_ "github.com/leighmcculloch/gobin"
	_ "github.com/psampaz/go-mod-outdated"
	_ "github.com/pseudomuto/protoc-gen-doc/cmd/protoc-gen-doc"
	_ "github.com/spf13/cobra"
	_ "golang.org/x/tools/cmd/goimports"
	_ "gotest.tools/v3/assert/cmd/gty-migrate-from-testify"
	_ "rsc.io/goversion"
)
