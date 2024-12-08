require_relative '../extension/formatscan/global/spaces_in_codes'
require_relative '../extension/formatscan/global/check_file_limit'
require_relative '../extension/formatscan/global/check_qoute_type'

module FormatExt
  @get_method = {
    'global': {
      'eof_newline': SpacesInCodes.new('meth_eof_newline'),
      'trail_whitespace': SpacesInCodes.new('meth_trail_space'),
      'max_len': CheckFileLimit.new('meth_max_len'),
      'row_char_limit': CheckFileLimit.new('meth_row_char_limit'),
      'qoute_type': CheckQouteType.new

    },
    'py': {
      # 'backslash_new_line': BackslashNewLine.new

    }
  }

  def self.get_method
    @get_method
  end
end
