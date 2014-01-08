# Build FEniCS from Scratch

A simple script to build [FEniCS](http://fenicsproject.org) on OSX relying on [Homebrew](http://brew.sh) and [pip](http://www.pip-installer.org).

1. Install [Homebrew](http://brew.sh)
2. Create a virtual environment if you would like:
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
3. Clone this project and build:
    ```
    git clone https://github.com/dpo/fenics-from-scratch.git
    cd fenics-from-scratch
    sh build.sh
    ```
4. Go grab a cup of joe.
