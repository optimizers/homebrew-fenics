class Dolfin < Formula
  desc "C++/Python interface of FEniCS"
  homepage "https://bitbucket.org/fenics-project/dolfin"
  url "https://bitbucket.org/fenics-project/dolfin/downloads/dolfin-1.6.0.tar.gz"
  sha256 "67eaac5fece6e71da0559b4ca8423156f9e99a952f0620adae449ebebb6695d1"
  head "https://bitbucket.org/fenics-project/dolfin.git"

  option "with-openmp", "Build with an Open-MP-enabled compiler"
  needs :openmp if build.with? "openmp"

  depends_on :python if MacOS.version <= :snow_leopard
  depends_on :fortran
  depends_on :mpi => [:cc, :cxx, :f90, :recommended]

  depends_on "cmake"      => :build
  depends_on "cppunit"    => :build
  depends_on "pkg-config" => :build
  depends_on "swig"       => :build

  depends_on "eigen"
  depends_on "homebrew/science/suite-sparse"
  depends_on "homebrew/science/vtk" => [:recommended, "--with-qt"]

  # MPI, PETSc and SLEPc must be installed before installing mpi4py, petsc4py and slepc4py
  depends_on "mpi4py"   => :python
  depends_on "numpy"    => :python
  depends_on "petsc4py" => :python
  depends_on "ply"      => :python
  depends_on "slepc4py" => :python

  boost_deps = ["without-single"] + ((build.with? "mpi") ? ["with-mpi"] : [])
  depends_on "boost"    => boost_deps

  hdf5_deps = [:recommended] + ((build.with? "mpi") ? ["with-mpi"] : [])
  depends_on "homebrew/science/hdf5"     => hdf5_deps

  depends_on "homebrew/science/parmetis" => :recommended if build.with? "mpi"
  depends_on "homebrew/science/pastix"   => :recommended if build.with? "mpi"
  depends_on "homebrew/science/petsc"    => :recommended if build.with? "mpi"
  depends_on "homebrew/science/slepc"    => :recommended if build.with? "mpi"
  depends_on "homebrew/science/scotch"   => :recommended if build.with? "mpi"

  trilinos_deps = [:recommended] + ((build.with? "mpi") ? [] : ["without-mpi"])
  depends_on "homebrew/science/trilinos" => trilinos_deps

  depends_on "optimizers/fenics/fiat"
  depends_on "optimizers/fenics/ufl"
  depends_on "optimizers/fenics/ffc"
  depends_on "optimizers/fenics/instant"

  env :std # To properly detect PARMETIS.

  def onoff(s, cond)
    s + (cond ? "ON" : "OFF")
  end

  def install
    ENV.deparallelize
    cmake_args = %W[-DCMAKE_INSTALL_PREFIX=#{prefix}
                    -DBUILD_SHARED_LIBS:BOOL=ON
                    -DDOLFIN_ENABLE_PYTHON:BOOL=ON
                    -DDOLFIN_INSTALL_PYTHON_MODULE_DIR=#{lib}/python2.7/site-packages
                    -DDOLFIN_INSTALL_PYTHON_PURE_MODULE_DIR=#{lib}/python2.7/site-packages
                    -DDOLFIN_ENABLE_UMFPACK:BOOL=ON
                    -DUMFPACK_INCLUDE_DIRS=#{Formula["suite-sparse"].opt_include}
                    -DDOLFIN_ENABLE_VTK:BOOL=ON
                    -DDOLFIN_ENABLE_CHOLMOD:BOOL=ON
                    -DCHOLMOD_INCLUDE_DIRS=#{Formula["suite-sparse"].opt_include}
                 ]

    ENV["CHOLMOD_DIR"] = "#{Formula["suite-sparse"]}.opt_prefix"
    ENV["UMFPACK_DIR"] = "#{Formula["suite-sparse"]}.opt_prefix"

    cmake_args << onoff("-DDOLFIN_ENABLE_OPENMP:BOOL=", (build.with? "openmp"))
    cmake_args << onoff("-DDOLFIN_ENABLE_HDF5:BOOL=", (build.with? "hdf5"))
    cmake_args << onoff("-DDOLFIN_ENABLE_MPI:BOOL=", (build.with? "mpi"))
    cmake_args << onoff("-DDOLFIN_ENABLE_PARMETIS:BOOL=", (build.with? "parmetis"))
    cmake_args << onoff("-DDOLFIN_ENABLE_PASTIX:BOOL=", (build.with? "pastix"))

    cmake_args << onoff("-DDOLFIN_ENABLE_PETSC:BOOL=", (build.with? "petsc"))
    ENV["PETSC_DIR"] = "#{Formula["petsc"].opt_prefix}/real" if build.with? "petsc"

    cmake_args << onoff("-DDOLFIN_ENABLE_SLEPC:BOOL=", (build.with? "slepc"))
    ENV["SLEPC_DIR"] = "#{Formula["slepc"].opt_prefix}/real" if build.with? "slepc"

    cmake_args << onoff("-DDOLFIN_ENABLE_SCOTCH:BOOL=", (build.with? "scotch"))
    cmake_args << onoff("-DDOLFIN_ENABLE_TRILINOS:BOOL=", (build.with? "trilinos"))

    mkdir "build" do
      system "cmake", "..", *cmake_args
      system "make"
      system "make", "install"
    end
  end

  def caveats; <<-EOS
    Do not source dolfin.conf, as the DYLIB settings conflict with Homebrew.
    EOS
  end

  test do
    (testpath/"poisson.py").write <<-EOS.undent
      from dolfin import *
      mesh = UnitSquareMesh(32, 32)
      V = FunctionSpace(mesh, "Lagrange", 1)

      def boundary(x):
        return x[0] < DOLFIN_EPS or x[0] > 1.0 - DOLFIN_EPS

      u0 = Constant(0.0)
      bc = DirichletBC(V, u0, boundary)
      u = TrialFunction(V)
      v = TestFunction(V)
      f = Expression("10*exp(-(pow(x[0] - 0.5, 2) + pow(x[1] - 0.5, 2)) / 0.02)")
      g = Expression("sin(5*x[0])")
      a = inner(grad(u), grad(v))*dx
      L = f*v*dx + g*v*ds

      u = Function(V)
      solve(a == L, u, bc)
    EOS
    system "python", "poisson.py"
  end
end
