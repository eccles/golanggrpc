#!/bin/sh -ex
# 
# make wheel package
#
PYTHON=python3
SETUP="${PYTHON} setup.py"
${SETUP} bdist_wheel
ls -l dist
