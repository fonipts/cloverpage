require_relative "../../interface/code_scan.rb"

class CheckTrailingSpaceInCode < CodeScanInterface
   def initialize()
      @ext_name = ''
      @ext_content = []
      @ext_config = nil
      @ext_log = []
      @ext_details = {}
   end

   def setData(name, content, config,log)
      @ext_name = name
      @ext_content = content
      @ext_config = config.first
      @ext_log = log
   end
   def read
      if @ext_config
         msg = ""
         list_trail_space = []
         reg_a = /(\s{1,})\n$/

         count =1
         getReadLine = @ext_content.getReadLine
         for line in getReadLine
            msg = line
            count_scan = line.scan(reg_a)
            if count_scan.length >0

               #@clone_file_data[count - 1] = @clone_file_data[count - 1].gsub(reg_a,"\n")
               @ext_content.setModifyReadLine( count - 1  , getReadLine[count - 1].gsub(reg_a,"\n"))
               template_msg ="file `%s` trail white space at line %s"% [@ext_name,count]
               @ext_log.append(template_msg)
            end

            count +=1
         end

      end
   end

   def write

   end

end
