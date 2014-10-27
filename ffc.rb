require 'formula'

class Ffc < Formula
  homepage 'https://bitbucket.org/fenics-project/ffc'
  url 'https://bitbucket.org/fenics-project/ffc/downloads/ffc-1.4.0.tar.gz'
  sha1 'b5d36757d5a44e4e2964e93eab5d304809052611'
  depends_on :python
  depends_on 'numpy' => :python
  depends_on 'fiat'
  depends_on 'ufl'

  patch :DATA

  def install
    ENV.deparallelize

    system 'python', 'setup.py', 'install', "--prefix=#{prefix}"
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
+        swig_executable = spawn.find_executable(executable, path='/usr/local/bin')
         if swig_executable is not None:
             break
     if swig_executable is None:
