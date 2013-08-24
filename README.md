# Build-FEniCS

A simple script to build [FEniCS](http://fenicsproject.org) on OSX relying on
[Homebrew](http://brew.sh) and [pip](http://www.pip-installer.org).

1. Install [Homebrew](http://brew.sh)
2. Clone this project:

    git clone ...

3. Create a virtual environment if you would like:

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

