require_relative "./library/bootloader.rb"

require 'fileutils'

#app_dir = Dir.pwd
#config_filename = File.join(app_dir,AppDefaultVaribles.default_filename_with_extname)

#if File.file?(config_filename)

loader = Bootloader.new(ARGV);
loader.loader()

#else

#    puts ErrorVaribles.config_file_notfund

#end

