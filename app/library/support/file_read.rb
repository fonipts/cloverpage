class FileRead

    def initialize(app_dir, filename)
        @list_content = []
        @clone_list_content = []
        @path_join_file = File.join(app_dir, filename)
        @filename = filename
    end
    def initReadFile
        @list_content = []
        @clone_list_content = []
        f = File.open(@path_join_file, "r")

        f.each_line do |line|
            @list_content.append(line)
        end
        @clone_list_content = @list_content.clone

        f.close
    end
    def initWriteFile
        File.write(@path_join_file,   @clone_list_content.join(""), mode: "w")
    end
    def getReadLine
        return @list_content
    end
    def setModifyReadLine(index, content)
        @clone_list_content[index] = content
    end
    def setAppendReadLine(content)
        @clone_list_content.append(content)
    end
    def setDeleteAtReadLine(index)
        @clone_list_content.delete_at(index)
    end
    def exists
        return File.exists?(@path_join_file)
    end
    def getPathJoinFile
        return @path_join_file
    end
    def getFilename
        return @filename
    end
end
