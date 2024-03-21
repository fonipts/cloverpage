require_relative '../config/app'
require_relative '../config/custom_command'
require_relative '../config/message'

require_relative '../library/core/schema/verify_content'
require_relative './exception/exception_config_file'

require 'fileutils'
require 'colorize'
require 'yaml'

class Bootloader
  def initialize(arg_list)
    @default_arg_list = arg_list
    @is_error = false
    @command_key = ''
    @command_list = []
    @get_config_api = {}
  end

  def verify_command
    if @default_arg_list.count == 0
      raise ExceptionConfigFile.new('Empty command, please specify your command or run `help`')
    end

    @command_key = @default_arg_list[0].to_sym
    raw_command_list = @default_arg_list.clone

    app_dir = Dir.pwd
    config_filename = File.join(app_dir, AppDefaultVaribles.default_filename_with_extname)
    raise ExceptionConfigFile.new(ErrorVaribles.config_file_notfund) unless File.file?(config_filename)

    file = File.open(config_filename)
    @get_config_api = YAML.load(file.read)

    verify = VerifyContent.new(@get_config_api)
    verify.InitConfig()

    raise ExceptionConfigFile.new(verify.errorMessage) if verify.isError

    @command_list = raw_command_list[1..-1]

    return if CustomCommand.global_list_command.key?(@command_key)

    raise ExceptionConfigFile.new('No command found at `' + @command_key.to_s + '` or run `help` to see available command')
  end

  def loader
    return if @is_error

    loadScriptToRun
  end

  def loadScriptToRun
    puts 'Welcome in cloverpage'

    begin
      verify_command

      classArg = CustomCommand.global_list_command[@command_key]
      classArg.set_variable(@command_list, @get_config_api)
      classArg.execute
    rescue Psych::SyntaxError
      puts ErrorVaribles.invalid_yaml_format.red
    rescue ExceptionConfigFile => e
      puts e.message.red
    end
  end
end
