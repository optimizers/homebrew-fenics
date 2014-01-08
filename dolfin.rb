require 'formula'

class Dolfin < Formula
  homepage 'https://bitbucket.org/fenics-project/dolfin'
  url 'https://bitbucket.org/fenics-project/dolfin/downloads/dolfin-1.3.0.tar.gz'
  sha1 'af1a3fe0798df54a563fe0e616a3da08f0c5e6fa'

  depends_on :fortran
  depends_on :python

  depends_on 'suite-sparse'
  depends_on 'eigen'
  depends_on 'cgal' => :recommended

  depends_on 'cmake' => :build
  depends_on 'cppunit' => :build
  depends_on 'pkg-config' => :build
  depends_on 'swig' => :build

  depends_on 'numpy' => :python
  depends_on 'ply' =>:python

  depends_on :mpi => :optional

  if build.with? 'mpi'
    depends_on :mpi => [:cc, :cxx, :f90]
    depends_on 'boost' => ['--without-single', '--with-mpi']
  else
    depends_on 'boost' => ['--without-single']
  end

  option 'with-plotting', 'add plotting'

  if build.with? 'plotting'
    puts 'HERE'
    depends_on 'sip'
    depends_on 'pyqt'
    depends_on 'vtk5' => 'with-qt'
  end

  depends_on 'ufc'
  depends_on 'fiat'
  depends_on 'ufl'
  depends_on 'ffc'
  depends_on 'instant'

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
