require_relative '../filesystem/scan_files_project'
require_relative '../filesystem/read_file'

require_relative '../../config/supported_language'
require 'fileutils'

class ScanProject
  def initialize(proj_dir, ext_file, dir_include, dir_exclude, logs, actions)
    @proj_dir = proj_dir
    @ext_file = ext_file
    @dir_include = dir_include
    @dir_exclude = dir_exclude
    @logs = logs
    @action_list = actions
  end

  def scan_file
    list_exclude = []
    list_ext = []
    for val in @dir_exclude
      list_exclude.push(File.join(@proj_dir, val))
    end

    for val in @ext_file
      list_ext.push(LangugeExt.lang_ext_list[val.to_sym])
    end

    for val in @dir_include
      scans = ScanFilesProject.new(File.join(@proj_dir, val), list_ext, list_exclude, method(:callback_read))
      scans.scan
    end
  end

  def callback_read(file, _ext)
    read_f = ReadFile.new(file)

    for val_act in @action_list
      val_act.read_filename(file)
      val_act.read_filecontent(read_f)
    end
  end
end
