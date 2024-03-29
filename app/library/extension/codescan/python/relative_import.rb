require_relative '../../../interface/code_scan'
require_relative '../../../parser/python_intepreter'

class RelativeImportPython < CodeScanInterface
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
    #p cls.imports
  end

  def set_data(name, content, log)
    @ext_name = name
    @ext_content = content
    @ext_log = log
  end
end
