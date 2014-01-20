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

3. Add this tap (**TODO change this**):
  
  ```
  brew tap optimizers/<name-of-this-repo>
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

5. Now you can install `dolfin`:

  ```
  brew install dolfin --env=std --without-mpi
  ```
or with `mpi`
  ```
  brew install open-mpi petsc slepc
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
-- 
-- The following optional packages were not found:
-- -----------------------------------------------
-- (**) OPENMP
-- (**) PETSC4PY
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

- Although `petsc4py` is installed, `dolfin` cannot find it.

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
