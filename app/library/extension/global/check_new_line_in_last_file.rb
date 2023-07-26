require_relative "../../interface/code_scan.rb"
class CheckNewLineInCode < CodeScanInterface
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
      if @ext_config
         msg = ""
         for line in @ext_content
            msg = line
         end
         reg_a = /\n/m
         if  !msg.match(reg_a)
            msg_data = "file `%s` has no newline found"% [@ext_name]
            @ext_log.append(msg_data)
         end
      end
   end

   def write

   end  

end

