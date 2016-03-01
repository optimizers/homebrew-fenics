# Troubleshooting

##### `Fatal Python error: PyThreadState_Get: no current thread`

You are mixing two Python interpreters. For instance, your virtual environment uses a different Python interpreter than the one used to build the dependencies. See the [Homebrew recommendations](https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Common-Issues.md#python-segmentation-fault-11-on-import-some_python_module).

To ensure all dependencies and the virtual environment use the Python interpreter shipped with the OS, start from a clean slate (see below) and make sure `which python` returns `/usr/bin/python`. If Homebrew Python is installed, you will have to `brew unlink python`.

The document [`Homebrew-and-Python`](https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Homebrew-and-Python.md) explains how Homebrew works with Python.

#### Checking for common issues

Check the general Homebrew [troubleshooting](https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Troubleshooting.md).

Inspect the output of `brew doctor`. Not everything reported there is a problem but there might be conflicts, especially if you also have packages installed with MacPorts or Fink.

#### Starting from a clean slate

All Dolfin dependencies can be uninstalled with
```
brew uninstall $(brew deps --recursive dolfin)
```

#### Poking around in case of a build error

If you encounter a build error (most likely with `dolfin`), rebuild with `brew install -vd dolfin`. When the build error occurs, you will be presented with an option to drop to a shell. There, you will be able to look around and inspect the source tree, the partial build, the CMake error logs, etc. Type `exit` to return to your normal shell.

#### Filing an issue

If nothing gives, feel free to [file an issue](https://github.com/optimizers/homebrew-fenics/issues). If there was a build error, please post the output of `brew gist-logs <formula>` where `<formula>` is the name of the formula that failed to build (presumably `dolfin`).
