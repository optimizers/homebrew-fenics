class Instant < Formula
  desc "inlining of C and C++ code in Python"
  homepage "https://bitbucket.org/fenics-project/instant"
  url "https://bitbucket.org/fenics-project/instant/downloads/instant-2016.1.0.tar.gz"
  sha256 "7bf03c8a7b61fd1e432b8f3a0405410ae68892ebb1a62a9f8118e8846bbeb0c6"
  head "git clone https://bitbucket.org/fenics-project/instant.git"

  depends_on :python if MacOS.version <= :snow_leopard
  depends_on "swig" => :build
  depends_on "numpy" => :python

  def pyver
    IO.popen("python -c 'import sys; print sys.version[:3]'").read.strip
  end

  def install
    ENV.deparallelize
    ENV.prepend_create_path "PYTHONPATH", lib/"python#{pyver}/site-packages"
    system "python", *Language::Python.setup_install_args(prefix)

    # Tests that require numpy.i just won't compile at this point.
    pkgshare.install "test"
  end

  test do
    ENV["PYTHONDONTWRITEBYTECODE"] = "1"

    cp_r opt_pkgshare/"test", testpath
    cd "test" do
      system "python", "run_tests.py"
    end
  end
end
