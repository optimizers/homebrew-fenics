# Build FEniCS from Scratch

A simple script to build [FEniCS](http://fenicsproject.org) on OSX relying on [Homebrew](http://brew.sh) and [pip](http://www.pip-installer.org).

1. Install [Homebrew](http://brew.sh)
2. Create a virtual environment if you would like:
    ````
    # Install virtualenv and virtualenvwrapper if you haven't already
    brew install virtualenv
    brew install virtualenvwrapper

    # Configure virtualenvwrapper if you haven't already
    # see http://virtualenvwrapper.readthedocs.org/en/latest/
    export WORKON_HOME=~/.virtualenvs
    mkdir -p $WORKON_HOME

    # Create a virtualenv and activate it
    mkvirtualenv fenics
    workon fenics
    ````
3. Clone this project and build:
    ````
    git clone ...
    cd fenics-from-scratch
    sh build.sh
    ````
4. Go grab a cup of joe.
