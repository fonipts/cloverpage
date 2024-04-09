require 'colorize'

class ScanLogs
  def initialize
    @project_name = ''
    @file_name = ''
    @error_count = 0
    @error_per_file = []
  end

  def append(data)
    @error_per_file.append(data)
    @error_count += 1
  end

  def error_show_per_file(name)
    unless @error_per_file.empty?
      puts name.yellow
      for val in @error_per_file
        puts "    #{val.red}"
      end
    end

    @error_per_file = []
  end

  def error_show_log
    return unless @error_count.zero?

    puts 'No error or warning has found'.yellow
  end

  attr_reader :error_per_file, :error_count
end
