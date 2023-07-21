require_relative "../library/extension/global/file_line_limit.rb"
require_relative "../library/extension/global/check_new_line_in_last_file.rb"
 
module LangugeExt
    @langExtList={
        "golang": "go",
        "python": "py",
        "ruby": "rb",
        "javascript": "js",
        "typescript": "ts",
        "javascriptx": "jsx",
        "typescriptx": "tsx"
    }


    @global_class_codescan = {
      "file_line_limit": FileLineLimit.new,
      "check_new_line_in_last_file": CheckNewLineInCode.new
    }

    @initial_class_codescan = {
      "python": {}
    }

    def self.langExtList
      return @langExtList
    end
   
    def self.global_class_codescan
      return @global_class_codescan
    end
end

