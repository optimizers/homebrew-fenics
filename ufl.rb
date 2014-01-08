require 'formula'

class Ufl < Formula
  homepage 'https://bitbucket.org/fenics-project/ufl'
  url 'https://bitbucket.org/fenics-project/ufl/downloads/ufl-1.3.0.tar.gz'
  sha1 '8a0dfb3f5c949958cb3f16a9014383c1d229063e'

  depends_on :python
  depends_on 'numpy' => :python

  def install
    ENV.deparallelize

    system 'python', 'setup.py', 'install', "--prefix=#{prefix}"
  end
end
