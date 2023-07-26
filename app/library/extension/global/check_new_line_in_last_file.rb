require_relative "../../interface/code_scan.rb"

class CheckNewLineInCode < CodeScanInterface
   def initialize()
      @ext_name = ''
      @ext_content = []
      @ext_config = nil
      @ext_log = []
      @ext_details = {}
      @is_error = false
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
      if @ext_config
         msg = ""
         for line in @ext_content
            msg = line
         end
         reg_a = /\n$/m
         if  !msg.match(reg_a)
            msg_data = "file `%s` has no newline found"% [@ext_name]
            @is_error = true
            @ext_log.append(msg_data)
            @clone_file_data.append("\n")
         end
      end
   end

   def write
      if @is_error

      end
   end

end
