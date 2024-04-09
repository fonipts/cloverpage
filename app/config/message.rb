require_relative './app'

module ErrorVaribles
  @config_file_notfund = 'I can not find the default config, please check the `' + AppDefaultVaribles.default_filename_with_extname + '`'
  @invalid_yaml_format = 'Invalid yaml format, please check the file'

  def self.config_file_notfund
    @config_file_notfund
  end

  def self.invalid_yaml_format
    @invalid_yaml_format
  end
end

module ErrorCode
  @config_file_notfund = 404

  def self.config_file_notfund
    @config_file_notfund
  end
end
