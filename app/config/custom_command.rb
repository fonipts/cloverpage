require_relative '../execute/format'
require_relative '../execute/lint'
require_relative '../execute/help'

module CustomCommand
  @global_list_command = {
    "format": FormatCommand.new,
    "lint": LintCommand.new,
    "help": HelpCommand.new
  }

  def self.global_list_command
    @global_list_command
  end
end
