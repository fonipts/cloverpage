require_relative './library/bootloader'

require 'fileutils'

loader = Bootloader.new(ARGV)
loader.loader
