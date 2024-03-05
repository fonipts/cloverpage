require_relative "../library/interface/command_initiate.rb"
require_relative "../config/app.rb"
require_relative "../config/message.rb"
require_relative "../library/core/schema/verify_content.rb"
require_relative "../library/core/execute_content.rb"
require_relative "../library/core/filesystem/scan_logs.rb"
require_relative "../library/exception/exception_config_file.rb"

require 'fileutils'
require 'colorize'
require 'yaml'

class LintCommand < CommandInitiateInterface

    def initialize
        @command_list = []
    end
    def execute
        app_dir = Dir.pwd
        config_filename = File.join(app_dir,AppDefaultVaribles.default_filename_with_extname)

        if File.file?(config_filename)
            file = File.open(config_filename)
            data = YAML.load(file.read)
            lintExecute(data)

        else

            puts ErrorVaribles.config_file_notfund.red

        end

    end

    def getDescription
        return "To execute linter in your workspace"
    end

    def setCommandVariable(cmd)
        @command_list = cmd
      end

    private
    def lintExecute(data)
        verify = VerifyContent.new(data)
        verify.InitConfig()

        if verify.isError()
            raise ExceptionConfigFile.new(verify.errorMessage())
        end
        logs = ScanLogs.new
        executeProject(verify.getListProject(),isWriteFiles(), logs)
        getLogs = logs.getLogs

        if getLogs.count() == 0
            puts "No error found".green
        else
            puts getLogs.join("\n")

        end

    end
    def isWriteFiles
        if @command_list.index '--write'

            return true;
        else
            puts "if like to modify your code add `--write` in your terminal command".yellow
            return false
        end

    end
end
