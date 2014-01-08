require 'formula'

class Instant < Formula
  homepage 'https://bitbucket.org/fenics-project/instant'
  url 'https://bitbucket.org/fenics-project/instant/downloads/instant-1.3.0.tar.gz'
  sha1 '45176eae1323c77652785b4c93306d74b0c22722'

  depends_on 'swig'
  depends_on :python
  depends_on 'numpy' => :python

  def install
    ENV.deparallelize

    system 'python', 'setup.py', 'install', "--prefix=#{prefix}"
  end
end
