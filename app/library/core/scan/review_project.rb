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
    @initial_class = {}

    @is_write = false
  end

  def deploy
    clone_data = @list_project.first.clone
    @list_project.shift
    load_project_scan(clone_data, @config_name)
  end

  def is_write(is_write)
    @is_write = is_write
  end

  def add_initial_class(data)
    @initial_class = data
  end

  private

  def load_project_scan(data, config_name)
    local_name = data['project']['name']
    local_description = data['project']['description']
    local_language = data['project']['language']
    local_include = data['project']['include']
    @log_class.project_name(local_name)

    if data['project'].key?(config_name)
      for name in data['project'][config_name]

        next unless @global_class.key?(name.keys.first.to_sym)

        @global_class[name.keys.first.to_sym].default_value(name.values)
      end

    end

    scan_files(local_include, config_name, local_language)
  end

  def scan_files(dirs, config_name, local_language)
    if dirs.count.positive?
      dir = dirs.first.clone
      dirs.shift
      scan_file = ScanFile.new
      scan_file.set_valid_ext(local_language)
      get_respected_class = scan_file.get_valid_ext_respected_class(local_language)
      files = scan_file.get_files(dir)

      read_file(files, dirs, config_name, local_language, get_respected_class)

    elsif @list_project.count.positive?
      clone_data = @list_project.first.clone
      @list_project.shift
      load_project_scan(clone_data, config_name)

    end
  end

  def read_file(files, dirs, config_name, local_language, get_respected_class)
    if files.count.positive?
      file = files.first.clone
      file_read = FileRead.new(file)
      files.shift

      file_read.init_read_file
      countr = 1
      global_class_clone = @global_class.clone

      if get_respected_class.key?(file_read.ext_name)
        get_classes_to_call = get_respected_class[file_read.ext_name]

        if @initial_class.key?(get_classes_to_call.to_sym)
          for key_s, values_s in @initial_class[get_classes_to_call.to_sym]
            global_class_clone[key_s] = values_s
          end
        end
      end
      @log_class.file_name(file)
      for key, _ in global_class_clone

        global_class_clone[key].set_data(file, file_read, @log_class)
        global_class_clone[key].read

        if global_class_clone.count == countr
          file_read.init_write_file if @is_write
          read_file(files, dirs, config_name, local_language, get_respected_class)
        end
        countr += 1
      end

    else
      scan_files(dirs, config_name, local_language)
    end
  end
end
