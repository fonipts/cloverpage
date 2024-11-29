require_relative '../../support/interface/command_initiate'
require_relative '../../config/custom_command'
require_relative '../../support/exception/exception_config_file'
require_relative '../../core/process/scan_project'
require_relative '../../support/schema/verify_scan_variable'
require_relative '../../core/filesystem/cache/scan_logs'

require 'colorize'

require 'fileutils'

class LintCommand < CommandInitiateInterface
  def initialize
    @proj_dir = ''
    @command_list = []
    @control_data = {}

    @raw_data = {}
  end

  def execute
    validate
    p @raw_data['lint']
    logs = ScanLogs.new(@proj_dir)

    scan_project = ScanProject.new(@proj_dir, @raw_data['language'], @raw_data['directory']['include'], @raw_data['directory']['exclude'],
                                   logs, [])
    scan_project.scan_file
  end

  def description
    'To linter in your codespace'
  end

  def variable(proj_dir, cmd, data)
    @proj_dir = proj_dir
    @command_list = cmd
    @control_data = data
  end

  private

  def validate
    raise ExceptionConfigFile, 'Please specify command `name`' if @command_list.count.zero?

    verify_class = VerifyScanVariable.new(@command_list[0], @control_data['scans'])

    raise ExceptionConfigFile, format('Your project name `%s` does not exist in cloverrc.yaml', @command_list[0]) if verify_class.invalid_verify

    @raw_data = verify_class.project_variable

    return if @raw_data.key?('lint')

    raise ExceptionConfigFile, format('Please check if there is `lint` config in your cloverrc.yaml')
  end
end
