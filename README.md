# golanggrpc

Boilerplate for golang GRPC server/client

Work In Progress - please do not use

# Development

    This repo uses docker as an isolation environment. Install on your development host:

        - make
        - docker-ce
        - docker-compose

## On first cloning this repo (or pulling a later version)

```bash
make builder
make tools
```

Cached go artifacts are in /tmp/$USER-$REPONAME/go

## Workflow:

Make changes to code and then:

```bash
make compile
```

Unittest:

```bash
make unittest
```

## To make all artifacts including api container:

```bash
make artifacts
```

## Clean codebase

```bash
make clean
```

## Functional tests against running api container

```bash
make functest
```

# Usage

    Currently this repo only supports one service called 'Echo'.

    See buildscripts/functest.sh for execution of the client that connects to a server running in a container.
    The container is defined in Dockerfile-aplineapi and created using the docker-compose.yaml file.

