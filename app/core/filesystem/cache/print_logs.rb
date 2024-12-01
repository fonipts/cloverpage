require 'colorize'

class PrintLogs
  def initialize(dir, name, file, list_error)
    @dir = dir
    @logs_path = File.join(@dir, '.clover', 'logs')
    @name = name
    @file = file
    @list_error = list_error
  end

  def record(row, msg)
    @list_error.push(format('-`%s` > line `%s`> %s', @name, row, msg))
  end
end
