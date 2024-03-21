require_relative '../library/interface/command_initiate'
require_relative '../config/custom_command'
require 'colorize'

class HelpCommand < CommandInitiateInterface
  def initialize; end

  def execute
    puts 'Available command in cloverpage'.green
    for key, value in CustomCommand.global_list_command
      puts format('  %s ... %s', key, value.description)
    end
  end

  def description
    'See all available command in cloverpage'
  end

  def variable(cmd, _data)
    p cmd
  end
end
