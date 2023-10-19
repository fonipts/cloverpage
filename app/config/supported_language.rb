require_relative "../library/extension/codescan/global/file_line_limit.rb"
require_relative "../library/extension/codescan/global/check_new_line_in_last_file.rb"
require_relative "../library/extension/codescan/global/check_trailing_space.rb"
require_relative "../library/extension/codescan/global/max_newline_limit.rb"

module LangugeExt
    @langExtList={
        "golang": "go",
        "python": "py",
        "html": "html",
        "ruby": "rb",
        "dart": "dart",
        "javascript": "js",
        "typescript": "ts",
        "javascriptx": "jsx",
        "typescriptx": "tsx"
    }

    @global_class_codescan = {
      "file_line_limit": FileLineLimit.new,
      "check_new_line_in_last_file": CheckNewLineInCode.new,
      "check_trailing_space": CheckTrailingSpaceInCode.new,
      "max_newline_limit": MaxNewlineLimitInCode.new
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

