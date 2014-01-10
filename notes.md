Installation notes
==================

- MPI appears to only work with `open-mpi` and not `mpich2`
- the dolfin install may need `--env=std`, which points to a path error with `superenv`
- steps from fresh:
  ```
  brew tap homebrew/science
  brew install python
  brew linkapps
  pip install numpy
  pip install ply
  ```
  then
  ```
  brew install dolfin
  ```
  then this installs the dependencies.
  ```
- for some reason `depends_on vtk5` does not install `sip` and `pyqt` which are dependencies

- for dependencies:

  - first MPI
  - next mpi4py

  - next parmetis
  - next hdf5
  
  - next petsc
  - next petsc4py

  - next scotch
  - next pastix

  - next slepc
  - next tao

- where is armadillo used?

- add sphinx, postgresql last

- add?
```
source /usr/local/Cellar/dolfin/1.3.0/share/dolfin/dolfin.conf
```
