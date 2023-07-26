require_relative "../../interface/code_scan.rb"

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

   def setData(name, content, config,log,clone_file_data,details)
      @ext_name = name
      @ext_content = content
      @ext_config = config
      @ext_log = log
      @ext_details = details
      @clone_file_data = clone_file_data
   end
   def read

      count =1
      newline_count =0
      @valid_line_code = []
      for line in @ext_content
         if line.strip == ""
            newline_count+=1
            if newline_count>@ext_config
               template_msg ="file `%s` found %s or more newline at line code %s"% [@ext_name,@ext_config, count]
               @ext_log.append(template_msg)
               @is_error = true
               @clone_file_data.delete_at(count-1)

            end
         else
            @valid_line_code.append(line)
            newline_count = 0
         end
         count +=1
         end

   end

   def write
      if @is_error

      end
   end

end
