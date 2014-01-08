Installation notes
==================

- MPI appears to only work with `open-mpi` and not `mpich2`
- with `boost --with-mpi` the dolfin install need `--env=std`, which points to a path error with `superenv`
- the minimal install actually had this:
  ```
boost		cscope		fontconfig	hwloc		libpng		open-mpi	pkg-config	readline	swig		vtk
cgal		dolfin		freetype	instant		libtiff		ossp-uuid	postgresql	sip		szip		vtk5
cloog		eigen		gdbm		isl		macvim		parmetis	pyqt		sphinx		tbb		wget
cmake		ffc		gfortran	jpeg		metis		pastix		python		sqlite		ufc		zsh
cppunit		fiat		gmp		libmpc		mpfr		pcre		qt		suite-sparse	ufl
  ```
  which could be helpful to debug a fresh install
- and pip had
  ```
FFC (1.3.0)
FIAT (1.3.0)
instant (1.3.0)
ipython (1.1.0)
matplotlib (1.1.1)
mpi4py (0.6.0)
numpy (1.8.0)
petsc4py (0.7.2)
pip (1.5)
ply (3.4)
py (1.4.19)
ScientificPython (2.9.2)
scipy (0.13.2)
setuptools (2.0.2)
stevedore (0.13)
UFL (1.3.0)
vboxapi (1.0)
virtualenv (1.11)
virtualenv-clone (0.2.4)
virtualenvwrapper (4.1.1)
VTK (5.10.1)
wsgiref (0.1.2)
  ```
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
  then this installs the dependencies:
  ```
  Installing dependencies for dolfin: gmp, mpfr, libmpc, isl, cloog, gfortran, cmake, pcre, swig, cppunit, eigen, boost, ufc, fiat, ufl, ffc, instant
  ```
  and `suite-sparse`

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
