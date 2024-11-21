require_relative '../config/app'
require_relative '../config/custom_command'
require_relative '../config/message'
require_relative '../support/exception/exception_config_file'
require_relative '../core/filesystem/generate_config_folder'

require_relative '../support/schema/verify_content'

require 'fileutils'
require 'colorize'
require 'yaml'

class Bootloader
  def initialize(arg_list)
    @default_arg_list = arg_list
    @proj_dir = Dir.pwd
    @command_key = ''
    @command_list = []
    @get_config_api = {}
  end

  def loader
    load_script_to_run
  end

  private

  def verify_command
    raise ExceptionConfigFile, 'Empty command, please specify your command or run `help`' if @default_arg_list.count.zero?

    config_filename = File.join(@proj_dir, AppDefaultVaribles.default_filename_with_extname)
    raise ExceptionConfigFile, ErrorVaribles.config_file_notfund unless File.file?(config_filename)

    file = File.open(config_filename)
    @get_config_api = YAML.safe_load(file.read)

    verify = VerifyContent.new(@get_config_api)
    verify.init_config

    raise ExceptionConfigFile, verify.error_message if verify.is_error

    @command_key = @default_arg_list[0].to_sym
    @command_list = @default_arg_list.clone[1..]
    return if CustomCommand.global_list_command.key?(@command_key)

    raise ExceptionConfigFile, "No command found at `#{@command_key}` or run `help` to see available command"
  end

  def load_script_to_run
    puts 'Welcome in cloverpage'

    begin
      verify_command
      gen_config = GenerateConfigFolder.new(@proj_dir)
      gen_config.deploy
      class_arg = CustomCommand.global_list_command[@command_key]
      class_arg.variable(@proj_dir, @command_list, @get_config_api)
      class_arg.execute
    rescue Psych::SyntaxError
      ErrorVaribles.invalid_yaml_format.red
    rescue ExceptionConfigFile => e
      puts e.message.red
    end
  end
end
