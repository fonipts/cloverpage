require_relative "../library/interface/command_initiate.rb"
require_relative "../config/custom_command.rb"
require 'colorize'

class HelpCommand < CommandInitiateInterface

    def initialize

    end
    def execute
        puts "Available command in cloverpage".green
        for key,value in CustomCommand.global_list_command
            puts "  %s ... %s" % [key,value.getDescription]
        end
    end

    def getDescription
        return "See all available command in cloverpage"
    end

    def setCommandVariable(cmd)
        p cmd
      end

end
