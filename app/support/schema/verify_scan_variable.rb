require_relative '../../config/app'
require_relative '../../config/supported_language'

class VerifyScanVariable
  def initialize(name, control_data)
    @name = name
    @control_data = control_data

    @verify_value_code = 0
    @scan_variable = {}
    init_loader
  end

  def project_variable
    @scan_variable
  end

  def invalid_verify
    @verify_value_code == 2
  end

  private

  def init_loader
    for x in @control_data
      if x['project']['name'] == @name
        @scan_variable = x['project']
        @verify_value_code = 1
      end
    end

    return unless @verify_value_code.zero?

    @verify_value_code = 2
  end
end
