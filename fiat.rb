require 'formula'

class Fiat < Formula
  homepage 'https://bitbucket.org/fenics-project/fiat'
  url 'https://bitbucket.org/fenics-project/fiat/downloads/fiat-1.4.0.tar.gz'
  sha1 'ea77559760ec862353c5d2a9d31d471294471a9f'

  depends_on :python
  depends_on 'numpy' => :python

  resource('scientificpython') do
    url 'https://sourcesup.renater.fr/frs/download.php/4153/ScientificPython-2.9.2.tar.gz'
    sha1 '387b0ed5600b0f08301412745aab2da72e1459d7'
  end

  def install
    ENV.deparallelize

    resourceargs = ['setup.py', 'install', "--prefix=#{prefix}"]
    resource('scientificpython').stage {system 'python', *resourceargs }

    system 'python', 'setup.py', 'install', "--prefix=#{prefix}"
  end
end
