#------------------------------------------------------------------------------
#
# Requires make, docker-ce and docker-compose
#
# Entry points into the docker build image are correspondingly (for example):
#
# To prepare after cloning or pulling from upstream:
#
#     make builder
#
#------------------------------------------------------------------------------
#
# '$ make clean' - regenerate everything from scratch
.PHONY: all
all: clean artifacts

#------------------------------------------------------------------------------
#
# `make clean` cleans all generated files from container
#
.PHONY: clean
clean:
	./buildscripts/clean.sh

#------------------------------------------------------------------------------
#
# `$ make tools` - install additional tools
#
.PHONY: tools
tools:
	./buildscripts/tools.sh

#------------------------------------------------------------------------------
#
# `$ make generated` - generate auto-generated code
#
.PHONY: generated
generated:
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
unittest:
	./buildscripts/unittest.sh

#------------------------------------------------------------------------------
#
# `$ make compile` compile Golang code
#
.PHONY: compile
compile:
	./buildscripts/compile.sh

#------------------------------------------------------------------------------
#
# `make shell` shell into builder container
#
.PHONY: shell
shell:
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
artifacts: check unittest compile api

#------------------------------------------------------------------------------
#
# api docker images
#
.PHONY: remove_apis
remove_apis:
	./buildscripts/remove_container.sh api

.PHONY: remove_api
remove_api:
	./buildscripts/remove_container.sh api

.PHONY: api
api: Dockerfile-api docker-compose.yaml
	./buildscripts/create_container.sh api

#------------------------------------------------------------------------------
#
# builder images
#
.PHONY: base
base: Dockerfile-base docker-compose.yaml
	./buildscripts/create_container.sh base

.PHONY: builder
builder: base Dockerfile-builder docker-compose.yaml
	./buildscripts/create_container.sh builder

.PHONY: purge
purge:
	./buildscripts/remove_container.sh builder
	./buildscripts/remove_container.sh base
	./buildscripts/purge.sh

.PHONY: remove_base
remove_base: remove_builder
	./buildscripts/remove_container.sh base

.PHONY: remove_builder
remove_builder:
	./buildscripts/remove_container.sh builder

