require_relative '../../../interface/code_scan'

class FileLineLimit < CodeScanInterface
  def initialize
    @ext_name = ''
    @ext_content = nil
    @ext_config = 100
    @ext_log = []
  end

  def default_value(value)
    @ext_config = value.first
  end

  def read
    counter = @ext_content.read_line.count
    return unless counter > @ext_config

    msg = format('file `%s` has exceed the limit of %s/%s', @ext_name, counter, @ext_config)
    @ext_log.append(msg)
  end

  def set_data(name, content, log)
    @ext_name = name
    @ext_content = content
    @ext_log = log
  end
end
