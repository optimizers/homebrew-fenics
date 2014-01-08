# Build FEniCS from Scratch

A simple script to build [FEniCS](http://fenicsproject.org) on OSX relying on [Homebrew](http://brew.sh) and [pip](http://www.pip-installer.org).


1. Install [Homebrew](http://brew.sh):
  ```
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
  ```
2. Add the `homebrew/science` tap:
  ```
  brew tap homebrew/science
  ```
3. Add this tap (**TODO change this**):
  ```
  brew tap lukeolson/fenics-from-scratch
  ```
3. Install the python from brew:
  ```
  brew tap homebrew/science
  brew install python
  ```
4. Install `numpy` and `ply` with `pip`:
  ```
  pip install numpy
  pip install ply
  ```
5. Now you can install `dolfin`:
  ```
  brew install dolfin
  ```

## Some options:

### To create a virtual environment

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
