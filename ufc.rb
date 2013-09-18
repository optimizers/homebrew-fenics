require 'formula'

class Ufc < Formula
  homepage 'https://bitbucket.org/fenics-project/ufc'
  head 'https://bitbucket.org/fenics-project/ufc.git'
  version '2.2.0+'

  depends_on 'cmake' => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end
end
