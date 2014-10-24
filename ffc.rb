require 'formula'

class Ffc < Formula
  homepage 'https://bitbucket.org/fenics-project/ffc'
  url 'https://bitbucket.org/fenics-project/ffc/downloads/ffc-1.4.0.tar.gz'
  sha1 'b5d36757d5a44e4e2964e93eab5d304809052611'
  depends_on :python
  depends_on 'numpy' => :python
  depends_on 'fiat'
  depends_on 'ufl'

  def install
    ENV.deparallelize

    system 'python', 'setup.py', 'install', "--prefix=#{prefix}"
  end
end
