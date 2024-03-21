require_relative '../../../config/supported_language'
require 'fileutils'

class ScanFile
  def initialize
    @proj_dir = Dir.pwd
    @files = []
    @exclude = []
    @valid_ext = []
    @is_root_dir = true
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

  def get_files(path)
    dir_count = 0
    path_join = if @is_root_dir
                  format('%s/%s/*', @proj_dir, path)
                else
                  format('%s/*', path)
                end
    @is_root_dir = false
    dir_lists = Dir.glob(path_join)

    for dir_list in dir_lists
      if File.directory?(dir_list)
        get_files(dir_list)
      elsif @valid_ext.include? File.extname(dir_list)
        @files.append(dir_list)
      end
    end

    @files
  end
end
