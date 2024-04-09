require_relative '../../../config/supported_language'
require 'fileutils'

class ScanFile
  def initialize
    @proj_dir = Dir.pwd
    @root_dirs = []
    @files = []
    @exclude = []
    @valid_ext = []
  end

  def set_exclude(paths)
    @exclude = paths
  end

  def set_valid_ext(exts)
    for ext in exts
      ext_format = format('.%s', LangugeExt.langExtList[ext.to_sym].to_s)
      @valid_ext.append(ext_format)
    end
  end

  def get_valid_ext_respected_class(exts)
    obj = {}
    for ext in exts
      ext_format = format('.%s', LangugeExt.langExtList[ext.to_sym].to_s)
      obj[ext_format] = ext.to_sym.to_s
    end
    obj
  end

  def get_files(path, is_root)
    path_join = if is_root
                  get_dir_path(path)
                else
                  format('%s/*', path)
                end

    dir_lists = Dir.glob(path_join)

    for dir_list in dir_lists
      if File.directory?(dir_list)
        @root_dirs.append(dir_list) if is_root
        get_files(dir_list, false)
      elsif @valid_ext.include? File.extname(dir_list)
        @files.append(dir_list)
      end
    end

    @files
  end

  private

  def get_dir_path(path)
    reg_os_dir = %r{^/}
    if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil # :comment for window os
      reg_os_dir = /^[a-zA-Z]:/
    end
    match1 = path.match(reg_os_dir)
    if match1
      if File.directory?(path)
        @proj_dir
      else
        format('%s/%s/*', @proj_dir, path)
      end
    else
      format('%s/%s/*', @proj_dir, path)
    end
  end

  attr_reader :root_dirs
end
