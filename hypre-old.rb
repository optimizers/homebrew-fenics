require "formula"

class Hypre < Formula
  homepage "http://computation.llnl.gov/casc/hypre"
  url "https://computation.llnl.gov/casc/hypre/download/hypre-2.9.1a.tar.gz"
  sha1 "62f6beb8e28046a6a8f2afcbe286f64afcf79aa5"

  depends_on :mpi => [:cc, :f90]

  def install
    cd 'src' do
      system "./configure", "--with-blas=yes",
                            "--with-lapack=yes",
                            "--without-babel",
                            "--without-mli",
                            "--without-fei",
                            "--without-superlu",
                            "--prefix=#{prefix}"
      system "make", "install"
    end
  end

end
