#!/bin/bash

# Ensure we have Python
brew install python

# Pip stuff.

## FFC
#pip install ffc
pip install git+https://bitbucket.org/fenics-project/ffc.git

## FIAT
# FIAT requires ScientificPython, though it doesn't say anywhere...
pip install https://sourcesup.renater.fr/frs/download.php/4153/ScientificPython-2.9.2.tar.gz

#   `pip install fiat` currently fails.
#   For the time being, grab FIAT from BitBucket.
pip install git+https://bitbucket.org/fenics-project/fiat.git

## INSTANT
#pip install instant
pip install git+https://bitbucket.org/fenics-project/instant.git

## UFL
# pip install ufl
pip install git+https://bitbucket.org/fenics-project/ufl.git

## PLY (required to Swig stuff.)
pip install ply

## SPHINX
pip install sphinx

# Homebrew stuff.
# 1. Prerequisites
brew install swig
brew install boost --with-mpi --without-single

brew tap homebrew/science
brew install armadillo
brew install cgal
brew install hdf5 --enable-parallel

brew install petsc
export PETSC_DIR=`brew --prefix petsc`
export PETSC_ARCH='arch-installed-petsc'
pip install petsc4py

brew install parmetis

brew install qt

#brew install https://raw.github.com/michaelwimmer/homebrew-science/e1806b4a754ef0575da2d798be6cce2f222c1bb8/scotch5.rb
brew install scotch
brew install pastix

brew install slepc
export SLEPC_DIR=`brew --prefix slepc`
pip install slepc4py

brew install sphinx

brew install tao
export TAO_DIR=`brew --prefix tao`
pip install tao4py

brew install vtk --with-qt --with-python

# ! The trilinos formula has been patched.
brew install trilinos --with-boost --with-scotch

#2. Install FEniCS.
brew install ufc
#brew install dolfin
