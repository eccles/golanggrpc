#
NAME := $(shell cat name )
PREFIX := $(NAME)${BUILDID}

DOCKER_COMPOSE := docker-compose -p $(PREFIX)
export DOCKER := $(DOCKER_COMPOSE) -f docker-compose.yaml

export OS ?= alpine
API := $(OS)api
BASE := $(OS)base
BUILD := $(OS)build

BUILD_EXEC := $(DOCKER) exec $(BUILD)

export IMGNAME := ${PREFIX}_${BUILD}

# No C dependencies so compile natively
export CGO_ENABLED := 0

# Where to put binaries
export GOBIN := ~/bin

#------------------------------------------------------------------------------
#
#
# Requires docker-ce and docker-compose
#
# Entry points into the docker build image are correspondingly (for example):
#
# To start from scratch
#
#     make clean
#
# Do not make any _local targets on your development environment. They are
# only for internal use by the make system.
#
#------------------------------------------------------------------------------

.PHONY: all
all: clean .env artifacts

#------------------------------------------------------------------------------
#
# `make clean` cleans all generated files from container
#
.PHONY: clean
clean: remove_containers
	./buildscripts/clean.sh

#------------------------------------------------------------------------------
#
# `$ make dependencies`
#
.PHONY: dependencies
dependencies: build
	$(BUILD_EXEC) ./src/buildscripts/dependencies.sh

#------------------------------------------------------------------------------
#
# `$ make check` statically check the code
#
.PHONY: check
check: dependencies
	$(BUILD_EXEC) ./src/buildscripts/check.sh

#------------------------------------------------------------------------------
#
# `$ make unittest` execute any unittests
#
.PHONY: unittest
unittest: check
	$(BUILD_EXEC) ./src/buildscripts/unittest.sh

#------------------------------------------------------------------------------
#
# `$ make compile` compile Golang code
#
.PHONY: compile
compile: unittest
	$(BUILD_EXEC) ./src/buildscripts/compile.sh

#------------------------------------------------------------------------------
#
# `make shell` shell into build container
#
.PHONY: shell
shell: build
	$(BUILD_EXEC) /bin/bash

#------------------------------------------------------------------------------
#
# `make functest` functional test using binaries
#
#.PHONY: functest
functest: compile api
	./buildscripts/functest.sh

#------------------------------------------------------------------------------
#
# `make python` make python client wheel
#
.PHONY: python
python: build
	$(BUILD_EXEC) ./src/buildscripts/python.sh

#------------------------------------------------------------------------------
#
#
#.PHONY: artifacts
artifacts: functest python

#------------------------------------------------------------------------------
#
# docker dependencies
#
.env:
	./buildscripts/env.sh

.PHONY: remove_containers
remove_containers: remove_api remove_build

.PHONY: remove_api
remove_api: .env
	./buildscripts/remove_container.sh api

.PHONY: remove_base
remove_base: .env
	./buildscripts/remove_container.sh base

.PHONY: remove_build
remove_build: .env
	./buildscripts/remove_container.sh build

.PHONY: api
api: .$(API)_container

.PHONY: base
base: .$(BASE)_container

.PHONY: build
build: .$(BUILD)_container

.$(API)_container: .env Dockerfile-$(API) docker-compose.yaml
	./buildscripts/create_container.sh $(API)

.$(BASE)_container: .env Dockerfile-$(BASE) docker-compose.yaml
	./buildscripts/create_container.sh $(BASE)

.$(BUILD)_container: .env .$(BASE)_container Dockerfile-$(BUILD) docker-compose.yaml
	./buildscripts/create_container.sh $(BUILD)

