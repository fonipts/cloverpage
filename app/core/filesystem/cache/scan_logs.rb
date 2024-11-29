require 'colorize'

class ScanLogs
  def initialize(dir)
    @dir = dir
    @logs_path = File.join(@dir, '.clover', 'logs')
  end

  def read(name, row, msg)
    puts format('`%s` > `%s` >%s', name, row, msg)
  end
end
