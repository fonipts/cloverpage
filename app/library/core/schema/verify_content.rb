require_relative "../../../config/app.rb"

class VerifyContent

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

        if !@init_config.has_key?("name")
            @is_error = true
            @error_message = 'You are missing the project `name`'
        end

        if !@init_config.has_key?("scans")
            @is_error = true
            @error_message = 'Please provide the `scan` project details'

        else
            for x in @init_config["scans"]

                if !x.has_key?("project")
                    @is_error = true
                    @error_message = 'List of `project` is missing'
                    break
                else
                    if !x['project'].has_key?("name")
                        @is_error = true
                        @error_message = 'In list of project the `name` is missing'
                        break

                    end
                    if !x['project'].has_key?("type")
                        @is_error = true
                        @error_message = 'In list of project the `type` is missing'
                        break
                    else
                        if !AppDefaultVaribles.valid_script_action.index(x['project']['type'])
                            @is_error = true
                            @error_message = 'In list of project type `%s.` is missing'% [ x['project']['type'] ]
                            break
                        end
                    end
                    if !x['project'].has_key?("action")
                        @is_error = true
                        @error_message = 'In list of project the `action` is missing'
                        break
                    end
                end

                if !@is_error
                    @list_project.append(x)
                end
            end
        end

    end
end
