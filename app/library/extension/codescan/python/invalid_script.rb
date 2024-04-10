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

    invalid_import
    invalid_newline_bracket
  end

  def set_data(name, content, log)
    @ext_name = name
    @ext_content = content
    @ext_log = log
  end

  private

  def invalid_import
    cls = PythonInterpreter.new
    cls.set_data('', @ext_content, '')
    cls.execute
    for k in cls.imports
      next unless k[:package] == 'typing'

      self_regexp = /\s{0,}(Self)\s{0,}/
      scan_class = k[:class_func].scan(self_regexp)

      next unless scan_class.count.positive?

      template_msg = format('file has invalid `from typing import Self`,
          please use the standard `from typing_extensions import Self  # type: ignore`') # :format_except
      @ext_log.append(template_msg)
    end
  end

  def invalid_newline_bracket
    newline1_regexp = /= \s{0,}(\[[\n\s\t]{0,}\()(.*?)(\][\n\s\t]{0,}\))/
    scan_newline1 = @ext_content.read_line.to_s.scan(newline1_regexp)

    return unless scan_newline1.count.positive?

    for s1 in scan_newline1
      newline_sub_regexp = /(\\n)/
      newline_string = s1[1].to_s.scan(newline_sub_regexp)
      newline_sub_regexp1 = /^([a-zA-Z]{1,}\.)/
      newline_string1 = s1[1].to_s.scan(newline_sub_regexp1)
      if newline_string.count.positive? || newline_string1.count.positive?
        if check_data(s1[1])
          template_msg = format('file has do not use `[( )]` for new line is not required to use')
          @ext_log.append(template_msg)
        end
      end

    end
  end

  private

  def check_data(content)
    is_validated = true
    words_split  = content.split(',')
    check_literal_regexp = /^([\"\']{1})/
    for word in words_split
      word_count = word.to_s.scan(newline_sub_regexp1)
      is_validated = false if word_count.count
    end
    is_validated
  end
end
