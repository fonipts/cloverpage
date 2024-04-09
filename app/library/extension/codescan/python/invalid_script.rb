require_relative '../../../interface/code_scan'
require_relative '../../../parser/python_intepreter'

class InvalidScriptPython < CodeScanInterface
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

    cls = PythonInterpreter.new
    cls.set_data('', @ext_content, '')
    cls.execute
    for k in cls.imports
      next unless k[:package] == 'typing'

      self_regexp = /\s{0,}(Self)\s{0,}/
      scan_class = k[:class_func].scan(self_regexp)

      next unless scan_class.count > 0

      template_msg = format('file has invalid `from typing import Self`,
         please use the standard `from typing_extensions import Self  # type: ignore`') # :format_except
      @ext_log.append(template_msg)
    end

    newline1_regexp = /=\s{0,}(\[[\n\s]{0,}\()(.*?)(\][\n\s]{0,}\))\s{0,}/
    scan_newline1 = @ext_content.read_line.to_s.scan(newline1_regexp)

    return unless scan_newline1.count > 0

    for s1 in scan_newline1
      newline_sub_regexp = /(\\n)/
      newline_string = s1[1].to_s.scan(newline_sub_regexp)
      if newline_string.count > 0
        template_msg = format('file has do not use `[( `)] for new line is not required to use')
        @ext_log.append(template_msg)
      end

    end
  end

  def set_data(name, content, log)
    @ext_name = name
    @ext_content = content
    @ext_log = log
  end
end
