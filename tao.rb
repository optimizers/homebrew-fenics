require 'formula'

class Tao < Formula
  homepage 'http://www.mcs.anl.gov/research/projects/tao'
  url 'http://www.mcs.anl.gov/research/projects/tao/download/tao-2.1-p2.tar.gz'
  sha1 '5dcee962499aad9ccaa4ee968d96c70bdfb79955'
  version '2.1-p2'

  # TAO 2.1 depends on PETSc 3.3
  depends_on 'petsc' => :build
  depends_on :fortran
  env :std  # Tests do not pass without this...

  def install

    ENV['TAO_DIR'] = Dir.getwd
    ENV['PETSC_DIR'] = Formula.factory('petsc').prefix
    # Contrary to the TAO documentation, leave PETSC_ARCH undefined.
    system "make all"
    system "make tao_shared"
    system "make tao_testexamples"
    system "make tao_testfortran"
    ohai 'Test results are in ~/Library/Logs/Homebrew/tao. Please check them.'

    lib.install Dir['lib/*']
    include.install Dir['include/*.h']
    doc.install Dir['docs/*']
    prefix.install Dir['conf']
  end
end
