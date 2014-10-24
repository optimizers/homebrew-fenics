require 'formula'

class Instant < Formula
  homepage 'https://bitbucket.org/fenics-project/instant'
  url 'https://bitbucket.org/fenics-project/instant/downloads/instant-1.4.0.tar.gz'
  sha1 '9f5c3f041cfde3005b22d1e3d8bd256b8e495b4e'

  depends_on 'swig'
  depends_on :python
  depends_on 'numpy' => :python

  def install
    ENV.deparallelize

    system 'python', 'setup.py', 'install', "--prefix=#{prefix}"
  end
end
