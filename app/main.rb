require_relative "./library/bootloader.rb"

require 'fileutils'

loader = Bootloader.new(ARGV);
loader.loader()

