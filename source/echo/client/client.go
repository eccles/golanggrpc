package client

import (
	"context"
	"fmt"

	log "github.com/sirupsen/logrus"
	"google.golang.org/grpc"

	echoAPI "github.com/eccles/golanggrpc/api/echo"
)

// connect - connects to server
func connect(backend string) *grpc.ClientConn {
	log.Info("Dial ", backend)
	conn, err := grpc.Dial(backend, grpc.WithInsecure())
	if err != nil {
		log.Fatalf("could not connect to %s: %v", backend, err)
	}
	return conn
}

// echo echoes "Online".
func echo(backend string) *echoAPI.GRPCStatus {
	conn := connect(backend)
	defer conn.Close()

	myclient := echoAPI.NewGolangGRPCClient(conn)

	value := &echoAPI.GRPCRequest{}

	res, err := myclient.Echo(
		context.Background(),
		value,
	)
	if err != nil {
		log.Fatalf("could not echo %s: %v", value, err)
	}
	return res
}

func printEcho(res *echoAPI.GRPCStatus) {
	fmt.Printf("Echo: %s\n", res.GetName())
}

// Execute executes the command
func Execute(hostname string, port int, cmd *string) bool {
	backend := fmt.Sprintf("%s:%d", hostname, port)
	log.Debugf("Executing %s -> %s", *cmd, backend)

	res := echo(backend)
	printEcho(res)

	return true
}
