# Build FEniCS from Scratch

A simple script to build [FEniCS](http://fenicsproject.org) on OSX relying on [Homebrew](http://brew.sh) and [pip](http://www.pip-installer.org).


1. Install [Homebrew](http://brew.sh):
  
  ```
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
  ```
2. Add the science, python, and versions taps
  
  ```
  brew tap homebrew/science
  brew tap homebrew/python
  brew tap homebrew/versions
  ```

3. Add this tap (**TODO will change**):
  
  ```
  brew tap lukeolson/fenics
  ```

3. Install the python from brew:

  ```
  brew install python
  brew linkapps
  ```

4. Install `numpy` and `ply` with `pip`:

  ```
  pip install numpy
  pip install ply
  ```
5. Install `mpi` and `petsc` and other packages:
  ```
  brew install open-mpi 
  brew install lukeolson/fenics/petsc --env=std
  brew install slepc
  pip install mpi4py
  export PETSC_DIR=/usr/local/Cellar/petsc/3.4.4
  export PETSC_ARCH=arch-darwin-c-opt
  pip install petsc4py
  ```

  note: if you've installed petsc (or tried to) before, then
  ```
  brew link petsc --overwrite
  ```
  may be necessary

5. Now you can install `dolfin` (**TODO will change**):
  ```
  brew install dolfin --env=std
  ```

## Some comments on `dolfin.rb.`

#### Included packages

With everything included (nothing excluded with `--without`) the following should be produced (use the `-v` option to verify):
```no-highlight
-- The following optional packages were found:
-- -------------------------------------------
-- (OK) MPI
-- (OK) PETSC
-- (OK) SLEPC
-- (OK) UMFPACK
-- (OK) CHOLMOD
-- (OK) PASTIX
-- (OK) SCOTCH
-- (OK) PARMETIS
-- (OK) CGAL
-- (OK) ZLIB
-- (OK) PYTHON
-- (OK) HDF5
-- (OK) VTK
-- (OK) QT
-- (OK) PETSC4PY
-- 
-- The following optional packages were not found:
-- -----------------------------------------------
-- (**) OPENMP
-- (**) TAO
-- (**) TRILINOS
-- (**) SPHINX
```
#### Demos

Demos are included here:
```
/usr/local/Cellar/dolfin/1.3.0/share/dolfin/demo
```

#### Issues

There are several outstanding issues:

- Relying on `depends_on slepc` to install `slepc` has path issues.

- MPI works with `open-mpi`.  There are issues, possibly with Boost, with `mpich2`.

- To build with `petsc`, `dolfin` install needs `--env=std`.  This indicates a path error with `superenv`.

- Within the formula, `depends_on vtk5` does not install `sip` and `pyqt`, which are dependencies.  This is a bug with `vtk5`, thus the work-around here.

- Currently `tao` does not work.  There is an issue with the installation of the `lib`.

- The `PATH` should work with `dolfin`, but this is an option if it does not:
```
source /usr/local/Cellar/dolfin/1.3.0/share/dolfin/dolfin.conf
```

- With `sphinx` installed, `dolfin` cannot find it.

- Currently, `trilinos` does not work.

## To create a virtual environment

1. Install virtualenv and virtualenvwrapper if you haven't already
    ```
    pip install virtualenv
    pip install virtualenvwrapper
    ```
2. Configure virtualenvwrapper (see the [documentation](http://virtualenvwrapper.readthedocs.org/en/latest/)).
    Create the directory:
    ```
    mkdir -p $HOME/.virtualenvs
    ```
    Then add the foolowing to your shell rc-file:
    ```
    export WORKON_HOME=$HOME/.virtualenvs
    source /usr/local/bin/virtualenvwrapper.sh
    ```
    Now create a virtualenv and activate
    ```
    mkvirtualenv fenics
    workon fenics
    ```

## old build script:

    ```
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
  ```
