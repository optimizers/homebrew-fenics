# Build FEniCS from Scratch

A [Homebrew](http://brew.sh) tap to build [FEniCS](http://fenicsproject.org) on OSX (and perhaps Linux) relying on [pip](http://www.pip-installer.org).

## Install Homebrew

First install [Homebrew](http://brew.sh) itself
```bash
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
```

If you are using Linux, try [Linuxbrew](http://linuxbrew.sh):
```bash
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/linuxbrew/go/install)"
```

Then add the science, python and FEniCS taps
```bash
brew tap homebrew/science
brew tap homebrew/python
brew tap optimizers/homebrew-fenics
```

Either install `pip` for use with system Python using
```bash
sudo easy_install pip
```
or install Homebrew Python, which ships with `pip`:
```bash
brew install python
```

## Recommended: Create a virtual environment

First install `virtualenv` and `virtualenvwrapper` if you haven't already:
```bash
pip install virtualenv
pip install virtualenvwrapper
```

Configure virtualenvwrapper (see the [documentation](http://virtualenvwrapper.readthedocs.org/en/latest/)):
```bash
mkdir -p ~/.virtualenvs
export WORKON_HOME=$HOME/.virtualenvs >> ~/.bashrc
source /usr/local/bin/virtualenvwrapper.sh >> ~/.bashrc
```

Open a fresh terminal in order to activate the most recent settings. Then create a virtual environment and activate it:
```bash
mkvirtualenv fenics
workon fenics
```

## Install the Python dependencies

The Python dependencies require `mpi`, `petsc` and `slepc` already installed:
```bash
brew install mpi
brew install slepc  # will install petsc
```

The virtual environment is a good place to install the Python dependencies without interfering with your system folders.
```
PETSC_DIR=/usr/local/opt/petsc/real SLEPC_DIR=/usr/local/opt/slepc/real pip install mpi4py petsc4py slepc4py
```

3. Install `dolfin`:
  ```
  brew install dolfin
  ```

#### Included packages

With everything included (nothing excluded with `--without`) the following should be produced (use `brew install -v dolfin` to verify or check the build logs in `~/Library/Logs/Homebrew/dolfin`):

```no-highlight
-- The following optional packages were found:
-- -------------------------------------------
-- (OK) MPI
-- (OK) PETSC
-- (OK) PETSC4PY
-- (OK) SLEPC
-- (OK) SLEPC4PY
-- (OK) TRILINOS
-- (OK) PASTIX
-- (OK) SCOTCH
-- (OK) PARMETIS
-- (OK) ZLIB
-- (OK) PYTHON
-- (OK) SPHINX
-- (OK) HDF5
-- (OK) VTK
-- (OK) QT
--
-- The following optional packages were not enabled:
-- -------------------------------------------------
-- (--) OPENMP
--
-- The following optional packages were not found:
-- -----------------------------------------------
-- (**) UMFPACK
-- (**) CHOLMOD
```

#### Demos

Demos are included here:
```
/usr/local/opt/dolfin/share/dolfin/demo
```
