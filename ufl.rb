require 'formula'

class Ufl < Formula
  homepage 'https://bitbucket.org/fenics-project/ufl'
  url 'https://bitbucket.org/fenics-project/ufl/downloads/ufl-1.4.0.tar.gz'
  sha1 '4069e9477c07ae2841418bbdea6a4f2f19c870b7'

  depends_on :python
  depends_on 'numpy' => :python

  def install
    ENV.deparallelize

    system 'python', 'setup.py', 'install', "--prefix=#{prefix}"
  end
end
