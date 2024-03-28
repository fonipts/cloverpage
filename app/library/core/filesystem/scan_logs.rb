require 'colorize'

class ScanLogs
  def initialize
    @logs = {}
    @project_name = ''
    @file_name = ''
    @error_count = 0
  end

  def project_name(data)
    @project_name = data
    return if @logs.key?(data)

    @logs[@project_name] = {}
  end

  def file_name(data)
    @file_name = data
  end

  def append(data)
    @logs[@project_name][@file_name] = [] unless @logs[@project_name].key?(@file_name)
    @logs[@project_name][@file_name].append(data)
    @error_count += 1
  end

  def error_show_log
    for name, values in @logs

      puts 'project: ' + name.green
      if values.empty?
        puts 'No error or warning has found'.yellow
      else
        for name_s, val_s in values
          puts name_s.blue
          for val in val_s
            puts '    ' + val.red
          end
        end
      end
    end
  end

  attr_reader :logs, :error_count
end
