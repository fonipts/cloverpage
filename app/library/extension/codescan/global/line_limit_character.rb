require_relative '../../../interface/code_scan'

class LineLimitCharacter < CodeScanInterface
  def initialize
    @ext_name = ''
    @ext_content = nil
    @ext_config = 150
    @ext_log = []
  end

  def default_value(value)
    @ext_config = value.first
  end

  def read
    count = 1
    read_line = @ext_content.read_line
    for line in read_line

      count_str = line.length

      if count_str > @ext_config
        template_msg = format('line %s it execeed string length %s/%s', count, count_str, @ext_config)
        @ext_log.append(template_msg)
        @is_error = true
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
