#
BASEDIR := $(shell basename `pwd` )
PREFIX := $(BASEDIR)${BUILDID}

#------------------------------------------------------------------------------
#
.PHONY: all
all:  clean artifacts

#------------------------------------------------------------------------------
#
# `$ make dependencies` 
#
.PHONY: dependencies
dependencies:
	./buildscripts/dependencies.sh

#------------------------------------------------------------------------------
#
# `$ make wheel` makes wheel
#
.PHONY: wheel
wheel: dependencies
	./buildscripts/wheel.sh

#------------------------------------------------------------------------------
#
# make artifacts
#
.PHONY: artifacts
artifacts: wheel

#------------------------------------------------------------------------------
#
# make clean
#
.PHONY: clean
clean:
	./buildscripts/clean.sh
