require_relative '../../../interface/code_scan'

class CheckNewLineInCode < CodeScanInterface
  def initialize
    @ext_name = ''
    @ext_content = nil
    @ext_config = nil
    @ext_log = []
  end

  def setData(name, content, config, log)
    @ext_name = name
    @ext_content = content
    @ext_config = config.first
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
end
