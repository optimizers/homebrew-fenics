class Ufl < Formula
  desc "DSL for FEM discretizations of variational forms"
  homepage "https://bitbucket.org/fenics-project/ufl"
  url "https://bitbucket.org/fenics-project/ufl/downloads/ufl-1.6.0.tar.gz"
  sha256 "c75c4781e5104504f158cb42cd87aceffa9052e8e9db6e9764e6a5b6115d7f73"
  head "https://bitbucket.org/fenics-project/ufl.git"

  depends_on :python if MacOS.version <= :snow_leopard
  depends_on "numpy" => :python

  def install
    ENV.deparallelize
    system "python", *Language::Python.setup_install_args(prefix)
    pkgshare.install "demo"
  end

  test do
    system "ufl-analyse", pkgshare/"demo/MixedMixedElement.ufl"
    (testpath/"testufl.py").write <<-EOS.undent
      from ufl.algorithms import load_ufl_file
      filedata = load_ufl_file("#{pkgshare}/demo/MixedMixedElement.ufl")
      forms = filedata.forms
      elements = filedata.elements
    EOS
    system "python", testpath/"testufl.py"
  end
end
