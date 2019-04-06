# -*- coding: utf-8 -*-
"""
ec_golanggrpc
"""

from collections import namedtuple
import os
import re
from setuptools import setup, find_packages

from ec_golanggrpc import about

NAME = open('name', 'rt').read().strip()
DESC = open('README.md').read()

setup(
    name=NAME,
    version=about.__version__,
    author=about.__author__,
    author_email=about.__author_email__,
    platforms=['linux', ],
    description=about.__description__,
    long_description=DESC,
    packages=find_packages(exclude=['build']),
    install_requires=['grpcio', 'protobuf'],
)
