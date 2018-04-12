# golanggrpc

Boilerplate for golang GRPC server/client

Work In Progress - please do not use

# Development

    This repo uses docker as an isolation environment. Install on your development host:

        - curl
        - make
        - docker-ce
        - docker-compose

    To make:

        make

    The first time this command is invoked will build a large base image for the build environment. This is cached so
    subsequent invokations are much quicker.

    To make changes, edit files and execute:

        make unittest

    For a more comprehensive description see buildscripts/README.md.

# Usage

    Currently this repo only supports one message called 'Echo'.

    See buildscripts/functest.sh for execution of the client that connects to a server running in a container.
    The container is defined in Dockerfile-aplineapi and created using the docker-compose.yaml file.

