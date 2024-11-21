require_relative '../command/action/format'
require_relative '../command/action/help'
require_relative '../command/action/lint'

module CustomCommand
  @global_list_command = {
    'format': FormatCommand.new,
    'lint': LintCommand.new,
    'help': HelpCommand.new
  }

  def self.global_list_command
    @global_list_command
  end
end
