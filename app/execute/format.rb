require_relative '../library/interface/command_initiate'
require_relative '../config/app'
require_relative '../config/message'
require_relative '../library/core/schema/verify_content'
require_relative '../library/core/execute_content'
require_relative '../library/core/filesystem/scan_logs'
require_relative '../library/exception/exception_config_file'

require 'fileutils'
require 'colorize'
require 'yaml'

class FormatCommand < CommandInitiateInterface
  def initialize
    @command_list = []
  end

  def execute
    app_dir = Dir.pwd
    config_filename = File.join(app_dir, AppDefaultVaribles.default_filename_with_extname)

    if File.file?(config_filename)
      file = File.open(config_filename)
      data = YAML.load(file.read)
      formatExecute(data)

    else

      puts ErrorVaribles.config_file_notfund.red

    end
  end

  def getDescription
    'To format your workspace'
  end

  def setCommandVariable(cmd)
    @command_list = cmd
  end

  private

  def formatExecute(data)
    verify = VerifyContent.new(data)
    verify.InitConfig()

    raise ExceptionConfigFile.new(verify.errorMessage) if verify.isError

    logs = ScanLogs.new
    executeProject(verify.getListProject, isWriteFiles, logs)
    getLogs = logs.getLogs

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
