require 'formula'

class Slepc < Formula
  homepage 'http://www.grycap.upv.es/slepc'
  url 'http://www.grycap.upv.es/slepc/download/download.php?filename=slepc-3.4.2.tar.gz'
  sha1 '38b384b22eeced67c85868a8f57d3c8f6514bc86'
  version '3.4.2'

  depends_on 'petsc' => :build
  depends_on :mpi => [:cc, :f90]
  depends_on :fortran
  depends_on :x11

  def install
    ENV.deparallelize
    ENV['SLEPC_DIR'] = Dir.getwd
    ENV['PETSC_DIR'] = Formula.factory('petsc').prefix
    system "./configure", "--prefix=#{prefix}"
    system "make PETSC_ARCH=arch-installed-petsc"
    system "make PETSC_ARCH=arch-installed-petsc install"
    system "make SLEPC_DIR=#{prefix} test"
  end
end
