require_relative "../../../config/app.rb"

class CommandContent

    def initialize(init)
        @init_config = init
        @is_error = false
        @error_message = ''
        @list_project = []
    end

    def InitConfig()
        checkProject()
    end
    def isError()
        return @is_error
    end
    def errorMessage()
        return @error_message
    end
    def getListProject()
        return @list_project
    end
    private
    def checkProject

        counter = @init_config.count()
        if counter==0
            @is_error = true
            @error_message = 'No arguments found, please run `help` for more information'
        else
            if @init_config[0] == "help"
                list = listCommandHelp

                for x in list
                    puts '`'+x[:command]+'`: '+ x[:message]
                end

                @is_error = true
                @error_message = 'Above are available command'
            elsif @init_config[0] == "execute"
                puts "Scanning your code"
            else
                @is_error = true
                @error_message = 'Invalid command, please run `help` for more information '
            end

        end

    end

    def listCommandHelp

        data = [
            "command": "execute",
            "message": "To scan your  project base in  `cloverrc.yaml`"
        ]
        return data

    end
end
