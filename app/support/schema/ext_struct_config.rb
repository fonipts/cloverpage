require_relative '../../config/app'
require_relative '../../config/supported_language'

class ExtStructConfig
  def initialize(config_raw, config_default)
    @config_raw = config_raw
    @config_default = config_default
  end

  def pass_command_var
    data = []
    var_disable = @config_raw['disable'] || []
    var_config = @config_raw['config'] || []
    @config_default.each_value do |value|
      value.each do |sub_key, sub_value|
        sub_value.action_name(sub_key)
        var_config.each do |sub2_key, _sub2_value|
          sub_value.default_config(sub2_key[sub_key.to_s]) if sub2_key.has_key?(sub_key.to_s)
        end
        data.append(sub_value) if var_disable.index(sub_key.to_s).nil?
      end
    end
    data
  end
end
