require 'formula'

class Dolfin < Formula
  homepage 'https://bitbucket.org/fenics-project/dolfin'
  url ''
  head 'https://bitbucket.org/fenics-project/dolfin.git'

  depends_on :mpi => [:cc, :cxx, :f90]

  # List all dependencies explicitly for completeness.
  depends_on 'boost'     => ['--with-mpi', '--without-single']
  depends_on 'armadillo' => :build
  depends_on 'cgal'      => :build
  depends_on 'parmetis'  => :build
  depends_on 'swig'      => :build
  depends_on 'cmake'     => :build
  depends_on 'petsc'     => :build
  depends_on 'slepc'     => :build
  depends_on 'scotch'    => :build    # Must be Scotch >= 6
  depends_on 'pastix'    => :build
  depends_on 'tao'       => :build
  depends_on 'trilinos'  => ['--with-boost', '--with-scotch']
  depends_on 'mtl'       => :build
  depends_on 'cppunit'   => :build
  depends_on 'hdf5'      => 'enable-parallel'
  depends_on 'suite-sparse' => :build
  depends_on 'qt'        => :build
  depends_on 'vtk'       => ['--with-qt', '--with-python']
  depends_on 'sphinx'    => :build

  depends_on :fortran
  depends_on :python

  def install
    if ENV.compiler == :clang
      opoo 'OpenMP support will not be enabled. Use --use-gcc if you require OpenMP.'
    end

    # ENV.j1  # if your formula's build system can't parallelize
    ENV['PETSC_DIR'] = Formula.factory('petsc').prefix
    ENV['PETSC_ARCH'] = 'arch-darwin-c-opt'
    ENV['SCOTCH_DIR'] = Formula.factory('scotch').prefix
    ENV['PASTIX_DIR'] = Formula.factory('pastix').prefix
    ENV['SLEPC_DIR'] = Formula.factory('slepc').prefix
    ENV['PARMETIS_DIR'] = Formula.factory('parmetis').prefix
    ENV['TAO_DIR'] = Formula.factory('tao').prefix
    ENV['CPPUNIT_DIR'] = Formula.factory('cppunit').prefix
    ENV['CGAL_DIR'] = Formula.factory('cgal').prefix

    # This is necessary to discover CGAL.
    ENV.append_to_cxxflags "-frounding-math"

    mkdir 'build' do
      system "cmake", "..", *std_cmake_args
      system "make"
    end
  end
end
