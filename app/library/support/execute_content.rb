require_relative "../../config/app.rb"
require_relative "../../config/supported_language.rb"

def executeProject(list, logs)
    if list.count() >0

        clone_data = list.first().clone

        data_project_name = clone_data['project']['name']
        data_project_type = clone_data['project']['type']
        data_project_action = clone_data['project']['action']
        list.shift()

        if data_project_type == AppDefaultVaribles.type_codescan
            puts "codescan [%s]" % [ clone_data['project']['name']] 
            utilCodescan(list, clone_data, logs)
        end
        
        if data_project_type == AppDefaultVaribles.type_apirequest
            puts "apirequest [%s]" % [ clone_data['project']['name']] 
            utilApirequest(list, clone_data, logs)
        end

        if data_project_type == AppDefaultVaribles.type_webperformance
            puts "webperformance [%s]" % [ clone_data['project']['name']] 
            utilWebperformance(list, clone_data, logs)
        end

    end
end


def utilCodescan(list, clone_data, logs)
    project_lang = clone_data['project']['lang']
    project_action = clone_data['project']['action']
    
    if !LangugeExt.langExtList.key?(project_lang.to_sym)
        puts "Your file extension does not supported as of this moment"
        clone_data['project']['files'] = []
    else
        app_dir = Dir.pwd
        project_file = clone_data['project']['files'].first().clone
        path_join = "%s.%s"% [project_file, LangugeExt.langExtList[project_lang.to_sym]]
        dir_list = Dir.glob(path_join)
        
        for x in dir_list
            path_join_file = File.join(app_dir,x) 
            if (File.exists?(path_join_file))
                
                f = File.open(path_join_file, "r")
                list_content = []
                f.each_line do |line|
                    list_content.append(line)
                end
                f.close
                for configValue in project_action
                    if LangugeExt.global_class_codescan.key?(configValue.keys.first.to_sym)
                        classArg = LangugeExt.global_class_codescan[configValue.keys.first.to_sym]
                        classArg.setData(x,list_content, configValue.values.first, logs, {})
                        classArg.read
                        if clone_data['project'].has_key?("is_modify_file")
                            if clone_data['project']["is_modify_file"]
                                classArg.write
                            end
                        end
                    end
                end
            end
        end    
        
        clone_data['project']['files'].shift()
    end    
    
    if clone_data['project']['files'].count() > 0 
        utilCodescan(list, clone_data,logs)
    else
        executeProject(list,logs)        
    end    

end

def utilApirequest(list, clone_data, logs)
    
    puts "This feature still ongoing"
    executeProject(list, logs)
end

def utilWebperformance(list, clone_data, logs)
    puts "This feature still ongoing"
    executeProject(list,logs)
end

