require_relative './command/bootloader'

require 'fileutils'

loader = Bootloader.new(ARGV)
loader.loader
