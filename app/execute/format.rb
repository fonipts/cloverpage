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
    formatExecute(@control_data)

  end

  def get_description
    'To format your workspace'
  end

  def set_variable(cmd, data)
    @command_list = cmd
    @control_data = data
  end

  private

  def formatExecute(_data)
    logs = ScanLogs.new

    getLogs = logs.getLogs

    review = ReviewProject.new(@control_data, logs, LangugeExt.global_class_formatscan, 'format_config')

    review.deploy
    if getLogs.count == 0
      puts 'No error found'.green
    else
      puts getLogs.join("\n")

    end
  end

  def isWriteFiles
    return true if @command_list.index '--write'

    puts 'if like to modify your code add `--write` in your terminal command'.yellow
    false
  end
end
