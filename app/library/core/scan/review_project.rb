require_relative '../../../config/supported_language'
require_relative '../filesystem/scan_file'
require_relative '../filesystem/file_read'

class ReviewProject
  def initialize(data, log_class, global_class, config_name)
    @data = data
    @log_class = log_class
    @global_class = global_class
    @config_name = config_name
    @list_project = @data['scans']
  end

  def deploy
    clone_data = @list_project.first.clone
    @list_project.shift
    load_project_scan(clone_data, @config_name)
  end

  private

  def load_project_scan(data, config_name)
    local_name = data['project']['name']
    local_description = data['project']['description']
    local_language = data['project']['language']
    local_include = data['project']['include']
    puts(local_name)

    if data['project'].key?(config_name)
      for name in data['project'][config_name]

        next unless @global_class.key?(name.keys.first.to_sym  )
        @global_class[name.keys.first.to_sym].default_value(name.values)
      end

    end

    scan_files(local_include, config_name, local_language)
  end

  def scan_files(dirs, config_name, local_language)
    if dirs.count > 0
      dir = dirs.first.clone
      dirs.shift
      scan_file = ScanFile.new
      scan_file.set_valid_ext(local_language)
      files = scan_file.get_files(dir)

      read_file(files, dirs, config_name, local_language)

    elsif @list_project.count > 0
      clone_data = @list_project.first.clone
      @list_project.shift
      load_project_scan(clone_data, config_name)

    end
  end

  def read_file(files, dirs, config_name, local_language)
    if files.count > 0
      file = files.first.clone
      file_read = FileRead.new(file)
      files.shift

      file_read.initReadFile
      countr = 1
      for key, value in @global_class

        @global_class[key].set_data(file, file_read, @log_class)
        @global_class[key].read

        read_file(files, dirs, config_name, local_language) if @global_class.count == countr
        countr += 1
      end

    else
      scan_files(dirs, config_name, local_language)
    end
  end
end
