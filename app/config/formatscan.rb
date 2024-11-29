# require_relative '../library/extension/formatscan/global/check_indent_per_line'
# require_relative '../library/extension/formatscan/global/check_new_line_in_last_file'
# require_relative '../library/extension/formatscan/global/check_trailing_space'
# require_relative '../library/extension/formatscan/global/check_extra_space'
# require_relative '../library/extension/formatscan/global/string_literal'
require_relative '../extension/formatscan/global/spaces_in_codes'

module FormatExt
  @get_method = {
    'global': {
      'trail_whitespace': SpacesInCodes.new('meth_trail_space')

    },
    'py': {
      # 'backslash_new_line': BackslashNewLine.new

    }
  }

  def self.get_method
    @get_method
  end
end
