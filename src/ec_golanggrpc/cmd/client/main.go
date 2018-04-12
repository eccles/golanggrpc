package main

import (
	"flag"
	"os"

	log "github.com/sirupsen/logrus"

	"ec_golanggrpc/client"
	"ec_golanggrpc/params"
)

var parameterMap = params.ParameterMap{
	"Debug": {
		Default: "false",
		Desc:    "Output debug statements to log",
	},
	"Host": {
		Default: "",
		Desc:    "Hostname",
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

	host, err := params.EnvString(parms, "Host")
	if err != nil {
		log.Panicf("Error %v", err)
	}
	port, err := params.EnvInt(parms, "Port")
	if err != nil {
		log.Panicf("Error %v", err)
	}
	cmd := flag.String("c", "Echo", "Command to execute")

	log.Infof("Cmd %s", *cmd)
	log.Info("Debug ", debug)
	log.Info("Host ", host)
	log.Info("Port ", port)
	log.Info("Execute")

	if client.Execute(host, port, cmd) == false {
		os.Exit(1)
	}
}
