require_relative '../../../support/interface/code_scan'

class CheckQouteType < CodeScanInterface
  def initialize
    @var_action_name = nil
    @var_read_filecontent = nil
    @var_logs = nil
    @var_default_config = 'double'
    @var_read_filename = nil

    # @@ext_content = nil
    # @ext_config = true
    # @ext_log = []
  end

  def action_name(value)
    @var_action_name = value
  end

  def read_filecontent(content)
    @var_read_filecontent = content

    for line in @var_read_filecontent.read_strip_qoute
      row = line[:row]
      count = 0
      line[:reference_key].each do |_ob_key, ob_val|
        count += 1 if ob_val[:type] != @var_default_config.to_s + '_qte_open_close'
      end
      @var_logs.record(line[:row], 'Must use `' + @var_default_config.to_s + '` qoute in string') if count.positive?
    end
  end

  def logs(cls)
    @var_logs = cls
  end

  def default_config(data)
    @var_default_config = data
  end

  def read_filename(data)
    @var_read_filename = data
  end

  attr_reader :var_action_name
end
