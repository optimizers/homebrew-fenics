#!/bin/bash

# Save these environment variables if they were set
[[ ${PETSC_DIR+set}  == 'set' ]] && PETSC_DIR_BKUP=$PETSC_DIR
[[ ${PETSC_ARCH+set} == 'set' ]] && PETSC_ARCH_BKUP=$PETSC_ARCH
[[ ${SLEPC_DIR+set}  == 'set' ]] && SLEPC_DIR_BKUP=$SLEPC_DIR
[[ ${TAO_DIR+set}    == 'set' ]] && TAO_DIR_BKUP=$TAO_DIR
unset PETSC_DIR PETSC_ARCH SLEPC_DIR TAO_DIR

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
pip install mpi4py
PETSC_DIR=$(brew --prefix petsc) PETSC_ARCH='arch-darwin-c-opt' pip install petsc4py

brew install parmetis

brew install qt

brew install scotch
brew install pastix

brew install slepc
SLEPC_DIR=$(brew --prefix slepc) pip install slepc4py

brew install sphinx

brew install tao
TAO_DIR=$(brew --prefix tao) pip install tao4py  # Not strictly necessary.

brew install vtk --with-qt --with-python

# ! The trilinos formula has been patched.
brew install trilinos --with-boost --with-scotch

#2. Install FEniCS.
brew install --HEAD ufc
#brew install dolfin

# Restore these environment variables if they were set
[[ ${PETSC_DIR_BKUP+set}  == 'set' ]] && export PETSC_DIR=$PETSC_DIR_BKUP
[[ ${PETSC_ARCH_BKUP+set} == 'set' ]] && export PETSC_ARCH=$PETSC_ARCH_BKUP
[[ ${SLEPC_DIR_BKUP+set}  == 'set' ]] && export SLEPC_DIR=$SLEPC_DIR_BKUP
[[ ${TAO_DIR_BKUP+set}    == 'set' ]] && export TAO_DIR=$TAO_DIR_BKUP
