require_relative "../../config/app.rb"
require_relative "../../config/supported_language.rb"
require_relative "./filesystem/file_read.rb"
require_relative "./filesystem/glob.rb"

def executeProject(list,is_modify, logs)
    if list.count() >0

        clone_data = list.first().clone

        data_project_name = clone_data['project']['name']
        data_project_type = clone_data['project']['type']
        data_project_action = clone_data['project']['action']
        list.shift()

        if data_project_type == AppDefaultVaribles.type_codescan
            puts "codescan [%s]" % [ clone_data['project']['name']]
            utilCodescan(list,is_modify,  clone_data, logs)
        end

        if data_project_type == AppDefaultVaribles.type_httprequest
            puts "httprequest [%s]" % [ clone_data['project']['name']]
            utilApirequest(list,is_modify, clone_data, logs)
        end

        if data_project_type == AppDefaultVaribles.type_webperformance
            puts "webperformance [%s]" % [ clone_data['project']['name']]
            utilWebperformance(list,is_modify, clone_data, logs)
        end

    end
end

def utilCodescan(list,is_modify, clone_data, logs)
    project_lang = clone_data['project']['lang']
    project_action = clone_data['project']['action']

    if !LangugeExt.langExtList.key?(project_lang.to_sym)
        puts "Your file extension does not supported as of this moment"
        clone_data['project']['files'] = []
    else
        app_dir = Dir.pwd
        project_file = clone_data['project']['files'].first().clone

        glob = Glob.new(project_file, LangugeExt.langExtList[project_lang.to_sym])

        for x in glob.readFiles

            file_read = FileRead.new(app_dir,x)
            if ( file_read.exists )
                file_read.initReadFile

                for configValue in project_action
                    if LangugeExt.global_class_codescan.key?(configValue.keys.first.to_sym)
                        classArg = LangugeExt.global_class_codescan[configValue.keys.first.to_sym]
                        classArg.setData(x,file_read, configValue.values, logs )
                        classArg.read

                    end
                end

                if is_modify

                        file_read.initWriteFile

                end

            end
        end

        clone_data['project']['files'].shift()
    end

    if clone_data['project']['files'].count() > 0
        utilCodescan(list,is_modify, clone_data,logs)
    else
        executeProject(list,is_modify,logs)
    end

end

def utilApirequest(list,is_modify, clone_data, logs)

    puts "This feature still ongoing"
    executeProject(list,is_modify, logs)
end

def utilWebperformance(list,is_modify, clone_data, logs)
    puts "This feature still ongoing"
    executeProject(list,is_modify,logs)
end
