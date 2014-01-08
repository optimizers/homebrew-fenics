require 'formula'

class Ffc < Formula
  homepage 'https://bitbucket.org/fenics-project/ffc'
  url 'https://bitbucket.org/fenics-project/ffc/downloads/ffc-1.3.0.tar.gz'
  sha1 'd3b2bb0108a1be59f8d482f4181a8efbbc44b523'

  depends_on :python
  depends_on 'numpy' => :python
  #depends_on 'ufc'
  #depends_on 'fiat'
  #depends_on 'ufl'

  def install
    ENV.deparallelize

    system 'python', 'setup.py', 'install', "--prefix=#{prefix}"
  end
end
