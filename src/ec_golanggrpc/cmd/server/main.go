package main

import (
	log "github.com/sirupsen/logrus"

	"ec_golanggrpc/params"
	"ec_golanggrpc/server"
)

var parameterMap = params.ParameterMap{
	"Debug": {
		Default: "false",
		Desc:    "Output debug statements to log",
	},
	"Port": {
		Default: "8080",
		Desc:    "Port number",
	},
}

func main() {
	parms := &params.Parameters{
		EnvTag:     "EC_GOLANGGRPC",
		Properties: &parameterMap,
	}

	debug, err := params.EnvBool(parms, "Debug")
	if err != nil {
		log.Panicf("Error %v", err)
	}
	if debug {
		log.SetLevel(log.DebugLevel)
	}

	port, err := params.EnvInt(parms, "Port")
	if err != nil {
		log.Panicf("Error %v", err)
	}

	log.Info("Debug ", debug)
	log.Info("Port ", port)
	server.Execute(port)
}
