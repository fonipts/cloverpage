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
    for line in @ext_content.read_line
      string_line = StringPerLine.new(line.to_s)
      count_scan = string_line.count_first_space
      indent_count = count_scan if count_scan.positive?
      if indent_count.positive?
        base_number = (indent_count / @ext_config) * @ext_config

        is_not_valid = true
        is_not_valid = false if (base_number + @ext_config) == indent_count

        is_not_valid = false if (base_number - @ext_config) == indent_count
        is_not_valid = false if base_number == indent_count
        if is_not_valid
          template_msg = format('file has invalid indentation at line %<count>s', count: count)
          @ext_log.append(template_msg)
        end
      end
      count += 1
    end
  end

  def set_data(name, content, log)
    @ext_name = name
    @ext_content = content
    @ext_log = log
  end
end
