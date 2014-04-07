require "formula"

class Ufc < Formula
  homepage "https://bitbucket.org/fenics-project/ufc"
  url "https://bitbucket.org/fenics-project/ufc-deprecated/downloads/ufc-2.3.0.tar.gz"
  sha1 "4cb7a9d80414894532e1a1dbe8ccdf42e5f563bb"

  depends_on :python
  depends_on 'swig'  => :build
  depends_on 'cmake' => :build
  depends_on 'boost' => ['--without-single']

  def install
    ENV.deparallelize

    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end
end
