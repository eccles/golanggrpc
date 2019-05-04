package main

import (
	"os"
	"strconv"

	log "github.com/sirupsen/logrus"

	"github.com/eccles/golanggrpc/ec_golanggrpc/server"
)

func main() {
	loglevel := os.Getenv("GOLANGGRPC_LOGLEVEL")
	if loglevel == "DEBUG" {
		log.SetLevel(log.DebugLevel)
	}

	port, err := strconv.Atoi(os.Getenv("GOLANGGRPC_PORT"))
	if err != nil {
		log.Panicf("Error %v", err)
	}

	log.Info("Loglevel ", loglevel)
	log.Info("Port ", port)
	server.Execute(port)
}
