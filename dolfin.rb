require 'formula'

class Dolfin < Formula
  homepage 'https://bitbucket.org/fenics-project/dolfin'
  url 'https://bitbucket.org/fenics-project/dolfin/downloads/dolfin-1.3.0.tar.gz'
  sha1 'af1a3fe0798df54a563fe0e616a3da08f0c5e6fa'

  depends_on :fortran
  depends_on :python
  depends_on 'numpy' => :python
  depends_on 'ply' =>:python
  depends_on 'cmake' => :build
  depends_on 'pkg-config' => :build
  depends_on 'swig' => :build
  depends_on 'cppunit' => :build
  depends_on 'boost' => ['--without-single']

  #depends_on :mpi => [:cc, :cxx, :f90]

  def install
    if ENV.compiler == :clang
      opoo 'OpenMP support will not be enabled. Use --use-gcc if you require OpenMP.'
    end

    ENV.deparallelize
    # ENV['PETSC_DIR'] = Formula.factory('petsc').prefix
    # ENV['PETSC_ARCH'] = 'arch-darwin-c-opt'
    # ENV['SCOTCH_DIR'] = Formula.factory('scotch').prefix
    # ENV['PASTIX_DIR'] = Formula.factory('pastix').prefix
    # ENV['SLEPC_DIR'] = '/usr/local/opt/slepc'
    # ENV['PARMETIS_DIR'] = Formula.factory('parmetis').prefix
    # #ENV['TAO_DIR'] = Formula.factory('tao').prefix
    # ENV['CPPUNIT_DIR'] = Formula.factory('cppunit').prefix
    # ENV['CGAL_DIR'] = Formula.factory('cgal').prefix

    # This is necessary to discover CGAL.
    #ENV.append_to_cflags '-frounding-math'

    mkdir 'build' do
      system 'cmake', '..', *std_cmake_args
      system 'make'
      system 'make', 'install'
    end
  end
end
