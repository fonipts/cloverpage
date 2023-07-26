require_relative "../../interface/code_scan.rb"

class MaxNewlineLimitInCode < CodeScanInterface
   def initialize()
      @ext_name = ''
      @ext_content = []
      @ext_config = nil
      @ext_log = []
      @ext_details = {}
   end

   def setData(name, content, config,log,details)
      @ext_name = name
      @ext_content = content
      @ext_config = config
      @ext_log = log
      @ext_details = details
   end
   def read

      count =1
      newline_count =0
      for line in @ext_content
         if line.strip == ""
            newline_count+=1
               if newline_count>@ext_config
                  template_msg ="file `%s` found %s or more newline at line code %s"% [@ext_name,@ext_config,count]
                  @ext_log.append(template_msg)
               end  
            else
               newline_count = 0
            end
            count +=1
         end

   end

   def write

   end  

end
