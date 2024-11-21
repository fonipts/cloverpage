# require_relative '../library/extension/codescan/global/file_line_limit'
# require_relative '../library/extension/codescan/global/line_limit_character'
# require_relative '../library/extension/codescan/global/max_newline_limit'
# require_relative '../library/extension/codescan/global/invalid_comment'
# require_relative '../library/extension/codescan/python/invalid_script'
# require_relative '../library/extension/codescan/python/relative_import'

module CodescanExt
  @global_class_codescan = {
    # 'file_line_limit': FileLineLimit.new,
    # 'line_limit_character': LineLimitCharacter.new,
    # 'max_newline_limit': MaxNewlineLimitInCode.new,
    # 'invalid_comment': InvalidComment.new
  }

  @initial_class_codescan = {
    'py': {}
  }

  def self.global_class_codescan
    @global_class_codescan
  end

  def self.initial_class_codescan
    @initial_class_codescan
  end
end
