require 'formula'

class Slepc < Formula
  homepage 'http://www.grycap.upv.es/slepc'
  url 'https://bitbucket.org/slepc/slepc/get/v3.3.tar.bz2'
  sha1 '32c34c663fcdea6d8852662451c08dc41ecebc27'
  version '3.3'

  depends_on 'petsc' => :build
  depends_on :mpi => :cc
  depends_on :fortran
  env :std  # Build fails without this

  def install
    ENV['SLEPC_DIR'] = Dir.getwd
    ENV['PETSC_DIR'] = Formula.factory('petsc').prefix
    system "./configure",
      "--prefix=#{prefix}"
    system "make PETSC_ARCH=arch-installed-petsc"
    system "make install PETSC_ARCH=arch-installed-petsc"
  end
end
