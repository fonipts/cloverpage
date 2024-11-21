require_relative '../../config/app'
require_relative '../../config/supported_language'

class TokenCharStruct
  def initialize(name, regex, value)
    @name = name
    @regex = regex
    @value = value
  end

  attr_reader :name, :regex, :value
end
