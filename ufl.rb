class Ufl < Formula
  desc "DSL for FEM discretizations of variational forms"
  homepage "https://bitbucket.org/fenics-project/ufl"
  url "https://bitbucket.org/fenics-project/ufl/downloads/ufl-2016.1.0.tar.gz"
  sha256 "8dccfe10d1251ba48a4d43a4c6c89abe076390223b500f4baf06f696294b8dd0"
  head "https://bitbucket.org/fenics-project/ufl.git"

  depends_on :python if MacOS.version <= :snow_leopard
  depends_on "numpy" => :python

  def pyver
    IO.popen("python -c 'import sys; print sys.version[:3]'").read.strip
  end

  def install
    ENV.deparallelize
    ENV.prepend_create_path "PYTHONPATH", lib/"python#{pyver}/site-packages"
    system "python", *Language::Python.setup_install_args(prefix)
    pkgshare.install "demo"
  end

  test do
    ENV["PYTHONDONTWRITEBYTECODE"] = "1"

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
