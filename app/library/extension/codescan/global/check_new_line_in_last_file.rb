require_relative "../../../interface/code_scan.rb"

class CheckNewLineInCode < CodeScanInterface

   def initialize()
      @ext_name = ''
      @ext_content = []
      @ext_config = nil
      @ext_log = []
      @ext_details = {}
      @is_error = false
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
         for line in @ext_content.getReadLine
            msg = line
         end
         reg_a = /\n$/m
         if  !msg.match(reg_a)
            msg_data = "file `%s` has no newline found"% [@ext_name]
            @is_error = true
            @ext_log.append(msg_data)
            @clone_file_data.setAppendReadLine("\n")
         end
      end
   end

   def write
      if @is_error

      end
   end

end
