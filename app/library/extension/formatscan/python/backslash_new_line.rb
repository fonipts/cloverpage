require_relative '../../../interface/code_scan'

class BackslashNewLine < CodeScanInterface
  def initialize
    @ext_name = ''
    @ext_content = []
    @ext_config = true
    @ext_log = []
  end

  def default_value(value)
    @ext_config = value.first
  end

  def read
    return unless @ext_config

    reg_a = /(\\\s{0,})$/

    count = 1
    read_line = @ext_content.read_line
    for line in read_line

      count_scan = line.scan(reg_a)

      unless count_scan.to_a.empty?
        template_msg = format('file has `\` use parenthesis `()` to make a newline at line %<count>s', count: count)
        @ext_log.append(template_msg)
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
