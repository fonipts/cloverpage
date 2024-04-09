require_relative '../../../interface/code_scan'
require_relative '../../../utility/string_per_line'

class CheckIndentPerLine < CodeScanInterface
  def initialize
    @ext_name = ''
    @ext_content = nil
    @ext_config = 2
    @ext_log = []
  end

  def default_value(value)
    @ext_config = value.first
  end

  def read
    return unless @ext_config.positive?

    count = 1
    indent_count = 0
    base_number = 0
    for line in @ext_content.read_line
      string_line = StringPerLine.new(line.to_s)
      count_scan = string_line.count_first_space

      base_number = (indent_count / @ext_config) * @ext_config

      is_not_valid = false

      is_not_valid = true if (count_scan % @ext_config).positive?
      if is_not_valid
        template_msg = format('file has invalid indentation at line %<count>s : %<indent_count>s',
                              count: count, indent_count: count_scan % @ext_config)
        @ext_log.append(template_msg)
      end
      indent_count = count_scan
      count += 1
    end
  end

  def set_data(name, content, log)
    @ext_name = name
    @ext_content = content
    @ext_log = log
  end
end
