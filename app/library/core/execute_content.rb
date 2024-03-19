require_relative '../../config/app'
require_relative '../../config/supported_language'
require_relative './filesystem/file_read'
require_relative './filesystem/glob'

def executeProject(list, is_modify, logs)
  return unless list.count > 0

  clone_data = list.first.clone

  data_project_name = clone_data['project']['name']
  data_project_type = clone_data['project']['type']
  data_project_action = clone_data['project']['action']
  list.shift

  if data_project_type == AppDefaultVaribles.type_codescan
    puts format('codescan [%s]', clone_data['project']['name'])
    utilCodescan(list, is_modify, clone_data, logs)
  end

  if data_project_type == AppDefaultVaribles.type_httprequest
    puts format('httprequest [%s]', clone_data['project']['name'])
    utilApirequest(list, is_modify, clone_data, logs)
  end

  return unless data_project_type == AppDefaultVaribles.type_formatscan

  puts format('format [%s]', clone_data['project']['name'])
  utilFormatscan(list, is_modify, clone_data, logs)
end

def utilCodescan(list, is_modify, clone_data, logs)
  project_lang = clone_data['project']['lang']
  project_action = clone_data['project']['action']

  if !LangugeExt.langExtList.key?(project_lang.to_sym)
    puts 'Your file extension does not supported as of this moment'
    clone_data['project']['files'] = []
  else
    app_dir = Dir.pwd
    project_file = clone_data['project']['files'].first.clone

    glob = Glob.new(project_file, LangugeExt.langExtList[project_lang.to_sym])

    for x in glob.readFiles

      file_read = FileRead.new(app_dir, x)
      next unless file_read.exists

      file_read.initReadFile

      for configValue in project_action
        next unless LangugeExt.global_class_codescan.key?(configValue.keys.first.to_sym)

        classArg = LangugeExt.global_class_codescan[configValue.keys.first.to_sym]
        classArg.setData(x, file_read, configValue.values, logs)
        classArg.read

      end

      file_read.initWriteFile if is_modify

    end

    clone_data['project']['files'].shift
  end

  if clone_data['project']['files'].count > 0
    utilCodescan(list, is_modify, clone_data, logs)
  else
    executeProject(list, is_modify, logs)
  end
end

def utilApirequest(list, is_modify, _clone_data, logs)
  puts 'This feature still ongoing'
  executeProject(list, is_modify, logs)
end

def utilFormatscan(list, is_modify, clone_data, logs)
  project_lang = clone_data['project']['lang']
  project_action = clone_data['project']['action']

  if !LangugeExt.langExtList.key?(project_lang.to_sym)
    puts 'Your file extension does not supported as of this moment'
    clone_data['project']['files'] = []
  else
    app_dir = Dir.pwd
    project_file = clone_data['project']['files'].first.clone

    glob = Glob.new(project_file, LangugeExt.langExtList[project_lang.to_sym])

    for x in glob.readFiles

      file_read = FileRead.new(app_dir, x)
      next unless file_read.exists

      file_read.initReadFile

      for configValue in project_action
        next unless LangugeExt.global_class_formatscan.key?(configValue.keys.first.to_sym)

        classArg = LangugeExt.global_class_formatscan[configValue.keys.first.to_sym]
        classArg.setData(x, file_read, configValue.values, logs)
        classArg.read

      end

      file_read.initWriteFile if is_modify

    end

    clone_data['project']['files'].shift
  end

  if clone_data['project']['files'].count > 0
    utilFormatscan(list, is_modify, clone_data, logs)
  else
    executeProject(list, is_modify, logs)
  end
end
