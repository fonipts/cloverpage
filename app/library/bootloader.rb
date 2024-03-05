require 'yaml'
require 'colorize'

require_relative "../config/custom_command.rb"
require_relative "../config/message.rb"

require_relative "./exception/exception_config_file.rb"

class Bootloader

    def initialize(arg_list)
        @default_arg_list = arg_list
        @is_error = false
        @command_key = ""
        @command_list = []
    end
    def verifyCommand()

        if @default_arg_list.count() == 0
            raise ExceptionConfigFile.new("Empty command, please specify your command or run `help`")
        end
        @command_key = @default_arg_list[0].to_sym
        raw_command_list = @default_arg_list.clone

        @command_list = raw_command_list[1..-1]

        if !CustomCommand.global_list_command.key?(@command_key)
            raise ExceptionConfigFile.new("No command found at `"+@command_key.to_s+"` or run `help` to see available command")
        end

    end
    def loader()
        if !@is_error
            loadScriptToRun()
        end
    end
    def loadScriptToRun()

            puts "Welcome in cloverpage"

            begin
                verifyCommand()

                classArg = CustomCommand.global_list_command[@command_key]
                classArg.setCommandVariable(@command_list)
                classArg.execute()

            rescue Psych::SyntaxError
                puts ErrorVaribles.invalid_yaml_format
            rescue ExceptionConfigFile =>e
                puts e.message.red
            end

    end
end

