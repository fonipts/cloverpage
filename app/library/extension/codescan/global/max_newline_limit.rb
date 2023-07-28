require_relative "../../../interface/code_scan.rb"

class MaxNewlineLimitInCode < CodeScanInterface
   def initialize()
      @ext_name = ''
      @ext_content = []
      @ext_config = nil
      @ext_log = []
      @ext_details = {}

      @is_error = false
      @valid_line_code = []
   end

   def setData(name, content, config,log)
      @ext_name = name
      @ext_content = content
      @ext_config = config.first
      @ext_log = log
   end
   def read

      count =1

      reference = -1
      newline_count =0
      @valid_line_code = []
     
      for line in @ext_content.getReadLine

         if line.strip == ""

            newline_count+=1
            if newline_count>@ext_config 
               
               if reference == -1
                  reference = count-1
               end
               template_msg ="file `%s` found %s or more newline at line code %s"% [@ext_name,@ext_config, count]

               @ext_log.append(template_msg)
               @is_error = true
               @ext_content.setDeleteAtReadLine(reference- @ext_config )
            else
               reference = -1
            end
         else
            @valid_line_code.append(line)
            newline_count = 0
            reference = -1
         end
         count +=1
      end

   end



end
