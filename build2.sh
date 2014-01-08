#!/bin/bash

# Save these environment variables if they were set
[[ ${PETSC_DIR+set}  == 'set' ]] && PETSC_DIR_BKUP=$PETSC_DIR
[[ ${PETSC_ARCH+set} == 'set' ]] && PETSC_ARCH_BKUP=$PETSC_ARCH
[[ ${SLEPC_DIR+set}  == 'set' ]] && SLEPC_DIR_BKUP=$SLEPC_DIR
[[ ${TAO_DIR+set}    == 'set' ]] && TAO_DIR_BKUP=$TAO_DIR
unset PETSC_DIR PETSC_ARCH SLEPC_DIR TAO_DIR

# add the homebrew-science tap
# TODO add to instructions
brew tap homebrew/science

# Ensure we have Python
# TODO shouldn't the depends get this?
brew install python

# PLY (required for Swig)
pip install ply

# SPHINX
# TODO now in brew
# TODO apparently sphinx needs a db
# TODO are any of the post-install instuctions needed for postgresql
brew install sphinx
brew install postgresql

brew install swig
brew install boost --with-mpi --without-single --build-from-source
brew install armadillo

# TODO does cgal need shared?
brew install cgal
# TODO dorsal build of hdf5 has many options...are they neededd?
brew install hdf5 --enable-parallel

# TODO uses special 3.4.3 build
brew install petsc

pip install mpi4py
pip install numpy
pip install scipy
brew install freetype
pip install matplotlib
PETSC_DIR=$(brew --prefix petsc) PETSC_ARCH='arch-darwin-c-opt' pip install petsc4py

brew install parmetis

brew install qt

brew install scotch
brew install pastix

# TODO uses special 3.4.3 build
brew install slepc
# TODO slepc4py is broken
SLEPC_DIR=$(brew --prefix slepc) pip install slepc4py

brew install sphinx

# TODO skipping tao for now
brew install tao
TAO_DIR=$(brew --prefix tao) pip install tao4py  # Not strictly necessary.

#brew install vtk --with-qt --with-python
# TODO change to
brew install vtk5 --with-qt --with-python


# ! The trilinos formula has been patched.
# TODO this is still broken.  tried
# https://github.com/kmlee/homebrew-science/blob/trilinos-11.4.2/trilinos.rb
brew install trilinos --with-boost --with-scotch

brew install suite-sparse

# TODO MTL no-go
brew install cppunit

#2. Install FEniCS.
brew install --HEAD ufc
brew install --HEAD dolfin --env=std

# ufl:
pip install https://bitbucket.org/fenics-project/ufl/downloads/ufl-1.3.0.tar.gz
#
pip install https://sourcesup.renater.fr/frs/download.php/4153/ScientificPython-2.9.2.tar.gz
# fiat:
pip install https://bitbucket.org/fenics-project/fiat/downloads/fiat-1.3.0.tar.gz

# FFC
pip install https://bitbucket.org/fenics-project/ffc/downloads/ffc-1.3.0.tar.gz

## INSTANT
pip install https://bitbucket.org/fenics-project/instant/downloads/instant-1.3.0.tar.gz

# Restore these environment variables if they were set
[[ ${PETSC_DIR_BKUP+set}  == 'set' ]] && export PETSC_DIR=$PETSC_DIR_BKUP
[[ ${PETSC_ARCH_BKUP+set} == 'set' ]] && export PETSC_ARCH=$PETSC_ARCH_BKUP
[[ ${SLEPC_DIR_BKUP+set}  == 'set' ]] && export SLEPC_DIR=$SLEPC_DIR_BKUP
[[ ${TAO_DIR_BKUP+set}    == 'set' ]] && export TAO_DIR=$TAO_DIR_BKUP
