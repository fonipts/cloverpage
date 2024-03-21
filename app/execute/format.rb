require_relative '../library/interface/command_initiate'
require_relative '../config/app'
require_relative '../config/message'
require_relative '../config/supported_language'
require_relative '../library/core/schema/verify_content'
require_relative '../library/core/filesystem/scan_logs'
require_relative '../library/exception/exception_config_file'

require 'fileutils'
require 'colorize'
require 'yaml'

class FormatCommand < CommandInitiateInterface
  def initialize
    @command_list = []
    @control_data = {}
  end

  def execute
    format_execute(@control_data)

  end

  def description
    'To format your workspace'
  end

  def variable(cmd, data)
    @command_list = cmd
    @control_data = data
  end

  private

  def format_execute(_data)
    scan_logs = ScanLogs.new

    get_logs = scan_logs.logs

    review = ReviewProject.new(@control_data, scan_logs, LangugeExt.global_class_formatscan, 'format_config')

    review.deploy
    if get_logs.count == 0
      puts 'No error found'.green
    else
      puts get_logs.join("\n")

    end
  end

  def is_write_files
    return true if @command_list.index '--write'

    puts 'if like to modify your code add `--write` in your terminal command'.yellow
    false
  end
end
