# require_relative '../library/extension/formatscan/global/check_indent_per_line'
# require_relative '../library/extension/formatscan/global/check_new_line_in_last_file'
# require_relative '../library/extension/formatscan/global/check_trailing_space'
# require_relative '../library/extension/formatscan/global/check_extra_space'
# require_relative '../library/extension/formatscan/global/string_literal'
# require_relative '../library/extension/formatscan/python/backslash_new_line'

module FormatExt
  @global_class_formatscan = {
    # 'check_indent_per_line': CheckIndentPerLine.new,
    # 'check_trailing_space': CheckTrailingSpaceInCode.new,
    # 'check_new_line_in_last_file': CheckNewLineInCode.new,
    # 'check_extra_space': CheckExtraSpaceInCode.new,
    # 'string_literal': StringLiteral.new
  }

  @initial_class_formatscan = {
    'py': {
      # 'backslash_new_line': BackslashNewLine.new

    }
  }

  def self.global_class_formatscan
    @global_class_formatscan
  end

  def self.initial_class_formatscan
    @initial_class_formatscan
  end
end
