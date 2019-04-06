#!/bin/sh
# 
# make wheel package
#
set -e
PYTHON=python3
SETUP="${PYTHON} setup.py"
${SETUP} bdist_wheel
ls -l dist
