#
BASEDIR := $(shell basename `pwd` )
PREFIX := $(BASEDIR)${BUILDID}

DOCKER_COMPOSE := docker-compose -p $(PREFIX)
export DOCKER := $(DOCKER_COMPOSE) -f docker-compose.yaml

export BUILDER ?= alpine
API := $(BUILDER)api
BASE := $(BUILDER)base

DOCKER_EXEC := $(DOCKER) exec -T $(BUILDER)

export IMGNAME := ${PREFIX}_${BUILDER}

# No C dependencies so compile natively
export CGO_ENABLED := 0

#------------------------------------------------------------------------------
#
#
# Requires docker-ce and docker-compose
#
# Entry points into the docker build image are correspondingly (for example):
#
# Dependencies:
#
#     unittest_local -> _check_local
#     package_local -> _check_local
#
# To start from scratch
#
#     make remove_container
#     make clean
#
# Do not make any _local targets on your development environment. They are
# only for internal use by the make system.
#
#------------------------------------------------------------------------------

.PHONY: all
all: remove_container clean artifacts

#------------------------------------------------------------------------------
#
# `make clean` cleans all generated files from container
#
.PHONY: _clean_local
_clean_local:
	./buildscripts/clean.sh

.PHONY: clean
clean: .$(BUILDER)_container
	time $(DOCKER_EXEC) make _clean_local

#------------------------------------------------------------------------------
#
# `$ make dependencies`
#
.PHONY: _dependencies_local
_dependencies_local:
	./buildscripts/dependencies.sh

.PHONY: dependencies
dependencies: .$(BUILDER)_container
	time $(DOCKER_EXEC) make _dependencies_local

#------------------------------------------------------------------------------
#
# `$ make check` statically check the code
#
.PHONY: _check_local
_check_local: _dependencies_local
	./buildscripts/check.sh

.PHONY: check
check: .$(BUILDER)_container
	time $(DOCKER_EXEC) make _check_local

#------------------------------------------------------------------------------
#
# `$ make compile` compile Golang code
#
.PHONY: _compile_local
_compile_local: _check_local
	./buildscripts/compile.sh

.PHONY: compile
compile: .$(BUILDER)_container
	time $(DOCKER_EXEC) make _compile_local

#------------------------------------------------------------------------------
#
# `$ make unittest` execute any unittests
#
.PHONY: _unittest_local
_unittest_local: _compile_local
	./buildscripts/unittest.sh

.PHONY: unittest
unittest: .$(BUILDER)_container
	time $(DOCKER_EXEC) make _unittest_local

#------------------------------------------------------------------------------
#
## `$ make functest` functional test using binaries
#
#.PHONY: functest
functest: unittest .$(API)_container
	time $(DOCKER_EXEC) ./buildscripts/functest.sh
	docker logs $(IMGNAME)api_1

#------------------------------------------------------------------------------
#
# `$ make python` make python client wheel
#
.PHONY: _python_local
_python_local: _unittest_local
	./buildscripts/python.sh

.PHONY: python
python: .$(BUILDER)_container
	time $(DOCKER_EXEC) make _python_local

#------------------------------------------------------------------------------
#
#
#.PHONY: artifacts
artifacts: functest python

#------------------------------------------------------------------------------
#
# docker dependencies
#
.PHONY: remove_container
remove_container:
	./buildscripts/remove_container.sh api

.PHONY: remove_base
remove_base:
	./buildscripts/remove_container.sh base

.$(API)_container: Dockerfile-$(API) docker-compose.yaml
	./buildscripts/create_container.sh api

.$(BASE)_container: Dockerfile-$(BASE) docker-compose.yaml
	./buildscripts/create_container.sh base

.$(BUILDER)_container: .$(BASE)_container Dockerfile-$(BUILDER) docker-compose.yaml
	./buildscripts/create_container.sh

