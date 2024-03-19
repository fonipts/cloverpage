require_relative '../library/interface/command_initiate'
require_relative '../config/custom_command'
require 'colorize'

class HelpCommand < CommandInitiateInterface
  def initialize; end

  def execute
    puts 'Available command in cloverpage'.green
    for key, value in CustomCommand.global_list_command
      puts format('  %s ... %s', key, value.getDescription)
    end
  end

  def getDescription
    'See all available command in cloverpage'
  end

  def setCommandVariable(cmd)
    p cmd
  end
end
