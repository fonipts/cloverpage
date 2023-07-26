require_relative "../../interface/code_scan.rb"

class FileLineLimit < CodeScanInterface

   def initialize()
      @ext_name = ''
      @ext_content = []
      @ext_config = nil
      @ext_log = []
      @ext_details = {}
   end

   def setData(name, content, config,log,clone_file_data,details)
      @ext_name = name
      @ext_content = content
      @ext_config = config
      @ext_log = log
      @ext_details = details
   end

   def read
      counter = @ext_content.count()
      if counter > @ext_config
         msg = "file `%s` has exceed the limit of %s/%s"% [@ext_name, counter, @ext_config]
         @ext_log.append(msg)
      end
   end
   def write

   end
end
