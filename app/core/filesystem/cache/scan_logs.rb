require 'colorize'
require_relative './print_logs'
require 'colorize'
class ScanLogs
  def initialize(dir)
    @dir = dir
    @logs_path = File.join(@dir, '.clover', 'logs')
    @list_error = []
    @file = nil
    @count_error = 0
  end

  def init_record(name, file)
    @file = file

    PrintLogs.new(@logs_path, name, file, @list_error)
  end

  def print
    puts "\n" + format('file: `%s` ', @file.to_s.sub(@dir, '.')).blue if @list_error.count.positive?
    puts "#{@list_error.join("\n")}".red if @list_error.count.positive?
    @count_error += @list_error.clone.count
    @list_error = []
  end
  attr_reader :count_error, :list_error
end
