require_relative "../execute/lint.rb"
require_relative "../execute/help.rb"

module CustomCommand

    @global_list_command = {
      "lint": LintCommand.new,
      "help": HelpCommand.new
    }

    def self.global_list_command
      return @global_list_command
    end
end

