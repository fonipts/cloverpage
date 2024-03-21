require_relative '../../../interface/code_scan'

class MaxNewlineLimitInCode < CodeScanInterface
  def initialize
    @ext_name = ''
    @ext_content = []
    @ext_config = 250
    @ext_log = []
    @ext_details = {}
  end

  def set_data(name, content, log)
    @ext_name = name
    @ext_content = content
    @ext_log = log
  end

  def read
    count = 1

    newline_count = 0

    for line in @ext_content.getReadLine

      if line.strip == ''

        newline_count += 1
        if newline_count > @ext_config

          template_msg = format('file `%s` found %s or more newline at line code %s', @ext_name, @ext_config, count)

          @ext_log.append(template_msg)
          @is_error = true
          @ext_content.setDeleteAtReadLine(count - 1)
        end
      else

        newline_count = 0

      end
      count += 1
    end
  end

  def default_value(value)
    @ext_config = value.first
  end
end
