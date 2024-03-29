require_relative '../library/extension/codescan/global/file_line_limit'
require_relative '../library/extension/codescan/global/line_limit_character'
require_relative '../library/extension/codescan/global/max_newline_limit'
require_relative '../library/extension/codescan/global/invalid_comment'
require_relative '../library/extension/formatscan/global/check_indent_per_line'
require_relative '../library/extension/formatscan/global/check_new_line_in_last_file'
require_relative '../library/extension/formatscan/global/check_trailing_space'
require_relative '../library/extension/formatscan/global/check_extra_space'
require_relative '../library/extension/formatscan/global/string_literal'
require_relative '../library/extension/codescan/python/relative_import'

require_relative '../library/extension/formatscan/python/backslash_new_line'

module LangugeExt
  @langExtList = {
    'golang': 'go',
    'python': 'py',
    'html': 'html',
    'ruby': 'rb',
    'dart': 'dart',
    'javascript': 'js',
    'typescript': 'ts',
    'javascriptx': 'jsx',
    'typescriptx': 'tsx',
    'yaml': 'yaml'
  }

  @global_class_codescan = {
    'file_line_limit': FileLineLimit.new,
    'line_limit_character': LineLimitCharacter.new,
    'max_newline_limit': MaxNewlineLimitInCode.new,
    'invalid_comment': InvalidComment.new
  }

  @global_class_formatscan = {
    'check_indent_per_line': CheckIndentPerLine.new,
    'check_trailing_space': CheckTrailingSpaceInCode.new,
    'check_new_line_in_last_file': CheckNewLineInCode.new,
    'check_extra_space': CheckExtraSpaceInCode.new,
    'string_literal': StringLiteral.new
  }

  @initial_class_codescan = {
    'python': {
      'relative_import': RelativeImportPython.new
    }
  }
  @initial_class_formatscan = {
    'python': {
      'backslash_new_line': BackslashNewLine.new

    }
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

  def self.initial_class_codescan
    @initial_class_codescan
  end

  def self.initial_class_formatscan
    @initial_class_formatscan
  end
end
