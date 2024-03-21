require_relative '../../../interface/code_scan'

class CheckNewLineInCode < CodeScanInterface
  def initialize
    @ext_name = ''
    @ext_content = nil
    @ext_config = 100
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
    for line in @ext_content.getReadLine
      msg = line
    end
    reg_a = /\n$/m
    return if msg.match(reg_a)

    msg_data = format('file `%s` has no newline found', @ext_name)
    @is_error = true
    @ext_log.append(msg_data)
    @ext_content.setAppendReadLine('\n')
  end

  def default_value(value)
    @ext_config = value.first
  end
end
