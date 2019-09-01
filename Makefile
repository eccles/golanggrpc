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
# `$ make generated`
#
.PHONY: generated
generated: builder
	./buildscripts/generated.sh

#------------------------------------------------------------------------------
#
# `$ make check` statically check the code
#
.PHONY: check
check: generated
	./buildscripts/check.sh

#------------------------------------------------------------------------------
#
# `$ make unittest` execute any unittests
#
.PHONY: unittest
unittest: check
	./buildscripts/unittest.sh

#------------------------------------------------------------------------------
#
# `$ make compile` compile Golang code
#
.PHONY: compile
compile: unittest
	./buildscripts/compile.sh

#------------------------------------------------------------------------------
#
# `make shell` shell into builder container
#
.PHONY: shell
shell: builder
	./buildscripts/builder.sh /bin/bash

#------------------------------------------------------------------------------
#
# `make functest` functional test using binaries
#
.PHONY: functest
functest: compile api
	./buildscripts/functest.sh

#------------------------------------------------------------------------------
#
# `make python` make python client wheel
#
#.PHONY: python
#python: builder
#	./buildscripts/python.sh

#------------------------------------------------------------------------------
#
#
#artifacts: functest python
.PHONY: artifacts
artifacts: functest

#------------------------------------------------------------------------------
#
# docker dependencies
#
.PHONY: remove_containers
remove_containers:
	./buildscripts/remove_container.sh api builder

.PHONY: remove_api
remove_api:
	./buildscripts/remove_container.sh api

.PHONY: remove_base
remove_base: remove_builder
	./buildscripts/remove_container.sh base

.PHONY: remove_builder
remove_builder:
	./buildscripts/remove_container.sh builder

.PHONY: api
api: .api_container

.PHONY: base
base: .base_container

.PHONY: builder
builder: .base_container .builder_container

.api_container: Dockerfile-api docker-compose.yaml
	./buildscripts/create_container.sh api

.base_container: Dockerfile-base docker-compose.yaml
	./buildscripts/create_container.sh base

.builder_container: Dockerfile-builder docker-compose.yaml
	./buildscripts/create_container.sh builder

