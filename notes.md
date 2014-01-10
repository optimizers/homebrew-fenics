Installation notes
==================

- MPI appears to only work with `open-mpi` and not `mpich2`

- the dolfin install needs `--env=std`, which points to a path error with `superenv`

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

- `tao` does not work

- add?
```
source /usr/local/Cellar/dolfin/1.3.0/share/dolfin/dolfin.conf
```

- can't find petsc4py.  this may be a path thing
