require_relative '../library/extension/codescan/global/file_line_limit'
require_relative '../library/extension/codescan/global/check_new_line_in_last_file'
require_relative '../library/extension/formatscan/global/check_trailing_space'
require_relative '../library/extension/codescan/global/max_newline_limit'
require_relative '../library/extension/formatscan/global/check_extra_space'

module LangugeExt
  @langExtList = {
    "golang": 'go',
    "python": 'py',
    "html": 'html',
    "ruby": 'rb',
    "dart": 'dart',
    "javascript": 'js',
    "typescript": 'ts',
    "javascriptx": 'jsx',
    "typescriptx": 'tsx'
  }

  @global_class_codescan = {
    "file_line_limit": FileLineLimit.new,
    "check_new_line_in_last_file": CheckNewLineInCode.new,
    "max_newline_limit": MaxNewlineLimitInCode.new
  }

  @global_class_formatscan = {
    "check_trailing_space": CheckTrailingSpaceInCode.new,
    "check_extra_space": CheckExtraSpaceInCode.new
  }

  @initial_class_codescan = {
    "python": {}
  }
  @initial_class_formatscan = {
    "python": {}
  }

  def self.langExtList
    @langExtList
  end

  def self.global_class_codescan
    @global_class_codescan
  end

  def self.global_class_formatscan
    @global_class_formatscan
  end
end
