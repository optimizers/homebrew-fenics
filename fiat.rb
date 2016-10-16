class Fiat < Formula
  desc "FInite element Automatic Tabulator"
  homepage "https://bitbucket.org/fenics-project/fiat"
  url "https://bitbucket.org/fenics-project/fiat/downloads/fiat-2016.1.0.tar.gz"
  sha256 "851723126a71bc1ae2dc4ad6e9330bd9b54d52db390dcbbc1f3c759fb49c6aeb"
  head "https://bitbucket.org/fenics-project/fiat.git"

  depends_on :python if MacOS.version <= :snow_leopard
  depends_on "numpy" => :python

  resource "sympy" do
    url "https://github.com/sympy/sympy/releases/download/sympy-0.7.6.1/sympy-0.7.6.1.tar.gz"
    sha256 "1fc272b51091aabe7d07f1bf9f0a47f3e28657fb2bec52bf3ef0e8f159f5f564"
  end

  def pyver
    IO.popen("python -c 'import sys; print sys.version[:3]'").read.strip
  end

  def install
    ENV.deparallelize
    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python#{pyver}/site-packages"

    resource("sympy").stage do
      system "python", *Language::Python.setup_install_args(libexec/"vendor")
    end

    ENV.prepend "PYTHONPATH", lib/"python#{pyver}/site-packages"
    system "python", *Language::Python.setup_install_args(prefix)
    pkgshare.install "test"
  end

  test do
    ENV["PYTHONDONTWRITEBYTECODE"] = "1"

    cp_r pkgshare/"test", testpath
    cd "test" do
      system "python", "test.py"
    end
  end
end
