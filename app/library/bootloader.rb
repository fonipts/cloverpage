require_relative "./initiate_control.rb"
require_relative "../config/message.rb"
require_relative "./support/verify_content.rb"
require_relative "./support/execute_content.rb"
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
            puts "my start"
            
            begin

                data = getContentOfYaml()
                verify = VerifyContent.new(data)
                verify.InitConfig()
                if verify.isError()
                    raise ExceptionConfigFile.new(verify.errorMessage())
                end
                logs = [];     
                executeProject(verify.getListProject(), logs)
                if logs.count() == 0 
                    puts "No error found"
                else
                    puts logs.join("\n")
                    system("command", exception: true) or exit
                end    
            rescue Psych::SyntaxError
                puts ErrorVaribles.invalid_yaml_format
            rescue ExceptionConfigFile =>e
                puts e.message
            end
        end    
    end
end

