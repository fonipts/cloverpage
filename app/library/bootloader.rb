require 'yaml'
require_relative "../config/message.rb"
require_relative "./core/schema/verify_content.rb"
require_relative "./core/execute_content.rb"
require_relative "./core/filesystem/scan_logs.rb"
require_relative "./exception/exception_config_file.rb"

class Bootloader

    def initialize(file, arg_list)
        @default_file = file
        @default_arg_list = arg_list
        @is_error = false
    end
    def getContentOfYaml()

        file = File.open(@default_file)
        return YAML.load(file.read)

    end
    def loader()
        if !@is_error
            loadScriptTORun()
        end
    end
    def loadScriptTORun()

            puts "my start"
            begin

                data = getContentOfYaml()
                verify = VerifyContent.new(data)
                verify.InitConfig()

                if verify.isError()
                    raise ExceptionConfigFile.new(verify.errorMessage())
                end

                logs = ScanLogs.new
                executeProject(verify.getListProject(), logs)
                getLogs = logs.getLogs
                if getLogs.count() == 0
                    puts "No error found"
                else
                    puts getLogs.join("\n")

                end
            rescue Psych::SyntaxError
                puts ErrorVaribles.invalid_yaml_format
            rescue ExceptionConfigFile =>e
                puts e.message
            end

    end
end
