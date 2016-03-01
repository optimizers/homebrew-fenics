### New Issue Checklist

- [ ] Run `brew update` and try again your prior steps
- [ ] Run `brew doctor`, fix as many issues as possible and try again your prior steps
- [ ] Check that a similar issue [hasn't already been filed](https://github.com/optimizers/homebrew-fenics/issues)
- [ ] Check [`TROUBLESHOOTING.md`](https://github.com/optimizers/homebrew-fenics/blob/master/TROUBLESHOOTING.md)
- [ ] Look up the relevant [FEniCS bug tracker](https://bitbucket.org/fenics-project) and [mailing list](https://groups.google.com/forum/#!forum/fenics-support) if reporting a build error
- [ ] If you're seeing permission errors try running `sudo chown -R $(whoami) $(brew --prefix)`?

### Bug reports / build errors:

_Erase any parts of this template not applicable to your Issue._

- Brief summary of issue:
- Please state the complete command that you issued.
- Please do not post lengthy build output here. Instead provide a link to a gist.
- If reporting a build failure paste the output of `brew gist-logs <formula>` (where `<formula>` is the name of the formula that failed to build).
