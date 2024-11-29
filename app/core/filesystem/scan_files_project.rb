require_relative './verify_glob_path'

require 'colorize'
require 'fileutils'

class ScanFilesProject
  def initialize(dir, ext, exlude_dir, callback)
    @dir = dir
    @exts = ext
    @exlude_dir = exlude_dir
    @callback = callback
  end

  def scan
    verify_glob = VerifyGlobPath.new(@dir)
    recursive_files(verify_glob.glob_path, @dir, verify_glob.is_path_glob_format)
  end

  def recursive_files(folder_glob, folder, is_glob)
    return if @exlude_dir.index folder

    @callback.call(folder, File.extname(folder).gsub(/^\./, '')) if File.file?(folder)
    for val in Dir.glob("#{folder_glob}/**")
      if File.directory?(val) && !is_glob
        recursive_files(val, folder, false)
      else
        ext_clean = File.extname(val).gsub(/^\./, '')
        @callback.call(val, ext_clean) if @exts.include? ext_clean
      end
    end
  end
end
