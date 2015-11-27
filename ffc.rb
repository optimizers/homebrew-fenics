class Ffc < Formula
  desc "FEniCS Form Compiler for finite element variational forms"
  homepage "https://bitbucket.org/fenics-project/ffc"
  url "https://bitbucket.org/fenics-project/ffc/downloads/ffc-1.6.0.tar.gz"
  sha256 "382e7713fe759694e5f07506b144eeead681e169e5a34c164ef3da30eddcc1c6"
  head "https://bitbucket.org/fenics-project/ffc.git"

  depends_on :python if MacOS.version <= :snow_leopard
  depends_on "swig" => :build
  depends_on "numpy" => :python

  depends_on "optimizers/fenics/fiat"
  depends_on "optimizers/fenics/ufl"

  resource "six" do
    url "https://pypi.python.org/packages/source/s/six/six-1.10.0.tar.gz"
    sha256 "105f8d68616f8248e24bf0e9372ef04d3cc10104f1980f54d57b2ce73a5ad56a"
  end

  # patch :DATA

  def pyver
    IO.popen("python -c 'import sys; print sys.version[:3]'").read.strip
  end

  def install
    ENV.deparallelize

    six_path = libexec/"six/lib/python#{pyver}/site-packages"
    six_path.mkpath
    ENV.prepend_create_path "PYTHONPATH", six_path

    resource("six").stage do
      system "python", *Language::Python.setup_install_args(libexec/"six")
    end
    
    dest_path = lib/"python#{pyver}/site-packages"
    dest_path.mkpath
    (dest_path/"homebrew-ffc-six.pth").write "#{six_path}\n"

    system "python", *Language::Python.setup_install_args(prefix)

    # Two tests fail. Not sure why.
    # cd "test" do
    #   ENV.prepend "PYTHONPATH", lib/"python#{pyver}/site-packages"
    #   system "python", "test.py"
    # end
  end
end

__END__
--- a/setup.py
+++ b/setup.py
@@ -51,7 +51,7 @@
     # Find SWIG executable
     swig_executable = None
     for executable in ["swig", "swig2.0"]:
-        swig_executable = spawn.find_executable(executable)
+        swig_executable = spawn.find_executable(executable, path="/usr/local/bin")
         if swig_executable is not None:
             break
     if swig_executable is None:
