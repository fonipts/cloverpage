
module AppDefaultVaribles
  @default_filename="cloverrc"
  @default_extname="yaml"
  @default_filename_with_extname="%s.%s"


  @type_codescan = "codescan"
  @type_apirequest = "apirequest"
  @type_webperformance = "webperformance"
  @valid_script_action = [@type_codescan, @type_apirequest, @type_webperformance]


  def self.default_filename
    return @default_filename
  end
  def self.default_extname
    return @default_extname
  end
  def self.default_filename_with_extname
    return @default_filename_with_extname% [@default_filename, @default_extname]
  end

  def self.type_codescan
    return @type_codescan
  end
  def self.type_apirequest
    return @type_apirequest
  end
  def self.type_webperformance
    return @type_webperformance
  end
  def self.valid_script_action
    return @valid_script_action
  end
end

