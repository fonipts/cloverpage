require_relative "../../../interface/code_scan.rb"

class FileLineLimit < CodeScanInterface

   def initialize()
      @ext_name = ''
      @ext_content = []
      @ext_config = nil
      @ext_log = []
   end

   def setData(name, content, config,log)
      @ext_name = name
      @ext_content = content
      @ext_config = config.first
      @ext_log = log
   end

   def read
      counter = @ext_content.getReadLine.count()
      if counter > @ext_config
         msg = "file `%s` has exceed the limit of %s/%s"% [@ext_name, counter, @ext_config]
         @ext_log.append(msg)
      end
   end

end
