require 'formula'

class Dolfin < Formula
  homepage 'https://bitbucket.org/fenics-project/dolfin'
  url 'https://bitbucket.org/fenics-project/dolfin/downloads/dolfin-1.4.0.tar.gz'
  sha1 'b58cb5e4aaef0825ded1237ba6012d7aee63c152'

  depends_on :fortran
  depends_on :python

  depends_on 'suite-sparse'
  depends_on 'eigen'

  depends_on 'cmake' => :build
  depends_on 'cppunit' => :build
  depends_on 'pkg-config' => :build
  depends_on 'swig' => :build

  depends_on 'numpy' => :python
  depends_on 'ply' => :python

  depends_on :mpi => [:cc, :cxx, :f90, :recommended]

  depends_on 'petsc-fenics' => :recommended if build.with? :mpi
  depends_on 'slepc' => :recommended if build.with? :mpi
  depends_on 'scotch' => :recommended if build.with? :mpi
  depends_on 'pastix' => :recommended if build.with? :mpi

  depends_on 'parmetis' => :recommended if build.with? :mpi
  depends_on 'hdf5' => ['enable-parallel', :recommended] if build.with? :mpi
  depends_on 'boost' => ['without-single', 'with-mpi'] if build.with? :mpi

  if build.without? :mpi
    depends_on 'boost' => ['--without-single']
  end

  depends_on 'vtk' => ['--with-qt']

  depends_on 'fiat'
  depends_on 'ufl'
  depends_on 'ffc'
  depends_on 'instant'

  def install
    if ENV.compiler == :clang
      opoo 'OpenMP support will not be enabled. Use --use-gcc if you require OpenMP.'
    end

    ENV.deparallelize
    ENV['PETSC_DIR'] = Formula.factory('petsc-fenics').prefix
    ENV['PETSC_ARCH'] = 'arch-darwin-c-opt'
    ENV['PARMETIS_DIR'] = Formula['parmetis'].prefix
    ENV['AMD_DIR'] = Formula['suite-sparse'].prefix
    ENV['CHOLMOD_DIR'] = Formula['suite-sparse'].prefix
    ENV['UMFPACK_DIR'] = Formula['suite-sparse'].prefix

    # ENV['SLEPC_DIR'] = Formula.factory('slepc').prefix
    # ENV['TAO_DIR'] = Formula['tao'].prefix
    # ENV['SCOTCH_DIR'] = Formula.factory('scotch').prefix
    # ENV['PASTIX_DIR'] = Formula.factory('pastix').prefix
    # #ENV['TAO_DIR'] = Formula.factory('tao').prefix
    # ENV['CPPUNIT_DIR'] = Formula.factory('cppunit').prefix
    # ENV.append_to_cflags '-frounding-math'

    mkdir 'build' do
      system 'cmake', '..', *std_cmake_args
      system 'make'
      system 'make', 'install'
    end
  end

  def caveats; <<-EOS
    do not source dolfin.conf, as the DYLIB settings conflict with Homebrew.
    EOS
  end
end
