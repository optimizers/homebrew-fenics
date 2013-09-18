require 'formula'

class Dolfin < Formula
  homepage 'https://bitbucket.org/fenics-project/dolfin'
  url ''
  head 'https://bitbucket.org/fenics-project/dolfin.git'
  version '1357c06'

  # depends_on 'metis'    => :build
  depends_on 'parmetis' => :build
  depends_on 'swig'     => :build
  depends_on 'cmake'    => :build
  depends_on 'petsc'    => :build
  # depends_on 'scotch5'  => :build
  depends_on 'scotch'   => :build    # Must be Scotch >= 6
  depends_on 'pastix'   => :build
  depends_on 'mtl'      => :build
  depends_on 'cppunit'  => :build
  depends_on 'hdf5'     => 'enable-parallel'

  depends_on :fortran
  depends_on :python

  def install
    # ENV.j1  # if your formula's build system can't parallelize
    ENV['PETSC_DIR'] = Formula.factory('petsc').prefix
    ENV['SCOTCH_DIR'] = Formula.factory('scotch5').prefix
    ENV['PASTIX_DIR'] = Formula.factory('pastix').prefix
    ENV['SLEPC_DIR'] = Formula.factory('slepc').prefix
    ENV['PARMETIS_DIR'] = Formula.factory('parmetis').prefix
    ENV['TAO_DIR'] = Formula.factory('tao').prefix
    ENV['CPPUNIT_DIR'] = Formula.factory('cppunit').prefix
    ENV['CGAL_DIR'] = Formula.factory('cgal').prefix

    # This seems necessary to find omp.h
    ENV.append_to_cflags "-I#{Formula.factory('metis').include}"

    # This is necessary to discover CGAL.
    ENV.append_to_cxxflags "-frounding-math"

    mkdir 'build' do
      system "cmake", "..", *std_cmake_args
      system "make", "install" # if this fails, try separate make/make install steps
    end
  end
end
