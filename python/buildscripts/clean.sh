#!/bin/sh
# 
# returns python3 repo to pristine state
#
find -name '*,cover' -delete
find -depth -name '__pycache__' -type d -exec rm -rf {} \; -print
find -name '.coverage' -delete
find -name '*.py[cod]' -delete
find -name '__pycache__' -exec rm -rf {} \;

rm -rf build/ \
       dist/ \
       *.egg-info/
