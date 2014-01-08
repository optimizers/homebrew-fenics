require 'formula'

class Test < Formula
  homepage "http://downloads.sourceforge.net/project/synfig"
  url 'http://downloads.sourceforge.net/project/synfig/releases/0.64.1/source/ETL-0.04.17.tar.gz'
  sha1 '2ab2957140deaad90232533461513c5d425007bb'

  depends_on 'vtk5' => 'with-qt'

  def install
    puts 'hi there'
  end
end
