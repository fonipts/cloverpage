class FileRead

    def initialize(app_dir, filename)
        @list_content = []
        @clone_list_content = []
        @list_index_delete = {}
        @list_index_delete_arr = []
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
        reference = 0
        counter = -1
        line_counter = 0
        #?@list_index_delete.each do |key ,value|

        #?    for n in 0..value
        #?        #@clone_list_content.delete_at( key - reference)
        #?        puts @clone_list_content.delete_at( key - reference)
        #?        puts "%s:%s  = %s" %[key,reference, n]
        #?    end
        #?    #puts key - reference
        #?    #puts "---"
        #?    reference += ((value+1) + counter)
        #?    counter+=1
        #?end
        row_count =0
        for k in @list_index_delete_arr
            if counter + 1 == k
                counter +=1

            else
                line_counter = row_count
                reference = k
                counter = k
            end
            row_count += 1
            #puts "%s : %s  = %s  - %s "% [k,counter , reference , line_counter]
            #puts @clone_list_content.delete_at( reference - line_counter)
            @clone_list_content.delete_at( reference - line_counter)
        end
        #if counter>0
          #puts @clone_list_content.join("")
        #end
        File.write(@path_join_file,   @clone_list_content.join(""), mode: "w")
    end
    def getReadLine
        return @clone_list_content
    end
    def setModifyReadLine(index, content)
        @clone_list_content[index] = content
    end
    def setAppendReadLine(content)
        @clone_list_content.append(content)
    end
    def setDeleteAtReadLine(index)
        counter = 1
        if @list_index_delete.key?(index)
            counter = @list_index_delete[index] +1
        end
        @list_index_delete[index] = counter
        @list_index_delete_arr.append(index)
       # @clone_list_content.delete_at(index)
         #@list_index_delete.append(index)
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
