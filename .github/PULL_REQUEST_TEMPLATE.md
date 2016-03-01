### Pull Request Checklist

- [ ] Check there aren't other open [Pull Requests](https://github.com/optimizers/homebrew-fenics/pulls) for the same update/change
- [ ] Run `brew audit --strict --online <formula>` (where `<formula>` is the name of the formula you're submitting) and correct all errors
- [ ] Build your formula locally prior to submission with `brew install <formula>`
- [ ] Write a sensible test if you are submitting a new formula.
- [ ] Check that the tests pass with `brew test <formula>`
