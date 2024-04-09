module AppDefaultVaribles
  @default_version = '0.0.1'
  @default_filename = 'cloverrc'
  @default_extname = 'yaml'
  @default_filename_with_extname = '%s.%s'

  def self.default_filename
    @default_filename
  end

  def self.default_extname
    @default_extname
  end

  def self.default_filename_with_extname
    format(@default_filename_with_extname, @default_filename, @default_extname)
  end

  def self.default_version
    @default_version
  end
end
