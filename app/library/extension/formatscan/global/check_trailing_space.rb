require_relative '../../../interface/code_scan'

class CheckTrailingSpaceInCode < CodeScanInterface
  def initialize
    @ext_name = ''
    @ext_content = []
    @ext_config = true
    @ext_log = []
  end

  def set_data(name, content, log)
    @ext_name = name
    @ext_content = content
    @ext_log = log
  end

  def read
    return unless @ext_config

    msg = ''
    list_trail_space = []
    reg_a = /(\s{1,})\n$/

    count = 1
    getReadLine = @ext_content.getReadLine
    for line in getReadLine
      msg = line
      count_scan = line.scan(reg_a)
      if count_scan.length > 0

        @ext_content.setModifyReadLine(count - 1, getReadLine[count - 1].gsub(reg_a, '\n'))
        template_msg = format('file `%s` trail white space at line %s', @ext_name, count)
        @ext_log.append(template_msg)
      end

      count += 1
    end
  end

  def default_value(value)
    @ext_config = value.first
  end
end
