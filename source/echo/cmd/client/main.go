package main

import (
	"flag"
	"os"
	"strconv"

	log "github.com/sirupsen/logrus"

	"github.com/eccles/golanggrpc/echo/client"
)

func main() {
	loglevel := os.Getenv("GOLANGGRPC_LOGLEVEL")
	if loglevel == "DEBUG" {
		log.SetLevel(log.DebugLevel)
	}

	host := os.Getenv("GOLANGGRPC_HOST")
	port, err := strconv.Atoi(os.Getenv("GOLANGGRPC_PORT"))
	if err != nil {
		log.Panicf("Illegal Port")
	}
	cmd := flag.String("c", "Echo", "Command to execute")

	log.Infof("Cmd %s", *cmd)
	log.Info("Loglevel ", loglevel)
	log.Info("Host ", host)
	log.Info("Port ", port)
	log.Info("Execute")

	if !client.Execute(host, port, cmd) {
		os.Exit(1)
	}
}
