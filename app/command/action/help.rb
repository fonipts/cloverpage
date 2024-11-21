require_relative '../../support/interface/command_initiate'
require_relative '../../config/custom_command'
require_relative '../../support/exception/exception_config_file'
require 'colorize'

class HelpCommand < CommandInitiateInterface
  def initialize
    @proj_dir = ''
    @command_list = []
    @control_data = {}
  end

  def execute
    puts 'Available command in cloverpage'.green
    puts 'Usage: cloverpage'
    for key, value in CustomCommand.global_list_command
      puts format('  %s ... %s', key, value.description)
    end
  end

  def description
    'See all available command in cloverpage'
  end

  def variable(proj_dir, cmd, data)
    @proj_dir = proj_dir
    @command_list = cmd
    @control_data = data
  end
end
