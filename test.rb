require 'formula'

class Test < Formula

  depends_on 'vtk5' => ['with-qt', 'with-python']

  if build.with? 'vtk5'
    depends_on 'sip'
    depends_on 'pyqt'
  end

  def install
    puts 'hi there'
  end
end
