require 'formula'

class Tao < Formula
  homepage 'http://www.mcs.anl.gov/research/projects/tao'
  url 'http://www.mcs.anl.gov/tao/download/tao-2.2-pre1.tar.gz'
  sha1 'e4b4790cf18d39f2b0b9810d3478163634fce66a'
  version '2.2'

  depends_on 'petsc' => :build  # TAO 2.2 depends on PETSc 3.4
  depends_on :fortran
  env :std  # Tests do not pass without this...

  def install
    ENV.deparallelize
    ENV['TAO_DIR'] = Dir.getwd
    ENV['PETSC_DIR'] = Formula.factory('petsc').prefix
    # Contrary to the TAO documentation,
    # it's important to leave PETSC_ARCH undefined.
    system "make all"
    system "make tao_testexamples"
    system "make tao_testfortran"
    ohai 'Test results are in ~/Library/Logs/Homebrew/tao. Please check them.'

    lib.install Dir['lib/*']
    include.install Dir['include/*.h']
    doc.install Dir['docs/*']
    prefix.install Dir['conf']
  end
end
