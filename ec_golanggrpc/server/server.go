package server

import (
	"fmt"
	"net"

	"github.com/eccles/golanggrpc/ec_golanggrpc/api"

	log "github.com/sirupsen/logrus"
	"golang.org/x/net/context"
	"google.golang.org/grpc"
)

type server struct {
	status string
}

// Execute starts the server from parameters.
func Execute(port int) {

	log.Info("listening to port ", port)
	lis, err := net.Listen("tcp", fmt.Sprintf(":%d", port))
	if err != nil {
		log.Panicf("could not listen to port %d: %v", port, err)
	}

	s := grpc.NewServer()

	api.RegisterGolangGRPCServer(
		s,
		&server{
			status: "Online",
		},
	)

	err = s.Serve(lis)
	if err != nil {
		log.Panicf("could not serve: %v", err)
	}
}

func (s *server) Echo(
	ctx context.Context,
	grpcRequest *api.GRPCRequest) (*api.GRPCStatus, error) {
	log.Info("Echo")
	return &api.GRPCStatus{
		Name: "Online",
	}, nil
}
