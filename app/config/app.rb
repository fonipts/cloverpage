module AppDefaultVaribles
  @default_version = '0.0.1'
  @default_filename = 'cloverrc'
  @default_extname = 'yaml'
  @default_filename_with_extname = '%s.%s'

  @type_codescan = 'codescan'
  @type_httprequest = 'httprequest'
  @type_formatscan = 'formatscan'
  @valid_script_action = [@type_codescan, @type_apirequest, @type_formatscan]

  def self.default_filename
    @default_filename
  end

  def self.default_extname
    @default_extname
  end

  def self.default_filename_with_extname
    format(@default_filename_with_extname, @default_filename, @default_extname)
  end

  def self.type_codescan
    @type_codescan
  end

  def self.type_httprequest
    @type_httprequest
  end

  def self.type_formatscan
    @type_formatscan
  end

  def self.valid_script_action
    @valid_script_action
  end

  def self.default_version
    @default_version
  end
end
