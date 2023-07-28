class Glob

    def initialize(path, ext)
        @path =path
        @ext = ext

        @path_join = "%s.%s"% [@path, @ext ]
    end
    def readFiles
       return Dir.glob(@path_join)
    end

end
