require_relative '../../../interface/code_scan'

class CheckTrailingSpaceInCode < CodeScanInterface
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

    reg_a = /(\s{1,})\n$/

    count = 1
    read_line = @ext_content.read_line
    for line in read_line

      count_scan = line.scan(reg_a)

      unless count_scan.to_a.empty?
        @ext_content.modify_read_line(count - 1, read_line[count - 1].gsub(reg_a, "\n"))
        template_msg = format('file `%<ext_name>s` trail white space at line %<count>s', ext_name: @ext_name,
                                                                                         count: count)
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
