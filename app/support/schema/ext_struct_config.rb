require_relative '../../config/app'
require_relative '../../config/supported_language'

class ExtStructConfig
  def initialize(config_raw, config_default)
    @config_raw = config_raw
    @config_default = config_default
  end

  def pass_command_var
    data = []
    @config_default.each_value do |value|
      value.each do |sub_key, sub_value|
        sub_value.action_name(sub_key)
        data.append(sub_value)
      end
    end
    data
  end
end
