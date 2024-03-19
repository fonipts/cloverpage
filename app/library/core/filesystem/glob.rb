class Glob
  def initialize(path, ext)
    @path = path
    @ext = ext

    @path_join = format('%s.%s', @path, @ext)
  end

  def readFiles
    Dir.glob(@path_join)
  end
end
