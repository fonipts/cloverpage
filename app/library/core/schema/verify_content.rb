require_relative '../../../config/app'
require_relative '../../../config/supported_language'

class VerifyContent
  def initialize(init)
    @init_config = init
    @is_error = false
    @error_message = ''
    @list_project = []
  end

  def InitConfig
    checkProject
  end

  def isError
    @is_error
  end

  def errorMessage
    @error_message
  end

  def get_list_project
    @list_project
  end

  private

  def checkProject
    if @init_config

      if !@init_config.has_key?('scans')
        @is_error = true
        @error_message = 'Please provide the `scan` project details'

      else
        for x in @init_config['scans']

          if !x.has_key?('project')
            @is_error = true
            @error_message = 'List of `project` is missing'
            break
          else
            unless x['project'].has_key?('name')
              @is_error = true
              @error_message = 'In list of project the `name` is missing'
              break

            end
            unless x['project'].has_key?('description')
              @is_error = true
              @error_message = 'In list of project the `description` is missing'
              break

            end
            reg_a = /^([a-z\-_]{1,})$/
            unless x['project']['name'].match(reg_a)
              @is_error = true
              @error_message = 'Invalid `name` format, follow standard `[a-z\-\_]`'
              break

            end
            unless x['project'].has_key?('language')
              @is_error = true
              @error_message = 'In list of project the `language` is missing'
              break
            end
            unless x['project'].has_key?('include')
              @is_error = true
              @error_message = 'In list of project the `include` is missing'
              break
            end
            unless x['project']['include'].instance_of? Array
              @is_error = true
              @error_message = '`include` must be in array format'
              break
            end
            unless x['project']['language'].instance_of? Array
              @is_error = true
              @error_message = '`language` must be in array format'
              break
            end

            for lang in x['project']['language']
              next if LangugeExt.langExtList.key?(lang.to_sym)

              @is_error = true
              @error_message = '`' + lang + '` is acceptable language'
              break
            end

            if x['project'].has_key?('exclude') && !(x['project']['exclude'].instance_of? Array)
              @is_error = true
              @error_message = '`exclude` must be in array format'
              break
            end
          end

          @list_project.append(x) unless @is_error
        end
      end

    else
      @is_error = true
      @error_message = 'Your `' + AppDefaultVaribles.default_filename_with_extname + '` is empty, please check'
    end
  end
end
