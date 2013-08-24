#!/bin/bash

# Ensure we have Python
brew install python

# Pip stuff.
pip install ffc

#   `pip install fiat` currently fails.
#   For the time being, grab FIAT from BitBucket.
pip install -e git+https://bitbucket.org/fenics-project/fiat.git#egg=fiat
pip install instant
pip install ufl

# Homebrew stuff.
# 1. Prerequisites
brew install swig
brew install boost --with-mpi --without-single

brew tap homebrew/science
brew install armadillo
brew install cgal
brew install petsc
brew install scotch

#2. Install FEniCS.
brew install ufc
brew install dolfin
